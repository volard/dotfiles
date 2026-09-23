function pytest15 --description 'Run a Selenium pytest target a specified number of times'
    if test (count $argv) -ne 2
        echo 'Usage: pytest15 <test-path> <run-count>' >&2
        return 2
    end

    if not string match --quiet --regex '^[1-9][0-9]*$' -- "$argv[2]"
        echo 'Run count must be a positive integer.' >&2
        return 2
    end
    set -l run_count $argv[2]

    for i in (seq 1 $run_count)
        echo "Run $i/$run_count"
        docker compose exec -T selenium-magic pytest \
            --browser docker-chrome \
            --reruns 0 \
            --url 'http://roadcons:crossfit20@frontend_magic' \
            --aisproject 'Апатиты ТЕСТ' \
            --db "dbname='apatitytestkube' user='cs' host='postgres' password='sanda05'" \
            --alluredir "/allure_results/run-$i" \
            "$argv[1]"
        or echo "FAILED: run $i"
    end
end
