Return-Path: <linux-acpi+bounces-19979-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D36FCF93A9
	for <lists+linux-acpi@lfdr.de>; Tue, 06 Jan 2026 17:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73C3830BDB89
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jan 2026 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4CB34D3AE;
	Tue,  6 Jan 2026 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqsILDT+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D334D3A9;
	Tue,  6 Jan 2026 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714429; cv=none; b=SORRwk9ifrzW24rYvcFajzmLXsNjYlRxJwKdBFMuW1zxlk4eIBziBg8r8YFZXrCkSBs62lFineU9L/Z394cwfsI/bXYIGRBWrHR36V1HEmvZ7zdwmpBMq5//U8Ru9WAqVOjhuLylGYqgGU1uZA9w+A5O2yiOhkMWudNX6rc20/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714429; c=relaxed/simple;
	bh=GtO+NuUpYKeE+WmjwXQmin9hFMsq6SXJs4VncfVQGoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHbKDYwE8JufXiniNYW/cjefbDhfoXLGv45aX1eteBpmctAnIscooz8C5MwRZwWGz8cnYkuayr6SpyTn/pIx2zj3RmL/CYPZE2i9PKJHPAJ/4mtNpMtaKqb8fFp6PmxrkL6Lzyv/x7Ck6mJCV/qv+7vWUE6tCVeBkiaWqCRuP3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqsILDT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C9EC116C6;
	Tue,  6 Jan 2026 15:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767714428;
	bh=GtO+NuUpYKeE+WmjwXQmin9hFMsq6SXJs4VncfVQGoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RqsILDT+R0k6tNqUxCG1LsDj2gcGG3IjkcKYf/EqHDjP6pir7XLKLcZ55SIMoWO9W
	 QYqk3FVd8kDUQNSuNbDKVh6qyjVgltwbFSUwGPwSZmRUCbl7lspWSnNToACvxzzEfI
	 yrpwnRpS76+GQAqjI3r4I7fw2EnTlTWYZmexSB2mwTh5ETSyNnIw5IPgqZiYEQrmOX
	 XpS3kdF4lXy0S5FMlDa/YDHbOK7Q4Hf35wT0pacg0xA/0xxGQvPGtBU5fxCevwYP2/
	 L2TWqObauSOZ987OSvd+CNUesgTPGc7uf+t9njA9g20L3qKIH3ozVjBb235/LYpBHn
	 8UkckbqPteKmw==
Message-ID: <65c7a296-7dc7-4368-9b2d-6fadd0dbf9c6@kernel.org>
Date: Tue, 6 Jan 2026 09:47:05 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: Documentation: driver-api: Disapprove of using
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
 Zhang Rui <rui.zhang@intel.com>, Armin Wolf <w_armin@gmx.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
References: <2396510.ElGaqSPkdT@rafael.j.wysocki>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <2396510.ElGaqSPkdT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/6/2026 6:27 AM, Rafael J. Wysocki wrote:
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
> for device enumeration in general.  If that is the case, binding a
> driver directly to a given ACPI device node clearly doesn't make sense.
> If the device in question is enumerated through a hardware interface, it
> will be represented by a device object matching that interface, like
> a struct pci_dev, and the ACPI device node corresponding to it will be
> treated as its "ACPI companions" whose role is to amend the "native"
> enumeratiom mechanism.
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

This is the same as Danilo's comment; but could you leave a few examples 
of conversions that have been done successfully?  Commit hashes that can 
demonstrate what it actually takes to convert an acpi driver to a 
platform driver and might make it easier for people to reference when 
this comes up.

