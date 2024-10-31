Return-Path: <linux-acpi+bounces-9196-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B8C9B7CC3
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 15:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AFD281742
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5059419B3C5;
	Thu, 31 Oct 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NqBfKA4K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6E142AA5;
	Thu, 31 Oct 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384639; cv=none; b=gxFm13xWIiCbfTmHpJHjseW5p2AfrF5UtGKHWRahuCFPeTJcet5FGHFmFb+bcJRmOIavtliYPdpraTovxsXCIQauymxqfsLVaDwhfkxB8h5reXx41ty28nZbkxKDztXWclPNj1o6pCfFFNc8BcwYdUhhFHpLxF6bolqkxE3pEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384639; c=relaxed/simple;
	bh=H1Jp3Eg6E4fHBpF5GYRklWf4a0t9FjB4azHH3cRT3W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hF8LSCWAgqklxcpEtD79dOjfduxkDd3RacMxgfDZ9gdtrmI9s4M4xqKfCuD6sT8DszQ5YYLi2RuSM4MaLstgbFQVZSoLewgXNEtLZkFBZkB5Vkn1kQBh42QABNC/pkD0Bh2ZCmDX/yXF6tKyZQSsJuSVjqOQpWO7Hp63BVw87Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NqBfKA4K; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A3F7B40E0219;
	Thu, 31 Oct 2024 14:23:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o8pRZ717O3Mn; Thu, 31 Oct 2024 14:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730384629; bh=TKKTDUk0ZXKijGga9iQFEGt/jssCC5AbXxtB6T55K3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqBfKA4KWjWcr8JO2xzei/8PtUXbdQokvHuvhZE2QQQuEYZr7ArVWy2U/GSj6bqO9
	 pt/AW3c2xbD5Hhbt79+/d9TbH6AojQll+airAvvcN4vguvixVik/vl4glChPiI9SYl
	 UCAm+len+Va4sxlLpgvrSF/oykBLbmQuLxuIyQOslW43UwK5/NvuDzebCdf4lRCUIb
	 N0Sa3O7DKhLtNaSQzPRBiqyLDeJ/PC93UkrjphI0DuES04J2oRlD+jQhOSSXsfGgTR
	 Yk8ZKEDzkIJTABZ0yR3OvMOUnTTiAcbkyroNJRL52QL720Uj3RDAEQeezxJ+56Ju+R
	 fIa8zBU37gB+5BBx6MmOsLKL3W2PXq1v3lDFPuDO7CeUIO+/eufvb19Dmj6CY+GOZ0
	 FRBXIDnHKurNpz4Ke2WlfsvVm0beyEZRtpmMV+c/8npmoQ1y1/B3HHXi4NXrchzrA/
	 aW5l1IHi+B9uqKY7sx+uQSWWKdJwL079sCOiDgsCtpnHnGYkeflxoz3G8A0gOw0zbc
	 OH46Cn7FAI1p+dmkwqWxqkCJFbikEj8Wuvz4BIGg9iqoduUaUuMJwIauNT+O2oWJBG
	 7Pj+08ohnUNfD5t4SGufEtkaqJiuaC8QNOfO9RNjjQzTujdz7umJBTgXVrefSLRqFk
	 kfeKgXd16O9Ew9ZVK1CdDDdo=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E365E40E019C;
	Thu, 31 Oct 2024 14:23:30 +0000 (UTC)
Date: Thu, 31 Oct 2024 15:23:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Baoquan He <bhe@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCHv4, REBASED 3/4] x86/64/kexec: Map original
 relocate_kernel() in init_transition_pgtable()
Message-ID: <20241031142324.GJZyOS3G62E3pn9ZJ-@fat_crate.local>
References: <20241016111458.846228-1-kirill.shutemov@linux.intel.com>
 <20241016111458.846228-4-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016111458.846228-4-kirill.shutemov@linux.intel.com>

On Wed, Oct 16, 2024 at 02:14:57PM +0300, Kirill A. Shutemov wrote:
> The init_transition_pgtable() function sets up transitional page tables.
> It ensures that the relocate_kernel() function is present in the
> identity mapping at the same location as in the kernel page tables.
> relocate_kernel() switches to the identity mapping, and the function
> must be present at the same location in the virtual address space before
> and after switching page tables.
> 
> init_transition_pgtable() maps a copy of relocate_kernel() in
> image->control_code_page at the relocate_kernel() virtual address, but
> the original physical address of relocate_kernel() would also work.
> 
> It is safe to use original relocate_kernel() physical address cannot be
					^^^^^^^^^^^^^^^

something went missing here in that sentence. Reads weird.

> overwritten until swap_pages() is called, and the relocate_kernel()
> virtual address will not be used by then.

...

> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 9c9ac606893e..645690e81c2d 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -157,7 +157,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
>  	pte_t *pte;
>  
>  	vaddr = (unsigned long)relocate_kernel;
> -	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
> +	paddr = __pa(relocate_kernel);
>  	pgd += pgd_index(vaddr);
>  	if (!pgd_present(*pgd)) {
>  		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);

Such changes always make me nervous so I'd queue them only after this merge
window is over so that they can get maximal testing in next. Unless someone
objects...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

