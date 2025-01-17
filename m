Return-Path: <linux-acpi+bounces-10731-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA62A148C8
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 05:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FFE3A9BEB
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 04:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CA81F63E5;
	Fri, 17 Jan 2025 04:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0FUaoRo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FCE25A658;
	Fri, 17 Jan 2025 04:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737087413; cv=none; b=knOEq+0MZrsFZCnoEJ/kIQzCbOqs3zV/PnL+J/BPbC9DXH0DJq9JRpBGwU7Y8eIE6GdyRqfhxf2IOzSfiPsHhBhiOV1vvqnq/SX6WQzQfWPIHl0KvY2AH6WiFnymyNTTYWveLMZ58w3YHIpGCBR5WIFLXCon4cl+JSr0T/LD5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737087413; c=relaxed/simple;
	bh=4kOvE7TSAT9BTzRnpArANe4qn8nlJixMsyVEd0YCx9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZumR9a0CpJph6OJY8nfQNxYrpJr0EyGlIeqMNU6mUgFfx8fAbBY+GBLRU+KgqKOfwbEl6wWmjj6OAAkvu42PIeoKBrCyRDd6RhacnRuPj4JD5450ooL/2RzPevXzas81Sh10/ILFMhrKP+RgBRPbKMMfcMm250YSc591iOFIiuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0FUaoRo; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e39f43344c5so2549089276.1;
        Thu, 16 Jan 2025 20:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737087410; x=1737692210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2E6iUPlED261n9mGg6iUNwOok9VxRhISzx3ayTm3xs=;
        b=R0FUaoRo9+bnk7cmO40YvlJ3Z8BJm3Eprno4Qj3Su1QHvKd9TVCMmSuCZYDEBgVewp
         yUeH7lKdtA2p9GvxTLZT74DGxC4xDCkJe9bMssNh60sNpZ7QsduoA8yhkVPZNN6ieYLx
         qVYrrQKReI4sJlv6qgS+6x66H7YHUQkHSyfcdlwIY2ltBAn4wVZv3rMwIgJyeqRXiQ+A
         wpNEaV9LnLXdBW8uSITH0+qx6ZIh4usOPKs3zl93lumxrvOMMliCcttkk8leerpvrVE1
         vnbfThEfN1zoEV7jw5NJGklVkI4rBldLn5M2J4h973d32T6iZwIQ5NiyG/E6WlH8DPp9
         LDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737087410; x=1737692210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2E6iUPlED261n9mGg6iUNwOok9VxRhISzx3ayTm3xs=;
        b=QLtl9Dumk8YAIDWzwhtQ1lfB7+H1uqzh4MFfcqFqlz1aZeXBS2p7lTdEDL6EuQomUh
         /TVeR5lUr8sXiANmkYrWyCatzaPrZ1VU/sjfIwzMS4zINH7Tlo+Z2diZt4o+rWCDZ0uh
         EHrMQG42+cMA9BNR0Gxgu6XAm5mAhs49U7GjUwmPXVqVC3grIRRQktySFYlIclPXajAd
         p7cnU1jpzf+BmzEPm419GCk1VaNBeey7TsrAICqaacN/5RINXoQ4k9OVgsGdkwbzDDjJ
         ZS3i0GB3D4q19I4RB7lGserrQW1qxlJ+K6n0RJNeNh5XOW25K5TU0Gko/XPdJXjv1s6d
         OM3A==
X-Forwarded-Encrypted: i=1; AJvYcCVNX0pEgbRVQrN4+ZoZlG1VFgVKMCF9fdpHO1EIL0Oq5Boa1RVCDNRZbGsFns8oMmm7dfNtnyGtFCwk@vger.kernel.org, AJvYcCXw6mEhLcHqGfuWQPaDjYTEbJLPtE0NCG+OwPyHfb36+I7huCNZSiGB1Y5p3hJUnngb6TjjyzRhh8LnaurH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsqki0pR6JtbM4P1aC1cBpcWgRKyuNK3Q5n47jON0G1LArAeNr
	dvsJh49D+aDQCwHlBH3G3eEtHcxhavIejRDIE1ZZNwsEOBjpeeWp
X-Gm-Gg: ASbGncs+ZC3cwFSRBDOmjaIoQV4TZOq1ChqDOkmutnIUiRfTSYsv50lJ1OXfTgDmD9e
	SSA+sZJnFVxsA1mvf1RGDtC8bQfBCy481kmEmRIzYM4FYQ6zOoMy5oMFwL3Oq/+DaMMIMOrADR6
	ap1l8lTrILQLUURjw0+doz2+fNS+vIDWtaaqQv9gfH/1POXCcP4OomtzaC1+olsnUEiJae2FGEh
	lGJnqa3jCllS2yugJBTy9pYt5zS76R+UQlTpg4oHVwvbxFlfrdLK8i2Q8xp8TumVw==
