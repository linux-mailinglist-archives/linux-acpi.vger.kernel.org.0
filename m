Return-Path: <linux-acpi+bounces-9899-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A851F9E2C3C
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 20:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7170E165BBC
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 19:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149011FF614;
	Tue,  3 Dec 2024 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0xT2MM2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B287E0E8
	for <linux-acpi@vger.kernel.org>; Tue,  3 Dec 2024 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255071; cv=none; b=DD3AwdzNNz+U+ZsZ41yA0goWUiVhEf3Yg9qxnw0aXk6AiXnmmbEhqMHccdCNCxciaw6SFTDzBg2u4GE353M84Fwa6y3CP1EPORJPOGkkz3sujWO30Wt2HlLAtCMQ7Jtmkxvtah38cmE87sZF8QQqW65Id4BlMStd82O1FvrdZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255071; c=relaxed/simple;
	bh=UrxBpHNHJDYu4HYkmWioWv5Fxdc+8/33gVkFmOxEnZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fn10itOE1mhSGl8oi2egJ64x6fTvm/qY72TO3WBk82BATl1sXLEmSM3feaK6VDcR7b62u/3xEuE1RZ2dF111uCByv7EsmLTF3chq8aUPDiUGoy8FkgiH7nJz8HHOjob2Sfnczzu0ar55ilTbegmjm0GRpr5MMEG2jfRB9vQrMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0xT2MM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CB9C4AF0B
	for <linux-acpi@vger.kernel.org>; Tue,  3 Dec 2024 19:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733255070;
	bh=UrxBpHNHJDYu4HYkmWioWv5Fxdc+8/33gVkFmOxEnZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P0xT2MM2xPxYZygwtaTTooJPvGGQD14WSYzv4oBsYRz+g1mfvPpFztKYV0qr+5zyK
	 tFvaAoFZkQIyw9ZXGGCy3WvAJ42WamvRaSDZ37sRnypdrBM9khwW0KTWU89OrVcYIH
	 oS7048CDdSHSv/fPU5ngdU1qgeDCmzC5YJVs5f6gGZmttcCmsYYT2keQtnls1TmCMJ
	 tmH6vqahPSgH0fbg2z+boSNZx442GmvIDzNbyN+hvEvUkH2+IBnVNoFQ9jcO0t1J1k
	 1Be93R6tp4oC/5jZ5dXMEHsPHy3mS6w2gciE/KGfHGrUYu8BNm8gciK5IWlaQMhcfB
	 tcrZqbfCoWRsw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29737adb604so3316355fac.1
        for <linux-acpi@vger.kernel.org>; Tue, 03 Dec 2024 11:44:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpH/Gdgy8J2mpiwOJeTuwZrvR6zLV9HznGh0fDtFWcSE6tSSj1RY9km9E6tS/acL5kW/NFV+TGVLe8@vger.kernel.org
X-Gm-Message-State: AOJu0YxFwSpmljD581N/vab4C8Sq8RP7O3t2XSUjr2NGjALDSiT1xZZT
	xWOtKU+s+MpTWVOA+6lBH90PKqiWT4sSWFttOfWOV2CUDFalssIAJeWNXTAnNhP2iwW6qg67yrI
	xJPuPEHGtl9vzh/KSeIno+lfEAc0=
X-Google-Smtp-Source: AGHT+IF8Li33r9PKsGvN6UGehYwvDSKL7p6Nxux11ULmWeDQdQ09sQQkdkjo0TcP8iQURD7kr2I8L6VZ75nPNgpXbrE=
X-Received: by 2002:a05:6870:e386:b0:29e:7f8c:8f57 with SMTP id
 586e51a60fabf-29e8884d9c9mr4841292fac.27.1733255069652; Tue, 03 Dec 2024
 11:44:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4542595.LvFx2qVVIh@kreacher> <2927980.e9J7NaK4W3@kreacher> <C20272A3-65B5-4AAD-B6AD-0B93A95C5D93@gmail.com>
In-Reply-To: <C20272A3-65B5-4AAD-B6AD-0B93A95C5D93@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Dec 2024 20:44:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jeE=3-0ad7OMWETnhYfQE+fhw2dQTfYTmn=_6gDnDghQ@mail.gmail.com>
Message-ID: <CAJZ5v0jeE=3-0ad7OMWETnhYfQE+fhw2dQTfYTmn=_6gDnDghQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] ACPI: scan: Extract CSI-2 connection graph from _CRS
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the delay.

