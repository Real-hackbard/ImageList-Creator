unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, System.Math, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Buttons, PngImage, Jpeg, Vcl.Samples.Spin,
  WinApi.ShellAPI, GIFImg;

type
  TForm1 = class(TForm)
    SaveDialog1: TSaveDialog;
    ImageList1: TImageList;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    Panel11: TPanel;
    Label1: TLabel;
    Label8: TLabel;
    StatusBar1: TStatusBar;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Image2: TImage;
    Label2: TLabel;
    Panel2: TPanel;
    Image3: TImage;
    Label3: TLabel;
    Panel3: TPanel;
    Image4: TImage;
    Label4: TLabel;
    Panel4: TPanel;
    Image5: TImage;
    Label5: TLabel;
    Panel5: TPanel;
    Image6: TImage;
    Label6: TLabel;
    Panel6: TPanel;
    Image7: TImage;
    Label7: TLabel;
    Panel7: TPanel;
    Image8: TImage;
    Label10: TLabel;
    Panel8: TPanel;
    Image9: TImage;
    Label11: TLabel;
    Panel9: TPanel;
    Image10: TImage;
    Label12: TLabel;
    Panel10: TPanel;
    Image11: TImage;
    Label13: TLabel;
    ComboBox5: TComboBox;
    Label15: TLabel;
    Label18: TLabel;
    ComboBox1: TComboBox;
    ComboBox4: TComboBox;
    Label14: TLabel;
    CheckBox1: TCheckBox;
    Button3: TButton;
    GroupBox2: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Button1: TButton;
    Button2: TButton;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    SpinEdit1: TSpinEdit;
    Label19: TLabel;
    SpinEdit2: TSpinEdit;
    Label20: TLabel;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image11MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure BmpToWmf(BmpFile, WmfFile: string);
// Converts a Bitmap to a Windows Metafile (*.wmf)
var
  MetaFile: TMetaFile;
  MFCanvas: TMetaFileCanvas;
  BMP: TBitmap;
begin
  MetaFile := TMetaFile.Create; try
  BMP := TBitmap.Create;
    try
      BMP.LoadFromFile(BmpFile);
      MetaFile.Height := BMP.Height;
      MetaFile.Width  := BMP.Width;
      MFCanvas := TMetafileCanvas.Create(MetaFile, 0);
       try
        MFCanvas.Draw(0, 0, BMP);
       finally
        MFCanvas.Free;
       end;
    finally
      BMP.Free;
    end;
      MetaFile.SaveToFile(WmfFile);
    finally
      MetaFile.Free;
  end;
end;

function DeleteFile(const AFile: string): boolean;
var
 sh: SHFileOpStruct;
begin
 ZeroMemory(@sh, sizeof(sh));
 with sh do
   begin
   Wnd := Application.Handle;
   wFunc := fo_Delete;
   pFrom := PChar(AFile +#0);
   fFlags := fof_Silent or fof_NoConfirmation;
   end;
 result := SHFileOperation(sh) = 0;
end;

function bmp2emf(const SourceFileName: TFileName): Boolean;
// Converts a Bitmap to a Enhanced Metafile (*.emf)
var
  Metafile: TMetafile;
  MetaCanvas: TMetafileCanvas;
  Bitmap: TBitmap;
begin
  Metafile := TMetaFile.Create;
  try
    Bitmap := TBitmap.Create;
    try
      Bitmap.LoadFromFile(SourceFileName);
      Metafile.Height := Bitmap.Height;
      Metafile.Width  := Bitmap.Width;
      MetaCanvas := TMetafileCanvas.Create(Metafile, 0);
      try
        MetaCanvas.Draw(0, 0, Bitmap);
      finally
        MetaCanvas.Free;
      end;
    finally
      Bitmap.Free;
    end;
    Metafile.SaveToFile(ChangeFileExt(SourceFileName, '.emf'));
  finally
    Metafile.Free;
  end;
end;

// png Image import
procedure LoadPngToBmp(var Dest: TBitmap; AFilename: TFilename);
{$R-}
type
  TRGB32 = packed record
    B, G, R, A : Byte;
  end;
  PRGBArray32 = ^TRGBArray32;
  TRGBArray32 = array[0..0] of TRGB32;
type
  TRG24 = packed record
    rgbtBlue, rgbtGreen, rgbtRed : Byte;
  end;
  PRGBArray24 = ^TPRGBArray24;
  TPRGBArray24 = array[0..0] of TRG24;
type
  TByteArray = Array[Word] of Byte;
  PByteArray = ^TByteArray;
  TPByteArray = array[0..0] of TByteArray;
var
  BMP : TBitmap;
  PNG: TPNGObject;
  x, y: Integer;
  BmpRow: PRGBArray32;
  PngRow : PRGBArray24;
  AlphaRow: PByteArray;
begin
  Bmp := TBitmap.Create;
  PNG := TPNGObject.Create;

  try
    if AFilename <> '' then
    begin
      PNG.LoadFromFile(AFilename);
      BMP.PixelFormat := pf32bit;
      BMP.Height := PNG.Height;
      BMP.Width := PNG.Width;

      if ( PNG.TransparencyMode = ptmPartial ) then
      begin
        for Y := 0 to BMP.Height-1 do
        begin
          BmpRow := PRGBArray32(BMP.ScanLine[Y]);
          PngRow := PRGBArray24(PNG.ScanLine[Y]);
          AlphaRow := PByteArray(PNG.AlphaScanline[Y]);

          for X := 0 to BMP.Width - 1 do
          begin
            with BmpRow[X] do
            begin
              with PngRow[X] do
              begin
                R := rgbtRed; G := rgbtGreen; B := rgbtBlue;
              end;
              A := Byte(AlphaRow[X]);
            end;
          end;
        end;
      end else
      begin
        for Y := 0 to BMP.Height-1 do
        begin
          BmpRow := PRGBArray32(BMP.ScanLine[Y]);
          PngRow := PRGBArray24(PNG.ScanLine[Y]);

          for X := 0 to BMP.Width - 1 do
          begin
            with BmpRow[X] do
            begin
              with PngRow[X] do
              begin
                R := rgbtRed; G := rgbtGreen; B := rgbtBlue;
              end;
              A := 255;
            end;
          end;
        end;
      end;
      Dest.Assign(BMP);
    end;
  finally
    Bmp.Free;
    PNG.Free;
  end;
  {$R+}
end;

procedure JoinBitmapsColumnB(Bmp1, Bmp2, Bmp3, Bmp4, Bmp5, Bmp6, Bmp7,
                                Bmp8, Bmp9, Bmp10, ResultBmp: TBitmap);
begin
  // Dimensioning the target bitmap
  // Adjust the size of the target bitmap (add width, height of the tallest image)
  ResultBmp.Height := Bmp1.Height + Bmp2.Height;
  ResultBmp.Canvas.Brush.Color := clFuchsia;

  // Bitmap Pixel bit
  case Form1.ComboBox3.ItemIndex of
      0 : ResultBmp.PixelFormat := pf8bit;
      1 : ResultBmp.PixelFormat := pf24bit;
      2 : ResultBmp.PixelFormat := pf32bit;
  end;

  // Draw images onto the canvas of the target bitmap
  // To build unequal sizes, the BMP specifications must be used.
  // You can also use numerical values for the same sizes.
  if Form1.ComboBox1.ItemIndex = 0 then
  begin
    ResultBmp.Width := Bmp1.Width;
    ResultBmp.Height := Bmp1.Height;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
  end;

  if Form1.ComboBox1.ItemIndex = 1 then
  begin
    ResultBmp.Width := Bmp1.Width;
    ResultBmp.Height := Bmp1.Height*2;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp1.Height, Bmp2);
  end;

  if Form1.ComboBox1.ItemIndex = 2 then
  begin
    ResultBmp.Width := Bmp1.Width;
    ResultBmp.Height := Bmp1.Height*3;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp1.Height, Bmp2);
    ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height, Bmp3);
  end;

  if Form1.ComboBox1.ItemIndex = 3 then
  begin
    ResultBmp.Width := Bmp1.Width*2;
    ResultBmp.Height := Bmp1.Height*3;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp4);
  end;

  if Form1.ComboBox1.ItemIndex = 4 then
  begin
    ResultBmp.Width := Bmp1.Width*2;
    ResultBmp.Height := Bmp1.Height*3;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height, Bmp5);
  end;

  if Form1.ComboBox1.ItemIndex = 5 then
  begin
    ResultBmp.Width := Bmp1.Width*2;
    ResultBmp.Height := Bmp1.Height*3;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height, Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height + Bmp5.Height, Bmp6);
  end;

  if Form1.ComboBox1.ItemIndex = 6 then
  begin
    ResultBmp.Width := Bmp1.Width*3;
    ResultBmp.Height := Bmp1.Height*3;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height, Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height + Bmp5.Height, Bmp6);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp5.Width, 0, Bmp7);
  end;

  if Form1.ComboBox1.ItemIndex = 7 then
  begin
    ResultBmp.Width := Bmp1.Width*3;
    ResultBmp.Height := Bmp1.Height*3;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height, Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height + Bmp5.Height, Bmp6);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp5.Width, 0, Bmp7);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp5.Width,
                           Bmp6.Height, Bmp8);
  end;

  if Form1.ComboBox1.ItemIndex = 8 then
  begin
    ResultBmp.Width := Bmp1.Width*3;
    ResultBmp.Height := Bmp1.Height*3;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height, Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height + Bmp5.Height, Bmp6);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp5.Width, 0, Bmp7);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp5.Width,
                           Bmp6.Height, Bmp8);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp5.Width,
                           Bmp6.Height + Bmp7.Height, Bmp9);
  end;

  if Form1.ComboBox1.ItemIndex = 9 then
  begin
    ResultBmp.Width := Bmp1.Width*4;
    ResultBmp.Height := Bmp1.Height*3;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height, Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height + Bmp5.Height, Bmp6);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp5.Width, 0, Bmp7);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp5.Width,
                           Bmp6.Height, Bmp8);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp5.Width,
                           Bmp6.Height + Bmp7.Height, Bmp9);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp4.Width + Bmp7.Width,
                           0, Bmp10);
  end;

