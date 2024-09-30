program define zipopen
    version 16.0

    // 检查参数
    syntax , [use] [erase] path(string) file(string)

    // 解压文件的路径和名称
    local fullzip "`path'`file'.zip"
    local fullfile "`file'"

    display in result "zipopen .dta.zip file; by yishu.cai@link.cuhk.edu.hk"
    display in result "$ use"
    display in result "$ erase"
    display in result "$ path = path of the .dta.zip file"
    display in result "$ file = name .dta file"

    // 获取文件名的长度和".dta"的位置
    local filelen = strlen("`file'")
    local dtapos = strpos("`file'", ".dta")

    // 如果使用 use 选项，则解压缩并打开文件
    if "`use'" != "" {
        // 检查 .zip 文件是否存在
        if !fileexists("`fullzip'") {
            display as error "Error: Zip file `fullzip' does not exist."
            exit 198
        }

        // 检查解压后的 .dta 文件是否已存在，如果不存在则解压缩
        if fileexists("`fullfile'") {
            display "Existing: `fullfile'"
        }
        else {
            unzipfile "`fullzip'", replace
        }

        // 使用解压后的文件
        use "`fullfile'", clear
    }

    // 如果使用 erase 选项，则删除解压后的文件
    if "`erase'" != "" {
        cap erase "`fullfile'"
        display "Erased: `fullfile'"
    }
end
