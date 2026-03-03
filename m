Return-Path: <linux-acpi+bounces-21321-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLOIJnRnp2mghAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21321-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 23:57:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 153DD1F8383
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 23:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0204A3012BEC
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 22:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362BB38C435;
	Tue,  3 Mar 2026 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDLDKVFi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837D3644CB;
	Tue,  3 Mar 2026 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578674; cv=none; b=IKVGysRr3kHau5cyzp5LZp9hhNoiqIDjmZ6YEplE0Aqbdr8bccfxMsg8gZbGbz1qDsNG00Nmc/FrLd/NdkhsFWDtDTJ2lqtsNf/YAH4FOrdeYJiRHHmMBBFlx9rF5KpFBQtpXwKW/BksiVsgxgnVl2hD7lAovsmusXNKVuWx+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578674; c=relaxed/simple;
	bh=M1EbppOzgdtKcOk8u5zp5xD9R7ciUhiVs/3iZvTsAYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEa8dRZhFaddxfwbTnvmohp6RdiZJ04TZ4t5JD7v8HDLAr9dPHfza/dK7TTFtbC8qKs6NdNNSyA6MVFeUHyVx5BqO7WCwcOxovSUfZUWkwQW1H8gah4tC8Jc0b7W5n3+gJmiid5shcCINwuYoJQJIHYqprXCSUKimzvFT8+qrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDLDKVFi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772578672; x=1804114672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M1EbppOzgdtKcOk8u5zp5xD9R7ciUhiVs/3iZvTsAYY=;
  b=UDLDKVFiMlNxX4d8QczEQwpwkhj4cO3P3yErfg5aLHR7g0a29yUCAVXW
   96aAYMSbY8QQJ5FCMuzu4iHr/byBkhRo/TbNSwhb2Fqrs4poF639id2Cl
   3Tw+qm+b0HDhtr155GY6YxmmEgQkHyOUCtpkf9RUhxEFRN5f+ZK4u5OgW
   cHQs6tuDsv41sxRrevXnm4rpkKgdnizJGndk41fNTN0qw57mK7bKaSxQ7
   rtw8tURafZ8GVffF/Ej1RM4cyLLJ22LDGP51LpkA4JYBzXaTsPHH3HUcC
   DM5aoAZlRE2X7ctoniJh0BlBVpQBjpVh4y+YSbgkrFTEgF6g834wIwglG
   A==;
X-CSE-ConnectionGUID: 0eGDbwt5QtiD5Yv+JeYlbg==
X-CSE-MsgGUID: WgegzKlLQK6K5LBkjySXgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="84269056"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="84269056"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 14:57:51 -0800
X-CSE-ConnectionGUID: pKNSi7arRtq6xx4bXlJP+g==
X-CSE-MsgGUID: vEs6fFZ9QEWm/Qvt9AjNKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="222815082"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 14:57:49 -0800
Date: Wed, 4 Mar 2026 00:57:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mike.isely@cobaltdigital.com
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mike Isely <isely@pobox.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] software node: Only the managing device can
 unreference managed software node
Message-ID: <aadna1zBB_XQDYfl@ashevche-desk.local>
References: <20260303211348.2414465-1-mike.isely@cobaltdigital.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303211348.2414465-1-mike.isely@cobaltdigital.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 153DD1F8383
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,pobox.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-21321-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 03:13:47PM -0600, mike.isely@cobaltdigital.com wrote:

