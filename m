Return-Path: <linux-acpi+bounces-21245-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJsjOo7Lomnz5QQAu9opvQ
	(envelope-from <linux-acpi+bounces-21245-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 12:03:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BFE1C26DD
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 12:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E41F3006B36
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 11:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A7421EE9;
	Sat, 28 Feb 2026 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcJQeyk7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2BE258EDA;
	Sat, 28 Feb 2026 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276557; cv=none; b=qQMwDhSYbyWOPqbS/BdcG87EDvYZBQ2V0Nc5m/IhE3b69eWwA2BxN/L4L5T4Ct45w2rkIcXdmPRkjhZwYXh0g+o7xluMk5fTRSSJNM+6M7QxmXPAVSqf0RXIfNFVAZCGLlWROtcB94ANB6iCLJS6f8uw2w28iEzm2NqEHVINmyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276557; c=relaxed/simple;
	bh=EeF25UiMhxyAwsA4IruwG7FT0XIe2iULHN2GxbbIehE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOJZyX0F77CQffKzU7vop6UW7dwIRLkzeFN4gXSEa+OXFzb4WMzhOEqKKBUN4ryjDqt5+r2ziFZIwNBzxRT4xrL9HikSVz0CQyiVYK2p9uC26h7D0hm2b9vEhPNl2Vthg54BjWhTTMPyaEp3TFf/f80OvsTJSdKSxSGRyXy65Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcJQeyk7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772276557; x=1803812557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EeF25UiMhxyAwsA4IruwG7FT0XIe2iULHN2GxbbIehE=;
  b=gcJQeyk7Vf0K6CuELS7g0m9VxDsc+bCHZc1HMotylBoxaJsP0WGQorh3
   2o0dDChzhVY7Ogq0E1nkEEJ2NhyvNiWk96TQXgG4xbtKJJgDkwN+v5AVk
   Se53nrRYb5w++aIacircE1veQXLzyv/V0JB09SzqDWLa1B5hqBpd5EKSz
   nNWQ5vr5doOCtQmfYoP3Mg6djXaCtJKnJ8pqvv3shnmYVj1LLgZd9WMdM
   Qr357W/yiTYloQ1VRwK5L9d0PtRCt5iWRZBfapUhnls4RtAWx2K2L19Fy
   CELhEnSir9+5MoH1pL58iDio2nHaYY23dWaiy0vzsSUT9vE8CZo8qdLhx
   Q==;
X-CSE-ConnectionGUID: C4vrmd3iRbqW9BSV41SjRQ==
X-CSE-MsgGUID: Y5T6eWMnS4O1EKIPit3biQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="84817897"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="84817897"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 03:02:36 -0800
X-CSE-ConnectionGUID: UVx9IANnQV2LP/NF7CkMww==
X-CSE-MsgGUID: 8sRkgceiRMuXBFAbLmq8vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="214919317"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.224])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 03:02:33 -0800
Date: Sat, 28 Feb 2026 13:02:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mike Isely at pobox <isely@pobox.com>
Cc: mike.isely@cobaltdigital.com, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sofware node: Only the managing device can
 unreference managed software node
Message-ID: <aaLLRyeK7GwR978-@ashevche-desk.local>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com>
 <20260224191922.2972974-2-mike.isely@cobaltdigital.com>
 <aZ7bX4SIoxKTPtoi@smile.fi.intel.com>
 <3951478d-43d6-1c9b-de5e-8affc5937472@isely.net>
 <aZ9VHXwReXdWZHz8@smile.fi.intel.com>
 <5c5f39f4-9797-4d84-eaf2-3fb7a830cbbf@isely.net>
 <aZ_zX-jQ7T8LVeSU@smile.fi.intel.com>
 <3d7a7e25-b78c-6c60-a485-92cced6075d1@isely.net>
 <aaCwG-llsnmQYgd0@smile.fi.intel.com>
 <64161dbd-975f-a12d-8e9c-ba2e791e48c2@isely.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64161dbd-975f-a12d-8e9c-ba2e791e48c2@isely.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cobaltdigital.com,gmail.com,linux.intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21245-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ashevche-desk.local:mid,cobaltdigital.com:email]
X-Rspamd-Queue-Id: 00BFE1C26DD
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 11:55:51AM -0600, Mike Isely wrote:
> On Thu, 26 Feb 2026, Andy Shevchenko wrote:
> > On Thu, Feb 26, 2026 at 01:06:42PM -0600, Mike Isely wrote:
> > > On Thu, 26 Feb 2026, Andy Shevchenko wrote:
> > > > On Wed, Feb 25, 2026 at 02:16:39PM -0600, Mike Isely wrote:
> > > > > On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > > > > > On Wed, Feb 25, 2026 at 01:42:30PM -0600, Mike Isely wrote:
> > > > > > > On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > > > > > > > On Tue, Feb 24, 2026 at 01:19:22PM -0600, mike.isely@cobaltdigital.com wrote:

