Return-Path: <linux-acpi+bounces-12805-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE78FA7E943
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 20:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050747A544E
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CEB2185B8;
	Mon,  7 Apr 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9vJPBrU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25BB21146F
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048930; cv=none; b=nDPhV+qJgh+GGD/2Zr1WMMXUTVXHAhb5ry6a8tSO3oWlvjA3rDSouFPX0vRXBVVSvCaWP6QFlb54xDxAB+sqJCWu7Q1OLaoaU+p9WeWkCq3cCXSFoh7KkYEXG6WvtVnmx+KjtzZcegUwE//eLJ8aT6crBUg4BwYgmCXM/ETsmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048930; c=relaxed/simple;
	bh=V1t+95YljFnfmDI6NtZpK4+ksHhw3vreEY87TKDAPfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chPmiJ5VLiR9W72xSy1xalwmBWhZ2347VWdEMLxSRkz3krqFHJbn1qucqH9J1R+ZZi8I0AKjdnzOxRTmpBoYVzbTHKLC5UmTHUVnrYPCQzG9XTVuo4ixBKJrr/zElhsfGNBh9UWAuUKSqakotaGOoWm/5a+U4YWenCsYriSY/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9vJPBrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34648C4CEEA
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2025 18:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744048930;
	bh=V1t+95YljFnfmDI6NtZpK4+ksHhw3vreEY87TKDAPfk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N9vJPBrU4ZOmOYn6GphK6iFFIW74oOzxGEeM2PwV/wu4jOZ/QXx0gF8kDvIQOippF
	 lgFHE8XzZrEDL7r9XaAcCF6VRgwryuLsSvD7dkxhez1EHtFUIsz7j6uwh8G21YRNnF
	 yzhy7Amfw8ioD/jZD/6HpOMx5EznC6RNJ1HwN/4wtfnuK6YaUilXmkEIUuR/KNsEqx
	 /O2HCzsfvkAEyDl3vu4X9Ur+eya7PMaI/SL0VkMPwbSQqVAceEZSwT7DOA7U+7m30K
	 93zVF2dmezRloybkyAPCD24WbRunFYTvdeBMhlCpE1KKhbV0Dgm4IEtPZTJdjDnJ3w
	 aKHwq9BlbixqQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c7e5f7f0e3so1374332fac.3
        for <linux-acpi@vger.kernel.org>; Mon, 07 Apr 2025 11:02:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVLnWg6H/kOhfYcfDcU2PGP5hyvzC52aiFhEDMaR8k/JS1/Qlt1U7LgjGN9J+Dd7ptToIZem+bGZCt@vger.kernel.org
X-Gm-Message-State: AOJu0YwT2o0dit664kzR9OEurmHLAFX/78szWj6xPwlfWuvilToQzOL2
	lNHVZkyrmG70grFV6x3rYU9RcPepKJOM8nuizW1pSJYSFqFBGPiBUHMXekmHMuwKKGE2O9I/FaV
	s17j3lJoie/+wWD4FO0jbAWpD4AQ=
X-Google-Smtp-Source: AGHT+IFoPPtFPnm5N32gizEBa8recub1gQOW6KCENwDgw/CsX4KZvMlp8tnzTCO/BzM+KCYvWODCGUQb23gnljflckw=
X-Received: by 2002:a05:6870:e984:b0:29e:6547:bffa with SMTP id
 586e51a60fabf-2cc9e62d1a7mr8153526fac.21.1744048929447; Mon, 07 Apr 2025
 11:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401133858.1892077-1-superm1@kernel.org> <CAJZ5v0gqFhUSu5_JiA3Z3qZACcqa+9Tdqv6DqHCq_b5HGbF7Sg@mail.gmail.com>
 <a089c36a-09e1-445a-b689-a41163ca3db3@kernel.org>
In-Reply-To: <a089c36a-09e1-445a-b689-a41163ca3db3@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Apr 2025 20:01:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0is9fvi+jbCgZbPmZgH6arKumu8Bs-+UmF5TCsB0vrSzQ@mail.gmail.com>
X-Gm-Features: ATxdqUF3qaVLLJuP9TdMxXAgtUirU2sNgCRnAT8_1M37MvyX85pZL4UgzWq2YmM
Message-ID: <CAJZ5v0is9fvi+jbCgZbPmZgH6arKumu8Bs-+UmF5TCsB0vrSzQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mario.limonciello@amd.com, 
	Xino JS1 Ni <nijs1@lenovo.com>, Antheas Kapenekakis <lkml@antheas.dev>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 4:18=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 4/1/2025 8:48 AM, Rafael J. Wysocki wrote:
> > On Tue, Apr 1, 2025 at 3:39=E2=80=AFPM Mario Limonciello <superm1@kerne=
l.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> When AC adapter is unplugged or plugged in EC wakes from
> >> HW sleep but APU doesn't enter back into HW sleep.
> >>
> >> The reason this happens is that when APU exits HW sleep the power rail=
s
> >> the EC controls will power up the TCON.
> >
> > I think that the above should be
> >
> > "The reason this happens is that, when the APU exits HW sleep, the
> > power rails controlled by the EC will power up the TCON."
> >
> > If I'm not mistaken, please let me know and I'll make this change when
> > applying the patch.
>
> Sounds good, thanks!

Now applied as 6.15-rc material with the above modification and some
other minor edits in the changelog.

Thanks!

> >> The TCON has a GPIO that will
> >> be toggled during this time.  The GPIO is not marked as a wakeup sourc=
e,
> >> however GPIO controller still has an unserviced interrupt. Unserviced
> >> interrupts will block entering HW sleep again. Clearing the GPIO doesn=
't
> >> help as the TCON continues to assert it until it's been initialized by
> >> i2c-hid.
> >>
> >> Fixing this would require TCON F/W changes and it's already broken
> >> in the wild on production hardware.
> >>
> >> To avoid triggering this issue add a quirk to avoid letting EC wake
> >> up system at all.  The power button still works properly on this syste=
m.
> >>
> >> Cc: Xino JS1 Ni <nijs1@lenovo.com>
> >> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> >> Link: https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1=
e808c72e6b1836da4a95fc63
> >> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> >> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v2:
> >>   Add more tags
> >>   Fix a typo and grammar in commit
> >> ---
> >>   drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
> >>   1 file changed, 28 insertions(+)
> >>
> >> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> >> index 8db09d81918fb..3c5f34892734e 100644
> >> --- a/drivers/acpi/ec.c
> >> +++ b/drivers/acpi/ec.c
> >> @@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wa=
keup[] =3D {
> >>                          DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP=
 ZHAN 66 Pro"),
> >>                  },
> >>          },
> >> +       /*
> >> +        * Lenovo Legion Go S; touchscreen blocks HW sleep when woken =
up from EC
> >> +        * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> >> +        */
> >> +       {
> >> +               .matches =3D {
> >> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
> >> +               }
> >> +       },
> >> +       {
> >> +               .matches =3D {
> >> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
> >> +               }
> >> +       },
> >> +       {
> >> +               .matches =3D {
> >> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
> >> +               }
> >> +       },
> >> +       {
> >> +               .matches =3D {
> >> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
> >> +               }
> >> +       },
> >>          { },
> >>   };
> >>
> >> --
> >> 2.43.0
> >>
>

