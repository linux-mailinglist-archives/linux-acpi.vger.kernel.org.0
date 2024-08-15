Return-Path: <linux-acpi+bounces-7588-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24BF952936
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 08:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3E228616C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 06:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A6C176FD2;
	Thu, 15 Aug 2024 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="If2Rgk+v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DC51448C1
	for <linux-acpi@vger.kernel.org>; Thu, 15 Aug 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723702559; cv=none; b=DQu0F1eIFCBl1RsArmCfr77CoafJtbrqpiSxOfZdOFsB5jJU3HhRchWAUM0SLEI7sPDR2NL4xrtC/wRC4mKo7PqytiLNegmewEgwFxGYDx9TNZIRbxsQD/9P35nL1ftnYqZU7mloPG29B2C17Rzobm3DcGx1xigB5P4W2d2otIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723702559; c=relaxed/simple;
	bh=S8PNyXOQnc3mwGHU4eSI2S+cpcf8X8gSb4qxEwdbdyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b30LYIaDIGTE9XEu35BWCQiEDrVIU7dve5UFpUU1F/BDB7ySyTIg46KmXTWxnXATLfQY/ilcQ1JwMG1IWbXDN/ytqrPGtMo+DgjWh2R9ngeSfwSRhvGnQyEMcsBPVB+sUVe3tKgMsIf+STFwRIfT+FJjkkikHk0PVk69B2zRNEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=If2Rgk+v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723702556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nmwt07YE+Usdtz1whTnqs27V8jSWf6riHC8dnsAJ1qU=;
	b=If2Rgk+vsP1GyvH7ciuAz0/luqtU27BmDHja3xNdeVTuGUijY/PkWjWgnWPEYjdQyBD9sL
	uNhj3ivT0QDt+8tKeQ05KEv3DaVl4zuvnENt6T3V/212lWAlPhWfwwFsBhPhs6jvgv2GZ9
	zkTOcKtr8FVnyeb2jGMn6hSdHi8AUDA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-oBnMItcDOvmNi3Zti2vySA-1; Thu,
 15 Aug 2024 02:15:51 -0400
X-MC-Unique: oBnMItcDOvmNi3Zti2vySA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9066D1954B11;
	Thu, 15 Aug 2024 06:15:47 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AF3C1955F6B;
	Thu, 15 Aug 2024 06:15:44 +0000 (UTC)
Date: Thu, 15 Aug 2024 14:15:40 +0800
From: Baoquan He <bhe@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCHv2 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Message-ID: <Zr2dDKP4JuRUSOL3@MiWiFi-R3L-srv>
References: <20240814124613.2632226-1-kirill.shutemov@linux.intel.com>
 <20240814124613.2632226-4-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814124613.2632226-4-kirill.shutemov@linux.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Cc Eric and kexec mailing list.

On 08/14/24 at 03:46pm, Kirill A. Shutemov wrote:
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
> overwritten until swap_pages() is called, and the relocate_kernel()
> virtual address will not be used by then.

I haven't read these codes for long time, wondering if we still need
copy relocate_kernel() to image->control_code_page + PAGE_SIZE as you
said.

> 
> Map the original relocate_kernel() at the relocate_kernel() virtual
> address in the identity mapping. It is preparation to replace the
> init_transition_pgtable() implementation with a call to
> kernel_ident_mapping_init().
> 
> Note that while relocate_kernel() switches to the identity mapping, it
> does not flush global TLB entries (CR4.PGE is not cleared). This means
> that in most cases, the kernel still runs relocate_kernel() from the
> original physical address before the change.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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
> -- 
> 2.43.0
> 


