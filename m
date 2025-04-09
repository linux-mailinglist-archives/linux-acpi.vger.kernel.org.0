Return-Path: <linux-acpi+bounces-12896-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815BFA82379
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 13:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BBC188FE57
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 11:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205ED25D539;
	Wed,  9 Apr 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKhMMceC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F44184F
	for <linux-acpi@vger.kernel.org>; Wed,  9 Apr 2025 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197893; cv=none; b=SE+bV/xRxCMf/Uo3aK0ZrSbd6Cvk52NLLB/4zMTk7ROwHzIiRywJe1CrtwKHUQgIv2ywHDJV6JL/m5QoFVsZ0sH/B/kaCnjIZFvpsXHZdcMtFrFymyrYbRGaQmMMU8xxiGfcz6Wv7X7LHJCvhBOqeL2kwWAJjWHgjk0GDPrLMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197893; c=relaxed/simple;
	bh=VlxHjgymv1xCx3GZ+6C2YPfGDaXZhQ71SUFDZxN5C94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1kDLAtejOfiFKY1ThO7bm3amyJNF66+OVODSBaOU7TYcGjN4EYckeReBuujM1yWXJ817uqh/EBI4AN2rhxYUh7LT/3WKyUkWPI59z2AtPWRLdFa846GSqfm4IkNR/4a1jQF/0Quv+L7IIdgl4jo7Dlbevqz2uuCpijjAgQtZr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKhMMceC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744197891; x=1775733891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VlxHjgymv1xCx3GZ+6C2YPfGDaXZhQ71SUFDZxN5C94=;
  b=eKhMMceCu1YS2iybZHTujeyAis9fQ8S4VrNccf+GSWSDhwPzzEMVv2Qt
   u/R2AP6OiGeVrwGccPSrqFxn2BxJsjeoqsnJ2Qm+NGb6FZJuQuehkGFTR
   vqvc1OYydxGB/U+6GsZkuiNHb9fRh+se9EmcYCEYKaUwHHB7K71+TGY08
   b9CRYiL+BCWPMFzQD6eRZ5TH4AFP9pMHjlz7+YgkTknAjxwzGj+Z1X7CQ
   b0zfD1Y7/lOnvwMRqegMKbAc9GPk2hdfbMp2rXs7k5FR2xF50S0QlCoS8
   pvln850sCYNiLTZ7gMmjZf0egBy7Qpa+TagnqBkOYr28o2wgzSwwUHIy1
   w==;
X-CSE-ConnectionGUID: wjDnU1pmRau66KkI4hl7bg==
X-CSE-MsgGUID: muVepYv4R/O4d70KU07GGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="33273240"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="33273240"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 04:24:50 -0700
X-CSE-ConnectionGUID: sHwGelf5SX6NWrv/i561AQ==
X-CSE-MsgGUID: 8DSgyOmkScKZGZQckvBcLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="133433661"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 04:24:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u2TXx-0000000AiCw-3yNJ;
	Wed, 09 Apr 2025 14:24:45 +0300
Date: Wed, 9 Apr 2025 14:24:45 +0300
From: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To: "Dumbre, Saket" <saket.dumbre@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Moore, Robert" <robert.moore@intel.com>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>
Subject: Re: ACPICA compilation error on x86_64_defconfig (W=1 build)
Message-ID: <Z_ZY_UA7ypFzpT0t@smile.fi.intel.com>
References: <Z_Qd0x6bLSQjJ7Rw@smile.fi.intel.com>
 <CAJZ5v0j2Y3vPZhUGJmcWzn6esg9zv5an0KPEN4QfQuyGrd5=YQ@mail.gmail.com>
 <Z_Qeot7pps5Q4vx7@smile.fi.intel.com>
 <LV8PR11MB86980990221C597E01BAEB7980B52@LV8PR11MB8698.namprd11.prod.outlook.com>
 <LV8PR11MB8698978FFF89ACBEF253667680B52@LV8PR11MB8698.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV8PR11MB8698978FFF89ACBEF253667680B52@LV8PR11MB8698.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

