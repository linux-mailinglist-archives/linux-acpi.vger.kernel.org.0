Return-Path: <linux-acpi+bounces-10643-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57519A110E3
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 20:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CD81888A67
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DA91FCD1A;
	Tue, 14 Jan 2025 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="euCs8RvT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14301B85FA;
	Tue, 14 Jan 2025 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881855; cv=none; b=pvXJ+TJeQZNouDhopcfr+fV9ntO9mNCb69vVJy2OqUnGebGMoBUkUV2CuhMjnqHQ8E76FliuDgsyAeB/girpVjUqBFnzb/faK470EOEAR1yMcBcCIIG3sf7pPuPFitU7P030cuFQcy3nFGEMfYhuO22r9t7Vukf/gp0j40Q1c4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881855; c=relaxed/simple;
	bh=9uDttyeLPPjhB32mwFWJOtpLbLWsKVEqcSAER0wqf20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT8ShBtuCMswioKJePBEKAgpNekUwLbX10d9VpVUG2N6rH03kvejPMDc8yKl1he2dS0ywNtUsrxPZFIJPwElVLXHu1gxDWIiN2nAOeHz6mljkZjl9cEIwq+YfukQ67uBEQWKTLt/isxt/vgag9NSfT5E1lPKqU1BkFAMU5C3ZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=euCs8RvT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736881854; x=1768417854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9uDttyeLPPjhB32mwFWJOtpLbLWsKVEqcSAER0wqf20=;
  b=euCs8RvTqoSYRvtQcp78W6fKM4BmTYQ7rHvRy+Ma15/bBk7v1i357YIc
   IuTqR39KF1xnURqP9IOXZC1GPq1RcUpJliaoYbjDlUbYCf/z7vcXSMqlA
   2w1EufBGqYhVYJraYGYwvSwefSMrokkAZ4s+PJ2bMIA57Y/ILsfy50GJ2
   lD+Tr/UUh1bBgDjRBnk1IQ96UTQLTXHYoZmOTr2HB+yi30BkhsWxdOxZq
   IK3xKeEdvtxhc0ANLuPdfK88CxOCHNQpQonrZNaaFNttU8niPxGIsElAX
   WKPPTa6Az+wFD1kZOiadKOvs3fVRPF98pj1sD+R4yoIA/41Hd+Ulby/85
   A==;
X-CSE-ConnectionGUID: hKRZ71WLSNmRy522wcbVdA==
X-CSE-MsgGUID: dgLuZV/XQDqFcjN6sDJWmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40958907"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40958907"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 11:10:53 -0800
X-CSE-ConnectionGUID: gXrihCw3Sh6N/8cgainqpA==
X-CSE-MsgGUID: 3gA9B5eQToeHJyuqQWbLaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="109840480"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 11:10:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tXmJL-00000000ySd-1u7S;
	Tue, 14 Jan 2025 21:10:47 +0200
Date: Tue, 14 Jan 2025 21:10:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] of: Warn when of_property_read_bool() is used on
 non-boolean properties
Message-ID: <Z4a2t9tRaiPSAovk@smile.fi.intel.com>
References: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org>
 <20250109-dt-type-warnings-v1-2-0150e32e716c@kernel.org>
 <CAMuHMdU=QR-JLgEHKWpsr6SbaZRc-Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU=QR-JLgEHKWpsr6SbaZRc-Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 14, 2025 at 07:35:22PM +0100, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Thu, Jan 9, 2025 at 8:42 PM Rob Herring (Arm) <robh@kernel.org> wrote:
> > The use of of_property_read_bool() for non-boolean properties is
> > deprecated. The primary use of it was to test property presence, but
> > that has been replaced in favor of of_property_present(). With those
> > uses now fixed, add a warning to discourage new ones.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Thanks for your patch, which is now commit c141ecc3cecd7647 ("of:
> Warn when of_property_read_bool() is used on non-boolean properties")
> in dt-rh/for-next.
> 
> I have bisected a failure in secondary CPU bring-up on R-Car H1 (quad
> Cortex-A9 MPCore) to this commit:
> 
>      Detected Renesas R-Car Gen1 r8a7779 ES1.0
>      smp: Bringing up secondary CPUs ...
>     -CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
>     -CPU1: Spectre v2: using BPIALL workaround
>     -CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
>     -CPU2: Spectre v2: using BPIALL workaround
>     -CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
>     -CPU3: Spectre v2: using BPIALL workaround
>     -smp: Brought up 1 node, 4 CPUs
>     -SMP: Total of 4 processors activated (2000.00 BogoMIPS).
>     +CPU1: failed to come online
>     +CPU2: failed to come online
>     +CPU3: failed to come online
>     +smp: Brought up 1 node, 1 CPU
>     +SMP: Total of 1 processors activated (500.00 BogoMIPS).
>      CPU: All CPU(s) started in SVC mode.
> 
> Reverting this commit on top of my work tree fixes the issue, too.
> However, I do not see how this commit could impact CPU bring-up?
> 
> I added debug code to of_property_read_bool(), to print all look-ups.
> I only saw a few before CPU bring-up, nothing relevant:
> 
>      NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
>     +OF: of_property_read_bool(interrupt-controller): 1
>      rcu: srcu_init: Setting srcu_struct sizes based on contention.
>     +OF: of_property_read_bool(interrupt-controller): 1
>      sched_clock: 64 bits at 250MHz, resolution 4ns, wraps every 4398046511102ns
>      clocksource: arm_global_timer: mask: 0xffffffffffffffff
> max_cycles: 0x7350b89c29, max_idle_ns: 881590431910 ns
>      Switching to timer-based delay loop, resolution 4ns
>     +OF: of_property_read_bool(interrupt-controller): 1
>     +OF: of_property_read_bool(always-on): 0
>      Console: colour dummy device 80x30
>      printk: legacy console [tty0] enabled
> 
> Perhaps something shifted in the code layout?  The obvious suspects
> (shmobile_boot_* and shmobile_smp_* asm code, secondary_startup(),
> addresses in arch/arm/mach-shmobile/platsmp-scu.c) are still at the
> same addresses as before...
> 
> Anyone with a clue?

Hmm... You meant the patch 2 troubles this?

-- 
With Best Regards,
Andy Shevchenko



