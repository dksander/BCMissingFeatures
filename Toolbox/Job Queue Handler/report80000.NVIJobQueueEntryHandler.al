Report 80000 "NVI - Job Queue Entry Handler"
{
    Caption = 'Job Queue Entry Handler';
    ProcessingOnly = true;
    UsageCategory = None;
    dataset
    {
        dataitem(JobQueueEntry; "Job Queue Entry")
        {
            RequestFilterFields = "Job Queue Category Code", "Object Type to Run", "Object ID to Run", "User ID";
            trigger OnPreDataItem()
            var
                BlankFilterErr: Label 'Blank filter is not allow!';
                HandleAllJQEQst: Label 'Do you want to %1 all %2 Job Queue entry?';
            begin
                if JobQueueEntry.GetFilters = '' then
                    error(BlankFilterErr);

                if JobQueueEntry.Count = 0 then
                    CurrReport.Break();

                if GuiAllowed then
                    if not confirm(StrSubstNo(HandleAllJQEQst, GetActionCaption(), JobQueueEntry.Count), false) then
                        CurrReport.Break();
                OpenLoading(JobQueueEntry.Count);
            end;

            trigger OnAfterGetRecord()
            begin
                UpdateLoading();

                case HandleAction of
                    HandleAction::Delete:
                        DeleteJobQueue();
                    HandleAction::Pause:
                        SetOnHoldJobQueue();
                    HandleAction::Restart:
                        RestartJobQueue();
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Action)
                {
                    field(HandleActionReq; HandleAction)
                    {
                        ApplicationArea = all;
                        Caption = 'Action';
                        ToolTip = 'Select action to preform on Job queue entry in filter';
                    }
                }
            }
        }
    }
    trigger OnPostReport()
    begin
        CloseLoading();
    end;

    local procedure UpdateLoading()
    begin
        CurrRec += 1;
        if GuiAllowed then
            Window.UPDATE(1, (CurrRec / NoOfRecs * 10000) DIV 1);
    end;

    local procedure OpenLoading(RecCount: Integer)
    var
        ProcessingBarTok: Label 'Processing... @1@@@@@@@@@@';
    begin
        CurrRec := 0;
        NoOfRecs := RecCount;
        window.Open(ProcessingBarTok);
    end;

    local procedure CloseLoading()
    begin
        if GuiAllowed then
            Window.Close();
    end;

    local procedure DeleteJobQueue()
    begin
        JobQueueEntry.DeleteTask();
    end;

    local procedure SetOnHoldJobQueue()
    begin
        JobQueueEntry.SetStatus(JobQueueEntry.Status::"On Hold")
    end;

    local procedure RestartJobQueue()
    begin
        JobQueueEntry.Restart();
    end;

    local procedure GetActionCaption(): Text
    var
        DeleteCapLbl: Label 'Delete';
        PauseCapLbl: Label 'Pause';
        RestartCapLbl: Label 'Restart';
    begin
        case HandleAction of
            HandleAction::Delete:
                exit(DeleteCapLbl);
            HandleAction::Pause:
                exit(PauseCapLbl);
            HandleAction::Restart:
                exit(RestartCapLbl);
        end
    end;

    var
        HandleAction: enum "NVI - JQE Action";
        Window: Dialog;
        CurrRec: Integer;
        NoOfRecs: Integer;
}
