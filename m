Return-Path: <linux-acpi+bounces-7708-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AE99583D5
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 12:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDD02871EF
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 10:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B6718CBE8;
	Tue, 20 Aug 2024 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OaZ/ox1p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2E18CBEC;
	Tue, 20 Aug 2024 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148814; cv=none; b=LqSXLlLAP8Voe1jRgYNwaRn77qX34zQI6qNXq3B6xSD3MmQ2SgUi2vgCJ7KQmtOhNb4bO3ZieFdudkR4mXi/YY0APDs0gxK7awzxRWYrqWK6I4PzJtiLhiphjkrZHVncsWdFxSnKdQCDAsbhoySKi2bze92mq8m41uY5/c2RhbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148814; c=relaxed/simple;
	bh=H+V92I1CFheUJuNQQxb6BnxqK1PBa1++hcmDmGIa5zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7xmlpVojCK/cY1BPavIf0H5oafQYwSwRjuKEe8iPCk6A2+++i0UlqV82On49lBk7EH348KiGN5ElcQCIcd0JENKr+VY0jszt67tD/4H71WyFTRCqR0YUk3U5rlTNIdTc3RwXH1K8vtZLU1+kJPimhAKAeBzA1FlkSsp5UBGyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OaZ/ox1p; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724148812; x=1755684812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H+V92I1CFheUJuNQQxb6BnxqK1PBa1++hcmDmGIa5zU=;
  b=OaZ/ox1p2l0XcOqBdKEUN4XovInvaaVdCaMRNj5r9avbAf29LW6IT09F
   ekBvi3haiVXpAAfBg+IYbRv9sMPMgoCiOuzL6GpeoB27hdBBu7yTYPJWg
   0wMeymHrt3wbFVZ3dHH2h+rAgq45vFzVLZKkOQQ21zPG35p35Og2WhWMU
   QMW5clyUcXfQWqc3seuTk3U7bs+/7e3vVBdzVKLtWBftgnAGg6+mBChAq
   nmHZHM+Q7/vBa6FBkGazGeR/i7nIcATaxvAAln2PwEDhiF5ocEFDkRpn6
   q44M8BOFRUzMnXfdhbQYJm5Mq7tkbuNTdHigxTiruZFGEUI7IPCwSMP2P
   A==;
X-CSE-ConnectionGUID: Nsqfq2SWQsy/RtvnHpHxKA==
X-CSE-MsgGUID: vhEvu28XTPallGoWYGjeBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="13111269"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="13111269"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:13:31 -0700
X-CSE-ConnectionGUID: RQ62qox5R02lVZ48yhKbgA==
X-CSE-MsgGUID: 5sfu+e4kQgeT/RMlVDDSOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60993767"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 20 Aug 2024 03:13:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 508C826D; Tue, 20 Aug 2024 13:13:26 +0300 (EEST)
Date: Tue, 20 Aug 2024 13:13:26 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, 
	"ardb@kernel.org" <ardb@kernel.org>, "luto@kernel.org" <luto@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>, 
	"rafael@kernel.org" <rafael@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv3 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Message-ID: <jzqh5j4w4w23xuigqj5bggbmx2hgte4u5tvbss3hqi3vjeodhl@rnmirwt6biol>
References: <20240819070827.3620020-1-kirill.shutemov@linux.intel.com>
 <20240819070827.3620020-4-kirill.shutemov@linux.intel.com>
 <4c140a8e0154504e9c645b9f78b0b164dc25a461.camel@intel.com>
 <hr7kym77uhbtj32eymcdp5mcbpid7euoiiszhx6yhkrbw5riag@lcozqjayilbo>
 <d97a17a53cb7550134ec521e3d22177d6a6ad05e.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d97a17a53cb7550134ec521e3d22177d6a6ad05e.camel@intel.com>

