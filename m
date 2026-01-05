Return-Path: <linux-acpi+bounces-19962-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A43ECF5184
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 18:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AF13302F90B
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 17:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F854314B87;
	Mon,  5 Jan 2026 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOnxwGmN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4213064AA
	for <linux-acpi@vger.kernel.org>; Mon,  5 Jan 2026 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635607; cv=none; b=uk+fM3PnTx0yNoq4tHDNVMbRRZa3zgcmVmluW25K9uqBNYj6LoHc8IiX6sTlyMywT2P4M8oqd9eaVBF2oo4w5y87HpDjpgzsJ6AJ3SMbMuDL4bmRslITbAwCPBDysyGmpFjpVslTGY9WwwpaW/PZj4GEcK3XiJ0paf9zH38ZnvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635607; c=relaxed/simple;
	bh=Ux87hSa/68cLrLbR1ZzCFUiDvj3dhNvAwil2Gxc0MrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0ndZsKdaxBeWj3lF8M3Ue0LMBuKsk9Qraa5VPEncouhNmbQ7wUfGwOEk7hdHhpaMLnQSSm/r46l3vW9Vsu0EM991VzhrTaFzcYndJ2TXk+JsmReP6/1KYyZBRCBsH3gtDr6HEhH1mt1BNZjvDzhX/JbXwi4jp+8nBUvFrzr4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOnxwGmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AC0C2BCB3
	for <linux-acpi@vger.kernel.org>; Mon,  5 Jan 2026 17:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767635606;
	bh=Ux87hSa/68cLrLbR1ZzCFUiDvj3dhNvAwil2Gxc0MrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lOnxwGmNE/bn7/PZzPU//WPUz3UX3w5bnVpfoKqJxfVA2NzpL2i3eR5zTiOFB1CPe
	 v9aTnFuoxT8JnT77MUcz7cbYw+b1OA9gFcgox32MEVM8zfcMSrA7CjLk7dD2BkJrsk
	 Jo8hALRXVndzywcJn1nu4RYXl4tUy4H2zPe6aFI6FbvZLsSkiHCpy2N1B0MwwyULhu
	 luQv3AEs14pQhAeNBqG21lioYtxsGVU5OAP/EOFgi4OifR8XxMx0e5mdblk4Xts8u1
	 mbZZVopjPYd7FM7OlqRTNo+OTX6HZs2kZByhV6F1IVolFQtPbV5NeEy0ne3curhwua
	 NTWYSHstqjrsQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3e3dac349easo166490fac.2
        for <linux-acpi@vger.kernel.org>; Mon, 05 Jan 2026 09:53:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXLS/RBc1gpdV49B4G9dfDhdkFLBrrnabWoBEkzXDLmjAc8NkpYRE8uD+sUN0+TKjd02zpH5VRYKGe@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu9/HaplLqvVo8088Ef5fN9JQRiWN6tXBAhTh5MZVOjcT2XQLy
	XymrJkc8+Tz7FVNuiYih63prMp4OEPbzrp/VKCmnPtGi64D9Si4ItPW6YS7LPzbZBFj4VDFxKJo
	IP8AUBkVRw8gmAApwumhDwLAqz5MKqAE=
X-Google-Smtp-Source: AGHT+IFhF5egrl4ZCq8xWFr+RoYVu40Zi1s5l8ky0E1Xv2jtj/ZH7g9+rHUhIzI9ZvmtV4nxRcx3nQAMiifxAdK2cSw=
X-Received: by 2002:a4a:c3c8:0:b0:65c:fdd9:6f54 with SMTP id
 006d021491bc7-65f47a682a6mr105538eaf.69.1767635605624; Mon, 05 Jan 2026
 09:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5977355.DvuYhMxLoT@rafael.j.wysocki> <2026010553-capable-chip-88d7@gregkh>
