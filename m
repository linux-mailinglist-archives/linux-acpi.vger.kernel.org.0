Return-Path: <linux-acpi+bounces-5916-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D588CB275
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 18:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D48283834
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CF22E620;
	Tue, 21 May 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhKR62PI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058128DA0;
	Tue, 21 May 2024 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310209; cv=none; b=bKlH94vAVBy6oJ+Gx0MLD9+Z8NVdAXzlyjyJckyky8aYrSiOqCUKVNY2JFfxvKxjvqUj2rOZvTQoF/Tf+214zDjP92i9t+Al+Z7SvjEMu7Al447UCaRSavNNsGGXMj1QluTbjhhwT0pYQ5BcDOxShkAbaWmQdzGd19QS7d1gaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310209; c=relaxed/simple;
	bh=aX8ee/F7iuxv4JaXn0INGjz6humhOGXV3AkccPo5LiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3CWmylMzkUd8KXSte5Y2faRRnmUFXS5xTctjpri4d3kOAFzkYK/fDLGbM5dLVMkJ0DMDYbK7qG8oDUPotXtRVVip0KMzYpUF915EVceuLAOnAXTcNfb3u0GO78S1gbaQYxg9V7X7ScEYyvFDvseJ+QNf2BA7gGoC3IE+GjnaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhKR62PI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716310208; x=1747846208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aX8ee/F7iuxv4JaXn0INGjz6humhOGXV3AkccPo5LiQ=;
  b=bhKR62PI93Bp+R131V3ZU13XRcEO1rPZAqd+r/8gFFsAyiKKIwLkrZ32
   u7pxfKCYZf2CkCrog/Miebvpwph+47rsO/dDDzFFXxW6UYW0ssdG/txtv
   nl990KMk4HBrEA8laVF2MOYF6X/5hF+JbhTxik7P282B3w8LheUT446cC
   TtLEz2QqO+WEsQENlTGPi3TBm121gSKKlRuHzMKHC3AQF9rDPQqjrm0S9
   t/WOjLRfreoxzsene/R6ixO1mYnK7SI43YOPbGrbfHffFPV5++0NT6lxm
   e1msnHrhIbA/UtkdEj0DJvtFGNG0aoqIe3zN7hXO0qUG4z4Sq1P9VGImD
   g==;
X-CSE-ConnectionGUID: DNiqadI1Q36FS2SwdpfinQ==
X-CSE-MsgGUID: i5DX3DfFTtSMHHUrETxnUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12370418"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12370418"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 09:50:08 -0700
X-CSE-ConnectionGUID: IWaBplqBTrCn4gS1fIWOeQ==
X-CSE-MsgGUID: HDnW4Zw3TUOChCy9F83uTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="33596113"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 09:50:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9Sgb-00000009iWD-1uSr;
	Tue, 21 May 2024 19:50:01 +0300
Date: Tue, 21 May 2024 19:50:01 +0300
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
Message-ID: <ZkzQuWmLZGhIQl-2@smile.fi.intel.com>
References: <20240513095610.216668-1-laura.nao@collabora.com>
 <ZkHlLLLoagsYlll7@smile.fi.intel.com>
 <b20b567f-ce96-45e8-aab7-29768f8313f5@leemhuis.info>
 <Zkyo6DL7NQltLLNr@smile.fi.intel.com>
 <c10a77b6-e7b1-43c0-af38-79092eeb34f1@leemhuis.info>
 <Zky1UgJSf_ybRMOI@smile.fi.intel.com>
 <4f1bcc8b-1795-4e3c-90a6-742cd8443396@leemhuis.info>
 <Zky9bovo_99LwDfY@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zky9bovo_99LwDfY@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 21, 2024 at 06:27:42PM +0300, Andy Shevchenko wrote:
> On Tue, May 21, 2024 at 05:14:07PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > On 21.05.24 16:53, Andy Shevchenko wrote:
> > > On Tue, May 21, 2024 at 04:26:32PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > >> On 21.05.24 16:00, Andy Shevchenko wrote:
> > >>> On Tue, May 21, 2024 at 12:01:17PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > >>>> On 13.05.24 12:02, Andy Shevchenko wrote:
> > >>>>> On Mon, May 13, 2024 at 11:56:10AM +0200, Laura Nao wrote:

...

