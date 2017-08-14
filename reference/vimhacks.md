# Save with sudo
`
:w !sudo tee %
`

# Edit remote files
`
vim scp://USER@IPADDR//path/to/file
`

# Write changes to patch file 
`
:w !diff -au "%" - > changes.patch
`

# Filter html through pandoc
`
:%!pandoc -f html -t markdown | pandoc -f markdown -t html
`

# Filter json through python
`
:%!python -m json.tool
`

# Filter xml through xmllint
`
:%!xmllint --format -
`

# Filter html through tidy
`
:%!tidy -icq -
`Find something better than tidy.

# Find doubled words
`
%s/\(\w\+\), \1/\1, \1, \1/g
`
