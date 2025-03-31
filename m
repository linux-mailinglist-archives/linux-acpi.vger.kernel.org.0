Return-Path: <linux-acpi+bounces-12572-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81AAA76FAD
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 22:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781411652CC
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 20:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED3221ABB4;
	Mon, 31 Mar 2025 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Q5hIJNyV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636F62153E7
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454310; cv=none; b=rGoGBYCueGWkhuWCeqg3XHJt9tNOyC4zT1JKHAnSBrLhnZ3b3s0AKSyAfWcvmm5MfQutEGA9+Uya5xUIbuLw1QYogSifFiKJG/W6Z/dULZkRHcN71mickMk7wXnr+OkNy180OLYC5yPh7fCdlkjw7v0xVW4F+6S/ZOKDc8mwLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454310; c=relaxed/simple;
	bh=Awi5LN3/3Ng6Nq5I1+xs5hvG9fD/jnJy/vHXqh1d24c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VD9pP6oQnDVEdov79oZ6eqY/IwEVves581xMonC8oCpOzp4z+84AHWKD6MyynzQulV2y6v+d+ZQygoPDpeNtneDW+ysTsjhUW+gHd0cv+oDcvUIyYe4Z2L1XLq4IVpHWKmtV8MsgiG9MsQhDVCFOCfBFreODhP1SbsgUx11cz1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Q5hIJNyV; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 37B9C2E09743
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 23:51:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1743454298;
	bh=K8ze1OdwTkCIo7kWM5045lQYuG9gXnKVqyqjVjf1m48=;
	h=Received:From:Subject:To;
	b=Q5hIJNyVkYuoHfMHzaMiJUNyrwm5dMQ82ZWJOfRrTEAhVrCIcrqNTAnvKca2oy379
	 8t6AFg1MypmvnfvS95yOHvWHxVzaetHGs+mNM5BRI1RFfGF+bQ0jf14xH8CoVDdwcB
	 3OAjG+GoK7cpz++WAili+DNlSm30FEGCAWGsPo2Q=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-30db2c2c609so53176351fa.3
        for <linux-acpi@vger.kernel.org>;
 Mon, 31 Mar 2025 13:51:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUNNKVBZRSKObD/Y8Mfy6vtCQJjmvxmKwPS8faihqpNr7gsjxKYn//jrYDeMFA/ZNaL9/fQW9Wc/wBB@vger.kernel.org
X-Gm-Message-State: AOJu0YxLEi+t5e/9UYEMtC0hiWLJx/TeZe8qNIGoKo3ktgyVobDnZpXR
	174fqciDsqoJ6uGR6zheHVGcy44Dr/VcUaQyMJa/llfHfz5I9YWeoeWFPVNNfKGhHGAjo0VbKkz
	D1sZNC72rmAewQtuhl9Jy+iBoYe4=
X-Google-Smtp-Source: 
 AGHT+IFqSepyP8fGygVKgncPc4vbKCHv3cGZY38xSc7EUky2OePkayz9xqYy4Z2sy5YW/aequNlpD2wreK1fy50IJlI=
X-Received: by 2002:a05:651c:1608:b0:30d:886b:1fff with SMTP id
 38308e7fff4ca-30eecdaa7ffmr1500341fa.37.1743454297536; Mon, 31 Mar 2025
 13:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331204442.1727618-1-superm1@kernel.org>
In-Reply-To: <20250331204442.1727618-1-superm1@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 31 Mar 2025 22:51:25 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHyRiyVkX8rsc69gkALScWdtXNAvAGn7c2aEXW_qgdWsA@mail.gmail.com>
X-Gm-Features: AQ5f1Jplne24sfkIiFmVcSQ5OWg3or7AkpnTfrs-CAiSEtqoPrtiaTERSSDaWmw
Message-ID: 
 <CAGwozwHyRiyVkX8rsc69gkALScWdtXNAvAGn7c2aEXW_qgdWsA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
	Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174345429867.31126.2062344255703278441@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Mon, 31 Mar 2025 at 22:44, Mario Limonciello <superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When AC adapter is unplugged or plugged in EC wakes from
> HW sleep but APU doesn't enter back into HW sleep.
>
> The reason this hapens is that when APU exits HW sleep the power
> rails the EC controls will power up the TCON.  The TCON has a
> GPIO that will be toggled during this time.  The GPIO is not marked
> as a wakeup source however GPIO controller still has an unserviced
> interrupt and it will block entering HW sleep again. Clearing the
> GPIO doesn't help, the TCON raises it again until it's been initialized
> by i2c-hid.
>
> Fixing this would require TCON F/W changes and it's already broken
> in the wild on production hardware.
>
> To avoid triggering this issue add a quirk to avoid letting EC wake
> up system at all.  The power button still works properly on this system.

Hi Mario,
I reported this issue to you early in January, did all the debugging
for it, found the cause, made this patch, tested it, and finally
deployed it as well. Then sent it to Xino.

Then you pushed back for perfectly valid reasons, and we had a
multi-week long back and forth trying to find the proper cause for
this.

So from my side I do not get why I am just a reported-by here. This is
my patch. We also had a discussion about this out of band.

Antheas

> Cc: Xino JS1 Ni <nijs1@lenovo.com>
> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 8db09d81918fb..3c5f34892734e 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>                         DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
>                 },
>         },
> +       /*
> +        * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
> +        * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> +        */
> +       {
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
> +               }
> +       },
> +       {
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
> +               }
> +       },
> +       {
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
> +               }
> +       },
> +       {
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
> +               }
> +       },
>         { },
>  };
>
> --
> 2.43.0
>

