# Save with sudo
<!--
:w !sudo tee %
-->

# Write changes to patch file 

<!--
:w !diff -au "%" - > changes.patch
-->

# Filter html through pandoc

<!--
:%!pandoc -f html -t markdown | pandoc -f markdown -t html
-->

# Find doubled words

<!--
%s/\(\w\+\), \1/\1, \1, \1/g
-->
