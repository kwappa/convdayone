# Convdayone

convert some data files of diary to [Day One](http://dayoneapp.com/) app via [dayone-cli](http://dayoneapp.com/tools/cli-man/)

## Usage

### Import from [MomentDiary](http://www.utagoe.com/jp/)

- export CSV from your app
- `bin/import_momentdiary #{PATH/TO/CSV}`

### Import from text file

- `bin/import_textfiles #{PATH/TO/DATADIR/}`
- datafile must be named `YYYYMM.txt`
  - e.g. `201601.txt`
- it can parse 2 styles

1. original style

```
========
1/5:
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
```

separator between each article must be longer than 8 characters of `=`.

2. exported from MomentDiary

```
- 2016年1月5日 火曜日 23:59
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
