Return-Path: <linux-acpi+bounces-19966-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94480CF5675
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 20:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53C943029E89
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 19:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C1F30F95B;
	Mon,  5 Jan 2026 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qjN81QtU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CAD13FEE;
	Mon,  5 Jan 2026 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642028; cv=none; b=pi1V2h3XarYLxxr3yYMqVWk4Xk4twgOY7aQF0GeESw99f6rjjYoXkCXyeM3ciS76LUTyAVQA6GUYp0JJ4xMkeqK9CI0cKmUZOFig25ySMh1EYV/KLaI/4OxkycPnmkdNf0UvaR0cIuYXl1pIX/LXTaZhqLBZaiHShlRIDWtOVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642028; c=relaxed/simple;
	bh=gR7shHQ1W8BLAqwRbxUUJJlDXLfwLNI8k6P7t86gJDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmczKRq3Bc8eQPrPj32CIbg1UfyLXTkigHcDVkjc3hI0dVOuIGp+3ULy60cYaj3BzTt52UpchPV+S486L8qxJ4D0f4d1kx6x4X3Q4TxVMMj7ThdPhPx2ktEiQgv60EepGj+/6V/RZHcAHHNfWv2fN9n8vQYaYCmpnPhwRMfwEyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qjN81QtU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=iHC/Y7+f8l87m1EMOasn4E3SL5094D6kI3trpvT3src=; b=qjN81QtUwyPKn8ZgmUFl1zGxDv
	RB8PHuzC/9N74pminQ0slcj+sMEazzwwClRJD7Zja9AIvzaNumslHkszQMMu9ctXYdTQNSFy1PUAx
	RGadKaMI6ch/bVLZxw+32k3gltemL54HC2lge7f5KNHV3f8bbthlJlxD6zn5S9xTCJhMXeOThTs/D
	m1tQlqw8ClHHxBmSd4rUwYw60hque3SyetWDIPk4ebnBaruek6Do0O9ql+9H/V0HT/ZOnTsztggNK
	fx7XQM0rwqK2Zr3Pl0u6+SbxMx+FM/whuoj/fX8wHe4CkG19W8nuJxGcA5x+wHKQvCZUb0Uqn7/zv
	8dV+13Zg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcqRD-0000000BzcB-1w5Y;
	Mon, 05 Jan 2026 19:40:24 +0000
Message-ID: <65f4e141-66b9-4120-87ba-5cbdcd02cb5f@infradead.org>
Date: Mon, 5 Jan 2026 11:40:21 -0800
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
 Zhang Rui <rui.zhang@intel.com>, Armin Wolf <w_armin@gmx.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
References: <5977355.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5977355.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/5/26 3:25 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
[snip]
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
> +is questionable either because it may cause ordering problems to appear.

Missing the "or ..." following "either because ...".
Or did you mean something like "also" instead of "either"?

> +Namely, ACPI device nodes are registered before enumerating hardware
> +corresponding to them and they land on the PM list in front of the majority
> +of other device objects.  Consequently, the execution ordering of their PM
> +callbacks may be different from what is generally expected.  Also, in general,
> +dependencies returned by _DEP objects do not affect ACPI device nodes
> +themselves, but the "physical" devices associated with them, which potentially
> +is one more source of inconsistency related to treating ACPI device nodes as
> +"real" device representation.
> +
> +All of the above means that binding drivers to ACPI device nodes should
> +generally be avoided and so struct acpi_driver objects should not be used.
> +
> +Moreover, a device ID is necessary to bind a driver directly to an ACPI device
> +node, but device IDs are not generally associated with all of them.  Some of
> +them contain alternative information allowing the corresponding pieces of
> +hardware to be identified, for example represented by an _ADR object return
> +value, and device IDs are not used in those cases.  In consequence, confusingly
> +enough, binding an ACPI driver to an ACPI device node may even be impossible.
> +
> +When that happens, the piece of hardware corresponding to the given ACPI device
> +node is represented by another device object, like a struct pci_dev, and the
> +ACPI device node is the "ACPI companion" of that device, accessible through its
> +fwnode pointer used by the ACPI_COMPANION() macro.  The ACPI companion holds
> +additional information on the device configuration and possibly some "recipes"
> +on device manipulation in the form of AML (ACPI Machine Language) byte code
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
> +"backed" or "accompanied" by one ACPI device node (eg. ACPI device nodes

                                                      e.g.

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


-- 
~Randy


