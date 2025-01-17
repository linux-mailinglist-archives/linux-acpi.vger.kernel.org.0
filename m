Return-Path: <linux-acpi+bounces-10740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB19A15583
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 18:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1B9164C89
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AEA1A071C;
	Fri, 17 Jan 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF5aKWFi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C4819C54E;
	Fri, 17 Jan 2025 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134019; cv=none; b=Ph535uQr37P7Y6nyEgMuB4ZIzvUWA6dTp8OACUbahaA/q2GAzwvNXYcjdBmrwDtUFtW7XCx9RwYpdceNZJBDDxmLne8SjhezmY/11oVz0y7foxgI8zstNj3KIkRfc53lfzpeA7WQd19muW50vE8U7ldlTw5jGDREWqchJ3+thtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134019; c=relaxed/simple;
	bh=88zwPi95i8TGRX++ehEYkawsWqmTt1jSgpGw+UQlbB4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=s52ZM0STfmTtGi1cW1mUoHbPxs6Qb6xiv9LJUmI8Jgdbl7VDYX0gYYl+Bnxe0SzaWKmrkAEMtvUDzbTen4G/Y75sYIyPmqc1ET/a1Nx6gnWCuD4KMiJjV8yemRZYVbh3WUoFUD0+qYV6MfZk0zAUBXs3fU1qUzkd0BbmLRRVFgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XF5aKWFi; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3a26de697fso3866958276.3;
        Fri, 17 Jan 2025 09:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737134016; x=1737738816; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHYqZZZpEFvNcu8/A5zGEKORIHwppLRRSnG2PdaXAAk=;
        b=XF5aKWFiUuvqvTtYtCkStmBMsOi1XF1CQHMiGEzslvmPKwjREdaQLfZ0j9PZ93t8YE
         Wy5+bPVj0/+ECrHd58xyUb7YS+tBV7T04PtSGjO/ZsJP/Sj8IrLvYqNgt0pw6fpmolQp
         BlwplmbFDS5Dj2Sj9tiuwbagQyBvC1L/M73FHD9CZ4rwWrX1fruOi93TqNuuED9gHmie
         2XbUF5AziYBwUYqW6yyEepRtfpC+h0MihlrFYvKwmISE+blLpUGFr4NCRjzFsJQRR/Yy
         hpepYGXUs50lgtzGpANNx/qXfnk6TjZiCk6ed+6JzU9gxTAFClljZYGODrgRcFic0BIA
         JL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737134016; x=1737738816;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cHYqZZZpEFvNcu8/A5zGEKORIHwppLRRSnG2PdaXAAk=;
        b=Za6pLQORIoxhswM59tJ7qMDRJs3ffKJVrVan8hRjLyIBQETdeWuYFVxv6USG8HtvAA
         6idnZbXQzhkRQsRNEafKaoOSthVH8i/4SPqo8+/186IV4h+dyXa8k28YwnJJJIIqosTh
         r1Gy92QCG6fufv8iaOSqMfESnY0qPmuBV10yhWWjJQxqvAp3LskUKaJsEwPbvVN0knlW
         pHoF9lWJyMdTlyc88a6k6Xs4gVwZHgiRh7FfbBcOQB0AlpNigYXiFdstWHERkn4QowtX
         sogglhGmpTl4RVMnKjJMtwyzkfic4bi5j3mxyKvCnT00qHmCI/euzBPneIJh+dvCTxig
         t86g==
X-Forwarded-Encrypted: i=1; AJvYcCVgENTwiVMrKKV9RaibRAiZ0cxV15v+zbm/j7Sio6VhbTQ7j/YoEgElBBlrzrVVY1j0RTdotX/kV8f5bYOQ@vger.kernel.org, AJvYcCWoMa+PNfA2jn+Qkv1RTuZUzgGoZUUoBnYJRxNzm9PbEuwVFM80CY/XelQQJYWhRdyJufKHGZ309NJ1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3reGihxR5UrWrPxFm/zT3eNQi+U7101IkzDeLJWvB/PMYwklF
	QX1DvHUHDEFdm63Xv01qLuw6oPl/Uvxm2p8sJAY3jNEBFdEEgCXd
X-Gm-Gg: ASbGncvMJQ+bfWx993HAhCHh6BSkqjd5Ub63L0OLW9NpBKqHImO6B7o7gLdOMDXACCH
	7bBfhohgz73KJoF+tOShEZC1jjdjaUn5h5LWlR+6aQgh9Y68nM7uClfqANwcwu0B69F2V1LXmkN
	82SfvohZrsz9v4UuBxkQHPmr3Hc5tDTV9+4qWte53au3TdvqeQZZvQJqL2Igyjbvrwi76csxoGK
	6xlTQA/enwe8G+9gxPG28pWXg0lxMZ691J4/o2ApsNMZOlb
X-Google-Smtp-Source: AGHT+IG2EUHbYRNVTxQ/GuXHxPk7iFocd7V1wakf5SDx9glBW+/Jx/5qRD8sDYc52QFeB9AjVlCwdg==
X-Received: by 2002:a05:690c:6d11:b0:6ef:8e4c:65ea with SMTP id 00721157ae682-6f6eb64cd25mr26873657b3.5.1737134016397;
        Fri, 17 Jan 2025 09:13:36 -0800 (PST)
