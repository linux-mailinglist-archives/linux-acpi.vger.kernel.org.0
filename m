Return-Path: <linux-acpi+bounces-12909-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A93A8277D
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 16:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2813E1BC1F5D
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF0425E81E;
	Wed,  9 Apr 2025 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVuAqni8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA1D154BF5
	for <linux-acpi@vger.kernel.org>; Wed,  9 Apr 2025 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208112; cv=none; b=gpU4q6zLe7irW88T1F1w5WCXJsQVnh7f9rF9BUVu58yBGq5PsZjIwbAn12uqjFznOhgWRBROz2DfbTFqZJUkYgRjGQDcd1nZ1kQjvCeG9Mzc4rMpjbMsej3iruCOI49ze0T/sdREMc6lPkZTIisytYvCJfCRKMjlQN+nFo1VBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208112; c=relaxed/simple;
	bh=YZNADTDnpFwmstiZiOUvs9W0ptXjNDD/nKl6XbxpEN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqU/KKMBBgJv1HPtMWW2GTWyFz7SlTB2V20+1pMvA1yh3Bh+F74WpOWRHl8w4EyJhi4obwFqqiz1LNYE5rMaFnhonIHZp2ij5yr3vPZz0wONeqzD65rBgfbvXNN2H0DMiJ+jQ5kGFdDscT4vqa9hrNOdrShk//qKMcDXJT67i1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVuAqni8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744208110; x=1775744110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YZNADTDnpFwmstiZiOUvs9W0ptXjNDD/nKl6XbxpEN0=;
  b=MVuAqni8vB7MJQhmjhdCV0mXb+h8wuiKPKijLzv60HrRm3GYE1maM7nr
   XL+ZdB90Si0B/ftHoHk7j/Axc+DntlCNqSIox6+O9ic8ZS8dEQpxm5IOm
   dEp4zwQhwL2FKAugg3Ualuy7WauaTg8OPB2IOBqlBi2Ui53ctnRHas8oy
   qN2xZyjey7wvV8CF2mVK9hYLZ7tFX0NZMCzQ9gB/MBcYOu6GnjGc65GYB
   +evRMELZ8lVED1pb19DYXOBNDp64eqYgdhD7eLwZvDfiOQMcIZlV1eScz
   PprxGrTLQl3NAzk91sA1M/TIzESVds2kSeuTdL2fx7caYm3FrUc1zqJFw
   w==;
X-CSE-ConnectionGUID: dwH6MD85Sy6lSfPzgMrUvg==
X-CSE-MsgGUID: yHbWICmWSlGYA5E06aqiww==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45809979"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="45809979"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 07:15:09 -0700
X-CSE-ConnectionGUID: GXh8NcH4TFy1pli2oRjmYA==
X-CSE-MsgGUID: +EL+c7RYTzOPd4yopBeCIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="159576359"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 07:15:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u2WCm-0000000Al3J-3nYF;
	Wed, 09 Apr 2025 17:15:04 +0300
Date: Wed, 9 Apr 2025 17:15:04 +0300
From: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Dumbre, Saket" <saket.dumbre@intel.com>,
	"Moore, Robert" <robert.moore@intel.com>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>
Subject: Re: ACPICA compilation error on x86_64_defconfig (W=1 build)
Message-ID: <Z_aA6D7_FdG4RTQV@smile.fi.intel.com>
References: <Z_Qd0x6bLSQjJ7Rw@smile.fi.intel.com>
 <CAJZ5v0j2Y3vPZhUGJmcWzn6esg9zv5an0KPEN4QfQuyGrd5=YQ@mail.gmail.com>
 <Z_Qeot7pps5Q4vx7@smile.fi.intel.com>
 <LV8PR11MB86980990221C597E01BAEB7980B52@LV8PR11MB8698.namprd11.prod.outlook.com>
 <LV8PR11MB8698978FFF89ACBEF253667680B52@LV8PR11MB8698.namprd11.prod.outlook.com>
 <Z_ZY_UA7ypFzpT0t@smile.fi.intel.com>
 <Z_Z9mnDbypQ0KLF8@smile.fi.intel.com>
 <CAJZ5v0jWu4rEjO1bYzaTkF3Edcmnyi+3yEz9WNYzb8+3J74hEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jWu4rEjO1bYzaTkF3Edcmnyi+3yEz9WNYzb8+3J74hEw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 04:07:09PM +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 9, 2025 at 4:01 PM Shevchenko, Andriy
> <andriy.shevchenko@intel.com> wrote:
> >
> > Note, I have posted two much better solutions in that bug report thread.
> 
> Which bug report thread do you mean?

https://github.com/acpica/acpica/issues/973

> > Please, choose one and fix, it prevents kernel from building...
> 
> With Clang-19 and 'make W=1' that is.

Yes. it is not *that* critical, sure.

