Return-Path: <linux-acpi+bounces-21163-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHd0NPBKn2lEZwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21163-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 20:18:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 798BD19CA84
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 20:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B641930090B7
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 19:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315B92D3ED2;
	Wed, 25 Feb 2026 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mftJYv6N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812042BE644;
	Wed, 25 Feb 2026 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772047086; cv=none; b=uCg8Yxm2vDh51w+CSGEuwJn6rVUnzmzpta8iccl/RLC5A2A8KdNXH803cFV2C1WsdxHasxhtvQl3aptfB8DDSW9U1smZ2FCNahp4Zlk3g6OGoRaTQVVuvRCVBrKZo5nZZhMX1Yu47ZAs6RJkfHB4o6p1TUGqzhCFCl/bGbPcW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772047086; c=relaxed/simple;
	bh=vRI+TIfMM43B2wJ1QoUqWhWEMmxSYNbHtXEcyc854xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zrny014/PSUCEX48iFAhlpwvWcvH3z1ki7ObyXXWpwgCiyq3w4V89rof1cbdttwUiYHnUbRdngI9+Z8IvZYN0CSDnHupHJ8CmtR+4RhM7Eke1vLR/u3t8//ymk8RIWBKmPfKHvH7IPwebWVKrdVYuq2UTdgtgx5wwtpqAb+2ccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mftJYv6N; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772047084; x=1803583084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vRI+TIfMM43B2wJ1QoUqWhWEMmxSYNbHtXEcyc854xc=;
  b=mftJYv6NXwkARqCjbHMNmnk7uzh/US7BFC5yRMXRFPycI1Ysf24gWbX+
   garyrQcJt1nUqd6owM7GJTmSg0MHarm0K3Ir5QEb7AOLFqaIxPCNQ60KN
   NpnJfKewY/ZaAcW+wwQvpV8uS+A/65DFvTOPUFGhj5bubvfvvH9BC+h8a
   IqfYdyebkuq7FK3rsdcHwxuhkO+jIrJZV0ppxNg+iz+JaQSCjF/36ZFei
   2bAB3cmKv6oL0G6MTWRONN+8IjCjkhcy1W7+w2Gfsc7Bs8rNdn34gVNFf
   iaeHGwWtdBQuHGCZvZ2YtbcqPFb4pspBQQ9VeEp5Bv9BtDACreeo4mx1G
   A==;
X-CSE-ConnectionGUID: ewd2hrHWQ26FQa3XGHehZA==
X-CSE-MsgGUID: l3wf02T6SIaLLH2uKZw54g==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="98567912"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="98567912"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 11:18:04 -0800
X-CSE-ConnectionGUID: 0ytlslcMS5W2BBs9es2p5A==
X-CSE-MsgGUID: EcEoiAwdTFqCYicmAiS/7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="239325732"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 11:18:02 -0800
Date: Wed, 25 Feb 2026 21:17:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mike Isely at pobox <isely@pobox.com>
Cc: mike.isely@cobaltdigital.com, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] software node: Use-after-free fix in
 drivers/base/swnode.c
Message-ID: <aZ9K56Q_NHmAYmeu@smile.fi.intel.com>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com>
 <aZ7E7q6vdUHW_Wj6@smile.fi.intel.com>
 <04eebe7b-0f88-2122-eeef-568117bb8235@isely.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04eebe7b-0f88-2122-eeef-568117bb8235@isely.net>
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
	FREEMAIL_CC(0.00)[cobaltdigital.com,gmail.com,linux.intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21163-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cobaltdigital.com:email]
X-Rspamd-Queue-Id: 798BD19CA84
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:59:56PM -0600, Mike Isely wrote:
> On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > On Tue, Feb 24, 2026 at 01:19:21PM -0600, mike.isely@cobaltdigital.com wrote:

...

> > > This was detected in kernel 6.12, verified also in kernel 6.6.  Visual
> > > inspection in 6.19.3 source (the latest as of right now) shows the
> > 
> > The latest is v7.0-rc1 as of time of the topic message.
> 
> I actually meant the latest release.  Guess I should have checked the 
> latest release candidate on the off-chance that it might have been 
> addressed.

It is probably not, but the idea to check against latest tag in the vanilla
repository. v6.19.3 is not even vanilla, it's stable kernel.

> > > same issue.  The nearly trivial fix was verified in 6.12.  While this
> > > patches against 6.19.3, IMHO this is a candidate for all LTS kernels.
> > 
> > Thanks for the contribution, usually for a single patch there is no need
> > in cover letter. The comment block can handle this (the place after cutter
> > '---' line in the message with a patch).
> 
> Yeah, a separate cover letter is overkill, but I was just following a 
> process here.

What process? I think we have that somewhere in the documentation that cover
letter for a single patch is not needed...

-- 
With Best Regards,
Andy Shevchenko



