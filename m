Return-Path: <linux-acpi+bounces-6767-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB0A92775C
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 15:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674361F222FD
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 13:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113D81AED2F;
	Thu,  4 Jul 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1BsKCVL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733528373;
	Thu,  4 Jul 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100653; cv=none; b=OPsNSXCej3FKKwG3MwbNZ9mzjcvAtmM0lEgeTKXMBY5XVu1p7GMlZGsLP+E+yvpZnyE9wI7nMp2A8mPPYjcIGjzUnTNF5bTrmlgGYYkzavSCC226Sjxk2XiMxwKZx1sUkzt49NSwJOFaNtDsHR4TO/i5N32XXY0JkvdGheVsUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100653; c=relaxed/simple;
	bh=vd6ZMMbCUn2U39zAqJ5QeXI+KZCVWJVSSyj9T80YrJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7eXiBO2Z+wGDxsczAe/Eh263vZAPnb93RRxf0N9a+Oth8pK9CdjXJXjWtpSqW0EGM0hwktZInfdXy9nMcubcxzgg41iYFqCSzrtpON3IXvIIn2j3DHGYcGkx2U7EvxkxanhgVP5Qexi0dsLgjSJnvUstl6kzQEF+dXe1gXeOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1BsKCVL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720100651; x=1751636651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vd6ZMMbCUn2U39zAqJ5QeXI+KZCVWJVSSyj9T80YrJM=;
  b=h1BsKCVLBIFomz0G1tr0EVcKOg38JREn0mewiY/9myKYmnFM/Cz0LBd+
   VmWztR19ExBSJ3XUlGnZnxBrCKay8mRUgq5c/sBDYtkUToNp9Ng3bBKUr
   DToyhrr/Roe+Rn47a9opXSFfBZumo95lP+R5+VJ74wZrcSQ5sSq3SSNhJ
   7Y6Bu6Pqte1rSldEGzNdgT+frCgDyiHW3m/dThByvyowG5a2WlETyKU+v
   sFzvX62B1RDkpdxUc1qRui7Zev3qX9Sj6cLsWtBVKvQwFsleG8ZvbYzDR
   CDst7kDdA/JPDEdoFadpkiNKLg8XNn2Q9XeWO4DdJ/+LDfToIBeKPlJpV
   Q==;
X-CSE-ConnectionGUID: GIjmXhWyRIutQvBdJ9/qag==
X-CSE-MsgGUID: XkSV36XVRYyNPNG+Ey0b8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17217109"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17217109"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 06:44:09 -0700
X-CSE-ConnectionGUID: XeQQC8IgQiOO66rDYk+aYw==
X-CSE-MsgGUID: qAyT9sa+TaKk8jCwTK5edw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77734900"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 04 Jul 2024 06:44:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C66B160D; Thu, 04 Jul 2024 16:44:03 +0300 (EEST)
Date: Thu, 4 Jul 2024 16:44:03 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "luto@kernel.org" <luto@kernel.org>, 
	"rafael@kernel.org" <rafael@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org" <peterz@infradead.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "bhe@redhat.com" <bhe@redhat.com>, 
	"x86@kernel.org" <x86@kernel.org>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ardb@kernel.org" <ardb@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>
Subject: Re: [PATCH 3/3] x86/64/kexec: Rewrite init_transition_pgtable() with
 kernel_ident_mapping_init()
Message-ID: <vyvbvham7qcj2pnotfn4mocozx6x33zkvuks63w3ymzk4w6sjc@2gk5xbtb5xrb>
References: <20240701124334.1855981-1-kirill.shutemov@linux.intel.com>
 <20240701124334.1855981-4-kirill.shutemov@linux.intel.com>
 <cd655676d5e81ca9b1de0a66f5f5c719ef816c89.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd655676d5e81ca9b1de0a66f5f5c719ef816c89.camel@intel.com>

On Wed, Jul 03, 2024 at 11:06:21AM +0000, Huang, Kai wrote:
> >  static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
> >  {
> > -	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
> > -	unsigned long vaddr, paddr;
> > -	int result = -ENOMEM;
> > -	p4d_t *p4d;
> > -	pud_t *pud;
> > -	pmd_t *pmd;
> > -	pte_t *pte;
> > +	struct x86_mapping_info info = {
> > +		.alloc_pgt_page	= alloc_transition_pgt_page,
> > +		.context	= image,
> > +		.page_flag	= __PAGE_KERNEL_LARGE_EXEC,
> > +		.kernpg_flag	= _KERNPG_TABLE_NOENC,
> > +		.offset = __START_KERNEL_map - phys_base,
> > +	};
> > +	unsigned long mstart = PAGE_ALIGN_DOWN(__pa(relocate_kernel));
> > +	unsigned long mend = mstart + PAGE_SIZE;
> >  
> > -	vaddr = (unsigned long)relocate_kernel;
> > -	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
> 
> Perhaps I am missing something, but this seems a functional change to me.
> 
> IIUC the page after image->control_code_page is allocated when loading the
> kexec kernel image.  It is a different page from the page where the
> relocate_kernel code resides in.
> 
> The old code maps relocate_kernel kernel VA to the page after the
> control_code_page.  Later in machine_kexec(), the relocate_kernel code is
> copied to that page so the mapping can work for that:
> 
> 	control_page = page_address(image->control_code_page) + PAGE_SIZE;
> 	__memcpy(control_page, relocate_kernel,
> KEXEC_CONTROL_CODE_MAX_SIZE);
> 
> The new code in this patch, however, seems just maps the relocate_kernel VA
> to the PA of the relocate_kernel, which should be different from the old
> mapping.

Yes, original code maps at relocate_kernel() VA the page with copy of the
relocate_kernel() in control_code_page. But it is safe to map original
relocate_kernel() page there as well as it is not going to be overwritten
until swap_pages(). We are not going to use original relocate_kernel()
page after RET at the end of relocate_kernel().

Does it make any sense?

I will try to explain it in the commit message in the next version.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