> > On Wed, Apr 09, 2025 at 02:24:45PM +0300, Shevchenko, Andriy wrote:
> > > GCC should ignore all clang specific pragmas as far as I know.
> > >
> > > But this seems to me the not the best solution either. What code needs is to
> > > have some refactoring to make sure the variable is used or not defined and used
> > > at all. Unfortunately, I am not familiar with ACPICA to propose anything right
> > > now, though.
> > >
> > > On Tue, Apr 08, 2025 at 09:34:36PM +0300, Dumbre, Saket wrote:
> > > > I am not sure about the Linux environment specifics like Andy described in the
> > > > previous conversation, but if GCC or some other compiler throws an error in the
> > > > code with #pragma for clang, then may I suggest using this instead:
> > > >
> > > > #pragma clang diagnostic push
> > > > #if defined(__clang__) && __clang__ >= n (replace n with the least version
> > > > number which introduces this new warning type)
> > > > #pragma clang diagnostic ignored "-Wunused-but-set-variable"
> > > > #endif
> > > > u32 num_carats;
> > > > #pragma clang diagnostic pop
> > > >
> > > > ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> > > > From: Dumbre, Saket <saket.dumbre@intel.com>
> > > > Sent: Tuesday, April 8, 2025 11:11 AM
> > > > To: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Rafael J. Wysocki
> > > > <rafael@kernel.org>
> > > > Cc: Moore, Robert <robert.moore@intel.com>; Wysocki, Rafael J
> > > > <rafael.j.wysocki@intel.com>; linux-acpi@vger.kernel.org
> > > > <linux-acpi@vger.kernel.org>; acpica-devel@lists.linux.dev
> > > > <acpica-devel@lists.linux.dev>
> > > > Subject: Re: ACPICA compilation error on x86_64_defconfig (W=1 build)
> > > >
> > > > Hi Andy and Rafael,
> > > >
> > > > This issue is a duplication of an Apple ecosystem-based (ARM + M-series micro
> > > > architecture) ACPICA GitHub Issue, which I was waiting on a response from the
> > > > contributor/submitter to move ahead to resolve it:
> > > > https://github.com/acpica/acpica/issues/973
> > > >
> > > > I don't see a platform specific file for Clang/LLVM in ACPICA (only for GCC and
> > > > MSVC), so I think the worst-case untidy solution would be to locally patch this
> > > > warning-turned-error by suppressing this warning type if the compiler is Clang/
> > > > LLVM.
> > > >
> > > > It would look somewhat better to move that line all the way down after all the
> > > > other definitions/declarations just before any execution line and wrap it with
> > > > a #pragma something along the lines:
> > > >
> > > > #pragma clang diagnostic push
> > > > #pragma clang diagnostic ignored "-Wunused-but-set-variable"
> > > > u32 num_carats;
> > > > #pragma clang diagnostic pop
> > > >
> > > > I am just not sure if this is the only place in the ACPICA code that generates
> > > > this warning type and depending on the answer, this fix could be implemented at
> > > > a wider/global scale, but please give this hacky fix a try and let me know if
> > > > it resolves that. Thanks a lot!
> > > >
> > > >
> > > > Kind regards,
> > > >
> > > > Saket Dumbre
> > > >
> > > >
> > > > ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> > > > From: Shevchenko, Andriy
> > > > Sent: Monday, April 7, 2025 11:51 AM
> > > > To: Rafael J. Wysocki
> > > > Cc: Dumbre, Saket; Moore, Robert; Wysocki, Rafael J;
> > > > linux-acpi@vger.kernel.org; acpica-devel@lists.linux.dev
> > > > Subject: Re: ACPICA compilation error on x86_64_defconfig (W=1 build)
> > > >
> > > > On Mon, Apr 07, 2025 at 08:49:41PM +0200, Rafael J. Wysocki wrote:
> > > > > On Mon, Apr 7, 2025 at 8:47 PM Andy Shevchenko
> > > > > <andriy.shevchenko@intel.com> wrote:
> > > > > >
> > > > > > v6.15-rc1 (but seems older should also be problematic) fails to compile by
> > > > > > Clang 19 with `make W=1`.
> > > > > >
> > > > > >   CC      drivers/acpi/acpica/nsaccess.o
> > > > > >   drivers/acpi/acpica/nsaccess.c:295:6: error: variable 'num_carats' set
> > > > but not used [-Werror,-Wunused-but-set-variable]
> > > > > >     295 |         u32 num_carats;
> > > > > >         |             ^
> > > > > >   1 error generated.
> > > > > >
> > > > > > I looked briefly in the code and I have no idea how to fix this, as
> > > > probably
> > > > > > __maybe_unused not an option for ACPICA. Hence this report.
> > > > > >
> > > > > > Note, the in-tree defconfig is in use:
> > > > > >
> > > > > >         git checkout v6.15-rc1
> > > > > >         make x86_64_defconfig
> > > >
> > > > > >         make W=1
> > > >
> > > > Since it's a clang, this should have also something like LLVM=1.
> > > >
> > > > > > should trigger it.
> > > >
> > > > --
> > > > With Best Regards,
> > > > Andy Shevchenko
> > > >
> > > >
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
> >

-- 
With Best Regards,
Andy Shevchenko