> However, since those corner cases are gone now, it makes sense to spend
> more time on driver conversions with the ultimate goal to get rid of
> struct acpi_driver and the related code from the kernel.
> 
> To that end, add a document explaining why using ACPI drivers is not
> a good idea, so it need not be explained from scratch on every attempt
> to convert an ACPI driver to a platform one.
> 
> Link: https://uefi.org/specs/ACPI/6.6/02_Definition_of_Terms.html#term-ACPI-Namespace [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> ---
> 
> v1 -> v2:
>     * Fixed a typo in the changelog (Andy).
>     * Addressed two review comments from Randy ("is questionable either" ->
>       "is also questionable" and "eg." -> "e.g.").
>     * Added R-bys from Andy and Armin.
> 
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
>   Documentation/driver-api/acpi/acpi-drivers.rst |   80 +++++++++++++++++++++++++
>   Documentation/driver-api/acpi/index.rst        |    1
>   2 files changed, 81 insertions(+)
> 
> --- /dev/null
> +++ b/Documentation/driver-api/acpi/acpi-drivers.rst
> @@ -0,0 +1,80 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +=========================================
> +Why using ACPI drivers is not a good idea
> +=========================================
> +
> +:Copyright: |copy| 2026, Intel Corporation
> +
> +:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> +
> +Even though binding drivers directly to struct acpi_device objects, also
> +referred to as "ACPI device nodes", allows basic functionality to be provided
> +at least in some cases, there are problems with it, related to general
> +consistency, sysfs layout, power management operation ordering, and code
> +cleanliness.
> +
> +First of all, ACPI device nodes represent firmware entities rather than
> +hardware and in many cases they provide auxiliary information on devices
> +enumerated independently (like PCI devices or CPUs).  It is therefore generally
> +questionable to assign resources to them because the entities represented by
> +them do not decode addresses in the memory or I/O address spaces and do not
> +generate interrupts or similar (all of that is done by hardware).
> +
> +Second, as a general rule, a struct acpi_device can only be a parent of another
> +struct acpi_device.  If that is not the case, the location of the child device
> +in the device hierarchy is at least confusing and it may not be straightforward
> +to identify the piece of hardware providing functionality represented by it.
> +However, binding a driver directly to an ACPI device node may cause that to
> +happen if the given driver registers input devices or wakeup sources under it,
> +for example.
> +
> +Next, using system suspend and resume callbacks directly on ACPI device nodes
> +is also questionable because it may cause ordering problems to appear.  Namely,
> +ACPI device nodes are registered before enumerating hardware corresponding to
> +them and they land on the PM list in front of the majority of other device
> +objects.  Consequently, the execution ordering of their PM callbacks may be
> +different from what is generally expected.  Also, in general, dependencies
> +returned by _DEP objects do not affect ACPI device nodes themselves, but the
> +"physical" devices associated with them, which potentially is one more source
> +of inconsistency related to treating ACPI device nodes as "real" device
> +representation.
> +
> +All of the above means that binding drivers to ACPI device nodes should
> +generally be avoided and so struct acpi_driver objects should not be used.
> +
> +Moreover, a device ID is necessary to bind a driver directly to an ACPI device
> +node, but device IDs are not generally associated with all of them.  Some of
> +them contain alternative information allowing the corresponding pieces of
> +hardware to be identified, for example represeted by an _ADR object return
> +value, and device IDs are not used in those cases.  In consequence, confusingly
> +enough, binding an ACPI driver to an ACPI device node may even be impossible.
> +
> +When that happens, the piece of hardware corresponding to the given ACPI device
> +node is represented by another device object, like a struct pci_dev, and the
> +ACPI device node is the "ACPI companion" of that device, accessible through its
> +fwnode pointer used by the ACPI_COMPANION() macro.  The ACPI companion holds
> +additional information on the device configuration and possibly some "recipes"
> +on device manipulation in the form of AML (ACPI Machine Language) bytecode
> +provided by the platform firmware.  Thus the role of the ACPI device node is
> +similar to the role of a struct device_node on a system where Device Tree is
> +used for platform description.
> +
> +For consistency, this approach has been extended to the cases in which ACPI
> +device IDs are used.  Namely, in those cases, an additional device object is
> +created to represent the piece of hardware corresponding to a given ACPI device
> +node.  By default, it is a platform device, but it may also be a PNP device, a
> +CPU device, or another type of device, depending on what the given piece of
> +hardware actually is.  There are even cases in which multiple devices are
> +"backed" or "accompanied" by one ACPI device node (e.g. ACPI device nodes
> +corresponding to GPUs that may provide firmware interfaces for backlight
> +brightness control in addition to GPU configuration information).
> +
> +This means that it really should never be necessary to bind a driver directly to
> +an ACPI device node because there is a "proper" device object representing the
> +corresponding piece of hardware that can be bound to by a "proper" driver using
> +the given ACPI device node as the device's ACPI companion.  Thus, in principle,
> +there is no reason to use ACPI drivers and if they all were replaced with other
> +driver types (for example, platform drivers), some code could be dropped and
> +some complexity would go away.
> --- a/Documentation/driver-api/acpi/index.rst
> +++ b/Documentation/driver-api/acpi/index.rst
> @@ -7,3 +7,4 @@ ACPI Support
>   
>      linuxized-acpica
>      scan_handlers
> +   acpi-drivers
> 
> 
> 


