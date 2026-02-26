Return-Path: <linux-acpi+bounces-21183-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIoNMWvzn2kyfAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21183-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 08:16:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D02CF1A1B6B
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 08:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 085F9300621D
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 07:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC2738BF87;
	Thu, 26 Feb 2026 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqFnlN2m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CEA13C8E8;
	Thu, 26 Feb 2026 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772090213; cv=none; b=GSGypOBHuc1gGGbu0q7w5xSheQieDoXh2HX94ke/Vh6l0Qir+55pv2t0pXlU0SdnmKaAZCrJ1I9jxERdefnQNFo03i/dLgYooH8jBMK564D+pUXmD8SbEIhpDBZ25I3AVBlS7PG+XAE2UI1QNtfjrE7ewT+FP2ISoils2oEp8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772090213; c=relaxed/simple;
	bh=gmsF1bIHUsqzDU//QRNWaZDUempOmCQ/mx2TZ2ftI1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf+5Uc4Jegi27ZGKJXbEpinl9wekUY7C5EwxxdTs3IDaP5xR2YCgjLRKOiuQj2bBTQ6F1FmZtlBAPx4k7jSVnlGlqGf9AYogmAqjQWXUMahUmkAM3AjtSrhiFvgj0Nr8q+Is2PFL/sDkj/CWKCZYnx+hskMZSLZd43HC8Q0Tgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqFnlN2m; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772090211; x=1803626211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gmsF1bIHUsqzDU//QRNWaZDUempOmCQ/mx2TZ2ftI1Q=;
  b=iqFnlN2mQhkWpxymNedq3ykP+tV20laPVB/NKQJpBg5PSG5eWcCEHjXK
   8v/Mhp6w2eD0/yb+slVEdpoYGU9+7YUZCWv2KqqAREyZsGNZDoB86t7Xt
   UsTAiKalqTLOUiRauFnGD/jbABHJgGPlXD7KZJKcYR+DGsR2nDePYPhqw
   XwykLbwEq4DMgAWamwRBM9UWTrkK95Nw2RaJpnCJBmqbnYxr2I+Of2cuv
   V/u72zWg8hhUR2UULAQD0Gbn2XMDUgSDMW3RlM3yAjt/b0pH3uGU4Jh8S
   pM0KAFBy7uvTKRP5+xLe2X2wWTieOr22TBOk1ydliIWiKh4qF507lvlv+
   w==;
X-CSE-ConnectionGUID: aVVbt/3jQg+f9H7dMvnUaA==
X-CSE-MsgGUID: vKmkNGOFRi6TrSzgQoOeCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73325102"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73325102"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 23:16:51 -0800
X-CSE-ConnectionGUID: WFDUhlOsQ6qFA0EwJNiDkg==
X-CSE-MsgGUID: zmBKU5tGRDW+UlQFhoDYfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="213514684"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 23:16:49 -0800
Date: Thu, 26 Feb 2026 09:16:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mike Isely at pobox <isely@pobox.com>
Cc: mike.isely@cobaltdigital.com, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sofware node: Only the managing device can
 unreference managed software node
Message-ID: <aZ_zX-jQ7T8LVeSU@smile.fi.intel.com>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com>
 <20260224191922.2972974-2-mike.isely@cobaltdigital.com>
 <aZ7bX4SIoxKTPtoi@smile.fi.intel.com>
 <3951478d-43d6-1c9b-de5e-8affc5937472@isely.net>
 <aZ9VHXwReXdWZHz8@smile.fi.intel.com>
 <5c5f39f4-9797-4d84-eaf2-3fb7a830cbbf@isely.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c5f39f4-9797-4d84-eaf2-3fb7a830cbbf@isely.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cobaltdigital.com,gmail.com,linux.intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21183-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D02CF1A1B6B
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 02:16:39PM -0600, Mike Isely wrote:
> On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > On Wed, Feb 25, 2026 at 01:42:30PM -0600, Mike Isely wrote:
> > > On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > > > On Tue, Feb 24, 2026 at 01:19:22PM -0600, mike.isely@cobaltdigital.com wrote:

...

