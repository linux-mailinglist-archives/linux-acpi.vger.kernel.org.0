Return-Path: <linux-acpi+bounces-5323-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB24F8B03D5
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Apr 2024 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245231F23266
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Apr 2024 08:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B105157E8B;
	Wed, 24 Apr 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lgohdwmC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D52AE77
	for <linux-acpi@vger.kernel.org>; Wed, 24 Apr 2024 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945869; cv=none; b=QJ29uaaXDcZ8rFsR76BLPrNCpF5sM5CTzMblG3zJAcu4frTvnRE2kUs6birpv/YSwv0tianfwQs5qY/Mxy7+0lmHtGPRBwdFrEvgilnR4oShh5g2ggZGqSqkooWA96Rju5HLU4H1Wl2HUmG/ZcUtfrDC9YKRJIPB/b5LJnSF/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945869; c=relaxed/simple;
	bh=irUYKc7pw4WJNik79FDsUVuQHFZ4029hRZLg8bZr89o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxP83lxXhHH5231Dfdm9DrcOoZeShRJDenGtSJc7bT8KlptPyHQS2+YvAl17ws/jkrqyIcP3HfpLAneRhHDKQy2RKdMG+jBGLmTI7TDf4kxQ4SYXfybUZY9J8TZeC4Juoog9DqXzpYcO6K618MAkuwEpV1qW9Tfpl4L9D7EU2ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lgohdwmC; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 568D73FB6C
	for <linux-acpi@vger.kernel.org>; Wed, 24 Apr 2024 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713945860;
	bh=/GB06l95ZQsDzqA+MN/KAr7Qkw5D7G4QKW4YMvwfo9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=lgohdwmCieZAOFoa6KJekJtUS30RA/7UOohoQMoPAot2I7NjMx/AB8JQ80boIAl80
	 ISWQILp62/2jE6+fJd6M3AWvUrJP9bmRIHmNhvcHbzmj5QQZ7ikgaXO3kDWASr1yil
	 uj4oiR47kYcnzNzqXmjU6gL2sROliR9T4864/1uDKpMirWrUWgV2USFfsbKIC9llRd
	 H82LP2zy/jL/VLYfVXgViS2AY8H3QTHSr19KtQEvpHLtRztRYSbUg508pB1BNJ3i8C
	 upa1RSy0Z/Zy1B6who31+qrMYJKTR2mUMSpYZHPY4xyddKBnU2yxUqS7vtYYEuUxz/
	 043b+vNlxf9Hw==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a7dad5cdfeso8325214a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 24 Apr 2024 01:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713945859; x=1714550659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GB06l95ZQsDzqA+MN/KAr7Qkw5D7G4QKW4YMvwfo9c=;
        b=YgRtWrsEvnsHWQw7dK0WbRw7cDlI4mq8ixJqhZc87n0nxeoKCfsyZLWzLnCk2233JB
         WoHc1qAD9pV5GalTmnpDeNl+lIj67GJboXeIwjW7TZg44YRmMzGelCWnrSFTs8lR6TlE
         HW1XNINxZXP+KmvLyIRtS6vbV8yNIYLWDJdI7eUK124ljfU1m6C9aeY4PXrmx74X4n7k
         3btJp78CKXFaRP+xXP2H2BnCaNSzYhnajqAAg8Ne9Qiu7R2k15iyNrcU5wzG4VvRKGoL
         X1mJ47+TBKSZDAiPO5gZJnVAOjUnkY6p9+L5m3/RjeNNpcGnUxtuklf2xLLwsyhHZ3Am
         rh/A==
X-Forwarded-Encrypted: i=1; AJvYcCWPNg1Eqp2CjZUuGKwnp6/ciNaZEYli8nEueWzoZFfV/DuI8MCrUwzTWeAvtwmV8fTXcfXWAxYLMfp4cgwD8RZ88rwo2DhPhH5BWw==
X-Gm-Message-State: AOJu0YyvCDhYYYMC9SdBmsmMcM/LhAAXjHVmWndlYQFUE61QTriAEkWE
	bWZ9tUpUMDAET2mDjD5FL49El312pPvmEwtSbFgrqFF/UmZL49yVIU25qtgESlAAAQ6i8WZ6em1
	yVEMKYNS0meydsV9Z1PpUPKrs30F7df58igpC3B2h0c46XVmWZWWsO90X7wBSVd5VlEeixG5CBD
	3MlawIjzk619G4MMu9TkWXfGuscHwiZOOnByRAjP6EK5sJw0fqcg==
X-Received: by 2002:a17:90a:d583:b0:2ad:da23:da0b with SMTP id v3-20020a17090ad58300b002adda23da0bmr1788151pju.34.1713945858940;
        Wed, 24 Apr 2024 01:04:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECoV+/GbeoZE1Bz4fZAOCYm/HXXyp/KAwcsiBcPqFto1ekZlZpWjhBDFR797Pdnw0lU8FwUhqBfc/7vUvnDEw=
X-Received: by 2002:a17:90a:d583:b0:2ad:da23:da0b with SMTP id
 v3-20020a17090ad58300b002adda23da0bmr1788136pju.34.1713945858559; Wed, 24 Apr
 2024 01:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218151533.5720-1-hdegoede@redhat.com>
