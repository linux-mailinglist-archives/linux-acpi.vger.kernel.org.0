Return-Path: <linux-acpi+bounces-21266-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EAYLDYZo2mJ9gQAu9opvQ
	(envelope-from <linux-acpi+bounces-21266-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 17:35:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB61C1C45C9
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 17:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C642E3037D53
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2482E62C4;
	Sat, 28 Feb 2026 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b="CwVZct/A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857BE2D838E;
	Sat, 28 Feb 2026 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.69.181.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772296465; cv=none; b=ISEaUSQNOM0kynke2Kp7cPcS5MsiV4ge1OLh2kH3cnw75clRtwaR/v6gVXIsbFWVxLvRQcsUF4fnLVOOc1LcdpkpfU4QHyYu5UbSGl/RS9jNU7Ba1TmtiazJr6v/L1m2429lCPtduJkoux85hYikP0lyXz8gt1WDmLGsGNyUehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772296465; c=relaxed/simple;
	bh=ufFuRF3oE56B+SSVCbtbyJ+YgY8xIhKgGRANyK2ofck=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Mime-Version:Content-Type; b=JUHuC9qyhlTUy4HQUG5YMQ3OgKgkHbDtYYHzK0FAcmUPaJhUXImPdRn1PqpS7Kla8FMuO9ga/K64Ci2RsAVlZn00li6VN3gN8b2zz/kVXqWMcsY4VcjgmBpcHQf5AzBbOWGCxTDBD5wejvDdsox7LwIoDz8Bv7KuB1i3NOnuY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net; spf=pass smtp.mailfrom=isely.net; dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b=CwVZct/A; arc=none smtp.client-ip=192.69.181.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isely.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
	t=1772296462; bh=/4tFb1VrbBvgKf/ubui3WN4mHOr5KLgZfSdboqYxuxQ=;
	h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
	b=CwVZct/AZ6hmgPWAYPRzZ5trzRnPlZPGDc/SY/5xB6qG1s3aO5aWp6WiE9kQJkEZP
	 x0mup614v82ZgT6hhxwnYQEDJXOtudQivWLRf28cqRqwlScqejJqchsGsQpp38ieCH
	 YAFOZb8NI/zHuxUECaQYuZDVTP2DIYTGj12kYuszwFQkl2t7Egj3wfw6J3DZ9
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
  id 00000000000A0006.0000000069A3190E.0000141A; Sat, 28 Feb 2026 10:34:22 -0600
Date: Sat, 28 Feb 2026 10:34:22 -0600 (CST)
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
In-Reply-To: <aaLLRyeK7GwR978-@ashevche-desk.local>
Message-ID: <c3b55429-dda9-db2d-85ef-8d110b5c7648@isely.net>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com> <20260224191922.2972974-2-mike.isely@cobaltdigital.com> <aZ7bX4SIoxKTPtoi@smile.fi.intel.com> <3951478d-43d6-1c9b-de5e-8affc5937472@isely.net> <aZ9VHXwReXdWZHz8@smile.fi.intel.com>
 <5c5f39f4-9797-4d84-eaf2-3fb7a830cbbf@isely.net> <aZ_zX-jQ7T8LVeSU@smile.fi.intel.com> <3d7a7e25-b78c-6c60-a485-92cced6075d1@isely.net> <aaCwG-llsnmQYgd0@smile.fi.intel.com> <64161dbd-975f-a12d-8e9c-ba2e791e48c2@isely.net>
 <aaLLRyeK7GwR978-@ashevche-desk.local>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[cobaltdigital.com,gmail.com,linux.intel.com,vger.kernel.org,pobox.com];
	TAGGED_FROM(0.00)[bounces-21266-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[isely.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[isely@isely.net,linux-acpi@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[isely@pobox.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pobox.com:replyto,pobox.com:email,isely.net:mid,isely.net:dkim]
X-Rspamd-Queue-Id: BB61C1C45C9
X-Rspamd-Action: no action

On Sat, 28 Feb 2026, Andy Shevchenko wrote:

> On Fri, Feb 27, 2026 at 11:55:51AM -0600, Mike Isely wrote:
> > On Thu, 26 Feb 2026, Andy Shevchenko wrote:

  [snip]

> 
> > I am unfamiliar with that driver or its surroundings, so I don't know if 
> > it is a viable means to reproduce the problem.  I can spend time 
> > analyzing that code further if you wish.  However it might be more 
> > productive to try to succinctly, generically, spell out the steps that 
> > lead to trouble:
> > 
> > 1. Somebody creates a struct device instance.
> > 
> > 2. Somebody calls device_create_managed_software_node() associating it 
> > with that struct device instance.  This causes two kobject references to 
> > be counted against the swnode instance (one for the struct device and 
> > one because the managed flag was set).  refcount=2
> > 
> > 3. Some time later, a child struct device is created and the properties 
> > of the parent are shared with the child.  This causes another kobject 
> > reference to be counted against the swnode instance.  refcount=3
> > 
> > 4. Some time later, that child struct device instance goes away (perhaps 
> > due to a hotplug removal).  During the tear-down, 
> > software_node_notify_remove() notices that the managed field of the 
> > swnode instance is set, so TWO kobject references are removed instead of 
> > the single reference created by the previous step.  refcount=1
> > 
> > 5. Repeat step 3.  refcount=2
> > 
> > 6. Repeat step 4.  refcount=0
> > 
> > 7. Now the kobject reference count inside the swnode instance has 
> > dropped to zero and so the swnode instance is released.  Notice that the 
> > parent device is still holding a physical reference, now pointing into 
> > freed memory.  Chaos likely follows.  If lucky, a NULL pointer kernel 
> > oops is the result.
> > 
> > I confirmed this exact sequence of behavior in the context of the sfp 
> > kernel module with appropriate printk debug trace added.  While that's 
> > going to be hard for you to reproduce without sfp hardware, anything 
> > else which performs those steps should produce similar results.
> > 
> > The patch fixes this by causing step 4 to only do the second reference 
> > decrement if the device being torn down is the same one that established 
> > the managing relationship in the first place.  Then everything stays 
> > balanced.
> > 
> > Notice that this has nothing to do with whether or not the properties 
> > are const, nor does it have anything to do with FPGA management.  I 
> > apologize if I caused confusion leading to that.
> 
> No problem, now with this very deep and comprehensive analysis everything
> is clear. Thanks for providing this all information!
> 
> > It's purely the
> > combination of a managed swnode instance used for a device that will 
> > create / remove child devices over time (due perhaps to hotplug 
> > activity).
> 
> > And because platform_device_register_full() will implicitly employ a 
> > managed swnode instance any time it is passed properties in its pdevinfo 
> > argument, then by implication anyone calling 
> > platform_device_register_full() in that manner - which happens in 
> > multiple other places in the kernel - is at risk for the same issue.
> 
> Yeah, I will think about this more, but if somebody beats me up to it
> and confirms that this is the best what we can do, I will have no
> objections. I dunno, let's say in a couple of weeks?
> 
> 

No rush.  We're already using the patch internally of course.

I can resend you the patch, fixing the process issues you cited, along 
with the commit comment adjusted to include the sequence above which 
finally made the issue crystal clear.  I'll try to get that to you on 
Monday or Tuesday.

  -Mike
   isely@pobox.com

