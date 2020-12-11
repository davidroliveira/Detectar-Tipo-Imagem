unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls;

type
  TMemoryStreamHelper = class helper for TMemoryStream
  public
    function ToString: string; reintroduce;
  end;

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Image1: TImage;
    FDMemTable1: TFDMemTable;
    FDMemTable1IMAGEM: TBlobField;
    DBImage1: TDBImage;
    DataSource1: TDataSource;
    BtnJPG: TButton;
    BtnPNG: TButton;
    BtnBMP: TButton;
    procedure Button1Click(Sender: TObject);
    procedure jpegClick(Sender: TObject);
    procedure BtnJPGClick(Sender: TObject);
    procedure BtnPNGClick(Sender: TObject);
    procedure BtnBMPClick(Sender: TObject);
  private
    procedure Carregar(const Arquivo: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses JPEG, Vcl.Imaging.pngimage, Vcl.Imaging.GIFImg;

procedure TForm1.Button1Click(Sender: TObject);
begin
  var BinStream := TMemoryStream.Create;
  try
    TMemoryStream(BinStream).LoadFromFile('C:\Users\PROGRAMADOR03\Desktop\ErroAjusteAvancadoA.el');
    Memo1.Lines.Text := BinStream.ToString;
  finally
    BinStream.Free;
  end;
end;

function TMemoryStreamHelper.ToString: string;
begin
  result := System.PWideChar(Self.memory );
end;

procedure TForm1.jpegClick(Sender: TObject);
begin
  var BinStream := TMemoryStream.Create;
  try
    BinStream.LoadFromFile('C:\Users\PROGRAMADOR03\Desktop\imagem.jpg');
    BinStream.Position := 0;
    Memo1.Lines.Text := BinStream.ToString;

    FDMemTable1.Close;
    FDMemTable1.Open;
    FDMemTable1.EmptyDataSet;
    FDMemTable1.Insert;
    FDMemTable1IMAGEM.LoadFromStream(BinStream);
    FDMemTable1.Post;

    var Bitmap := TBitmap.Create;
    try
      Bitmap.Width := DBImage1.Picture.Width;
      Bitmap.Height := DBImage1.Picture.Height;
      Bitmap.Canvas.Draw(0, 0, DBImage1.Picture.Graphic);
      Bitmap.SaveToFile('C:\Users\PROGRAMADOR03\Desktop\imagem-RESULTADO.BMP');
    finally
      Bitmap.Free;
    end;
    Image1.Picture.LoadFromFile('C:\Users\PROGRAMADOR03\Desktop\imagem-RESULTADO.BMP')

  finally
    BinStream.Free;
  end;
end;

procedure TForm1.BtnJPGClick(Sender: TObject);
begin
  Carregar('C:\Users\PROGRAMADOR03\Desktop\imagem.jpg');
end;

procedure TForm1.BtnPNGClick(Sender: TObject);
begin
  Carregar('C:\Users\PROGRAMADOR03\Desktop\imagem.png');
end;

procedure TForm1.BtnBMPClick(Sender: TObject);
begin
  Carregar('C:\Users\PROGRAMADOR03\Desktop\imagem.bmp');
end;

procedure DetectImage(const InputFileName: string; BM: TBitmap);
var
  FS: TFileStream;
  FirstBytes: AnsiString;
  Graphic: TGraphic;
  Ext: string;
begin
  Ext := string.Empty;
  Graphic := nil;
  FS := TFileStream.Create(InputFileName, fmOpenRead);
  try
    SetLength(FirstBytes, 8);
    FS.Read(FirstBytes[1], 8);

    if Copy(FirstBytes, 1, 2) = 'BM' then
    begin
      Graphic := TBitmap.Create;
      Ext := '.bmp';
    end
    else if FirstBytes = #137'PNG'#13#10#26#10 then
    begin
      Graphic := TPngImage.Create;
      Ext := '.png';
    end
    else if Copy(FirstBytes, 1, 3) =  'GIF' then
    begin
      Graphic := TGIFImage.Create;
      Ext := '.gif';
    end
    else if Copy(FirstBytes, 1, 2) = #$FF#$D8 then
    begin
      Graphic := TJPEGImage.Create;
      Ext := '.jpg';
    end;

    if Assigned(Graphic) then
    begin
      try
        FS.Seek(0, soFromBeginning);
        Graphic.LoadFromStream(FS);
        Graphic.SaveToFile(ExtractFileDir(InputFileName) + '\imagem-RESULTADO' + Ext);
        BM.Assign(Graphic);
      except
      end;
      Graphic.Free;
    end;
  finally
    FS.Free;
  end;
end;

procedure TForm1.Carregar(const Arquivo: string);
begin
  DetectImage(Arquivo, image1.Picture.Bitmap);
//     //Try
//          //var fs := TFileStream.Create('c:\testjpg.dat', fmOpenRead Or fmSharedenyNone);
//          var fs := TMemoryStream.Create;
//          fs.LoadFromFile(Arquivo);
//          fs.Position := 0;
//
//          var OleGraphic := TOleGraphic.Create; {The magic class!}
//          OleGraphic.LoadFromStream(fs);
//
//          var Source := Timage.Create(Nil);
//          Source.Picture.Assign(OleGraphic);
//
//          var BMP := TBitmap.Create; {Converting to Bitmap}
//          bmp.Width := Source.Picture.Width;
//          bmp.Height := source.Picture.Height;
//          bmp.Canvas.Draw(0, 0, source.Picture.Graphic);
//
//          image1.Picture.Bitmap := bmp; {Show the bitmap on form}
//
//     //Finally
//          fs.Free;
//          OleGraphic.Free;
//          Source.Free;
//          bmp.Free;
//     //End;
end;

end.
