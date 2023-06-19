
Function GetQuote {
    param(
        [string]$APIKey
    )

    $endpoint = "https://api.api-ninjas.com/v1/quotes"


    $headers = @{
        "X-Api-Key" = $APIKey
    }
    try {
        # Make the GET request
        $response = Invoke-RestMethod -Uri $endpoint -Headers $headers -Method Get

        # Extract the "quote" field from the response
        $quote = $response[0].quote
        $author = $response[0].author

        Write-Output ""
        Write-Host """" $quote """"  
        Write-Host "-" $author
        Write-Output ""
    }
    catch {
        # If an error occurs, print the error message
        Write-Host "An error occurred: $($_.Exception.Message)"
    }
}
