Return-Path: <linux-acpi+bounces-19959-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 188A4CF4E87
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 18:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0653330237B
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 16:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782F732E6A2;
	Mon,  5 Jan 2026 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="b4MXc7Hc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2C2221F13;
	Mon,  5 Jan 2026 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631878; cv=none; b=SFhrp1NznffflMr68aM9twzyz7vOH/LiA5hZnll6wj29pyGkeIery5mkLc8kJPgAUTjltS3a2F7j13BryAdBY3gx4ECFFYRrQWtd16RFUFSHgFc+El+hY33x4hjHirXzdutt3BwRboQTNVFJrVukRPJtbJE7KSFW9HQcVuiFJEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631878; c=relaxed/simple;
	bh=sWXv/Oav2uKzm8PmT7UqHsLjP2DnlVOfnuGNkuE/29k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIDTEcnsS7lMKUYAkZAH3iuTZ4Ml8CqiRGaVjy/0IT4iWV6BOWfvOEnjcBO5Df1YQ+tjjKDJUkwhsWgYqRr9L9me/CF1AKWaYtXje4/02IwKtz/jZ1jpE16ugafV6hThgx/NtPllEUIEPTKxO32SZPjG4bZMVFQFNwZjRRm0PW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=b4MXc7Hc; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1767631870; x=1768236670; i=w_armin@gmx.de;
	bh=AOw79OU8yBmXD+XxGxUrM40oVtrB3yf9b+o1Ox70poE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b4MXc7HcfPASTuYZSYdtgCPef/ca+57del66fv6KVSRs5sQy0ztr+mkttTOl9a3N
	 NjO69NG+626/kPQMP19bow6V2QsMWa8IMdbTmn4kPcE6cUU7r6h86tAbvfqEfdCir
	 kxF0trOB/Z+FVhejmU0z3qFkkydtr6gKAuy7EE+SPoBDEMQsZHVq0Qz/JlzgrkByE
	 ldanpCYXZyRFCSDAvmQz6IkCblWIroaAHCCXC0+8khMUtJc78lGR/OruX+Vfv7K8w
	 l8pGfD33Y0hdfd4gNRiONuUDLrF9wZnLf3XyHZBkoUO9Ed+zu1T75N2rPfhc56+1d
	 czL4W090iubFIVZsGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKYx-1vJCZl1bFX-00HsZl; Mon, 05
 Jan 2026 17:51:10 +0100
Message-ID: <575e9f6e-7cfb-4685-9579-c9be1f1daa63@gmx.de>
Date: Mon, 5 Jan 2026 17:51:07 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hansg@kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
References: <5977355.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <5977355.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7E992RnMwX0vR1WE3i/71p3pmJJLoTWr6GmAY4xr6y90FIHsAaf
 PmOqmBirwiQXDDbKiChg/reOpr33ZcWkFxCQeA2nQ3gaqRopsvbC2iKjEtuOwcWySRXv/LQ
 uAKVv+V43XYwYtovZKOQGknBJRYwAZHa5JDpkX+mYTvhl9ravlCT5IRSTLWdPg2MiEr+tMQ
 KySIO4xINHBYZSM3MFwFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vtVQgzH7NXs=;GqjJANNztxBJl7pmPiOxc8p/FY1
 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

