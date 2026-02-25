Return-Path: <linux-acpi+bounces-21166-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L4TLi1Vn2nXaAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21166-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 21:01:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D219D025
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 21:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E8053012236
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 20:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E12D780C;
	Wed, 25 Feb 2026 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYSiVj+0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7592C15B8;
	Wed, 25 Feb 2026 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049701; cv=none; b=K2R4g4ulwmtfLXud+uMXb2D4PDkWuow8iOYZ9baUcQuUvHgot4PQfUa+y3eHj1K5BFwCxxu+Rb3QR17zvLDThq4xyxvBkS/0GGuFRgXIDU75A89czBr9Cyac/CULDVTxzpaRw/l1kRazH8s532dsV9LqlqhWkBIJoOefBMKxQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049701; c=relaxed/simple;
	bh=nACnF10gwy+ypOYwAOLjnKCm3JxiMKjIfXXn8Q0DU1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLqbHbWNabfdHUdDsKIOW+vH5Yimdx9P01HhA2GHzWT6C6zImHRTM6GnKMgEkfFhik7uxH46cQOGeSMR/XTf+S3MxnhukESz6xLbunisZ79fT8Emcd3musjpY3nTfKmyMoyk/lFnxQKok7EvV9AMjBykDVRaeTRlsWFQvnlm4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYSiVj+0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772049699; x=1803585699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nACnF10gwy+ypOYwAOLjnKCm3JxiMKjIfXXn8Q0DU1Q=;
  b=XYSiVj+0klnnorWDiHvn3QBZxo1gqaG5UmJab1zflld4eWGfTXf5ScVz
   PRa4Pz+0DU/h6EMdT+HcexIhRHxkbLrXzJFVkktcAqKiegtgJmL1EjQDA
   vELETKoSs/0QKJmYuZRBh/7gbTPhlLg8R8l4+8Q3+9/kqgjZE1n72tFHX
   +ekX1TmklJjInpWvY+UIkmRjQ3dSmFAZV5j6tQFPgSTP7lFHvJOPy9qLY
   cuDjIRff53VqYtCUPIgUbjzmJXW97KVDlQfE2MCKtI+yMKtaINnj+pqhF
   cl63A4xd+02hSlMdS/gRA7Y2V8XThp2ntNNJUbBjBlAM8jcgM2/ETI3x1
   g==;
X-CSE-ConnectionGUID: sJRnTey3QryFtgQqLaJnvA==
X-CSE-MsgGUID: vDtSXn54R0OQbeQ0RneRDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="83728029"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="83728029"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 12:01:38 -0800
X-CSE-ConnectionGUID: pxo7qlKXRK6/HIL4AhllmA==
X-CSE-MsgGUID: S3Rb1r2nTSykdkj58OTB9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="216228517"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 12:01:36 -0800
Date: Wed, 25 Feb 2026 22:01:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mike Isely at pobox <isely@pobox.com>
Cc: mike.isely@cobaltdigital.com, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sofware node: Only the managing device can
 unreference managed software node
Message-ID: <aZ9VHXwReXdWZHz8@smile.fi.intel.com>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com>
 <20260224191922.2972974-2-mike.isely@cobaltdigital.com>
 <aZ7bX4SIoxKTPtoi@smile.fi.intel.com>
 <3951478d-43d6-1c9b-de5e-8affc5937472@isely.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3951478d-43d6-1c9b-de5e-8affc5937472@isely.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cobaltdigital.com,gmail.com,linux.intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21166-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,pobox.com:email,wikipedia.org:url,cobaltdigital.com:email,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: C23D219D025
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 01:42:30PM -0600, Mike Isely wrote:
> On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > On Tue, Feb 24, 2026 at 01:19:22PM -0600, mike.isely@cobaltdigital.com wrote:

...

> > > A scenario exists where device_create_managed_software_node() is used
> > > to create an swnode instance that will be implicitly shared to a child
> > > device despite best intentions not to permit such sharing (per the
> > > comment in device_create_managed_software_node()).  I encountered this
> > > with the sfp kernel module when it was instantiated with properties
> > 
> > SFP? Or is it the name of the actual module in the kernel?
> 
> Actual kernel module name, sfp.ko, CONFIG_SFP in .config, named after 
> the piece of hardware it works with, an SFP cage.  This is logic which 
> monitors SFP cages for hotplug appearance / removal of SFP transceivers.  
> When a transceiver appears, the sfp kernel module will create a child 
> hwmon device instance to monitor various bits of metadata from the 
> transceiver.  When that transceiver goes away, the sfp kernel module 
> will tear down that child hwmon device instance.
> 
> The sfp kernel module needs resources configured to know where to 
> monitor; in our case that is set up dynamically by another locally 
> written kernel module (which iteracts with an FPGA we have where the SFP 
> hardware elements reside), and that kernel module will combine 

> devicetree information with some run-time information to generate the 
> properties handed off to the sfp kernel module instantiation.

What runtime information? Why this can't be done via DT overlay as others do?

