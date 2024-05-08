Return-Path: <linux-acpi+bounces-5651-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B148C8BF548
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 06:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332BF1F22C3B
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 04:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B389FC127;
	Wed,  8 May 2024 04:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HklEkM7B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97771364
	for <linux-acpi@vger.kernel.org>; Wed,  8 May 2024 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715143343; cv=none; b=axKXD6TD70Nwnvo7ha38ItLnHLVH1AeQ2DGRcpWy3FuEPG20ajbk0sL9WFG46tI8h1oFhpxGZaT5Riwh+kG9mGxJUsjez60GE1ZXs6L2O1bL1nK47Qk3t2C1GkEByhvjgqGpCZ7dvRvkG/BrNDcz9DpXDDHP0eSofbYr28/dMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715143343; c=relaxed/simple;
	bh=JkHEyvKzQaIpDlBGJ6RjhKYN8wVhkJLM1gz5BQ4HeKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+yKNwNRsOsS6YD8KwZt7Sbdphc8YwreNeYjM7OFI7AkEFDL1kqBRukjO/UjYeyXadvU8Hj2M1KvG05uk/Md4dztczzrjYbL0cjFasQ176z4zembfO9j0c997ue4KkqJbDJ0AqQvXWM5eWtiVamDoKkvUyBYpyxPJZj6RVu7M7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HklEkM7B; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7614A3F129
	for <linux-acpi@vger.kernel.org>; Wed,  8 May 2024 04:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715143338;
	bh=HSPCqRRSwu+VBeQIW7/mpTtZkfCB1ZBdSnw3PPs81ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=HklEkM7BuUCZ0BADggek+I+f9HHL1zabtcRpx5ft4j7zGr6WkBmuy603Esu04xMrS
	 1ljPokvM6neTp42DpuNgISyv5CMQXzqIBDsWYNMIeBxHm98EKu+MDyM8KbRO/0zVPg
	 Dsi4yj0qkm/jBu4Qy2NCEqWrUh8DpsDOrI1QmjRSsn8QrkWZMXRl0BVPbKKdKoeDQ8
	 STm6jLobFRULmwiPHwWspDNXyaIoX/lwkdDgDKfAF0Pmg/L8JBpRpPNXN7RKnYoo6I
	 NaBeLWDJuhJLIgbh3oSVgcufRbsXQnd5NMvYOj0r6bmJ8dk46rNXLbC4Kp9AKz2UO2
	 wFbRAtOdyBQdA==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-61e5d65daceso3854736a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 07 May 2024 21:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715143337; x=1715748137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSPCqRRSwu+VBeQIW7/mpTtZkfCB1ZBdSnw3PPs81ks=;
        b=rABg9AmQiAbNxCM+6KBuL//k5MiMqGMd4QOV6busEGsw32BCL2G9AnHMOiv0G6PznQ
         yBb0qNHyVj1bcMGqbmiQn56WJcb7YhvaFCLOoQ0cDm5PpCHYdSrdsmOXgFaDSo89ih2C
         n5oHN4O7HIgcc7irEm0osjfDGUTNOEuDPxokUbOJePqZkFWfwxKC2E/+cLAG/otb5oB1
         KgKSoTswPUk8cg2guRRjdR6mFzvAr98NVQi99+NtrSwDwvd8t1jk+oQh6VH3op2k9wL6
         kcEt3lV+uBtQPNUH9dwYXhsdbkOm4CuGt84DfcJmi1N+rlDjTcwGTrw1DaqokzkeK+qC
         YsAw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+FmPm4DUSlXKsZOC90FUxcr6mUNdrST/QxX+yW6PQoGSChDupaXCdPbCTPP94lPTqXH7QTj8ylnaNJkbT1xJKcHzDdw+dM6S1g==
X-Gm-Message-State: AOJu0YxZKhLq9/HjE65j9v8P17x0BJKYjfTOQKeb7o1L24yEZrdVyyrq
	OzAcApO+lNerThYY5ceci/Kv5Aoegz8FmPoUs1OsXwZLaAYx+aPAByuGNptgYsVa0g6Ti1H4bsK
	zf28GX8w7r4+61E9RbeSPFb+wlWDPEfAzUb4uBBz/EIIh7nboEqoeL/w6xFAca+ivzzSG4n0MWW
	owRhspmp8iHSw7/XW7WWG5+8LVk/5jftfb/jO/8eGwYChIRYF2KQ==