end;

procedure JoinBitmapsColumnA(Bmp1, Bmp2, Bmp3, Bmp4, Bmp5, Bmp6, Bmp7,
                                Bmp8, Bmp9, Bmp10, ResultBmp: TBitmap);
begin
  // Dimensioning the target bitmap
  // Adjust the size of the target bitmap (add width, height of the tallest image)
  ResultBmp.Height := Bmp1.Height + Bmp2.Height;
  ResultBmp.Canvas.Brush.Color := clFuchsia;

  // Bitmap Pixel bit
  case Form1.ComboBox3.ItemIndex of
      0 : ResultBmp.PixelFormat := pf8bit;
      1 : ResultBmp.PixelFormat := pf24bit;
      2 : ResultBmp.PixelFormat := pf32bit;
  end;

  // Draw images onto the canvas of the target bitmap
  // To build unequal sizes, the BMP specifications must be used.
  // You can also use numerical values for the same sizes.
  if Form1.ComboBox1.ItemIndex = 0 then
  begin
    ResultBmp.Width := Bmp1.Width;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
  end;

  if Form1.ComboBox1.ItemIndex = 1 then
  begin
    ResultBmp.Width := Bmp1.Width;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp1.Height, Bmp2);
  end;

  if Form1.ComboBox1.ItemIndex = 2 then
  begin
    ResultBmp.Width := Bmp1.Width*2;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp1.Height, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp3);
  end;

  if Form1.ComboBox1.ItemIndex = 3 then
  begin
    ResultBmp.Width := Bmp1.Width*2;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height, Bmp4);
  end;

  if Form1.ComboBox1.ItemIndex = 4 then
  begin
    ResultBmp.Width := Bmp1.Width*3;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width, 0, Bmp5);
  end;

  if Form1.ComboBox1.ItemIndex = 5 then
  begin
    ResultBmp.Width := Bmp1.Width*3;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width, 0, Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width, Bmp5.Height, Bmp6);
  end;

  if Form1.ComboBox1.ItemIndex = 6 then
  begin
    ResultBmp.Width := Bmp1.Width*4;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width, 0, Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width, Bmp5.Height, Bmp6);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width + Bmp5.Width, 0, Bmp7);
  end;

  if Form1.ComboBox1.ItemIndex = 7 then
  begin
    ResultBmp.Width := Bmp1.Width*4;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width, 0, Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width, Bmp5.Height, Bmp6);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width + Bmp5.Width, 0, Bmp7);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width + Bmp5.Width,
                           Bmp6.Height, Bmp8);
  end;

  if Form1.ComboBox1.ItemIndex = 8 then
  begin
    ResultBmp.Width := Bmp1.Width*5;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width, 0, Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width, Bmp5.Height, Bmp6);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width + Bmp5.Width, 0, Bmp7);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width + Bmp5.Width,
                           Bmp6.Height, Bmp8);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width + Bmp5.Width + Bmp7.Width,
                           0, Bmp9);
  end;

  if Form1.ComboBox1.ItemIndex = 9 then
  begin
    ResultBmp.Width := Bmp1.Width*5;
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(0, Bmp2.Height, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width, Bmp3.Height, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width, 0, Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width, Bmp5.Height, Bmp6);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width + Bmp5.Width, 0, Bmp7);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width + Bmp5.Width,
                           Bmp6.Height, Bmp8);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width + Bmp5.Width + Bmp7.Width,
                           0, Bmp9);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp3.Width + Bmp5.Width + Bmp7.Width,
                           Bmp9.Height, Bmp10);
  end;
end;

