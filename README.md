# new
Are you tired of using mkdir AND touch for all of your unix purposes?
Me too. That is why i chose to make a tool that does all that for you.
Need to make a nested directory with a file at the end? No problem, new has your back:
```
new dir1/dir2/dir3/file file dir5/dir6/
```
the outputting tree will be 
```
.
├── dir1
│   └── dir2
│       └── dir3
│           └── file
├── dir5
│   └── dir6
└── file
```

# installing
you can install the static binary from the releases page or build the project yourself

# building
install zig 0.14.1 and do
`zig build`
and the binary will be in ./zig-out/bin/
