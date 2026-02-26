Return-Path: <linux-acpi+bounces-21194-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJZ5DCawoGnUlgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21194-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 21:42:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B16541AF3A7
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 21:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06D8B3008D51
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 20:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B97466B47;
	Thu, 26 Feb 2026 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gu42HW0m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565DF3290BD;
	Thu, 26 Feb 2026 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138529; cv=none; b=iNnhOetRis3Y/7kH3Geiz9Bh4IgYk/C5u7ZBW9UEUnVxYhIn3BdbPLXk5xa9A6i0m/8aPu5jQ07j40+ICBz6xDkgg47gmluYmcsPIJGyJTO3VUMKbLupkzKx3nYV3up5GYwYOqB0hvrdzAk5TK/K0KsbbrQBSTWwKYUo2O7VR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138529; c=relaxed/simple;
	bh=NO6Ob2zpd7YGokR5iJAChHNFetdbeNd4WgTd2I4zTBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MngKUiZppDqSfsS3/NCsI9HX1v1TA/O07nSKvRHP0fUQ6hTXcRtTo1Ghap7n1Qx95tbwVFWZwDkSCdF6j/+m71Fb5hRFF2imCeiIzLNbcm8hvrGGCz2cHcM4BrYJiUfJRGMNMFE3jFjdMrciBn6XmBDo4O2Sp3rSKnd6tIZwXEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gu42HW0m; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772138528; x=1803674528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NO6Ob2zpd7YGokR5iJAChHNFetdbeNd4WgTd2I4zTBU=;
  b=Gu42HW0mjd7NLaUmytEAa7oSkHhZN5+p3WHkE7TBDc89LZxq1eRatKvD
   eSSr990MMGOrf1ufDrWp8JDogceothqiurc+62amAzhDSRrhABD8N2zjW
   EyJjqhfhBgXomzkqhlvuF/qm0SbfBNaow7hF7ilmdnPIJckJqe7QM32mx
   gXSlEYQ42+xp2nmtSSyQkCUIBsd5r2SI/VKtTn5qhX7IdQDHLeV9p+m9C
   XgY1lYNngXRAXGPi4vhLEmWEsifR+DY1NloZFCIaou4M7LTkQadnRn6CN
   TOfJxIajeXfwuRk/STYudqC9x1dxGBcGHhJD3xGZiqv+Drzbh0P2tdsQA
   A==;
X-CSE-ConnectionGUID: daejUElgSHCCEl6xr9gnGA==
X-CSE-MsgGUID: 9C8c2kB1QceqmNqPsQPbIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="72246732"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="72246732"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 12:42:07 -0800
X-CSE-ConnectionGUID: vSiVx1dVQOqhziPzOuf6nA==
X-CSE-MsgGUID: jVmLzne9R6mmKTUu4aQIsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="247202708"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 12:42:05 -0800
Date: Thu, 26 Feb 2026 22:42:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mike Isely at pobox <isely@pobox.com>
Cc: mike.isely@cobaltdigital.com, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sofware node: Only the managing device can
 unreference managed software node
Message-ID: <aaCwG-llsnmQYgd0@smile.fi.intel.com>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com>
 <20260224191922.2972974-2-mike.isely@cobaltdigital.com>
 <aZ7bX4SIoxKTPtoi@smile.fi.intel.com>
 <3951478d-43d6-1c9b-de5e-8affc5937472@isely.net>
 <aZ9VHXwReXdWZHz8@smile.fi.intel.com>
 <5c5f39f4-9797-4d84-eaf2-3fb7a830cbbf@isely.net>
 <aZ_zX-jQ7T8LVeSU@smile.fi.intel.com>
 <3d7a7e25-b78c-6c60-a485-92cced6075d1@isely.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d7a7e25-b78c-6c60-a485-92cced6075d1@isely.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cobaltdigital.com,gmail.com,linux.intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21194-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: B16541AF3A7
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 01:06:42PM -0600, Mike Isely wrote:
> On Thu, 26 Feb 2026, Andy Shevchenko wrote:
> > On Wed, Feb 25, 2026 at 02:16:39PM -0600, Mike Isely wrote:
> > > On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > > > On Wed, Feb 25, 2026 at 01:42:30PM -0600, Mike Isely wrote:
> > > > > On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > > > > > On Tue, Feb 24, 2026 at 01:19:22PM -0600, mike.isely@cobaltdigital.com wrote:

...

