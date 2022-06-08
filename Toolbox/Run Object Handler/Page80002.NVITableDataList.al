page 80002 "NVI - Table Data List"
{
    Caption = 'Table Data List';
    PageType = List;
    SourceTable = "NVI - Table data";
    UsageCategory = None;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field.';
                    ApplicationArea = All;
                }
                field("Field No."; Rec."Field No.")
                {
                    ToolTip = 'Specifies the value of the Field No. field.';
                    ApplicationArea = All;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ToolTip = 'Specifies the value of the Field Name field.';
                    ApplicationArea = All;
                }
                field("Value"; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    procedure SetTable(TableId: Integer)
    begin
        GlobalTableId := TableId;
    end;

    local procedure LoadData()
    var
        TableNotSetErr: Label 'Table No is not correct';
        RecRef: RecordRef;
        field
    begin
        OpenLoading();
        if GlobalTableId = 0 then
            Error(TableNotSetErr);
        RecRef.Reset();
        RecRef.Open(GlobalTableId);
        repeat

        until RecRef.Next() = 0;
        CloseLoading();
    end;



    local procedure OpenLoading()
    var
        ProcessingBarTok: Label 'Loading records...';
    begin
        window.Open(ProcessingBarTok);
    end;

    local procedure CloseLoading()
    begin
        Window.Close();
    end;

    var
        GlobalTableId: Integer;
        Window: Dialog;
}
