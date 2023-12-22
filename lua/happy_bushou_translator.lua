-- 在基本 Translator 基础上，基于字形（部首）进行过滤。
--
-- 输入文本（input）形如“PINYIN/BUSHOU”，其中“PINYIN”为基础 Translator 使用的
-- 拼音编码，“/”为分隔符，“BUSHOU”为部首符号序列（定义于“happy.hushou”字典文件）。
-- 相应段（seg）应当带有“happy_bushou”tag。
--
-- 例如，为了输入“你好”，可键入“nihk/rn”。其中，“nihk”是“你好”对应的自然码拼音，
-- “rn”分别表示偏旁“亻”（ren）和“女”（nü）。 特殊的部首符号“-”表示任意。


---@param input string
---@param seg Segment
---@param env table
local function func(input, seg, env)
  -- Check tags. Break if tags do no match. --
  if not seg:has_tag('happy_bushou') then
    return
  end

  -- Split input text into parts. --
  local sep_pos = string.find(input, '/')
  if sep_pos == nil then
    return
  end
  local input_pinyin = string.sub(input, 1, sep_pos - 1)
  local input_bushou = string.sub(input, sep_pos + 1)
  if input_pinyin == nil or input_bushou == nil then
    return
  end

  -- Prepare translator and dictionary. --
  local hb = env.happy_bushou
  if not hb then
    if hb == false then
      return -- Not available.
    end
    env.happy_bushou = false ---@type table|boolean
    hb = {
      main_trans = Component.Translator(env.engine, '', 'script_translator@translator'),
      bushou_rdb = ReverseLookup('happy.bushou'),
    }
    env.happy_bushou = hb ---@type table
  end
  local main_trans = hb.main_trans ---@type Translator
  local bushou_rdb = hb.bushou_rdb ---@type ReverseLookup

  -- Fetch candidates, and filter out unmacthed ones. --
  for cand in main_trans:query(input_pinyin, seg):iter() do
    local cand_matches = true
    local char_idx = 0
    local char_idx_max = #input_bushou
    for char in string.gmatch(cand.text, "[\1-\127\194-\244][\128-\191]*") do
      char_idx = char_idx + 1
      local expected_bushou = string.byte(input_bushou, char_idx)
      if expected_bushou ~= 45 then -- '-' -> 45 : skip
        local char_bushou_seq = bushou_rdb:lookup(char)
        if string.byte(char_bushou_seq) ~= expected_bushou
          and #char_bushou_seq > 0
          and string.find(char_bushou_seq, string.char(expected_bushou)) == nil
        then
          cand_matches = false
          break
        end
      end
      if char_idx >= char_idx_max then -- pinyin is longer than bushou
        break
      end
    end
    if cand_matches then
      cand.type = 'happy_bushou'
      cand.quality = cand.quality + 1000
      if char_idx >= char_idx_max then
        cand._end = seg._end
        cand.comment = '｢' .. input_bushou .. '｣'
      else
        cand._end = seg.start + sep_pos + char_idx
        cand.comment = '｢' .. string.sub(input_bushou, 1, char_idx) .. '｣'
      end
      yield(cand)
    end
  end
end


return func
