

Function SendChatGPT {
    param(
        [string]$s,
        [string]$u
    )

    # Check if environment variable is null or not set
    if ([string]::IsNullOrEmpty($env:OPENAI_API_KEY)) {
        Throw "OPENAI_API_KEY is null or not set."
    }
    $APIKey = $env:OPENAI_API_KEY


    $baseUrl = "https://api.openai.com/v1/chat/completions"
    $headers = @{
        "Content-Type"  = "application/json"
        "Authorization" = "Bearer $APIKey"
    }
    
    $quotedText = [System.Management.Automation.WildcardPattern]::Escape($u)
    $quotedText = $quotedText -replace "'", "\'"
    $quotedText = $quotedText -replace '"', '\"'
    $quotedText = $quotedText -replace '“', '\"'
    $quotedText = $quotedText -replace '”', '\"'

    $body = @{
        model    = "gpt-3.5-turbo"
        messages = @(
            @{ role = "system"; content = $s },
            @{ role = "user"; content = $quotedText }
        )
    } | ConvertTo-Json

    $response = Invoke-RestMethod -Uri $baseUrl -Method Post -Headers $headers -Body $body
    Write-Output ""
    Write-Output $response.choices[0].message.content
    Write-Output ""
}

Function pingGPT {
    SendChatGPT -s "You are a romantic poet" -u "Make a haiku about life"
}

Function refrase {
    param(
        [Parameter(Position = 0)]
        [string]$Text
    )
    $system = "Act like a tech writer explain technical concepts"
    
    $command = "Please paraphrase and summerize the text below:\n" + $Text

    SendChatGPT -s $system -u $command

}