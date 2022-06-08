page 80007 "NVI - Active Session List"
{

    ApplicationArea = All;
    Caption = 'Active Session List';
    PageType = List;
    SourceTable = "Active Session";
    UsageCategory = Administration;
    Editable = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    ApplicationArea = All;
                }
                field("User SID"; Rec."User SID")
                {
                    ToolTip = 'Specifies the value of the User SID field.';
                    ApplicationArea = All;
                }
                field("Session ID"; Rec."Session ID")
                {
                    ToolTip = 'Specifies the value of the Session ID field.';
                    ApplicationArea = All;
                }
                field("Client Computer Name"; Rec."Client Computer Name")
                {
                    ToolTip = 'Specifies the value of the Client Computer Name field.';
                    ApplicationArea = All;
                }
                field("Client Type"; Rec."Client Type")
                {
                    ToolTip = 'Specifies the value of the Client Type field.';
                    ApplicationArea = All;
                }
                field("Login Datetime"; Rec."Login Datetime")
                {
                    ToolTip = 'Specifies the value of the Login Datetime field.';
                    ApplicationArea = All;
                }
                field("Server Computer Name"; Rec."Server Computer Name")
                {
                    ToolTip = 'Specifies the value of the Server Computer Name field.';
                    ApplicationArea = All;
                }
                field("Server Instance ID"; Rec."Server Instance ID")
                {
                    ToolTip = 'Specifies the value of the Server Instance ID field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Server Instance Name"; Rec."Server Instance Name")
                {
                    ToolTip = 'Specifies the value of the Server Instance Name field.';
                    ApplicationArea = All;
                }
                field("Database Name"; Rec."Database Name")
                {
                    ToolTip = 'Specifies the value of the Database Name field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(StopSession)
            {
                ApplicationArea = All;
                Caption = 'Stop Session';
                ToolTip = 'Stop the currently marked session';
                Image = Delete;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                trigger OnAction();
                begin
                    if confirm(StrSubstNo(StopSessionQst, Rec."Session ID")) then
                        STOPSESSION(Rec."Session ID");
                end;
            }
        }
    }
    var
        StopSessionQst: Label 'Do you want to stop session %1?';
}
