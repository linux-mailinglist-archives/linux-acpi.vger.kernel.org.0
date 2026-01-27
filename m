Return-Path: <linux-acpi+bounces-20646-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL6LO+uCeGmqqgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20646-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 10:18:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F5F9199D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 10:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11BC53058BB4
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F694333440;
	Tue, 27 Jan 2026 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lu6LiKLz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E634331A71;
	Tue, 27 Jan 2026 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769505274; cv=none; b=SnmYj79KTVYolvFAU0qxxs3YUpvvRi7yfn7sEEH/X5NLXkgHtuac9vFNXiKPStqXZgCuvB/qt2aFIv+3XiEAuSREwFqbiOe/OWDUZGU3ZCmamREF3fixH+RWampltJ5Zd+QpTJTgq1bO54WBt0lBvVwZYs6yA0R6KADy+LOl7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769505274; c=relaxed/simple;
	bh=wA5rbgiEwVVcceiEGmwj1C3uIIzfloDmcPxun/ZMq80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmseuPylGvAwd7Tv1S+YJlZubjYpccMlwpq6r207YFOi876Wn8yarMRDPZaXGVrT/w6w/OcdYchU0UjtPBRnIm5/Gtc45B2VradDqG2DR4uiDd3r/2h6KFGKndYARocY6H+/hh8iqgHS9cqr3IbLWFDQGJuil9bnBzInkP2T9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lu6LiKLz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769505273; x=1801041273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wA5rbgiEwVVcceiEGmwj1C3uIIzfloDmcPxun/ZMq80=;
  b=lu6LiKLz2FAqdJ8qRl8wGNMUmYzx8bwBFUhk48E2vFPNdj/AjQaZKOdv
   DNFupMFM9aM/isHPI67ADsKYw8B+M572J7Q5Jbx2Ts3klNn1trI55hblG
   dRezsan8xCXjQuJMeRU58uzaz0/fp00Y3Px8Zc3w6t7w/8bvrbve/BYC2
   oSc39rLMtYm7yp18Vc7kj7pR3mSPA3obE3mik8jeaYf/YqIP/krpTpTE6
   VTY7MgDnKv05CyP2t1cxU7hpxbopJEf8BfUXV8ztPqK4SonvYx+sfkZkS
   kHOwK62BRKhbB0cMsRuhuffpdZe6BjLCx9laiakUlUfMerVzlD10oNutr
   Q==;
X-CSE-ConnectionGUID: GCvdEQlTQvy4+YLMOYZF5A==
X-CSE-MsgGUID: KKrWwR68RK+OrnIa6aQ96Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="82063815"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="82063815"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 01:14:33 -0800
X-CSE-ConnectionGUID: eZ8T0zA0QuOuSlCk9I6C5g==
X-CSE-MsgGUID: edZl9nkTR1mG1M50Et7Lhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="207048789"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 01:14:30 -0800
Date: Tue, 27 Jan 2026 11:14:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Denis Sergeev <denserg.edu@gmail.com>, westeri@kernel.org,
	linusw@kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] gpiolib: acpi: use BIT_ULL() for u64 mask in address
 space handler
Message-ID: <aXiB80UJamq0oeDr@smile.fi.intel.com>
References: <20260126035914.16586-1-denserg.edu@gmail.com>
 <20260127080759.GY2275908@black.igk.intel.com>
 <CAMRc=MdRQzgSNorb9rHtAGWYPOK7t2o6q2gP9FLB3ECsvgVrAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdRQzgSNorb9rHtAGWYPOK7t2o6q2gP9FLB3ECsvgVrAQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,gmail.com,kernel.org,vger.kernel.org,linuxtesting.org];
	TAGGED_FROM(0.00)[bounces-20646-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtesting.org:url,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 54F5F9199D
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:06:33AM +0100, Bartosz Golaszewski wrote:
> On Tue, Jan 27, 2026 at 9:08 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Mon, Jan 26, 2026 at 06:59:14AM +0300, Denis Sergeev wrote:
> > > The BIT() macro uses unsigned long, which is 32 bits on 32-bit
> > > architectures. When iterating over GPIO pins with index >= 32,
> > > the expression (*value & BIT(i)) causes undefined behavior due
> > > to shifting by a value >= type width.
> > >
> > > Since 'value' is a pointer to u64, use BIT_ULL() to ensure correct
> > > 64-bit mask on all architectures.
> > >
> > > Found by Linux Verification Center (linuxtesting.org) with Svace.
> > >
> > > Fixes: 2c4d00cb8fc5 ("gpiolib: acpi: Use BIT() macro to increase readability")
> > > Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
> >
> > Reviewed-by: Mika Westerberg <westeri@kernel.org>
> 
> I'll queue this for v6.19-rc8.

This is half-baked solution... But okay, let's shut up at least the stream of
this type of "fixes" in this file.

-- 
With Best Regards,
Andy Shevchenko



