Return-Path: <linux-acpi+bounces-9975-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52D49E6254
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 01:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48B3166A75
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 00:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A8A1DA21;
	Fri,  6 Dec 2024 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="frl9SOAL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596A256E;
	Fri,  6 Dec 2024 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445574; cv=pass; b=XhJwLdyg4ZBWj9J2Co6WlU0khEt7YbjL+PJA6QHtbEGpDjrY1lR9FvTMZnm5VbbHNk2LYRSyE+MieLZ+pspPg3oL7hHPE/b0U1m5UYii5abRRs0D8CfI0AwuwlrNzlaETabEzYhDmwKFnjNmOfHucscHCSYwMnKcrD8zBD4kmKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445574; c=relaxed/simple;
	bh=naDHteggYDNyV8q7fwf3t6b1GoEdZiocdqZ1WN89i5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBSx0L2SEBjjspSdOzLup6QkQXGFMKo2XYQWk52bkkvTMBGJupcjsPPe1cjZ9rjznVJnBBDIfS2QEkydZCsB+uhKOuli3Ocl4lqFNm7qq9d1F67/WJdHimjJW/1af8lvszxUdbyf6WAuZbgcyp3ByCDrb8VIgE4Ry6nS8qQ+gpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=frl9SOAL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733445557; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vv9Ka4rmVLBgYt4Ybw2IugZ+NDvUQCvh8YP5EKUIdcgm2z9f20b6iVdbdosSYigvjhaCIM3hayxuacUiT3PI5NGUFnDZCrzqd6Fcpf+A2Ujrochli34Nq2nXJ//YVWjP15MKXFGdYLqc9E2a/eBRlxBYYH8TbSYZ9b7euOeiydQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733445557; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DxeZSd14xAc7OohM2Iu2R+qsXq5QuBf8PDg2bMjgiK4=; 
	b=RuJj2cQlq86bR/lIG2YC8esd0xLIoydneX900uo/Ozi1AIBYSnTHUe8CeR2TkSESAmQitsE8A+ETN7KyieLr4S9F07FssEVulgagtbb6kn8aBcLqWtfWCGXfsvjO/ZTIKz9OAGu4IAqjOfDhjxr08lVaw/Han1lXnmVufrIheYw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733445557;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=DxeZSd14xAc7OohM2Iu2R+qsXq5QuBf8PDg2bMjgiK4=;
	b=frl9SOALmzyZrJiabjYTp15VDu09TnWFtWl0qE3NWpbc92Wl8UV8n+4sKHE1flbf
	nOFFOzhtravOHWjbcJMEkbna93W0CqGXBywaCNX2QRfnB6cGTC8HAFE9r5HVz4Buwcd
	2wgYjbii++mzcRX3BDVsHs7d1ORlPcKNne3n7ju0=
Received: by mx.zohomail.com with SMTPS id 1733445555406621.2825345189734;
	Thu, 5 Dec 2024 16:39:15 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 593C610604B0; Fri, 06 Dec 2024 01:39:10 +0100 (CET)
Date: Fri, 6 Dec 2024 01:39:10 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 2/4] power: supply: core: implement extension API
Message-ID: <nf3knk45vithb2pxoezqh6aeuj544syy3hesdjl74jbklzoo5x@4rlwxt5dztpr>
References: <20241205-power-supply-extensions-v5-0-f0f996db4347@weissschuh.net>
 <20241205-power-supply-extensions-v5-2-f0f996db4347@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dzxg6puaa3vvfdw6"
Content-Disposition: inline
In-Reply-To: <20241205-power-supply-extensions-v5-2-f0f996db4347@weissschuh.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.425.61
X-ZohoMailClient: External


--dzxg6puaa3vvfdw6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/4] power: supply: core: implement extension API
MIME-Version: 1.0

Hi,

