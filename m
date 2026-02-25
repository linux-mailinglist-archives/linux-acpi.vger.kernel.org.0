Return-Path: <linux-acpi+bounces-21164-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHMwNuRQn2k7aAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21164-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 20:43:32 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1A019CDD2
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 20:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C4C3301076A
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 19:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40E23EF0A2;
	Wed, 25 Feb 2026 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b="BsWu0K7D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B831282C;
	Wed, 25 Feb 2026 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.69.181.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048559; cv=none; b=qqEYHI3/2D+vDUZjIYdrrER+IXqGqTiTMxcrjU4S32lSsqBt7Twg+I/6l4T9/uOfEZrOfsVPj+/RWwUFxdDPGaPFO5fbWbNsIxw7xC0AnGXAm5+p1qBzzad5AUfySfTI5FDPQ+irjPZ1x1AE8t2dGVQHKhuznGu91aAMEdZnQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048559; c=relaxed/simple;
	bh=U0EyeW5prSFBDEIKK9EvAcv0letEC0AySmujSU/mcFo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Mime-Version:Content-Type; b=pUbzbu5PJ8lIscn5RAhGXDIIajhLPKVGffCce52FaaWzs9FVXOB42dBjUfDlc7GnS1nwIsayEUPwsW1Io2HuWa7Ikkqa7hqEYjZO5Y7VGezm7wqMx7YCRSvhW3LTUZWj+4R/sbooolsTHULK71294m7wTWVHBqUUTPrLN/BBbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net; spf=pass smtp.mailfrom=isely.net; dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b=BsWu0K7D; arc=none smtp.client-ip=192.69.181.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isely.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
	t=1772048550; bh=kzij4aA0gGqBbn8ObMvzsIUlZDFWFDVrY7Lbc7PhliU=;
	h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
	b=BsWu0K7Dvl2n/47Rp5BaiNe82RY7fBbnaeV+kg+hOZLN+Z9hLOyHUW4YhgNP1OxJV
	 y8HXeU54g1OmPKg3UR1kRQ0vW1a6jCVNFb8YTmcwozsiEOqVM9eNdfEbtSwPv1ghoQ
	 fvVSqkOfzjesSHfNrQZzhd66/+glf24n/ZsOh3XG7wahCXqbi1BRBlwUsmfk8
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
  id 00000000000A0003.00000000699F50A6.00007069; Wed, 25 Feb 2026 13:42:30 -0600
