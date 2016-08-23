macro(pop list out)
    list(GET ${list} 0 ${out}) 
    list(REMOVE_AT ${list} 0)
endmacro()

macro(push list in)
    list(APPEND ${list} ${in}) 
endmacro()

macro(join list delim out)
    set(sep "")
    foreach(arg ${${list}})
        set(${out} "${${out}}${sep}${arg}")
        set(sep ${delim})
    endforeach()
endmacro()

macro(symlink src dst)
    get_filename_component(file "${src}" NAME)
    set(dst_file "${dst}/${file}")
    if(NOT IS_DIRECTORY "${dst}")
        execute_process(
            COMMAND mkdir -p "${dst}"
            RESULT_VARIABLE rc)
        if(rc)
            message(FATAL_ERROR "Failed mkdir -p ${dst}")
        endif()
    elseif(IS_SYMLINK "${dst_file}")
        file(REMOVE "${dst_file}")
    endif()
    message("-- Symlinking: ${dst_file}")
    execute_process(
        COMMAND cmake -E create_symlink "${src}" "${dst_file}"
        RESULT_VARIABLE rc)
    if(rc)
        message(FATAL_ERROR "create_symlink failed! src:${src} dst:${dst} dst_file:${dst_file}")
    endif()
endmacro()

function(FILE CMD)
    if(CMD STREQUAL INSTALL)
        set(args ${ARGN})
        set(cmd FILES)
        set(type FILE)
        # join(args " " trace)
        # message(${trace})
        while (args)
            pop(args arg)
            if(arg STREQUAL DESTINATION)
                set(cmd ${arg})
                pop(args dest)
            elseif(arg STREQUAL FILES)
                set(cmd ${arg})
                pop(args files)
            elseif(arg STREQUAL TYPE)
                set(cmd ${arg})
                pop(args type)
            elseif(arg STREQUAL FILE_PERMISSIONS OR
                    arg STREQUAL DIRECTORY_PERMISSIONS OR
                    arg STREQUAL NO_SOURCE_PERMISSIONS OR
                    arg STREQUAL USE_SOURCE_PERMISSIONS OR
                    arg STREQUAL FILES_MATCHING OR
                    arg STREQUAL PATTERN OR
                    arg STREQUAL REGEX OR
                    arg STREQUAL EXCLUDE OR
                    arg STREQUAL PERMISSIONS OR
                    arg STREQUAL TYPE)
                set(cmd ${arg})
            else()
                if(cmd STREQUAL FILES)
                    push(files "${arg}")
                endif()
            endif()
        endwhile()
        # message("dest: " ${dest} "; files: " ${files})
        if(NOT type STREQUAL DIRECTORY)
            foreach(file ${files})
                symlink(${file} ${dest})
            endforeach()
        else()
            _FILE(${ARGV})
        endif()
    else()
        _FILE(${ARGV})
    endif()
endfunction(FILE)
