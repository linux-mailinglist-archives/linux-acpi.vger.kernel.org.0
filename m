Return-Path: <linux-acpi+bounces-14456-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D648BADF9DE
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 01:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771CC3BF0FA
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 23:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF822284663;
	Wed, 18 Jun 2025 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHaBO13O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F00027E046;
	Wed, 18 Jun 2025 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750290240; cv=none; b=rAhp0KmaR3pd0tgIjXRpo+JQl9yq5pY+Zv/kIg+lX2Eae314n/ASbAxVTymsVOdau2UXoJ4oaup4Oi7HZvWJH5Tx6a9BQdTAdh0MNAR0coQmCxRb+blRXsn7WMRffl/cCOmdz0lWf6D2vlPnm0ifk5t6+qAQTFgibevK2o+DEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750290240; c=relaxed/simple;
	bh=aPgD+c9dFhS0m4Oykg90MXCZJy8+pTxqDLWxOCDrVSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u85G+DU4xruqZ4jwL9Kmohu67Q8YsuSsFwemLkp/AwjRaPcT8saxKgBNfMeGvM4eZ0qCe9X7mXMtNTFV9AQNqUzNbq11g/Km8/jNuxAiyosAlOADW9/LtMzK+r5xObjoAPloVur6MWZoD23S0xNomq7fpLwaYrune+g/e/3sUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHaBO13O; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750290239; x=1781826239;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aPgD+c9dFhS0m4Oykg90MXCZJy8+pTxqDLWxOCDrVSQ=;
  b=jHaBO13Op+bIzzvpC7QfcY1MeTfOFAj/U/4u2ZsGn1se9+d8I6w9vGrn
   Qk8sH4+vP8o48tBdh9ip22bPUjoe0QImLgmVnq/C2dgCr2YSiWM/etDNr
   qAB5bqfZtGkCoxK58SgahkrVolyS4WT24pYSunYDv9Ep9l1DoLqQ1PMJ7
   AEFH+6QbV2rCQOgD3b4bmp6tulbPkHkawDn+OJIx+hpb0TIF+ZdLXzM0X
   bIjtT6vjNHxJjPalEFZaJoea1sQNa51g6Y0Y+G00HvVrcRAF0OIlAEL3q
   /z7WgZAVBTC10q1Z6e0VJ6nCUw4jU+hN+9+qvxbFnj7Zo9K/tqsptx0RI
   Q==;
X-CSE-ConnectionGUID: uYdUPrivRhemNBwMEv0xkg==
X-CSE-MsgGUID: L7PTv8dgQlKyvLYjb1CHmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52624043"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="52624043"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:43:58 -0700
X-CSE-ConnectionGUID: SwenbBcPSzCbqMNkWPsVhQ==
X-CSE-MsgGUID: X0MtmjRgREWiLkKrXY3Osw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="181363863"
Received: from tcorban-mobl1.amr.corp.intel.com (HELO [10.125.34.69]) ([10.125.34.69])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:43:58 -0700
Message-ID: <bcd3848d-54dd-453e-b0b5-91cb72160645@linux.intel.com>
Date: Wed, 18 Jun 2025 16:43:51 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Benjamin.Cheatham@amd.com,
 Jonathan.Cameron@huawei.com, dakr@kernel.org, dan.j.williams@intel.com,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, rafael@kernel.org,
 sudeep.holla@arm.com, Dan Carpenter <dan.carpenter@linaro.org>,
 Kees Cook <kees@kernel.org>
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
 <2025061446-wriggle-modulator-f7f3@gregkh>
 <a3a08e5d-bfea-4569-8d13-ed0a42d81b2a@linux.intel.com>
 <2025061546-exile-baggage-c231@gregkh>
Content-Language: en-GB
From: Marc Herbert <marc.herbert@linux.intel.com>
In-Reply-To: <2025061546-exile-baggage-c231@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2025-06-15 20:35, Greg KH wrote:
> On Sat, Jun 14, 2025 at 07:53:34AM -0700, Marc Herbert wrote:
>>> the kernel relies on this not being "optimized away" by the compiler
>>> in many places.
>>
>> I think "undefined behavior" is the more general topic, more important
>> than null pointer checks specifically?
> 
> Is this really "undefined behaviour"? 

This is apparently debatable:

https://stackoverflow.com/questions/26906621/does-struct-name-null-b-cause-undefined-behaviour-in-c11

Also note: https://blog.llvm.org/2011/05/what-every-c-programmer-should-know.html

  Dereferencing a NULL Pointer: contrary to popular belief,
  dereferencing a null pointer in C is undefined. [...] NULL pointer
  dereferences being undefined enables a broad range of optimizations
  [...]  This significantly punishes scheduling and other
  optimizations. In C-based languages, NULL being undefined enables a
  large number of simple scalar optimizations that are exposed as a
  result of macro expansion and inlining.

> There are a lot of things that the kernel requires for a compiler to
> be able to build it, and this is one of those things, it can't do this
> type of "optimization" and expect the output to actually work
> properly.

According to page 2, this type of optimizations exists for a reason and
makes a real impact
https://blog.llvm.org/2011/05/what-every-c-programmer-should-know_14.html

  While this is intentionally a simple and contrived example, this sort
  of thing happens all the time with inlining: inlining a function often
  exposes a number of secondary optimization opportunities. This means
  that if the optimizer decides to inline a function, a variety of local
  optimizations can kick in, which change the behavior of the code. This
  is both perfectly valid according to the standard, and _important for
  performance in practice_. [emphasis mine]

In other words, by turning this off unconditionally at the global level,
the kernel could actually lose (surprise!) some performance.

> Again, that's not the issue here.  The issue is that we rely on this
> type of optimization to not happen in order to work properly.

I'm interested in examples where this deviation is actually required, if
anyone can think of some from the top of their head. But in this
particular case it is not required because it's trivial and enough to
swap the two lines and check the pointer first. Even if the language
lawyers eventually agree that this particular case is not UB (for
instance: because it does not dereference "for real"), I still miss the
value of involving lawyers (or tripping some analyzers) at all in
situations where this can be avoided so easily. There are plenty enough
complex situations already, no need for even more C torture :-)


> So no need to "fix" anything here except perhaps the compiler for not
> attempting to do foolish things like this :)

It looks foolish when assuming that C is some sort of low-level language
a.k.a. "portable assembly", which it stopped being a long time ago;
for performance reasons:

https://queue.acm.org/detail.cfm?id=3212479
https://stefansf.de/post/pointers-are-more-abstract-than-you-might-expect/

Does this mean C has evolved into some hybrid monster good at neither
low-level nor high-level stuff? I think yes.

>>> If "tooling" trips over stuff like this, then we should fix the tooling
>>
>> Because of its old age, many quirks and limitations, C needs and has a
>> pretty large number of external "tools": static and run-time analyzers,
>> coding rules (CERT, MISRA,...) and what not. It's not realistic to "fix"
>> them all so they all "support" undefined behaviors like this one.
> 
> If they wish to analize Linux, then yes, they do need to be fixed to
> recognize that this is not an issue for us.  There is no requirement
> that we have that _all_ tools must be able to parse our source code.

Not sure why I wrote "all", this should have been "any".

Undefined behavior is in the "Most Wanted" list of pretty much all these
tools for obvious reasons.

Most these tools want to make C _in general_ less broken; not any specific
C project in particular. If some projects prefer being left out and use
some project-specific C dialect instead then it's their loss.



