unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ZAbstractConnection, ZConnection,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    ComboBox1: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DBGrid1: TDBGrid;
    Label9: TLabel;
    Edit6: TEdit;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    DataSource1: TDataSource;
    Button6: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a: string;
  searchValue: string;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
Edit1.Enabled := False;
Edit2.Enabled := False;
Edit3.Enabled := False;
Edit4.Enabled := False;
Edit5.Enabled := False;

ComboBox1.Enabled := False;

Button2.Enabled := False;
Button3.Enabled := False;
Button4.Enabled := False;
Button5.Enabled := False;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
Edit1.Enabled := True;
Edit2.Enabled := True;
Edit3.Enabled := True;
Edit4.Enabled := True;
Edit5.Enabled := True;

ComboBox1.Enabled := True;

Button1.Enabled := False;
Button2.Enabled := True;
Button3.Enabled := False;
Button4.Enabled := False;
Button5.Enabled := True;

Edit1.SetFocus;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Edit4.Text := '';
  Edit5.Text := '';
  Label8.Caption := 'Isi Otomatis';
  ComboBox1.Text := 'Pilih--';

Edit1.Enabled := False;
Edit2.Enabled := False;
Edit3.Enabled := False;
Edit4.Enabled := False;
Edit5.Enabled := False;

ComboBox1.Enabled := False;

Button1.Enabled := True;
Button2.Enabled := False;
Button3.Enabled := False;
Button4.Enabled := False;
Button5.Enabled := False;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
try
  if (Edit2.Text = '') or (Edit3.Text = '') or (Edit4.Text = '') or (Edit5.Text = '') or (ComboBox1.Text = '') then
  begin
    ShowMessage('Semua kolom harus diisi!');
    Exit;
  end;

  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('insert into kustomer (nik, nama, telp, email, alamat, member) values (:field1, :field2, :field3, :field4, :field5, :field6)');
  ZQuery1.ParamByName('field1').AsString := Edit1.Text;
  ZQuery1.ParamByName('field2').AsString := Edit2.Text;
  ZQuery1.ParamByName('field3').AsString := Edit3.Text;
  ZQuery1.ParamByName('field4').AsString := Edit4.Text;
  ZQuery1.ParamByName('field5').AsString := Edit5.Text;
  ZQuery1.ParamByName('field6').AsString := ComboBox1.Text;
  ZQuery1.ExecSQL;

  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('Select * from kustomer');
  ZQuery1.Open;

  ShowMessage('Data Berhasil Disimpan');
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Edit4.Text := '';
  Edit5.Text := '';
  Label8.Caption := 'Isi Otomatis';
  ComboBox1.Text := 'Pilih--';


  Edit1.Enabled := False;
  Edit2.Enabled := False;
  Edit3.Enabled := False;
  Edit4.Enabled := False;
  Edit5.Enabled := False;

  ComboBox1.Enabled := False;

  Button1.Enabled := True;
  Button2.Enabled := False;
  Button3.Enabled := False;
  Button4.Enabled := False;
  Button5.Enabled := False;
except
  on E: Exception do
    ShowMessage('Terjadi kesalahan: ' + E.Message);
end;

end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin

 if not ZQuery1.IsEmpty then
  begin
    Edit1.Text := ZQuery1.FieldByName('nik').AsString;
    Edit2.Text := ZQuery1.FieldByName('nama').AsString;
    Edit3.Text := ZQuery1.FieldByName('telp').AsString;
    Edit4.Text := ZQuery1.FieldByName('email').AsString;
    Edit5.Text := ZQuery1.FieldByName('alamat').AsString;
    ComboBox1.Text := ZQuery1.FieldByName('member').AsString;
    a:=ZQuery1.Fields[0].AsString;
  end;
  Edit1.Enabled := True;
  Edit2.Enabled := True;
  Edit3.Enabled := True;
  Edit4.Enabled := True;
  Edit5.Enabled := True;

  ComboBox1.Enabled := True;

  Button1.Enabled := False;
  Button2.Enabled := False;
  Button3.Enabled := True;
  Button4.Enabled := True;
  Button5.Enabled := True;

  Edit1.SetFocus;

    if ComboBox1.Text = 'Ya' then
    Label8.Caption := 'Diskon 10%'
  else if ComboBox1.Text = 'Tidak' then
    Label8.Caption := 'Diskon 5%'
  else
    Label8.Caption := '';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