procedure JoinBitmapsVertical(Bmp1, Bmp2, Bmp3, Bmp4, Bmp5, Bmp6, Bmp7, Bmp8,
                              Bmp9, Bmp10, ResultBmp: TBitmap);
var
  w, h: Integer;
begin
  // Calculate maximum width, add height
  if Bmp1.Width > Bmp2.Width then
    w := Bmp1.Width
  else
    w := Bmp2.Width;       // Section width of the individual images
    h := Bmp1.Height * (Form1.ComboBox1.ItemIndex+1); // Number of individual images

  // Dimensioning the target bitmap
  ResultBmp.SetSize(w, h);
  // Bitmap Pixel bit
  case Form1.ComboBox3.ItemIndex of
      0 : ResultBmp.PixelFormat := pf8bit;
      1 : ResultBmp.PixelFormat := pf24bit;
      2 : ResultBmp.PixelFormat := pf32bit;
  end;

  // Draw
  ResultBmp.Canvas.Draw(0, 0, Bmp1);           // First picture above
  ResultBmp.Canvas.Draw(0, Bmp1.Height, Bmp2); // Second image directly below
  ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height, Bmp3);
  ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height + Bmp3.Height, Bmp4);
  ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height + Bmp3.Height + Bmp4.Height,
                        Bmp5);
  ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height + Bmp3.Height + Bmp4.Height +
                        Bmp5.Height, Bmp6);
  ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height + Bmp3.Height + Bmp4.Height +
                        Bmp5.Height + Bmp6.Height, Bmp7);
  ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height + Bmp3.Height + Bmp4.Height +
                        Bmp5.Height + Bmp6.Height + Bmp7.Height, Bmp8);
  ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height + Bmp3.Height + Bmp4.Height +
                        Bmp5.Height + Bmp6.Height + Bmp7.Height + Bmp8.Height,
                        Bmp9);
  ResultBmp.Canvas.Draw(0, Bmp1.Height + Bmp2.Height + Bmp3.Height + Bmp4.Height +
                        Bmp5.Height + Bmp6.Height + Bmp7.Height + Bmp8.Height +
                        Bmp9.Height, Bmp10);
end;

procedure JoinBitmapsHorizontal(Bmp1, Bmp2, Bmp3, Bmp4, Bmp5, Bmp6, Bmp7,
                                Bmp8, Bmp9, Bmp10, ResultBmp: TBitmap);
begin
  // Adjust the size of the target bitmap (add width, height of the tallest image)
  case Form1.ComboBox1.ItemIndex of
    0 : ResultBmp.Width := Bmp1.Width;
    1 : ResultBmp.Width := Bmp1.Width + Bmp2.Width;
    2 : ResultBmp.Width := Bmp1.Width + Bmp2.Width + Bmp3.Width;
    3 : ResultBmp.Width := Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width;
    4 : ResultBmp.Width := Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                       Bmp5.Width;
    5 : ResultBmp.Width := Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                       Bmp5.Width + Bmp6.Width;
    6 : ResultBmp.Width := Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                       Bmp5.Width + Bmp6.Width + Bmp7.Width;
    7 : ResultBmp.Width := Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                       Bmp5.Width + Bmp6.Width + Bmp7.Width + Bmp8.Width;
    8 : ResultBmp.Width := Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                       Bmp5.Width + Bmp6.Width + Bmp7.Width + Bmp8.Width +
                       Bmp9.Width;
    9 : ResultBmp.Width := Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                       Bmp5.Width + Bmp6.Width + Bmp7.Width + Bmp8.Width +
                       Bmp9.Width + Bmp10.Width;
  end;


  // Dimensioning the target bitmap
  ResultBmp.Height := Max(Bmp1.Height, Bmp2.Height);

  // Bitmap Pixel bit
  case Form1.ComboBox3.ItemIndex of
      0 : ResultBmp.PixelFormat := pf8bit;
      1 : ResultBmp.PixelFormat := pf24bit;
      2 : ResultBmp.PixelFormat := pf32bit;
  end;

  // Draw images onto the canvas of the target bitmap
  // To build unequal sizes, the BMP specifications must be used.
  // You can also use numerical values for the same sizes.
  if Form1.ComboBox1.ItemIndex = 0 then
  begin
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
  end;

  if Form1.ComboBox1.ItemIndex = 1 then
  begin
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp2);
  end;

  if Form1.ComboBox1.ItemIndex = 2 then
  begin
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width, 0, Bmp3);
  end;

  if Form1.ComboBox1.ItemIndex = 3 then
  begin
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width, 0, Bmp4);
  end;

  if Form1.ComboBox1.ItemIndex = 4 then
  begin
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width, 0, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width, 0,
                        Bmp5);
  end;

  if Form1.ComboBox1.ItemIndex = 5 then
  begin
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width, 0, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width, 0,
                          Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width, 0, Bmp6);
  end;

  if Form1.ComboBox1.ItemIndex = 6 then
  begin
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width, 0, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width, 0,
                          Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width, 0, Bmp6);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width + Bmp6.Width, 0, Bmp7);
  end;

  if Form1.ComboBox1.ItemIndex = 7 then
  begin
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width, 0, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width, 0,
                          Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width, 0, Bmp6);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width + Bmp6.Width, 0, Bmp7);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width + Bmp6.Width + Bmp7.Width, 0, Bmp8);
  end;

  if Form1.ComboBox1.ItemIndex = 8 then
  begin
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width, 0, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width, 0,
                          Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width, 0, Bmp6);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width + Bmp6.Width, 0, Bmp7);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width + Bmp6.Width + Bmp7.Width, 0, Bmp8);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width + Bmp6.Width + Bmp7.Width + Bmp8.Width, 0,
                          Bmp9);
  end;

  if Form1.ComboBox1.ItemIndex = 9 then
  begin
    ResultBmp.Canvas.Draw(0, 0, Bmp1);
    ResultBmp.Canvas.Draw(Bmp1.Width, 0, Bmp2);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width, 0, Bmp3);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width, 0, Bmp4);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width, 0,
                          Bmp5);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width, 0, Bmp6);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width + Bmp6.Width, 0, Bmp7);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width + Bmp6.Width + Bmp7.Width, 0, Bmp8);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width + Bmp6.Width + Bmp7.Width + Bmp8.Width, 0,
                          Bmp9);
    ResultBmp.Canvas.Draw(Bmp1.Width + Bmp2.Width + Bmp3.Width + Bmp4.Width +
                          Bmp5.Width + Bmp6.Width + Bmp7.Width + Bmp8.Width +
                          Bmp9.Width, 0, Bmp10);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  case ComboBox2.ItemIndex of
  0 : begin
        Image1.Picture.Graphic := nil;
          if ComboBox4.ItemIndex = 0 then
          begin
            JoinBitmapsHorizontal(Image2.Picture.Bitmap, Image3.Picture.Bitmap,
                        Image4.Picture.Bitmap, Image5.Picture.Bitmap,
                        Image6.Picture.Bitmap, Image7.Picture.Bitmap,
                        Image8.Picture.Bitmap, Image9.Picture.Bitmap,
                        Image10.Picture.Bitmap, Image11.Picture.Bitmap,
                        Image1.Picture.Bitmap);  // Result Image
          end;

          if ComboBox4.ItemIndex = 1 then
          begin
            JoinBitmapsColumnA(Image2.Picture.Bitmap, Image3.Picture.Bitmap,
                        Image4.Picture.Bitmap, Image5.Picture.Bitmap,
                        Image6.Picture.Bitmap, Image7.Picture.Bitmap,
                        Image8.Picture.Bitmap, Image9.Picture.Bitmap,
                        Image10.Picture.Bitmap, Image11.Picture.Bitmap,
                        Image1.Picture.Bitmap);  // Result Image
          end;

          if ComboBox4.ItemIndex = 2 then
          begin
            JoinBitmapsColumnB(Image2.Picture.Bitmap, Image3.Picture.Bitmap,
                        Image4.Picture.Bitmap, Image5.Picture.Bitmap,
                        Image6.Picture.Bitmap, Image7.Picture.Bitmap,
                        Image8.Picture.Bitmap, Image9.Picture.Bitmap,
                        Image10.Picture.Bitmap, Image11.Picture.Bitmap,
                        Image1.Picture.Bitmap);  // Result Image
          end;
      end;


  1 : begin
        Image1.Picture.Graphic := nil;
        JoinBitmapsVertical(Image2.Picture.Bitmap,
                      Image3.Picture.Bitmap,
                      Image4.Picture.Bitmap,
                      Image5.Picture.Bitmap,
                      Image6.Picture.Bitmap,
                      Image7.Picture.Bitmap,
                      Image8.Picture.Bitmap,
                      Image9.Picture.Bitmap,
                      Image10.Picture.Bitmap,
                      Image11.Picture.Bitmap,
                      Image1.Picture.Bitmap);  // Result Image);
      end;
  end;

  StatusBar1.Panels[2].Text := IntToStr(Image1.Picture.Bitmap.Width) + 'x' +
                               IntToStr(Image1.Picture.Bitmap.Height);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Bmp: TBitmap;
  Jpg: TJPEGImage;
  PNG: TPNGObject;
  GIF: TGIFImage;
