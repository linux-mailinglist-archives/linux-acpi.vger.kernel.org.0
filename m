Return-Path: <linux-acpi+bounces-20928-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLxeK4s6jGlZjgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20928-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 09:15:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2591E122219
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 09:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6830730074A3
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 08:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6D350291;
	Wed, 11 Feb 2026 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDtCCMH0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B5A34FF58;
	Wed, 11 Feb 2026 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797705; cv=none; b=HCFA/cvkZTFr/4lrAybTybsVw1r9iLe03MmVve3VJFfhc5yHAkg+XFvG/gULglyF91lk9aopPTF26VaCL0T3XgjwHRpj2dovtJh0M9VHucOfj1Y7+QW0tVvIk/4gQZ+yHS7QToAdp9+Vl+98hpyBOAs8Z8IjdmcSYBvytCkv3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797705; c=relaxed/simple;
	bh=lcm3o7wL5kBg7ZYVDqCsaOcln/wpMYWwqixrap+exkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvIxFi7RgoKK92NJOy8FvlvWHikyLHsFWV0hPmS4bXLZ7bo9NzymW2HgrL0tKyBhdxdsx8w73C9B5nfxPbKoNS7bUDTsWXc8wtd+SMVl18YNblHOeefb31bpOQHYfZNoCE7JvbRWohKA53QsfSKeQbt5Pg+b7Rd7Psd4ra0TVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDtCCMH0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770797705; x=1802333705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lcm3o7wL5kBg7ZYVDqCsaOcln/wpMYWwqixrap+exkM=;
  b=oDtCCMH0wDoOBrawYKhVDfPBxfUxwTTfFwRe8e2mTaDJAMb0NWHXN5H/
   CP2ACwPjr36qS5nfgWEn5xPTMC7+tjFnq45Y69kcXQFu63k4sC8HBLNsb
   QmvNZ55PUlhSR0/aFpJTs4RoHDERPW6fMGe7dExVqHrDi4SiaKtH41cWz
   Azo5dqwYr9Z1OXK+G2oLqmqKyt2ohAbZr35tS52qDA+hSTjoxsGkEr2QV
   Agt5l9QbTR11JcGHaxxxXPkZ/4YJqVtYc+lEYaSjqvIrRxf3mim2nxHeO
   mfsJjbi8lb8bvm2CmKLqf6CFFHctxItuS7IiPxloM1dHSk1EwYJuKHRci
   g==;
X-CSE-ConnectionGUID: afE77VtOTMqSqUiDG3OYug==
X-CSE-MsgGUID: H4Dh/0SiSu2pJJq4WKimjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="83380869"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="83380869"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:15:04 -0800
X-CSE-ConnectionGUID: 8UiJQ0k6Q7em/8Llw6CfGw==
X-CSE-MsgGUID: mhA5W8wZShqRq0+mZKkrcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211137503"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:15:01 -0800
Date: Wed, 11 Feb 2026 10:14:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] device property: Allow secondary lookup in
 fwnode_get_next_child_node()
Message-ID: <aYw6g-R5hXd2jnwQ@smile.fi.intel.com>
References: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>
 <aYurEV6kKQfI3cs8@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYurEV6kKQfI3cs8@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.intel.com,linuxfoundation.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-20928-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 2591E122219
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 12:02:57AM +0200, Sakari Ailus wrote:
> On Tue, Feb 10, 2026 at 02:58:22PM +0100, Andy Shevchenko wrote:
> > When device_get_child_node_count() got split to the fwnode and device
> > respective APIs, the fwnode didn't inherit the ability to traverse over
> > the secondary fwnode. Hence any user, that switches from device to fwnode
> > API misses this feature. In particular, this was revealed by the commit
> > 1490cbb9dbfd ("device property: Split fwnode_get_child_node_count()")
> > that effectively broke the GPIO enumeration on Intel Galileo boards.
> > Fix this by moving the secondary lookup from device to fwnode API.
> > 
> > Note, in general no device_*() API should go into the depth of the fwnode
> > implementation.

Thanks for the review, my answers below.

...

> > +	if (IS_ERR_OR_NULL(fwnode))
> > +		return NULL;
> 
> This test is already being done by fwnode_call_ptr_op() (via
> fwnode_has_op()) so I'd omit it here. That would probably be best put in
> another patch though. Up to you.

I would like to keep this as is for the matter of backporting.
With that done, I can clean up further.

...

> As the function becomes trivial, I'd move it to property.h.

Yes, but the same applies to many functions in the property.c. I don't want to
treat this specially:
- exceptionally for this function (what about the rest?)
- for the matters of backporting

...

TL;DR: I would like to move this patch forward as is. After that I will
consider cleaning up as suggested taking into account other places.

-- 
With Best Regards,
Andy Shevchenko



