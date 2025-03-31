Return-Path: <linux-acpi+bounces-12575-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB4BA76FFF
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 23:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73563AA645
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 21:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD52C1C84D6;
	Mon, 31 Mar 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Cf9d4p+0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCFC14601C
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743455794; cv=none; b=QJPtYTY3oh7WmSaoCOhcgYdqDi3hi1SsC2oiONcTay51tzJtqggCgYSUiApsD5QniYMFMfWoRxkS/g5xIjnm2N1kZVhMLVa6kc+3yVh/e461Imrk94MDDCp5ipLc9LSynruXDmQ5ulauUqIXroXx7h7GXbYIt8oPlZmUennzZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743455794; c=relaxed/simple;
	bh=rO9JrZxbqPIGLkT8fRyvaMwDBL8kMISH1pzZZLhbCTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kp1dthNy1CCB8CzDywmjQnaugHcBEcPkEj143g39C+xitor2kFaOXO6iMdwEkBgN61HmpHej7nrtX0mZOaCjdDfEU+FQ034uSS75uOd0yN67+dIfPeDfalI4iYdePOOAMGV27KEAE71x83jX4dInd+hktvYHFd+NPQedCxDlwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Cf9d4p+0; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 34B212E0972E
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 00:16:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1743455789;
	bh=GXEn7ZOr2J3dxWX0mI3zEXIECb0dlHr+uSKMpxfyO9I=;
	h=Received:From:Subject:To;
	b=Cf9d4p+0BWc8vvnDArtlrbH4yubSoTyCbzv8r3waacyU4pnQhgzwlWsrfpxTEcJ7v
	 eWAOEWXULplBvxe1EO2rj4Ln42edGuBiOJjdfPruCWTZY6Wq9VG1DKfVHuUZ2fVrmr
	 f24KtJw/oyQ+n8XMdE+IYS/0lMrXGceOiZTclBCo=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.173) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f173.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-30bf7d0c15eso50598101fa.0
        for <linux-acpi@vger.kernel.org>;
 Mon, 31 Mar 2025 14:16:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW80Qk1voZFhS4J5HYtctbMvm8g4J7JFy+7D5Tt8bOIoSk+BUAU7HNIzHH4zWp62WymUUfZEa2j92Vn@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJ7r7LIb3FP3ebi+OfhUI2hkSNUWeoD1pM00s/qJjM6tRsYnd
	CIHSP7LOvHdMIiZIPwS+wcW8YAj0qI8fRnj8pXU2/e1C/mZ0THz4kxlQuEwKg+b+fk9CIgfUAQA
	ajFy1iTIUqIi09eas4WVDHFs8Xkw=
X-Google-Smtp-Source: 
 AGHT+IEA7HJXauHQgqTBVxni95t3HZBE6AU6GkQVQ9nBuo1CMOv3IkdrxghaXN4/Ib8LiBFI9uTnr6UKYa7keBTYsog=
X-Received: by 2002:a2e:a901:0:b0:30c:b2c:edb6 with SMTP id
 38308e7fff4ca-30de02734fdmr31221651fa.18.1743455788497; Mon, 31 Mar 2025
 14:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331204442.1727618-1-superm1@kernel.org>
 <CAGwozwHyRiyVkX8rsc69gkALScWdtXNAvAGn7c2aEXW_qgdWsA@mail.gmail.com>
 <CAGwozwEiCXFDi73qAPSm2K9A8OZutE7dbjFfCmbUSAOTaz8SEA@mail.gmail.com>
 <50cc3227-93eb-4cb8-8151-23e52ca91f80@kernel.org>
