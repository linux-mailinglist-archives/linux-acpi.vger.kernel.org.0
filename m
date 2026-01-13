Return-Path: <linux-acpi+bounces-20268-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7352D1B839
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 23:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8D3D302F90E
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 22:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92543352949;
	Tue, 13 Jan 2026 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQyeHgql"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F319350D62
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341741; cv=none; b=KqyFqVCyW1gJ+1AlvhGu52ADGzlwtNMeKz1HYkzkyAM4A+7cEuSi7j6GhsWpmEa9B7rUTROLgCgS7p2yqnqX/t/yHU9qWF2yQ1FGWulClBtRe8fxoPnDghje8GQbJeAhcbNFbzBf/MSUeQvAUMj8mJ09+a4qE/yy30F+75qnxmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341741; c=relaxed/simple;
	bh=4bek3je020EggdFEWGHiLu8CdQFqjkH0qnUPSvs6a64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIFZjE8frbEKTxP3gLcoBWEg/XjTCjOeb+f/p1lNLEVsNOi0qeD5RLmPCrME9YNmSnMTTZmn+K71+OifXfd7CJBRmESbw6hFHr3Wn+0uOWjQi0D50hqv2fg3cB4jmq3VR+zlDw0SrdcKRIkIxwSXWrtALIvbKIolk4IK8VhMJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQyeHgql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136C0C19423
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 22:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768341741;
	bh=4bek3je020EggdFEWGHiLu8CdQFqjkH0qnUPSvs6a64=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dQyeHgqlVojY9lkJvBIhzsH4BZglCnKLA7HS+BTwuVx2vc135FIKKOu3BxmF4QqH0
	 F1rF1cpl11fsKbVUtBwXxEjEJZ4a40Y6NH0G9jAWyam3U3DjUDrCiud6Tr7khuwMeW
	 2ik0+NnJlRO+Zt5L6mNkHjJLiCMm/1wSDvONufT0wSeRvoPDNqUGh2qYm1qxF7vmtR
	 GC2yrMXb/cWJwV7w1JajbfdwiQzocP+bdmlIJGHOb61ftOCc1VOh/fwD9mU+RqpODY
	 VljPPMy9kf3N2JiOiRd4fe29YsmJILCap1MPFCDGgH6ud8VuWV9rHxIk1oOI1k9HVy
	 k24m87g7AjtSA==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-65f6f9d84d6so2059632eaf.1
        for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 14:02:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtMYgdvQCM3I/cWoivPLx+N0r9mpspKhZ1j7XXGHZN+AJtJ1//juHuE+XH5kyJQ8yYVevJfe+rKJ1Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzrIUNtQjvsd/BtRT7Wrp+qgKpU82B6RiggD/dhNtwQtG6qq99U
	NqoecarVwhgtNIq+UcmCrZnvz1XqvviP24W9+8hYdHklVKRM+yEyosoWABFDqenNIaru6XhNbT1
	6SsAY6xVOZbdY7sWllkuSGLhE+vQOIOQ=
X-Received: by 2002:a4a:c910:0:b0:65f:6aa6:fc4b with SMTP id
 006d021491bc7-66100638a25mr283411eaf.19.1768341740173; Tue, 13 Jan 2026
 14:02:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2396510.ElGaqSPkdT@rafael.j.wysocki> <65c7a296-7dc7-4368-9b2d-6fadd0dbf9c6@kernel.org>
 <CAJZ5v0ihuu_9G7N5UkHAGwRq=BN1spkXmdOuUTxRFwn3acdfbw@mail.gmail.com> <cfe29b78-93c1-423f-930d-10e4fcda6987@kernel.org>
