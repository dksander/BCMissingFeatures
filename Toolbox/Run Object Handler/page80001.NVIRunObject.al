page 80001 "NVI - Run Object"
{
    caption = 'Run All Objects';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = AllObjWithCaption;
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where("Object Type" = filter(Table | Page | Report | Codeunit | XMLport));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Object Type to run';
                }
                field("Object ID"; Rec."Object ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Object ID to run';
                }
                field("Object Name"; Rec."Object Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Object name to run';
                }
                field("Object Caption"; Rec."Object Caption")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Object Caption to run';
                }
                field("Object Subtype"; Rec."Object Subtype")
                {
                    ApplicationArea = All;
                    ToolTip = 'Object sub type';
                }
                field("App Package ID"; Rec."App Package ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'App ID for Object orgin';
                }
                field("App Package Name"; GetNavAppName(Rec."App Package ID"))
                {
                    Caption = 'App Package Name';
                    ApplicationArea = All;
                    ToolTip = 'App Name for Object orgin';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Run Object")
            {
                Caption = 'Run Object';
                ApplicationArea = All;
                Image = ExecuteBatch;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Scope = "Repeater";
                ShortcutKey = 'Ctrl+F5';
                ToolTip = 'Run Selected Object';

                trigger OnAction();
                begin
                    RunObject();
                end;
            }
            action("Edit Data")
            {
                Caption = 'Edit Data';
                ApplicationArea = All;
                Image = ExecuteBatch;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Scope = "Repeater";
                Enabled = Rec."Object Type" = Rec."Object Type"::Table;
                ShortcutKey = 'Ctrl+F6';
                ToolTip = 'Edit Selected Table';

                trigger OnAction();
                begin
                    EditData();
                end;
            }
        }
    }
    local procedure GetNavAppName(inAppPackageID: Guid): Text
    var
        NavApp: Record "NAV App Installed App";
    begin
        NavApp.SetRange("Package ID", inAppPackageID);
        if NavApp.FindFirst() then
            exit(NavApp.Name);
    end;

    local procedure RunObject()
    var
        ObjectInvalidMsg: Label 'Object Type %1 with name %2 cannot be run';
    begin
        case Rec."Object Type" of
            Rec."Object Type"::Page:
                PAGE.RunModal(Rec."Object ID");
            Rec."Object Type"::Report:
                REPORT.RunModal(Rec."Object ID");
            Rec."Object Type"::Codeunit:
                CODEUNIT.run(Rec."Object ID");
            Rec."Object Type"::XMLport:
                XMLPORT.run(Rec."Object ID");
            Rec."Object Type"::Table:
                Hyperlink(GetUrl(ClientType::Current, CompanyName, ObjectType::Table, Rec."Object ID"));
            else
                Message(StrSubstNo(ObjectInvalidMsg, Rec."Object Type", Rec."Object Name"));
        end;
    end;

    local procedure EditData()
    begin
        Rec.TestField("Object Type", Rec."Object Type"::Table);

    end;
}