try
  if (Edit2.Text = '') or (Edit3.Text = '') or (Edit4.Text = '') or (Edit5.Text = '') or (ComboBox1.Text = '') then
  begin
    ShowMessage('Semua kolom harus diisi!');
    Exit;
  end;

  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('UPDATE kustomer SET nik = :field1, nama = :field2, telp = :field3, email = :field4, alamat = :field5, member = :field6 WHERE id = :id');
  ZQuery1.ParamByName('id').AsString := a;
  ZQuery1.ParamByName('field1').AsString := Edit1.Text;
  ZQuery1.ParamByName('field2').AsString := Edit2.Text;
  ZQuery1.ParamByName('field3').AsString := Edit3.Text;
  ZQuery1.ParamByName('field4').AsString := Edit4.Text;
  ZQuery1.ParamByName('field5').AsString := Edit5.Text;
  ZQuery1.ParamByName('field6').AsString := ComboBox1.Text;
  ZQuery1.ExecSQL;

  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('SELECT * FROM kustomer');
  ZQuery1.Open;

  ShowMessage('Data Berhasil Diupdate');

  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Edit4.Text := '';
  Edit5.Text := '';
  Label8.Caption := 'Isi Otomatis';
  ComboBox1.Text := 'Pilih--';

  Edit1.Enabled := False;
  Edit2.Enabled := False;
  Edit3.Enabled := False;
  Edit4.Enabled := False;
  Edit5.Enabled := False;
  ComboBox1.Enabled := False;

  Button1.Enabled := True;
  Button2.Enabled := False;
  Button3.Enabled := False;
  Button4.Enabled := False;
  Button5.Enabled := False;

except
  on E: Exception do
    ShowMessage('Terjadi kesalahan: ' + E.Message);
end;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
try

  if a = '' then
  begin
    ShowMessage('Pilih data yang akan dihapus.');
    Exit;
  end;

  if MessageDlg('Anda yakin ingin menghapus data ini?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.Add('DELETE FROM kustomer WHERE id = :id');
    ZQuery1.ParamByName('id').AsString := a;
    ZQuery1.ExecSQL;

    ZQuery1.SQL.Clear;
    ZQuery1.SQL.Add('SELECT * FROM kustomer');
    ZQuery1.Open;

    ShowMessage('Data Berhasil Dihapus');

    Edit1.Text := '';
    Edit2.Text := '';
    Edit3.Text := '';
    Edit4.Text := '';
    Edit5.Text := '';
    Label8.Caption := 'Isi Otomatis';
    ComboBox1.Text := 'Pilih--';

    Edit1.Enabled := False;
    Edit2.Enabled := False;
    Edit3.Enabled := False;
    Edit4.Enabled := False;
    Edit5.Enabled := False;
    ComboBox1.Enabled := False;

    Button1.Enabled := True;
    Button2.Enabled := False;
    Button3.Enabled := False;
    Button4.Enabled := False;
    Button5.Enabled := False; 
  end;

except
  on E: Exception do
    ShowMessage('Terjadi kesalahan: ' + E.Message);
end;

end;

procedure TForm1.Edit6Change(Sender: TObject);
begin
  searchValue := Edit6.Text;

  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('SELECT * FROM kustomer WHERE nama LIKE :search OR nik LIKE :search');
  ZQuery1.ParamByName('search').AsString := '%' + searchValue + '%';
  ZQuery1.Open;

  DBGrid1.DataSource.DataSet.Refresh;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
 if ComboBox1.Text = 'Ya' then
    Label8.Caption := 'Diskon 10%'
  else if ComboBox1.Text = 'Tidak' then
    Label8.Caption := 'Diskon 5%'
  else
    Label8.Caption := '';
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
Form2.QuickRep1.Preview;
end;

end.