On Thu, Dec 05, 2024 at 09:46:36PM +0100, Thomas Wei=DFschuh wrote:
> Various drivers, mostly in platform/x86 extend the ACPI battery driver
> with additional sysfs attributes to implement more UAPIs than are
> exposed through ACPI by using various side-channels, like WMI,
> nonstandard ACPI or EC communication.
>=20
> While the created sysfs attributes look similar to the attributes
> provided by the powersupply core, there are various deficiencies:
>=20
> * They don't show up in uevent payload.
> * They can't be queried with the standard in-kernel APIs.
> * They don't work with triggers.
> * The extending driver has to reimplement all of the parsing,
> formatting and sysfs display logic.
> * Writing a extension driver is completely different from writing a
> normal power supply driver.
>=20
> This extension API avoids all of these issues.
> An extension is just a "struct power_supply_ext" with the same kind of
> callbacks as in a normal "struct power_supply_desc".
>=20
> The API is meant to be used via battery_hook_register(), the same way as
> the current extensions.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

[...]

> @@ -1241,7 +1297,22 @@ EXPORT_SYMBOL_GPL(power_supply_set_property);
>  int power_supply_property_is_writeable(struct power_supply *psy,
>  					enum power_supply_property psp)
>  {
> -	return psy->desc->property_is_writeable && psy->desc->property_is_write=
able(psy, psp);
> +	struct power_supply_ext_registration *reg;
> +
> +	power_supply_for_each_extension(reg, psy) {
> +		if (power_supply_ext_has_property(reg->ext, psp)) {
> +			if (reg->ext->property_is_writeable)
> +				return reg->ext->property_is_writeable(psy, reg->ext,
> +								       reg->data, psp);
> +			else
> +				return -ENODEV;
> +		}
> +	}
> +
> +	if (!psy->desc->property_is_writeable)
> +		return -ENODEV;
> +
> +	return psy->desc->property_is_writeable(psy, psp);
>  }

I think the two 'return -ENODEV' should just be 'return 0'. This
function basically returns a bool. Otherwise the patch looks good to
me. Thanks!

-- Sebastian

--dzxg6puaa3vvfdw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdSR6MACgkQ2O7X88g7
+poSCQ/9Hie0/YLg5Chmq0eLFpj4+fIiR5epm4AqMXcCzHfZPJswDOPD+m1lCvyb
sVh/i4xEh4JRE29Q9LIibo5wvmEh+6Y0ajFY5HH1mM6+jh/9OzhxXg4Ut3K+VV/r
Ye+QfdVpW/Mws4UaMmXxh3CyYdC+4UggFH+pZpMCuv1eIdw2A8CgchL1dCkaEq/Q
a0O71dYXTWhgp6SMCzaPax+40yrY4YkHB1ApA8Q214gctlxN1U4JuKRgXZcnJF3V
F3FclaBHcO40KOUU+GPCPRc3Pq8qZkSh877b1tJ4AYvTAbvsMMeMznNVJ0m1fYxu
DDxl8wd6bAphtUL//9mnPO9zjd9NIHSZlfYau27gyZ/MAOVw8GwC3S3LW6UIgmgi
5dmdY0AS8PwQbssLDvowUnLobTUxWJl1EFusK2Ebk6z6nWJYlThvC492Vy6hyYhh
w9nbTtH/wY3KvwOuH03gqeLFL+VAiQ+1m+3Oy5MzVQExCRZofwXTP91OW5r71dwu
mZzCVAliyU8WX6wDu6CRQXS/+J4jMMwUwBA31JsR5FEK6Ur2S57IB3ke6RTAcBkt
PtoGz1CUejWb3zqceJJXi38J0n2eG3NxLUGx+t9zH/C3bFDL1nxvyEFYxqiYROrQ
/2x9qBmvGvwtbajQ16sThvwaOMGna2+Te4kPd9hyFfDho4gDAJA=
=UeRU
-----END PGP SIGNATURE-----

--dzxg6puaa3vvfdw6--

