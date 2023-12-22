---@meta
--- API reference: https://github.com/hchunhui/librime-lua/wiki/Scripting

---@class Candidate
Candidate = {
  type = '',
  start = 0,
  _start = 0,
  _end = 0,
  quality = 0,
  text = '',
  comment = '',
  preedit = '',
}

---@class Component
Component = {
  ---@param namespace string
  ---@param prescription string
  Processor = function(engine, namespace, prescription) end,
  ---@param namespace string
  ---@param prescription string
  Segmentor = function(engine, namespace, prescription) end,
  ---@param namespace string
  ---@param prescription string
  ---@return Translator
  Translator= function(engine, namespace, prescription) end,
  ---@param namespace string
  ---@param prescription string
  Filter    = function(engine, namespace, prescription) end,
}

---@class Memory
Memory = {
  ---@param input string
  ---@param predictive boolean
  ---@param limit number
  dict_lookup = function(self, input, predictive, limit) end,
  ---@param input string
  ---@param predictive boolean
  user_lookup = function(self, input, predictive) end,
  iter_dict = function(self) end,
  iter_user = function(self) end,
}

---@class ReverseLookup
ReverseLookup = {
  ---@param key string
  ---@return string
  lookup = function(self, key) end,
}

---@class Schema
Schema = {
  schema_id = '',
  schema_name = '',
  config = nil,
  page_size = 0,
  select_keys = nil,
}

---@class Segment
Segment = {
  status = '',
  start = 0,
  _start = 0,
  _end = 0,
  length = 0,
  tags = nil,
  menu = nil,
  selected_index = 0,
  prompt = '',
  has_tag = function(self, t) end,
}

---@class Translation
Translation = {
  iter = function(self) end
}

---@class Translator
Translator = {
  name_space = '',
  ---@param input string
  ---@param seg Segment
  ---@return Translation
  query = function(self, input, seg) end
}

---@param c Candidate
function yield(c) end
