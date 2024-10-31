Return-Path: <linux-acpi+bounces-9185-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112CC9B786F
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 11:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6B928136B
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E59195962;
	Thu, 31 Oct 2024 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sw5RcALi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B612B169;
	Thu, 31 Oct 2024 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369519; cv=none; b=RHm38zPPNlXxP11CaNfdBXPL53/8bBH42YW9JXF4DScLJ0yTa3QcU+hOu7+fPpKlTOWsK3VhXQn+SWEqgxh50SOO50FOzB3GOL6ww5q8YhruJSw/MDNwE10MlMw7pBfXErVzyMqn2qKGutjJv5hqjIXNoajg7xFS22AXuDAUvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369519; c=relaxed/simple;
	bh=fSxItwnNBBOBz+TJUIDnGFbhmk1MBG4OISnlpcaj7bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBCLiGGzjJkyFy+BsaeUeCUAlFvTWejdgqSHDUNpfeZXEHCMx92zUYnchmURi44Z2ekEfK876A1teTonCchOhG6pYBNfThjwb+R6caBCdVbpVOuJAZXJo9axvBDsKWIK+g9LydjpIv2IxYJ8P7uYLp7IpzqckCA2OK5MUkz1Nr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sw5RcALi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730369518; x=1761905518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fSxItwnNBBOBz+TJUIDnGFbhmk1MBG4OISnlpcaj7bU=;
  b=Sw5RcALi7/1X1yb66beY3EuQIeubuZuPWEglFZjY8/d7uNu8ZIGPNWxw
   gFUzELEx+QPNiIf800Qz/tInSezZHcineUDjmrwBkVH/tTNTJV3RNWD3q
   TmvKIut/ZW0G+5f8+OqPbS08ja8Vmxzw5kEXm8ZWZzyW4v8uAGrzlymQO
   Sx8dXx9xhMNRv4mfD9Vl3KPRYTjHtbKVJKH08MRQscZyFvpWo/TPHRX7T
   xccbDgrJPByI2gxJlnteAuZFeVPbmm6AZ0YQ2NFGO6e3mpuOy3+/MmkrX
   oaSbierMSgqkIzV/mqKfuf3P23rVKFkaImm/3t/MmmiGQR448hc32OyF2
   A==;
X-CSE-ConnectionGUID: iniedKx4SUeEV5e+OHfSRw==
X-CSE-MsgGUID: WkIwtNvUSQ6b6eHXFrJX5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="33889892"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="33889892"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:11:57 -0700
X-CSE-ConnectionGUID: Y3C7ARSkRRa1ebv/pkchMg==
X-CSE-MsgGUID: n+1neofaS8GvroBnInt/rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82496957"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 31 Oct 2024 03:11:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 44A951C4; Thu, 31 Oct 2024 12:11:52 +0200 (EET)
Date: Thu, 31 Oct 2024 12:11:52 +0200
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
Message-ID: <3rmdms6czfsa4hwfx5egcf5rheojpwhdhwq2gxkn2ffvvymfir@dv7x4cmby6sz>
References: <20241016111458.846228-1-kirill.shutemov@linux.intel.com>
 <20241016111458.846228-2-kirill.shutemov@linux.intel.com>
 <20241030114712.GCZyIcwF9MyQacmRf1@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030114712.GCZyIcwF9MyQacmRf1@fat_crate.local>

On Wed, Oct 30, 2024 at 12:47:12PM +0100, Borislav Petkov wrote:
> On Wed, Oct 16, 2024 at 02:14:55PM +0300, Kirill A. Shutemov wrote:
> > Calculation of 'next' virtual address doesn't protect against wrapping
> > to zero. It can result in page table corruption and hang. The
> > problematic case is possible if user sets high x86_mapping_info::offset.
> > 
> > The wrapping to zero only occurs if the top PGD entry is accessed.
> > There are no such users in the upstream. Only hibernate_64.c uses
> > x86_mapping_info::offset, and it operates on the direct mapping range,
> > which is not the top PGD entry.
> > 
> > Replace manual 'next' calculation with p?d_addr_end() which handles
> > wrapping correctly.
> 
> So this is a fix for a theoretical issue as it cannot happen currently?

Right.

> Can we call that out in the commit message so that the stable AI doesn't pick
> it up?

Do we have magic words for that?

I tried to express that in the second paragraph: "no such users in the
upstream".

> And which commit is it fixing?
> 
> aece27851d44 ("x86, 64bit, mm: Add generic kernel/ident mapping helper")
> perhaps?

This one is closer:

e4630fdd4763 ("x86/power/64: Always create temporary identity mapping correctly")

It adds x86_mapping_info::offset.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

