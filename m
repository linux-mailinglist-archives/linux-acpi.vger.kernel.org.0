Return-Path: <linux-acpi+bounces-5911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3808CB0C3
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 16:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73ADD2830E1
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F27F12FF7B;
	Tue, 21 May 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPQUBde1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8290E6E2AE;
	Tue, 21 May 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303195; cv=none; b=IFi8gqmdfJ7WCCw6b2N4rOykwlSuPtITkbLYD7SJwlJHTcYVz3yOidHdA2H4mOFu3KCMgU9Da1T2S7FaepsdorY6dPOslBhF7nOTMWNp8JbQuM5vH6CNaYe+yTGkXJs0uhZ5X8VqQoJRp1tbHtXQGnpg8nbm9oMwoVSRTegLA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303195; c=relaxed/simple;
	bh=0rV27fJz+qYDbWeUT9WapXNkA90Ko3P1Fuya2Vwd0H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtNeC459z5ey+d4lJwnVrZviZPpDp4M31T9kdhUEAsPc+YwazIASlRj0a3+G6iG7RECz+2a8o1ZYl3zz1JNXqsR+Z8Q7lEp+db1CkVBgKSJCPEh0xoAPsZpqjDuUeIq0iaYhuO9pPbNnqqRsphLyrNuz1t6W3wFHL4dg3KPuV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPQUBde1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716303194; x=1747839194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0rV27fJz+qYDbWeUT9WapXNkA90Ko3P1Fuya2Vwd0H0=;
  b=OPQUBde1MkWhy9YuSxukVj5tHEo1kM610sWk0Md5F0LtvPnWXOo6J35i
   YT3UTa6te1NPxlsBa4LJ//Arcq41Js9WFhjUYD9g4vZhTJUt1fK4t/uNe
   /QV0OvR/idPmotgqXuZxp3Pb3UYvzThvf4j+UfMzDHEImjleiQKHPoH3+
   RKiAS+wHbd3GcKBn0iyoZiRm5iT1eqzrHUorrFN8uHraOozU8vL/UUI1q
   UABlkxOU6g04l/j96Yn0yumFHhXCZDjnA2+KpnWxjEUdpMO7Ly/xPE+Sf
   960YX83Tjr9zRu226iDpMOIKV6CHTxhdyPf03wN0VvS+valP4vQOuI1PL
   A==;
X-CSE-ConnectionGUID: 5cqA6tulTheTS226wY8V6Q==
X-CSE-MsgGUID: tfkPb2H2SWqO8ltbjleTpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12618693"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12618693"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 07:53:13 -0700
X-CSE-ConnectionGUID: nPFACJVJSbienTlLOVffiQ==
X-CSE-MsgGUID: R0BibKmTQ2iA/P8rbHN3Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="37908417"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 07:53:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9QrT-00000009gf6-1F5U;
	Tue, 21 May 2024 17:53:07 +0300
Date: Tue, 21 May 2024 17:53:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Laura Nao <laura.nao@collabora.com>,
	mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
	brgl@bgdev.pl, kernel@collabora.com, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] gpiolib: acpi: Move ACPI device NULL check to
 acpi_can_fallback_to_crs()
Message-ID: <Zky1UgJSf_ybRMOI@smile.fi.intel.com>
References: <20240513095610.216668-1-laura.nao@collabora.com>
 <ZkHlLLLoagsYlll7@smile.fi.intel.com>
 <b20b567f-ce96-45e8-aab7-29768f8313f5@leemhuis.info>
 <Zkyo6DL7NQltLLNr@smile.fi.intel.com>
 <c10a77b6-e7b1-43c0-af38-79092eeb34f1@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10a77b6-e7b1-43c0-af38-79092eeb34f1@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 21, 2024 at 04:26:32PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 21.05.24 16:00, Andy Shevchenko wrote:
> > On Tue, May 21, 2024 at 12:01:17PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> On 13.05.24 12:02, Andy Shevchenko wrote:
> >>> On Mon, May 13, 2024 at 11:56:10AM +0200, Laura Nao wrote:
> >>>> Following the relocation of the function call outside of
> >>>> __acpi_find_gpio(), move the ACPI device NULL check to
> >>>> acpi_can_fallback_to_crs().
> >>>
> >>> Thank you, I'll add this to my tree as we have already the release happened.
> >>> I will be available after v6.10-rc1 is out.
> >>
> >> Hmm, what exactly do you mean with that? It sounds as you only want to
> >> add this to the tree once -rc1 is out -- which seems likely at this
> >> point, as that patch is not yet in -next. If that's the case allow me to
> >> ask: why?
> > 
> > Because:
> > 
> > - that's the policy of Linux Next (do not include what's not supposed to be
> >   merged during merge window), Cc'ed to Stephen to clarify, it might be that
> >   I'm mistaken
> > 
> > - the process of how we maintain the branches is to have them based on top of
> >   rc1 (rarely on other rcX and never on an arbitrary commit from vanilla

Note, besides above reasons the one is (was in this case as you noticed)
to wait until dependencies laid down in the upstream.

> Something like that is what I feared. And yes, some of that is true. But
> the patch in this thread contains a Fixes: tag for commit 49c02f6e901c
> which was merged during this merge window -- and that patch thus ideally
> should (ideally after some testing in -next) be merge during the merge
> window as well, to ensure the problem does not even hit -rc1.

> That's something a lot of subsystem master all the time. The scheduler
> for example:
> 
> https://git.kernel.org/torvalds/c/6e5a0c30b616bfff6926ecca5d88e3d06e6bf79a
> https://git.kernel.org/torvalds/c/8dde191aabba42e9c16c8d9c853a72a062db27ee
> 
> Other subsystems (perf, x86, net) do this, too. Not sure how they
> exactly do that with git; I think some (most?) have a dedicated -fixes
> branch (based on master and fast-forwarded after Linus merged from it)
> for that is also included in next in parallel to their "for-next"
> branch.  Stephen will know for sure.

This part of the kernel is not so critical as scheduler, but in general I agree
that sooner we get this in is better. The other thing, that we have 3 regressions
now for very this code. And some of them are still under discussions.

Wouldn't be better to gather all fixes and send a bunch via proper process
after rc1? This will ensure that everything we know about is covered properly
and processed accordingly,

In broader way, the process should be amended if you want a fast track for
the patches like this. I'm on the second level here, Bart is the maintainer
who sends PRs directly to Linus. Do we have anything like this?

Ideally I should be able to create a tag based on an (arbitrary) commit from
vanilla that is in the time of merge window and send it directly to Linus
(with the respective maintainer's Ack). That's what I call a fast track.
Maybe you can introduce and document a such?

-- 
With Best Regards,
Andy Shevchenko