X-Google-Smtp-Source: AGHT+IGszIJsbwNcoREb/V1CBqOTbNU27ac+G7EdPoMOV1+G8pTqWClfi4gVeCejQzML+9KXUpnFxw==
X-Received: by 2002:a05:690c:3082:b0:6ef:90a7:16ec with SMTP id 00721157ae682-6f6eb9296b2mr6760897b3.28.1737087410027;
        Thu, 16 Jan 2025 20:16:50 -0800 (PST)
Received: from alphacentauri.localnet ([2800:bf0:82:1159:c837:3446:190b:188d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e66f53dbsm2980297b3.103.2025.01.16.20.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 20:16:49 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>,
 Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Maximilian Luz <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Lyndon Sanche <lsanche@lyndeno.ca>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>,
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 00/19] Hide platform_profile_handler from consumers
Date: Thu, 16 Jan 2025 23:16:44 -0500
Message-ID: <5023429.31r3eYUQgx@alphacentauri>
In-Reply-To: <a5f7d82f-23a7-8e6a-9e68-9f302cf177d7@linux.intel.com>
References:
 <20250116002721.75592-1-kuurtb@gmail.com>
 <a5f7d82f-23a7-8e6a-9e68-9f302cf177d7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, January 16, 2025 11:09:49=E2=80=AFAM Colombia Standard Time Il=
po J=C3=A4rvinen=20
wrote:
> On Wed, 15 Jan 2025, Kurt Borja wrote:
>=20
> > The merge window is about to open, so I rebased this patchset on top of
> > pdx86/review-ilpo-next to pick up acer-wmi latest commits, in case we
> > manage to squeeze this into v6.14.
>=20
> Hi all,
>=20
> I was hoping to finish this in this cycle since it has been so close and=
=20
> has only required minor tweaks recently.
>=20
> I went to review the changes once again and ended up applying this now=20
> into the review-ilpo-next branch. Thank you all who worked on to improve=
=20
> this series! :-)

Thank you Mario, Ilpo and Mark for reviewing this :)

