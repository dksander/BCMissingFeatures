Enum 80000 "NVI - JQE Action"
{
    Extensible = true;
    Caption = 'Job Queue Entry Action';

    value(0; Pause)
    {
        Caption = 'Pause';
    }
    value(1; Delete)
    {
        Caption = 'Delete';
    }
    value(2; Restart)
    {
        Caption = 'Restart';
    }
}
