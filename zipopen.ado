program define zipopen
    version 16.0

    // 检查参数
    syntax , path(string) file(string)

    // 解压文件
    local fullzip "`path'`file'.zip"
    local fullfile "`file'"

    display in result "zipopen .dta.zip file; by yishu.cai@link.cuhk.edu.hk"
    display in result "$ path = path of the .dta.zip file"
    display in result "$ file = name .dta file"

    // 获取文件名的长度和".dta"的位置
    local filelen = strlen("`file'")
    local dtapos = strpos("`file'", ".dta")

    // 如果文件名不以.dta结尾，则报错
    if (`dtapos' != (`filelen' - 3)) {
        display as error "Error: The file must be a .dta file."
        exit 198
    }

    // 解压缩并替换已有文件
    unzipfile "`fullzip'", replace

    // 使用解压后的文件
    use "`fullfile'", clear

    // 删除解压的文件
    erase "`fullfile'"
end