>=20
> There were minor nits, however, I hadto address while applying. I added=20
> the justification into 5/19 commit message and changed a few trivial=20
> things in the code. Please check that the diff compared with your series=
=20
> w/o any modifications makes sense:
>=20
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/
Documentation/ABI/testing/sysfs-class-platform-profile
> index b5a3600080bc..dc72adfb830a 100644
> --- a/Documentation/ABI/testing/sysfs-class-platform-profile
> +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
> @@ -1,12 +1,15 @@
>  What:		/sys/class/platform-profile/platform-profile-X/name
> -Date:		January 2025
> +Date:		March 2025
> +KernelVersion:	6.14
>  Description:	Name of the class device given by the driver.
> =20
>  		RO
> =20
>  What:		/sys/class/platform-profile/platform-profile-X/choices
> -Date:		January 2025
> -Description:	This file contains a space-separated list of profiles=20
supported for this device.
> +Date:		March 2025
> +KernelVersion:	6.14
> +Description:	This file contains a space-separated list of profiles=20
supported
> +		for this device.
> =20
>  		Drivers must use the following standard profile-names:
> =20
> @@ -26,7 +29,8 @@ Description:	This file contains a space-separated list=
=20
of profiles supported for
>  		RO
> =20
>  What:		/sys/class/platform-profile/platform-profile-X/profile
> -Date:		January 2025
> +Date:		March 2025
> +KernelVersion:	6.14
>  Description:	Reading this file gives the current selected profile=20
for this
>  		device. Writing this file with one of the strings from
>  		platform_profile_choices changes the profile to the new=20
value.
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index c9e46b6e27da..fc92e43d0fe9 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -540,7 +540,7 @@ struct device *platform_profile_register(struct devic=
e=20
*dev, const char *name,
>  	pprof->dev.parent =3D dev;
>  	dev_set_drvdata(&pprof->dev, drvdata);
>  	dev_set_name(&pprof->dev, "platform-profile-%d", pprof->minor);
> -	/* device_register() takes ownership of ppdev */
> +	/* device_register() takes ownership of pprof/ppdev */
>  	ppdev =3D &no_free_ptr(pprof)->dev;
>  	err =3D device_register(ppdev);
>  	if (err) {
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-
wmi.c
> index 9a485f777591..1032c0e84e3d 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3894,7 +3894,7 @@ static int platform_profile_setup(struct asus_wmi=20
*asus)
>  	asus->ppdev =3D devm_platform_profile_register(dev, "asus-wmi", asus,
>  						    =20
&asus_wmi_platform_profile_ops);
>  	if (IS_ERR(asus->ppdev)) {
> -		dev_err(dev, "Failed to register a platform_profile=20
class device");
> +		dev_err(dev, "Failed to register a platform_profile class=20
device\n");
>  		return PTR_ERR(asus->ppdev);
>  	}
> =20
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/d=
ell/
dell-pc.c
> index 1874d4adfb8a..483240bb36e7 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -270,17 +270,16 @@ static int thermal_init(void)
>  	if (IS_ERR(platform_device))
>  		return PTR_ERR(platform_device);
> =20
> -	/* Clean up if failed */
>  	ppdev =3D devm_platform_profile_register(&platform_device->dev,=20
"dell-pc",
>  					       NULL,=20
&dell_pc_platform_profile_ops);
>  	if (IS_ERR(ppdev)) {
>  		ret =3D PTR_ERR(ppdev);
> -		goto cleanup_thermal_handler;
> +		goto cleanup_platform_device;
>  	}
> =20
>  	return 0;
> =20
> -cleanup_thermal_handler:
> +cleanup_platform_device:
>  	platform_device_unregister(platform_device);
> =20
>  	return ret;

Changes LGTM, thanks.

~ Kurt

>=20
>=20
> >=20
> > ~ Kurt
> > ---
> > v3 -> v4:
> >=20
> > [09/19]
> >   - Replace error message with a user-friendly one
> >=20
> > v3: https://lore.kernel.org/platform-driver-x86/20250115071022.4815-1-k=
uurtb@gmail.com/
> >=20
> > Kurt Borja (19):
> >   ACPI: platform_profile: Replace *class_dev member with class_dev
> >   ACPI: platform_profile: Let drivers set drvdata to the class device
> >   ACPI: platform_profile: Remove platform_profile_handler from callbacks
> >   ACPI: platform_profile: Add `ops` member to handlers
> >   ACPI: platform_profile: Add `probe` to platform_profile_ops
> >   platform/surface: surface_platform_profile: Use
> >     devm_platform_profile_register()
> >   platform/x86: acer-wmi: Use devm_platform_profile_register()
> >   platform/x86: amd: pmf: sps: Use devm_platform_profile_register()
> >   platform/x86: asus-wmi: Use devm_platform_profile_register()
> >   platform/x86: dell-pc: Use devm_platform_profile_register()
> >   platform/x86: ideapad-laptop: Use devm_platform_profile_register()
> >   platform/x86: hp-wmi: Use devm_platform_profile_register()
> >   platform/x86: inspur_platform_profile: Use
> >     devm_platform_profile_register()
> >   platform/x86: thinkpad_acpi: Use devm_platform_profile_register()
> >   ACPI: platform_profile: Remove platform_profile_handler from exported
> >     symbols
> >   ACPI: platform_profile: Move platform_profile_handler
> >   ACPI: platform_profile: Clean platform_profile_handler
> >   ACPI: platform_profile: Add documentation
> >   ACPI: platform_profile: Add a prefix to log messages
> >=20
> >  .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
> >  drivers/acpi/platform_profile.c               | 172 +++++++++++++-----
> >  .../surface/surface_platform_profile.c        |  48 ++---
> >  drivers/platform/x86/acer-wmi.c               | 114 ++++++------
> >  drivers/platform/x86/amd/pmf/core.c           |   1 -
> >  drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
> >  drivers/platform/x86/amd/pmf/sps.c            |  51 +++---
> >  drivers/platform/x86/asus-wmi.c               |  55 +++---
> >  drivers/platform/x86/dell/alienware-wmi.c     |  34 ++--
> >  drivers/platform/x86/dell/dell-pc.c           |  60 +++---
> >  drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
> >  drivers/platform/x86/ideapad-laptop.c         |  45 +++--
> >  .../platform/x86/inspur_platform_profile.c    |  48 +++--
> >  drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
> >  include/linux/platform_profile.h              |  37 ++--
> >  15 files changed, 495 insertions(+), 337 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-platform-prof=
ile
> >=20
> >=20
> > base-commit: d98bf6a6ed61a8047e199495b0887cce392f8e5b
> >=20
>=20
>=20





