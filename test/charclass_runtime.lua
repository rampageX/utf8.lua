local utf8 = require("init")
utf8.config = {
  debug = nil, --utf8:require("util").debug
}
utf8:init()

local cl = utf8:require("charclass.runtime.init")

local equals = require('test.util').equals
local assert = require('test.util').assert
local assert_equals = require('test.util').assert_equals

assert_equals(true, cl.new()
  :with_codes(utf8.byte' ')
  :invert()
  :in_codes(utf8.byte' '))

assert_equals(false, cl.new()
  :with_codes(utf8.byte' ')
  :invert()
  :test(utf8.byte' '))

assert_equals(false, cl.new()
  :with_codes()
  :with_ranges()
  :with_classes('space')
  :without_classes()
  :with_subs()
  :invert()
  :test(utf8.byte(' ')))

assert_equals(true, cl.new()
  :with_codes()
  :with_ranges()
  :with_classes()
  :without_classes('space')
  :with_subs()
  :invert()
  :test(utf8.byte(' ')))

assert_equals(false, cl.new()
  :with_codes()
  :with_ranges()
  :with_classes()
  :without_classes()
  :with_subs(cl.new():with_classes('space'))
  :invert()
  :test(utf8.byte(' ')))

assert_equals(true, cl.new()
  :with_codes()
  :with_ranges()
  :with_classes()
  :without_classes()
  :with_subs(cl.new():with_classes('space'):invert())
  :invert()
  :test(utf8.byte(' ')))

assert_equals(true, cl.new()
  :with_codes()
  :with_ranges()
  :with_classes('punct', 'digit', 'space', 'cntrl')
  :without_classes()
  :with_subs()
  :invert()
  :test(utf8.byte'П')
)

assert_equals(true, cl.new()
  :with_codes()
  :with_ranges()
  :with_classes('punct', 'digit', 'space', 'cntrl')
  :without_classes()
  :with_subs()
  :invert()
  :test(utf8.byte'и')
)

print "OK"
