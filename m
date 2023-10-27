Return-Path: <linux-acpi+bounces-1069-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C846D7DA094
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 20:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050D91C2096B
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681F13D3A1
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35692F37
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 17:40:51 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162121BF;
	Fri, 27 Oct 2023 10:40:50 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5845b7ee438so236374eaf.1;
        Fri, 27 Oct 2023 10:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698428449; x=1699033249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KOnH5/FFvstAu2M3w0vaUabYFluUiI04lKVVVH2LdQ=;
        b=RRIcRFEhGZpvbBJmUetxEvtcY1WXRJiNJrTX2V8Ax1Fpsqxa26BxcsHrIfWa531P8x
         fqF0qcREtixV/4NYMpB99oXh7Up/VXgwADCUm5sxjfEkTv3okkDwMcBs/bwVKFMOgeG5
         qzHOeRiI6wfTloQEA7oWzrLUg5gL50LI6fKc5il9kWIGnbtwPOzwFPAuin/wgEtzlIT+
         F1vKC3C/B6idQ/xlv/YR1ejp4ksMFYtdy8cPSXwna5nUaCH6sbRiWNRW15pT+NH3elZB
         nT9LA+WCBgWfvvj56snZ3Zi5AcahNFuNg2uWCs0mmSXT8oWt0SdPvrAhnnQjLHd6wtUS
         hUhA==
X-Gm-Message-State: AOJu0YxXHoPhpO7U4Tohp0vvb/lcZMJAuf2yvok0zVf2dviPwqXf+s1B
	VmDLQB4qvvbyfMT/OQktrhCX1WGeU31cMPwRTF4=
X-Google-Smtp-Source: AGHT+IGmkTTYBTsiBopbSgUqEW96Xo90pG7nkLrU3+0tvfvjD6kzWW62O+UNb6lMLez0m5f5v/8h/bC9p8CaSbVyrGM=
X-Received: by 2002:a4a:4184:0:b0:57c:6e35:251e with SMTP id
 x126-20020a4a4184000000b0057c6e35251emr3635145ooa.1.1698428449329; Fri, 27
 Oct 2023 10:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026083335.12551-1-raag.jadav@intel.com> <20231027081855.GK3208943@black.fi.intel.com>
 <ZTuMo2qDO6Aqq3D_@black.fi.intel.com> <ZTvGaNZmGWpsM-yw@black.fi.intel.com>
 <20231027142856.GL3208943@black.fi.intel.com> <ZTvqYwFWm9PQeKIU@black.fi.intel.com>
 <CAJZ5v0hkB6Lm82ie6hfzFVDaqEj7DYxnYxD5NRQNXZxKZjL+xg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hkB6Lm82ie6hfzFVDaqEj7DYxnYxD5NRQNXZxKZjL+xg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Oct 2023 19:40:38 +0200
Message-ID: <CAJZ5v0i6H3aaDv1pPoygSHLLNA9YUr2AkMus=Cbb=KvyV5BEpg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
To: Raag Jadav <raag.jadav@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, rafael@kernel.org, len.brown@intel.com, 
	andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, 
	bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 7:19=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Oct 27, 2023 at 6:51=E2=80=AFPM Raag Jadav <raag.jadav@intel.com>=
 wrote:
> >
> > On Fri, Oct 27, 2023 at 05:28:56PM +0300, Mika Westerberg wrote:
> > > On Fri, Oct 27, 2023 at 05:17:12PM +0300, Raag Jadav wrote:
> > > > Or perhaps something like,
> > > >
> > > > bool acpi_dev_uid_match(struct acpi_device *adev, const void *uid2,=
 enum uid_type type)
> > > > {
> > > >         u64 uid1_d, uid2_d;
> > > >
> > > >         if (type =3D=3D UID_TYPE_STR) {
> > > >                 char *uid2_s =3D (char *)uid2;
> > > >                 if (!(uid2_s && !kstrtou64(uid2_s, 0, &uid2_d)))
> > > >                         return false;
> > > >         } else if (type =3D=3D UID_TYPE_INT) {
> > > >                 u64 *uid2_p;
> > > >                 uid2_p =3D (u64 *)uid2;
> > > >                 uid2_d =3D *uid2_p;
> > > >         } else {
> > > >                 return false;
> > > >         }
> > > >
> > > >         if (!acpi_dev_uid_to_integer(adev, &uid1_d) && uid1_d =3D=
=3D uid2_d)
> > > >                 return true;
> > > >         else
> > > >                 return false;
> > > > }
> > > >
> > > > Although this looks unnecessarily hideous.
> > >
> > > Indeed, but using the _Generic() you should be able to have
> > > a single acpi_dev_uid_match() to work for either type so:
> > >
> > > acpi_dev_uid_match(adev, "1")
> > >
> > > and
> > >
> > > acpi_dev_uid_match(adev, 1)
> > >
> > > would both work with type checkings etc.
> > >
> > > Not sure if this is worth the trouble though.
> >
> > Well, in that case we can probably try both and hope for the best ;)
> >
> > bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> > {
> >         const char *uid1 =3D acpi_device_uid(adev);
> >         u64 uid1_d;
> >
> >         return uid1 && uid2 && (!strcmp(uid1, uid2) ||
> >                (!kstrtou64(uid1, 0, &uid1_d) && uid1_d =3D=3D (u64)uid2=
));
> > }
> >
> > But I'm guessing the compiler wouldn't be very happy about this.
>
> IMO it would be better to use the observation that if the uid2 string
> can be successfully cast to an int and the device's unique_id string
> can't be cast to an int (or the other way around), there is no match.
>
> If they both can be cast to an int, they match as long as the casting
> results are equal.
>
> If none of them can be cast to an int,  they need to be compared as strin=
gs.

Or if the strings don't match literally, try to convert them both to
ints and compare.

