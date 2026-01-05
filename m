Return-Path: <linux-acpi+bounces-19956-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A808BCF487E
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 16:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8244331AE613
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 15:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECED33ADAC;
	Mon,  5 Jan 2026 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Diz4d3x4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C8F33A9FE;
	Mon,  5 Jan 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627946; cv=none; b=VnZ4qzI0iJdURv5MmUZ7rqk+R727y0hNLP1MZbrfgzF1lvS4rlvSwI5lNN0T8PwClekT0bpcgwyV/hGlEIYCjOzU0xHcGXdMlTR9l19jozxSqrzEgubb1L9MohFY9K502pZUZ7OnjpMCzXahohzXjNI3xcGA7PpF/z8YRu7vRM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627946; c=relaxed/simple;
	bh=a2Xh755bovxvDuxi7l+L79WtVNLIDy5zDE/sGra80SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tk7jZjHVnzAqhJSt5UnJPMxyRd2emsHa41+CrS5uhyzak08/cjBoaf13oHSr297dKEMAmIVnbgy6FNnHZ0VOBX/ugt5R/EsLtqDMheTU6rIT2xjKhUehyyfb1Dr0nI5rNOw5JmFbIQll0knW7KxdW0/K52cUBMsjQYMENfszT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Diz4d3x4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767627944; x=1799163944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a2Xh755bovxvDuxi7l+L79WtVNLIDy5zDE/sGra80SQ=;
  b=Diz4d3x4F7R4rd8XWWBcN/t1TAu+QbVznKhvuNNv/V3OiP9wzRZOeGvy
   dQMEyIrKWkL/DJ4jnd5TFjGsWMnsT/u+De2Em3YAg3BhCLteoBwhnbjnr
   nT8QOUKqQJ5uqpXDoVC0+OMoqmHjRY+u+cFuMqF6tgTxtLy796hngtVcU
   nx0BPeBGby8D21tV5GZNMFu/7BRB/IdMos7o0oVPkq2jPiRcTSPDWnSqm
   6aQ/FZ7MUJkC3VZcfDS5uqI3DqP8aGUmQxcK4gfRhe0p7iqhGpCkAcWXf
   X+D519uqyagNWumJTyfrb86NE1CzXkOHDdCwocIJSHK9YH2Q9cZ8hCSjF
   w==;
X-CSE-ConnectionGUID: uQyddSdoQ0urkSL4IO3+QQ==
X-CSE-MsgGUID: jY2FdT8eRzWcHBobsX8Pgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="68188065"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="68188065"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 07:45:43 -0800
X-CSE-ConnectionGUID: KfZ9YJ6OTXmlJUhcU2EPpQ==
X-CSE-MsgGUID: +CrFxdi9TCGE5cL9SEs5jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="206556668"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 07:45:41 -0800
Date: Mon, 5 Jan 2026 17:45:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hansg@kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Armin Wolf <w_armin@gmx.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
Message-ID: <aVvcobLt9YUL1jws@smile.fi.intel.com>
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
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 05, 2026 at 12:25:04PM +0100, Rafael J. Wysocki wrote:

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

binding

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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I have read it in full and found quite useful. Also it would be probably good
to have a pointer somewhere on the example how to convert the driver from ACPI
driver to a platform one. Maybe in a form of the existing commit(s), dunno...

-- 
With Best Regards,
Andy Shevchenko



