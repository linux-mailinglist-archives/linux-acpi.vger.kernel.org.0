Return-Path: <linux-acpi+bounces-11267-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E8BA3A53A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 19:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3591706A4
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 18:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4200F27126C;
	Tue, 18 Feb 2025 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK4Qszlm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA89271260;
	Tue, 18 Feb 2025 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902710; cv=none; b=bKX4AZCVhp5kTUM1POGXe4A9HLIoL+STkMk9j2ILPE71XtGC/bLZhpQWfmFdIF2/szDy33eZdzfYDRh4yjVHWFIXrDGGqt1jlw3uibMljYhgHBAopEaXsegZr9PUSCxE/wp1sBszmjrViSPaoNWWmWnyM01g4z1DKWtPzkjQ/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902710; c=relaxed/simple;
	bh=LKySc1hd8oH3XoJ/e0kyHo+BUWiFLrywoT3DLOsEihY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Qoblnv0v2lah+BCxOq+Ot/6UAO0yI9oqrCaQI9HeA+lmHI7dFieBQt28Kf82yqNEGA/AZK45CD/jzDVloc4U2fcGsO3mSHfPs5u12n/Ws/+TSmXGABm7OqjZVNW4KOpoJsuMou39H/hbjO3CMeZgOKt4/fuWGHxrXerCWvOzHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK4Qszlm; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e479e529ebcso4300439276.3;
        Tue, 18 Feb 2025 10:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739902707; x=1740507507; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hstotl6P8U6u0g9i0+sH14I9qLS3HJ19iSYl9IIgYgE=;
        b=fK4QszlmoCQ3SPEha3cSQEpALEpyhysd842eczn8tTiD2o89kQrlHc5etxHeOb/CaG
         LjzH4DVoIu0Md9rOwbogIPZcE0qX1FYQ7rwRjyV/7iIpunDsc0TdxlzlnskvnnKu38gd
         +9biyfgUPhPY0POJXIULpeUVCbUAzLxrKhpsnqHhxf0uyWvfJYHtOKxAi8djMcgSj0Xr
         oMGZJ+/+o4Z6M/1KyFPmqh/hr5sHDbBrTtu4xFbuPssYmh3iqn6xMKBIu9uObj5DWkUO
         iUyUxh4jD80uN27TbAsbVrVtdf43V71+YV9NhZ1mdErxhDwI2y/iGY3xw1PyxMhU3Uq0
         vBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902707; x=1740507507;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hstotl6P8U6u0g9i0+sH14I9qLS3HJ19iSYl9IIgYgE=;
        b=G2JBuDoULBdwmyRpPKH8vqTY3FAn22QDACc00QMyqK0HJHbS1m2odY4geOK9i26GF0
         ac52NATWrj/X/Y02sSOQVspIMoQyuYj19tHbXzgVBmIchJAGGxDUgCAsfMPSD48Dog1U
         0AXOFfvTMTJTNmhpN45JyqUGeVF+Uro6cFcuBTA3nDRsrXDyoFbZJ8cGfPZeGf++UZLr
         fvXC4HNYHcB9Hv4+003F0N/CajuVfQTC6Uy87rpl73w5txIJ3PZrpm+LzReI2SS942GS
         5d+08Oc0JgLBx3yVRwtEyL9utAugMb22SnsAXCAwEEoo4s3N8qvuz1zOBrlJMJ7bhB/E
         NYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIFHUJ/EUKvd2yXPzkcQi7J0xyWIZQwFqmfmCDlO2SCADcm+wBafwInBCADGINIXAl20Jw3Jecxt1VJm3i@vger.kernel.org, AJvYcCXqFH+R7VFSBYypgA2rL1Z/47iIpCtX0iO21UxTy3Ri/VFoN6gsgtqc6lELSMxUxM598pDNn14LdJD8@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZZcQhpzUQSVAYf/753aRU5E9ROp46sp2PHnAjg1aMJS7bOXN
	Ydv9hX2xRsYqj0C57Du79zUeDVkpjSuXSfcrXJCeduTVL0gtgdwi
