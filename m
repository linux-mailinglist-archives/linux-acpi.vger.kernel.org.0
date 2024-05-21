Return-Path: <linux-acpi+bounces-5913-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 841708CB158
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 17:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB02AB23A38
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 15:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29339145326;
	Tue, 21 May 2024 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMlO/VpB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78F1482FD;
	Tue, 21 May 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305271; cv=none; b=QIiOAP7WpGZFr/tW7O4dZr87RJXBGhnfSVdb6diBi540CMi7tGcGy1mbH8gQavNiPlhjj0o3CYn5+lTidEzrx2+XXtw6w88keSJljwMyd0qHb9biz4bMJHyFze0T38rqsPfXd9F7l8Fn9ZdfacQtyEDdFN4IsD0NXha9WTZT7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305271; c=relaxed/simple;
	bh=IC9nTsYHcZ8MNeWk3KQE+CAXDWKcffMouhowkGoKjfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc2QoSPTITJAGUbhVt9TLaZdHDcQRT3uXIK7qjrwj2tBIjjIxvIKsAFNOIDHE1P2hJnbcKREGLKncrta+VVG5CdChnuOHsmYKgcuOi0P3HahJP3Fh2rZsYMhqfJP9wIuWAsCsAaeNfudEtizCn7+G8CD0H1xW4dhZHMIMjMI1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMlO/VpB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716305270; x=1747841270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IC9nTsYHcZ8MNeWk3KQE+CAXDWKcffMouhowkGoKjfY=;
  b=TMlO/VpBXbUNbmmujj81+GBH1Ukpc+0aSA9ZJq8LUhjPv15JatloYqUD
   QHbtdkj7QKBWAEy17Zjye8oIu29illWrEmAhhQ0z4uHs/qqqGs/HiH6v2
   0xDtQtD5izIg4p791eGaTqDn1wvucWbynZigWMkGY2twN+j7MzB4r5poQ
   JCuno8GIVacR0VFGmKfw6iXX7En63uDZOy86ft3uA2g0GGGXWDSd6sGK/
   eSuKjmH/uJnYtAiWHeENnB6v/bCFiqTHndKYtOfkDUoB6SGmWX777jjyl
   zSXDvNITNPJpgKbzEZLVkZaY71a0cpioK1mOUssOF36FyMf3kCLnI1dKx
   A==;
X-CSE-ConnectionGUID: Gbo8Gvk9SPWPoL0tmMN1Lw==
X-CSE-MsgGUID: 1zvlGcZdT9y289mhBp6Sdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23178841"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="23178841"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 08:27:49 -0700
X-CSE-ConnectionGUID: aNk5wQgXSyu7uP8s7KJKRA==
X-CSE-MsgGUID: tpA2RpQhQh6tfqJ//cnHvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="70372293"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 08:27:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9ROw-00000009hE4-3F9b;
	Tue, 21 May 2024 18:27:42 +0300
Date: Tue, 21 May 2024 18:27:42 +0300
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
Message-ID: <Zky9bovo_99LwDfY@smile.fi.intel.com>
References: <20240513095610.216668-1-laura.nao@collabora.com>
 <ZkHlLLLoagsYlll7@smile.fi.intel.com>
 <b20b567f-ce96-45e8-aab7-29768f8313f5@leemhuis.info>
 <Zkyo6DL7NQltLLNr@smile.fi.intel.com>
 <c10a77b6-e7b1-43c0-af38-79092eeb34f1@leemhuis.info>
 <Zky1UgJSf_ybRMOI@smile.fi.intel.com>
 <4f1bcc8b-1795-4e3c-90a6-742cd8443396@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f1bcc8b-1795-4e3c-90a6-742cd8443396@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 21, 2024 at 05:14:07PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 21.05.24 16:53, Andy Shevchenko wrote:
> > On Tue, May 21, 2024 at 04:26:32PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> On 21.05.24 16:00, Andy Shevchenko wrote:
> >>> On Tue, May 21, 2024 at 12:01:17PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>>> On 13.05.24 12:02, Andy Shevchenko wrote:
> >>>>> On Mon, May 13, 2024 at 11:56:10AM +0200, Laura Nao wrote:

...

