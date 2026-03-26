# ImageList-Creator

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)  ![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Description](https://github.com/user-attachments/assets/dbf330e0-633c-4b31-a0ef-b1edb9ed5aa7) ![ImageList Creator](https://github.com/user-attachments/assets/14bb8d13-5d46-4ffb-b0ab-fcf5635842e3)  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) ![032026](https://github.com/user-attachments/assets/0fc2f280-2ec1-45b1-8947-57bfc6683ea0)  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)  

</br>

Delphi's ```TImageList``` manages collections of same-sized images (icons/bitmaps) for UI components. Modern Delphi (10.3+) uses ```TImageCollection``` with ```TVirtualImageList``` to support High DPI scaling, automatically resizing images based on DPI. ```TVirtualImageList``` should be placed on forms, while ```TImageCollection``` resides on data modules for centralized management.

### Key Delphi ImageList Components & Features:
* ```TImageList``` (Traditional): A standard container for identical-sized images used by components like ```TToolBar```, ```TListView```, or ```TMenuItem```.
  
* TImageCollection (Modern): Centralized storage for images of various sizes and formats (SVG, PNG, ICO). Images here are not displayed directly but are sourced by ```TVirtualImageList```.
  
* ```TVirtualImageList``` (High-DPI): Links to a TImageCollection to dynamically produce the correct size image based on the screen's DPI, eliminating blurry or tiny icons in high-resolution, according to the Embarcadero blog post.
Image List Editor: Accessed at design time, this tool allows for adding, removing, replacing, and clearing images, as described in the Embarcadero [DocWiki](https://docwiki.embarcadero.com/RADStudio/Athens/en/Image_List_Editor).

* Transparency: Supports 32-bit images (e.g., 32-bit BMP, PNG) for proper alpha blending.
  
* Performance: ```TImageList``` is highly efficient, storing images in a single large bitmap.
  
* Virtualization: ```TVirtualImageList``` only keeps required images for specific forms, optimizing memory.

</br>

![ImageList Creator](https://github.com/user-attachments/assets/c60887c4-5702-456f-805c-502859e71c8c)

</br>

Import Formats : [Bitmap](https://en.wikipedia.org/wiki/Bitmap), [PNG](https://en.wikipedia.org/wiki/PNG), [ICON](https://en.wikipedia.org/wiki/ICO_(file_format))  
Export Formats : [Bitmap](https://en.wikipedia.org/wiki/Bitmap), [JPEG](https://en.wikipedia.org/wiki/JPEG), [PNG](https://en.wikipedia.org/wiki/PNG), [GIF](https://en.wikipedia.org/wiki/GIF), [WMF](https://en.wikipedia.org/wiki/Windows_Metafile), [EMF](https://en.wikipedia.org/wiki/Windows_Metafile)  

It is also possible to combine different image formats, which is not recommended because the color pixels do not match in some PNG files.

# Use
This article shows how to use the images in an ImageList. Delphi's TImageList provides the methods GetBitmap and GetIcon for reading the images. GetBitmap provides the image as a bitmap, and GetIcon provides it as an icon. The first parameter for both methods is the index of the image in the list. Here, the first image in the list is displayed as a bitmap:

```pascal
procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  ImageList1.GetBitmap(0,BitBtn1.Glyph);
end;
```
</br>

The following procedure assigns the fifth image to the application icon:

```pascal
procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  ImageList1.GetIcon(4,Application.Icon);
end;
```