Date: Wed, 25 Feb 2026 13:42:30 -0600 (CST)
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
In-Reply-To: <aZ7bX4SIoxKTPtoi@smile.fi.intel.com>
Message-ID: <3951478d-43d6-1c9b-de5e-8affc5937472@isely.net>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com> <20260224191922.2972974-2-mike.isely@cobaltdigital.com> <aZ7bX4SIoxKTPtoi@smile.fi.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[cobaltdigital.com,gmail.com,linux.intel.com,vger.kernel.org,pobox.com];
	TAGGED_FROM(0.00)[bounces-21164-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[isely.net:+];
	NEURAL_HAM(-0.00)[-0.995];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[isely@isely.net,linux-acpi@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[isely@pobox.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.com:replyto,pobox.com:email,cobaltdigital.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wikipedia.org:url,isely.net:mid,isely.net:dkim]
X-Rspamd-Queue-Id: 1A1A019CDD2
X-Rspamd-Action: no action

On Wed, 25 Feb 2026, Andy Shevchenko wrote:

> On Tue, Feb 24, 2026 at 01:19:22PM -0600, mike.isely@cobaltdigital.com wrote:
> > From: Mike Isely <mike.isely@cobaltdigital.com>
> 
> Author's and...
> 
> > A scenario exists where device_create_managed_software_node() is used
> > to create an swnode instance that will be implicitly shared to a child
> > device despite best intentions not to permit such sharing (per the
> > comment in device_create_managed_software_node()).  I encountered this
> > with the sfp kernel module when it was instantiated with properties
> 
> SFP? Or is it the name of the actual module in the kernel?

Actual kernel module name, sfp.ko, CONFIG_SFP in .config, named after 
the piece of hardware it works with, an SFP cage.  This is logic which 
monitors SFP cages for hotplug appearance / removal of SFP transceivers.  
When a transceiver appears, the sfp kernel module will create a child 
hwmon device instance to monitor various bits of metadata from the 
transceiver.  When that transceiver goes away, the sfp kernel module 
will tear down that child hwmon device instance.

The sfp kernel module needs resources configured to know where to 
monitor; in our case that is set up dynamically by another locally 
written kernel module (which iteracts with an FPGA we have where the SFP 
hardware elements reside), and that kernel module will combine 
devicetree information with some run-time information to generate the 
properties handed off to the sfp kernel module instantiation.  We use 
platform_device_register_full() to instantiate it, and that in turn 
causes the swnode instance to be created.  The hwmon child instance 
later created by the sfp module ends up inheriting those resources, 
including the swnode instance, from the sfp parent device, and when the 
hwmon instance is later torn down, we end up with the use-after-free 
problem due to the swnode instance's reference count being incorrectly 
decremented by that child device due to the managed flag being set.

If the term SFP is unfamiliar, an explanation can be found here:

https://en.wikipedia.org/wiki/Small_Form-factor_Pluggable


> 
> > via a call to platform_device_register_full() - it will create hwmon
> > child devices which get all property references.  Unfortunately with
> > just a "managed" boolean in struct swnode handling this, then
> > kobject_put() gets called for the managed aspect when the child device
> > goes away instead of the parent.  This leads to premature freeing of
> > the swnode structure, followed by use-after-free problems, heap
> > corruption, and generally chaos / crashes / misbehavior in the kernel.
> > 
> > This commit changes that boolean into a pointer to the actual managing
> > struct device, which is then checked against the struct device
> > instance that is actually going away (via the usual call back into
> > software_node_notify_remove()).  Thus the child device removal is
> > ignored as it should, and we only do the kobject_put() when the actual
> > managing struct device instance goes away.  We effectively carry a
> > little bit more information now so that we can be sure to clean up
> > only when the correct struct device instance is actually going away.
> > 
> > Note that while we are now keeping a pointer to a struct device here,
> > this is safe to do because the pointer itself only stays in use while
> > the pointed-to device remains valid.  (So no need to be concerned
> > about additional reference counting.)
> 
> The term is called "object lifetime".

Meh


> 
> > Signed-off-by: Mike Isely <isely@pobox.com>
> 
> ...submitter's addresses are different. Either it should be send from the
> mentioned address, or you should have
> 
>   From: Author <...>
>   ...
> 
>   SoB: Author <...>
>   SoB: Submitter <...>
> 
> ...

This isn't the first time I've submitted patches.

The reason for SoB being isely@pobox.com is because that is my primary 
email address for which I've been known by in the kernel community.  
It's an address that is stable and has been associated with me since 
1996.  This address has a history and is associated with patches in the 
past going back a long ways.

The from-address of mike.isely@cobaltdigital.com is my current work 
email, which is associated with the reason for the patch.  My employment 
with Cobalt Digital goes back just a few years but my history with the 
Linux kernel goes back significantly further.

It's actually been a while since I sent in a patch.  Last time I did, 
this is how I did it and it wasn't a problem then.  I don't recall 
seeing anything that required the from-address to equate to the SoB.  
Seems like a SoB associated with a long-term known stable email is 
better than something more ephemeral.  If a requirement of equating the 
two is the case now, then I apologize.


> 
> What about the use case (don't know if it's pure theoretical or practical)
> when there is a parent and a few children and the managed swnode appears
> in one of the children? With some other dependencies between children
> it might affect how swnode is get cleaned up. Simple and regular approach
> is to cleanup children in the reversed order, but I can't say that it's
> always the case. Some children in some corner cases might have their own
> dependencies (I saw some strange devices or device drivers where the HW
> is a bit complicated and driver is written without much care).

Though I don't think that's practical, it should not be an issue either.  
Bottom line, swnode instances are reference-counted by virtue of 
containing a kobject instance within.  So even if a managing child goes 
away first, the reference count is still non-zero due to the reference 
from the parent.  So no risk of dangling pointers / use-after-free.  
Note also that management of object lifetime via reference counting here 
provides a fair amount of resilience against potential cleanup ordering 
issues.

An earlier attempt at a solution I had tried was to simply dispense with 
the notion of "managed" here since the reference counting is already 
going to ensure cleanup when the device goes away.  "Managed" in the 
context of struct device are for resources that need automatic cleanup 
which otherwise wouldn't already happen.  So it shouldn't be strictly 
even needed here.  However that didn't work due to a practical 
constraint: The swnode instance is created before the "managing" device 
instance is ready to establish a reference to the swnode instance.  
Turns out that the solution I ultimately hit upon is trivial.

From a standpoint of design hygiene, it makes logical sense that the 
entity which asserts "management" over something should be the same 
entity that deasserts it.  That's really all that this patch does.

  -Mike
   isely@pobox.com
   mike.isely@cobaltdigital.com

