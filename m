Return-Path: <linux-acpi+bounces-19952-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FE3CF482D
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 16:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39F6F316358B
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDF02BD597;
	Mon,  5 Jan 2026 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UHVCKfKJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB128135D;
	Mon,  5 Jan 2026 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620854; cv=none; b=CNpW2fVKbfYRU1q1uExJRECGoRnQzTx1zkkGNW9PTSrt7X8ttzeOY2kB/5/h1zFU7E+J41Ip75CdBXLQ7CeKjFYsMq+CrPDdenHuU0u2wGJR85msB2LRMQDqAuncpYm7A4zOiDs/VhBeAl5CZgFsFb6iYaIz2th3LlB5FDxV5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620854; c=relaxed/simple;
	bh=WSOCjjD2DBq0Cb2Rn+veRBCmNUrRwIQn/Krzmz9lGOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfTM4/nmvH8XHwpIB46zPokBJxy5wmhq2pFqIJSCQq7xH++ulqF0W6Xi6LGAAnPgPFnULSjIR/KSJXUUQssi4khfxdipycaJ8mUQymlidoir7tZvQCysrAv+LY2aBcvgN18gGhRh5893cEERb5fAz9+sLdHHuUbjHTn+ZHGoaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UHVCKfKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20030C116D0;
	Mon,  5 Jan 2026 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767620853;
	bh=WSOCjjD2DBq0Cb2Rn+veRBCmNUrRwIQn/Krzmz9lGOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHVCKfKJkqg7z/wkGDQGvzk8D1rC5DzLMDhGMrJiwYcARXd49ljj9Rd7Z7EC85sdh
	 xKwH6ZPVBiJ/CX0qr1SZwvlHFNpsqIIU6Ak0h7HxKzjFLoiGTmcXGrQp4fQnl8S0KY
	 hjxaC1T6FUzmlGytELuBxWE5mxHdV2V885pKMCkg=
Date: Mon, 5 Jan 2026 14:47:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Armin Wolf <w_armin@gmx.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
Message-ID: <2026010553-capable-chip-88d7@gregkh>
References: <5977355.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5977355.DvuYhMxLoT@rafael.j.wysocki>

On Mon, Jan 05, 2026 at 12:25:04PM +0100, Rafael J. Wysocki wrote:
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
>  A hierarchical tree structure in OS-controlled memory that contains
>  named objects. These objects may be data objects, control method
>  objects, bus/device package objects, and so on.
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
> 
> Link: https://uefi.org/specs/ACPI/6.6/02_Definition_of_Terms.html#term-ACPI-Namespace [1]
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
>  Documentation/driver-api/acpi/acpi-drivers.rst |   80 +++++++++++++++++++++++++
>  Documentation/driver-api/acpi/index.rst        |    1 
>  2 files changed, 81 insertions(+)

Documenting this is fine, but really, just moving all of the existing
drivers to not use this and deleting the api entirely might be simplest.
Looks like the only "new" acpi drivers that show up are in the
platform/x86/ subsystem, so just tell the maintainers there not to take
any new ones?

thanks,

greg k-h

