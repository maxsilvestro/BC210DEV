controladdin Wysiwyg
{
    RequestedHeight = 600;
    MinimumHeight = 600;
    MaximumHeight = 600;
    VerticalStretch = true;
    HorizontalStretch = true;
    Scripts = 'src/Editor/Scripts/ckeditor.js', 'src/Editor/Scripts/MainScript.js';
    StartupScript = 'src/Editor/Scripts/startupScript.js';
    RecreateScript = 'src/Editor/Scripts/recreateScript.js';
    StyleSheets = 'src/Editor/Stylesheet/styles.css';
    RefreshScript = 'src/Editor/Scripts/refreshScript.js';

    event ControlReady();
    event SaveRequested(data: Text);
    event ContentChanged();
    event OnAfterInit();

    procedure Init();
    procedure Load(data: Text);
    procedure RequestSave();
    procedure SetReadOnly(readonly: boolean);
}

page 50110 "Test Wysiwyg"
{
    layout
    {
        area(Content)
        {
            usercontrol(Test; Wysiwyg)
            {
                ApplicationArea = All;
                trigger ControlReady()
                begin
                    CurrPage.Test.Init();
                    CurrPage.Test.Load('This is a <strong>BOLD</strong> statement!');
                end;

                trigger SaveRequested(data: Text)
                begin
                    Message(data);
                end;
            }
        }
    }
    actions
    {
        area(Creation)
        {
            action(Save)
            {
                trigger OnAction()
                begin
                    CurrPage.Test.RequestSave();
                end;

            }
        }
    }
}