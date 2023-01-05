pageextension 50101 CustomerCard_50101 extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field(counterField; counter)
            {
                ApplicationArea = All;
                Caption = 'Contatore';
            }
        }
    }
    actions
    {
        addfirst(processing)
        {
            action(BackgroundAction)
            {
                Caption = 'Launch background action';
                ApplicationArea = All;
                Image = Workflow;

                trigger OnAction()
                begin
                    if not Confirm('Eseguire task in background?') then
                        exit;

                    StartBackgroundTask();
                end;
            }
            action(CoupledOrderAction)
            {
                ApplicationArea = All;
                Image = CoupledOrder;

                trigger OnAction()
                var
                    lFile: Text;
                    lInstream: InStream;
                    lJSBuffer: Record "JSON Buffer" temporary;
                    lTypeHelper: Codeunit "Type Helper";
                begin
                    if not UploadIntoStream('json file', '', '', lFile, lInstream) then
                        exit;
                    lJSBuffer.ReadFromText(lTypeHelper.ReadAsTextWithSeparator(lInstream, lTypeHelper.CRLFSeparator));
                    page.RunModal(page::JsonBuffer, lJSBuffer);
                end;
            }

        }
        addfirst(Promoted)
        {
            actionref(PromotedBackgroundAction; BackgroundAction)
            { }
        }
    }
    var
        BackgroundTaskId: Integer;
        counter: Integer;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    begin
        case TaskId of
            BackgroundTaskId:
                GetBackgroundResult(Results);
        end;
    end;

    local procedure GetBackgroundResult(Results: Dictionary of [Text, Text])
    var
        lCounterText: Text;
        lNot: Notification;
    begin
        lCounterText := Results.Get('counter');

        Evaluate(counter, lCounterText);

        if counter < 10 then
            StartBackgroundTask()
        else begin
            lnot.Message(Results.Get('messaggio'));
            lnot.Send();
        end;

    end;

    local procedure StartBackgroundTask()
    var
        lTaskPar: Dictionary of [Text, Text];
    begin
        lTaskPar.Add('counter', Format(counter));

        CurrPage.EnqueueBackgroundTask(BackgroundTaskId, Codeunit::BackgroundHandler, lTaskPar, 600000, PageBackgroundTaskErrorLevel::Warning);
    end;
}
