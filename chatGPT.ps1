

Function SendChatGPT {
    param(
        [string]$APIKey
    )
    Write-Output "hello world"

    $baseUrl = "https://api.openai.com/v1/chat/completions"
    $headers = @{
        "Content-Type"  = "application/json"
        "Authorization" = "Bearer $APIKey"
    }

    $body = @{
        model    = "gpt-3.5-turbo"
        messages = @(
            @{ role = "system"; content = "You are a helpful assistant." },
            @{ role = "user"; content = "Who won the World Series in 2020?" }
        )
    } | ConvertTo-Json

    $response = Invoke-RestMethod -Uri $baseUrl -Method Post -Headers $headers -Body $body
    Write-Output $response
}