> > >>>>> Thank you, I'll add this to my tree as we have already the release happened.
> > >>>>> I will be available after v6.10-rc1 is out.
> > >>>>
> > >>>> Hmm, what exactly do you mean with that? It sounds as you only want to
> > >>>> add this to the tree once -rc1 is out -- which seems likely at this
> > >>>> point, as that patch is not yet in -next. If that's the case allow me to
> > >>>> ask: why?
> > >>>
> > >>> Because:
> > >>>
> > >>> - that's the policy of Linux Next (do not include what's not supposed to be
> > >>>   merged during merge window), Cc'ed to Stephen to clarify, it might be that
> > >>>   I'm mistaken
> > >>>
> > >>> - the process of how we maintain the branches is to have them based on top of
> > >>>   rc1 (rarely on other rcX and never on an arbitrary commit from vanilla
> > > 
> > > Note, besides above reasons the one is (was in this case as you noticed)
> > > to wait until dependencies laid down in the upstream.
> > 
> > Well, that can be a reason, sure. But I still wonder if Linus would have
> > preferred to get 49c02f6e901c and this fix for it in the same pull.
> > Sure, adding this fix would have been a late addition, but when it is a
> > fix and mentioned in the PR that from what I can see is no problem at
> > all for him.
> 
> 
> > >> Something like that is what I feared. And yes, some of that is true. But
> > >> the patch in this thread contains a Fixes: tag for commit 49c02f6e901c
> > >> which was merged during this merge window -- and that patch thus ideally
> > >> should (ideally after some testing in -next) be merge during the merge
> > >> window as well, to ensure the problem does not even hit -rc1.
> > > 
> > >> That's something a lot of subsystem master all the time. The scheduler
> > >> for example:
> > >>
> > >> https://git.kernel.org/torvalds/c/6e5a0c30b616bfff6926ecca5d88e3d06e6bf79a
> > >> https://git.kernel.org/torvalds/c/8dde191aabba42e9c16c8d9c853a72a062db27ee
> > >>
> > >> Other subsystems (perf, x86, net) do this, too. Not sure how they
> > >> exactly do that with git; I think some (most?) have a dedicated -fixes
> > >> branch (based on master and fast-forwarded after Linus merged from it)
> > >> for that is also included in next in parallel to their "for-next"
> > >> branch.  Stephen will know for sure.
> > > 
> > > This part of the kernel is not so critical as scheduler, but in general I agree
> > > that sooner we get this in is better.
> > 
> > Side note: with all those CIs that "sooner" became more important I'd
> > say, as I frequently see multiple CI systems running into and bisecting
> > problems -- which humans then look into and report, which is a waste of
> > time.
> 
> Oh, yes, our processes are completely non-ideal. Once I tried to micro-optimize
> the way of Cc'ing people for the patches to avoid waste of resources and you
> know what? This is a dead end. I gave up, so I don't care anymore and don't
> buy this argument anymore. If people are serious about this, they should be
> serious consistently.
> 
> For your reference:
> 20240423132024.2368662-1-andriy.shevchenko@linux.intel.com
> 
> > > The other thing, that we have 3 regressions
> > > now for very this code. And some of them are still under discussions.
> > > 
> > > Wouldn't be better to gather all fixes and send a bunch via proper process
> > > after rc1? 
> > 
> > Depends on the situation. As a general approach I'd say no, but there
> > definitely can be situations where that is wise.
> > 
> > > This will ensure that everything we know about is covered properly
> > > and processed accordingly,
> > > 
> > > In broader way, the process should be amended if you want a fast track for
> > > the patches like this. I'm on the second level here, Bart is the maintainer
> > > who sends PRs directly to Linus. Do we have anything like this?
> > 
> > Pretty sure Linus wants maintains to just fast-track things when needed
> > by sending an additional PR; he multiple times said that this is not a
> > problem.
> > 
> > But there is a way to fast track things: just ask Linus to pull a patch
> > from the list (e.g. in a reply to the patch while CCIng tim). He
> > multiple times said this is no problem for him, unless it becomes the
> > norm. This is documented in
> > Documentation/process/handling-regressions.rst /
> > https://docs.kernel.org/process/handling-regressions.html
> 
> "For urgent regressions, consider asking Linus to pick up the fix straight from
> the mailing list: he is totally fine with that for uncontroversial fixes.
> Ideally though such requests should happen in accordance with the subsystem
> maintainers or come directly from them."
> 
> The first thing I'm not so comfortable with is that Bart as a subsystem
> maintainer will be by-passed. The second one, is the metrics of urgency.
> I can assume that something from a TIP tree is really urgent and they
> even have established fast track for ages. But why do you think this fix
> is of the same level of urgency? I haven't found in the documentation
> the checklist which I can count numbers, compare with a table and have
> a clear answer "yes, I have do it".

FWIW, I have just sent a PR to Linus and GPIO maintainers with this one
included. Hopefully everybody is now happy.

-- 
With Best Regards,
Andy Shevchenko