X-Received: by 2002:a05:6a20:551c:b0:1af:bed5:b70d with SMTP id adf61e73a8af0-1afc8d5ad05mr1552520637.28.1715143336809;
        Tue, 07 May 2024 21:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+HyVNbe1dSvzu2G2nDYLP/LKDopQvqMiTGXD0qWByp4kRuYCcTnj0AU5thgSgX4K5E9Z5LKhSXCyoiI2bI+E=
X-Received: by 2002:a05:6a20:551c:b0:1af:bed5:b70d with SMTP id
 adf61e73a8af0-1afc8d5ad05mr1552509637.28.1715143336475; Tue, 07 May 2024
 21:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218151533.5720-1-hdegoede@redhat.com> <CAAd53p6h3G-eHO=va11_YEODtmnpfxqhXpQ1xw3ZAKa3X5-ayQ@mail.gmail.com>
 <98f6e530-1f1b-4c4e-9f70-2f8dff74575b@redhat.com>
In-Reply-To: <98f6e530-1f1b-4c4e-9f70-2f8dff74575b@redhat.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 8 May 2024 12:42:05 +0800
Message-ID: <CAAd53p4r=+fUkmUm9dQWDm4uYhm7rgMESTtv=zZer5RB5oiHRw@mail.gmail.com>
Subject: Re: [RFC 0/2] ACPI: Adding new acpi_driver type drivers ?
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org, 
	AceLan Kao <acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[+Cc AceLan]

Hi Hans,

On Wed, Apr 24, 2024 at 5:58=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Kai-Heng Feng,
>
> On 4/24/24 10:04 AM, Kai-Heng Feng wrote:
> > Hi Hans,
> >
> > On Sun, Feb 18, 2024 at 11:15=E2=80=AFPM Hans de Goede <hdegoede@redhat=
.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> I recently learned that some Dell AIOs (1) use a backlight controller =
board
> >> connected to an UART. Canonical even submitted a driver for this in 20=
17:
> >> https://lkml.org/lkml/2017/10/26/78
> >>
> >> This UART has a DELL0501 HID with CID set to PNP0501 so that the UART =
is
> >> still handled by 8250_pnp.c. Unfortunately there is no separate ACPI d=
evice
> >> with an UartSerialBusV2() resource to model the backlight-controller.
> >>
> >> The RFC patch 2/2 in this series uses acpi_quirk_skip_serdev_enumerati=
on()
> >> to still create a serdev for this for a backlight driver to bind to
> >> instead of creating a /dev/ttyS0.
> >>
> >> Like other cases where the UartSerialBusV2() resource is missing or br=
oken
> >> this will only create the serdev-controller device and the serdev-devi=
ce
> >> itself will need to be instantiated by the consumer (the backlight dri=
ver).
> >>
> >> Unlike existing other cases which use DMI modaliases to load on a spec=
ific
> >> board to work around brokeness of that board's specific ACPI tables, t=
he
> >> intend here is to have a single driver for all Dell AIOs using the DEL=
L0501
> >> HID for their UART, without needing to maintain a list of DMI matches.
> >>
> >> This means that the dell-uart-backlight driver will need something to =
bind
> >> to. The original driver from 2017 used an acpi_driver for this matchin=
g on
> >> and binding to the DELL0501 acpi_device.
> >>
> >> AFAIK you are trying to get rid of having drivers bind directly to
> >> acpi_device-s so I assume that you don't want me to introduce a new on=
e.
> >> So to get a device to bind to without introducing a new acpi_driver
> >> patch 2/2 if this series creates a platform_device for this.
> >>
> >> The creation of this platform_device is why this is marked as RFC,
> >> if you are ok with this solution I guess you can merge this series
> >> already as is. With the caveat that the matching dell-uart-backlight
> >> driver is still under development (its progressing nicely and the
> >> serdev-device instantation + binding a serdev driver to it already
> >> works).
> >
> > I was about to work on this and found you're already working on it.
> >
> > Please add me to Cc list when the driver is ready to be tested, thanks!
>
> I hope you have access to actual hw with such a backlight device ?
>
> The driver actually has been ready for testing for quite a while now,
> but the person who reported this backlight controller not being
> supported to me has been testing this on a AIO of a friend of theirs
> and this has been going pretty slow.
>
> So if you can test the driver (attached) then that would be great :)
>
> I even wrote an emulator to test it locally and that works, so
> assuming I got the protocol right from the original posting of
> the driver for this years ago then things should work.
>
> Note this depends on the kernel also having the patches from this
> RFC (which Rafael has already merged) applied.