> > > > > A scenario exists where device_create_managed_software_node() is used
> > > > > to create an swnode instance that will be implicitly shared to a child
> > > > > device despite best intentions not to permit such sharing (per the
> > > > > comment in device_create_managed_software_node()).  I encountered this
> > > > > with the sfp kernel module when it was instantiated with properties
> > > > 
> > > > SFP? Or is it the name of the actual module in the kernel?
> > > 
> > > Actual kernel module name, sfp.ko, CONFIG_SFP in .config, named after 
> > > the piece of hardware it works with, an SFP cage.  This is logic which 
> > > monitors SFP cages for hotplug appearance / removal of SFP transceivers.  
> > > When a transceiver appears, the sfp kernel module will create a child 
> > > hwmon device instance to monitor various bits of metadata from the 
> > > transceiver.  When that transceiver goes away, the sfp kernel module 
> > > will tear down that child hwmon device instance.
> > > 
> > > The sfp kernel module needs resources configured to know where to 
> > > monitor; in our case that is set up dynamically by another locally 
> > > written kernel module (which iteracts with an FPGA we have where the SFP 
> > > hardware elements reside), and that kernel module will combine 
> > 
> > > devicetree information with some run-time information to generate the 
> > > properties handed off to the sfp kernel module instantiation.
> > 
> > What runtime information? Why this can't be done via DT overlay as others do?
> 
> I don't recall the specifics.  It might be calculation of a unit name.  
> The connectivity in this case is I2C so that should be a constant.  We 
> have some variants where the FPGA is PCIE-connected to the host and so 
> the memory map is a run-time calculation.  We have other drivers that 
> have to be instantiated with run-time computed properties.  So we handle 
> this as a general case.

But the configurations are semi-static, right? For the contents of FPGA we have
a specific manager that reloads the FPGA configuration.

Using swnode for dynamically calculated data seems weird. The data in swnodes
is usually static (const), I can't remember the case where we need to supply
run-time calculated values.

Since that, DT overlay approach seems fine, no?

> > > We use platform_device_register_full() to instantiate it, and that in turn 
> > > causes the swnode instance to be created.  The hwmon child instance 
> > > later created by the sfp module ends up inheriting those resources, 
> > > including the swnode instance, from the sfp parent device, and when the 
> > > hwmon instance is later torn down, we end up with the use-after-free 
> > > problem due to the swnode instance's reference count being incorrectly 
> > > decremented by that child device due to the managed flag being set.
> > > 
> > > If the term SFP is unfamiliar, an explanation can be found here:
> > > 
> > > https://en.wikipedia.org/wiki/Small_Form-factor_Pluggable
> > > 
> > > > > via a call to platform_device_register_full() - it will create hwmon
> > > > > child devices which get all property references.  Unfortunately with
> > > > > just a "managed" boolean in struct swnode handling this, then
> > > > > kobject_put() gets called for the managed aspect when the child device
> > > > > goes away instead of the parent.  This leads to premature freeing of
> > > > > the swnode structure, followed by use-after-free problems, heap
> > > > > corruption, and generally chaos / crashes / misbehavior in the kernel.
> > > > > 
> > > > > This commit changes that boolean into a pointer to the actual managing
> > > > > struct device, which is then checked against the struct device
> > > > > instance that is actually going away (via the usual call back into
> > > > > software_node_notify_remove()).  Thus the child device removal is
> > > > > ignored as it should, and we only do the kobject_put() when the actual
> > > > > managing struct device instance goes away.  We effectively carry a
> > > > > little bit more information now so that we can be sure to clean up
> > > > > only when the correct struct device instance is actually going away.
> > > > > 
> > > > > Note that while we are now keeping a pointer to a struct device here,
> > > > > this is safe to do because the pointer itself only stays in use while
> > > > > the pointed-to device remains valid.  (So no need to be concerned
> > > > > about additional reference counting.)
> > > > 
> > > > The term is called "object lifetime".
> > > 
> > > Meh

...

> Would SoB lines by *both* addresses (even though it's the same person)
> clear that hurdle?

Yes.

-- 
With Best Regards,
Andy Shevchenko