Am 05.01.26 um 12:25 schrieb Rafael J. Wysocki:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Sadly, there is quite a bit of technical debt related to the
> kernel's ACPI support subsystem and one of the most significant
> pieces of it is the existence and use of ACPI drivers represented
> by struct acpi_driver objects.
>
> Those drivers are bound directly to struct acpi_device objects, also
> referred to as "ACPI device nodes", representing device objects in the
> ACPI namespace defined as:
>
>   A hierarchical tree structure in OS-controlled memory that contains
>   named objects. These objects may be data objects, control method
>   objects, bus/device package objects, and so on.
>
> according to the ACPI specification [1].
>
> The above definition implies, although rather indirectly, that the
> objects in question don't really represent hardware.  They are just
> "device package objects" containing some information on the devices
> present in the given platform that is known to the platform firmware.
>
> Although the platform firmware can be the only source of information on
> some devices, the information provided by it alone may be insufficient
> for device enumeration in general.  If that is the case, bindig a driver
> directly to a given ACPI device node clearly doesn't make sense.  If
> the device in question is enumerated through a hardware interface, it
> will be represented by a device object matching that interface, like
> a struct pci_dev, and the ACPI device node corresponding to it will be
> treated as its "ACPI companions" whose role is to amend the "native"
> enumeration mechanism.
>
> For the sake of consistency and confusion avoidance, it is better to
> treat ACPI device nodes in general as ACPI companions of other device
> objects representing hardware.  In some cases though it appeared easier
> to take a shortcut and use an ACPI driver binding directly to an ACPI
> device node.  Moreover, there were corner cases in which that was the
> only choice, but they all have been addressed now.
>
> In all cases in which an ACPI driver might be used, the ACPI device
> node it might bind to is an ACPI companion of another device object
> representing a piece of hardware.  It is thus better to use a driver
> binding to the latter than to use an ACPI driver and leave the other
> device object alone, not just because doing so is more consistent and
> less confusing, but also because using ACPI drivers may lead to
> potential functional deficiencies, like possible ordering issues
> related to power management.
>
> Unfortunately, there are quite a few ACPI drivers in use and, as a rule,
> they bind to ACPI device nodes that are ACPI companions of platform
> devices, so in fact they play the role of platform drivers although in
> a kind of convoluted way.  An effort has been under way to replace them
> with platform drivers, which is relatively straightforward in the vast
> majority of cases, but it has not been pursued very aggressively so far,
> mostly due to the existence of the corner cases mentioned above.
> However, since those corner cases are gone now, it makes sense to spend
> more time on driver conversions with the ultimate goal to get rid of
> struct acpi_driver and the related code from the kernel.
>
> To that end, add a document explaining why using ACPI drivers is not
> a good idea, so it need not be explained from scratch on every attempt
> to convert an ACPI driver to a platform one.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>
> Link: https://uefi.org/specs/ACPI/6.6/02_Definition_of_Terms.html#term-A=
CPI-Namespace [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Although this patch can be applied independently, it actually depends on
> some ACPI changes in linux-next and on
>
> https://lore.kernel.org/linux-acpi/12824456.O9o76ZdvQC@rafael.j.wysocki/
>
> so it is better to handle it along with that material.
>
> ---
>   Documentation/driver-api/acpi/acpi-drivers.rst |   80 ++++++++++++++++=
+++++++++
>   Documentation/driver-api/acpi/index.rst        |    1
>   2 files changed, 81 insertions(+)
>
> --- /dev/null
> +++ b/Documentation/driver-api/acpi/acpi-drivers.rst
> @@ -0,0 +1,80 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Why using ACPI drivers is not a good idea
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Copyright: |copy| 2026, Intel Corporation
> +
> +:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> +
> +Even though binding drivers directly to struct acpi_device objects, als=
o
> +referred to as "ACPI device nodes", allows basic functionality to be pr=
ovided
> +at least in some cases, there are problems with it, related to general
> +consistency, sysfs layout, power management operation ordering, and cod=
e
> +cleanliness.
> +
> +First of all, ACPI device nodes represent firmware entities rather than
> +hardware and in many cases they provide auxiliary information on device=
s
> +enumerated independently (like PCI devices or CPUs).  It is therefore g=
enerally
> +questionable to assign resources to them because the entities represent=
ed by
> +them do not decode addresses in the memory or I/O address spaces and do=
 not
> +generate interrupts or similar (all of that is done by hardware).
> +
> +Second, as a general rule, a struct acpi_device can only be a parent of=
 another
> +struct acpi_device.  If that is not the case, the location of the child=
 device
> +in the device hierarchy is at least confusing and it may not be straigh=
tforward
> +to identify the piece of hardware providing functionality represented b=
y it.
> +However, binding a driver directly to an ACPI device node may cause tha=
t to
> +happen if the given driver registers input devices or wakeup sources un=
der it,
> +for example.
> +
> +Next, using system suspend and resume callbacks directly on ACPI device=
 nodes
> +is questionable either because it may cause ordering problems to appear=
.
> +Namely, ACPI device nodes are registered before enumerating hardware
> +corresponding to them and they land on the PM list in front of the majo=
rity
> +of other device objects.  Consequently, the execution ordering of their=
 PM
> +callbacks may be different from what is generally expected.  Also, in g=
eneral,
> +dependencies returned by _DEP objects do not affect ACPI device nodes
> +themselves, but the "physical" devices associated with them, which pote=
ntially
> +is one more source of inconsistency related to treating ACPI device nod=
es as
> +"real" device representation.
> +
> +All of the above means that binding drivers to ACPI device nodes should
> +generally be avoided and so struct acpi_driver objects should not be us=
ed.
> +
> +Moreover, a device ID is necessary to bind a driver directly to an ACPI=
 device
> +node, but device IDs are not generally associated with all of them.  So=
me of
> +them contain alternative information allowing the corresponding pieces =
of
> +hardware to be identified, for example represented by an _ADR object re=
turn
> +value, and device IDs are not used in those cases.  In consequence, con=
fusingly
> +enough, binding an ACPI driver to an ACPI device node may even be impos=
sible.
> +
> +When that happens, the piece of hardware corresponding to the given ACP=
I device
> +node is represented by another device object, like a struct pci_dev, an=
d the
> +ACPI device node is the "ACPI companion" of that device, accessible thr=
ough its
> +fwnode pointer used by the ACPI_COMPANION() macro.  The ACPI companion =
holds
> +additional information on the device configuration and possibly some "r=
ecipes"
> +on device manipulation in the form of AML (ACPI Machine Language) byte =
code
> +provided by the platform firmware.  Thus the role of the ACPI device no=
de is
> +similar to the role of a struct device_node on a system where Device Tr=
ee is
> +used for platform description.
> +
> +For consistency, this approach has been extended to the cases in which =
ACPI
> +device IDs are used.  Namely, in those cases, an additional device obje=
ct is
> +created to represent the piece of hardware corresponding to a given ACP=
I device
> +node.  By default, it is a platform device, but it may also be a PNP de=
vice, a
> +CPU device, or another type of device, depending on what the given piec=
e of
> +hardware actually is.  There are even cases in which multiple devices a=
re
> +"backed" or "accompanied" by one ACPI device node (eg. ACPI device node=
s
> +corresponding to GPUs that may provide firmware interfaces for backligh=
t
> +brightness control in addition to GPU configuration information).
> +
> +This means that it really should never be necessary to bind a driver di=
rectly to
> +an ACPI device node because there is a "proper" device object represent=
ing the
> +corresponding piece of hardware that can be bound to by a "proper" driv=
er using
> +the given ACPI device node as the device's ACPI companion.  Thus, in pr=
inciple,
> +there is no reason to use ACPI drivers and if they all were replaced wi=
th other
> +driver types (for example, platform drivers), some code could be droppe=
d and
> +some complexity would go away.
> --- a/Documentation/driver-api/acpi/index.rst
> +++ b/Documentation/driver-api/acpi/index.rst
> @@ -7,3 +7,4 @@ ACPI Support
>  =20
>      linuxized-acpica
>      scan_handlers
> +   acpi-drivers
>
>
>

