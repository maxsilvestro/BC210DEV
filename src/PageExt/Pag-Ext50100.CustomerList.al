pageextension 50100 CustomerList_50100 extends "Customer List"
{

    actions
    {
        addfirst(processing)
        {
            action(Debug)
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    lVarie: Codeunit Varie;
                    lIndex: Integer;
                    lString: Text;
                    lTB: TextBuilder;
                begin
                    lString := PadStr(lString, 5, '0');
                    for lIndex := 1 to 10000 do begin
                        lString := lVarie.incAlpha36(lString);
                        lTB.AppendLine(lString);
                    end;

                    Message(lTB.ToText());
                    Message('%1 - %2 -%3 - %4', lIndex, lString, lVarie.fromAlpha36ToInt(lString), lVarie.fromIntToAlpha36(lIndex));
                end;
            }
        }
    }
}
