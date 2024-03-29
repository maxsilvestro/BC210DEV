codeunit 50102 Varie
{

    procedure fromAlpha36ToInt(iText: Text) oInt: Integer
    var
        lIndex: Integer;
        lList: List of [Integer];
        lLen: Integer;
    begin
        lLen := StrLen(iText);
        for lIndex := 0 to lLen - 1 do
            lList.Add(StrPos(alpha36String(), iText[lLen - lIndex]) - 1);
        oInt := fromBaseToInt(lList, 36);
    end;

    procedure fromIntToAlpha36(iInt: Integer) oText: Text
    var
        lList: List of [Integer];
        lInt: Integer;
    begin
        fromIntToBase(iInt, 36, lList);
        foreach lInt in lList do
            oText := alpha36String() [lInt + 1] + oText;
    end;

    procedure incAlpha36(iString: Text) oString: Text
    begin
        oString := incAlpha36(iString, false);
    end;

    procedure incAlpha36(iString: Text; iAutoGrowe: Boolean) oString: Text
    begin
        oString := incAlpha(iString.ToUpper(), StrLen(iString), iAutoGrowe);
    end;

    local procedure alpha36String(): Text
    var
        lStringLbl: Label '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', Locked = true;
    begin
        exit(lStringLbl);
    end;

    local procedure fromBaseToInt(iList: List of [Integer]; iBase: Integer) oInt: Integer
    var
        lInt: Integer;
        lIndex: Integer;
    begin
        foreach lInt in iList do begin
            oInt := oInt + Power(iBase, lIndex) * lInt;
            lIndex += 1;
        end;
    end;

    local procedure fromIntToBase(iInt: Integer; iBase: Integer; var oList: List of [Integer])
    begin
        if (iInt <= iBase) then begin
            oList.Add(iInt);
            exit;
        end;

        oList.Add(iInt mod ibase);
        fromIntToBase(iInt div ibase, iBase, oList);
    end;

    local procedure incAlpha(iString: Text; iPos: Integer; iAutoGrowe: Boolean) oString: Text
    var
        lInvalidStrLbl: Label 'Invali string', comment = 'ITA="Stringa non valida"';
        lIsLast: Boolean;
    begin
        if iAutoGrowe and (iPos = 0) then begin
            iString := alpha36String() [1] + iString;
            iPos := 1;
        end;

        if IsChar(iString[iPos]) then
            lIsLast := IncValue(iString[iPos])
        else
            Error(lInvalidStrLbl);

        if lIsLast then
            oString := incAlpha(iString, iPos - 1, iAutoGrowe)
        else
            oString := iString;
    end;

    local procedure IncValue(var vChar: Char) oIsLast: Boolean
    var
        lNum: Integer;
    begin
        lNum := StrPos(alpha36String(), Format(vChar));
        if (lNum = StrLen(alpha36String())) then begin
            vChar := alpha36String() [1];
            oIsLast := true;
        end
        else
            vChar := alpha36String() [lNum + 1];
    end;

    local procedure IsChar(iChar: Char): Boolean
    begin
        exit(alpha36String().Contains(Format(iChar)));
    end;

    [Scope('OnPrem')]
    procedure ReadSMBFile(FilePath: Text)
    var
        fileMngt: Codeunit "File Management";
        AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Locked = true;
        FileName: Text;
    begin
        Download(FilePath, '', '', AllFilesDescriptionTxt, FileName);


    end;
}
