Pageextension 80000 "NVI - Job Queue Entries" extends "Job Queue Entries"
{
    actions
    {
        addafter(Restart)
        {
            action(MassHandler)
            {
                ToolTip = 'Action for restart,pause,delete multiple job queue entries';
                ApplicationArea = all;
                Caption = 'Mass Handle Entries';
                RunObject = Report "NVI - Job Queue Entry Handler";
                Image = AddAction;
                Promoted = true;
                PromotedIsBig = true;
            }
        }
    }
}
