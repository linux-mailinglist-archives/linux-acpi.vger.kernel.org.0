Return-Path: <linux-acpi+bounces-7654-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ABE956A0B
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 13:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA252875B3
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25B167DAC;
	Mon, 19 Aug 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGyJEUXF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7215B972;
	Mon, 19 Aug 2024 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068644; cv=none; b=bbnRHiQ4boJ14A5HOScLV0Jam1ZepKq6T+Jnu8Es+a1VL1YEfH4MuV5clm1gBIROzajddQM+dLDe60VI1PF7UsOb7BJnwDKbWUKGio6jbIebE6sOKXQDNQGe+P3bgvvB9OMv53iKkBOlnsK4Vk9rrtvqOTcT0jUQvg+oDn0VgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068644; c=relaxed/simple;
	bh=IojMVBrqkeaGExfwqC/z1nOFW9hFN0FzC20e1/aVBQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoF8+VjQO1hJnXNwqrWyi4ymGXwLAoWeUTXQ2NNbPbyU4Ct+GLaJc3Y6y5cZ3/HIxSedWMugb+J6AUSkkubSnabobIOk6Clj4owcKNOHZ+H/B8myUUA0iesZCGZaUBTs9LzK6Fm1cfSFht2JyISCajDbet+zmnVWgCjf1TtEvVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGyJEUXF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724068643; x=1755604643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IojMVBrqkeaGExfwqC/z1nOFW9hFN0FzC20e1/aVBQ4=;
  b=oGyJEUXF9Fu1IHD8wf7qrd0ohwU6fEzkuGBvQGriddejb90MyrMnODXs
   Qg9eMwUcElctmIywRQc+gLPnbhBUpy1OlbFs7fcu2eVzN1oN4gh16kCIc
   /wDQDCRKhcdwAu/RMca/KbqJFL5ZnQfO+Z2I14LazpPECmiuJrdoM0o7d
   SUsyZrLJFNv+ILcl1JvzwYYHRwPKxztUK2ATOPx91MPX79XrPDuGUYPGa
   +s8WZo8BshExlVuHyVUSY+iU/HVxjHYHBECsNjQL9pgPGe10eQJiwkywB
   rtpQQ+l02+fpsHptfvZ5SHBmg+fkiYqsX7A+mMIRAR2KJEY86Gb0L8Qsq
   w==;
