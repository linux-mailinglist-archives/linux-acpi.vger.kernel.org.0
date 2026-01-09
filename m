Return-Path: <linux-acpi+bounces-20121-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 854E6D0C43E
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 22:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9C5F300DCA8
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 21:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1655531D399;
	Fri,  9 Jan 2026 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie5rITgC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E705D28C874
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993101; cv=none; b=B6uzQq4DvGn1cWGsl0f+Fe+RD3uVM78A6litXWUZkMsCXdFgUe4OcyHPpX9pHXFDXlxi/p07xQtkjtMKgx4ayNCWlozezSH8CU6ipCsd4hXKEs3PwOxq1VJSuZfzmYWAEkDVlaehxg5pwhz8MS4yxrngPz2P0a8Jw/Rpx5HgMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993101; c=relaxed/simple;
	bh=i2e4BgmPCtMxCitIw9sJXKT1haE9ND24uoYLDY6d2H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpKp+s7jnP9VHl98pIFdfjNmr5kauyYcovxHENsUCv0C65Y/8It/L6Txr3l6G8oh2hmdF/WQhzQdrsxiGk8iIGkVnwpNRPAV5rc+5xsCcbkEjKYMRWujgqVpIwjtChtISaaITLDcvq0zNrLgQOOXMJTJsf5DxFkXaIFIksFSyGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie5rITgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866CFC16AAE
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 21:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767993100;
	bh=i2e4BgmPCtMxCitIw9sJXKT1haE9ND24uoYLDY6d2H8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ie5rITgCO7OEWUdG45IhB8rB4DU2xNlX+wg5sy82xbnDkd/vrE0OdZskU7jKbUT1e
	 92Xtjro97mkiInzjW9KH/c2u43gMfHQKoSAHkV9ovkBeJpyX5hPNXeEb1czjzHrur4
	 cl5GzPdPFpQbSAVdGiD0Y1o8Mc7SBqgmhaM81hdNMXJw+/wPW5qzYACpwWhBzYndFG
	 mlKll1wS+oVv5Unur2Rj/1+pnQ0mkVgoZLJFKz+/S89yGHIuyK1XxAQfZQGP8Zr5xv
	 x6L9dbtdx8762q14dY7L1pqWQBAwFbtTTNJgzN5ZJsmsyTX/qtPg6HfVeNau+rYMWM
	 cfKUtBBIAPa7Q==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3f0c93ecf42so2294415fac.0
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 13:11:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6Od3gsm7NEcu8ak9bvzZR/G5yT/m+8W/Yc50PzrZMpZCzCuOUIKQXlyouzZj61o35kMq7LNFtF0th@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNwxRM4A6407KeEvSD5fn/TYqNJvUDl84rTQNgRJrB5RRQ7ZG
	GHZZKc86Jm1oqZusS4TqNEM+Bk0+w2HWh+kjB9PTuOuUfKc7jczuAL1+A6txyyioJEI/Gg0h1Jc
	b098sEy+rsa5fq9/ttqVdEu//5GYeNO0=
X-Google-Smtp-Source: AGHT+IHP3Iszz7zad/0sWM0OL4kZbKwvjl9/FdP38PT0tAITiMRYxq89hygja6GZJQxvHFNtqTk0EC0mOJA/Hc/eLio=
X-Received: by 2002:a05:6870:93c3:b0:3ec:42e9:e7b3 with SMTP id
 586e51a60fabf-3ffa24c4ae2mr8489323fac.13.1767993099662; Fri, 09 Jan 2026
 13:11:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109095358.24265-1-kkartik@nvidia.com> <20260109101302.GW2275908@black.igk.intel.com>
 <aWDhEBjy9b9_uzoR@smile.fi.intel.com> <aWDmt3CA5h_i9Hij@kekkonen.localdomain> <aWE0uuZjB1iMGF2B@smile.fi.intel.com>
In-Reply-To: <aWE0uuZjB1iMGF2B@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Jan 2026 22:11:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ijTQC2cFTt+hW-ofJwMqdEeES8d5MMbbq8_Bqg+_9E3g@mail.gmail.com>
X-Gm-Features: AQt7F2petwX6C127Qyv2TLEv6Ia5cxyHLQRN7zhZNH7Q_lsKS2ItECKOK7qDeNs
Message-ID: <CAJZ5v0ijTQC2cFTt+hW-ofJwMqdEeES8d5MMbbq8_Bqg+_9E3g@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: bus: Use OF match data for PRP0001 matched devices
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Kartik Rajput <kkartik@nvidia.com>, lenb@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 6:02=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jan 09, 2026 at 01:29:59PM +0200, Sakari Ailus wrote:
> > On Fri, Jan 09, 2026 at 01:05:52PM +0200, Andy Shevchenko wrote:
> > > On Fri, Jan 09, 2026 at 11:13:02AM +0100, Mika Westerberg wrote:
> > > > On Fri, Jan 09, 2026 at 03:23:58PM +0530, Kartik Rajput wrote:
> > > > > During pre-production development, drivers may provide both ACPI =
and OF
> > > > > match tables while a formal ACPI HID for the device is not yet
> > > > > allocated. Such devices are enumerated via PRP0001. In this case,
> > > > > acpi_device_get_match_data() consults only the driver=E2=80=99s A=
CPI match table
> > > > > and returns NULL, even though the device was successfully matched=
 via
> > > > > PRP0001.
> > > > >
> > > > > This behavior also risks breaking existing PRP0001 setups if a dr=
iver
> > > > > later gains an ACPI HID, as the presence of an ACPI match table c=
hanges
> > > > > the match-data lookup path.
> > > > >
> > > > > Explicitly detect PRP0001 and fetch match data from the driver's
> > > > > OF match table via acpi_of_device_get_match_data().
>
> ...
>
> > > > >         const struct acpi_device_id *acpi_ids =3D dev->driver->ac=
pi_match_table;
> > > > > +       struct acpi_device *adev =3D ACPI_COMPANION(dev);
> > > > >         const struct acpi_device_id *match;
> > > > >
> > > > > -       if (!acpi_ids)
> > > > > +       if (!adev)
> > > > > +               return NULL;
> > > > > +
> > > > > +       if (!strcmp(acpi_device_hid(adev), ACPI_DT_NAMESPACE_HID)=
)
> > > > >                 return acpi_of_device_get_match_data(dev);
> > >
> > > On top of what Mika asked, shouldn't we check CID as well? Theoretica=
lly it's
> > > possible that some device may have HID "blablabla" and CID PRP0001, I=
 don't
> > > remember what documentation says about this case, though.
> >
> > According to Documentation/firmware-guide/acpi/enumeration.rst PRP0001 =
is
> > also valid for _CID. So yes, I think this should be checked as well -- =
I'd
> > loop over the &device->pnp.ids list.
>
> Yeah, but if we have a device with
>
> HID "blablabla"
> CID "PRP0001"
>
> and at the same time the driver has ACPI ID listed, we should probably us=
e that
> one as HID should have higher weight for matching. Logic here is not just=
 as simple
> as looping over pnp.ids how I see it.

Right.

What about:

if (acpi_ids) {
       match =3D acpi_match_device(acpi_ids, dev);
       if (match)
               return (const void *)match->driver_data;
}
return acpi_of_device_get_match_data(dev);