There are newer AIO have UID other than 0, like "SIOBUAR2".

Once change the "0" to NULL in 'get_serdev_controller("DELL0501", "0",
0, "serial0");', everything works perfectly.

With that change,
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Kai-Heng

>
> Regards,
>
> Hans
>
>
>
>
>
>
> >> If you have a different idea how to handle this I'm certainly open
> >> to suggestions.
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >> 1) All In One a monitor with a PC builtin
> >>
> >>
> >> p.s.
> >>
> >> I also tried this approach, but that did not work:
> >>
> >> This was an attempt to create both a pdev from acpi_default_enumeratio=
n()
> >> by making the PNP scan handler attach() method return 0 rather then 1;
> >> and get a pnp_device created for the UART driver as well by
> >> making acpi_is_pnp_device() return true.
> >>
> >> This approach does not work due to the following code in pnpacpi_add_d=
evice():
> >>
> >>         /* Skip devices that are already bound */
> >>         if (device->physical_node_count)
> >>                 return 0;
> >>
> >> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> >> index 01abf26764b0..847c08deea7b 100644
> >> --- a/drivers/acpi/acpi_pnp.c
> >> +++ b/drivers/acpi/acpi_pnp.c
> >> @@ -353,10 +353,17 @@ static bool acpi_pnp_match(const char *idstr, co=
nst struct acpi_device_id **matc
> >>   * given ACPI device object, the PNP scan handler will not attach to =
that
> >>   * object, because there is a proper non-PNP driver in the kernel for=
 the
> >>   * device represented by it.
> >> + *
> >> + * The DELL0501 ACPI HID represents an UART (CID is set to PNP0501) w=
ith
> >> + * a backlight-controller attached. There is no separate ACPI device =
with
> >> + * an UartSerialBusV2() resource to model the backlight-controller.
> >> + * This setup requires instantiating both a pnp_device for the UART a=
s well
> >> + * as a platform_device for the backlight-controller driver to bind t=
oo.
> >>   */
> >>  static const struct acpi_device_id acpi_nonpnp_device_ids[] =3D {
> >>         {"INTC1080"},
> >>         {"INTC1081"},
> >> +       {"DELL0501"},
> >>         {""},
> >>  };
> >>
> >> @@ -376,13 +383,16 @@ static struct acpi_scan_handler acpi_pnp_handler=
 =3D {
> >>   * For CMOS RTC devices, the PNP ACPI scan handler does not work, bec=
ause
> >>   * there is a CMOS RTC ACPI scan handler installed already, so we nee=
d to
> >>   * check those devices and enumerate them to the PNP bus directly.
> >> + * For DELL0501 devices the PNP ACPI scan handler is skipped to creat=
e
> >> + * a platform_device, see the acpi_nonpnp_device_ids[] comment.
> >>   */
> >> -static int is_cmos_rtc_device(struct acpi_device *adev)
> >> +static int is_special_pnp_device(struct acpi_device *adev)
> >>  {
> >>         static const struct acpi_device_id ids[] =3D {
> >>                 { "PNP0B00" },
> >>                 { "PNP0B01" },
> >>                 { "PNP0B02" },
> >> +               { "DELL0501" },
> >>                 {""},
> >>         };
> >>         return !acpi_match_device_ids(adev, ids);
> >> @@ -390,7 +400,7 @@ static int is_cmos_rtc_device(struct acpi_device *=
adev)
> >>
> >>  bool acpi_is_pnp_device(struct acpi_device *adev)
> >>  {
> >> -       return adev->handler =3D=3D &acpi_pnp_handler || is_cmos_rtc_d=
evice(adev);
> >> +       return adev->handler =3D=3D &acpi_pnp_handler || is_special_pn=
p_device(adev);
> >>  }
> >>  EXPORT_SYMBOL_GPL(acpi_is_pnp_device);
> >>
> >>
> >> Hans de Goede (2):
> >>   ACPI: x86: Move acpi_quirk_skip_serdev_enumeration() out of
> >>     CONFIG_X86_ANDROID_TABLETS
> >>   ACPI: x86: Add DELL0501 handling to
> >>     acpi_quirk_skip_serdev_enumeration()
> >>
> >>  drivers/acpi/x86/utils.c | 38 ++++++++++++++++++++++++++++++++++----
> >>  include/acpi/acpi_bus.h  | 22 +++++++++++-----------
> >>  2 files changed, 45 insertions(+), 15 deletions(-)
> >>
> >> --
> >> 2.43.0
> >>
> >

