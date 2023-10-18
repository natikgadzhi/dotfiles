# A function which filters options which starts with "-" from $argv.
function _swift_repeat_preprocessor
    set -l results
    for i in (seq (count $argv))
        switch (echo $argv[$i] | string sub -l 1)
            case '-'
            case '*'
                echo $argv[$i]
        end
    end
end

function _swift_repeat_using_command
    set -l currentCommands (_swift_repeat_preprocessor (commandline -opc))
    set -l expectedCommands (string split " " $argv[1])
    set -l subcommands (string split " " $argv[2])
    if [ (count $currentCommands) -ge (count $expectedCommands) ]
        for i in (seq (count $expectedCommands))
            if [ $currentCommands[$i] != $expectedCommands[$i] ]
                return 1
            end
        end
        if [ (count $currentCommands) -eq (count $expectedCommands) ]
            return 0
        end
        if [ (count $subcommands) -gt 1 ]
            for i in (seq (count $subcommands))
                if [ $currentCommands[(math (count $expectedCommands) + 1)] = $subcommands[$i] ]
                    return 1
                end
            end
        end
        return 0
    end
    return 1
end

complete -c repeat -n '_swift_repeat_using_command "repeat"' -l include-counter -d 'Include a counter with each repetition.'
complete -c repeat -n '_swift_repeat_using_command "repeat"' -l count -s c -d 'The number of times to repeat \'phrase\'.'
complete -c repeat -n '_swift_repeat_using_command "repeat"' -s h -l help -d 'Show help information.'
