codeunit 50101 BackgroundHandler
{
    trigger OnRun()
    begin
        procBackgroundTask(Page.GetBackgroundParameters());
    end;

    local procedure procBackgroundTask(iParams: Dictionary of [Text, Text])
    var
        lResult: Dictionary of [Text, Text];
        lCounter: Integer;
    begin
        Evaluate(lCounter, iParams.Get('counter'));
        lCounter += 1;
        Sleep(1000);
        lResult.Add('counter', Format(lCounter));
        lResult.Add('messaggio', 'Questo è un messaggio di ritorno');
        page.SetBackgroundTaskResult(lResult);
    end;
}
