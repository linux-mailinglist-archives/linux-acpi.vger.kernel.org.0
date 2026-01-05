Return-Path: <linux-acpi+bounces-19967-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7911FCF5729
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 20:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96021300A987
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C6029D29C;
	Mon,  5 Jan 2026 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl+sMnLs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0126C10FD
	for <linux-acpi@vger.kernel.org>; Mon,  5 Jan 2026 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767643196; cv=none; b=rxts0TS41DsbFqQQWmntA40C0KaAlUJMF5VlTKG4rA+/7E6cJJ9XRgQqO9apA92bLWDDKgDJmhe2lwaIrHJJjtYrgHlux5QUUDsj0pTgFTxnls6Ztf3oylDNFqN3UsQXmCeV1fOVjHiSscTsorb4baKKYbEaKjsGFwBRSPONeFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767643196; c=relaxed/simple;
	bh=rie8GE5gTW1H66Ivn3uC0IV/bF2bzI2p66akqDKODUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omjGwdv0IHYG2Ucb8VJ+nU1wk1uO5wcQAqV5a24uCrT5LKDcCjNn60nsw3qSF+wBuR0bPYC/F8CrVbJRaoPENVXG3zrB6yecOiY331GbKwMma6xM/+UuF+tflAj7obVaSkLbRv/c8akSZ5a16L8wviqgvFHJvSRsIs77RVOC9C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl+sMnLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4727C19425
	for <linux-acpi@vger.kernel.org>; Mon,  5 Jan 2026 19:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767643195;
	bh=rie8GE5gTW1H66Ivn3uC0IV/bF2bzI2p66akqDKODUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sl+sMnLs1Codz5TjXCN0hEJ15qbl4rN4XjHcr78RGVapHV6Yjer3WQmweJrH4+Jn8
	 OFZuAbbVFmASnTxn+rTsEjkbV2FFh3maBRK0sRsan++Ygxg2YpTHNtj3Tr1OQLQY/s
	 /EtliowGREfx3UXUpCEi/2DhjFGjkzDnMsUWoS1nGOEdw024VB0b/MeFOw1yLMZMwU
	 bN2skjv1e3RHKMWuQo6V4FAnreL0ZXrPjB3+TsjEK9E9goLhqbRWnrRutoJ0QHxsAR
	 g5vDTpPFc9j1g0SzYMhMBwj9lQ4lk/hFh6gZ7jNHgadt4EQW6d8clGakbfOxFlz8sC
	 iZijmmtYSS+XA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3e89d226c3aso240692fac.2
        for <linux-acpi@vger.kernel.org>; Mon, 05 Jan 2026 11:59:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrIWCKEw7mNWCw1lgp3NBZ5c19G96tgBQqrrnEMUQsIYcH7vxtjbvxUHrcrFPCk1KP2p3Y0m1DqwWs@vger.kernel.org
X-Gm-Message-State: AOJu0YwuygIuKneQwKoTGaonPMUTJQQhxAvtGLEj0rnjPUxNwDisD0bR
	nv7d/aREbq7rNDfbVboi+np3NjQsBMn5D3lFsPJ2LGy/LZH77M9zL43oRtfOcZoIx4PqtIo0fm7
	v5sIeWbmekpoLjGWahmtfitJ6Y5UBCS0=
X-Google-Smtp-Source: AGHT+IGdEaekIAWchtRRvqoH8Fp2CJHaWYphjcrVR4vKuwpy12mIulDvGnDtupw0V21Y2t5sHe/wZatj24dXVMqQAj0=
X-Received: by 2002:a4a:be94:0:b0:65f:1770:de44 with SMTP id
 006d021491bc7-65f47a8fc91mr275346eaf.63.1767643194897; Mon, 05 Jan 2026
 11:59:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5977355.DvuYhMxLoT@rafael.j.wysocki> <65f4e141-66b9-4120-87ba-5cbdcd02cb5f@infradead.org>
