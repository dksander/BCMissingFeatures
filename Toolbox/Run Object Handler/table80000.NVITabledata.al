table 80000 "NVI - Table data"
{
    Caption = 'Table data';
    TableType = Temporary;
    DataClassification = SystemMetadata;
    ReplicateData = false;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(3; "Field No."; Integer)
        {
            Caption = 'Field No.';
            TableRelation = Field."No.";
        }
        field(4; "Field Name"; Text[30])
        {
            Caption = 'Field Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Field.FieldName where("No." = field("Field No.")));
            Editable = false;
        }
        field(5; "Record ID"; RecordId)
        {
            Caption = 'Record ID';
        }
        field(10; Value; Text[2048])
        {
            Caption = 'Value';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Table ID", "Field No.", "Record ID")
        {
            Clustered = true;
        }
    }
}

