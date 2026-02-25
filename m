Return-Path: <linux-acpi+bounces-21168-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DfgGrpYn2kragQAu9opvQ
	(envelope-from <linux-acpi+bounces-21168-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 21:16:58 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7689019D1BF
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 21:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFAD7301F9A1
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 20:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7373D2D5923;
	Wed, 25 Feb 2026 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b="BKkwLv13"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C452D249E;
	Wed, 25 Feb 2026 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.69.181.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050602; cv=none; b=DXsRyr2Lp5lAPdv7A7eSmD5SNAlLlAOwkkNd9KqtUk/mbqiD7FAIQWhFQGrvS7zfz/aNEXKs95/05ZNcABpkSW1cJReXxVwCCqLw3nINZ+8t+K/5kabQSMsrURkMhqDFvq9wkHRkeLGvUvLjh3QxYDCEmFHUEuksFAkV7puN2ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050602; c=relaxed/simple;
	bh=u0q+OhOsSgIVZQ+k+DGwVtTjaN/kYes3yTOoY9QYrD4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Mime-Version:Content-Type; b=DumodNChN18/lZYFl+4xkt3njhoH2MMrNgWnowbCD6WwQpPTs7PcsB8t1+lbJQLiVxLEBjAWGJimfizAgWAqt8uor2Dxw72z3Onv58HH43ASI/6VKNA6EX5X3J3F5f1r3vNxiLKoESIrY9kHONjiaOM9JYRaaPbL8C7AaPX62wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net; spf=pass smtp.mailfrom=isely.net; dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b=BKkwLv13; arc=none smtp.client-ip=192.69.181.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isely.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
	t=1772050599; bh=6zalYpwy1qUW0hE75t2j3/yDJ6YhhDyGYd5CNWxmKtY=;
	h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
	b=BKkwLv13VAUqTKcD4cGtysLm0bEE3c2jqGX9GwLRcgF4i2ILErs4554kpx69KWmXr
	 69M3RUp5zVLPLzByGnk/YvrHnYTTShdL+TMtfkTHL8M3M5dRwCMdmhMsEfYvR35r3R
	 GAbwnGjPp+mYp1na8vH/mp5REhZjrVbBdUH77YCLRyP4ZCYIn4+QXYFdQDFfz
Original-Reply-To: Mike Isely at pobox <isely@pobox.com>
Original-Subject: Re: [PATCH 1/1] sofware node: Only the managing device can unreference
 managed software node
Author: Mike Isely <isely@isely.net>
Original-cc: mike.isely@cobaltdigital.com,
  Daniel Scally <djrscally@gmail.com>,
  Heikki Krogerus <heikki.krogerus@linux.intel.com>,
  Sakari Ailus <sakari.ailus@linux.intel.com>,
  linux-acpi@vger.kernel.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  Mike Isely at pobox <isely@pobox.com>
Received: from ts4-dock4.isely.net (ts4-dock4.isely.net [::ffff:192.168.23.121])
  (AUTH: PLAIN isely, TLS: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by cnc.isely.net with ESMTPSA
  id 00000000000A0007.00000000699F58A7.000076FB; Wed, 25 Feb 2026 14:16:39 -0600
Date: Wed, 25 Feb 2026 14:16:39 -0600 (CST)
From: Mike Isely <isely@isely.net>
Reply-To: Mike Isely at pobox <isely@pobox.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: mike.isely@cobaltdigital.com,
  Daniel Scally <djrscally@gmail.com>,
  Heikki Krogerus <heikki.krogerus@linux.intel.com>,
  Sakari Ailus <sakari.ailus@linux.intel.com>,
  linux-acpi@vger.kernel.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  Mike Isely at pobox <isely@pobox.com>
Subject: Re: [PATCH 1/1] sofware node: Only the managing device can unreference
 managed software node
In-Reply-To: <aZ9VHXwReXdWZHz8@smile.fi.intel.com>
Message-ID: <5c5f39f4-9797-4d84-eaf2-3fb7a830cbbf@isely.net>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com> <20260224191922.2972974-2-mike.isely@cobaltdigital.com> <aZ7bX4SIoxKTPtoi@smile.fi.intel.com> <3951478d-43d6-1c9b-de5e-8affc5937472@isely.net> <aZ9VHXwReXdWZHz8@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[isely.net,none];
	R_DKIM_ALLOW(-0.20)[isely.net:s=deb];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FREEMAIL_CC(0.00)[cobaltdigital.com,gmail.com,linux.intel.com,vger.kernel.org,pobox.com];
	TAGGED_FROM(0.00)[bounces-21168-lists,linux-acpi=lfdr.de];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[cobaltdigital.com:query timed out];
	DKIM_TRACE(0.00)[isely.net:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[isely@isely.net,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	HAS_REPLYTO(0.00)[isely@pobox.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isely.net:mid,isely.net:dkim,wikipedia.org:url,cobaltdigital.com:email,pobox.com:replyto,pobox.com:email]
X-Rspamd-Queue-Id: 7689019D1BF
X-Rspamd-Action: no action

On Wed, 25 Feb 2026, Andy Shevchenko wrote:

> On Wed, Feb 25, 2026 at 01:42:30PM -0600, Mike Isely wrote:
> > On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > > On Tue, Feb 24, 2026 at 01:19:22PM -0600, mike.isely@cobaltdigital.com wrote:
> 
> ...
> 
> > > > A scenario exists where device_create_managed_software_node() is used
> > > > to create an swnode instance that will be implicitly shared to a child
> > > > device despite best intentions not to permit such sharing (per the
> > > > comment in device_create_managed_software_node()).  I encountered this
> > > > with the sfp kernel module when it was instantiated with properties
> > > 
> > > SFP? Or is it the name of the actual module in the kernel?
> > 
> > Actual kernel module name, sfp.ko, CONFIG_SFP in .config, named after 
> > the piece of hardware it works with, an SFP cage.  This is logic which 
> > monitors SFP cages for hotplug appearance / removal of SFP transceivers.  
> > When a transceiver appears, the sfp kernel module will create a child 
> > hwmon device instance to monitor various bits of metadata from the 
> > transceiver.  When that transceiver goes away, the sfp kernel module 
> > will tear down that child hwmon device instance.
> > 
> > The sfp kernel module needs resources configured to know where to 
> > monitor; in our case that is set up dynamically by another locally 
> > written kernel module (which iteracts with an FPGA we have where the SFP 
> > hardware elements reside), and that kernel module will combine 
> 
> > devicetree information with some run-time information to generate the 
> > properties handed off to the sfp kernel module instantiation.
> 
> What runtime information? Why this can't be done via DT overlay as others do?

I don't recall the specifics.  It might be calculation of a unit name.  
The connectivity in this case is I2C so that should be a constant.  We 
have some variants where the FPGA is PCIE-connected to the host and so 
the memory map is a run-time calculation.  We have other drivers that 
have to be instantiated with run-time computed properties.  So we handle 
this as a general case.


> 
> > We use platform_device_register_full() to instantiate it, and that in turn 
> > causes the swnode instance to be created.  The hwmon child instance 
> > later created by the sfp module ends up inheriting those resources, 
> > including the swnode instance, from the sfp parent device, and when the 
> > hwmon instance is later torn down, we end up with the use-after-free 
> > problem due to the swnode instance's reference count being incorrectly 
> > decremented by that child device due to the managed flag being set.
> > 
> > If the term SFP is unfamiliar, an explanation can be found here:
> > 
> > https://en.wikipedia.org/wiki/Small_Form-factor_Pluggable
> > 
> > > > via a call to platform_device_register_full() - it will create hwmon
> > > > child devices which get all property references.  Unfortunately with
> > > > just a "managed" boolean in struct swnode handling this, then
> > > > kobject_put() gets called for the managed aspect when the child device
> > > > goes away instead of the parent.  This leads to premature freeing of
> > > > the swnode structure, followed by use-after-free problems, heap
> > > > corruption, and generally chaos / crashes / misbehavior in the kernel.
> > > > 
> > > > This commit changes that boolean into a pointer to the actual managing
> > > > struct device, which is then checked against the struct device
> > > > instance that is actually going away (via the usual call back into
> > > > software_node_notify_remove()).  Thus the child device removal is
> > > > ignored as it should, and we only do the kobject_put() when the actual
> > > > managing struct device instance goes away.  We effectively carry a
> > > > little bit more information now so that we can be sure to clean up
> > > > only when the correct struct device instance is actually going away.
> > > > 
> > > > Note that while we are now keeping a pointer to a struct device here,
> > > > this is safe to do because the pointer itself only stays in use while
> > > > the pointed-to device remains valid.  (So no need to be concerned
> > > > about additional reference counting.)
> > > 
> > > The term is called "object lifetime".
> > 
> > Meh
> > 
> > > > Signed-off-by: Mike Isely <isely@pobox.com>
> > > 
> > > ...submitter's addresses are different. Either it should be send from the
> > > mentioned address, or you should have
> > > 
> > >   From: Author <...>
> > >   ...
> > > 
> > >   SoB: Author <...>
> > >   SoB: Submitter <...>
> > > 
> > > ...
> > 
> > This isn't the first time I've submitted patches.
> > 
> > The reason for SoB being isely@pobox.com is because that is my primary 
> > email address for which I've been known by in the kernel community.  
> > It's an address that is stable and has been associated with me since 
> > 1996.  This address has a history and is associated with patches in the 
> > past going back a long ways.
> > 
> > The from-address of mike.isely@cobaltdigital.com is my current work 
> > email, which is associated with the reason for the patch.  My employment 
> > with Cobalt Digital goes back just a few years but my history with the 
> > Linux kernel goes back significantly further.
> > 
> > It's actually been a while since I sent in a patch.  Last time I did, 
> > this is how I did it and it wasn't a problem then.
> 
> This is standard check in Linux Next, missed SoB by submitter (same
> exists with committer). It's all documented and I'm surprised nobody
> told you that before.
> 
> > I don't recall 
> > seeing anything that required the from-address to equate to the SoB.  
> 
> From goes to Author field into Git, Author must provide a DCO. This all
> is being required from day 1.
> 
> > Seems like a SoB associated with a long-term known stable email is 
> > better than something more ephemeral.  If a requirement of equating the 
> > two is the case now, then I apologize.
> 
> Documentation/process/submitting-patches.rst:
> 
> "Note, the From: tag is optional when the From: author is also the person (and
> email) listed in the From: line of the email header."
> 
> There are also examples
> 
> """
>         From: From Author <from@author.example.org>
> 
>         <changelog>
> 
>         Co-developed-by: Random Co-Author <random@coauthor.example.org>
>         Signed-off-by: Random Co-Author <random@coauthor.example.org>
>         Signed-off-by: From Author <from@author.example.org>
>         Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
>         Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
> """
> 
> Does it help?

Would SoB lines by *both* addresses (even though it's the same person) 
clear that hurdle?

So noted.


> 
> > > What about the use case (don't know if it's pure theoretical or practical)
> > > when there is a parent and a few children and the managed swnode appears
> > > in one of the children? With some other dependencies between children
> > > it might affect how swnode is get cleaned up. Simple and regular approach
> > > is to cleanup children in the reversed order, but I can't say that it's
> > > always the case. Some children in some corner cases might have their own
> > > dependencies (I saw some strange devices or device drivers where the HW
> > > is a bit complicated and driver is written without much care).
> > 
> > Though I don't think that's practical, it should not be an issue either.  
> > Bottom line, swnode instances are reference-counted by virtue of 
> > containing a kobject instance within.  So even if a managing child goes 
> > away first, the reference count is still non-zero due to the reference 
> > from the parent.  So no risk of dangling pointers / use-after-free.  
> > Note also that management of object lifetime via reference counting here 
> > provides a fair amount of resilience against potential cleanup ordering 
> > issues.
> > 
> > An earlier attempt at a solution I had tried was to simply dispense with 
> > the notion of "managed" here since the reference counting is already 
> > going to ensure cleanup when the device goes away.  "Managed" in the 
> > context of struct device are for resources that need automatic cleanup 
> > which otherwise wouldn't already happen.  So it shouldn't be strictly 
> > even needed here.  However that didn't work due to a practical 
> > constraint: The swnode instance is created before the "managing" device 
> > instance is ready to establish a reference to the swnode instance.  
> > Turns out that the solution I ultimately hit upon is trivial.
> > 
> > From a standpoint of design hygiene, it makes logical sense that the 
> > entity which asserts "management" over something should be the same 
> > entity that deasserts it.  That's really all that this patch does.
> 
> OK. Thanks for elaboration.
> 
> 

