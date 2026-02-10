Return-Path: <linux-acpi+bounces-20924-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDYdOgeri2lXYQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20924-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 23:02:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7184D11F959
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 23:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B78BF301873E
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEEC3321AA;
	Tue, 10 Feb 2026 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBwAy5Gs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F03043D5;
	Tue, 10 Feb 2026 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770760966; cv=none; b=uYfhgZxk8GhSt40YlZ4cKJL05oygIM/Vc4eB874it00eZlksP0JrSBvPNSssOelfNtZKr0fGHRrjyq34v0jheJQ/puPKRe1PvWPE+Qfe1TON+xj6GchpgyiOcCcdMUjXfYSW38+kcpis2+SxgXD8e/YcG+dEyELWiE9Z3vZDzS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770760966; c=relaxed/simple;
	bh=gWcmNKmtYUdITknuMcYCQG0X69MWxLuzvSKaGyqwQuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZm3P52ub6fxdAObF/M/oHn7vkMjz6XgQw2/KVhbVcoe9s9hhIgP8OapomphUrsR3gVxziY285xFQaCQAPCFZFUnmi8Rkddq/Q7u19w4EyX6uoLi9jBPLqo/V5dnivkw2/MnT1ISs7BId7RN4gmYTdHbNe9hrm4drbfudCI8AOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBwAy5Gs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770760965; x=1802296965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gWcmNKmtYUdITknuMcYCQG0X69MWxLuzvSKaGyqwQuA=;
  b=HBwAy5GsiYMxXhBnIsLJkE4NNvcxybbBWckkOlVyxykx6QKi3z8uw4MN
   aZehAW5AWBgrVxlYmBoQeY6iNvMsWFGmCKYjJzriFbuW7VHY+NnCj8PuT
   ncg9WelMGBbLd7WIrmP97gz+q2fM+7y03hNXn6nSL884iKgmg6tCv9ORV
   snYv126Sm2IHrVuOD7JcB7ngizT4G7j1y8WymcSNVnT99aG5msDnyWhhZ
   jO81oRVFSJGeZc3Wm38zgMkWhq1sTfysQmbi5Kc4H9tF9zU87e/3RH5KZ
   LKNP4RqC08xBFZwNOiGwYlKtgeDnktxzDKHx+Yt1T8bQLTPRU8HjaS15G
   w==;
X-CSE-ConnectionGUID: 97pZj56TRLy/1dmcI6vFMQ==
X-CSE-MsgGUID: xQRDTbxfRZCmm3V5yLoylQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="70918915"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="70918915"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 14:02:44 -0800
X-CSE-ConnectionGUID: jHV6+9qQRBOc//sOcFYNeA==
X-CSE-MsgGUID: HPI+9c58ScmMeFkPnyM9cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211875646"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.164])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 14:02:42 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 8073A121D37;
	Wed, 11 Feb 2026 00:02:57 +0200 (EET)
Date: Wed, 11 Feb 2026 00:02:57 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] device property: Allow secondary lookup in
 fwnode_get_next_child_node()
Message-ID: <aYurEV6kKQfI3cs8@kekkonen.localdomain>
References: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20924-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.intel.com,linuxfoundation.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sakari.ailus@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 7184D11F959
X-Rspamd-Action: no action

Hi Andy,

Thanks for the patch.

On Tue, Feb 10, 2026 at 02:58:22PM +0100, Andy Shevchenko wrote:
> When device_get_child_node_count() got split to the fwnode and device
> respective APIs, the fwnode didn't inherit the ability to traverse over
> the secondary fwnode. Hence any user, that switches from device to fwnode
> API misses this feature. In particular, this was revealed by the commit
> 1490cbb9dbfd ("device property: Split fwnode_get_child_node_count()")
> that effectively broke the GPIO enumeration on Intel Galileo boards.
> Fix this by moving the secondary lookup from device to fwnode API.
> 
> Note, in general no device_*() API should go into the depth of the fwnode
> implementation.
> 
> Fixes: 114dbb4fa7c4 ("drivers property: When no children in primary, try secondary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/property.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 6a63860579dd..8d9a34be57fb 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -797,7 +797,18 @@ struct fwnode_handle *
>  fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
>  			   struct fwnode_handle *child)
>  {
> -	return fwnode_call_ptr_op(fwnode, get_next_child_node, child);
> +	struct fwnode_handle *next;
> +
> +	if (IS_ERR_OR_NULL(fwnode))
> +		return NULL;

This test is already being done by fwnode_call_ptr_op() (via
fwnode_has_op()) so I'd omit it here. That would probably be best put in
another patch though. Up to you.

> +
> +	/* Try to find a child in primary fwnode */
> +	next = fwnode_call_ptr_op(fwnode, get_next_child_node, child);
> +	if (next)
> +		return next;
> +
> +	/* When no more children in primary, continue with secondary */
> +	return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node, child);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
>  
> @@ -841,19 +852,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
>  struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  						 struct fwnode_handle *child)
>  {
> -	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> -	struct fwnode_handle *next;
> -
> -	if (IS_ERR_OR_NULL(fwnode))
> -		return NULL;
> -
> -	/* Try to find a child in primary fwnode */
> -	next = fwnode_get_next_child_node(fwnode, child);
> -	if (next)
> -		return next;
> -
> -	/* When no more children in primary, continue with secondary */
> -	return fwnode_get_next_child_node(fwnode->secondary, child);
> +	return fwnode_get_next_child_node(dev_fwnode(dev), child);

As the function becomes trivial, I'd move it to property.h.

>  }
>  EXPORT_SYMBOL_GPL(device_get_next_child_node);
>  

-- 
Kind regards,

Sakari Ailus

