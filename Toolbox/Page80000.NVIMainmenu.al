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
                    ToolTip = 'Press to open Toolbox function Edit table';
                    Caption = 'Edit Table';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        page.RunModal(Page::"NVI - Edit Table");
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
            }
        }
    }
    trigger OnOpenPage()
    begin
        RunObject := 'Edit records in table';
        JobQueueHandler := 'Job Queue Mass Handler';
    end;

    var
        RunObject: text;
        JobQueueHandler: Text;
}