In-Reply-To: <cfe29b78-93c1-423f-930d-10e4fcda6987@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Jan 2026 23:02:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0heEwzVx39wz3qNThpniG3kPfEkk87Y2xTXBbmNaiEKrQ@mail.gmail.com>
X-Gm-Features: AZwV_QgaVN7dNsgHxuGkjjPZIvsHayUbHIORYqi1FGGzOnab7aVghlCvS0CP-A0
Message-ID: <CAJZ5v0heEwzVx39wz3qNThpniG3kPfEkk87Y2xTXBbmNaiEKrQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hansg@kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Armin Wolf <w_armin@gmx.de>, Danilo Krummrich <dakr@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 10:58=E2=80=AFPM Mario Limonciello (AMD) (kernel.or=
g)
<superm1@kernel.org> wrote:
>
>
>
> On 1/7/2026 6:22 AM, Rafael J. Wysocki wrote:
> > On Tue, Jan 6, 2026 at 4:47=E2=80=AFPM Mario Limonciello (AMD) (kernel.=
org)
> > <superm1@kernel.org> wrote:
> >>
> >>
> >>
> >> On 1/6/2026 6:27 AM, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Sadly, there is quite a bit of technical debt related to the
> >>> kernel's ACPI support subsystem and one of the most significant
> >>> pieces of it is the existence and use of ACPI drivers represented
> >>> by struct acpi_driver objects.
> >>>
> >>> Those drivers are bound directly to struct acpi_device objects, also
> >>> referred to as "ACPI device nodes", representing device objects in th=
e
> >>> ACPI namespace defined as:
> >>>
> >>>    A hierarchical tree structure in OS-controlled memory that contain=
s
> >>>    named objects. These objects may be data objects, control method
> >>>    objects, bus/device package objects, and so on.
> >>>
> >>> according to the ACPI specification [1].
> >>>
> >>> The above definition implies, although rather indirectly, that the
> >>> objects in question don't really represent hardware.  They are just
> >>> "device package objects" containing some information on the devices
> >>> present in the given platform that is known to the platform firmware.
> >>>
> >>> Although the platform firmware can be the only source of information =
on
> >>> some devices, the information provided by it alone may be insufficien=
t
> >>> for device enumeration in general.  If that is the case, binding a
> >>> driver directly to a given ACPI device node clearly doesn't make sens=
e.
> >>> If the device in question is enumerated through a hardware interface,=
 it
> >>> will be represented by a device object matching that interface, like
> >>> a struct pci_dev, and the ACPI device node corresponding to it will b=
e
> >>> treated as its "ACPI companions" whose role is to amend the "native"
> >>> enumeratiom mechanism.
> >>>
> >>> For the sake of consistency and confusion avoidance, it is better to
> >>> treat ACPI device nodes in general as ACPI companions of other device
> >>> objects representing hardware.  In some cases though it appeared easi=
er
> >>> to take a shortcut and use an ACPI driver binding directly to an ACPI
> >>> device node.  Moreover, there were corner cases in which that was the
> >>> only choice, but they all have been addressed now.
> >>>
> >>> In all cases in which an ACPI driver might be used, the ACPI device
> >>> node it might bind to is an ACPI companion of another device object
> >>> representing a piece of hardware.  It is thus better to use a driver
> >>> binding to the latter than to use an ACPI driver and leave the other
> >>> device object alone, not just because doing so is more consistent and
> >>> less confusing, but also because using ACPI drivers may lead to
> >>> potential functional deficiencies, like possible ordering issues
> >>> related to power management.
> >>>
> >>> Unfortunately, there are quite a few ACPI drivers in use and, as a ru=
le,
> >>> they bind to ACPI device nodes that are ACPI companions of platform
> >>> devices, so in fact they play the role of platform drivers although i=
n
> >>> a kind of convoluted way.  An effort has been under way to replace th=
em
> >>> with platform drivers, which is relatively straightforward in the vas=
t
> >>> majority of cases, but it has not been pursued very aggressively so f=
ar,
> >>> mostly due to the existence of the corner cases mentioned above.
> >>
> >> This is the same as Danilo's comment; but could you leave a few exampl=
es
> >> of conversions that have been done successfully?  Commit hashes that c=
an
> >> demonstrate what it actually takes to convert an acpi driver to a
> >> platform driver and might make it easier for people to reference when
> >> this comes up.
> >
> > The purpose of this posting and the new document is to grow awareness
> > rather than to tell people how to convert drivers.
> >
> > I'll start posting driver conversion patches at one point and the
> > motivation for all of them is basically the same, so I thought it
> > would be better to document it in on place and then refer to it
> > instead of repeating the same information every time a conversion
> > patch is posted.
>
> Thanks for explaining.  Makes sense to me.  If you didn't already commit
> feel free to add my tag (no need to spin it if you already did).
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

I did, but adding a tag to it is not a big deal, thanks!