In-Reply-To: <2026010553-capable-chip-88d7@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Jan 2026 18:53:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jnnYyOnc5s4FijXS9sAyu5Mpgc4KLmR6DV-oTUwqttKA@mail.gmail.com>
X-Gm-Features: AQt7F2r5D6vvyl6-k8-gOfwQtYVwQ1cHwnr-uoTCiiXrBJyk7eWn5JiDgK2rNSA
Message-ID: <CAJZ5v0jnnYyOnc5s4FijXS9sAyu5Mpgc4KLmR6DV-oTUwqttKA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Hans de Goede <hansg@kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Armin Wolf <w_armin@gmx.de>, Danilo Krummrich <dakr@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 2:47=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 05, 2026 at 12:25:04PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Sadly, there is quite a bit of technical debt related to the
> > kernel's ACPI support subsystem and one of the most significant
> > pieces of it is the existence and use of ACPI drivers represented
> > by struct acpi_driver objects.
> >
> > Those drivers are bound directly to struct acpi_device objects, also
> > referred to as "ACPI device nodes", representing device objects in the
> > ACPI namespace defined as:
> >
> >  A hierarchical tree structure in OS-controlled memory that contains
> >  named objects. These objects may be data objects, control method
> >  objects, bus/device package objects, and so on.
> >
> > according to the ACPI specification [1].
> >
> > The above definition implies, although rather indirectly, that the
> > objects in question don't really represent hardware.  They are just
> > "device package objects" containing some information on the devices
> > present in the given platform that is known to the platform firmware.
> >
> > Although the platform firmware can be the only source of information on
> > some devices, the information provided by it alone may be insufficient
> > for device enumeration in general.  If that is the case, bindig a drive=
r
> > directly to a given ACPI device node clearly doesn't make sense.  If
> > the device in question is enumerated through a hardware interface, it
> > will be represented by a device object matching that interface, like
> > a struct pci_dev, and the ACPI device node corresponding to it will be
> > treated as its "ACPI companions" whose role is to amend the "native"
> > enumeration mechanism.
> >
> > For the sake of consistency and confusion avoidance, it is better to
> > treat ACPI device nodes in general as ACPI companions of other device
> > objects representing hardware.  In some cases though it appeared easier
> > to take a shortcut and use an ACPI driver binding directly to an ACPI
> > device node.  Moreover, there were corner cases in which that was the
> > only choice, but they all have been addressed now.
> >
> > In all cases in which an ACPI driver might be used, the ACPI device
> > node it might bind to is an ACPI companion of another device object
> > representing a piece of hardware.  It is thus better to use a driver
> > binding to the latter than to use an ACPI driver and leave the other
> > device object alone, not just because doing so is more consistent and
> > less confusing, but also because using ACPI drivers may lead to
> > potential functional deficiencies, like possible ordering issues
> > related to power management.
> >
> > Unfortunately, there are quite a few ACPI drivers in use and, as a rule=
,
> > they bind to ACPI device nodes that are ACPI companions of platform
> > devices, so in fact they play the role of platform drivers although in
> > a kind of convoluted way.  An effort has been under way to replace them
> > with platform drivers, which is relatively straightforward in the vast
> > majority of cases, but it has not been pursued very aggressively so far=
,
> > mostly due to the existence of the corner cases mentioned above.
> > However, since those corner cases are gone now, it makes sense to spend
> > more time on driver conversions with the ultimate goal to get rid of
> > struct acpi_driver and the related code from the kernel.
> >
> > To that end, add a document explaining why using ACPI drivers is not
> > a good idea, so it need not be explained from scratch on every attempt
> > to convert an ACPI driver to a platform one.
> >
> > Link: https://uefi.org/specs/ACPI/6.6/02_Definition_of_Terms.html#term-=
ACPI-Namespace [1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Although this patch can be applied independently, it actually depends o=
n
> > some ACPI changes in linux-next and on
> >
> > https://lore.kernel.org/linux-acpi/12824456.O9o76ZdvQC@rafael.j.wysocki=
/
> >
> > so it is better to handle it along with that material.
> >
> > ---
> >  Documentation/driver-api/acpi/acpi-drivers.rst |   80 ++++++++++++++++=
+++++++++
> >  Documentation/driver-api/acpi/index.rst        |    1
> >  2 files changed, 81 insertions(+)
>
> Documenting this is fine, but really, just moving all of the existing
> drivers to not use this and deleting the api entirely might be simplest.

That's the final goal, but there are ~45 ACPI drivers in the tree (as
of my current linux-next branch) in several different subsystems, so
it may take a few cycles to convert all of them.

Also, I'm not expecting this doc to ever change, so reverting the
commit adding it when all of the ACPI drivers have been converted
should be trivial.

> Looks like the only "new" acpi drivers that show up are in the
> platform/x86/ subsystem, so just tell the maintainers there not to take
> any new ones?

That's one of the goals of this posting. :-)

