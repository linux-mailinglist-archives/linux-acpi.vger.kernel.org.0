Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CF03DB75F
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jul 2021 12:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbhG3Krs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Jul 2021 06:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbhG3Krr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jul 2021 06:47:47 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0633C0613CF;
        Fri, 30 Jul 2021 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WD2Ag4JED4QIsvoIQN/gUdEl19MyG+gX26ckt/2TnRM=; b=wNjsq2UUJjLuncBCL1YsnTrm0
        YXYmurFWsXKUm2L2J6I/ypUlXwg6ahaMW1adauhejdybPNoV1znnmnxnBQE7zBZc3hiHNA70er0TI
        QnYpssBHkV8KBet2y5hmFMhE39l0DvuwgvbgZ0fqc5k0GCfAVD82AU47p5lagEFMKX6EwrPmcUuQf
        0RzJNbNT94GC9OKKBbbhwI8Po+HCAFRODBNYzP5zCse901ce9un9gcI6vTyY548AnZny/xjNRDv6s
        Lb108Ee4PLeZUMVJX0zUdAchyPz3c4fqfDYw0Cckeo3R8jGRFEZmHnrutm/pKoieeyzfQfhmhr16V
        0fey8HIUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46754)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m9Q2U-0002GT-LV; Fri, 30 Jul 2021 11:46:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m9Q2N-0008Nd-T1; Fri, 30 Jul 2021 11:46:43 +0100
Date:   Fri, 30 Jul 2021 11:46:43 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Len Brown <lenb@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] memblock: make memblock_find_in_range method private
Message-ID: <20210730104643.GG22278@shell.armlinux.org.uk>
References: <20210730104039.7047-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730104039.7047-1-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 30, 2021 at 01:40:39PM +0300, Mike Rapoport wrote:
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index f97eb2371672..1f8ef9fd5215 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -1012,31 +1012,25 @@ static void __init reserve_crashkernel(void)
>  		unsigned long long lowmem_max = __pa(high_memory - 1) + 1;
>  		if (crash_max > lowmem_max)
>  			crash_max = lowmem_max;
> -		crash_base = memblock_find_in_range(CRASH_ALIGN, crash_max,
> -						    crash_size, CRASH_ALIGN);
> +
> +		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> +						       CRASH_ALIGN, crash_max);
>  		if (!crash_base) {
>  			pr_err("crashkernel reservation failed - No suitable area found.\n");
>  			return;
>  		}
>  	} else {
> +		unsigned long long crash_max = crash_base + crash_size;
>  		unsigned long long start;
>  
> -		start = memblock_find_in_range(crash_base,
> -					       crash_base + crash_size,
> -					       crash_size, SECTION_SIZE);
> +		start = memblock_phys_alloc_range(crash_size, SECTION_SIZE,
> +						  crash_base, crash_max);
>  		if (start != crash_base) {
> -			pr_err("crashkernel reservation failed - memory is in use.\n");
> +			pr_err("crashkernel reservation failed - No suitable area found.\n");

This change to the error message is incorrect. In this code block, we
are trying to get the exact specified memory block - it is not about
there being "no suitable area" - the requested memory block is not
available. So, the original message carries the exact correct meaning.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