On Mon, Aug 19, 2024 at 12:39:23PM +0000, Huang, Kai wrote:
> On Mon, 2024-08-19 at 14:57 +0300, kirill.shutemov@linux.intel.com wrote:
> > On Mon, Aug 19, 2024 at 11:16:52AM +0000, Huang, Kai wrote:
> > > On Mon, 2024-08-19 at 10:08 +0300, Kirill A. Shutemov wrote:
> > > > The init_transition_pgtable() function sets up transitional page tables.
> > > > It ensures that the relocate_kernel() function is present in the
> > > > identity mapping at the same location as in the kernel page tables.
> > > > relocate_kernel() switches to the identity mapping, and the function
> > > > must be present at the same location in the virtual address space before
> > > > and after switching page tables.
> > > > 
> > > > init_transition_pgtable() maps a copy of relocate_kernel() in
> > > > image->control_code_page at the relocate_kernel() virtual address, but
> > > > the original physical address of relocate_kernel() would also work.
> > > > 
> > > > It is safe to use original relocate_kernel() physical address cannot be
> > > > overwritten until swap_pages() is called, and the relocate_kernel()
> > > > virtual address will not be used by then.
> > > > 
> > > > Map the original relocate_kernel() at the relocate_kernel() virtual
> > > > address in the identity mapping. It is preparation to replace the
> > > > init_transition_pgtable() implementation with a call to
> > > > kernel_ident_mapping_init().
> > > > 
> > > > Note that while relocate_kernel() switches to the identity mapping, it
> > > > does not flush global TLB entries (CR4.PGE is not cleared). This means
> > > > that in most cases, the kernel still runs relocate_kernel() from the
> > > > original physical address before the change.
> > > > 
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > ---
> > > >  arch/x86/kernel/machine_kexec_64.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > > > index 9c9ac606893e..645690e81c2d 100644
> > > > --- a/arch/x86/kernel/machine_kexec_64.c
> > > > +++ b/arch/x86/kernel/machine_kexec_64.c
> > > > @@ -157,7 +157,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
> > > >  	pte_t *pte;
> > > >  
> > > >  	vaddr = (unsigned long)relocate_kernel;
> > > > -	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
> > > > +	paddr = __pa(relocate_kernel);
> > > >  	pgd += pgd_index(vaddr);
> > > >  	if (!pgd_present(*pgd)) {
> > > >  		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
> > > 
> > > 
> > > IIUC, this breaks KEXEC_JUMP (image->preserve_context is true).
> > > 
> > > The relocate_kernel() first saves couple of regs and some other data like PA
> > > of swap page to the control page.  Note here the VA_CONTROL_PAGE is used to
> > > access the control page, so those data are saved to the control page.
> > > 
> > > SYM_CODE_START_NOALIGN(relocate_kernel)
> > >         UNWIND_HINT_END_OF_STACK
> > >         ANNOTATE_NOENDBR
> > >         /*      
> > >          * %rdi indirection_page
> > >          * %rsi page_list
> > >          * %rdx start address
> > >          * %rcx preserve_context
> > >          * %r8  bare_metal
> > >          */
> > > 
> > > 	...
> > > 
> > >         movq    PTR(VA_CONTROL_PAGE)(%rsi), %r11                             
> > >         movq    %rsp, RSP(%r11)                                              
> > >         movq    %cr0, %rax
> > >         movq    %rax, CR0(%r11)
> > >         movq    %cr3, %rax
> > >         movq    %rax, CR3(%r11)
> > >         movq    %cr4, %rax
> > >         movq    %rax, CR4(%r11)
> > > 
> > > 	...
> > > 
> > > 	/*
> > >          * get physical address of control page now
> > >          * this is impossible after page table switch
> > >          */
> > >         movq    PTR(PA_CONTROL_PAGE)(%rsi), %r8
> > > 
> > >         /* get physical address of page table now too */
> > >         movq    PTR(PA_TABLE_PAGE)(%rsi), %r9
> > > 
> > >         /* get physical address of swap page now */
> > >         movq    PTR(PA_SWAP_PAGE)(%rsi), %r10
> > > 
> > >         /* save some information for jumping back */
> > >         movq    %r9, CP_PA_TABLE_PAGE(%r11)
> > >         movq    %r10, CP_PA_SWAP_PAGE(%r11)
> > >         movq    %rdi, CP_PA_BACKUP_PAGES_MAP(%r11)
> > > 
> > > 	...
> > > 
> > > And after jumping back from the second kernel, relocate_kernel() tries to
> > > restore the saved data:
> > > 
> > > 	...
> > > 
> > >         /* get the re-entry point of the peer system */
> > >         movq    0(%rsp), %rbp
> > >         leaq    relocate_kernel(%rip), %r8		<---------  (*) 
> > >         movq    CP_PA_SWAP_PAGE(%r8), %r10
> > >         movq    CP_PA_BACKUP_PAGES_MAP(%r8), %rdi
> > >         movq    CP_PA_TABLE_PAGE(%r8), %rax
> > >         movq    %rax, %cr3
> > >         lea     PAGE_SIZE(%r8), %rsp
> > >         call    swap_pages
> > >         movq    $virtual_mapped, %rax
> > >         pushq   %rax
> > >         ANNOTATE_UNRET_SAFE
> > >         ret
> > >         int3
> > > SYM_CODE_END(identity_mapped)
> > > 
> > > Note the above code (*) uses the VA of relocate_kernel() to access the control
> > > page.  IIUC, that means if we map VA of relocate_kernel() to the original PA
> > > where the code relocate_kernel() resides, then the above code will never be
> > > able to read those data back since they were saved to the control page.
> > > 
> > > Did I miss anything?
> > 
> > Note that relocate_kernel() usage at (*) is inside identity_mapped(). We
> > run from identity mapping there. Nothing changed to identity mapping
> > around relocate_kernel(), only top mapping (at __START_KERNEL_map) is
> > affected.
> 
> Yes, but before this patch the VA of relocate_kernel() is mapped to the copied
> one, which resides in the control page:
> 
>         control_page = page_address(image->control_code_page) + PAGE_SIZE;
>         __memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
>         
>         page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
>         page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;    
> 
> So the (*) can actually access to the control page IIUC.
> 
> Now if we change to map VA of relocate_kernel() to the original one, then (*)
> won't be able to access the control page.

No, it still will be able to access control page.

So we call relocate_kernel() in normal kernel text (within
__START_KERNEL_map).

relocate_kernel() switches to identity mapping, VA is still the same.

relocate_kernel() jumps to identity_mapped() in the control page:


	/*
	 * get physical address of control page now
	 * this is impossible after page table switch
	 */
	movq	PTR(PA_CONTROL_PAGE)(%rsi), %r8

	...

	/* jump to identity mapped page */
	addq	$(identity_mapped - relocate_kernel), %r8
	pushq	%r8
	ANNOTATE_UNRET_SAFE
	ret

The ADDQ finds offset of identity_mapped() in the control page.

identity_mapping() finds start of the control page from *relative*
position of relocate_page() to the current RIP in the control page:

	leaq	relocate_kernel(%rip), %r8

It looks like this in my kernel binary:

	lea    -0xfa(%rip),%r8

What PA is mapped at the normal kernel text VA of relocate_kernel() makes
zero affect to the calculation.

Does it make sense?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

