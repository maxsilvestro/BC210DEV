codeunit 50106 ProgDialog
{
    var
        Window: Dialog;
        Text000: Label '#1##################\\';
        Text001: Label '#2##################\\';
        MaxCount: Integer;
        Text002: Label '%1%';
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

        ProgressBarText := Text000 + Text001;
        Window.Open(ProgressBarText);
        Window.Update(1, Format(WindowTitle));
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
                    UpdText := Format(WindowText);
                    if MaxCount <> 0 then
                        UpdText += ' ' + StrSubstNo(Text002, Round(Counter / MaxCount * 100, 1));
                    Window.Update(2, UpdText);
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
