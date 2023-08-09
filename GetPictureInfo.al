pageextension 50112 ZYItemCard extends "Item Card"
{
    actions
    {
        addafter("&Bin Contents")
        {
            action(GetPictureInfo)
            {
                Caption = 'Get Picture Info';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = GetLines;

                trigger OnAction()
                begin
                    GetPictureInfo();
                end;
            }
        }
    }

    var
        Msg: Label 'Format is ''%1''\Size is ''%2'' bytes\Width is ''%3'' pixels\Height is ''%4'' pixels';

    local procedure GetPictureInfo()
    var
        Image: Codeunit Image;
        InS: InStream;
        ItemTenantMedia: Record "Tenant Media";
    begin
        if Rec.Picture.Count > 0 then begin
            ItemTenantMedia.Get(Rec.Picture.Item(1));
            ItemTenantMedia.CalcFields(Content);
            ItemTenantMedia.Content.CreateInStream(InS, TextEncoding::UTF8);
            Image.FromStream(InS);
            Message(Msg, Image.GetFormat(), InS.Length, Image.GetWidth(), Image.GetHeight());
        end;
    end;
}

pageextension 50113 ZYCustomerCardExt extends "Customer Card"
{
    actions
    {
        addafter("Sales Journal")
        {
            action(GetPictureInfo)
            {
                Caption = 'Get Picture Info';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = GetLines;

                trigger OnAction()
                begin
                    GetPictureInfo();
                end;
            }
        }
    }

    var
        Msg: Label 'Format is ''%1''\Size is ''%2'' bytes\Width is ''%3'' pixels\Height is ''%4'' pixels';

    local procedure GetPictureInfo()
    var
        Image: Codeunit Image;
        InS: InStream;
        CustTenantMedia: Record "Tenant Media";
    begin
        if Rec.Image.HasValue then begin
            CustTenantMedia.Get(Rec.Image.MediaId);
            CustTenantMedia.CalcFields(Content);
            CustTenantMedia.Content.CreateInStream(InS, TextEncoding::UTF8);
            Image.FromStream(InS);
            Message(Msg, Image.GetFormat(), InS.Length, Image.GetWidth(), Image.GetHeight());
        end;
    end;
}
