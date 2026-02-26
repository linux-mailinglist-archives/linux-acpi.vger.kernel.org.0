Return-Path: <linux-acpi+bounces-21193-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF+MB3+boGlVlAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21193-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 20:14:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E251AE3BF
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 20:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3327431E9477
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 19:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBA73B8BB7;
	Thu, 26 Feb 2026 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b="CulOgr8Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8503E8C6F;
	Thu, 26 Feb 2026 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.69.181.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132811; cv=none; b=aiPx7gi79fOZ03hBzn94TLs9rSU5PnOPfkn5lGzYPTNygkaMbDKDrG5eAkZ9KMGHOQYhDYLJTx7rbdvjFlaWze3S11weUizT6B5xRVAGajejB+ZVBe0rmxGAr9Txasbh78+ELYOunrKiNJ8pifdILowQSHS2D/292xnTL5fweEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132811; c=relaxed/simple;
	bh=4FIkNmuS/a3jszRHeQiOpzu8QljIAu0SHA7SzQjUTNk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Mime-Version:Content-Type; b=Emw11Z/f5o/eByoeOG9q+0ABs0ZvLHrJGzlHLJxxvoukaB23NH4vx9Jirl1P9AQJTf0TJxrVKnPi7rJ+OySkFucbYvgMy1fD4bIWcSOMeKTIuG93sHS9GlVwIn/2sxFNhPG/ufIdhsISO2q9qH0QYlTGCKeOvzk7afd8a3h2bDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net; spf=pass smtp.mailfrom=isely.net; dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b=CulOgr8Q; arc=none smtp.client-ip=192.69.181.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isely.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
	t=1772132803; bh=q293kRkwyFuQ0/7ghFwJzXZcH4NQSGakfL6+vfdvsXU=;
	h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
	b=CulOgr8QbPJLUDHNqlGIVhJcQPChIkVeA6gN/Lsvl/R3g9ciUDhGVzulZbBzJNYra
	 iftDRZgIlWjjtSi66vKmMNOYDat0sJkeKcHnRZ97qnxu5s3G8HDnxvJDPvoruZ8J/C
	 vkieg8FCRukjgI3ewFox0raBjAuh12iZYKNGoQRzyLhfXR3lllMuy2FhXwvG/
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
  id 00000000000A0005.0000000069A099C2.00006112; Thu, 26 Feb 2026 13:06:42 -0600
Date: Thu, 26 Feb 2026 13:06:42 -0600 (CST)
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
In-Reply-To: <aZ_zX-jQ7T8LVeSU@smile.fi.intel.com>
Message-ID: <3d7a7e25-b78c-6c60-a485-92cced6075d1@isely.net>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com> <20260224191922.2972974-2-mike.isely@cobaltdigital.com> <aZ7bX4SIoxKTPtoi@smile.fi.intel.com> <3951478d-43d6-1c9b-de5e-8affc5937472@isely.net> <aZ9VHXwReXdWZHz8@smile.fi.intel.com>
 <5c5f39f4-9797-4d84-eaf2-3fb7a830cbbf@isely.net> <aZ_zX-jQ7T8LVeSU@smile.fi.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[cobaltdigital.com,gmail.com,linux.intel.com,vger.kernel.org,pobox.com];
	TAGGED_FROM(0.00)[bounces-21193-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[isely.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[isely@isely.net,linux-acpi@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[isely@pobox.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21E251AE3BF
X-Rspamd-Action: no action

On Thu, 26 Feb 2026, Andy Shevchenko wrote:

> On Wed, Feb 25, 2026 at 02:16:39PM -0600, Mike Isely wrote:
> > On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > > On Wed, Feb 25, 2026 at 01:42:30PM -0600, Mike Isely wrote:
> > > > On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > > > > On Tue, Feb 24, 2026 at 01:19:22PM -0600, mike.isely@cobaltdigital.com wrote:
> 
> ...
> 
> > > > > > A scenario exists where device_create_managed_software_node() is used
> > > > > > to create an swnode instance that will be implicitly shared to a child
> > > > > > device despite best intentions not to permit such sharing (per the
> > > > > > comment in device_create_managed_software_node()).  I encountered this
> > > > > > with the sfp kernel module when it was instantiated with properties
> > > > > 
> > > > > SFP? Or is it the name of the actual module in the kernel?
> > > > 
> > > > Actual kernel module name, sfp.ko, CONFIG_SFP in .config, named after 
> > > > the piece of hardware it works with, an SFP cage.  This is logic which 
> > > > monitors SFP cages for hotplug appearance / removal of SFP transceivers.  
> > > > When a transceiver appears, the sfp kernel module will create a child 
> > > > hwmon device instance to monitor various bits of metadata from the 
> > > > transceiver.  When that transceiver goes away, the sfp kernel module 
> > > > will tear down that child hwmon device instance.
> > > > 
> > > > The sfp kernel module needs resources configured to know where to 
> > > > monitor; in our case that is set up dynamically by another locally 
> > > > written kernel module (which iteracts with an FPGA we have where the SFP 
> > > > hardware elements reside), and that kernel module will combine 
> > > 
> > > > devicetree information with some run-time information to generate the 
> > > > properties handed off to the sfp kernel module instantiation.
> > > 
> > > What runtime information? Why this can't be done via DT overlay as others do?
> > 
> > I don't recall the specifics.  It might be calculation of a unit name.  
> > The connectivity in this case is I2C so that should be a constant.  We 
> > have some variants where the FPGA is PCIE-connected to the host and so 
> > the memory map is a run-time calculation.  We have other drivers that 
> > have to be instantiated with run-time computed properties.  So we handle 
> > this as a general case.
> 
> But the configurations are semi-static, right? For the contents of FPGA we have
> a specific manager that reloads the FPGA configuration.
> 
> Using swnode for dynamically calculated data seems weird. The data in swnodes
> is usually static (const), I can't remember the case where we need to supply
> run-time calculated values.

Semi-static means partially dynamic...

We use the kernel FPGA manager in one platform (zynqmp) and a userspace 
loader program in another (PCIE connected to bcm2711 soc).  However it 
is not reasonable to reload on-the-fly as that would disrupt every piece 
of logic (kernel modules and userspace code) currently pointing inside 
its memory space.  It would require tearing down the application space 
and unloading every kernel module using the FPGA space (some of which is 
ours and others which are stock kernel code).  Might as well reboot - so 
we load once at boot time.  If the image needs to be swapped out (and 
there are defined cases for this), a symbolic link is updated to point 
to the new bitfile and the processor is rebooted.  But this is getting 
off-topic.

We actually don't directly invoke the use of swnode.  It's being done 
indirectly inside of platform_device_register_full(), when its 
pdevinfo->properties argument is non-null, which is a normal thing that 
happens in many other invocations of that function.  See 
drivers/base/platform.c at the call to 
device_create_managed_software_node().  I had no idea of even the 
existence of swnode until I started tracking down the kernel 
misbehavior.

Whether statically provided or calculated, this code path is happening.  
Our case may be dynamic, but certainly any other managed swnode usage 
which involves child devices is going to be a reference-counting problem 
before this patch.

   [snip]

  -Mike
   isely@pobox.com