begin
  if SaveDialog1.Execute then
  BEGIN
    if SaveDialog1.FilterIndex = 1 then
    begin
      try
        bmp := TBitmap.Create;
        bmp.Assign(Image1.Picture.Bitmap);

      case ComboBox3.ItemIndex of
        0 : bmp.PixelFormat := pf8bit;
        1 : bmp.PixelFormat := pf24bit;
        2 : bmp.PixelFormat := pf32bit;
      end;

        bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
      finally
        bmp.Free;
      end;
    end;

    if SaveDialog1.FilterIndex = 2 then
    begin
        Bmp := TBitmap.Create;
        Jpg := TJPEGImage.Create;
      try
        Bmp.Assign(Image1.Picture.Bitmap);

        case ComboBox3.ItemIndex of
          0 : bmp.PixelFormat := pf8bit;
          1 : bmp.PixelFormat := pf24bit;
          2 : bmp.PixelFormat := pf32bit;
        end;

        Jpg.Assign(Bmp);
        Jpg.CompressionQuality := SpinEdit1.Value;
        Jpg.Compress;
        if CheckBox1.Checked = true then Jpg.Transparent := true;
        Jpg.SaveToFile(SaveDialog1.FileName + '.jpg');
      finally
        Jpg.Free;
        Bmp.Free;
      end;
    end;

    if SaveDialog1.FilterIndex = 3 then
    begin
      Bmp := TBitmap.Create;
      PNG := TPNGObject.Create;
      {In case something goes wrong, free booth Bitmap and PNG}
      try
        bmp.Assign(Image1.Picture.Bitmap);

        case ComboBox3.ItemIndex of
          0 : bmp.PixelFormat := pf8bit;
          1 : bmp.PixelFormat := pf24bit;
          2 : bmp.PixelFormat := pf32bit;
        end;

        //Convert data into png
        PNG.Assign(bmp);
        //Compress File size
        PNG.CompressionLevel := SpinEdit2.Value;
        //Set Transparent Color Black
        if CheckBox1.Checked = true then PNG.Transparent := true;
        PNG.SaveToFile(SaveDialog1.FileName + '.png');
      finally
        Bmp.Free;
        PNG.Free;
      end;
    end;

    if SaveDialog1.FilterIndex = 4 then
    begin
      try
        bmp := TBitmap.Create;
        bmp.Assign(Image1.Picture.Bitmap);

      case ComboBox3.ItemIndex of
        0 : bmp.PixelFormat := pf8bit;
        1 : bmp.PixelFormat := pf24bit;
        2 : bmp.PixelFormat := pf32bit;
      end;

        bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
        bmp2emf(SaveDialog1.FileName + '.bmp');
      finally
        bmp.Free;
        DeleteFile(SaveDialog1.FileName + '.bmp');
      end;
    end;

    if SaveDialog1.FilterIndex = 5 then
    begin
      try
        bmp := TBitmap.Create;
        bmp.Assign(Image1.Picture.Bitmap);

      case ComboBox3.ItemIndex of
        0 : bmp.PixelFormat := pf8bit;
        1 : bmp.PixelFormat := pf24bit;
        2 : bmp.PixelFormat := pf32bit;
      end;

        bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
        BmpToWmf(SaveDialog1.FileName + '.bmp', SaveDialog1.FileName + '.wmf');
      finally
        bmp.Free;
        DeleteFile(SaveDialog1.FileName + '.bmp');
      end;
    end;

    if SaveDialog1.FilterIndex = 6 then
    begin
      try
        bmp := TBitmap.Create;
        GIF := TGIFImage.Create;
        bmp.Assign(Image1.Picture.Bitmap);
        // Copy Bitmap Pixel to GIF Data
        GIF.Assign(bmp);

        // Create GIF File Image
        GIF.SaveToFile(SaveDialog1.FileName + '.gif');
      finally
        bmp.Free;
        GIF.Free;
      end;
    end;



  END;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i : integer;
  Img : TImage;
  Lab : TLabel;
begin

    for i := 2 to 11 do
      begin
        Img := TImage(FindComponent('Image'+IntToStr(i)));
        Img.Picture.Graphic := nil;
      end;

    for i := 2 to 7 do
      begin
        Lab := TLabel(FindComponent('Label'+IntToStr(i)));
        Lab.Caption := '0x0';
      end;

    for i := 10 to 13 do
      begin
        Lab := TLabel(FindComponent('Label'+IntToStr(i)));
        Lab.Caption := '0x0';
      end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  i : integer;
  num : integer;
  Img : TImage;
