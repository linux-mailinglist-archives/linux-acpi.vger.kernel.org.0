Return-Path: <linux-acpi+bounces-9269-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8865B9BAF99
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 10:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 030CDB21F58
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19E81AE00C;
	Mon,  4 Nov 2024 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgfgmMG3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F94D6FC5;
	Mon,  4 Nov 2024 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712422; cv=none; b=g9zcEyrxhG3EoFLXHMRJtw8AmCwtNPDhZkRPo5cyiPB3t3d2d/pDWDkhulg0XbITpVjCtxJSu0Nhu5h/mpSSNoAc+XodmXG4202hTKB0YY/HirQOQ/uYIDbEAVY3J+7SVNzkpBy22rtzcNZxBIOBElVFO+yvNRvtLYsAhLwZbzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712422; c=relaxed/simple;
	bh=Sx5KjvKZ4csWvVy9wH3IjtRV3od9fJK+XxTSO1IYTjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6GpRVdH3DgJ2OqTRgMp5a6Ta5KVzppAZrdpQb4YLhxNIiQBgTziPph23/OujjXzmvIaMck8CuliURVMYOYGC1+xbj8sIvXaoEB0PimVFkUYOfsbOjZhGDG0T7JSR66/ZcmBuwKzemv/UjvMyE+oLpoyiE70Ex3bAhtKSTi5/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgfgmMG3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730712421; x=1762248421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sx5KjvKZ4csWvVy9wH3IjtRV3od9fJK+XxTSO1IYTjc=;
  b=hgfgmMG3KWnRbNz8K1OoKj/2iJxg2jYLpt0xVVGD9kAGZcE5FXvHECLD
   6QpMwJ5AR1o5+pwhlqL44+VXMCK08rapDBqYsmhD6BhSxa1p/AiFWTatJ
   mCvC45BV2ocfCThS8hQ9ISiWN1iyJV3V1UPRjRxl0gru2u1O8CJFnsbl2
   D6ryBIGlfB5m/AMDckNibviJBnHPFWE208rMlz2IDiVdjKghsgOzl4ORz
   nfMHPHsOMgNzWJdXMBFIqJ0t7QUYPDkeH0ToNQPfp7DbWv59RSVnVQ7F/
   1eQvPBb0uLdE0YKPpdFjXLymqG9Ttib5B21T0ld9eOGqbAT1ZrhN/rjh2
   A==;
X-CSE-ConnectionGUID: ZyjohGY7SlOpcTnHN9rQHQ==
X-CSE-MsgGUID: Uxf9v32lR+6C6aOKk4DZ6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30502788"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30502788"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 01:27:00 -0800
X-CSE-ConnectionGUID: 9wRJx7qtSf2a1DC+yCrjhg==
X-CSE-MsgGUID: T+MAZZ9zSVKEgdhd5gz+WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88414155"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 04 Nov 2024 01:26:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 153D21C4; Mon, 04 Nov 2024 11:26:55 +0200 (EET)
Date: Mon, 4 Nov 2024 11:26:55 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sean Christopherson <seanjc@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCHv4, REBASED 1/4] x86/mm/ident_map: Fix virtual address
 wrap to zero
Message-ID: <qz42rystorh4q2fpk5kpgjnycorfjmjypjgj3dmi4hhfznlzdx@eaertxsby5st>
References: <20241016111458.846228-1-kirill.shutemov@linux.intel.com>
 <20241016111458.846228-2-kirill.shutemov@linux.intel.com>
 <20241030114712.GCZyIcwF9MyQacmRf1@fat_crate.local>
 <3rmdms6czfsa4hwfx5egcf5rheojpwhdhwq2gxkn2ffvvymfir@dv7x4cmby6sz>
 <20241031135916.GDZyONNENEDAViMSOZ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031135916.GDZyONNENEDAViMSOZ@fat_crate.local>

On Thu, Oct 31, 2024 at 02:59:16PM +0100, Borislav Petkov wrote:
> On Thu, Oct 31, 2024 at 12:11:52PM +0200, Kirill A. Shutemov wrote:
> > Do we have magic words for that?
> 
> No clue.
> 
> > I tried to express that in the second paragraph: "no such users in the
> > upstream".
> 
> Right, so perhaps better to spell it out explicitly:
> 
> "Backporter's note:
> 
> This fixes a theoretical issue only and there's no need to backport it to
> stable."
> 
> at the end of the commit message.

Okay.

> 
> > > And which commit is it fixing?
> > > 
> > > aece27851d44 ("x86, 64bit, mm: Add generic kernel/ident mapping helper")
> > > perhaps?
> > 
> > This one is closer:
> > 
> > e4630fdd4763 ("x86/power/64: Always create temporary identity mapping correctly")
> > 
> > It adds x86_mapping_info::offset.
> 
> But aece27851d44 has the faulty check...

It cannot be triggered without 'offset'.

I'll put both.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