...

> > > > > > > > > A scenario exists where device_create_managed_software_node() is used
> > > > > > > > > to create an swnode instance that will be implicitly shared to a child
> > > > > > > > > device despite best intentions not to permit such sharing (per the
> > > > > > > > > comment in device_create_managed_software_node()).  I encountered this
> > > > > > > > > with the sfp kernel module when it was instantiated with properties
> > > > > > > > 
> > > > > > > > SFP? Or is it the name of the actual module in the kernel?
> > > > > > > 
> > > > > > > Actual kernel module name, sfp.ko, CONFIG_SFP in .config, named after 
> > > > > > > the piece of hardware it works with, an SFP cage.  This is logic which 
> > > > > > > monitors SFP cages for hotplug appearance / removal of SFP transceivers.  
> > > > > > > When a transceiver appears, the sfp kernel module will create a child 
> > > > > > > hwmon device instance to monitor various bits of metadata from the 
> > > > > > > transceiver.  When that transceiver goes away, the sfp kernel module 
> > > > > > > will tear down that child hwmon device instance.
> > > > > > > 
> > > > > > > The sfp kernel module needs resources configured to know where to 
> > > > > > > monitor; in our case that is set up dynamically by another locally 
> > > > > > > written kernel module (which iteracts with an FPGA we have where the SFP 
> > > > > > > hardware elements reside), and that kernel module will combine 
> > > > > > 
> > > > > > > devicetree information with some run-time information to generate the 
> > > > > > > properties handed off to the sfp kernel module instantiation.
> > > > > > 
> > > > > > What runtime information? Why this can't be done via DT overlay as others do?
> > > > > 
> > > > > I don't recall the specifics.  It might be calculation of a unit name.  
> > > > > The connectivity in this case is I2C so that should be a constant.  We 
> > > > > have some variants where the FPGA is PCIE-connected to the host and so 
> > > > > the memory map is a run-time calculation.  We have other drivers that 
> > > > > have to be instantiated with run-time computed properties.  So we handle 
> > > > > this as a general case.
> > > > 
> > > > But the configurations are semi-static, right? For the contents of FPGA we have
> > > > a specific manager that reloads the FPGA configuration.
> > > > 
> > > > Using swnode for dynamically calculated data seems weird. The data in swnodes
> > > > is usually static (const), I can't remember the case where we need to supply
> > > > run-time calculated values.
> > > 
> > > Semi-static means partially dynamic...
> > > 
> > > We use the kernel FPGA manager in one platform (zynqmp) and a userspace 
> > > loader program in another (PCIE connected to bcm2711 soc).  However it 
> > > is not reasonable to reload on-the-fly as that would disrupt every piece 
> > > of logic (kernel modules and userspace code) currently pointing inside 
> > > its memory space.  It would require tearing down the application space 
> > > and unloading every kernel module using the FPGA space (some of which is 
> > > ours and others which are stock kernel code).  Might as well reboot - so 
> > > we load once at boot time.  If the image needs to be swapped out (and 
> > > there are defined cases for this), a symbolic link is updated to point 
> > > to the new bitfile and the processor is rebooted.
> > 
> > To me the (full) reversing of the kernel state seems the correct approach.
> > The modules not really needs to be unloaded. The driver should be unbound
> > from the device.
> > 
> > > But this is getting off-topic.
> > 
> > Not really, it gets more understanding on why this way was chosen and not
> > another.
> 
> I think there's a miscommunication here.  The nature / mechanism by how 
> / when we load the FPGA has exactly nothing to do with this problem.  
> The issue has to do with sfp kernel module behavior when SFP 
> transceivers are hotplugged, which is completely unrelated to FPGA 
> loading.  The problem would be the same no matter how we manage the 
> FPGA.
> 
> > > We actually don't directly invoke the use of swnode.  It's being done 
> > > indirectly inside of platform_device_register_full(), when its 
> > > pdevinfo->properties argument is non-null, which is a normal thing that 
> > > happens in many other invocations of that function.  See 
> > > drivers/base/platform.c at the call to 
> > > device_create_managed_software_node().
> > 
> > I'm aware of this. I reviewed a lot of swnode code.
> > 
> > So, the properties supplied are not const, that's what you are trying to say?
> > And this I believe a problem. I don't remember if we have such a case in kernel
> > (when we use dynamic properties with platform_device_register_full().
> 
> In our case it's not const, but I think you're getting hung up on that.  
> The const-ness of the data is not germane to the problem.
> 
> It isn't that the data is dynamic, it's that swnode is being used at all 
> in a scenario where a parent device is managing it and there are child 
> devices that come & go over time (due in our case to SFP transceiver 
> hotplug).  That scenario happens if platform_device_register_full() is 
> called, with the pdevinfo->properties argument set, to create a device 
> that itself may later generate child devices that come and go over time.  
> The platform_device_register_full() implementation notices that it's 
> getting a properties structure via its pdevinfo argument, triggering a 
> usage of device_create_managed_software_node().  It doesn't matter if 
> the incoming properties to platform_device_register_full() are static or 
> not; the behavior will be the same.
> 
> We are using platform_device_register_full() to instantiate the sfp 
> kernel module.  A grep through the kernel sources shows many other cases 
> of this sort of pattern (call to platform_device_register_full() with 
> pdevinfo->properties set), so unless every single one of those cases 
> happens to not create / remove child devices, this problem is not 
> specific to our usage of the sfp kernel module.  And there's certainly 
> no rule written anywhere that though shalt not use 
> platform_device_register_full() in cases where child devices may be 
> created / removed...
> 
> > > I had no idea of even the existence of swnode until I started tracking down
> > > the kernel misbehavior.
> > 
> > > Whether statically provided or calculated, this code path is happening.  
> > > Our case may be dynamic, but certainly any other managed swnode usage 
> > > which involves child devices is going to be a reference-counting problem 
> > > before this patch.
> > 
> > I have a hardware that uses drivers/mfd/intel_quark_i2c_gpio.c. Do you think
> > I can reproduce the issue with it?
> > 
> > The hierarchy is that
> > 
> > PCI device (associated ACPI node)
> >   I2C host controller (associated node in ACPI and managed swnode from the driver)
> >     I2C-client (it has it's own ACPI node)
> >   GPIO controller (associated node in ACPI and managed swnode from the driver)
> >     GPIO controller port (child swnode from the driver)
> >       ...users of GPIO pins of the given port...
> 
> I am unfamiliar with that driver or its surroundings, so I don't know if 
> it is a viable means to reproduce the problem.  I can spend time 
> analyzing that code further if you wish.  However it might be more 
> productive to try to succinctly, generically, spell out the steps that 
> lead to trouble:
> 
> 1. Somebody creates a struct device instance.
> 
> 2. Somebody calls device_create_managed_software_node() associating it 
> with that struct device instance.  This causes two kobject references to 
> be counted against the swnode instance (one for the struct device and 
> one because the managed flag was set).  refcount=2
> 
> 3. Some time later, a child struct device is created and the properties 
> of the parent are shared with the child.  This causes another kobject 
> reference to be counted against the swnode instance.  refcount=3
> 
> 4. Some time later, that child struct device instance goes away (perhaps 
> due to a hotplug removal).  During the tear-down, 
> software_node_notify_remove() notices that the managed field of the 
> swnode instance is set, so TWO kobject references are removed instead of 
> the single reference created by the previous step.  refcount=1
> 
> 5. Repeat step 3.  refcount=2
> 
> 6. Repeat step 4.  refcount=0
> 
> 7. Now the kobject reference count inside the swnode instance has 
> dropped to zero and so the swnode instance is released.  Notice that the 
> parent device is still holding a physical reference, now pointing into 
> freed memory.  Chaos likely follows.  If lucky, a NULL pointer kernel 
> oops is the result.
> 
> I confirmed this exact sequence of behavior in the context of the sfp 
> kernel module with appropriate printk debug trace added.  While that's 
> going to be hard for you to reproduce without sfp hardware, anything 
> else which performs those steps should produce similar results.
> 
> The patch fixes this by causing step 4 to only do the second reference 
> decrement if the device being torn down is the same one that established 
> the managing relationship in the first place.  Then everything stays 
> balanced.
> 
> Notice that this has nothing to do with whether or not the properties 
> are const, nor does it have anything to do with FPGA management.  I 
> apologize if I caused confusion leading to that.

No problem, now with this very deep and comprehensive analysis everything
is clear. Thanks for providing this all information!

> It's purely the
> combination of a managed swnode instance used for a device that will 
> create / remove child devices over time (due perhaps to hotplug 
> activity).

> And because platform_device_register_full() will implicitly employ a 
> managed swnode instance any time it is passed properties in its pdevinfo 
> argument, then by implication anyone calling 
> platform_device_register_full() in that manner - which happens in 
> multiple other places in the kernel - is at risk for the same issue.

Yeah, I will think about this more, but if somebody beats me up to it
and confirms that this is the best what we can do, I will have no
objections. I dunno, let's say in a couple of weeks?

-- 
With Best Regards,
Andy Shevchenko