begin
  for i := 2 to 11 do
    begin
      num := num + 1;
      Img := TImage(FindComponent('Image'+IntToStr(i)));
      try
        Img.Picture.Bitmap.SaveToFile(ExtractFilePath(Application.ExeName) +
                                                  'Data\mySet\' +
                                                  IntToStr(num) +
                                                  '.bmp');
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
    end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
var
  i : integer;
begin
  if CheckBox1.Checked = true then
  begin
    for i := 2 to ComponentCount - 1 do
    begin
      if Components[i] is TImage then
        (Components[i] as TImage).Transparent := true;
    end;
  end;

  if CheckBox1.Checked = false then
  begin
    for i := 2 to ComponentCount - 1 do
    begin
      if Components[i] is TImage then
        (Components[i] as TImage).Transparent := false;
    end;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0 : begin
          Label2.Enabled := true;  Label3.Enabled := false;
          Label4.Enabled := false;  Label5.Enabled := false;
          Label6.Enabled := false;  Label7.Enabled := false;
          Label10.Enabled := false;  Label11.Enabled := false;
          Label12.Enabled := false;  Label13.Enabled := false;
        end;
    1 : begin
          Label2.Enabled := true;  Label3.Enabled := true;
          Label4.Enabled := false;  Label5.Enabled := false;
          Label6.Enabled := false;  Label7.Enabled := false;
          Label10.Enabled := false;  Label11.Enabled := false;
          Label12.Enabled := false;  Label13.Enabled := false;
        end;
    2 : begin
          Label2.Enabled := true;  Label3.Enabled := true;
          Label4.Enabled := true;  Label5.Enabled := false;
          Label6.Enabled := false;  Label7.Enabled := false;
          Label10.Enabled := false;  Label11.Enabled := false;
          Label12.Enabled := false;  Label13.Enabled := false;
        end;
    3 : begin
          Label2.Enabled := true;  Label3.Enabled := true;
          Label4.Enabled := true;  Label5.Enabled := true;
          Label6.Enabled := false;  Label7.Enabled := false;
          Label10.Enabled := false;  Label11.Enabled := false;
          Label12.Enabled := false;  Label13.Enabled := false;
        end;
    4 : begin
          Label2.Enabled := true;  Label3.Enabled := true;
          Label4.Enabled := true;  Label5.Enabled := true;
          Label6.Enabled := true;  Label7.Enabled := false;
          Label10.Enabled := false;  Label11.Enabled := false;
          Label12.Enabled := false;  Label13.Enabled := false;
        end;
    5 : begin
          Label2.Enabled := true;  Label3.Enabled := true;
          Label4.Enabled := true;  Label5.Enabled := true;
          Label6.Enabled := true;  Label7.Enabled := true;
          Label10.Enabled := false;  Label11.Enabled := false;
          Label12.Enabled := false;  Label13.Enabled := false;
        end;
    6 : begin
          Label2.Enabled := true;  Label3.Enabled := true;
          Label4.Enabled := true;  Label5.Enabled := true;
          Label6.Enabled := true;  Label7.Enabled := true;
          Label10.Enabled := true;  Label11.Enabled := false;
          Label12.Enabled := false;  Label13.Enabled := false;
        end;
    7 : begin
          Label2.Enabled := true;  Label3.Enabled := true;
          Label4.Enabled := true;  Label5.Enabled := true;
          Label6.Enabled := true;  Label7.Enabled := true;
          Label10.Enabled := true;  Label11.Enabled := true;
          Label12.Enabled := false;  Label13.Enabled := false;
        end;
    8 : begin
          Label2.Enabled := true;  Label3.Enabled := true;
          Label4.Enabled := true;  Label5.Enabled := true;
          Label6.Enabled := true;  Label7.Enabled := true;
          Label10.Enabled := true;  Label11.Enabled := true;
          Label12.Enabled := true;  Label13.Enabled := false;
        end;
    9 : begin
          Label2.Enabled := true;  Label3.Enabled := true;
          Label4.Enabled := true;  Label5.Enabled := true;
          Label6.Enabled := true;  Label7.Enabled := true;
          Label10.Enabled := true;  Label11.Enabled := true;
          Label12.Enabled := true;  Label13.Enabled := true;
        end;
  end;
end;

procedure TForm1.ComboBox5Change(Sender: TObject);
var
  i, num : integer;
  Img : TImage;
  Lab : TLabel;
  pic : TBitmap;
begin
  num := 0;
  case ComboBox5.ItemIndex of
    0 : begin
          for i := 2 to 11 do
          begin
            num := num + 1;
            Img := TImage(FindComponent('Image'+IntToStr(i)));
            try
            Img.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                                  'Data\Set\A\' +
                                                  IntToStr(num) +
                                                  '.bmp');
            except
              on E: Exception do
                ShowMessage(E.Message);
            end;
          end;

          for i := 2 to 7 do
          begin
            Lab := TLabel(FindComponent('Label'+IntToStr(i)));
            Lab.Caption := '16x16';
          end;

          for i := 10 to 13 do
          begin
            Lab := TLabel(FindComponent('Label'+IntToStr(i)));
            Lab.Caption := '16x16';
          end;
        end;

    1 : begin
          for i := 2 to 11 do
          try
            num := num + 1;
            pic := TBitmap.Create;
            LoadPngToBmp(pic, ExtractFilePath(Application.ExeName) +
                                                    'Data\Set\B\' +
                                                    IntToStr(num) +
                                                    '.png');
            Img := TImage(FindComponent('Image'+IntToStr(i)));
            Img.Height :=  pic.Height;
            Img.Width := pic.Width;
            pic.PixelFormat := pf24bit;
            Img.Picture.Bitmap.Assign(pic);
          finally
            pic.Free;
          end;

          for i := 2 to 7 do
          begin
            Lab := TLabel(FindComponent('Label'+IntToStr(i)));
            Lab.Caption := '24x24';
          end;

          for i := 10 to 13 do
          begin
            Lab := TLabel(FindComponent('Label'+IntToStr(i)));
            Lab.Caption := '24x24';
          end;
        end;

    2 : begin
          for i := 2 to 11 do
          try
            num := num + 1;
            pic := TBitmap.Create;
            Icon := TIcon.Create;
            Icon.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                                    'Data\Set\C\' +
                                                    IntToStr(num) +
                                                    '.ico');
            Icon.Transparent := true;
            Icon.AssignTo(pic);

            Img := TImage(FindComponent('Image'+IntToStr(i)));
            Img.Height :=  pic.Height;
            Img.Width := pic.Width;
            pic.PixelFormat := pf24bit;
            Img.Picture.Bitmap.Assign(pic);
          finally
            pic.Free;
          end;

          for i := 2 to 7 do
            begin
              Lab := TLabel(FindComponent('Label'+IntToStr(i)));
              Lab.Caption := '48x48';
            end;

            for i := 10 to 13 do
            begin
              Lab := TLabel(FindComponent('Label'+IntToStr(i)));
              Lab.Caption := '48x48';
            end;
        end;

    3 : begin
          for i := 2 to 11 do
          begin
            num := num + 1;
            Img := TImage(FindComponent('Image'+IntToStr(i)));
            try
              Img.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                                  'Data\mySet\' +
                                                  IntToStr(num) +
                                                  '.bmp');
            except
              on E: Exception do
                ShowMessage(E.Message);
            end;
          end;

          for i := 2 to 7 do
          begin
            Lab := TLabel(FindComponent('Label'+IntToStr(i)));
            Lab.Caption := '16x16';
          end;

          for i := 10 to 13 do
          begin
            Lab := TLabel(FindComponent('Label'+IntToStr(i)));
            Lab.Caption := '16x16';
          end;
        end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
