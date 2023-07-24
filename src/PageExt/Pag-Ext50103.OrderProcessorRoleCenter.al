pageextension 50103 OrderProcessorRoleCenter50103 extends "Headline RC Order Processor"
{
    var
        NotifShow: Dictionary of [text, Guid];

    trigger OnAfterGetCurrRecord()
    var
        lNotification: Notification;
        lNotId: Guid;
        lText: text;
    begin
        lText := 'pippo';
        if not NotifShow.Get(lText, lNotId) then begin
            lNotId := CreateGuid();
            NotifShow.Add(lText, lNotId);
        end;

        lNotification.Id := lNotId;
        lNotification.Message(lText);

        lNotification.Send();
    end;
}
