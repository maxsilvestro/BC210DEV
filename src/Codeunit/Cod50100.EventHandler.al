codeunit 50100 EventHandler
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', false, false)]
    local procedure Customer_OnBeforeInsert(var Rec: Record Customer; RunTrigger: Boolean)
    begin

    end;
}
