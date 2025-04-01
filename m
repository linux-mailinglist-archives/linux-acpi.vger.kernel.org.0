Return-Path: <linux-acpi+bounces-12587-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F51A77B42
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 14:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1824A7A3F5B
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A452203703;
	Tue,  1 Apr 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="mZsn2juI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857891F2388
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511642; cv=none; b=QwZwQydr8vg2hjMn1OFtr6DdPhh4qFq+utGEVm+4pwjz8jYVSI40eE8opXc+RNvVLF3vP0zDc3kId6f19K+GuOvHhhJjB2KNkoNoV0StrUvYki6OEv6F0x6ELppNp6vQif0obx1//tWsvw7PS2uWMtIa22D1QmWZ8kM721PbtP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511642; c=relaxed/simple;
	bh=Mjbx18qg6m024rws4uRZnWkAOkdKl7GtubSl/YjU1qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvH6kDwefuemV3Cvnbge17YZwKA0b5GvSSt+Hg3Jq/YUvNXK2MIxzIeF4XOtlTAUKQ5Jf7tLOPByPg2QReUHtrq0wX8GSOg/UfavsvOG6NMd2cUaUAgmP/xozQmLfrtaxPIhu9jrjDQcYhLptQBwlGH5nSnq45r67EXSG7iU5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=mZsn2juI; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id D261E2E08E27
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 15:47:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1743511638;
	bh=L9I+znDr4SJ94QznyzcRYlLFLDvEnj6q+OAfSL+GKx4=;
	h=Received:From:Subject:To;
	b=mZsn2juIoeoayZQuI0GMOZEvKtwpJyVnuijhP/tC2SdA8PIKQmnXzGXc6880T+yr4
	 7ZJu7Rfpz/UcQnzrq9SX2cWFplC3Hol6i5fDEaptWJjHMnSdczrwCx49XGsmgR0BL8
	 BDvMRJ7Q66gvssx4q/xAXJbfX47YAZ4wvag7PU+Q=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.167.48) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f48.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-54b10594812so3979656e87.1
        for <linux-acpi@vger.kernel.org>;
 Tue, 01 Apr 2025 05:47:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWsSFSE2tgf5BiefNQhwYI9TNtJqD/XmHizO57oiU5cBEOeDzBwMn3I7yqT+6UMWy6lryUN3tFobi7l@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdgdRFZ3HZk47/ZT+V4hMLBvfhKauCX3Pon3cwUtMpohzTG0Y
	dtxZ+rX3Rz022Au2DPJBS2zVI/MQS6+3FudF3OtOvH5xULnB4WNAJ53RBBS456gI2ozvwRPOD0J
	B3ByjiDQlbSRuzlQ9EkxP7Krk1AU=
X-Google-Smtp-Source: 
 AGHT+IEfh8OMA3MoKhspKWSg5x2tUVivsg7a/SasQHrCeJ4f7p6cxX1Z2CEBdSqgWsF9MwIcyAgX+9ePnRqXHTvvq0Q=
X-Received: by 2002:a2e:a98e:0:b0:30c:15b:1268 with SMTP id
 38308e7fff4ca-30de024b46dmr37240771fa.15.1743511636165; Tue, 01 Apr 2025
 05:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331204442.1727618-1-superm1@kernel.org>
In-Reply-To: <20250331204442.1727618-1-superm1@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 1 Apr 2025 14:47:04 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwF7AtFbeUnU7DnNf8QAj3WJSnr2QYTAp1y3Ubv+V1AgrA@mail.gmail.com>
X-Gm-Features: AQ5f1JpysTkJZUUwgQfE3c0yXvr6QvZSHOLKTcDMrcpoz_d5VEGpGoG5NFnDqb0
Message-ID: 
 <CAGwozwF7AtFbeUnU7DnNf8QAj3WJSnr2QYTAp1y3Ubv+V1AgrA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
	Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174351163732.17616.16903818531618477006@linux1587.grserver.gr>
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

Speaking of a V2, typo /\

> rails the EC controls will power up the TCON.  The TCON has a
> GPIO that will be toggled during this time.  The GPIO is not marked
> as a wakeup source however GPIO controller still has an unserviced
> interrupt and it will block entering HW sleep again. Clearing the
> GPIO doesn't help, the TCON raises it again until it's been initialized
> by i2c-hid.

And missing commas/weird grammar above

A

> Fixing this would require TCON F/W changes and it's already broken
> in the wild on production hardware.
>
> To avoid triggering this issue add a quirk to avoid letting EC wake
> up system at all.  The power button still works properly on this system.
>
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

