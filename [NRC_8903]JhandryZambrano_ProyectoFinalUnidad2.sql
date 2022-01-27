--Proporcione una consulta que muestre el nombre del artista, el album, el genero y que el tipo de medio sea Protected AAC audio file y la suma de ventas del 2010 al 2012
Select artists.Name AS Artista, albums.Title AS Albumn, genres.Name As Genero, media_types.Name AS TipoMedio,SUM(invoices.Total) AS Ventas
From invoice_items
Inner Join invoices ON invoice_items.InvoiceId = invoices.InvoiceId
Inner Join tracks ON invoice_items.TrackId = tracks.TrackId
Inner Join albums ON tracks.AlbumId = albums.AlbumId
Inner Join artists ON albums.ArtistId = artists.ArtistId
Inner Join genres ON tracks.GenreId = genres.GenreId
Inner Join media_types ON tracks.MediaTypeId = media_types.MediaTypeId
Where media_types.Name = 'Protected AAC audio file'
Group By artists.ArtistId
Having invoices.InvoiceDate Between '2010-01-01' AND '2012-31-01'
Order By invoices.Total ASC

--Se requiere consultar el album, artista, pista, tipomedio, genero que menos vendio en el 2010
Select albums.Title AS Album, artists.Name AS Artista , tracks.Name AS Pista, media_types.Name AS TipoDeMedio, genres.Name AS Genero
From invoice_items
Inner Join invoices ON invoice_items.InvoiceId = invoices.InvoiceId
Inner Join tracks ON invoice_items.TrackId = tracks.TrackId
Inner Join albums ON tracks.AlbumId = albums.AlbumId
Inner Join artists ON albums.ArtistId = artists.ArtistId
Inner Join media_types ON tracks.MediaTypeId = media_types.MediaTypeId
Inner Join genres ON tracks.GenreId = genres.GenreId
Group By invoices.InvoiceId
Having invoices.InvoiceDate Between '2010-01-01' AND '2010-31-01'
Order By SUM(invoices.Total) ASC
Limit 1;


--Realice una consulta que sume las ventas de los artistas  que mas vendio en el 2012
Select albums.Title AS Album, artists.Name AS Artista, tracks.Name AS Pista, media_types.Name AS TipoDeMedio, genres.Name AS Genero
From invoice_items
Inner Join invoices ON invoice_items.InvoiceId = invoices.InvoiceId
Inner Join tracks ON invoice_items.TrackId = tracks.TrackId
Inner Join albums ON tracks.AlbumId = albums.AlbumId
Inner Join artists ON albums.ArtistId = artists.ArtistId
Inner Join media_types ON tracks.MediaTypeId = media_types.MediaTypeId
Inner Join genres ON tracks.GenreId = genres.GenreId
Group By invoices.InvoiceId
Having invoices.InvoiceDate Between '2012-01-01' AND '2012-31-01'
Order By SUM(invoices.Total) DESC
Limit 1;

--Realice una consulta  de las pistas, album, nombre del artista y genero que menos se compro en el 2012. 
Select albums.Title AS Album, artists.Name AS Artista, tracks.Name AS Pista, genres.Name As Genero, playlists.Name AS Playlist
From invoice_items
Inner Join invoices ON invoice_items.InvoiceId = invoices.InvoiceId
Inner Join tracks ON invoice_items.TrackId = tracks.TrackId
Inner Join albums ON tracks.AlbumId = albums.AlbumId
Inner Join artists ON albums.ArtistId = artists.ArtistId
Inner Join genres ON tracks.GenreId = genres.GenreId
Inner Join playlist_track On playlist_track.TrackId = tracks.TrackId
Inner Join playlists On playlist_track.PlaylistId = playlists.PlaylistId
Where invoices.InvoiceDate Between '2012-01-01' AND '2012-31-01'
Group By invoices.InvoiceId
Order By SUM(invoices.Total) ASC
Limit 1;

--Realice una consulta de los nombres de las ciudades donde el artista tuvo ventas mayores a 300 y menores a 400, además de saber el playlist
Select invoices.BillingCity AS Ciudades, artists.Name As Artista, genres.Name As Genero,media_types.Name As TipoMedio 
From invoice_items
Inner Join invoices ON invoice_items.InvoiceId = invoices.InvoiceId
Inner Join tracks ON invoice_items.TrackId = tracks.TrackId
Inner Join albums ON tracks.AlbumId = albums.AlbumId
Inner Join artists ON albums.ArtistId = artists.ArtistId
Inner Join genres ON tracks.GenreId = genres.GenreId
Inner Join media_types ON tracks.MediaTypeId = media_types.MediaTypeId
Group By invoices.BillingCity
Having SUM(invoices.Total) Between 300 AND 400
Order By invoices.BillingCity ASC

--Se busca encontrar en cuantos paises ha dado soporte Johnson y que paises son además de saber el cliente y dar a conocer la pista con su playlist y genero
Select employees.LastName AS NombreEmpleado, invoices.BillingCountry AS Pais, COUNT(invoices.BillingCountry)  AS Total,customers.LastName ,tracks.Name AS Pista, playlists.Name AS Playlist, genres.Name AS Genero
From invoice_items
Inner Join invoices ON invoice_items.InvoiceId = invoices.InvoiceId
Inner Join customers ON invoices.CustomerId = customers.CustomerId
Inner Join employees On customers.SupportRepId = employees.EmployeeId
Inner Join tracks On invoice_items.TrackId = tracks.TrackId
Inner Join playlist_track On playlist_track.TrackId = tracks.TrackId
Inner Join playlists On playlist_track.PlaylistId = playlists.PlaylistId
Inner Join genres On tracks.GenreId = genres.GenreId
Group By invoices.BillingCountry
Having employees.LastName = 'Johnson'
Order By invoices.BillingCountry ASC

