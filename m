Return-Path: <linux-acpi+bounces-1068-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A977DA092
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 20:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CECB21012
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 18:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CF83D38B
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BAC168B2
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 17:20:05 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F89128;
	Fri, 27 Oct 2023 10:20:01 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57f137dffa5so298908eaf.1;
        Fri, 27 Oct 2023 10:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698427200; x=1699032000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AStNFe6wJs0Em1n6/3g792uBA5JpFkSsw8YocrKn8w=;
        b=Cva7tRbjzJe4Km7Zh/mWL+yU7NRune2ybcpGY8RUdaCJFdM+xncyHlBsxR3O2kWas4
         6m954i4r78O8oVU1wGCavkmPnaT8Y76regSOWvKcARV/IJf9b63qckw3d6g4SLvQJXb7
         2dc41yJnYVWPeHYEGXhY9uVpuG+erIg5zbK4Vw3San1TSmb8sf3V4b3ciG3XgMDouoTp
         FLsKwMIl4rsLEnkybFpQsZKIZdgsAJJTRcsqksiXJQVq7fJQNNXZ7ZQsjaqOzf9mpkRK
         xZK+MWg7jdPxHTcnpoCk/Iycn1QCbNlIYNMwsNachNUBs8mLBjwXmJBqApUYYKgowdaw
         xjIg==
X-Gm-Message-State: AOJu0YyW62m3SnCbpHYjP7oNFjIJPI+AHegD0S7OJPH390CTytxlVLOz
	j+0USL3V4UvJiJOkXcUEFjyR6IplHWznCiy0eqA=
X-Google-Smtp-Source: AGHT+IEnXHCS3D+uVxFVTEqni2SKA3ep1nI5wWXs/L9Fl6BbY/lCs8bMTxxhZjIi9+46bSyv0CUH4gjB3QbplFb5d3A=
X-Received: by 2002:a4a:d743:0:b0:584:17d0:de3d with SMTP id
 h3-20020a4ad743000000b0058417d0de3dmr3482378oot.1.1698427200507; Fri, 27 Oct
 2023 10:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026083335.12551-1-raag.jadav@intel.com> <20231027081855.GK3208943@black.fi.intel.com>
 <ZTuMo2qDO6Aqq3D_@black.fi.intel.com> <ZTvGaNZmGWpsM-yw@black.fi.intel.com>
 <20231027142856.GL3208943@black.fi.intel.com> <ZTvqYwFWm9PQeKIU@black.fi.intel.com>
In-Reply-To: <ZTvqYwFWm9PQeKIU@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Oct 2023 19:19:49 +0200
Message-ID: <CAJZ5v0hkB6Lm82ie6hfzFVDaqEj7DYxnYxD5NRQNXZxKZjL+xg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
To: Raag Jadav <raag.jadav@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, rafael@kernel.org, len.brown@intel.com, 
	andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, 
	bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 6:51=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> On Fri, Oct 27, 2023 at 05:28:56PM +0300, Mika Westerberg wrote:
> > On Fri, Oct 27, 2023 at 05:17:12PM +0300, Raag Jadav wrote:
> > > Or perhaps something like,
> > >
> > > bool acpi_dev_uid_match(struct acpi_device *adev, const void *uid2, e=
num uid_type type)
> > > {
> > >         u64 uid1_d, uid2_d;
> > >
> > >         if (type =3D=3D UID_TYPE_STR) {
> > >                 char *uid2_s =3D (char *)uid2;
> > >                 if (!(uid2_s && !kstrtou64(uid2_s, 0, &uid2_d)))
> > >                         return false;
> > >         } else if (type =3D=3D UID_TYPE_INT) {
> > >                 u64 *uid2_p;
> > >                 uid2_p =3D (u64 *)uid2;
> > >                 uid2_d =3D *uid2_p;
> > >         } else {
> > >                 return false;
> > >         }
> > >
> > >         if (!acpi_dev_uid_to_integer(adev, &uid1_d) && uid1_d =3D=3D =
uid2_d)
> > >                 return true;
> > >         else
> > >                 return false;
> > > }
> > >
> > > Although this looks unnecessarily hideous.
> >
> > Indeed, but using the _Generic() you should be able to have
> > a single acpi_dev_uid_match() to work for either type so:
> >
> > acpi_dev_uid_match(adev, "1")
> >
> > and
> >
> > acpi_dev_uid_match(adev, 1)
> >
> > would both work with type checkings etc.
> >
> > Not sure if this is worth the trouble though.
>
> Well, in that case we can probably try both and hope for the best ;)
>
> bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> {
>         const char *uid1 =3D acpi_device_uid(adev);
>         u64 uid1_d;
>
>         return uid1 && uid2 && (!strcmp(uid1, uid2) ||
>                (!kstrtou64(uid1, 0, &uid1_d) && uid1_d =3D=3D (u64)uid2))=
;
> }
>
> But I'm guessing the compiler wouldn't be very happy about this.

IMO it would be better to use the observation that if the uid2 string
can be successfully cast to an int and the device's unique_id string
can't be cast to an int (or the other way around), there is no match.

If they both can be cast to an int, they match as long as the casting
results are equal.

If none of them can be cast to an int,  they need to be compared as strings=
.

