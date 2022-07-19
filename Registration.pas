unit Registration;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, ComObj, ActiveX,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.ExtCtrls, iniFiles, DateUtils, ExcelXP;

type
  TForm1 = class(TForm)

    Label1: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Edit4: TEdit;
    Label6: TLabel;
    Edit5: TEdit;
    ComboBox2: TComboBox;
    Button1: TButton;
    CheckBox1: TCheckBox;
    Button2: TButton;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    DBGrid1: TDBGrid;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Button3: TButton;
    N3: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure ComboBox1Click(Sender: TObject);
    procedure ComboBox2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure N2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DBGrid1Enter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N3Click(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;



var
  Form1: TForm1;

implementation
{$R *.dfm}

Uses Rasshivka, ErrorMessage;



//��� ������������
function GetUserFromWindows: string;
var
  Name : string;
  NameLen : Dword;
begin
  NameLen := 255;
  SetLength(Name, NameLen);
  if GetUserName(PChar(Name), NameLen) then
    Result := Copy(Name,1,NameLen - 1)
  else
    Result := '�� �����';
end;



// ������ ���������
procedure TForm1.Button1Click(Sender: TObject);
var
              Com_box_2, EMS, KCE, Pony_Express, MAJOR, PTK, ESP_Express, Credit_Consulting :string;
              Com_box, Pisma, Kur_slujba, DHL_Paket, DHL_Koroba :string;
              WWW,LA,LB,LI,LD,LF,PB,LRU : string;
begin
          LA:= 'LA';
          LB:= 'LB';
          LI:= 'LI';
          LD:= 'LD';
          PB:= 'PB';
          LF:= 'LF';
          LRU:= '2LRU';
          WWW:= 'WWW';


          DHL_Koroba := ComboBox1.Items[0];
          DHL_Paket := ComboBox1.Items[1];
          Kur_slujba := ComboBox1.Items[2];
          Pisma := ComboBox1.Items[3];
          Com_box := ComboBox1.Items.Strings[ComboBox1.ItemIndex];

          ESP_Express  := Combobox2.Items[0];
          KCE := Combobox2.Items[1];
          MAJOR  := Combobox2.Items[2];
          EMS := Combobox2.Items[3];
          Pony_Express := Combobox2.Items[4];
          PTK   := Combobox2.Items[5];
          Credit_Consulting := Combobox2.Items[6];
          Com_box_2 := ComboBox2.Items.Strings[ComboBox2.ItemIndex];

          //���� ������ � ����

          //������ � DHL ��������

          if (Com_box = DHL_Paket) then
          begin
                if Edit2.Text = '' then
                begin

                ShowMessage('������� �����-��� DHL');
                Edit2.SetFocus;

                end
                else if Edit4.Text = '' then
                     begin

                     ShowMessage('������� � ���������');
                     Edit4.SetFocus;

                     end
                     else if Edit5.Text = '' then
                          begin

                          ShowMessage('������� �����-��� ���������');
                          Edit5.SetFocus;

                          end
                          else if  (copy(Edit5.Text, 0, 2) = LA) or (copy(Edit5.Text, 0, 2) = LB) or
                                   (copy(Edit5.Text, 0, 2) = LI) or (copy(Edit5.Text, 0, 2) = LD) or
                                   (copy(Edit5.Text, 0, 2) = PB) or (copy(Edit5.Text, 0, 2) = LF) or
                                   (copy(Edit5.Text, 0, 4) = LRU) or (copy(Edit5.Text, 0, 3) = WWW) then
                                begin

                                ShowMessage('�� ��������� ������ �����-��� ����������������� ���������');
                                Edit1.Enabled := False;
                                Edit2.Enabled := False;
                                Edit3.Enabled := False;
                                Edit4.Enabled := False;
                                Edit5.SetFocus;
                                Edit5.SelectAll;

                                end
                                else
                                     begin

                                     ADOQuery1.Close;
                                     ADOQuery1.SQL.Clear;
                                     ADOQuery1.SQL.ADD('SELECT [�� ���������] FROM Registration WHERE [�� ���������] = '+quotedstr(edit5.Text)+'');

                                     ADOQuery1.Open;

                                            if not ADOQuery1.Eof then
                                            begin

                                            ADOQuery1.Close;

                                            ADOQuery1.ExecSQL;

                                            ADOQuery1.SQL.Clear;
                                            ADOQuery1.SQL.Add('SELECT * FROM Registration ORDER BY ID DESC');
                                            ADOQuery1.Open;

                                            ShowMessage('����');


                                            end
                                            else
                                                begin




                                                ADOQuery1.Close;




                                                ADOQuery1.SQL.Add('INSERT INTO Registration ([�� ��������], [�� DHL], [�� �������], [�� �����������], [�� ���������], [��� ������������], [��� ��������], ������)');
                                                ADOQuery1.SQL.Add('VALUES (' + quotedstr(edit1.Text) + ',' +
                                                                               quotedstr(edit2.Text) + ',' +
                                                                               quotedstr(edit3.Text) + ',' +
                                                                               quotedstr(edit4.Text) + ',' +
                                                                               quotedstr(edit5.Text) + ',' +
                                                                               quotedstr(GetUserFromWindows) + ',' +
                                                                               quotedstr(ComboBox1.Items.Strings[ComboBox1.ItemIndex]) + ',' +
                                                                               quotedstr('DHL') + ')' );

                                                ADOQuery1.ExecSQL;
                                                ADOQuery1.SQL.Clear;
                                                ADOQuery1.SQL.Add('SELECT * FROM Registration ORDER BY ID DESC');

                                                ADOQuery1.Open;



                                                    if CheckBox3.Checked = True then
                                                    begin
                                                          Edit2.Enabled := True;
                                                          Edit3.Enabled := True;
                                                          Edit4.Enabled := True;

                                                         Edit2.Clear;
                                                         Edit3.Clear;
                                                         Edit5.Clear;
                                                         Edit2.SetFocus;
                                                     end
                                                    else
                                                        begin
                                                          Edit1.Enabled := True;
                                                          Edit2.Enabled := True;
                                                          Edit3.Enabled := True;
                                                          Edit4.Enabled := True;


                                                            Edit1.Clear;
                                                            Edit2.Clear;
                                                            Edit3.Clear;
                                                            Edit5.Clear;
                                                            Edit2.SetFocus;
                                                        end;



                                                end;
                                     end;

          end;

          // ������ � MAJOR

                if (Com_box_2 = MAJOR) then
                begin

                          if Edit2.Text = '' then
                          begin

                               ShowMessage('������� �����-��� DHL');
                               Edit2.SetFocus;

                          end;

                          if Edit4.Text = '' then
                          begin

                               ShowMessage('������� � ���������');
                               Edit4.SetFocus;

                          end;

                          if Edit5.Text = '' then
                          begin
                                ShowMessage('������� �����-��� ���������');
                                Edit5.SetFocus;
                          end
                          else
                          if  (copy(Edit5.Text, 0, 2) = LA) or (copy(Edit5.Text, 0, 2) = LB) or
                              (copy(Edit5.Text, 0, 2) = LI) or (copy(Edit5.Text, 0, 2) = LD) or
                              (copy(Edit5.Text, 0, 2) = PB) or (copy(Edit5.Text, 0, 2) = LF) or
                              (copy(Edit5.Text, 0, 4) = LRU) or (copy(Edit5.Text, 0, 3) = WWW) then

                          begin
                                        ShowMessage('�� ��������� ������ �����-��� ����������������� ���������');
                                        Edit5.SetFocus;
                                        Edit5.SelectAll;
                           end
                          else
                             begin
                                    ADOQuery1.Close;
                                    ADOQuery1.SQL.Clear;
                                    ADOQuery1.SQL.ADD('SELECT [�� ���������] FROM Registration WHERE [�� ���������] = '+quotedstr(edit5.Text)+'');

                                    ADOQuery1.Open;

                                    if not ADOQuery1.Eof then
                                    begin

                                          ADOQuery1.Close;

                                          ADOQuery1.ExecSQL;

                                          ADOQuery1.SQL.Clear;
                                          ADOQuery1.SQL.Add('SELECT * FROM Registration ORDER BY ID DESC');
                                          ADOQuery1.Open;

                                          ShowMessage('����');


                                    end
                                    else
                                    begin




                                     ADOQuery1.Close;




                                    ADOQuery1.SQL.Add('INSERT INTO Registration ([�� ��������], [�� DHL], [�� �������], [�� �����������], [�� ���������], [��� ������������], [��� ��������], ������)');
                                    ADOQuery1.SQL.Add('VALUES (' + quotedstr(edit1.Text) + ',' +
                                                                   quotedstr(edit2.Text) + ',' +
                                                                   quotedstr(edit3.Text) + ',' +
                                                                   quotedstr(edit4.Text) + ',' +
                                                                   quotedstr(edit5.Text) + ',' +
                                                                   quotedstr(GetUserFromWindows) + ',' +
                                                                   quotedstr(ComboBox1.Items.Strings[ComboBox1.ItemIndex]) + ',' +
                                                                   quotedstr('MAJOR') + ')' );

                                    ADOQuery1.ExecSQL;
                                    ADOQuery1.SQL.Clear;
                                    ADOQuery1.SQL.Add('SELECT * FROM Registration ORDER BY ID DESC');

                                    ADOQuery1.Open;


                                      if CheckBox3.Checked = True then
                                      begin
                                           Edit2.Clear;
                                           Edit3.Clear;
                                           Edit5.Clear;
                                           Edit2.SetFocus;
                                       end
                                      else
                                          begin
                                              Edit1.Clear;
                                              Edit2.Clear;
                                              Edit3.Clear;
                                              Edit5.Clear;
                                              Edit2.SetFocus;
                                          end;



                                    end;
                          end;

                end;

          // ������ � ��������

                if (Com_box = Pisma) then
                  begin
                        if Edit4.Text = '' then
                        begin
                             ShowMessage('������� � ���������');
                             Edit4.SetFocus;
                        end;

                        if Edit5.Text = '' then
                        begin
                              ShowMessage('������� �����-��� ���������');
                              Edit5.SetFocus;
                        end
                        else
                        if  (copy(Edit5.Text, 0, 2) = LA) or (copy(Edit5.Text, 0, 2) = LB) or
                            (copy(Edit5.Text, 0, 2) = LI) or (copy(Edit5.Text, 0, 2) = LD) or
                            (copy(Edit5.Text, 0, 2) = PB) or (copy(Edit5.Text, 0, 2) = LF) or
                            (copy(Edit5.Text, 0, 4) = LRU) or (copy(Edit5.Text, 0, 3) = WWW) then

                          begin
                                        ShowMessage('�� ��������� ������ �����-��� ����������������� ���������');
                                        Edit5.SetFocus;
                                        Edit5.SelectAll;
                           end
                        else
                               begin
                                    ADOQuery1.Close;

                                    ADOQuery1.SQL.Clear;
                                    ADOQuery1.SQL.ADD('SELECT [�� ���������] FROM Registration WHERE [�� ���������] = '+quotedstr(edit5.Text)+'');
                                    ADOQuery1.Open;

                                    if not ADOQuery1.Eof then
                                    begin

                                    ADOQuery1.Close;

                                    ADOQuery1.ExecSQL;

                                    ADOQuery1.SQL.Clear;
                                    ADOQuery1.SQL.Add('SELECT * FROM Registration ORDER BY ID DESC');
                                    ADOQuery1.Open;

                                    ShowMessage('����');


                                    end
                                    else
                                        begin


                                        ADOQuery1.Close;

                                        ADOQuery1.SQL.Add('INSERT INTO Registration ([�� ��������], [�� DHL], [�� �������], [�� �����������], [�� ���������], [��� ������������], [��� ��������], ������)');
                                        ADOQuery1.SQL.Add('VALUES (' + quotedstr(edit1.Text) + ',' +
                                                                       quotedstr(edit2.Text) + ',' +
                                                                       quotedstr(edit3.Text) + ',' +
                                                                       quotedstr(edit4.Text) + ',' +
                                                                       quotedstr(edit5.Text) + ',' +
                                                                       quotedstr(GetUserFromWindows) + ',' +
                                                                       quotedstr(ComboBox1.Items.Strings[ComboBox1.ItemIndex]) + ',' +
                                                                       quotedstr('������') + ')' );
                                        ADOQuery1.ExecSQL;
                                        ADOQuery1.SQL.Clear;
                                        ADOQuery1.SQL.Add('SELECT * FROM Registration ORDER BY ID DESC');

                                        ADOQuery1.Open;

                                        Edit4.Clear;
                                        Edit5.Clear;

                                        Edit4.SetFocus;
                                        end;
                               end;
                  end;


          // ������ � ��������

                if (Com_box = DHL_Koroba) then
                begin

                        if Edit2.Text = '' then
                        begin

                             ShowMessage('������� �����-��� DHL');
                             Edit2.SetFocus;

                        end;

                        if Edit4.Text = '' then
                        begin

                             ShowMessage('������� � ���������');
                             Edit4.SetFocus;

                        end;

                        if Edit5.Text = '' then
                        begin
                              ShowMessage('������� �����-��� ���������');
                              Edit5.SetFocus;
                        end
                        else
                        if  (copy(Edit5.Text, 0, 2) = LA) or (copy(Edit5.Text, 0, 2) = LB) or
                            (copy(Edit5.Text, 0, 2) = LI) or (copy(Edit5.Text, 0, 2) = LD) or
                            (copy(Edit5.Text, 0, 2) = PB) or (copy(Edit5.Text, 0, 2) = LF) or
                            (copy(Edit5.Text, 0, 4) = LRU) or (copy(Edit5.Text, 0, 3) = WWW) then

                          begin
                                        ShowMessage('�� ��������� ������ �����-��� ����������������� ���������');
                                        Edit5.SetFocus;
                                        Edit5.SelectAll;
                           end
                        else
                         begin
                              ADOQuery1.Close;

                              ADOQuery1.SQL.Clear;
                              ADOQuery1.SQL.ADD('SELECT [�� ���������] FROM Registration WHERE [�� ���������] = '+quotedstr(edit5.Text)+'');
                              ADOQuery1.Open;

                              if not ADOQuery1.Eof then
                              begin

                              ADOQuery1.Close;

                              ADOQuery1.ExecSQL;

                              ADOQuery1.SQL.Clear;
                              ADOQuery1.SQL.Add('SELECT * FROM Registration ORDER BY ID DESC');
                              ADOQuery1.Open;

                              ShowMessage('����');


                              end
                              else
                                  begin


                                  ADOQuery1.Close;

                                  ADOQuery1.SQL.Add('INSERT INTO Registration ([�� ��������], [�� DHL], [�� �������], [�� �����������], [�� ���������], [��� ������������], [��� ��������], ������)');
                                  ADOQuery1.SQL.Add('VALUES (' + quotedstr(edit1.Text) + ',' +
                                                                 quotedstr(edit2.Text) + ',' +
                                                                 quotedstr(edit3.Text) + ',' +
                                                                 quotedstr(edit4.Text) + ',' +
                                                                 quotedstr(edit5.Text) + ',' +
                                                                 quotedstr(GetUserFromWindows) + ',' +
                                                                 quotedstr(ComboBox1.Items.Strings[ComboBox1.ItemIndex]) + ',' +
                                                                 quotedstr('DHL') + ')' );
                                  ADOQuery1.ExecSQL;
                                  ADOQuery1.SQL.Clear;
                                  ADOQuery1.SQL.Add('SELECT * FROM Registration ORDER BY ID DESC');

                                  ADOQuery1.Open;

                                  Edit4.Clear;
                                  Edit5.Clear;

                                  Edit4.SetFocus;
                                 end;
                         end;
                end;

           //������ � KCE, Pony Express, ESP Express, PTK, Credit Consulting

                if   (Com_box_2 = KCE)  or (Com_box_2 = ESP_Express)   or
                     (Com_box_2 = Pony_Express) or (Com_box_2 = PTK)  or (Com_box_2 = Credit_Consulting) then
                  begin

                        if Edit1.Text = '' then
                        begin

                             ShowMessage('������� �����-��� ����������������� ������');
                             Edit1.SetFocus;
                        end;

                        if Edit4.Text = '' then
                        begin

                             ShowMessage('������� � ���������');
                             Edit4.SetFocus;
                        end;

                        if Edit5.Text = '' then
                        begin

                              ShowMessage('������� �����-��� ���������');
                              Edit5.SetFocus;
                        end
                        else
                        if  (copy(Edit5.Text, 0, 2) = LA) or (copy(Edit5.Text, 0, 2) = LB) or
                            (copy(Edit5.Text, 0, 2) = LI) or (copy(Edit5.Text, 0, 2) = LD) or
                            (copy(Edit5.Text, 0, 2) = PB) or (copy(Edit5.Text, 0, 2) = LF) or
                            (copy(Edit5.Text, 0, 4) = LRU) or (copy(Edit5.Text, 0, 3) = WWW) then

                          begin
                                        ShowMessage('�� ��������� ������ �����-��� ����������������� ���������');
                                        Edit5.SetFocus;
                                        Edit5.SelectAll;
                           end
                        else
                         begin
                            ADOQuery1.Close;

                            ADOQuery1.SQL.Clear;
                            ADOQuery1.SQL.ADD('SELECT [�� ���������] FROM Registration WHERE [�� ���������] = '+quotedstr(edit5.Text)+'');
                            ADOQuery1.Open;

                            if not ADOQuery1.Eof then
                            begin

                            ADOQuery1.Close;

                            ADOQuery1.ExecSQL;

                            ADOQuery1.SQL.Clear;
                            ADOQuery1.SQL.Add('SELECT * FROM Registration ORDER BY ID DESC');
                            ADOQuery1.Open;

                            ShowMessage('����');


                            end
                            else
                                begin
                                ADOQuery1.Close;
                                ADOQuery1.SQL.Add('INSERT INTO Registration ([�� ��������], [�� DHL], [�� �������], [�� �����������], [�� ���������], [��� ������������], [��� ��������], ������)');
                                ADOQuery1.SQL.Add('VALUES (' + quotedstr(edit1.Text) + ',' +
                                                               quotedstr(edit2.Text) + ',' +
                                                               quotedstr(edit3.Text) + ',' +
                                                               quotedstr(edit4.Text) + ',' +
                                                               quotedstr(edit5.Text) + ',' +
                                                               quotedstr(GetUserFromWindows) + ',' +
                                                               quotedstr(ComboBox1.Items.Strings[ComboBox1.ItemIndex]) + ',' +
                                                               quotedstr(ComboBox2.Items.Strings[ComboBox2.ItemIndex]) + ')' );
                                ADOQuery1.ExecSQL;
                                ADOQuery1.SQL.Clear;
                                ADOQuery1.SQL.Add('SELECT * FROM Registration ORDER BY ID DESC');

                                ADOQuery1.Open;

                                Edit1.Clear;
                                Edit4.Clear;
                                Edit5.Clear;

                                Edit1.SetFocus;
                                end;
                         end;

                  end;

                //������ � EMS

                if (Com_box_2 = EMS) then
                begin
                        if Edit1.Text = '' then
                        begin

                             ShowMessage('������� �����-��� ����������������� ������');
                             Edit1.SetFocus;
                        end;

                        if Edit4.Text = '' then
                        begin

                             ShowMessage('������� � ���������');
                             Edit4.SetFocus;
                        end;

                        if Edit5.Text = '' then
                        begin

                              ShowMessage('������� �����-��� ���������');
                              Edit5.SetFocus;
                        end
                        else
                        if  (copy(Edit5.Text, 0, 2) = LA) or (copy(Edit5.Text, 0, 2) = LB) or
                            (copy(Edit5.Text, 0, 2) = LI) or (copy(Edit5.Text, 0, 2) = LD) or
                            (copy(Edit5.Text, 0, 2) = PB) or (copy(Edit5.Text, 0, 2) = LF) or
                            (copy(Edit5.Text, 0, 4) = LRU) or (copy(Edit5.Text, 0, 3) = WWW) then

                          begin
                                        ShowMessage('�� ��������� ������ �����-��� ����������������� ���������');
                                        Edit5.SetFocus;
                                        Edit5.SelectAll;
                           end
                        else
                         begin
                            ADOQuery1.Close;

                            ADOQuery1.SQL.Clear;
                            ADOQuery1.SQL.ADD('SELECT [�� ���������] FROM Registration WHERE [�� ���������] = '+quotedstr(edit5.Text)+'');
                            ADOQuery1.Open;

                            if not ADOQuery1.Eof then
                            begin

                            ADOQuery1.Close;

                            ADOQuery1.ExecSQL;

                            ADOQuery1.SQL.Clear;
                            ADOQuery1.SQL.Add('SELECT * FROM Registration ORDER BY ID DESC');
                            ADOQuery1.Open;

                            ShowMessage('����');


                            end
                            else
                                begin
                                ADOQuery1.Close;

                                ADOQuery1.SQL.Add('INSERT INTO Registration ([�� ��������], [�� DHL], [�� �������], [�� �����������], [�� ���������], [��� ������������], [��� ��������], ������)');
                                ADOQuery1.SQL.Add('VALUES (' + quotedstr(edit1.Text) + ',' +
                                                               quotedstr(edit2.Text) + ',' +
                                                               quotedstr(edit3.Text) + ',' +
                                                               quotedstr(edit4.Text) + ',' +
                                                               quotedstr(edit5.Text) + ',' +
                                                               quotedstr(GetUserFromWindows) + ',' +
                                                               quotedstr(ComboBox1.Items.Strings[ComboBox1.ItemIndex]) + ',' +
                                                               quotedstr(ComboBox2.Items.Strings[ComboBox2.ItemIndex]) + ')' );
                                ADOQuery1.ExecSQL;
                                ADOQuery1.SQL.Clear;
                                ADOQuery1.SQL.Add('SELECT * FROM Registration ORDER BY ID DESC');

                                ADOQuery1.Open;

                                Edit1.Clear;
                                Edit3.Clear;
                                Edit4.Clear;
                                Edit5.Clear;

                                Edit1.SetFocus;
                                end;
                         end;

                end;


               //��������� ������ "���������" ��� �������, ���� �� ����� ������� �� "��������������" � � ���� � ���-�� ����� ��� ���-�� ����
                if (CheckBox1.Checked = False) and ((Edit5.Text = '') or (Edit5.Text <> '')) then
                  begin
                        button1.Visible := True;
                  end;


end;


//������ ������� ������
procedure TForm1.Button2Click(Sender: TObject);
    var
        buttonSelected : Integer;
        beta : integer;
begin
        beta := ADOQuery1.FieldByName('ID').Value ;
        buttonSelected := MessageDlg('�� �������, ��� ������ ������� ������ ID ='+ IntToStr(beta) +'?',mtCustom, mbOKCancel, 0);

            if buttonSelected = mrOK  then
              begin
                        DBGrid1.DataSource.DataSet.Delete;
              end;
           // else if buttonSelected = mrCancel then ShowMessage('���� ������ Cancel');



end;


//test
procedure TForm1.Button3Click(Sender: TObject);

begin
        Form3.ShowModal;
        Form3.Button1.Enabled := False;
        Form3.CheckBox1.Checked := False;
        Form3.Label1.Caption := '�� �������� �����:' +  '';
end;



//��������������
procedure TForm1.CheckBox1Click(Sender: TObject);

begin
          if (CheckBox1.Checked = True) and ((Edit5.Text <> '') or (Edit5.Text = '')) then
            begin
                  button1.Visible := False
            end

end;

//�� ���������
procedure TForm1.CheckBox2Click(Sender: TObject);
begin

        if (checkBox2.Checked = True) then
          begin
              Edit3.Enabled := False;
              Edit3.Text := '0';
              Edit4.SetFocus;
          end;


        if (Edit4.Text <> '') then
          begin
               Edit5.SetFocus;
          end;

        if checkBox2.Checked = False then
          begin
              Edit3.Enabled := True;
              Edit3.Clear;
              Edit3.SetFocus;
          end;

end;


//�������� �����-���
procedure TForm1.CheckBox3Click(Sender: TObject);
begin
        if checkBox3.Checked = True then
          begin
              Edit1.Enabled := False;
              Edit2.SetFocus
          end
        else
          begin
              Edit1.Enabled := True;
              Edit1.Clear;
          end;

end;

//���� ���������������� ����� ��� ������� ������ Enter ��� � ������� ������� �����-���.
procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
var
        DHL_Koroba, Com_box : string;
        EMS, KCE, Pony_Express, MAJOR, PTK, ESP_Express, Com_box_2, Credit_Consulting :string;
        LA,LB,LI,LD,LF,PB, LRU, st : string;
        MsgBox : HWND;
begin

         LRU:= '2LRU';
         LA:= 'LA';
         LB:= 'LB';
         LI:= 'LI';
         LD:= 'LD';
         PB:= 'PB';
         LF:= 'LF';

         DHL_Koroba := ComboBox1.Items[0];
         Com_box := ComboBox1.Items.Strings[ComboBox1.ItemIndex];

         ESP_Express  := Combobox2.Items[0];
         KCE := Combobox2.Items[1];
         MAJOR  := Combobox2.Items[2];
         EMS := Combobox2.Items[3];
         Pony_Express := Combobox2.Items[4];
         PTK   := Combobox2.Items[5];
         Credit_Consulting := Combobox2.Items[6];
         Com_box_2 := ComboBox2.Items.Strings[ComboBox2.ItemIndex];
         MsgBox := FindWindow('#32770', '��������� MsgBoxa');

         if   (Com_box_2 = KCE) and (Key = #13)               or
              (Com_box_2 = ESP_Express) and (Key = #13)       or
              (Com_box_2 = Pony_Express) and (Key = #13)      or
              (Com_box_2 = PTK) and (Key = #13)               or
              (Com_box_2 = Credit_Consulting) and (Key = #13) then
         begin
              key:=#0;
              Edit4.SetFocus;
         end;


         if (Com_box_2 = EMS) and (Key = #13) then
         begin
                key:=#0;

                if Edit4.Text = '' then
                begin
                      Edit4.SetFocus;
                end
                else if (CheckBox2.Checked = True) and (Edit4.Text <> '') then
                      begin
                            Edit5.SetFocus;
                      end
                      else begin
                                Edit3.SetFocus;
                           end;
         end;

          if  ((copy(Edit1.Text, 0, 2) = LA) and (Key = #13)) or ((copy(Edit1.Text, 0, 2) = LB) and (Key = #13)) or
              ((copy(Edit1.Text, 0, 2) = LI) and (Key = #13)) or ((copy(Edit1.Text, 0, 2) = LD) and (Key = #13)) or
              ((copy(Edit1.Text, 0, 2) = PB) and (Key = #13)) or ((copy(Edit1.Text, 0, 2) = LF) and (Key = #13)) or
              ((copy(Edit1.Text, 0, 4) = LRU) and (Key = #13)) then

          begin

                        key:=#0;

                     //   ShowMessage('�� ��������� ������ �����-��� ����������������� ���������');

                        Form3.Label1.Caption := '�� �������� �����:' + Edit1.Text;
                        Form3.ShowModal;
                        Form3.Button1.Enabled := False;
                        Form3.CheckBox1.Checked := False;

                        Edit1.SetFocus;
                        Edit1.SelectAll;

                        Edit2.Enabled := False;
                        Edit3.Enabled := False;
                        Edit4.Enabled := False;
                        Edit5.Enabled := False;
           end
           else if (Key = #13) then
                 begin
                       Edit2.Enabled := True;
                       Edit3.Enabled := True;
                       Edit4.Enabled := True;
                       Edit5.Enabled := True;

                       key:=#0;
                       Edit2.SetFocus;
                 end;

       if (Com_box = DHL_Koroba) and (Key = #13) then
         begin
               Edit2.SetFocus;
         end;

       if (key in
           ['/','*','-','~','`','!','"','@','#','�',
            ';','$','%',':','^','?','&','(',')','_','=','\','.',
            ',','<','>',':','''','{','}','[',']','|'] ) then
       begin
                     st:= key;

                        ShowMessage('�� ��������� ������ �����-��� ����������������� ���������, �� ����� ���� ' + st);
                        key:=#0;
                        Edit1.SetFocus;
                        Edit1.SelectAll;

       end;


end;



procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
var
        LA,LB,LI,LD,LF,PB,LRU, st : string;
begin
        LRU:= '2LRU';
        LA:= 'LA';
        LB:= 'LB';
        LI:= 'LI';
        LD:= 'LD';
        PB:= 'PB';
        LF:= 'LF';

         if  ((copy(Edit2.Text, 0, 2) = LA) and (Key = #13)) or ((copy(Edit2.Text, 0, 2) = LB) and (Key = #13)) or
             ((copy(Edit2.Text, 0, 2) = LI) and (Key = #13)) or ((copy(Edit2.Text, 0, 2) = LD) and (Key = #13)) or
             ((copy(Edit2.Text, 0, 2) = PB) and (Key = #13)) or ((copy(Edit2.Text, 0, 2) = LF) and (Key = #13)) or
             ((copy(Edit2.Text, 0, 4) = LRU) and (Key = #13)) then

          begin

                        key:=#0;

                      //  ShowMessage('�� ��������� ������ �����-��� ����������������� ���������');
                      //  Edit2.SetFocus;
                      //  Edit2.SelectAll;

                        Form3.Label1.Caption := '�� �������� �����:' + Edit2.Text;
                        Form3.ShowModal;
                        Form3.Button1.Enabled := False;
                        Form3.CheckBox1.Checked := False;

                        Edit2.SetFocus;
                        Edit2.SelectAll;

                        Edit1.Enabled := False;
                        Edit3.Enabled := False;
                        Edit4.Enabled := False;
                        Edit5.Enabled := False;

           end
           else if Key = #13 then
                 begin

                      Edit1.Enabled := True;
                      Edit3.Enabled := True;
                      Edit4.Enabled := True;
                      Edit5.Enabled := True;

                      key:=#0;
                      Edit3.SetFocus;
                 end;

       if (key in
           ['/','*','-','~','`','!','"','@','#','�',
            ';','$','%',':','^','?','&','(',')','_','=','\','.',
            ',','<','>',':','''','{','}','[',']','|'] ) then
       begin
                        st:= key;

                        ShowMessage('�� ��������� ������ �����-��� ����������������� ���������, �� ����� ���� ' + st);
                        key:=#0;
                        Edit2.SetFocus;
                        Edit2.SelectAll;

       end;

        if (Key = #13) and (Edit4.Text = '') then
              begin
                key:=#0;
                Edit4.SetFocus;
              end;

        if (Key = #13) and (checkBox2.Checked = True) then
              begin
                key:=#0;
                Edit5.SetFocus;
              end;

        if Key = #13 then
         begin
              key:=#0;
              Edit3.SetFocus;
         end;
end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
var
        LA,LB,LI,LD,LF,PB,LRU, st : string;
begin
        LRU:= '2LRU';
        LA:= 'LA';
        LB:= 'LB';
        LI:= 'LI';
        LD:= 'LD';
        PB:= 'PB';
        LF:= 'LF';

        if  ((copy(Edit3.Text, 0, 2) = LA) and (Key = #13)) or ((copy(Edit3.Text, 0, 2) = LB) and (Key = #13)) or
            ((copy(Edit3.Text, 0, 2) = LI) and (Key = #13)) or ((copy(Edit3.Text, 0, 2) = LD) and (Key = #13)) or
            ((copy(Edit3.Text, 0, 2) = PB) and (Key = #13)) or ((copy(Edit3.Text, 0, 2) = LF) and (Key = #13)) or
            ((copy(Edit3.Text, 0, 4) = LRU) and (Key = #13)) then

          begin

                        key:=#0;
                        ShowMessage('�� ��������� ������ �����-��� ����������������� ���������');
                        Edit3.SetFocus;
                        Edit3.SelectAll;

           end
           else if (Edit4.Text <> '') and (Key = #13) then
                begin
                     key:=#0;
                     Edit5.SetFocus;
                end
                else  if Key = #13 then
                       begin
                            key:=#0;
                            Edit4.SetFocus;
                       end;

       if (key in
           ['/','*','-','~','`','!','"','@','#','�',
            ';','$','%',':','^','?','&','(',')','_','=','\','.',
            ',','<','>',':','''','{','}','[',']','|'] ) then
       begin
                     st:= key;

                        ShowMessage('�� ��������� ������ �����-��� ����������������� ���������, �� ����� ���� ' + st);
                        key:=#0;
                        Edit3.SetFocus;
                        Edit3.SelectAll;

       end;

end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
var
        LA,LB,LI,LD,LF,PB,LRU, st : string;
begin
        LRU:= '2LRU';
        LA:= 'LA';
        LB:= 'LB';
        LI:= 'LI';
        LD:= 'LD';
        PB:= 'PB';
        LF:= 'LF';

          if  (((copy(Edit4.Text, 0, 2) <> LA) and (Key = #13)) and ((copy(Edit4.Text, 0, 2) <> LB) and (Key = #13)) and
              ((copy(Edit4.Text, 0, 2) <> LI) and (Key = #13)) and ((copy(Edit4.Text, 0, 2) <> LD) and (Key = #13)) and
              ((copy(Edit4.Text, 0, 2) <> PB) and (Key = #13)) and ((copy(Edit4.Text, 0, 2) <> LF) and (Key = #13))) or
              ((copy(Edit4.Text, 0, 4) = LRU) and (Key = #13)) then

          begin
                        ShowMessage('�� ��������� ������ �����-��� � �����������');
                        key:=#0;
                        Edit4.SetFocus;
                        Edit4.SelectAll;

           end
           else if Key = #13 then
                 begin
                      key:=#0;
                      Edit5.SetFocus;
                 end;

       if (key in
           ['/','*','-','~','`','!','"','@','#','�',
            ';','$','%',':','^','?','&','(',')','_','=','\','.',
            ',','<','>',':','''','{','}','[',']','|'] ) then
       begin
                        st:= key;

                        ShowMessage('�� ��������� ������ �����-��� ����������������� ���������, �� ����� ���� ' + st);
                        key:=#0;
                        Edit4.SetFocus;
                        Edit4.SelectAll;

       end;

         if Key = #13 then
         begin
              key:=#0;
              Edit5.SetFocus;
         end;

end;


procedure TForm1.Edit5KeyPress(Sender: TObject; var Key: Char);
          var Com_box_2, EMS, KCE, Pony_Express, MAJOR, PTK, ESP_Express, Credit_Consulting :string;
              Com_box, Pisma, Kur_slujba, DHL_Paket, DHL_Koroba :string;
              WWW,st, LA,LB,LI,LD,LF,PB,LRU : string;
              i:integer;
begin
          LA:= 'LA';
          LB:= 'LB';
          LI:= 'LI';
          LD:= 'LD';
          PB:= 'PB';
          LF:= 'LF';
          LRU:= '2LRU';
          WWW:= 'WWW';

          DHL_Koroba := ComboBox1.Items[0];
          DHL_Paket := ComboBox1.Items[1];
          Kur_slujba := ComboBox1.Items[2];
          Pisma := ComboBox1.Items[3];
          Com_box := ComboBox1.Items.Strings[ComboBox1.ItemIndex];

          ESP_Express  := Combobox2.Items[0];
          KCE := Combobox2.Items[1];
          MAJOR  := Combobox2.Items[2];
          EMS := Combobox2.Items[3];
          Pony_Express := Combobox2.Items[4];
          PTK   := Combobox2.Items[5];
          Credit_Consulting := Combobox2.Items[6];
          Com_box_2 := ComboBox2.Items.Strings[ComboBox2.ItemIndex];
          LoadKeyboardLayout('00000409', KLF_ACTIVATE);


      if (CheckBox1.Checked = False) and ((Edit5.Text = '') or (Edit5.Text <> '')) then
       begin
              button1.Visible := True;
       end;




      //�������� ���� "� ���������" -------------------------------------------------------------------------------------
      if     ((Com_box = DHL_Paket) and (Key = #13))
          or ((Com_box_2 = MAJOR) and (Key = #13))
          or ((Com_box = DHL_Koroba) and (Key = #13)) then
      begin

          if Edit2.Text = '' then
          begin
               key:=#0;
               ShowMessage('������� �����-��� DHL');
               Edit2.SetFocus;

          end
          else  if Edit4.Text = '' then
                begin
                     key:=#0;
                     ShowMessage('������� � �����������');
                     Edit4.SetFocus;

                end
                else  if Edit5.Text = '' then
                      begin
                            key:=#0;
                            ShowMessage('������� � ���������');
                      end;




      end;

      if   ((Com_box = Pisma) and (Key = #13)) then
       begin
             if Edit4.Text = '' then
              begin
                   key:=#0;
                   ShowMessage('������� � ���������');
              end
              else if Edit5.Text = '' then
                    begin
                          key:=#0;
                          ShowMessage('������� �����-��� ���������');
                    end;

       end;

       if  ((Com_box = Kur_slujba) and (Com_box_2 = KCE) and (Key = #13))               or
           ((Com_box = Kur_slujba) and (Com_box_2 = ESP_Express) and (Key = #13))       or
           ((Com_box = Kur_slujba) and (Com_box_2 = Pony_Express) and (Key = #13))      or
           ((Com_box = Kur_slujba) and (Com_box_2 = PTK) and (Key = #13))               or
           ((Com_box = Kur_slujba) and (Com_box_2 = EMS) and (Key = #13))               or
           ((Com_box = Kur_slujba) and (Com_box_2 = Credit_Consulting) and (Key = #13)) then
       begin
          if Edit1.Text = '' then
          begin
               key:=#0;
               ShowMessage('������� �����-��� DHL');
               Edit1.SetFocus;

          end
          else  if Edit4.Text = '' then
                begin
                     key:=#0;
                     ShowMessage('������� � �����������');
                     Edit4.SetFocus;

                end
                else  if Edit5.Text = '' then
                      begin
                            key:=#0;
                            ShowMessage('������� � ���������');
                      end;


       end;

        if  (((copy(Edit5.Text, 0, 2) = LA) and (Key = #13)) or ((copy(Edit5.Text, 0, 2) = LB) and (Key = #13))   or
            ((copy(Edit5.Text, 0, 2) = LI) and (Key = #13))  or ((copy(Edit5.Text, 0, 2) = LD) and (Key = #13))   or
            ((copy(Edit5.Text, 0, 2) = PB) and (Key = #13))  or ((copy(Edit5.Text, 0, 2) = LF) and (Key = #13)))  or
            ((copy(Edit5.Text, 0, 4) = LRU) and (Key = #13)) or ((copy(Edit5.Text, 0, 3) = WWW) and (Key = #13))  or
            ((Length(Edit5.Text) < 6) and (Key = #13)) then

          begin

                        key:=#0;
                        ShowMessage('�� ��������� ������ �����-��� ����������������� ���������');
                        Edit5.SetFocus;
                        Edit5.SelectAll;

           end;

       if (key in
           ['/','*','-','~','`','!','"','@','#','�',
            ';','$','%',':','^','?','&','(',')','_','=','\','.',
            ',','<','>',':','''','{','}','[',']','|'] ) then
       begin
                     st:= key;

                        ShowMessage('�� ��������� ������ �����-��� ����������������� ���������, �� ����� ���� ' + st);
                        key:=#0;
                        Edit5.SetFocus;
                        Edit5.SelectAll;

       end;

    //------------------------------------------------------------------------------------------------------------------
   if (CheckBox1.Checked = True) then
   begin
      //���� ������ � ���� -----------------------------------------------------------------------------------------------
                if (Com_box = DHL_Paket) and (Key = #13) then
                  begin


                                ADOQuery1.Close;
                                ADOQuery1.SQL.Clear;
                                ADOQuery1.SQL.ADD('SELECT [�� ���������] FROM Registration WHERE [�� ���������] = '+quotedstr(edit5.Text)+'');

                                ADOQuery1.Open;

                                if not ADOQuery1.Eof then
                                begin

                                      ADOQuery1.Close;

                                      ADOQuery1.ExecSQL;

                                      ADOQuery1.SQL.Clear;
                                      ADOQuery1.SQL.Add('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');
                                      ADOQuery1.Open;

                                      ShowMessage('����');


                                end
                                else
                                begin




                                 ADOQuery1.Close;




                                ADOQuery1.SQL.Add('INSERT INTO Registration ([�� ��������], [�� DHL], [�� �������], [�� �����������], [�� ���������], [��� ������������], [��� ��������], ������)');
                                ADOQuery1.SQL.Add('VALUES (' + quotedstr(edit1.Text) + ',' +
                                                               quotedstr(edit2.Text) + ',' +
                                                               quotedstr(edit3.Text) + ',' +
                                                               quotedstr(edit4.Text) + ',' +
                                                               quotedstr(edit5.Text) + ',' +
                                                               quotedstr(GetUserFromWindows) + ',' +
                                                               quotedstr(ComboBox1.Items.Strings[ComboBox1.ItemIndex]) + ',' +
                                                               quotedstr('DHL') + ')' );

                                ADOQuery1.ExecSQL;
                                ADOQuery1.SQL.Clear;
                                ADOQuery1.SQL.Add('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');

                                ADOQuery1.Open;


                                  if CheckBox3.Checked = True then
                                  begin
                                       Edit2.Clear;
                                       Edit3.Clear;
                                       Edit5.Clear;
                                       Edit2.SetFocus;
                                   end
                                  else
                                      begin
                                          Edit1.Clear;
                                          Edit2.Clear;
                                          Edit3.Clear;
                                          Edit5.Clear;
                                          Edit2.SetFocus;
                                      end;



                                end;

                               Key := #0;

                  end;

// ������ � MAJOR
                if (Com_box_2 = MAJOR) and (Key = #13) then
                begin


                                ADOQuery1.Close;
                                ADOQuery1.SQL.Clear;
                                ADOQuery1.SQL.ADD('SELECT [�� ���������] FROM Registration WHERE [�� ���������] = '+quotedstr(edit5.Text)+'');

                                ADOQuery1.Open;

                                if not ADOQuery1.Eof then
                                begin

                                      ADOQuery1.Close;

                                      ADOQuery1.ExecSQL;

                                      ADOQuery1.SQL.Clear;
                                      ADOQuery1.SQL.Add('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');
                                      ADOQuery1.Open;

                                      ShowMessage('����');


                                end
                                else
                                begin




                                 ADOQuery1.Close;




                                ADOQuery1.SQL.Add('INSERT INTO Registration ([�� ��������], [�� DHL], [�� �������], [�� �����������], [�� ���������], [��� ������������], [��� ��������], ������)');
                                ADOQuery1.SQL.Add('VALUES (' + quotedstr(edit1.Text) + ',' +
                                                               quotedstr(edit2.Text) + ',' +
                                                               quotedstr(edit3.Text) + ',' +
                                                               quotedstr(edit4.Text) + ',' +
                                                               quotedstr(edit5.Text) + ',' +
                                                               quotedstr(GetUserFromWindows) + ',' +
                                                               quotedstr(ComboBox1.Items.Strings[ComboBox1.ItemIndex]) + ',' +
                                                               quotedstr('MAJOR') + ')' );

                                ADOQuery1.ExecSQL;
                                ADOQuery1.SQL.Clear;
                                ADOQuery1.SQL.Add('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');

                                ADOQuery1.Open;


                                  if CheckBox3.Checked = True then
                                  begin
                                       Edit2.Clear;
                                       Edit3.Clear;
                                       Edit5.Clear;
                                       Edit2.SetFocus;
                                   end
                                  else
                                      begin
                                          Edit1.Clear;
                                          Edit2.Clear;
                                          Edit3.Clear;
                                          Edit5.Clear;
                                          Edit2.SetFocus;
                                      end;



                                end;

                                key:=#0;

                end;
// ������ � ��������
                if (Com_box = Pisma) and (Key = #13) then
                  begin


                        ADOQuery1.Close;

                        ADOQuery1.SQL.Clear;
                        ADOQuery1.SQL.ADD('SELECT [�� ���������] FROM Registration WHERE [�� ���������] = '+quotedstr(edit5.Text)+'');
                        ADOQuery1.Open;

                        if not ADOQuery1.Eof then
                        begin

                        ADOQuery1.Close;

                        ADOQuery1.ExecSQL;

                        ADOQuery1.SQL.Clear;
                        ADOQuery1.SQL.Add('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');
                        ADOQuery1.Open;

                        ShowMessage('����');


                        end
                        else
                            begin


                            ADOQuery1.Close;

                            ADOQuery1.SQL.Add('INSERT INTO Registration ([�� ��������], [�� DHL], [�� �������], [�� �����������], [�� ���������], [��� ������������], [��� ��������], ������)');
                            ADOQuery1.SQL.Add('VALUES (' + quotedstr(edit1.Text) + ',' +
                                                           quotedstr(edit2.Text) + ',' +
                                                           quotedstr(edit3.Text) + ',' +
                                                           quotedstr(edit4.Text) + ',' +
                                                           quotedstr(edit5.Text) + ',' +
                                                           quotedstr(GetUserFromWindows) + ',' +
                                                           quotedstr(ComboBox1.Items.Strings[ComboBox1.ItemIndex]) + ',' +
                                                           quotedstr('������') + ')' );
                            ADOQuery1.ExecSQL;
                            ADOQuery1.SQL.Clear;
                            ADOQuery1.SQL.Add('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');

                            ADOQuery1.Open;

                            Edit4.Clear;
                            Edit5.Clear;

                            Edit4.SetFocus;
                            end;

                            key:=#0;
                  end;
// ������ � ��������
                if (Com_box = DHL_Koroba) and (Key = #13) then
                begin
                        key:=#0;


                        ADOQuery1.Close;

                        ADOQuery1.SQL.Clear;
                        ADOQuery1.SQL.ADD('SELECT [�� ���������] FROM Registration WHERE [�� ���������] = '+quotedstr(edit5.Text)+'');
                        ADOQuery1.Open;
                                      //   SELECT Rasshivka.[����������� ��������], Registration.[�� �����������] FROM Rasshivka, Registration WHERE Rasshivka.[����������� ��������] = Registration.[�� �����������] ;
                        if not ADOQuery1.Eof then
                        begin

                        ADOQuery1.Close;

                        ADOQuery1.ExecSQL;

                        ADOQuery1.SQL.Clear;
                        ADOQuery1.SQL.Add('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');
                        ADOQuery1.Open;

                        ShowMessage('����');


                        end
                        else
                            begin


                            ADOQuery1.Close;

                            ADOQuery1.SQL.Add('INSERT INTO Registration ([�� ��������], [�� DHL], [�� �������], [�� �����������], [�� ���������], [��� ������������], [��� ��������], ������)');
                            ADOQuery1.SQL.Add('VALUES (' + quotedstr(edit1.Text) + ',' +
                                                           quotedstr(edit2.Text) + ',' +
                                                           quotedstr(edit3.Text) + ',' +
                                                           quotedstr(edit4.Text) + ',' +
                                                           quotedstr(edit5.Text) + ',' +
                                                           quotedstr(GetUserFromWindows) + ',' +
                                                           quotedstr(ComboBox1.Items.Strings[ComboBox1.ItemIndex]) + ',' +
                                                           quotedstr('DHL') + ')' );
                            ADOQuery1.ExecSQL;
                            ADOQuery1.SQL.Clear;
                            ADOQuery1.SQL.Add('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');

                            ADOQuery1.Open;

                            Edit4.Clear;
                            Edit5.Clear;

                            Edit4.SetFocus;
                            end;
                end;


                if   (Com_box_2 = KCE) and (Key = #13)         or
                     (Com_box_2 = ESP_Express) and (Key = #13)  or
                     (Com_box_2 = Pony_Express) and (Key = #13) or
                     (Com_box_2 = PTK) and (Key = #13)  or
                     (Com_box_2 = Credit_Consulting) and (Key = #13) then
                  begin

                        key:=#0;

                        ADOQuery1.Close;

                        ADOQuery1.SQL.Clear;
                        ADOQuery1.SQL.ADD('SELECT [�� ���������] FROM Registration WHERE [�� ���������] = '+quotedstr(edit5.Text)+'');
                        ADOQuery1.Open;

                        if not ADOQuery1.Eof then
                        begin

                        ADOQuery1.Close;

                        ADOQuery1.ExecSQL;

                        ADOQuery1.SQL.Clear;
                        ADOQuery1.SQL.Add('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');
                        ADOQuery1.Open;

                        ShowMessage('����');


                        end
                        else
                            begin
                            ADOQuery1.Close;

                            ADOQuery1.SQL.Add('INSERT INTO Registration ([�� ��������], [�� DHL], [�� �������], [�� �����������], [�� ���������], [��� ������������], [��� ��������], ������)');
                            ADOQuery1.SQL.Add('VALUES (' + quotedstr(edit1.Text) + ',' +
                                                           quotedstr(edit2.Text) + ',' +
                                                           quotedstr(edit3.Text) + ',' +
                                                           quotedstr(edit4.Text) + ',' +
                                                           quotedstr(edit5.Text) + ',' +
                                                           quotedstr(GetUserFromWindows) + ',' +
                                                           quotedstr(ComboBox1.Items.Strings[ComboBox1.ItemIndex]) + ',' +
                                                           quotedstr(ComboBox2.Items.Strings[ComboBox2.ItemIndex]) + ')' );
                            ADOQuery1.ExecSQL;
                            ADOQuery1.SQL.Clear;
                            ADOQuery1.SQL.Add('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');

                            ADOQuery1.Open;

                            Edit1.Clear;
                            Edit5.Clear;

                            Edit1.SetFocus;
                            end;

                  end;

                if (Com_box_2 = EMS) and (Key = #13) then
                begin
                        key:=#0;
                        ADOQuery1.Close;

                        ADOQuery1.SQL.Clear;
                        ADOQuery1.SQL.ADD('SELECT [�� ���������] FROM Registration WHERE [�� ���������] = '+quotedstr(edit5.Text)+'');
                        ADOQuery1.Open;

                        if not ADOQuery1.Eof then
                        begin

                        ADOQuery1.Close;

                        ADOQuery1.ExecSQL;

                        ADOQuery1.SQL.Clear;
                        ADOQuery1.SQL.Add('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');
                        ADOQuery1.Open;

                        ShowMessage('����');


                        end
                        else
                            begin
                            ADOQuery1.Close;

                            ADOQuery1.SQL.Add('INSERT INTO Registration ([�� ��������], [�� DHL], [�� �������], [�� �����������], [�� ���������], [��� ������������], [��� ��������], ������)');
                            ADOQuery1.SQL.Add('VALUES (' + quotedstr(edit1.Text) + ',' +
                                                           quotedstr(edit2.Text) + ',' +
                                                           quotedstr(edit3.Text) + ',' +
                                                           quotedstr(edit4.Text) + ',' +
                                                           quotedstr(edit5.Text) + ',' +
                                                           quotedstr(GetUserFromWindows) + ',' +
                                                           quotedstr(ComboBox1.Items.Strings[ComboBox1.ItemIndex]) + ',' +
                                                           quotedstr(ComboBox2.Items.Strings[ComboBox2.ItemIndex]) + ')' );
                            ADOQuery1.ExecSQL;
                            ADOQuery1.SQL.Clear;
                            ADOQuery1.SQL.Add('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');

                            ADOQuery1.Open;


                            Edit1.Clear;
                            Edit3.Clear;
                            Edit5.Clear;

                            Edit1.SetFocus;

                            end;

                end;
//------------------------------------------------------------------------------------------------------------------


   end;


end;

procedure TForm1.ComboBox1Click(Sender: TObject);
          var Com_box, Pisma, Kur_slujba, DHL_Paket, DHL_Koroba :string;
              EMS, KCE, Pony_Express, MAJOR, PTK, ESP_Express, Com_box_2, Credit_Consulting :string;
begin
          //ComboBox1 = DHL ������, DHL ������, ���������� ������, ������.
          DHL_Koroba := ComboBox1.Items[0];
          DHL_Paket := ComboBox1.Items[1];
          Kur_slujba := ComboBox1.Items[2];
          Pisma := ComboBox1.Items[3];
          Com_box := ComboBox1.Items.Strings[ComboBox1.ItemIndex];

          //ComboBox2 = ESPR Express, KCE, MAJOR, EMS, Pony Express, PTK.
          ESP_Express  := Combobox2.Items[0];
          KCE := Combobox2.Items[1];
          MAJOR  := Combobox2.Items[2];
          EMS := Combobox2.Items[3];
          Pony_Express := Combobox2.Items[4];
          PTK   := Combobox2.Items[5];
          Credit_Consulting := Combobox2.Items[6];
          Com_box_2 := ComboBox2.Items.Strings[ComboBox2.ItemIndex];

          if Com_box = DHL_Koroba then
            begin

              Edit1.Clear;
              Edit2.Clear;
              Edit3.Clear;
              Edit4.Clear;
              Edit5.Clear;

              Edit1.Visible := True;
              Edit2.Visible := True;
              Edit3.Visible := True;
              Edit4.Visible := True;
              Edit5.Visible := True;

              Label2.Visible := True;
              Label3.Visible := True;
              Label4.Visible := True;
              Label5.Visible := True;
              Label6.Visible := True;

              ComboBox2.Visible := False;

              CheckBox2.Checked := False;
              CheckBox3.Checked := False;

              CheckBox2.Visible := False;
              CheckBox3.Visible := False;
            end;

          if Com_box = DHL_Paket then
            begin

              Edit1.Clear;
              Edit2.Clear;
              Edit3.Clear;
              Edit4.Clear;
              Edit5.Clear;

              Edit1.Visible := True;
              Edit2.Visible := True;
              Edit3.Visible := True;
              Edit4.Visible := True;
              Edit5.Visible := True;

              Label2.Visible := True;
              Label3.Visible := True;
              Label4.Visible := True;
              Label5.Visible := True;
              Label6.Visible := True;

              ComboBox2.Visible := False;

              CheckBox2.Checked := False;
              CheckBox3.Checked := False;

              CheckBox2.Visible := True;
              CheckBox3.Visible := True;

            end;

          if Com_box = Kur_slujba then
            begin

              Edit1.Clear;
              Edit2.Clear;
              Edit3.Clear;
              Edit4.Clear;
              Edit5.Clear;

             // ComboBox2.ItemIndex := -1;
              ComboBox2.Visible := True;

              Edit1.Visible := False;
              Edit2.Visible := False;
              Edit3.Visible := False;
              Edit4.Visible := False;
              Edit5.Visible := False;

              Label2.Visible := False;
              Label3.Visible := False;
              Label4.Visible := False;
              Label5.Visible := False;
              Label6.Visible := False;

              CheckBox2.Visible := False;
              CheckBox3.Visible := False;

              CheckBox2.Checked := False;
              CheckBox3.Checked := False;

              if Com_box_2 = EMS then
               begin
                Edit1.Clear;
                Edit2.Clear;
                Edit3.Clear;
                Edit4.Clear;
                Edit5.Clear;

                CheckBox2.Visible := True;
                CheckBox3.Visible := False;

                Label2.Visible := True;
                Label3.Visible := False;
                Label4.Visible := True;
                Label5.Visible := True;
                Label6.Visible := True;

                Edit1.Visible := True;
                Edit2.Visible := False;
                Edit3.Visible := True;
                Edit4.Visible := True;
                Edit5.Visible := True;
               end;

               if (Com_box_2 = KCE) or (Com_box_2 = ESP_Express) or
                  (Com_box_2 = Pony_Express) or (Com_box_2 = PTK) or
                  (Com_box_2 = Credit_Consulting) then
                begin

                  Edit1.Clear;
                  Edit2.Clear;
                  Edit3.Clear;
                  Edit4.Clear;
                  Edit5.Clear;

                  Edit1.Visible := True;
                  Edit2.Visible := False;
                  Edit3.Visible := False;
                  Edit4.Visible := True;
                  Edit5.Visible := True;

                  Label2.Visible := True;
                  Label3.Visible := False;
                  Label4.Visible := False;
                  Label5.Visible := True;
                  Label6.Visible := True;

                  CheckBox2.Visible := False;
                  CheckBox3.Visible := False;
                end;

               if Com_box_2 = MAJOR then
                 begin
                   Edit1.Clear;
                   Edit2.Clear;
                   Edit3.Clear;
                   Edit4.Clear;
                   Edit5.Clear;

                   CheckBox2.Visible := True;
                   CheckBox3.Visible := True;

                   Label2.Visible := True;
                   Label3.Visible := True;
                   Label4.Visible := True;
                   Label5.Visible := True;
                   Label6.Visible := True;

                   Edit1.Visible := True;
                   Edit2.Visible := True;
                   Edit3.Visible := True;
                   Edit4.Visible := True;
                   Edit5.Visible := True;
                 end;


            end;

          if Com_box = Pisma then
            begin

              Edit1.Clear;
              Edit2.Clear;
              Edit3.Clear;
              Edit4.Clear;
              Edit5.Clear;

              ComboBox2.Visible := False;

              Edit1.Visible := False;
              Edit2.Visible := False;
              Edit3.Visible := False;
              Edit4.Visible := True;
              Edit5.Visible := True;

              Label2.Visible := False;
              Label3.Visible := False;
              Label4.Visible := False;
              Label5.Visible := True;
              Label6.Visible := True;

              CheckBox2.Checked := False;
              CheckBox3.Checked := False;

              CheckBox2.Visible := False;
              CheckBox3.Visible := False;
            end;

end;

procedure TForm1.ComboBox2Click(Sender: TObject);

          var EMS, KCE, Pony_Express, MAJOR, PTK, ESP_Express, Com_box_2, Credit_Consulting :string;
begin

          ESP_Express  := Combobox2.Items[0];
          KCE := Combobox2.Items[1];
          MAJOR  := Combobox2.Items[2];
          EMS := Combobox2.Items[3];
          Pony_Express := Combobox2.Items[4];
          PTK   := Combobox2.Items[5];
          Credit_Consulting := Combobox2.Items[6];
          Com_box_2 := ComboBox2.Items.Strings[ComboBox2.ItemIndex];



          if   Com_box_2 = EMS then

              begin

                Edit1.Clear;
                Edit2.Clear;
                Edit3.Clear;
                Edit4.Clear;
                Edit5.Clear;

                CheckBox2.Visible := True;
                CheckBox3.Visible := False;

                Label2.Visible := True;
                Label3.Visible := False;
                Label4.Visible := True;
                Label5.Visible := True;
                Label6.Visible := True;

                Edit1.Visible := True;
                Edit2.Visible := False;
                Edit3.Visible := True;
                Edit4.Visible := True;
                Edit5.Visible := True;

                CheckBox2.Checked := False;
                CheckBox3.Checked := False;

              end;

          if (Com_box_2 = KCE) or (Com_box_2 = ESP_Express) or
             (Com_box_2 = Pony_Express) or (Com_box_2 = PTK) or (Com_box_2 = Credit_Consulting) then
              begin

                Edit1.Clear;
                Edit2.Clear;
                Edit3.Clear;
                Edit4.Clear;
                Edit5.Clear;

                Edit1.Visible := True;
                Edit2.Visible := False;
                Edit3.Visible := False;
                Edit4.Visible := True;
                Edit5.Visible := True;

                Label2.Visible := True;
                Label3.Visible := False;
                Label4.Visible := False;
                Label5.Visible := True;
                Label6.Visible := True;

                CheckBox2.Checked := False;
                CheckBox3.Checked := False;

                CheckBox2.Visible := False;
                CheckBox3.Visible := False;
              end;

          if Com_box_2 = MAJOR then
            begin
                Edit1.Clear;
                Edit2.Clear;
                Edit3.Clear;
                Edit4.Clear;
                Edit5.Clear;

                CheckBox2.Visible := True;
                CheckBox3.Visible := True;

                Label2.Visible := True;
                Label3.Visible := True;
                Label4.Visible := True;
                Label5.Visible := True;
                Label6.Visible := True;

                CheckBox2.Checked := False;
                CheckBox3.Checked := False;

                Edit1.Visible := True;
                Edit2.Visible := True;
                Edit3.Visible := True;
                Edit4.Visible := True;
                Edit5.Visible := True;
            end;
end;



procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
          Button2.Visible := True;
end;

procedure TForm1.DBGrid1Enter(Sender: TObject);
begin


          if DBGrid1.DataSource.State = dsEdit then
          begin
            DBGrid1.DataSource.DataSet.Post;
            DBGrid1.EditorMode:=False;
          end;

end;

//�� �������� ��������� ��� �������� ����� � ������� DBGrid � ���������
procedure TForm1.DBGrid1KeyPress(Sender: TObject; var Key: Char);
var
        Check_Index, ID, pos : integer;
        s,t: string;
begin
        if (Key = #13) then
        begin
          if DBGrid1.DataSource.State in [dsEdit] then
          begin

            Key := #0;

           // DBGrid1.DataSource.DataSet.Post;
           // DBGrid1.EditorMode:=False;



                Check_Index :=  DBGrid1.SelectedIndex;

                if (Check_Index = 5) OR (Check_Index = 2) then
                begin

                  t  := DBGrid1.Fields[2].AsString;        //���������� �� DHL
                  s  := DBGrid1.Fields[5].AsString;          //���������� �� ���������
                  ID := ADOQuery1.FieldByName('ID').Value; //����� ID ����������

                  pos:= ADOQuery1.RecNo;


                  ADOQuery1.Close;
                  ADOQuery1.SQL.Text := 'SELECT [�� DHL], [�� ���������] FROM Registration WHERE [�� DHL] = :prm AND [�� ���������] = :p ';

                  ADOQuery1.Parameters.ParamByName('prm').Value := t;  //���������� �������� [�� DHL]
                  ADOQuery1.Parameters.ParamByName('p').Value := s;    //���������� �������� [�� ���������]
                  ADOQuery1.Open;

                  if ADOQuery1.IsEmpty  then
                  begin
                        ADOQuery1.Close;

                        ADOQuery1.SQL.Add('UPDATE Registration SET [�� DHL] = ' + t + ', [�� ���������] =' + s + 'WHERE ID = ' + IntToStr(ID) );

                        ADOQuery1.ExecSQL;
                        ADOQuery1.SQL.Clear;
                        ADOQuery1.SQL.Add('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');

                        ADOQuery1.Open;

                        DBGrid1.EditorMode := False;
                        ADOQuery1.RecNo := pos;
                  end
                  else
                      begin
                            ADOQuery1.Close;

                            ADOQuery1.SQL.Clear;
                            ADOQuery1.SQL.Add('SELECT * FROM RegistrationWHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ ' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0 ORDER BY ID DESC');
                            ADOQuery1.Open;

                            ShowMessage('���� �����');

                            DBGrid1.EditorMode := False;
                            ADOQuery1.RecNo := pos;
                      end;
                end
                else
                    begin
                          DBGrid1.DataSource.DataSet.Post;
                          DBGrid1.EditorMode := False;
                    end;


          end;



         end;


end;



procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        Form2.Memo1.Clear;
end;


procedure TForm1.FormCreate(Sender: TObject);
          var s,g,f :string;
              today : TDateTime;
              ini : TIniFile;
begin

        ini:=Tinifile.Create(extractfilepath(paramstr(0))+'setting.ini');

        ADOConnection1.Connected:=False;
        ADOConnection1.LoginPrompt := False;
        ADOConnection1.DefaultDatabase := 'TeestDB.mdf';
        ADOConnection1.ConnectionString:= ini.ReadString('Connection','ConnStr','');
        ADOConnection1.Connected:=True;


        ADOQuery1.SQL.ADD('SELECT * FROM Registration WHERE [��� ������������] =' + quotedstr(GetUserFromWindows)+ {' AND DATEDIFF(day, [���� �����������], GETDATE()) = 0}' ORDER BY ID DESC');
        ADOQuery1.Active :=True;
        Ini.Free;

        DBGrid1.Columns[10].Visible := False;
        DBGrid1.Columns[11].Visible := False;

        ComboBox1.Style:= csDropDownList;
        ComboBox2.Style:= csDropDownList;

        Button1.Visible := False;
        Button2.Visible := False;


        Edit1.Visible := False;
        Edit2.Visible := False;
        Edit3.Visible := False;
        Edit4.Visible := False;
        Edit5.Visible := False;

        Label2.Visible := False;
        Label3.Visible := False;
        Label4.Visible := False;
        Label5.Visible := False;
        Label6.Visible := False;

        CheckBox2.Visible := False;
        CheckBox3.Visible := False;

end;






procedure TForm1.N2Click(Sender: TObject);
begin
      Form2.ShowModal;
end;




procedure TForm1.N3Click(Sender: TObject);
Var
   ExcelApp, Workbook, Range, Cell1, Cell2, ArrayData: Variant;
   BeginCol, BeginRow, j: integer;
   col, RowCount, ColCount: Integer;
   ShFile: String;
Begin
   BeginCol := 1;
   BeginRow := 2;

 // ������� ���������� ������� ������
   RowCount := ADOQuery1.RecordCount;
   ColCount := ADOQuery1.FieldDefs.Count;

 // �������� Excel
   ExcelApp := CreateOleObject('Excel.Application');

 // ��������� ������� Excel �� �������, ����� �������� ����� ����������
   ExcelApp.Application.EnableEvents := false;

 //  ������� ����� (Workbook)
 //  ���� ��������� ������, ��
   Workbook := ExcelApp.WorkBooks.Add(ShFile);
   ArrayData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);

 // ��������� ������
   ADOQuery1.DisableControls;

   //����� ����� ��������
   for col :=0 to 5 do

        ExcelApp.WorkBooks[1].WorkSheets[1].cells[1,col+1].value := dbgrid1.fields[col].displaylabel;

        ExcelApp.WorkBooks[1].WorkSheets[1].cells[1,col+1].value := dbgrid1.fields[8].displaylabel;


   While Not ADOQuery1.eof Do
   Begin
      // For J := 1 To ADOQuery1.FieldDefs.Count Do
      // Begin
      //    ArrayData[ADOQuery1.RecNo, J] := ADOQuery1.FieldbyName(ADOQuery1.FieldDefs.Items[j - 1].DisplayName).value;
      // End;
       For J := 1 To 6 Do
         Begin
            ArrayData[ADOQuery1.RecNo, J] := ADOQuery1.FieldbyName(ADOQuery1.FieldDefs.Items[j - 1].DisplayName).value;
         End;
       For J := 9 To ADOQuery1.FieldDefs.Count Do
         begin
          ArrayData[ADOQuery1.RecNo, 7] := ADOQuery1.FieldbyName(ADOQuery1.FieldDefs.Items[j - 1].DisplayName).value;
         end;
       ADOQuery1.Next;
   End;

   ADOQuery1.EnableControls;

 // ����� ������� ������ �������, � ������� ����� �������� ������
   Cell1 := WorkBook.WorkSheets[1].Cells[BeginRow, BeginCol];
 // ������ ������ ������ �������, � ������� ����� �������� ������
   Cell2 := WorkBook.WorkSheets[1].Cells[BeginRow + RowCount - 1, BeginCol + ColCount - 1];

 // �������, � ������� ����� �������� ������
   Range := WorkBook.WorkSheets[1].Range[Cell1, Cell2];

 // � ��� � ��� ����� ������
 // ������� ������� ����������� ����������
   Range.Value := ArrayData;

 // ������ Excel �������
   ExcelApp.Visible := True;
   ADOQuery1.First;
End;

end.

