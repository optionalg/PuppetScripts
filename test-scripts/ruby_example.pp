file {'/tmp/output.txt':
  content => inline_template("Math Example 6 * 7 = <%= 6*7 %>.\n"),
}
