Return-Path: <linux-acpi+bounces-5655-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8018BFB29
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 12:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6AE1C21213
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 10:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A113380BF0;
	Wed,  8 May 2024 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="htwACLhv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A798061B
	for <linux-acpi@vger.kernel.org>; Wed,  8 May 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164881; cv=none; b=XLNhZ0KXE1TZzHRkV2vpAfOcq2ICGfSUQOvegambzmekjfB9uuNX6Z51i0eBqVbtCkXkViQeEImJVs9mMGnorZERgzL0TmXZMhOt1V1IvARfR07JHWY7Il+xavRUifzWSBQAcXXN6LujJg8DNNDZnMRZzRTguc5+4G3i0uQyl1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164881; c=relaxed/simple;
	bh=MVCI8ngP53BF5WynLFT0fNXuVvT7c2K2BLtRJ4vrruM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g++Oa/Uo+V0TIAXy3tBevgWFGzfQmUB0kdlP7NF6jZYokR9cF+KxJblzFUQSEPdc1CR3qkKC3iUS5vJDTjPFipLAbx8ScgH0XHvfRGAnxtnIGGUc49j9Fzf+sB7J9eemgVtyYr7Kdrrc2BJ/q9UHBt5vnZi1W0QKMiaRURRO/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=htwACLhv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B5DC03F5F4
	for <linux-acpi@vger.kernel.org>; Wed,  8 May 2024 10:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715164876;
	bh=MVCI8ngP53BF5WynLFT0fNXuVvT7c2K2BLtRJ4vrruM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=htwACLhvP+pYakQ/FOUbP6qjO9DidQcsLHT10sVY04mYm89XzeLewhNQ+4H8h4LbZ
	 87qyBpOckQ7ToZemETQYqi+/VwX6eu2h9z9vbJW2f54gUDbaZM7Zhq+Wm2vycZL7jh
	 heUeHJB59XL7py3htJ+Z4M/Z4gs2q2LIX6qv/xGDYuSTAwvTM8Ld1Nid5jcAOJkH+p
	 +g5m/c4DPiuOYYZ05SGZYYGt+eOq8SGPxIGgsgYY72s6l+pegAlpcu5pT0hVCELhB0
	 MxhvlV3CSuvxMqcRLG1hxQlESO4VCHz7LoMPgfA0ZEOiIVWr26NkpGo2NBg7urXD/E
	 wnTgSVXyB13SA==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b2738ce656so3519253a91.0
        for <linux-acpi@vger.kernel.org>; Wed, 08 May 2024 03:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715164875; x=1715769675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVCI8ngP53BF5WynLFT0fNXuVvT7c2K2BLtRJ4vrruM=;
        b=Y6lg6ZbDa12WqGQ3urbFPUm0fSD6KK3ZptfF+0ReMd9jqqDjBwl2yko04ZrO0EcVh0
         +yo2jSN11Md0nlh3Y4bXJts60YYoQfyY/eJFOq8ZJ2+P6acS3SXhxxmjGVtXc9rdAnxG
         0WIh533hP6PTpIVizKbjUV1hmBwnT/5DGfhpn0trNLHiSS5+1i+4U91FqsAdj7WJfMJ4
         4Zgh1NDXc0vDqwMx7Lvr8b0FcK+qLL2YkFLvwgsO84AKiaSZKTEJOD9EaLIoKBIA6yPP
         nxsEXNu5Pqr2ufGunt2DY9M2N6U6G1n8RHahqA/ZGu8Nc+pKxy66NGJ1TqONodPJIimb
         2e2w==
X-Forwarded-Encrypted: i=1; AJvYcCVEAkWfNMJnGweKNsdGeqQ6k6yWJu1dfBI9c3cNuS2sCgGwNSjTlkNxHtpV4iDWneNvbpEGFrQb4jks3OHUrXhNaCsNP613wlV3gw==
X-Gm-Message-State: AOJu0YzC9jhWryGRO3fZCZRz3BwTXLDdw9H+tB/+MF0v5bzIWjNI4p9E
	sd4ZyfXka4PDKJ4zBgIbss28AaNyBaNhGehoQbr2UWx7gNjPK9MeIwBBkpCXS30riYeOZPXnN/G
	9R3I7rXK04gs8mOmUpHoqtPgYXgPEnswbTsokMjvy2PwSIAusk5AXYZoeZ49aI84yglB2R7k/t3
	Rt9zzaZRFL7NmcIM/VykTNu3Mg1LiFu6oYjC8t+gAWg+WS6FM+YA==
X-Received: by 2002:a17:90a:d182:b0:2b3:79ad:8572 with SMTP id 98e67ed59e1d1-2b616cff979mr1856881a91.49.1715164875304;
        Wed, 08 May 2024 03:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGWjYBfyoRdG9yJUv2+V8kosHbkMO6BRdcu8CY2DZ9NB3fCpaNh/IjT41L6KvfVLI9EPpo7VNX2eJ8Y8cS5gc=