> We use platform_device_register_full() to instantiate it, and that in turn 
> causes the swnode instance to be created.  The hwmon child instance 
> later created by the sfp module ends up inheriting those resources, 
> including the swnode instance, from the sfp parent device, and when the 
> hwmon instance is later torn down, we end up with the use-after-free 
> problem due to the swnode instance's reference count being incorrectly 
> decremented by that child device due to the managed flag being set.
> 
> If the term SFP is unfamiliar, an explanation can be found here:
> 
> https://en.wikipedia.org/wiki/Small_Form-factor_Pluggable
> 
> > > via a call to platform_device_register_full() - it will create hwmon
> > > child devices which get all property references.  Unfortunately with
> > > just a "managed" boolean in struct swnode handling this, then
> > > kobject_put() gets called for the managed aspect when the child device
> > > goes away instead of the parent.  This leads to premature freeing of
> > > the swnode structure, followed by use-after-free problems, heap
> > > corruption, and generally chaos / crashes / misbehavior in the kernel.
> > > 
> > > This commit changes that boolean into a pointer to the actual managing
> > > struct device, which is then checked against the struct device
> > > instance that is actually going away (via the usual call back into
> > > software_node_notify_remove()).  Thus the child device removal is
> > > ignored as it should, and we only do the kobject_put() when the actual
> > > managing struct device instance goes away.  We effectively carry a
> > > little bit more information now so that we can be sure to clean up
> > > only when the correct struct device instance is actually going away.
> > > 
> > > Note that while we are now keeping a pointer to a struct device here,
> > > this is safe to do because the pointer itself only stays in use while
> > > the pointed-to device remains valid.  (So no need to be concerned
> > > about additional reference counting.)
> > 
> > The term is called "object lifetime".
> 
> Meh
> 
> > > Signed-off-by: Mike Isely <isely@pobox.com>
> > 
> > ...submitter's addresses are different. Either it should be send from the
> > mentioned address, or you should have
> > 
> >   From: Author <...>
> >   ...
> > 
> >   SoB: Author <...>
> >   SoB: Submitter <...>
> > 
> > ...
> 
> This isn't the first time I've submitted patches.
> 
> The reason for SoB being isely@pobox.com is because that is my primary 
> email address for which I've been known by in the kernel community.  
> It's an address that is stable and has been associated with me since 
> 1996.  This address has a history and is associated with patches in the 
> past going back a long ways.
> 
> The from-address of mike.isely@cobaltdigital.com is my current work 
> email, which is associated with the reason for the patch.  My employment 
> with Cobalt Digital goes back just a few years but my history with the 
> Linux kernel goes back significantly further.
> 
> It's actually been a while since I sent in a patch.  Last time I did, 
> this is how I did it and it wasn't a problem then.

This is standard check in Linux Next, missed SoB by submitter (same
exists with committer). It's all documented and I'm surprised nobody
told you that before.

> I don't recall 
> seeing anything that required the from-address to equate to the SoB.  

From goes to Author field into Git, Author must provide a DCO. This all
is being required from day 1.

> Seems like a SoB associated with a long-term known stable email is 
> better than something more ephemeral.  If a requirement of equating the 
> two is the case now, then I apologize.

Documentation/process/submitting-patches.rst:

"Note, the From: tag is optional when the From: author is also the person (and
email) listed in the From: line of the email header."

There are also examples

"""
        From: From Author <from@author.example.org>

        <changelog>

        Co-developed-by: Random Co-Author <random@coauthor.example.org>
        Signed-off-by: Random Co-Author <random@coauthor.example.org>
        Signed-off-by: From Author <from@author.example.org>
        Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
        Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
"""

Does it help?

> > What about the use case (don't know if it's pure theoretical or practical)
> > when there is a parent and a few children and the managed swnode appears
> > in one of the children? With some other dependencies between children
> > it might affect how swnode is get cleaned up. Simple and regular approach
> > is to cleanup children in the reversed order, but I can't say that it's
> > always the case. Some children in some corner cases might have their own
> > dependencies (I saw some strange devices or device drivers where the HW
> > is a bit complicated and driver is written without much care).
> 
> Though I don't think that's practical, it should not be an issue either.  
> Bottom line, swnode instances are reference-counted by virtue of 
> containing a kobject instance within.  So even if a managing child goes 
> away first, the reference count is still non-zero due to the reference 
> from the parent.  So no risk of dangling pointers / use-after-free.  
> Note also that management of object lifetime via reference counting here 
> provides a fair amount of resilience against potential cleanup ordering 
> issues.
> 
> An earlier attempt at a solution I had tried was to simply dispense with 
> the notion of "managed" here since the reference counting is already 
> going to ensure cleanup when the device goes away.  "Managed" in the 
> context of struct device are for resources that need automatic cleanup 
> which otherwise wouldn't already happen.  So it shouldn't be strictly 
> even needed here.  However that didn't work due to a practical 
> constraint: The swnode instance is created before the "managing" device 
> instance is ready to establish a reference to the swnode instance.  
> Turns out that the solution I ultimately hit upon is trivial.
> 
> From a standpoint of design hygiene, it makes logical sense that the 
> entity which asserts "management" over something should be the same 
> entity that deasserts it.  That's really all that this patch does.

OK. Thanks for elaboration.

-- 
With Best Regards,
Andy Shevchenko