In-Reply-To: <65f4e141-66b9-4120-87ba-5cbdcd02cb5f@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Jan 2026 20:59:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hKNhspV9Rz4fydW0xu3SirYOOc_KZKEdATDA69PQ1F2w@mail.gmail.com>
X-Gm-Features: AQt7F2plK8GdhgZgJip6sHHS2wCvb6i7N2CkZxe4CwUtyQVvJwfL7lc5SHF-mpw
Message-ID: <CAJZ5v0hKNhspV9Rz4fydW0xu3SirYOOc_KZKEdATDA69PQ1F2w@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hansg@kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Armin Wolf <w_armin@gmx.de>, Danilo Krummrich <dakr@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 8:40=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 1/5/26 3:25 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> [snip]
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
> >
> > --- /dev/null
> > +++ b/Documentation/driver-api/acpi/acpi-drivers.rst
> > @@ -0,0 +1,80 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. include:: <isonum.txt>
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Why using ACPI drivers is not a good idea
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +:Copyright: |copy| 2026, Intel Corporation
> > +
> > +:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > +
> > +Even though binding drivers directly to struct acpi_device objects, al=
so
> > +referred to as "ACPI device nodes", allows basic functionality to be p=
rovided
> > +at least in some cases, there are problems with it, related to general
> > +consistency, sysfs layout, power management operation ordering, and co=
de
> > +cleanliness.
> > +
> > +First of all, ACPI device nodes represent firmware entities rather tha=
n
> > +hardware and in many cases they provide auxiliary information on devic=
es
> > +enumerated independently (like PCI devices or CPUs).  It is therefore =
generally
> > +questionable to assign resources to them because the entities represen=
ted by
> > +them do not decode addresses in the memory or I/O address spaces and d=
o not
> > +generate interrupts or similar (all of that is done by hardware).
> > +
> > +Second, as a general rule, a struct acpi_device can only be a parent o=
f another
> > +struct acpi_device.  If that is not the case, the location of the chil=
d device
> > +in the device hierarchy is at least confusing and it may not be straig=
htforward
> > +to identify the piece of hardware providing functionality represented =
by it.
> > +However, binding a driver directly to an ACPI device node may cause th=
at to
> > +happen if the given driver registers input devices or wakeup sources u=
nder it,
> > +for example.
> > +
> > +Next, using system suspend and resume callbacks directly on ACPI devic=
e nodes
> > +is questionable either because it may cause ordering problems to appea=
r.
>
> Missing the "or ..." following "either because ...".
> Or did you mean something like "also" instead of "either"?

Yes, I'll change it into "is also questionable".

>
> > +Namely, ACPI device nodes are registered before enumerating hardware
> > +corresponding to them and they land on the PM list in front of the maj=
ority
> > +of other device objects.  Consequently, the execution ordering of thei=
r PM
> > +callbacks may be different from what is generally expected.  Also, in =
general,
> > +dependencies returned by _DEP objects do not affect ACPI device nodes
> > +themselves, but the "physical" devices associated with them, which pot=
entially
> > +is one more source of inconsistency related to treating ACPI device no=
des as
> > +"real" device representation.
> > +
> > +All of the above means that binding drivers to ACPI device nodes shoul=
d
> > +generally be avoided and so struct acpi_driver objects should not be u=
sed.
> > +
> > +Moreover, a device ID is necessary to bind a driver directly to an ACP=
I device
> > +node, but device IDs are not generally associated with all of them.  S=
ome of
> > +them contain alternative information allowing the corresponding pieces=
 of
> > +hardware to be identified, for example represented by an _ADR object r=
eturn
> > +value, and device IDs are not used in those cases.  In consequence, co=
nfusingly
> > +enough, binding an ACPI driver to an ACPI device node may even be impo=
ssible.
> > +
> > +When that happens, the piece of hardware corresponding to the given AC=
PI device
> > +node is represented by another device object, like a struct pci_dev, a=
nd the
> > +ACPI device node is the "ACPI companion" of that device, accessible th=
rough its
> > +fwnode pointer used by the ACPI_COMPANION() macro.  The ACPI companion=
 holds
> > +additional information on the device configuration and possibly some "=
recipes"
> > +on device manipulation in the form of AML (ACPI Machine Language) byte=
 code
> > +provided by the platform firmware.  Thus the role of the ACPI device n=
ode is
> > +similar to the role of a struct device_node on a system where Device T=
ree is
> > +used for platform description.
> > +
> > +For consistency, this approach has been extended to the cases in which=
 ACPI
> > +device IDs are used.  Namely, in those cases, an additional device obj=
ect is
> > +created to represent the piece of hardware corresponding to a given AC=
PI device
> > +node.  By default, it is a platform device, but it may also be a PNP d=
evice, a
> > +CPU device, or another type of device, depending on what the given pie=
ce of
> > +hardware actually is.  There are even cases in which multiple devices =
are
> > +"backed" or "accompanied" by one ACPI device node (eg. ACPI device nod=
es
>
>                                                       e.g.

OK