On Thu, Nov 21, 2024 at 10:57=E2=80=AFPM Miao Wang <shankerwangmiao@gmail.c=
om> wrote:
>
> 2023=E5=B9=B411=E6=9C=887=E6=97=A5 00:09=EF=BC=8CRafael J. Wysocki <rjw@r=
jwysocki.net> =E5=86=99=E9=81=93=EF=BC=9A
> >
> >  +static acpi_status acpi_bus_check_add(acpi_handle handle, bool first_=
pass,
> >                                     struct acpi_device **adev_p)
> >   {
> >       struct acpi_device *device =3D acpi_fetch_acpi_dev(handle);
> >  @@ -2054,9 +2059,25 @@ static acpi_status acpi_bus_check_add(ac
> >               if (acpi_device_should_be_hidden(handle))
> >                       return AE_OK;
> >
> >  -            /* Bail out if there are dependencies. */
> >  -            if (acpi_scan_check_dep(handle, check_dep) > 0)
> >  -                    return AE_CTRL_DEPTH;
> >  +            if (first_pass) {
> >  +                    acpi_mipi_check_crs_csi2(handle);
> >  +
> >  +                    /* Bail out if there are dependencies. */
> >  +                    if (acpi_scan_check_dep(handle) > 0) {
> >  +                            /*
> >  +                             * The entire CSI-2 connection graph need=
s to be
> >  +                             * extracted before any drivers or scan h=
andlers
> >  +                             * are bound to struct device objects, so=
 scan
> >  +                             * _CRS CSI-2 resource descriptors for al=
l
> >  +                             * devices below the current handle.
> >  +                             */
> >  +                            acpi_walk_namespace(ACPI_TYPE_DEVICE, han=
dle,
> >  +                                                ACPI_UINT32_MAX,
> >  +                                                acpi_scan_check_crs_c=
si2_cb,
> >  +                                                NULL, NULL, NULL);
> >  +                            return AE_CTRL_DEPTH;
> >  +                    }
> >  +            }
> >
> >               fallthrough;
> >       case ACPI_TYPE_ANY:     /* for ACPI_ROOT_OBJECT */
> >
>
> Hi, I'd like to report some issues caused by this patch. Correct me if I'=
m wrong
> since I'm not expert on ACPI. Before this patch, properties of ACPI devic=
es with
> _DEP relationship declared were evaluated after the initialization of the
> depending devices, i.e. the execution of handler->attach(). With this pat=
ch,
> _CRS of all the ACPI devices are evaluated to check if the device contain=
s a
> CSI2 resource, regardless of the declaration of _DEP relationship.

Yes, but the _DEP information is not relevant for whether or not _CRS
may be evaluated at all.

> The evaluation of _CRS is even before _STA

Not really.  _STA has already been evaluated by
acpi_ns_init_one_device() for all devices at this point.

> and other methods indicating the status of the device.

No, but it doesn't matter, at least by the spec.  Had the device been
disabled, _CRS would have been expected to work anyway:

"If a device is disabled, then _CRS returns a valid resource template
for the device, but the actual resource assignments in the return byte
stream are ignored." (ACPI 6.5, Section 6.2.2. _CRS (Current Resource
Settings)).

That said, adding a device status check before the _CRS evaluation in
acpi_bus_check_add() is not inconceivable.

> This has caused some issues in certain scenarios, where the DSDT contains=
 legacy
