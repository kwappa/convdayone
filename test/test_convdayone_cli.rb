require 'test/unit'
require 'convdayone'

class TestConvdayoneCLI < Test::Unit::TestCase
  sub_test_case '.cli_option' do
    sub_test_case 'when option is empty' do
      test 'returns blank' do
        assert_true(Convdayone::CLI.cli_option({}).empty?)
      end

      sub_test_case 'when option is given' do
        test 'returns correct cli option' do
          options = { starred: true, date: Time.parse('2015-01-06T12:34:56+09:00'), invalid_key: 'invalid', photo_path: 'my/photo/path' }
          assert_equal(Convdayone::CLI.cli_option(options), "--date='2015-01-06 03:34:56' --starred='true' --photo-path='my/photo/path'")
        end
      end
    end
  end
end
