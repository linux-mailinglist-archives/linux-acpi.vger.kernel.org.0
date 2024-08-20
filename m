Return-Path: <linux-acpi+bounces-7713-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1C895858A
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 13:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A841C21C88
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B1418DF79;
	Tue, 20 Aug 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N5UKICDc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7D18A6BC;
	Tue, 20 Aug 2024 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152495; cv=none; b=RseVxiy+gLoWgkBJEiW+5s7i7mhb4Iyuh/tBD4ZLk9MvahfGqMLh4FtxvbHw8NiqyAonXZ6wQbm2NrSO9G8x7D/N9BPGD4p77Kje2CyI8RC85erCCg/8Nn+5jlRsXF1I98JkV2O068kKgwnmdszfFhW0gGLcpGbhn8r14mBb/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152495; c=relaxed/simple;
	bh=m6RXcpM9BA6bId8/mRtxdjVsZYXBaatKRdN++kTTHNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET6SEF/nEbkdRqUfFrdsdvuL+pn1aMhsI51HdIS44iuRiMfdwuoWS3tdpxkC/wZFa4CAgDMT+qe1/keHqV8mOX1Iy+3LQTvTkyv6UnDcAkveose5DtoUB+VADW7sgdlMgctTSOIqEaZFy0T0F3J7ozzA2vYhU5QU1fzVO8VoJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N5UKICDc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724152493; x=1755688493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m6RXcpM9BA6bId8/mRtxdjVsZYXBaatKRdN++kTTHNg=;
  b=N5UKICDcS/l9bRmTId82tU4S6N5gzHKuKf2b95atvUtNJw3nLM8F5PG0
   eKAmCngufvr5ZdEoHyegKxseYrffFZlZ7vA8713scSN2Wkb7BD6DOYeNn
   x5xyMO/W9PpqkBHNnlxLbLWkiaAY8vz5Fm/7UsUK3N9tUPZTME2R5kdYv
   yVIinn0t1yCGKmSM1d82YjPW3RnD1at9mb5ncYrts36imFF7BYGXq2D9C
   eH7Wck9i36Ho+8Ra+LwBksC6dJbL7fjIftUWINeeYTD/N8yxtYQWG5IQJ
   5T0+IS918yd7yuQ0Ut4NfmaMsNG6spSSDLvMW3hmrVft86aRHTHwCYE6D
   w==;
X-CSE-ConnectionGUID: QMqR6Z7eSvuZ3IRK3LlpNQ==
X-CSE-MsgGUID: JYJ0F3C/RFCWbZrMhb7JuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22609389"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22609389"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:14:53 -0700
X-CSE-ConnectionGUID: 4LLJGHzMTuufgfoKa0H+Og==
X-CSE-MsgGUID: XwQfv2LnTgCJ0nTXvtxNVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65056087"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 20 Aug 2024 04:14:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8164B3C0; Tue, 20 Aug 2024 14:14:47 +0300 (EEST)
Date: Tue, 20 Aug 2024 14:14:47 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "ardb@kernel.org" <ardb@kernel.org>, 
	"luto@kernel.org" <luto@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com" <seanjc@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "bhe@redhat.com" <bhe@redhat.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"bp@alien8.de" <bp@alien8.de>, "rafael@kernel.org" <rafael@kernel.org>, 
	"Huang, Ying" <ying.huang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv3 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Message-ID: <hxw67ecixuf5mkj3ucwhsobvd6dyjhwjo32fu4jiwoxgrgk7rd@dklvwlnrewil>
References: <20240819070827.3620020-1-kirill.shutemov@linux.intel.com>
 <20240819070827.3620020-4-kirill.shutemov@linux.intel.com>
 <4c140a8e0154504e9c645b9f78b0b164dc25a461.camel@intel.com>
 <hr7kym77uhbtj32eymcdp5mcbpid7euoiiszhx6yhkrbw5riag@lcozqjayilbo>
 <d97a17a53cb7550134ec521e3d22177d6a6ad05e.camel@intel.com>
 <jzqh5j4w4w23xuigqj5bggbmx2hgte4u5tvbss3hqi3vjeodhl@rnmirwt6biol>
 <6464ab0f43f51f4526666f8924921262e8144027.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6464ab0f43f51f4526666f8924921262e8144027.camel@intel.com>

On Tue, Aug 20, 2024 at 11:06:34AM +0000, Huang, Kai wrote:
> At later time:
> 
>         call    swap_pages                                                   
>         movq    $virtual_mapped, %rax  	<---- (1)                            
>         pushq   %rax
>         ANNOTATE_UNRET_SAFE
>         ret  				<---- (2)
> 
> (1) will load the VA which has __START_KERNEL_map to %rax, and after (2) the
> kernel will run at VA of the original relocate_kernel() which maps to the PA
> of the original relcoate_kernel().  But I think the memory page of the
> original relocate_kernel() won't get corrupted after returning from the second
> kernel, so should be safe to use?

Yes.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

