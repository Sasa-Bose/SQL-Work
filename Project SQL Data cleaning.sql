/* Cleaning data in SQL Queries */

select *
From PortfolioProject.dbo.NashvilleHousing

/*Standardize Date format*/
select SaleDate, CONVERT(Date,Saledate)
From PortfolioProject.dbo.NashvilleHousing

--UPDATE NashvilleHousing
--SET SaleDate = CONVERT(Date,Saledate)
-- or
--ALTER TABLE NashvilleHousing
--ADD SaleDateConverted Date;
--UPDATE NashvilleHousing
--SET SaleDateConverted = CONVERT(Date,Saledate)

/*Populate property address data*/
select *
From PortfolioProject.dbo.NashvilleHousing
--where PropertyAddress is null
order by ParcelID --same parcel id seems to have the same property address as well- assume 1
--to become sure about assume 1  
--we will perform self join on parcel id
select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.dbo.NashvilleHousing a
join PortfolioProject.dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null

update a
set a.PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.dbo.NashvilleHousing a
join PortfolioProject.dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null


/* Breaking out address into individual columns(address,city,state)*/

select 
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)as address
, SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress))as city
from PortfolioProject.dbo.NashvilleHousing

--Update the same to table
ALTER TABLE NashvilleHousing
ADD PropertySpiltAddress Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySpiltAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)


ALTER TABLE NashvilleHousing
ADD PropertySpiltCity Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySpiltCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress))

select 
PARSENAME(replace(OwnerAddress,',','.'),3)
,PARSENAME(replace(OwnerAddress,',','.'),2)
,PARSENAME(replace(OwnerAddress,',','.'),1)
from PortfolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ADD OwnerSpiltAddress Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSpiltAddress = PARSENAME(replace(OwnerAddress,',','.'),3)

ALTER TABLE NashvilleHousing
ADD OwnerSpiltCity Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSpiltCity = PARSENAME(replace(OwnerAddress,',','.'),2)

ALTER TABLE NashvilleHousing
ADD OwnerSpiltState Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSpiltState = PARSENAME(replace(OwnerAddress,',','.'),1)

/*Change Y and N to Yes and No in "SoldAsVacant"*/

select distinct(SoldAsVacant),count(SoldAsVacant)
from PortfolioProject.dbo.NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant
, case when SoldAsVacant = 'Y'then 'Yes'
       when SoldAsVacant = 'N'then 'No'
       else SoldAsVacant
       end
from PortfolioProject.dbo.NashvilleHousing

update PortfolioProject.dbo.NashvilleHousing
set SoldAsVacant = case when SoldAsVacant = 'Y'then 'Yes'
				   when SoldAsVacant = 'N'then 'No'
				   else SoldAsVacant
				   end

/* Removing duplicates */

--Suggested to create a temp table and move in the duplicate data 
--Deleting raw data is not a safe option

with RowNumCTE AS(
select *,
	ROW_NUMBER() over(
	partition by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 order by 
				 UniqueID
				 ) row_num
from PortfolioProject.dbo.NashvilleHousing
)
SELECT *
from RowNumCTE
where row_num > 1
--order by PropertyAddress

/* Deleting unused columns*/

--DO NOT delete any columns from raw data(imported data).


--alter table table_name_here
--drop column OwnerAddress, TaxDistrict, PropertyAddress,SaleDate