In-Reply-To: <50cc3227-93eb-4cb8-8151-23e52ca91f80@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 31 Mar 2025 23:16:17 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwH7r-7uELUB1fiftAf3ziU6irgW92qiHHNOpuJ-87=WJw@mail.gmail.com>
X-Gm-Features: AQ5f1JoA4fKS0BNsHcHxTLst4NjknUzZhs7v_ODW_1H_to5bvueaGruxoz0SGp8
Message-ID: 
 <CAGwozwH7r-7uELUB1fiftAf3ziU6irgW92qiHHNOpuJ-87=WJw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
	Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <174345578955.726.341445525945406213@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Mon, 31 Mar 2025 at 22:55, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 3/31/2025 3:53 PM, Antheas Kapenekakis wrote:
> > On Mon, 31 Mar 2025 at 22:51, Antheas Kapenekakis <lkml@antheas.dev> wrote:
> >>
> >> On Mon, 31 Mar 2025 at 22:44, Mario Limonciello <superm1@kernel.org> wrote:
> >>>
> >>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>
> >>> When AC adapter is unplugged or plugged in EC wakes from
> >>> HW sleep but APU doesn't enter back into HW sleep.
> >>>
> >>> The reason this hapens is that when APU exits HW sleep the power
> >>> rails the EC controls will power up the TCON.  The TCON has a
> >>> GPIO that will be toggled during this time.  The GPIO is not marked
> >>> as a wakeup source however GPIO controller still has an unserviced
> >>> interrupt and it will block entering HW sleep again. Clearing the
> >>> GPIO doesn't help, the TCON raises it again until it's been initialized
> >>> by i2c-hid.
> >>>
> >>> Fixing this would require TCON F/W changes and it's already broken
> >>> in the wild on production hardware.
> >>>
> >>> To avoid triggering this issue add a quirk to avoid letting EC wake
> >>> up system at all.  The power button still works properly on this system.
> >>
> >> Hi Mario,
> >> I reported this issue to you early in January, did all the debugging
> >> for it, found the cause, made this patch, tested it, and finally
> >> deployed it as well. Then sent it to Xino.
> >>
> >> Then you pushed back for perfectly valid reasons, and we had a
> >> multi-week long back and forth trying to find the proper cause for
> >> this.
> >>
> >> So from my side I do not get why I am just a reported-by here. This is
> >> my patch. We also had a discussion about this out of band.
> >>
> >> Antheas
> >
> > It is interesting you ended up finding the cause. Which makes
> > attributing this a bit murkier.
> >
> > Antheas
>
> Hi Antheas,
>
> FWIW - you and I separately created very similar patches.

There is only one way to write a no_ec_wakeup patch after I reported
to you that it fixes it, here [1] mine is the same, even the DMI order
is the same.

> There has been more debugging that is not public (as you can see from
> the content of this commit message).
>
> What tag would you like in this case?

I think co-developed-by since you also worked very hard on fixing
this. I do not know if b4 picks up co-developed tags.

Not that I am content with it, which you might have noticed with my
absence in the amd/drm issue tracker.

So, was it the touchscreen after all? Did you verify this by tweaking
its firmware?

Antheas

[1] https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63


> Thanks,
>
> >>
> >>> Cc: Xino JS1 Ni <nijs1@lenovo.com>
> >>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> >>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>> ---
> >>>   drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
> >>>   1 file changed, 28 insertions(+)
> >>>
> >>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> >>> index 8db09d81918fb..3c5f34892734e 100644
> >>> --- a/drivers/acpi/ec.c
> >>> +++ b/drivers/acpi/ec.c
> >>> @@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
> >>>                          DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
> >>>                  },
> >>>          },
> >>> +       /*
> >>> +        * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
> >>> +        * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> >>> +        */
> >>> +       {
> >>> +               .matches = {
> >>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
> >>> +               }
> >>> +       },
> >>> +       {
> >>> +               .matches = {
> >>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
> >>> +               }
> >>> +       },
> >>> +       {
> >>> +               .matches = {
> >>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
> >>> +               }
> >>> +       },
> >>> +       {
> >>> +               .matches = {
> >>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
> >>> +               }
> >>> +       },
> >>>          { },
> >>>   };
> >>>
> >>> --
> >>> 2.43.0
> >>>
>