Received: from localhost ([2800:bf0:82:1159:c837:3446:190b:188d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e670a2e7sm4893467b3.122.2025.01.17.09.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 09:13:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jan 2025 12:13:32 -0500
Message-Id: <D74IM4AZ87C9.1R1S1KOA89PX7@gmail.com>
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Limonciello, Mario"
 <mario.limonciello@amd.com>, "Armin Wolf" <W_Armin@gmx.de>, "Joshua
 Grisham" <josh@joshuagrisham.com>, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, "Hans de Goede" <hdegoede@redhat.com>,
 "Maximilian Luz" <luzmaximilian@gmail.com>, "Lee Chun-Yi" <jlee@suse.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>, "Corentin Chary"
 <corentin.chary@gmail.com>, "Luke D . Jones" <luke@ljones.dev>, "Lyndon
 Sanche" <lsanche@lyndeno.ca>, "Ike Panhc" <ike.pan@canonical.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>, "Alexis Belmonte"
 <alexbelm48@gmail.com>, "Ai Chao" <aichao@kylinos.cn>, "Gergo Koteles"
 <soyer@irl.hu>, <Dell.Client.Kernel@dell.com>,
 <ibm-acpi-devel@lists.sourceforge.net>
Subject: Re: [PATCH v4 00/19] Hide platform_profile_handler from consumers
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Mark
 Pearson" <mpearson-lenovo@squebb.ca>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250116002721.75592-1-kuurtb@gmail.com>
 <1eb2720a-c9af-4e5c-8df2-c4ce3c017d5c@app.fastmail.com>
 <3aab5072-f032-7458-56af-1d45e89a5d44@linux.intel.com>
In-Reply-To: <3aab5072-f032-7458-56af-1d45e89a5d44@linux.intel.com>

On Fri Jan 17, 2025 at 11:42 AM -05, Ilpo J=C3=A4rvinen wrote:
> On Thu, 16 Jan 2025, Mark Pearson wrote:
>
> > Hi
> >=20
> > On Wed, Jan 15, 2025, at 7:27 PM, Kurt Borja wrote:
> > > Hi :)
> > >
> > > The merge window is about to open, so I rebased this patchset on top =
of
> > > pdx86/review-ilpo-next to pick up acer-wmi latest commits, in case we
> > > manage to squeeze this into v6.14.
> > >
> > > ~ Kurt
> > > ---
> > > v3 -> v4:
> > >
> > > [09/19]
> > >   - Replace error message with a user-friendly one
> > >
> > > v3:=20
> > > https://lore.kernel.org/platform-driver-x86/20250115071022.4815-1-kuu=
rtb@gmail.com/
> > >
> > > Kurt Borja (19):
> > >   ACPI: platform_profile: Replace *class_dev member with class_dev
> > >   ACPI: platform_profile: Let drivers set drvdata to the class device
> > >   ACPI: platform_profile: Remove platform_profile_handler from callba=
cks
> > >   ACPI: platform_profile: Add `ops` member to handlers
> > >   ACPI: platform_profile: Add `probe` to platform_profile_ops
> > >   platform/surface: surface_platform_profile: Use
> > >     devm_platform_profile_register()
> > >   platform/x86: acer-wmi: Use devm_platform_profile_register()
> > >   platform/x86: amd: pmf: sps: Use devm_platform_profile_register()
> > >   platform/x86: asus-wmi: Use devm_platform_profile_register()
> > >   platform/x86: dell-pc: Use devm_platform_profile_register()
> > >   platform/x86: ideapad-laptop: Use devm_platform_profile_register()
> > >   platform/x86: hp-wmi: Use devm_platform_profile_register()
> > >   platform/x86: inspur_platform_profile: Use
> > >     devm_platform_profile_register()
> > >   platform/x86: thinkpad_acpi: Use devm_platform_profile_register()
> > >   ACPI: platform_profile: Remove platform_profile_handler from export=
ed
> > >     symbols
> > >   ACPI: platform_profile: Move platform_profile_handler
> > >   ACPI: platform_profile: Clean platform_profile_handler
> > >   ACPI: platform_profile: Add documentation
> > >   ACPI: platform_profile: Add a prefix to log messages
> > >
> > >  .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
> > >  drivers/acpi/platform_profile.c               | 172 +++++++++++++---=
--
> > >  .../surface/surface_platform_profile.c        |  48 ++---
> > >  drivers/platform/x86/acer-wmi.c               | 114 ++++++------
> > >  drivers/platform/x86/amd/pmf/core.c           |   1 -
> > >  drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
> > >  drivers/platform/x86/amd/pmf/sps.c            |  51 +++---
> > >  drivers/platform/x86/asus-wmi.c               |  55 +++---
> > >  drivers/platform/x86/dell/alienware-wmi.c     |  34 ++--
> > >  drivers/platform/x86/dell/dell-pc.c           |  60 +++---
> > >  drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
> > >  drivers/platform/x86/ideapad-laptop.c         |  45 +++--
> > >  .../platform/x86/inspur_platform_profile.c    |  48 +++--
> > >  drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
> > >  include/linux/platform_profile.h              |  37 ++--
> > >  15 files changed, 495 insertions(+), 337 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-platform-pr=
ofile
> > >
> > >
> > > base-commit: d98bf6a6ed61a8047e199495b0887cce392f8e5b
> > > --=20
> > > 2.48.1
> >=20
> > For the series up to v4 commit 15/19:
> > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >=20
> > I need to go over the last few commits just once more, as there a few=
=20
> > pieces I need to get my head around - and I'm not going to get it done=
=20
> > this evening. Hope it's OK to add review for the bits that I have done.
>
> I, for the first time ever, tested filter-branch and after some initial=
=20
> hickups on how to specify the commit range, got your Reviewed-bys added
> with single command :-).

Awesome! I believe commit 15/19

a213108c01e0 ("ACPI: platform_profile: Remove platform_profile_handler from=
 exported symbols")

is still missing a rev-by by Mark, if there is still time.

~ Kurt

>
> While at it, I also managed to catch one rev-by line without any=20
> name+email (I assume it was b4 messing something up).
>
> I'll soon want to merge fixes branch into for-next though, and after that=
=20
> adding any rev-bys will not be as easy as it was now.


