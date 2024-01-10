codeunit 50106 ProgDialog
{
    var
        Window: Dialog;
        Text000: Label '#1##################\\', Locked = true;
        Text001: Label '#2##################\\', Locked = true;
        Text002: Label '#3##################', Locked = true;
        MaxCount: Integer;
        StepCount: Integer;
        Counter: Integer;

    procedure Init(NewMaxCount: Integer; NewStepCount: Integer; WindowTitle: Text)
    var
        ProgressBarText: Text;
    begin
        Counter := 0;
        MaxCount := NewMaxCount;
        if NewStepCount = 0 then
            NewStepCount := 1;
        StepCount := NewStepCount;

        ProgressBarText := Text000 + Text001 + Text002;
        Window.Open(ProgressBarText);
        Window.Update(1, Format(WindowTitle));
        Window.Update(2, '');
        Window.Update(3, '');
    end;

    procedure Update(WindowText: Text)
    var
        IsHandled: Boolean;
        UpdText: Text;
    begin
        IsHandled := false;
        if not IsHandled then
            if WindowText <> '' then begin
                Counter := Counter + 1;
                if Counter mod StepCount = 0 then begin
                    Window.Update(2, Format(WindowText));
                    if MaxCount <> 0 then
                        Window.Update(3, Format(Round(Counter / MaxCount * 100, 1)) + '%');
                end;
            end;
    end;

    procedure GetCounter(): Integer
    begin
        exit(counter);
    end;

    procedure Close()
    begin
        Window.Close();
    end;
}
