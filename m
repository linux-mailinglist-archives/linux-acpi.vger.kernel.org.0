Return-Path: <linux-acpi+bounces-21167-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bq6JzxWn2mIaQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21167-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 21:06:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A75F19D093
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 21:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 182F830457CF
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 20:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC72F2607;
	Wed, 25 Feb 2026 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keRFxBvJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF9713635C;
	Wed, 25 Feb 2026 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049964; cv=none; b=Znw4RsAZFfq4yKzQLHV+5IilC8qeJhoObVMhJT/JLtX5HpRq2EMAjGBcWpq9JYo8fUUethhwF1686fyFM7UNTGSv56v3iza/9BxyS4Rjt5l/bnniYkG0xhPbrN5fDgYlIMqJnT+At/voj1VNMpmqzTCtTiEZtdg929niGS0YYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049964; c=relaxed/simple;
	bh=B3DnkGh3dmzjZV5oKZOo6XlvVy2GCPe2KOqD7sZ7POU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXlzCRQu6rt8avZOPg9U5TP7jlkWs7VW///881fmnzPpvnYN0QMo6jA5ovE4FLBC5ikqM6bCwZpOt5+E076i/vdSJ8ORsNJ7smQXmor2txoJJPUXMAJ6VRJURSXJKdFsvvkFcZEL3rBpMCLXpuXzKJnRz1cgL9+sigqptRiJbdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=keRFxBvJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772049963; x=1803585963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B3DnkGh3dmzjZV5oKZOo6XlvVy2GCPe2KOqD7sZ7POU=;
  b=keRFxBvJF4cYlvZK4ANCIrGadkp1xjQC0QS+ABTl8wWUfNSC1xPvcFq1
   gdc+VOtl6PciuRUE0lyfV07SGlW15YwFraF6rm2XpkK6+XDJfrTsTNOGg
   ag70jNGIcnDAx1PBwbZwSTKE7szdcb3sZHkqooD2wphbfAvl3wb5QlI4n
   J6zfAdQEyBsySQN3dKQAASzqxdKCWdQfd5Lox8hTKty4BIJkDn6hiukIX
   AFT1aFTjX3tcVV4EypaALNH+EbueWnvxe2m4nXdhvj7o/vsBeePdG9xUT
   L8bVV1+OtipxEYQ8wImgDJhQ0Ci8eNYBWxOgD5Eu9gxBbZrAHCM5RJptN
   g==;
X-CSE-ConnectionGUID: zpHjdQN0SPaMt73lYw1ieg==
X-CSE-MsgGUID: woj6Qc03QX+u/pD1tOHgYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73008946"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73008946"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 12:06:02 -0800
X-CSE-ConnectionGUID: LN/bpprzR42XwvRSKsWsYw==
X-CSE-MsgGUID: w7OmXNmXR6GUqvoqcfA/gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="246888051"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 12:06:00 -0800
Date: Wed, 25 Feb 2026 22:05:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mike Isely at pobox <isely@pobox.com>
Cc: mike.isely@cobaltdigital.com, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] software node: Use-after-free fix in
 drivers/base/swnode.c
Message-ID: <aZ9WJX2otnpgk6wR@smile.fi.intel.com>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com>
 <aZ7E7q6vdUHW_Wj6@smile.fi.intel.com>
 <04eebe7b-0f88-2122-eeef-568117bb8235@isely.net>
 <aZ9K56Q_NHmAYmeu@smile.fi.intel.com>
 <80ccd17f-9265-f304-fae0-1250c2caedba@isely.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ccd17f-9265-f304-fae0-1250c2caedba@isely.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cobaltdigital.com,gmail.com,linux.intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21167-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cobaltdigital.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smile.fi.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 2A75F19D093
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 01:48:04PM -0600, Mike Isely wrote:
> On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > On Wed, Feb 25, 2026 at 12:59:56PM -0600, Mike Isely wrote:
> > > On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > > > On Tue, Feb 24, 2026 at 01:19:21PM -0600, mike.isely@cobaltdigital.com wrote:

...

> > > > > This was detected in kernel 6.12, verified also in kernel 6.6.  Visual
> > > > > inspection in 6.19.3 source (the latest as of right now) shows the
> > > > 
> > > > The latest is v7.0-rc1 as of time of the topic message.
> > > 
> > > I actually meant the latest release.  Guess I should have checked the 
> > > latest release candidate on the off-chance that it might have been 
> > > addressed.
> > 
> > It is probably not, but the idea to check against latest tag in the vanilla
> > repository. v6.19.3 is not even vanilla, it's stable kernel.
> 
> I tend to stick with the latest kernel that is NOT a release candidate 
> when building random things here regardless of the term used and that's 
> still 6.19.3.  But for verifying a patch, yes I should have at least 
> taken a closer look at 7.0-rc1.

The logical requirement for a new contribution is to build changes against
current or next cycle. Hence only two kernels have interest to us:

- latest tag in vanilla (v7.0-rc1 as of today)
- latest tag in Linux Next (whatever day it is)

> > > > > same issue.  The nearly trivial fix was verified in 6.12.  While this
> > > > > patches against 6.19.3, IMHO this is a candidate for all LTS kernels.
> > > > 
> > > > Thanks for the contribution, usually for a single patch there is no need
> > > > in cover letter. The comment block can handle this (the place after cutter
> > > > '---' line in the message with a patch).
> > > 
> > > Yeah, a separate cover letter is overkill, but I was just following a 
> > > process here.
> > 
> > What process? I think we have that somewhere in the documentation that cover
> > letter for a single patch is not needed...
> 
> Documentation/process/submitting-patches.rst in the kernel sources, or
> https://docs.kernel.org/process/submitting-patches.html

Yes, it maybe not so clear but it actually tells you to choose between two:
- vanilla (latest tag), OR
- dedicated tree "for-next" (most use this, but some use other name for
  the branch for the next cycle).


-- 
With Best Regards,
Andy Shevchenko