> Explanation here is lengthy because the problem is subtle.
> 
> A scenario exists where device_create_managed_software_node() is used
> to create an swnode instance that will be implicitly shared to a child
> device despite best intentions not to permit such sharing (per the
> comment in device_create_managed_software_node()).  I encountered this
> with the sfp kernel module when it was instantiated with properties
> via a call to platform_device_register_full() - it will create hwmon
> child devices which get all property references.  Unfortunately with
> just a "managed" boolean in struct swnode handling this, then
> kobject_put() gets called for the managed aspect when the child device
> goes away instead of the parent.  This leads to premature freeing of
> the swnode structure, followed by use-after-free problems, heap
> corruption, and generally chaos / crashes / misbehavior in the kernel.
> 
> This commit changes that boolean into a pointer to the actual managing
> struct device, which is then checked against the struct device
> instance that is actually going away (via the usual call back into
> software_node_notify_remove()).  Thus the child device removal is
> ignored as it should, and we only do the kobject_put() when the actual
> managing struct device instance goes away.  We effectively carry a
> little bit more information now so that we can be sure to clean up
> only when the correct struct device instance is actually going away.
> 
> Note that while we are now keeping a pointer to a struct device here,
> this is safe to do because the pointer itself only stays in use while
> the pointed-to device remains valid.  (So no need to be concerned
> about additional reference counting.)
> 
> Here's a succinct, generic sequence that spells out the steps which
> lead to trouble:
> 
>   1. Somebody creates a struct device instance.
> 
>   2. Somebody calls device_create_managed_software_node() associating
>   it with that struct device instance.  This causes two kobject
>   references to be counted against the swnode instance (one for the
>   struct device and one because the managed flag was set).  refcount=2
> 
>   3. Some time later, a child struct device is created and the
>   properties of the parent are shared with the child.  This causes
>   another kobject reference to be counted against the swnode instance.
>   refcount=3
> 
>   4. Some time later, that child struct device instance goes
>   away (perhaps due to a hotplug removal).  During the tear-down,
>   software_node_notify_remove() notices that the managed field of the
>   swnode instance is set, so TWO kobject references are removed
>   instead of the single reference created by the previous step.
>   refcount=1
> 
>   5. Repeat step 3.  refcount=2
> 
>   6. Repeat step 4.  refcount=0
> 
>   7. Now the kobject reference count inside the swnode instance has
>   dropped to zero and so the swnode instance is released.  Notice that
>   the parent device is still holding a physical reference, now
>   pointing into freed memory.  Chaos likely follows.  If lucky, a NULL
>   pointer kernel oops is the result.
> 
> The patch fixes this by causing step 4 to only do the second reference
> decrement if the device being torn down is the same one that
> established the managing relationship in the first place.  Then
> everything stays balanced.
> 
> I confirmed this exact sequence of behavior in the context of the sfp
> kernel module with appropriate printk debug trace added, when
> instantiated with platform_device_register_full() with properties
> provided.  While that's may be hard for to reproduce without sfp
> hardware, anything else which performs those steps should produce
> similar results.
> 
> Note that because platform_device_register_full() will implicitly
> employ a managed swnode instance any time it is passed properties in
> its pdevinfo argument, then by implication anyone calling
> platform_device_register_full() in that manner - which happens in
> multiple other places in the kernel - is at risk for the same issue.
> 
> Signed-off-by: Mike Isely <mike.isely@cobaltdigital.com>
> Signed-off-by: Mike Isely <isely@pobox.com>
> ---
>  drivers/base/swnode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 53b3f0061ad12..18a903a35197c 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -36,8 +36,8 @@ struct swnode {
>  	struct list_head children;
>  	struct swnode *parent;
>  
> +	struct device *managing_dev;
>  	unsigned int allocated:1;
> -	unsigned int managed:1;
>  };
>  
>  static DEFINE_IDA(swnode_root_ids);
> @@ -1060,7 +1060,7 @@ int device_create_managed_software_node(struct device *dev,
>  	if (IS_ERR(fwnode))
>  		return PTR_ERR(fwnode);
>  
> -	to_swnode(fwnode)->managed = true;
> +	to_swnode(fwnode)->managing_dev = dev;
>  	set_secondary_fwnode(dev, fwnode);
>  
>  	if (device_is_registered(dev))
> @@ -1104,7 +1104,7 @@ void software_node_notify_remove(struct device *dev)
>  	sysfs_remove_link(&dev->kobj, "software_node");
>  	kobject_put(&swnode->kobj);
>  
> -	if (swnode->managed) {
> +	if (swnode->managing_dev == dev) {
>  		set_secondary_fwnode(dev, NULL);
>  		kobject_put(&swnode->kobj);
>  	}
> -- 
> 2.47.3

> ---
> 
> Correct issue in drivers/base/swnode.c that can lead to use-after-free
> due to kobject reference counting error, which itself is due to
> incorrect behavior with the "managed" struct swnode flag in
> circumstances involving child struct device instances where the parent
> struct device is managing a struct swnode.
> 
> Use-after-free in this case leads to likely kernel heap corruption, so
> any manner of chaos can result, if left unaddressed.

There is already '---' above, at least now it's visible, but I dunno if tools
will cope with non-standard changelog location.


-- 
With Best Regards,
Andy Shevchenko