--Proporcione una consulta que permita realiza la búsqueda del nombre y apellido del cliente,el álbum, el artista,el genero, nombre de la playlist que haya hecho Queen
Select customers.LastName AS NombreCliente, customers.FirstName As ApellidoCliente, albums.Title As Album, artists.Name As Artista, genres.Name As Genero, playlists.Name As Playlists
From invoice_items
Inner Join invoices ON invoice_items.InvoiceId = invoices.InvoiceId
Inner Join customers ON invoices.CustomerId = customers.CustomerId
Inner Join employees On customers.SupportRepId = employees.EmployeeId
Inner Join tracks On invoice_items.TrackId = tracks.TrackId
Inner Join playlist_track On playlist_track.TrackId = tracks.TrackId
Inner Join playlists On playlist_track.PlaylistId = playlists.PlaylistId
Inner Join genres On tracks.GenreId = genres.GenreId
Inner Join albums ON tracks.AlbumId = albums.AlbumId
Inner Join artists ON albums.ArtistId = artists.ArtistId
Group By tracks.Name
Having tracks.Composer = 'Queen'
Order By tracks.Name ASC


--Realice una consulta que muestre el artista, la pista,el genero, la ciudad, los compositores, el total de ventas en las ciudades de USA en el 2013
Select artists.Name As Artista, tracks.Name As Pista, genres.Name As Genero, invoices.BillingCity As Ciudad, tracks.Composer As Compositor, SUM(invoices.Total) As Total, invoices.InvoiceDate
From invoice_items
Inner Join invoices On invoice_items.InvoiceId = invoices.InvoiceId
Inner Join customers On invoices.CustomerId = customers.CustomerId
Inner Join tracks On invoice_items.TrackId = tracks.TrackId
Inner Join albums On tracks.AlbumId = albums.AlbumId
Inner Join artists On albums.ArtistId = artists.ArtistId
Inner Join genres On tracks.GenreId = genres.GenreId
Where invoices.BillingCountry = 'USA'
Group By invoices.InvoiceDate
Having invoices.InvoiceDate Between '2013-01-01' AND '2013-12-31'
Order By invoices.Total ASC

--Realice una consulta que muestre el artista ,álbum, genero, pista, compositor,  y nombre , apellido del cliente que realizo mas compras en los años 2012 y 2013 y  verifique en que mes se vendió mas.
Select artists.Name As Artista, albums.Title As Albums, genres.Name As Genero, tracks.Name As Pista, tracks.Composer As Compositor, customers.FirstName As NombreCliente, customers.LastName As ApellidoCliente
From invoice_items
Inner Join invoices On invoice_items.InvoiceId = invoices.InvoiceId
Inner Join customers On invoices.CustomerId = customers.CustomerId
Inner Join tracks On invoice_items.TrackId = tracks.TrackId
Inner Join albums On tracks.AlbumId = albums.AlbumId
Inner Join artists On albums.ArtistId = artists.ArtistId
Inner Join genres On tracks.GenreId = genres.GenreId
Group By invoices.InvoiceDate
Having invoices.InvoiceDate Between '2012-01-01' AND '2013-12-31'
Order By invoices.Total ASC

--Realizar una consulta que permita verificar el nombre y apellido de cliente que realizo la mayor cantidad de ventas en USA, además mostrar,  el género mas escuchado, el Pais, Estado,teléfono, y Playlist
Select customers.FirstName As NombreCliente, customers.LastName As ApellidoCliente, customers.Phone As Telefono, invoices.BillingCountry As Pais,
invoices.BillingState As Estado, playlists.Name As Playlist, genres.Name As Genero, SUM(invoices.Total) As TotalVentas
From invoice_items
Inner Join invoices On invoice_items.InvoiceId = invoices.InvoiceId
Inner Join customers On invoices.CustomerId = customers.CustomerId
Inner Join tracks On invoice_items.TrackId = tracks.TrackId
Inner Join genres On tracks.GenreId = genres.GenreId
Inner Join playlist_track On playlist_track.TrackId = tracks.TrackId
Inner Join playlists On playlist_track.PlaylistId = playlists.PlaylistId
Group By invoices.InvoiceId
Having invoices.BillingCountry = 'USA'
Order By invoices.Total DESC
Limit 1;


--Realizar una consulta que permita buscar el artista menos vendido del 2012 y del 2013, además debe mostrar el genero,  el formato, el nombre del álbum,nombre del empleado que lo atendio, numero celular, y la pista.
Select artists.Name As Artista, genres.Name As Genero, media_types.Name As Formato, albums.Title As Album, 
employees.FirstName As NombreEmpleado, employees.Phone As Telefono, tracks.Name As Pista, SUM(invoices.Total) AS TotalVentas 
From invoice_items
Inner Join invoices On invoice_items.InvoiceId = invoices.InvoiceId
Inner Join tracks On invoice_items.TrackId = tracks.TrackId
Inner Join genres On tracks.GenreId = genres.GenreId
Inner Join media_types On tracks.MediaTypeId = media_types.MediaTypeId
Inner Join albums On tracks.AlbumId = albums.AlbumId
Inner Join artists On albums.ArtistId = artists.ArtistId
Inner Join customers On invoices.CustomerId = customers.CustomerId
Inner Join employees On customers.SupportRepId = employees.EmployeeId
Group By artists.ArtistId
Having invoices.InvoiceDate Between '2012-01-01' AND '2013-31-01'
Order By invoices.Total ASC