X-Received: by 2002:a17:90a:d182:b0:2b3:79ad:8572 with SMTP id
 98e67ed59e1d1-2b616cff979mr1856866a91.49.1715164874962; Wed, 08 May 2024
 03:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218151533.5720-1-hdegoede@redhat.com> <CAAd53p6h3G-eHO=va11_YEODtmnpfxqhXpQ1xw3ZAKa3X5-ayQ@mail.gmail.com>
 <98f6e530-1f1b-4c4e-9f70-2f8dff74575b@redhat.com> <CAAd53p4r=+fUkmUm9dQWDm4uYhm7rgMESTtv=zZer5RB5oiHRw@mail.gmail.com>
 <ZjtJVpWvNuusC_O9@smile.fi.intel.com>
In-Reply-To: <ZjtJVpWvNuusC_O9@smile.fi.intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 8 May 2024 18:41:03 +0800
Message-ID: <CAAd53p5gJVh5E=bMNbwjGdow-UhF=aZonYnBX8ubmrO4snhvTQ@mail.gmail.com>
Subject: Re: [RFC 0/2] ACPI: Adding new acpi_driver type drivers ?
To: Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	AceLan Kao <acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 5:44=E2=80=AFPM Andy Shevchenko <andy@kernel.org> wr=
ote:
>
> On Wed, May 08, 2024 at 12:42:05PM +0800, Kai-Heng Feng wrote:
> > [+Cc AceLan]
> > On Wed, Apr 24, 2024 at 5:58=E2=80=AFPM Hans de Goede <hdegoede@redhat.=
com> wrote:
> > > On 4/24/24 10:04 AM, Kai-Heng Feng wrote:
> > > > On Sun, Feb 18, 2024 at 11:15=E2=80=AFPM Hans de Goede <hdegoede@re=
dhat.com> wrote:
> > > >>
> > > >> Hi Rafael,
> > > >>
> > > >> I recently learned that some Dell AIOs (1) use a backlight control=
ler board
> > > >> connected to an UART. Canonical even submitted a driver for this i=
n 2017:
> > > >> https://lkml.org/lkml/2017/10/26/78
> > > >>
> > > >> This UART has a DELL0501 HID with CID set to PNP0501 so that the U=
ART is
> > > >> still handled by 8250_pnp.c. Unfortunately there is no separate AC=
PI device
> > > >> with an UartSerialBusV2() resource to model the backlight-controll=
er.
> > > >>
> > > >> The RFC patch 2/2 in this series uses acpi_quirk_skip_serdev_enume=
ration()
> > > >> to still create a serdev for this for a backlight driver to bind t=
o
> > > >> instead of creating a /dev/ttyS0.
> > > >>
> > > >> Like other cases where the UartSerialBusV2() resource is missing o=
r broken
> > > >> this will only create the serdev-controller device and the serdev-=
device
> > > >> itself will need to be instantiated by the consumer (the backlight=
 driver).
> > > >>
> > > >> Unlike existing other cases which use DMI modaliases to load on a =
specific
> > > >> board to work around brokeness of that board's specific ACPI table=
s, the
> > > >> intend here is to have a single driver for all Dell AIOs using the=
 DELL0501
> > > >> HID for their UART, without needing to maintain a list of DMI matc=
hes.
> > > >>
> > > >> This means that the dell-uart-backlight driver will need something=
 to bind
> > > >> to. The original driver from 2017 used an acpi_driver for this mat=
ching on
> > > >> and binding to the DELL0501 acpi_device.
> > > >>
> > > >> AFAIK you are trying to get rid of having drivers bind directly to
> > > >> acpi_device-s so I assume that you don't want me to introduce a ne=
w one.
> > > >> So to get a device to bind to without introducing a new acpi_drive=
r
> > > >> patch 2/2 if this series creates a platform_device for this.
> > > >>
> > > >> The creation of this platform_device is why this is marked as RFC,
> > > >> if you are ok with this solution I guess you can merge this series
> > > >> already as is. With the caveat that the matching dell-uart-backlig=
ht
> > > >> driver is still under development (its progressing nicely and the
> > > >> serdev-device instantation + binding a serdev driver to it already
> > > >> works).
> > > >
> > > > I was about to work on this and found you're already working on it.
> > > >
> > > > Please add me to Cc list when the driver is ready to be tested, tha=
nks!
> > >
> > > I hope you have access to actual hw with such a backlight device ?
> > >
> > > The driver actually has been ready for testing for quite a while now,
> > > but the person who reported this backlight controller not being
> > > supported to me has been testing this on a AIO of a friend of theirs
> > > and this has been going pretty slow.
> > >
> > > So if you can test the driver (attached) then that would be great :)
> > >
> > > I even wrote an emulator to test it locally and that works, so
> > > assuming I got the protocol right from the original posting of
> > > the driver for this years ago then things should work.
> > >
> > > Note this depends on the kernel also having the patches from this
> > > RFC (which Rafael has already merged) applied.
> >
> > There are newer AIO have UID other than 0, like "SIOBUAR2".
> >
> > Once change the "0" to NULL in 'get_serdev_controller("DELL0501", "0",
> > 0, "serial0");', everything works perfectly.
> >
> > With that change,
> > Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Do we have tables with _UID set to 0?
> If so, we would need more complex approach.

Yes, some tables have _UID set to 0 and some have other _UID values.

Kai-Heng

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

