page 80000 "NVI - Main menu"
{
    Caption = 'NAV-Vision - Toolbox';
    PageType = NavigatePage;
    ApplicationArea = all;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(DataHandler)
            {
                Caption = 'Data model';
                field(RunObjectReq; RunObject)
                {
                    ApplicationArea = All;
                    ToolTip = 'Press to open Toolbox function Run Object';
                    Caption = 'Run Object';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        page.RunModal(Page::"NVI - Run Object");
                    end;
                }
            }
            group(Mist)
            {
                Caption = 'Miscellaneous';
                field(JobQueueHandler; JobQueueHandler)
                {
                    ApplicationArea = All;
                    caption = 'Job Queue Mass Handler';
                    ToolTip = 'Press to Run Mass handler Report';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        Report.RunModal(Report::"NVI - Job Queue Entry Handler");
                    end;
                }
                field(LicensOverview; LicensOverview)
                {
                    ApplicationArea = All;
                    caption = 'Licens Overview';
                    ToolTip = 'Press to open licens overview';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        page.RunModal(page::"NVI - License overview");
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        RunObject := 'Run Object';
        JobQueueHandler := 'Job Queue Mass Handler';
        LicensOverview := 'Licens Overview'
    end;

    var
        RunObject: text;
        JobQueueHandler: Text;
        LicensOverview: text;
}