> devices, which requires reading IO ports to form the result of its _CRS. =
An
> example of such a legacy device is declared in the DSDT is as below:
>
>     Device (LPT)
>     {
>         Name (_HID, EisaId ("PNP0400") /* Standard LPT Parallel Port */)
>         Name (_UID, 0x02)  // _UID: Unique ID
>         Name (_DDN, "LPT1")  // _DDN: DOS Device Name
>         Name (_DEP, Package (0x01)  // _DEP: Dependencies
>         {
>             \_SB.PCI0
>         })
>         OperationRegion (ITE1, SystemIO, 0x2E, 0x02)
>         Field (ITE1, ByteAcc, NoLock, Preserve) {INDX, 8,   DATA, 8}
>         IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
>         {
>             // Omitting some declarations of fields
>             IOAH,   8,
>             IOAL,   8,
>         }
>         Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settin=
gs
>         {
>             Name (BUF0, ResourceTemplate ()
>             {
>                 IO (Decode16,
>                     0x0378,             // Range Minimum
>                     0x0378,             // Range Maximum
>                     0x01,               // Alignment
>                     0x08,               // Length
>                     _Y01)
>                 IRQ (Level, ActiveLow, Exclusive, _Y02)
>                     {7}
>             })
>             CreateByteField (BUF0, \LPT._CRS._Y01._MIN, IOLO)
>             CreateByteField (BUF0, 0x03, IOHI)
>             CreateByteField (BUF0, \LPT._CRS._Y01._MAX, IORL)
>             CreateByteField (BUF0, 0x05, IORH)
>             CreateByteField (BUF0, \LPT._CRS._Y01._LEN, LEN1)
>             CreateByteField (BUF0, \LPT._CRS._Y02._INT, IRQL)
>
>             IOLO =3D IOAL /* \LPT_.IOAL */
>             IORL =3D IOAL /* \LPT_.IOAL */
>             IOHI =3D IOAH /* \LPT_.IOAH */
>             IORH =3D IOAH /* \LPT_.IOAH */
>             // Omitting some assignments and calculations
>
>             Return (BUF0)
>         }
>     }
>
> On non-x86 platforms, IO ports are implemented using MMIO. The memory is
> remapped in the initialization of the PCI root, using its QWordIO resourc=
e
> declared in its _CRS, in acpi_pci_root_remap_iospace(). Before the
> initialization of the PCI root, reads and writes of the IO ports will res=
ult in
> accessing memory region which is not mapped.

That's not really straightforward.

> Before this patch, adding a _DEP of Package(){PCI0} to these legacy devic=
es will
> postpone the initialization of these devices after the PCI root, solving =
the
> above problem. After this patch, however, the evaluation of _CRS regardle=
ss of
> _DEP declarations causes accessing IO ports before they are ready.

Well, before this patch, Linux simply did not have to evaluate _CRS
during device discovery.

Nowhere in the spec it is stated that _CRS cannot be evaluated for a
given device before enumerating all devices listed by its _DEP object.
As it is currently defined, _DEP is only about operation region
dependencies, not even about general device enumeration ordering (even
though it is used for enforcing specific enumeration ordering in the
field because OSes tend to enumerate devices in the order following
from _DEP as a matter of fact).

> I've checked the ACPI spec, and it states that ``OSPM must guarantee that=
 the
> following operation regions are always accessible: SystemIO operation reg=
ions"

Which to me is clearly at odds with the SystemIO implementation
description above.

> and ``Since the region types above are permanently available, no _REG met=
hods
> are required, nor will OSPM evaluate any _REG methods that appear in the =
same
> scope as the operation region declaration(s) of these types". It seems th=
at
> from the view of the AML codes in the DSDT, it can never know when the IO=
 ports
> are ready, and it is impossible for Linux on non-x86 platforms to ensure =
IO
> ports are always accessible.

They aren't always accessible anyhow.  They become accessible after
enumerating the PCI host bridge and they aren't accessible earlier.

> I wonder if there would be a better solution to this problem.

Well, it is a bit unfortunate that it took 6 kernel release cycles to
realize that there was a problem.  Had this been reported earlier,
there would have been more options on the table.

At this point, the functionality related to CSI-2 connection graphs
simply needs to be there, the only option for avoiding _CRS evaluation
in acpi_bus_check_add() would be to somehow defer the enumeration of
all devices using CSI-2 connections until the host bridge is
enumerated.  Alternatively, the enumeration of the PCI host bridge
might be pushed forward, but that would require addressing at least a
few enumeration ordering issues.  None of these would be a small
change and backporting any of that would have been a considerable
effort.

One of the things worth considering is whether or not CSI-2 is
relevant for the architectures that rely on the old behavior related
to _DEP.  If not at all, a Kconfig option could be added to disable
CSI-2 graphs enumeration on those architectures and that would make
the problem go away.

Also I'm wondering if the firmware could be updated to survive a mere
evaluation of _CRS if the hardware is not ready.

Thanks!