X-CSE-ConnectionGUID: d0Rw5Z/GTmSUnMGqmKFKcQ==
X-CSE-MsgGUID: tUSAJIdyTMKVjzzsW2OKkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="21857168"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="21857168"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 04:57:22 -0700
X-CSE-ConnectionGUID: 8dRCNa69QFqtDgJ886kDIw==
X-CSE-MsgGUID: wkcgrrjZQjCuLkrsk8avDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64742648"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2024 04:57:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D8DA02D8; Mon, 19 Aug 2024 14:57:16 +0300 (EEST)
Date: Mon, 19 Aug 2024 14:57:16 +0300
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
Subject: Re: [PATCHv3 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Message-ID: <hr7kym77uhbtj32eymcdp5mcbpid7euoiiszhx6yhkrbw5riag@lcozqjayilbo>
References: <20240819070827.3620020-1-kirill.shutemov@linux.intel.com>
 <20240819070827.3620020-4-kirill.shutemov@linux.intel.com>
 <4c140a8e0154504e9c645b9f78b0b164dc25a461.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c140a8e0154504e9c645b9f78b0b164dc25a461.camel@intel.com>

On Mon, Aug 19, 2024 at 11:16:52AM +0000, Huang, Kai wrote:
> On Mon, 2024-08-19 at 10:08 +0300, Kirill A. Shutemov wrote:
> > The init_transition_pgtable() function sets up transitional page tables.
> > It ensures that the relocate_kernel() function is present in the
> > identity mapping at the same location as in the kernel page tables.
> > relocate_kernel() switches to the identity mapping, and the function
> > must be present at the same location in the virtual address space before
> > and after switching page tables.
> > 
> > init_transition_pgtable() maps a copy of relocate_kernel() in
> > image->control_code_page at the relocate_kernel() virtual address, but
> > the original physical address of relocate_kernel() would also work.
> > 
> > It is safe to use original relocate_kernel() physical address cannot be
> > overwritten until swap_pages() is called, and the relocate_kernel()
> > virtual address will not be used by then.
> > 
> > Map the original relocate_kernel() at the relocate_kernel() virtual
> > address in the identity mapping. It is preparation to replace the
> > init_transition_pgtable() implementation with a call to
> > kernel_ident_mapping_init().
> > 
> > Note that while relocate_kernel() switches to the identity mapping, it
> > does not flush global TLB entries (CR4.PGE is not cleared). This means
> > that in most cases, the kernel still runs relocate_kernel() from the
> > original physical address before the change.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/kernel/machine_kexec_64.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > index 9c9ac606893e..645690e81c2d 100644
> > --- a/arch/x86/kernel/machine_kexec_64.c
> > +++ b/arch/x86/kernel/machine_kexec_64.c
> > @@ -157,7 +157,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
> >  	pte_t *pte;
> >  
> >  	vaddr = (unsigned long)relocate_kernel;
> > -	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
> > +	paddr = __pa(relocate_kernel);
> >  	pgd += pgd_index(vaddr);
> >  	if (!pgd_present(*pgd)) {
> >  		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
> 
> 
> IIUC, this breaks KEXEC_JUMP (image->preserve_context is true).
> 
> The relocate_kernel() first saves couple of regs and some other data like PA
> of swap page to the control page.  Note here the VA_CONTROL_PAGE is used to
> access the control page, so those data are saved to the control page.
> 
> SYM_CODE_START_NOALIGN(relocate_kernel)
>         UNWIND_HINT_END_OF_STACK
>         ANNOTATE_NOENDBR
>         /*      
>          * %rdi indirection_page
>          * %rsi page_list
>          * %rdx start address
>          * %rcx preserve_context
>          * %r8  bare_metal
>          */
> 
> 	...
> 
>         movq    PTR(VA_CONTROL_PAGE)(%rsi), %r11                             
>         movq    %rsp, RSP(%r11)                                              
>         movq    %cr0, %rax
>         movq    %rax, CR0(%r11)
>         movq    %cr3, %rax
>         movq    %rax, CR3(%r11)
>         movq    %cr4, %rax
>         movq    %rax, CR4(%r11)
> 
> 	...
> 
> 	/*
>          * get physical address of control page now
>          * this is impossible after page table switch
>          */
>         movq    PTR(PA_CONTROL_PAGE)(%rsi), %r8
> 
>         /* get physical address of page table now too */
>         movq    PTR(PA_TABLE_PAGE)(%rsi), %r9
> 
>         /* get physical address of swap page now */
>         movq    PTR(PA_SWAP_PAGE)(%rsi), %r10
> 
>         /* save some information for jumping back */
>         movq    %r9, CP_PA_TABLE_PAGE(%r11)
>         movq    %r10, CP_PA_SWAP_PAGE(%r11)
>         movq    %rdi, CP_PA_BACKUP_PAGES_MAP(%r11)
> 
> 	...
> 
> And after jumping back from the second kernel, relocate_kernel() tries to
> restore the saved data:
> 
> 	...
> 
>         /* get the re-entry point of the peer system */
>         movq    0(%rsp), %rbp
>         leaq    relocate_kernel(%rip), %r8		<---------  (*) 
>         movq    CP_PA_SWAP_PAGE(%r8), %r10
>         movq    CP_PA_BACKUP_PAGES_MAP(%r8), %rdi
>         movq    CP_PA_TABLE_PAGE(%r8), %rax
>         movq    %rax, %cr3
>         lea     PAGE_SIZE(%r8), %rsp
>         call    swap_pages
>         movq    $virtual_mapped, %rax
>         pushq   %rax
>         ANNOTATE_UNRET_SAFE
>         ret
>         int3
> SYM_CODE_END(identity_mapped)
> 
> Note the above code (*) uses the VA of relocate_kernel() to access the control
> page.  IIUC, that means if we map VA of relocate_kernel() to the original PA
> where the code relocate_kernel() resides, then the above code will never be
> able to read those data back since they were saved to the control page.
> 
> Did I miss anything?

Note that relocate_kernel() usage at (*) is inside identity_mapped(). We
run from identity mapping there. Nothing changed to identity mapping
around relocate_kernel(), only top mapping (at __START_KERNEL_map) is
affected.

But I didn't test kexec jump thing. Do you (or anybody else) have setup to
test it?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

