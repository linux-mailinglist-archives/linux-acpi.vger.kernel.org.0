Return-Path: <linux-acpi+bounces-9077-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3745B9B4D16
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 16:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DCA1C21C98
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 15:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8950718E379;
	Tue, 29 Oct 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOlJ4yrv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ED31885BD;
	Tue, 29 Oct 2024 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214606; cv=none; b=LjSbySQP4A2K03q/IIk0eUCfyxXOGQM1kfibDHAXQVZeOZyR5smvgPP872YMB4G4vVGVBMKd+qhwxi+Sx+ZC1x4irk0Rtw0sumCoNUD2EY8w1o/LTztah6jlGBgiZWOu++w/iPNkf82Vzb1C20QLqNU4illeRJe17oHsafJaSFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214606; c=relaxed/simple;
	bh=zppHwKkF/7U28D07l6cGlNPFzKBueSR56H4LqPBf0Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kujxwtzzvp3sndZb/CeDBgmDWr5VF4d/iNHkwOMkoRhoPK/vk5RUCN2dvvZOlOqcK93fuWxvf4qmclRRwMa0bdNAK2HRl7MbAsKZ7EFI4zRaxs+WwTs2z/Oxog/WDHtrv/xRf90Tn7vitePrD6Bk0NwXKkCl3Ae1wQqO3lyFHqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOlJ4yrv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730214605; x=1761750605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zppHwKkF/7U28D07l6cGlNPFzKBueSR56H4LqPBf0Nc=;
  b=AOlJ4yrvcC1zKH7ypuTo9nZ4XM1dvV5cz26jvpescRNsgnq2oEWIYnyp
   TtrTlXvtByP5vCiv96ibdxPaPHNi6gUtITaVFlm/tWa2phrwcInWTztKW
   rf2A3aoENCwzBfGttdorl26IXVvVvYkKMEVj84ntvv4Z3TyU8lzKlb2iu
   GohnpfXx58WL4VqppBV6BsSKkd+bxL1ZiNQ00yxzQr6NUSBFwh3W7Kjgu
   jYCpu7VKbMD6G4bAxv0I5vuqCeXvpV4FQ/EWQ7YhfHLhkfipNB2lWrqJv
   2ljrHMqcHw9wXB6BXqbjRM6CW/IZ4VwZ8ZqvPcWL2+GJh5MOtTJShEnB0
   g==;
X-CSE-ConnectionGUID: r2ss6uRCSBK+dss11/Zo3g==
X-CSE-MsgGUID: aRy8A01FSxW7NIQgwtKDIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40958759"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40958759"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:10:04 -0700
X-CSE-ConnectionGUID: KFOHjn+WTaKQ3zRyNQdZbA==
X-CSE-MsgGUID: hjkhL2pgR8qWEirbuh/+DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86548084"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 29 Oct 2024 08:10:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0743826B; Tue, 29 Oct 2024 17:09:58 +0200 (EET)
Date: Tue, 29 Oct 2024 17:09:58 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Baoquan He <bhe@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sean Christopherson <seanjc@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCHv4, REBASED 0/4] x86: Reduce code duplication on page
 table initialization
Message-ID: <jtibkddkdwyx2fljoztmxpirzdilm7go2maem4z3osbiqk7seb@5pfzpdsukbxf>
References: <20241016111458.846228-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016111458.846228-1-kirill.shutemov@linux.intel.com>

On Wed, Oct 16, 2024 at 02:14:54PM +0300, Kirill A. Shutemov wrote:
> Use kernel_ident_mapping_init() to initialize kernel page tables where
> possible, replacing manual initialization, reducing code duplication.
> 
> v4:
>  - Reviewed-bys from Kai;
>  - Fix comment in acpi_mp_setup_reset() (Rafael);
> v3:
>  - Reviewed-bys from Tom;
>  - Improve commit messages;
> v2:
>  - A separate patch to change what PA is mapped at relocate_kernel() VA.
>  - Improve commit messages;
>  - Add Reveiwed-by from Kai;
> 
> Kirill A. Shutemov (4):
>   x86/mm/ident_map: Fix virtual address wrap to zero
>   x86/acpi: Replace manual page table initialization with
>     kernel_ident_mapping_init()
>   x86/64/kexec: Map original relocate_kernel() in
>     init_transition_pgtable()
>   x86/64/kexec: Rewrite init_transition_pgtable() with
>     kernel_ident_mapping_init()
> 
>  arch/x86/include/asm/kexec.h       |  5 +-
>  arch/x86/kernel/acpi/madt_wakeup.c | 73 +++++-------------------
>  arch/x86/kernel/machine_kexec_64.c | 89 +++++++++++-------------------
>  arch/x86/mm/ident_map.c            | 14 +----
>  4 files changed, 50 insertions(+), 131 deletions(-)

Any feedback on this series?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

