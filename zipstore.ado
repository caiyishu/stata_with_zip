program define zipstore
    version 16.0
    
    // 检查参数
    syntax , path(string) file(string) [level(integer 9)] [replace]

    display in result "zipstore .dta to .dta.zip file; by yishu.cai@link.cuhk.edu.hk"
    display in result "$ path = path of the .dta.zip file"
    display in result "$ file = name .dta file"
    display in result "$ [level] = compression level 1-[9]"
    display in result "$ [replace]"
    
    // 检查 level 是否在有效范围内 (1-9)
    if (`level' < 1 | `level' > 9) {
        display as error "Error: Compression level must be between 1 and 9."
        exit 198
    }
    
    // 拼接文件路径和名称
    local fullfile "`path'`file'"
    local zipfile "`fullfile'.zip"
    
    // 保存数据
    save "`fullfile'", replace
    
    // 压缩文件并设置压缩级别
    if ("`replace'" != "") {
        zipfile "`fullfile'", saving("`zipfile'", replace) complevel(`level')
    }
    else {
        zipfile "`fullfile'", saving("`zipfile'") complevel(`level')
    }
    
    // 删除原始文件
    erase "`fullfile'"
    
end
