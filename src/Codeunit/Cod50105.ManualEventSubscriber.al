codeunit 50105 ManualEventSubscriber
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Page, Page::"Customer Card", 'OnNameChange', '', false, false)]
    local procedure OnNameChange(var vDescr: Text[10]);
    begin
        CallsCount += 1;
        Message('%1 %2', CallsCount, vDescr);
    end;

    var
        CallsCount: Decimal;

}
