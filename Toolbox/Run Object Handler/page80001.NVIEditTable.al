page 80001 "NVI - Edit Table"
{
    PageType = NavigatePage;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Edit Table';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ShowFilter = false;

    layout
    {
        area(content)
        {
            group(EditTable)
            {
                field(TableID; TableID)
                {
                    ToolTip = 'Select Table to edit';
                    Caption = 'Table ID';
                    ApplicationArea = All;
                    TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(RunTable)
            {
                Image = Table;
                Caption = 'Run Table';
                ApplicationArea = all;
                ToolTip = 'Run Object';
                InFooterBar = true;
                trigger OnAction()
                begin
                    Hyperlink(GetURIToRun());
                end;
            }
        }
    }
    local procedure GetURIToRun(): text
    var
        EnvironmentInfo: Codeunit "Environment Information";
        CloudUriTok: Label 'https://businesscentral.dynamics.com/Live/tablet?%1';
        UnkownEnviromentErr: Label 'Enviroment Type Unknown';
        OnPremUriTok: Label 'http://%1/%2/tablet?tenant=%3&table=%4';
    begin
        if EnvironmentInfo.IsSaaS() then
            exit(StrSubstNo(CloudUriTok, TableID));
        if EnvironmentInfo.IsOnPrem() then
            exit(StrSubstNo(OnPremUriTok, 'bc20pte', 'BC', 'default', TableID));

        error(UnkownEnviromentErr)
    end;

    var
        TableID: Integer;
}