> >>>>> Thank you, I'll add this to my tree as we have already the release happened.
> >>>>> I will be available after v6.10-rc1 is out.
> >>>>
> >>>> Hmm, what exactly do you mean with that? It sounds as you only want to
> >>>> add this to the tree once -rc1 is out -- which seems likely at this
> >>>> point, as that patch is not yet in -next. If that's the case allow me to
> >>>> ask: why?
> >>>
> >>> Because:
> >>>
> >>> - that's the policy of Linux Next (do not include what's not supposed to be
> >>>   merged during merge window), Cc'ed to Stephen to clarify, it might be that
> >>>   I'm mistaken
> >>>
> >>> - the process of how we maintain the branches is to have them based on top of
> >>>   rc1 (rarely on other rcX and never on an arbitrary commit from vanilla
> > 
> > Note, besides above reasons the one is (was in this case as you noticed)
> > to wait until dependencies laid down in the upstream.
> 
> Well, that can be a reason, sure. But I still wonder if Linus would have
> preferred to get 49c02f6e901c and this fix for it in the same pull.
> Sure, adding this fix would have been a late addition, but when it is a
> fix and mentioned in the PR that from what I can see is no problem at
> all for him.


> >> Something like that is what I feared. And yes, some of that is true. But
> >> the patch in this thread contains a Fixes: tag for commit 49c02f6e901c
> >> which was merged during this merge window -- and that patch thus ideally
> >> should (ideally after some testing in -next) be merge during the merge
> >> window as well, to ensure the problem does not even hit -rc1.
> > 
> >> That's something a lot of subsystem master all the time. The scheduler
> >> for example:
> >>
> >> https://git.kernel.org/torvalds/c/6e5a0c30b616bfff6926ecca5d88e3d06e6bf79a
> >> https://git.kernel.org/torvalds/c/8dde191aabba42e9c16c8d9c853a72a062db27ee
> >>
> >> Other subsystems (perf, x86, net) do this, too. Not sure how they
> >> exactly do that with git; I think some (most?) have a dedicated -fixes
> >> branch (based on master and fast-forwarded after Linus merged from it)
> >> for that is also included in next in parallel to their "for-next"
> >> branch.  Stephen will know for sure.
> > 
> > This part of the kernel is not so critical as scheduler, but in general I agree
> > that sooner we get this in is better.
> 
> Side note: with all those CIs that "sooner" became more important I'd
> say, as I frequently see multiple CI systems running into and bisecting
> problems -- which humans then look into and report, which is a waste of
> time.

Oh, yes, our processes are completely non-ideal. Once I tried to micro-optimize
the way of Cc'ing people for the patches to avoid waste of resources and you
know what? This is a dead end. I gave up, so I don't care anymore and don't
buy this argument anymore. If people are serious about this, they should be
serious consistently.

For your reference:
20240423132024.2368662-1-andriy.shevchenko@linux.intel.com

> > The other thing, that we have 3 regressions
> > now for very this code. And some of them are still under discussions.
> > 
> > Wouldn't be better to gather all fixes and send a bunch via proper process
> > after rc1? 
> 
> Depends on the situation. As a general approach I'd say no, but there
> definitely can be situations where that is wise.
> 
> > This will ensure that everything we know about is covered properly
> > and processed accordingly,
> > 
> > In broader way, the process should be amended if you want a fast track for
> > the patches like this. I'm on the second level here, Bart is the maintainer
> > who sends PRs directly to Linus. Do we have anything like this?
> 
> Pretty sure Linus wants maintains to just fast-track things when needed
> by sending an additional PR; he multiple times said that this is not a
> problem.
> 
> But there is a way to fast track things: just ask Linus to pull a patch
> from the list (e.g. in a reply to the patch while CCIng tim). He
> multiple times said this is no problem for him, unless it becomes the
> norm. This is documented in
> Documentation/process/handling-regressions.rst /
> https://docs.kernel.org/process/handling-regressions.html

"For urgent regressions, consider asking Linus to pick up the fix straight from
the mailing list: he is totally fine with that for uncontroversial fixes.
Ideally though such requests should happen in accordance with the subsystem
maintainers or come directly from them."

The first thing I'm not so comfortable with is that Bart as a subsystem
maintainer will be by-passed. The second one, is the metrics of urgency.
I can assume that something from a TIP tree is really urgent and they
even have established fast track for ages. But why do you think this fix
is of the same level of urgency? I haven't found in the documentation
the checklist which I can count numbers, compare with a table and have
a clear answer "yes, I have do it".

-- 
With Best Regards,
Andy Shevchenko



