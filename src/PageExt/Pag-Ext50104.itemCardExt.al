pageextension 50104 itemCardExt_50104 extends "Item Card"
{
    layout
    {
        addafter(ItemPicture)
        {
            part(ItemImages; ItemImages)
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "No." = field("No.");
            }
        }
    }
}
