page 80005 "NVI - License overview"
{
    ApplicationArea = All;
    Caption = 'NVI - License overview';
    PageType = List;
    SourceTable = "License Permission";
    UsageCategory = Administration;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the Object Type field.';
                    ApplicationArea = All;
                }
                field("Object Number"; Rec."Object Number")
                {
                    ToolTip = 'Specifies the value of the Object Number field.';
                    ApplicationArea = All;
                }
                field("Read Permission"; Rec."Read Permission")
                {
                    ToolTip = 'Specifies the value of the Read Permission field.';
                    ApplicationArea = All;
                }
                field("Insert Permission"; Rec."Insert Permission")
                {
                    ToolTip = 'Specifies the value of the Insert Permission field.';
                    ApplicationArea = All;
                }
                field("Modify Permission"; Rec."Modify Permission")
                {
                    ToolTip = 'Specifies the value of the Modify Permission field.';
                    ApplicationArea = All;
                }
                field("Delete Permission"; Rec."Delete Permission")
                {
                    ToolTip = 'Specifies the value of the Delete Permission field.';
                    ApplicationArea = All;
                }
                field("Execute Permission"; Rec."Execute Permission")
                {
                    ToolTip = 'Specifies the value of the Execute Permission field.';
                    ApplicationArea = All;
                }
                field("Limited Usage Permission"; Rec."Limited Usage Permission")
                {
                    ToolTip = 'Specifies the value of the Limited Usage Permission field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Objects)
            {
                action(ShowAvailableObjects)
                {
                    Caption = 'Show Available Objects only';
                    ToolTip = 'Filter list to only show Objects not in use';
                    Image = AvailableToPromise;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        AllObjWithCaption: Record AllObjWithCaption;
                    begin
                        if ShowMarked then begin
                            Rec.Reset();
                            if Rec.FindSet(false, false) then
                                repeat
                                    Rec.ClearMarks();
                                until Rec.Next() = 0;
                        end
                        else begin
                            Rec.Reset();
                            Rec.SetRange("Object Number", 50000, 99999);
                            if Rec.FindSet(false, false) then
                                repeat
                                    if not AllObjWithCaption.Get(Rec."Object Type", Rec."Object Number") then
                                        Rec.Mark(true);
                                until Rec.Next() = 0;
                            Rec.MarkedOnly();
                            ShowMarked := true;
                        end;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        clear(ObjectExist);
        if AllObjWithCaption.Get(Rec."Object Type", Rec."Object Number") then
            ObjectExist := true;
    end;

    var
        ObjectExist: Boolean;
        ShowMarked: Boolean;
}
