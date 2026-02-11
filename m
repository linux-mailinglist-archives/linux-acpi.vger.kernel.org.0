Return-Path: <linux-acpi+bounces-20929-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAtnEmk9jGlyjwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20929-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 09:27:21 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B9F122375
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 09:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 667F13014136
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 08:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9E3502B0;
	Wed, 11 Feb 2026 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpZn5Q14"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FDC34F27D;
	Wed, 11 Feb 2026 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798438; cv=none; b=VYlR7cgbmkbDb16FIJsYeMEmNIc4tAWy+QH3Xw8dfMlmUzPCTDdf14ydqdakacnayKE13rki0ui+vlrvSI4baWNrcx8Epg/E3i1V/iB/HsyRbGooXcTho3fywo3ELv8PCfzH9HwjRgUR7Xk8nYHNeyji1rQhrn68j7ArqjkjMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798438; c=relaxed/simple;
	bh=3k5BEXJiy4RD36/1Q2xs6gyb3RUnCpGcDHV8zJtSCAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtgRLupyZ0H/p5gjUCROEpAsb3qFWwHZuLg7k7BMjuDAUOknZgO4xBKLsqIlTmV2aaH/RdFp4fpXKBYFUYAirZ24YqMVXRyaJB1vuo6hfatGg8ZvTYla62YoWbCbqv5EIwZEwqM/Zr7DUp/sFlizoGtXZdpLp/KqbcmgjY1dRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpZn5Q14; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770798438; x=1802334438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3k5BEXJiy4RD36/1Q2xs6gyb3RUnCpGcDHV8zJtSCAE=;
  b=fpZn5Q14LoZy0KP3QGAo5lcytIvmuXZ8J5XF2Idq64w2tak30V/YacUf
   1XBC+zgaszRVTzIYSBsGtnU01AHrn3VKvyPBfTUN680bRd3t3MfN+9FGn
   FuQxeno0gfFGSQKUgIU9jeVUfKUju11dlsfAhkFy0U1U5moGIDPEv9UJG
   +e+8oQsZ7c982v/C0uynvZZsyLIn1Zz2v2bXQX0rBRMIp1vGPvJm38eGP
   eF2Ji4dILhOu6OQfVTmsTKvXsVQ5WAupV8SaYJI23o0J9M2xOSKlujONe
   80tGuDjV2d9RebH04mCck0JqueBWRlNAC+jx+zPga/pn7E1GQfeY5bIIh
   A==;
X-CSE-ConnectionGUID: vW8QYz9DSNCKOoo5UfLKHg==
X-CSE-MsgGUID: QL4jQQilQb2MvGOuTmfOfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71926542"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71926542"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:27:14 -0800
X-CSE-ConnectionGUID: Icr8/pTDTY+lWyHG/nNW3g==
X-CSE-MsgGUID: KnBmDAw2S3+P2/0Y4Rym8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="212005392"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.208])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:27:13 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 42561121D36;
	Wed, 11 Feb 2026 10:27:28 +0200 (EET)
Date: Wed, 11 Feb 2026 10:27:28 +0200
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
Message-ID: <aYw9cHENHUhxtzZP@kekkonen.localdomain>
References: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>
 <aYurEV6kKQfI3cs8@kekkonen.localdomain>
 <aYw6g-R5hXd2jnwQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYw6g-R5hXd2jnwQ@smile.fi.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20929-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: B4B9F122375
X-Rspamd-Action: no action

Hi Andy,

On Wed, Feb 11, 2026 at 10:14:59AM +0200, Andy Shevchenko wrote:
> On Wed, Feb 11, 2026 at 12:02:57AM +0200, Sakari Ailus wrote:
> > On Tue, Feb 10, 2026 at 02:58:22PM +0100, Andy Shevchenko wrote:
> > > When device_get_child_node_count() got split to the fwnode and device
> > > respective APIs, the fwnode didn't inherit the ability to traverse over
> > > the secondary fwnode. Hence any user, that switches from device to fwnode
> > > API misses this feature. In particular, this was revealed by the commit
> > > 1490cbb9dbfd ("device property: Split fwnode_get_child_node_count()")
> > > that effectively broke the GPIO enumeration on Intel Galileo boards.
> > > Fix this by moving the secondary lookup from device to fwnode API.
> > > 
> > > Note, in general no device_*() API should go into the depth of the fwnode
> > > implementation.
> 
> Thanks for the review, my answers below.
> 
> ...
> 
> > > +	if (IS_ERR_OR_NULL(fwnode))
> > > +		return NULL;
> > 
> > This test is already being done by fwnode_call_ptr_op() (via
> > fwnode_has_op()) so I'd omit it here. That would probably be best put in
> > another patch though. Up to you.
> 
> I would like to keep this as is for the matter of backporting.
> With that done, I can clean up further.
> 
> ...
> 
> > As the function becomes trivial, I'd move it to property.h.
> 
> Yes, but the same applies to many functions in the property.c. I don't want to
> treat this specially:
> - exceptionally for this function (what about the rest?)
> - for the matters of backporting

There are other similar functions in property.h already. Moving the other
trivial ones there, too, wouldn't hurt.

> 
> ...
> 
> TL;DR: I would like to move this patch forward as is. After that I will
> consider cleaning up as suggested taking into account other places.

Sounds good to me.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus

