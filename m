Return-Path: <linux-acpi+bounces-12573-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7260A76FAE
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 22:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E812D3A4B49
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7052D21ABD7;
	Mon, 31 Mar 2025 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="rRoGAEd9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EE9211A0D
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454408; cv=none; b=UMMhGk09Ii5gmQ21+tYQp9Y+aPMrNvec7+AcrSxvbHv4bms7iJRoI+EItGnFu8YiQIHygd3/CvxU0sdHCrEFL2UDf35Qq+slwfOFcBKR6V7OxtGvjbr1bBsbxqGH3Y1u7KHe0lA5Fm48cfEz7arQtIBvQTr7+KSIWy1a4tgu9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454408; c=relaxed/simple;
	bh=oNDGxxkHrw+Om5ObecnhrF7R2RLhIGAP4yJSAHjUsiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xg2Pt1KCC5LzlgKCkhrgHzJyOp8rGTory5VIGpGbSsdH3ww7nWUz2JQa1s6cHIci9oHJkTi4nQWi77a9D+u/nagN4pJwNHllldk+NeRMhUsbf+wjx7jScR8I8N4/Wv421a+j3C7EMBM3FOEEMY6+o7oMGQTcf6yF2g+MtTtOwQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=rRoGAEd9; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 2B8AC2E09746
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 23:53:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1743454403;
	bh=2bo+0+xOgqqeRGpV2WGbZOY1ifDazEQqd8o1H2l5YXo=;
	h=Received:From:Subject:To;
	b=rRoGAEd9n7n9O3JSayEire82ZyqX4mffLFLaV+SCw6uQH44pljdCNUezoBewQ0u5e
	 L+BI2bAkiElowOk/p9TYR7606ebRbAN+dOqtGqPQyRaqVr5+QuaSdizZ2IayXdYpHr
	 EqJapqdeMMg+tB02l7Us6AzUZWqQ3GbskzsJPZXw=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.167.53) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f53.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5499614d3d2so5610572e87.3
        for <linux-acpi@vger.kernel.org>;
 Mon, 31 Mar 2025 13:53:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWh6v/3CYTi/ASMXrMD25X+XMt89Z2rgiM04FLHfl7IXCpEpGgZfxZP5vC5p6gimXJDstis5HMiJo0R@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ0Ixt7oU+ji2A4ZPWQfEX5v/+KFmGmKF2JbyueyayFqidePHd
	tkSvm+Z+yORkqgI01QoTEmhVYqPqw+lANwyB5ylXZW94w/C2QqE/3lg/cdC3xfGKdHFXycwSOgk
	3FoJx8qvizDapR3gdc0taD+ULUAY=
X-Google-Smtp-Source: 
 AGHT+IFyeqvAt9jr2fe3pLqTkin8KTiBTR7CpukDhJMo6UdzlXc6VqwlHgNwQ3bkS6c2422tmYXiIpca2PuP/Efz5Fk=
X-Received: by 2002:a2e:a99a:0:b0:30c:514d:92ed with SMTP id
 38308e7fff4ca-30de024b2camr27103051fa.14.1743454401518; Mon, 31 Mar 2025
 13:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331204442.1727618-1-superm1@kernel.org>
 <CAGwozwHyRiyVkX8rsc69gkALScWdtXNAvAGn7c2aEXW_qgdWsA@mail.gmail.com>
In-Reply-To: 
 <CAGwozwHyRiyVkX8rsc69gkALScWdtXNAvAGn7c2aEXW_qgdWsA@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 31 Mar 2025 22:53:10 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEiCXFDi73qAPSm2K9A8OZutE7dbjFfCmbUSAOTaz8SEA@mail.gmail.com>
X-Gm-Features: AQ5f1JqrhfKDYCCQos626Acj_K5rrWp4NTGv82ig9ERENVCFiAFSm1vINnycPUY
Message-ID: 
 <CAGwozwEiCXFDi73qAPSm2K9A8OZutE7dbjFfCmbUSAOTaz8SEA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
	Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174345440260.4209.14205495435530023244@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Mon, 31 Mar 2025 at 22:51, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Mon, 31 Mar 2025 at 22:44, Mario Limonciello <superm1@kernel.org> wrote:
> >
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > When AC adapter is unplugged or plugged in EC wakes from
> > HW sleep but APU doesn't enter back into HW sleep.
> >
> > The reason this hapens is that when APU exits HW sleep the power
> > rails the EC controls will power up the TCON.  The TCON has a
> > GPIO that will be toggled during this time.  The GPIO is not marked
> > as a wakeup source however GPIO controller still has an unserviced
> > interrupt and it will block entering HW sleep again. Clearing the
> > GPIO doesn't help, the TCON raises it again until it's been initialized
> > by i2c-hid.
> >
> > Fixing this would require TCON F/W changes and it's already broken
> > in the wild on production hardware.
> >
> > To avoid triggering this issue add a quirk to avoid letting EC wake
> > up system at all.  The power button still works properly on this system.
>
> Hi Mario,
> I reported this issue to you early in January, did all the debugging
> for it, found the cause, made this patch, tested it, and finally
> deployed it as well. Then sent it to Xino.
>
> Then you pushed back for perfectly valid reasons, and we had a
> multi-week long back and forth trying to find the proper cause for
> this.
>
> So from my side I do not get why I am just a reported-by here. This is
> my patch. We also had a discussion about this out of band.
>
> Antheas

It is interesting you ended up finding the cause. Which makes
attributing this a bit murkier.

Antheas
>
> > Cc: Xino JS1 Ni <nijs1@lenovo.com>
> > Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> > index 8db09d81918fb..3c5f34892734e 100644
> > --- a/drivers/acpi/ec.c
> > +++ b/drivers/acpi/ec.c
> > @@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
> >                         DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
> >                 },
> >         },
> > +       /*
> > +        * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
> > +        * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> > +        */
> > +       {
> > +               .matches = {
> > +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                       DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
> > +               }
> > +       },
> > +       {
> > +               .matches = {
> > +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                       DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
> > +               }
> > +       },
> > +       {
> > +               .matches = {
> > +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
> > +               }
> > +       },
> > +       {
> > +               .matches = {
> > +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
> > +               }
> > +       },
> >         { },
> >  };
> >
> > --
> > 2.43.0
> >