In-Reply-To: <20240218151533.5720-1-hdegoede@redhat.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 24 Apr 2024 16:04:06 +0800
Message-ID: <CAAd53p6h3G-eHO=va11_YEODtmnpfxqhXpQ1xw3ZAKa3X5-ayQ@mail.gmail.com>
Subject: Re: [RFC 0/2] ACPI: Adding new acpi_driver type drivers ?
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sun, Feb 18, 2024 at 11:15=E2=80=AFPM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi Rafael,
>
> I recently learned that some Dell AIOs (1) use a backlight controller boa=
rd
> connected to an UART. Canonical even submitted a driver for this in 2017:
> https://lkml.org/lkml/2017/10/26/78
>
> This UART has a DELL0501 HID with CID set to PNP0501 so that the UART is
> still handled by 8250_pnp.c. Unfortunately there is no separate ACPI devi=
ce
> with an UartSerialBusV2() resource to model the backlight-controller.
>
> The RFC patch 2/2 in this series uses acpi_quirk_skip_serdev_enumeration(=
)
> to still create a serdev for this for a backlight driver to bind to
> instead of creating a /dev/ttyS0.
>
> Like other cases where the UartSerialBusV2() resource is missing or broke=
n
> this will only create the serdev-controller device and the serdev-device
> itself will need to be instantiated by the consumer (the backlight driver=
).
>
> Unlike existing other cases which use DMI modaliases to load on a specifi=
c
> board to work around brokeness of that board's specific ACPI tables, the
> intend here is to have a single driver for all Dell AIOs using the DELL05=
01
> HID for their UART, without needing to maintain a list of DMI matches.
>
> This means that the dell-uart-backlight driver will need something to bin=
d
> to. The original driver from 2017 used an acpi_driver for this matching o=
n
> and binding to the DELL0501 acpi_device.
>
> AFAIK you are trying to get rid of having drivers bind directly to
> acpi_device-s so I assume that you don't want me to introduce a new one.
> So to get a device to bind to without introducing a new acpi_driver
> patch 2/2 if this series creates a platform_device for this.
>
> The creation of this platform_device is why this is marked as RFC,
> if you are ok with this solution I guess you can merge this series
> already as is. With the caveat that the matching dell-uart-backlight
> driver is still under development (its progressing nicely and the
> serdev-device instantation + binding a serdev driver to it already
> works).

I was about to work on this and found you're already working on it.

Please add me to Cc list when the driver is ready to be tested, thanks!

Kai-Heng

>
> If you have a different idea how to handle this I'm certainly open
> to suggestions.
>
> Regards,
>
> Hans
>
> 1) All In One a monitor with a PC builtin
>
>
> p.s.
>
> I also tried this approach, but that did not work:
>
> This was an attempt to create both a pdev from acpi_default_enumeration()
> by making the PNP scan handler attach() method return 0 rather then 1;
> and get a pnp_device created for the UART driver as well by
> making acpi_is_pnp_device() return true.
>
> This approach does not work due to the following code in pnpacpi_add_devi=
ce():
>
>         /* Skip devices that are already bound */
>         if (device->physical_node_count)
>                 return 0;
>
> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> index 01abf26764b0..847c08deea7b 100644
> --- a/drivers/acpi/acpi_pnp.c
> +++ b/drivers/acpi/acpi_pnp.c
> @@ -353,10 +353,17 @@ static bool acpi_pnp_match(const char *idstr, const=
 struct acpi_device_id **matc
>   * given ACPI device object, the PNP scan handler will not attach to tha=
t
>   * object, because there is a proper non-PNP driver in the kernel for th=
e
>   * device represented by it.
> + *
> + * The DELL0501 ACPI HID represents an UART (CID is set to PNP0501) with
> + * a backlight-controller attached. There is no separate ACPI device wit=
h
> + * an UartSerialBusV2() resource to model the backlight-controller.
> + * This setup requires instantiating both a pnp_device for the UART as w=
ell
> + * as a platform_device for the backlight-controller driver to bind too.
>   */
>  static const struct acpi_device_id acpi_nonpnp_device_ids[] =3D {
>         {"INTC1080"},
>         {"INTC1081"},
> +       {"DELL0501"},
>         {""},
>  };
>
> @@ -376,13 +383,16 @@ static struct acpi_scan_handler acpi_pnp_handler =
=3D {
>   * For CMOS RTC devices, the PNP ACPI scan handler does not work, becaus=
e
>   * there is a CMOS RTC ACPI scan handler installed already, so we need t=
o
>   * check those devices and enumerate them to the PNP bus directly.
> + * For DELL0501 devices the PNP ACPI scan handler is skipped to create
> + * a platform_device, see the acpi_nonpnp_device_ids[] comment.
>   */
> -static int is_cmos_rtc_device(struct acpi_device *adev)
> +static int is_special_pnp_device(struct acpi_device *adev)
>  {
>         static const struct acpi_device_id ids[] =3D {
>                 { "PNP0B00" },
>                 { "PNP0B01" },
>                 { "PNP0B02" },
> +               { "DELL0501" },
>                 {""},
>         };
>         return !acpi_match_device_ids(adev, ids);
> @@ -390,7 +400,7 @@ static int is_cmos_rtc_device(struct acpi_device *ade=
v)
>
>  bool acpi_is_pnp_device(struct acpi_device *adev)
>  {
> -       return adev->handler =3D=3D &acpi_pnp_handler || is_cmos_rtc_devi=
ce(adev);
> +       return adev->handler =3D=3D &acpi_pnp_handler || is_special_pnp_d=
evice(adev);
>  }
>  EXPORT_SYMBOL_GPL(acpi_is_pnp_device);
>
>
> Hans de Goede (2):
>   ACPI: x86: Move acpi_quirk_skip_serdev_enumeration() out of
>     CONFIG_X86_ANDROID_TABLETS
>   ACPI: x86: Add DELL0501 handling to
>     acpi_quirk_skip_serdev_enumeration()
>
>  drivers/acpi/x86/utils.c | 38 ++++++++++++++++++++++++++++++++++----
>  include/acpi/acpi_bus.h  | 22 +++++++++++-----------
>  2 files changed, 45 insertions(+), 15 deletions(-)
>
> --
> 2.43.0
>