> > > > > > > A scenario exists where device_create_managed_software_node() is used
> > > > > > > to create an swnode instance that will be implicitly shared to a child
> > > > > > > device despite best intentions not to permit such sharing (per the
> > > > > > > comment in device_create_managed_software_node()).  I encountered this
> > > > > > > with the sfp kernel module when it was instantiated with properties
> > > > > > 
> > > > > > SFP? Or is it the name of the actual module in the kernel?
> > > > > 
> > > > > Actual kernel module name, sfp.ko, CONFIG_SFP in .config, named after 
> > > > > the piece of hardware it works with, an SFP cage.  This is logic which 
> > > > > monitors SFP cages for hotplug appearance / removal of SFP transceivers.  
> > > > > When a transceiver appears, the sfp kernel module will create a child 
> > > > > hwmon device instance to monitor various bits of metadata from the 
> > > > > transceiver.  When that transceiver goes away, the sfp kernel module 
> > > > > will tear down that child hwmon device instance.
> > > > > 
> > > > > The sfp kernel module needs resources configured to know where to 
> > > > > monitor; in our case that is set up dynamically by another locally 
> > > > > written kernel module (which iteracts with an FPGA we have where the SFP 
> > > > > hardware elements reside), and that kernel module will combine 
> > > > 
> > > > > devicetree information with some run-time information to generate the 
> > > > > properties handed off to the sfp kernel module instantiation.
> > > > 
> > > > What runtime information? Why this can't be done via DT overlay as others do?
> > > 
> > > I don't recall the specifics.  It might be calculation of a unit name.  
> > > The connectivity in this case is I2C so that should be a constant.  We 
> > > have some variants where the FPGA is PCIE-connected to the host and so 
> > > the memory map is a run-time calculation.  We have other drivers that 
> > > have to be instantiated with run-time computed properties.  So we handle 
> > > this as a general case.
> > 
> > But the configurations are semi-static, right? For the contents of FPGA we have
> > a specific manager that reloads the FPGA configuration.
> > 
> > Using swnode for dynamically calculated data seems weird. The data in swnodes
> > is usually static (const), I can't remember the case where we need to supply
> > run-time calculated values.
> 
> Semi-static means partially dynamic...
> 
> We use the kernel FPGA manager in one platform (zynqmp) and a userspace 
> loader program in another (PCIE connected to bcm2711 soc).  However it 
> is not reasonable to reload on-the-fly as that would disrupt every piece 
> of logic (kernel modules and userspace code) currently pointing inside 
> its memory space.  It would require tearing down the application space 
> and unloading every kernel module using the FPGA space (some of which is 
> ours and others which are stock kernel code).  Might as well reboot - so 
> we load once at boot time.  If the image needs to be swapped out (and 
> there are defined cases for this), a symbolic link is updated to point 
> to the new bitfile and the processor is rebooted.

To me the (full) reversing of the kernel state seems the correct approach.
The modules not really needs to be unloaded. The driver should be unbound
from the device.

> But this is getting off-topic.

Not really, it gets more understanding on why this way was chosen and not
another.

> We actually don't directly invoke the use of swnode.  It's being done 
> indirectly inside of platform_device_register_full(), when its 
> pdevinfo->properties argument is non-null, which is a normal thing that 
> happens in many other invocations of that function.  See 
> drivers/base/platform.c at the call to 
> device_create_managed_software_node().

I'm aware of this. I reviewed a lot of swnode code.

So, the properties supplied are not const, that's what you are trying to say?
And this I believe a problem. I don't remember if we have such a case in kernel
(when we use dynamic properties with platform_device_register_full().

> I had no idea of even the existence of swnode until I started tracking down
> the kernel misbehavior.

> Whether statically provided or calculated, this code path is happening.  
> Our case may be dynamic, but certainly any other managed swnode usage 
> which involves child devices is going to be a reference-counting problem 
> before this patch.

I have a hardware that uses drivers/mfd/intel_quark_i2c_gpio.c. Do you think
I can reproduce the issue with it?

The hierarchy is that

PCI device (associated ACPI node)
  I2C host controller (associated node in ACPI and managed swnode from the driver)
    I2C-client (it has it's own ACPI node)
  GPIO controller (associated node in ACPI and managed swnode from the driver)
    GPIO controller port (child swnode from the driver)
      ...users of GPIO pins of the given port...


-- 
With Best Regards,
Andy Shevchenko