GCC should ignore all clang specific pragmas as far as I know.

But this seems to me the not the best solution either. What code needs is to
have some refactoring to make sure the variable is used or not defined and used
at all. Unfortunately, I am not familiar with ACPICA to propose anything right
now, though.

On Tue, Apr 08, 2025 at 09:34:36PM +0300, Dumbre, Saket wrote:
> I am not sure about the Linux environment specifics like Andy described in the
> previous conversation, but if GCC or some other compiler throws an error in the
> code with #pragma for clang, then may I suggest using this instead:
> 
> #pragma clang diagnostic push
> #if defined(__clang__) && __clang__ >= n (replace n with the least version
> number which introduces this new warning type)
> #pragma clang diagnostic ignored "-Wunused-but-set-variable"
> #endif
> u32 num_carats;
> #pragma clang diagnostic pop
> 
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> From: Dumbre, Saket <saket.dumbre@intel.com>
> Sent: Tuesday, April 8, 2025 11:11 AM
> To: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Rafael J. Wysocki
> <rafael@kernel.org>
> Cc: Moore, Robert <robert.moore@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; linux-acpi@vger.kernel.org
> <linux-acpi@vger.kernel.org>; acpica-devel@lists.linux.dev
> <acpica-devel@lists.linux.dev>
> Subject: Re: ACPICA compilation error on x86_64_defconfig (W=1 build)
>  
> Hi Andy and Rafael,
> 
> This issue is a duplication of an Apple ecosystem-based (ARM + M-series micro
> architecture) ACPICA GitHub Issue, which I was waiting on a response from the
> contributor/submitter to move ahead to resolve it:
> https://github.com/acpica/acpica/issues/973
> 
> I don't see a platform specific file for Clang/LLVM in ACPICA (only for GCC and
> MSVC), so I think the worst-case untidy solution would be to locally patch this
> warning-turned-error by suppressing this warning type if the compiler is Clang/
> LLVM. 
> 
> It would look somewhat better to move that line all the way down after all the
> other definitions/declarations just before any execution line and wrap it with
> a #pragma something along the lines:
> 
> #pragma clang diagnostic push
> #pragma clang diagnostic ignored "-Wunused-but-set-variable"
> u32 num_carats;
> #pragma clang diagnostic pop
> 
> I am just not sure if this is the only place in the ACPICA code that generates
> this warning type and depending on the answer, this fix could be implemented at
> a wider/global scale, but please give this hacky fix a try and let me know if
> it resolves that. Thanks a lot! 
> 
> 
> Kind regards,
> 
> Saket Dumbre
> 
> 
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> From: Shevchenko, Andriy
> Sent: Monday, April 7, 2025 11:51 AM
> To: Rafael J. Wysocki
> Cc: Dumbre, Saket; Moore, Robert; Wysocki, Rafael J;
> linux-acpi@vger.kernel.org; acpica-devel@lists.linux.dev
> Subject: Re: ACPICA compilation error on x86_64_defconfig (W=1 build)
> 
> On Mon, Apr 07, 2025 at 08:49:41PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Apr 7, 2025 at 8:47 PM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > >
> > > v6.15-rc1 (but seems older should also be problematic) fails to compile by
> > > Clang 19 with `make W=1`.
> > >
> > >   CC      drivers/acpi/acpica/nsaccess.o
> > >   drivers/acpi/acpica/nsaccess.c:295:6: error: variable 'num_carats' set
> but not used [-Werror,-Wunused-but-set-variable]
> > >     295 |         u32 num_carats;
> > >         |             ^
> > >   1 error generated.
> > >
> > > I looked briefly in the code and I have no idea how to fix this, as
> probably
> > > __maybe_unused not an option for ACPICA. Hence this report.
> > >
> > > Note, the in-tree defconfig is in use:
> > >
> > >         git checkout v6.15-rc1
> > >         make x86_64_defconfig
> 
> > >         make W=1
> 
> Since it's a clang, this should have also something like LLVM=1.
> 
> > > should trigger it.
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
With Best Regards,
Andy Shevchenko