X-Gm-Gg: ASbGncutMiMZk1Hoomk7pIWdyUGSw5WdWqH9wYD82mUrPawCvn++b3Z8kwVfxd62EPj
	lOaTtesBNl6o4+XVutH/uoqgVIi0rHtFh5KibCdPtBygtqI++JuVnU/7+fp/wMCzJKgjLpHGZGu
	CC5q69vXIGec5dFu3c2X61kVpe9iCMlRPNvDskKXPpMRn3gG1B6V1FqcWN7+WIyQFA73r1OgHcR
	xeKbSHdAaeSiXFGIsEj1dvSNr+MKJ1AFDjjtMk8X8k80epzNmTR/TcYUj5KV4DZg1jD+MI4yO2l
	CdR1OHI=
X-Google-Smtp-Source: AGHT+IGECy+BuFFTQJsQbuaOJPeVq5YpsE5+g1Z9O5xWctB7M+z/Qj8nxMs5KPAkRQxY4+rQD1XK/A==
X-Received: by 2002:a05:6902:1208:b0:e57:4db7:6d51 with SMTP id 3f1490d57ef6-e5dc92fd402mr10197597276.32.1739902707408;
        Tue, 18 Feb 2025 10:18:27 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dae0da26csm3140099276.44.2025.02.18.10.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 10:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Feb 2025 13:18:25 -0500
Message-Id: <D7VS189559P4.BKIIWBE7VCPE@gmail.com>
Cc: "Len Brown" <lenb@kernel.org>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Limonciello, Mario"
 <mario.limonciello@amd.com>, "Armin Wolf" <W_Armin@gmx.de>, "Gergo Koteles"
 <soyer@irl.hu>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: platform_profile: Fix memory leak in
 profile_class_is_visible()
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Mark Pearson"
 <mpearson-lenovo@squebb.ca>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250212193058.32110-1-kuurtb@gmail.com>
 <9a8a5084-589d-4c45-a011-5bf4d0dfc8ba@app.fastmail.com>
 <CAJZ5v0hv3frfZCLgANBi-Kn8LCiuoWFSMcjDSipXQyycS5i1rw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hv3frfZCLgANBi-Kn8LCiuoWFSMcjDSipXQyycS5i1rw@mail.gmail.com>

On Tue Feb 18, 2025 at 1:07 PM -05, Rafael J. Wysocki wrote:
> On Sat, Feb 15, 2025 at 3:18=E2=80=AFAM Mark Pearson <mpearson-lenovo@squ=
ebb.ca> wrote:
>>
>>
>> On Wed, Feb 12, 2025, at 2:30 PM, Kurt Borja wrote:
>> > If class_find_device() finds a device it's reference count is
>> > incremented. Call put_device() to drop this reference before returning=
.
>> >
>> > Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI
>> > platform profile")
>> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> > ---
>> >  drivers/acpi/platform_profile.c | 8 +++++++-
>> >  1 file changed, 7 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/acpi/platform_profile.c
>> > b/drivers/acpi/platform_profile.c
>> > index fc92e43d0fe9..2ad53cc6aae5 100644
>> > --- a/drivers/acpi/platform_profile.c
>> > +++ b/drivers/acpi/platform_profile.c
>> > @@ -417,8 +417,14 @@ static int profile_class_registered(struct device
>> > *dev, const void *data)
>> >
>> >  static umode_t profile_class_is_visible(struct kobject *kobj, struct
>> > attribute *attr, int idx)
>> >  {
>> > -     if (!class_find_device(&platform_profile_class, NULL, NULL,
>> > profile_class_registered))
>> > +     struct device *dev;
>> > +
>> > +     dev =3D class_find_device(&platform_profile_class, NULL, NULL,
>> > profile_class_registered);
>> > +     if (!dev)
>> >               return 0;
>> > +
>> > +     put_device(dev);
>> > +
>> >       return attr->mode;
>> >  }
>> >
>> >
>> > base-commit: 3e3e377dd1f300bbdd230533686ce9c9f4f8a90d
>> > --
>> > 2.48.1
>> Good find. Looks good to me.
>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Applied as 6.15 material, thanks!

Hi Rafael,

Thank you!

I believe this should be merged as a fix for v6.14-rc4 before
commit 77be5cacb2c2 hits stable.

--=20
 ~ Kurt