end;

procedure TForm1.Image10MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pic : TBitmap;
  Icon : TIcon;
  check : integer;
begin
  if OpenDialog1.Execute then
  BEGIN
    if OpenDialog1.FilterIndex = 1 then     // bitmap import
    begin
      try
        pic := TBitmap.Create;
        pic.LoadFromFile(OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image10.Height := pic.Height;
        Image10.Width := pic.Width;
        Image10.Picture.Bitmap.Assign(pic);
        Label10.Caption := IntToStr(Image10.Width) +'x'+
                          IntToStr(Image10.Height);

        check := Image10.Width;

        if (Image10.Height > 48) or (Image10.Width > 48) then
        begin
          Image10.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label10.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 2 then     // png import
    begin
      try
        pic := TBitmap.Create;
        LoadPngToBmp(pic, OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image10.Height := pic.Height;
        Image10.Width := pic.Width;
        Image10.Picture.Bitmap.Assign(pic);
        Label10.Caption := IntToStr(Image10.Width) +'x'+
                          IntToStr(Image10.Height);

        check := Image10.Width;

        if (Image10.Height > 48) or (Image10.Width > 48) then
        begin
          Image10.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label10.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 3 then     // ico import
    begin
      try
        pic := TBitmap.Create;
        Icon := TIcon.Create;
        Icon.LoadFromFile(OpenDialog1.FileName);
        Icon.Transparent := true;
        Image10.Height := Icon.Height;
        Image10.Width := Icon.Width;
        Icon.AssignTo(pic);
        Image10.Picture.Bitmap.Assign(pic);
        Label10.Caption := IntToStr(Image10.Width) +'x'+
                          IntToStr(Image10.Height);

        check := Image10.Width;

        if (Image10.Height > 48) or (Image10.Width > 48) then
        begin
          Image10.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label10.Caption := '0x0';
        end;

      finally
        pic.Free;
        Icon.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;
  END;
end;

procedure TForm1.Image11MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pic : TBitmap;
  Icon : TIcon;
  check : integer;
begin
  if OpenDialog1.Execute then
  BEGIN
    if OpenDialog1.FilterIndex = 1 then     // bitmap import
    begin
      try
        pic := TBitmap.Create;
        pic.LoadFromFile(OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image11.Height := pic.Height;
        Image11.Width := pic.Width;
        Image11.Picture.Bitmap.Assign(pic);
        Label11.Caption := IntToStr(Image11.Width) +'x'+
                          IntToStr(Image11.Height);

        check := Image11.Width;

        if (Image11.Height > 48) or (Image11.Width > 48) then
        begin
          Image11.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label11.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 2 then     // png import
    begin
      try
        pic := TBitmap.Create;
        LoadPngToBmp(pic, OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image11.Height := pic.Height;
        Image11.Width := pic.Width;
        Image11.Picture.Bitmap.Assign(pic);
        Label11.Caption := IntToStr(Image11.Width) +'x'+
                          IntToStr(Image11.Height);

        check := Image11.Width;

        if (Image11.Height > 48) or (Image11.Width > 48) then
        begin
          Image11.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label11.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 3 then     // ico import
    begin
      try
        pic := TBitmap.Create;
        Icon := TIcon.Create;
        Icon.LoadFromFile(OpenDialog1.FileName);
        Icon.Transparent := true;
        Image11.Height := Icon.Height;
        Image11.Width := Icon.Width;
        Icon.AssignTo(pic);
        Image11.Picture.Bitmap.Assign(pic);
        Label11.Caption := IntToStr(Image11.Width) +'x'+
                          IntToStr(Image11.Height);

        check := Image11.Width;

        if (Image11.Height > 48) or (Image11.Width > 48) then
        begin
          Image11.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label11.Caption := '0x0';
        end;

      finally
        pic.Free;
        Icon.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;
  END;
end;

procedure TForm1.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pic : TBitmap;
  Icon : TIcon;
  check : integer;
begin
  if OpenDialog1.Execute then
  BEGIN
    if OpenDialog1.FilterIndex = 1 then     // bitmap import
    begin
      try
        pic := TBitmap.Create;
        pic.LoadFromFile(OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image2.Height := pic.Height;
        Image2.Width := pic.Width;
        Image2.Picture.Bitmap.Assign(pic);
        Label2.Caption := IntToStr(Image2.Width) +'x'+
                          IntToStr(Image2.Height);

        check := Image2.Width;

        if (Image2.Height > 48) or (Image2.Width > 48) then
        begin
          Image2.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label2.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 2 then     // png import
    begin
      try
        pic := TBitmap.Create;
        LoadPngToBmp(pic, OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image2.Height := pic.Height;
        Image2.Width := pic.Width;
        Image2.Picture.Bitmap.Assign(pic);

        Label2.Caption := IntToStr(Image2.Width) +'x'+
                          IntToStr(Image2.Height);
        check := Image2.Width;

        if (Image2.Height > 48) or (Image2.Width > 48) then
        begin
          Image2.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label2.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 3 then     // ico import
    begin
      try
        pic := TBitmap.Create;
        Icon := TIcon.Create;
        Icon.LoadFromFile(OpenDialog1.FileName);
        Icon.Transparent := true;
        Image2.Height := Icon.Height;
        Image2.Width := Icon.Width;
        Icon.AssignTo(pic);
        Image2.Picture.Bitmap.Assign(pic);
        Label2.Caption := IntToStr(Image2.Width) +'x'+
                          IntToStr(Image2.Height);
        check := Image2.Width;

        if (Image2.Height > 48) or (Image2.Width > 48) then
        begin
          Image2.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label2.Caption := '0x0';
        end;

      finally
        pic.Free;
        Icon.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;
  END;
end;

procedure TForm1.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pic : TBitmap;
  Icon : TIcon;
  check : integer;
begin
  if OpenDialog1.Execute then
  BEGIN
    if OpenDialog1.FilterIndex = 1 then     // bitmap import
    begin
      try
        pic := TBitmap.Create;
        pic.LoadFromFile(OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image3.Height := pic.Height;
        Image3.Width := pic.Width;
        Image3.Picture.Bitmap.Assign(pic);
        Label3.Caption := IntToStr(Image3.Width) +'x'+
                          IntToStr(Image3.Height);

        check := Image3.Width;

        if (Image3.Height > 48) or (Image3.Width > 48) then
        begin
          Image3.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label3.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 2 then     // png import
    begin
      try
        pic := TBitmap.Create;
        LoadPngToBmp(pic, OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image3.Height := pic.Height;
        Image3.Width := pic.Width;
        Image3.Picture.Bitmap.Assign(pic);
        Label3.Caption := IntToStr(Image3.Width) +'x'+
                          IntToStr(Image3.Height);

        check := Image3.Width;

        if (Image3.Height > 48) or (Image3.Width > 48) then
        begin
          Image3.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label3.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 3 then     // ico import
    begin
      try
        pic := TBitmap.Create;
        Icon := TIcon.Create;
        Icon.LoadFromFile(OpenDialog1.FileName);
        Icon.Transparent := true;
        Image3.Height := Icon.Height;
        Image3.Width := Icon.Width;
        Icon.AssignTo(pic);
        Image3.Picture.Bitmap.Assign(pic);
        Label3.Caption := IntToStr(Image3.Width) +'x'+
                          IntToStr(Image3.Height);

        check := Image3.Width;

        if (Image3.Height > 48) or (Image3.Width > 48) then
        begin
          Image3.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label3.Caption := '0x0';
        end;

      finally
        pic.Free;
        Icon.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;
  END;
end;

procedure TForm1.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pic : TBitmap;
  Icon : TIcon;
  check : integer;
begin
  if OpenDialog1.Execute then
  BEGIN
    if OpenDialog1.FilterIndex = 1 then     // bitmap import
    begin
      try
        pic := TBitmap.Create;
        pic.LoadFromFile(OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image4.Height := pic.Height;
        Image4.Width := pic.Width;
        Image4.Picture.Bitmap.Assign(pic);
        Label4.Caption := IntToStr(Image4.Width) +'x'+
                          IntToStr(Image4.Height);

        check := Image4.Width;

        if (Image4.Height > 48) or (Image4.Width > 48) then
        begin
          Image4.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label4.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 2 then     // png import
    begin
      try
        pic := TBitmap.Create;
        LoadPngToBmp(pic, OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image4.Height := pic.Height;
        Image4.Width := pic.Width;
        Image4.Picture.Bitmap.Assign(pic);
        Label4.Caption := IntToStr(Image4.Width) +'x'+
                          IntToStr(Image4.Height);

        check := Image4.Width;

        if (Image4.Height > 48) or (Image4.Width > 48) then
        begin
          Image4.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label4.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 3 then     // ico import
    begin
      try
        pic := TBitmap.Create;
        Icon := TIcon.Create;
        Icon.LoadFromFile(OpenDialog1.FileName);
        Icon.Transparent := true;
        Image4.Height := Icon.Height;
        Image4.Width := Icon.Width;
        Icon.AssignTo(pic);
        Image4.Picture.Bitmap.Assign(pic);
        Label4.Caption := IntToStr(Image4.Width) +'x'+
                          IntToStr(Image4.Height);

        check := Image4.Width;

        if (Image4.Height > 48) or (Image4.Width > 48) then
        begin
          Image4.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label4.Caption := '0x0';
        end;

      finally
        pic.Free;
        Icon.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;
  END;
end;

procedure TForm1.Image5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pic : TBitmap;
  Icon : TIcon;
  check : integer;
begin
  if OpenDialog1.Execute then
  BEGIN
    if OpenDialog1.FilterIndex = 1 then     // bitmap import
    begin
      try
        pic := TBitmap.Create;
        pic.LoadFromFile(OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image5.Height := pic.Height;
        Image5.Width := pic.Width;
        Image5.Picture.Bitmap.Assign(pic);
        Label5.Caption := IntToStr(Image5.Width) +'x'+
                          IntToStr(Image5.Height);

        check := Image5.Width;

        if (Image5.Height > 48) or (Image5.Width > 48) then
        begin
          Image5.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label5.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 2 then     // png import
    begin
      try
        pic := TBitmap.Create;
        LoadPngToBmp(pic, OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image5.Height := pic.Height;
        Image5.Width := pic.Width;
        Image5.Picture.Bitmap.Assign(pic);
        Label5.Caption := IntToStr(Image5.Width) +'x'+
                          IntToStr(Image5.Height);

        check := Image5.Width;

        if (Image5.Height > 48) or (Image5.Width > 48) then
        begin
          Image5.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label5.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 3 then     // ico import
    begin
      try
        pic := TBitmap.Create;
        Icon := TIcon.Create;
        Icon.LoadFromFile(OpenDialog1.FileName);
        Icon.Transparent := true;
        Image5.Height := Icon.Height;
        Image5.Width := Icon.Width;
        Icon.AssignTo(pic);
        Image5.Picture.Bitmap.Assign(pic);
        Label5.Caption := IntToStr(Image5.Width) +'x'+
                          IntToStr(Image5.Height);

        check := Image5.Width;

        if (Image5.Height > 48) or (Image5.Width > 48) then
        begin
          Image5.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label5.Caption := '0x0';
        end;

      finally
        pic.Free;
        Icon.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;
  END;
end;

procedure TForm1.Image6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pic : TBitmap;
  Icon : TIcon;
  check : integer;
begin
  if OpenDialog1.Execute then
  BEGIN
    if OpenDialog1.FilterIndex = 1 then     // bitmap import
    begin
      try
        pic := TBitmap.Create;
        pic.LoadFromFile(OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image6.Height := pic.Height;
        Image6.Width := pic.Width;
        Image6.Picture.Bitmap.Assign(pic);
        Label6.Caption := IntToStr(Image6.Width) +'x'+
                          IntToStr(Image6.Height);

        check := Image6.Width;

        if (Image6.Height > 48) or (Image6.Width > 48) then
        begin
          Image6.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label6.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 2 then     // png import
    begin
      try
        pic := TBitmap.Create;
        LoadPngToBmp(pic, OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image6.Height := pic.Height;
        Image6.Width := pic.Width;
        Image6.Picture.Bitmap.Assign(pic);
        Label6.Caption := IntToStr(Image6.Width) +'x'+
                          IntToStr(Image6.Height);

        check := Image6.Width;

        if (Image6.Height > 48) or (Image6.Width > 48) then
        begin
          Image6.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label6.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 3 then     // ico import
    begin
      try
        pic := TBitmap.Create;
        Icon := TIcon.Create;
        Icon.LoadFromFile(OpenDialog1.FileName);
        Icon.Transparent := true;
        Image6.Height := Icon.Height;
        Image6.Width := Icon.Width;
        Icon.AssignTo(pic);
        Image6.Picture.Bitmap.Assign(pic);
        Label6.Caption := IntToStr(Image6.Width) +'x'+
                          IntToStr(Image6.Height);

        check := Image6.Width;

        if (Image6.Height > 48) or (Image6.Width > 48) then
        begin
          Image6.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label6.Caption := '0x0';
        end;

      finally
        pic.Free;
        Icon.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;
  END;
end;

procedure TForm1.Image7MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pic : TBitmap;
  Icon : TIcon;
  check : integer;
begin
  if OpenDialog1.Execute then
  BEGIN
    if OpenDialog1.FilterIndex = 1 then     // bitmap import
    begin
      try
        pic := TBitmap.Create;
        pic.LoadFromFile(OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image7.Height := pic.Height;
        Image7.Width := pic.Width;
        Image7.Picture.Bitmap.Assign(pic);
        Label7.Caption := IntToStr(Image7.Width) +'x'+
                          IntToStr(Image7.Height);

        check := Image7.Width;

        if (Image7.Height > 48) or (Image7.Width > 48) then
        begin
          Image7.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label7.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 2 then     // png import
    begin
      try
        pic := TBitmap.Create;
        LoadPngToBmp(pic, OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image7.Height := pic.Height;
        Image7.Width := pic.Width;
        Image7.Picture.Bitmap.Assign(pic);
        Label7.Caption := IntToStr(Image7.Width) +'x'+
                          IntToStr(Image7.Height);

        check := Image7.Width;

        if (Image7.Height > 48) or (Image7.Width > 48) then
        begin
          Image7.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label7.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 3 then     // ico import
    begin
      try
        pic := TBitmap.Create;
        Icon := TIcon.Create;
        Icon.LoadFromFile(OpenDialog1.FileName);
        Icon.Transparent := true;
        Image7.Height := Icon.Height;
        Image7.Width := Icon.Width;
        Icon.AssignTo(pic);
        Image7.Picture.Bitmap.Assign(pic);
        Label7.Caption := IntToStr(Image7.Width) +'x'+
                          IntToStr(Image7.Height);

        check := Image7.Width;

        if (Image7.Height > 48) or (Image7.Width > 48) then
        begin
          Image7.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label7.Caption := '0x0';
        end;

      finally
        pic.Free;
        Icon.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;
  END;
end;

procedure TForm1.Image8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pic : TBitmap;
  Icon : TIcon;
  check : integer;
begin
  if OpenDialog1.Execute then
  BEGIN
    if OpenDialog1.FilterIndex = 1 then     // bitmap import
    begin
      try
        pic := TBitmap.Create;
        pic.LoadFromFile(OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image8.Height := pic.Height;
        Image8.Width := pic.Width;
        Image8.Picture.Bitmap.Assign(pic);
        Label8.Caption := IntToStr(Image8.Width) +'x'+
                          IntToStr(Image8.Height);

        check := Image8.Width;

        if (Image8.Height > 48) or (Image8.Width > 48) then
        begin
          Image8.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label8.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 2 then     // png import
    begin
      try
        pic := TBitmap.Create;
        LoadPngToBmp(pic, OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image8.Height := pic.Height;
        Image8.Width := pic.Width;
        Image8.Picture.Bitmap.Assign(pic);
        Label8.Caption := IntToStr(Image8.Width) +'x'+
                          IntToStr(Image8.Height);

        check := Image8.Width;

        if (Image8.Height > 48) or (Image8.Width > 48) then
        begin
          Image8.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label8.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 3 then     // ico import
    begin
      try
        pic := TBitmap.Create;
        Icon := TIcon.Create;
        Icon.LoadFromFile(OpenDialog1.FileName);
        Icon.Transparent := true;
        Image8.Height := Icon.Height;
        Image8.Width := Icon.Width;
        Icon.AssignTo(pic);
        Image8.Picture.Bitmap.Assign(pic);
        Label8.Caption := IntToStr(Image8.Width) +'x'+
                          IntToStr(Image8.Height);

        check := Image8.Width;

        if (Image8.Height > 48) or (Image8.Width > 48) then
        begin
          Image8.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label8.Caption := '0x0';
        end;

      finally
        pic.Free;
        Icon.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;
  END;
end;

procedure TForm1.Image9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pic : TBitmap;
  Icon : TIcon;
  check : integer;
begin
  if OpenDialog1.Execute then
  BEGIN
    if OpenDialog1.FilterIndex = 1 then     // bitmap import
    begin
      try
        pic := TBitmap.Create;
        pic.LoadFromFile(OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image9.Height := pic.Height;
        Image9.Width := pic.Width;
        Image9.Picture.Bitmap.Assign(pic);
        Label9.Caption := IntToStr(Image9.Width) +'x'+
                          IntToStr(Image9.Height);

        check := Image9.Width;

        if (Image9.Height > 48) or (Image9.Width > 48) then
        begin
          Image9.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label9.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 2 then     // png import
    begin
      try
        pic := TBitmap.Create;
        LoadPngToBmp(pic, OpenDialog1.FileName);

        case ComboBox3.ItemIndex of
        0 : pic.PixelFormat := pf8bit;
        1 : pic.PixelFormat := pf24bit;
        2 : pic.PixelFormat := pf32bit;
        end;

        Image9.Height := pic.Height;
        Image9.Width := pic.Width;
        Image9.Picture.Bitmap.Assign(pic);
        Label9.Caption := IntToStr(Image9.Width) +'x'+
                          IntToStr(Image9.Height);

        check := Image9.Width;

        if (Image9.Height > 48) or (Image9.Width > 48) then
        begin
          Image9.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label9.Caption := '0x0';
        end;

      finally
        pic.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;

    if OpenDialog1.FilterIndex = 3 then     // ico import
    begin
      try
        pic := TBitmap.Create;
        Icon := TIcon.Create;
        Icon.LoadFromFile(OpenDialog1.FileName);
        Icon.Transparent := true;
        Image9.Height := Icon.Height;
        Image9.Width := Icon.Width;
        Icon.AssignTo(pic);
        Image9.Picture.Bitmap.Assign(pic);
        Label9.Caption := IntToStr(Image9.Width) +'x'+
                          IntToStr(Image9.Height);

        check := Image9.Width;

        if (Image9.Height > 48) or (Image9.Width > 48) then
        begin
          Image9.Picture.Graphic := nil;
          Beep;
          ShowMessage('Image is too large for glyphs, use maximal 48px.');
          Label9.Caption := '0x0';
        end;

      finally
        pic.Free;
        Icon.Free;
        if (Image3.Width <> check) or (Image4.Width <> check) or
           (Image5.Width <> check) or (Image6.Width <> check) or
           (Image7.Width <> check) or (Image8.Width <> check) or
           (Image9.Width <> check) or (Image10.Width <> check) then
        begin
          StatusBar1.Panels[0].Text := 'The images are not the same size.';
        end else begin
          StatusBar1.Panels[0].Text := 'The images all match.';
        end;
      end;
    end;
  END;
end;

end.
