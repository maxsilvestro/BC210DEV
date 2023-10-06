page 50105 ItemImages
{
    ApplicationArea = All;
    Caption = 'ItemImages';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Picture; ConfigMediaBuffer."Media Set")
                {
                    ToolTip = 'Specifies the picture that has been inserted for the item.';
                    Editable = false;
                }
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        ConfigMediaBuffer.SetRange("Media Set ID", Rec.Picture.MediaId);
        ConfigMediaBuffer.FindFirst();
    end;

    var
        ConfigMediaBuffer: Record "Config. Media Buffer";


}
