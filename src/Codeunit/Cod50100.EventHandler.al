codeunit 50100 EventHandler
{
    [EventSubscriber(ObjectType::Table, Database::"Avg. Cost Adjmt. Entry Point", 'OnBeforeInsertEvent', '', false, false)]
    local procedure MyProcedure(var Rec: Record "Avg. Cost Adjmt. Entry Point")
    begin
        if Rec."Valuation Date" = Today then;
    end;
}
