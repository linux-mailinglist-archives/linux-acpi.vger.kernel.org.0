Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17A33DD1E7
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Aug 2021 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhHBI0a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Aug 2021 04:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhHBI0a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Aug 2021 04:26:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD21DC061798
        for <linux-acpi@vger.kernel.org>; Mon,  2 Aug 2021 01:26:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h14so32255273lfv.7
        for <linux-acpi@vger.kernel.org>; Mon, 02 Aug 2021 01:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kz70ZSfw0gF/+Eh/YJkSF3/zSs7YIozU2Kk7aShS8/8=;
        b=J5xAHujnzexFvkkaoEUTfQIY3kAfoX3t0epqE64o+NeLDaqffL2McvcjUUxw2ktQY7
         hq1E6o9GZ/ylYc3n6snTUXx8AnF+RKXZ9lAKxmM5HDmf83z/7B6YEyTs//qYuxKAa6dZ
         bEJH6KNuLOf1wy7fYK22finBSH/SV7Ds+XeVfwiJJACQJHs4ERQg3gYHwNRm9X+mRL6Y
         /0tozTp22V26v4/JQKKeDj8ZFY+Pb4bX1pYHZVSE3r8Ok43kmkwDlsDXUrYG7jwC4Uba
         JzJUSDBcpFT+S/hNuHDbo/L8+V7thyZzJPIdqFsRp3PCMt71hTrIDtdQNTjKXjZFvyvp
         a0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kz70ZSfw0gF/+Eh/YJkSF3/zSs7YIozU2Kk7aShS8/8=;
        b=sDrVL4yzNI+mXI7fV2el5VfzhhU41MaLwrgshMCBFXrpeyNKnDh11XoAmyCoz+3F6V
         44AMGMPWiGgBX/hVgyGhqmdsazNuyk05XOGNn5RPwhm2OYbj4NCIA+c2jYDSRsuVBQQM
         e0ZViSMFRl/8q7yQLFTeE06gGsIknoA3STaiv9LDdXau6NpjQgT8G5YtEe4NRdyH/Z2M
         gptNWCfpyCYsxPj+s6OHIvfKwYH9coM7bY7O+wz0tuqn3AngNK0jaFEchlKv9u1xWsyc
         bnvYV3hVjfWF1sDKi8fXTTDKoZPYbw2Z2FGUAE7zfOMwqyotfxUfoih3VT9fGlwf7Jh1
         O48w==
X-Gm-Message-State: AOAM532oHKUM1DmRZt0u3FhXaxhxbjjWEfMOeV2egC8bSAq3dUyLdo7U
        T4tBakQhQx4QsprW22Smq50UCw==
X-Google-Smtp-Source: ABdhPJw4L1rfWJyd67FPpqtde+HLzdTeW90cWbvOk2oF2MTjUInXvrFZCt9sc56KfGp6ReXUQE5Rzw==
X-Received: by 2002:a05:6512:1689:: with SMTP id bu9mr4154164lfb.147.1627892779032;
        Mon, 02 Aug 2021 01:26:19 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r11sm840514ljp.135.2021.08.02.01.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 01:26:18 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 067C3102B6D; Mon,  2 Aug 2021 11:26:22 +0300 (+03)
Date:   Mon, 2 Aug 2021 11:26:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2] memblock: make memblock_find_in_range method private
Message-ID: <20210802082621.xfbrdg2c6glwz3oq@box.shutemov.name>
References: <20210802063737.22733-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802063737.22733-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 02, 2021 at 09:37:37AM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> There are a lot of uses of memblock_find_in_range() along with
> memblock_reserve() from the times memblock allocation APIs did not exist.
> 
> memblock_find_in_range() is the very core of memblock allocations, so any
> future changes to its internal behaviour would mandate updates of all the
> users outside memblock.
> 
> Replace the calls to memblock_find_in_range() with an equivalent calls to
> memblock_phys_alloc() and memblock_phys_alloc_range() and make
> memblock_find_in_range() private method of memblock.
> 
> This simplifies the callers, ensures that (unlikely) errors in
> memblock_reserve() are handled and improves maintainability of
> memblock_find_in_range().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Looks good to me:

Acked-by: Kirill A. Shutemov <kirill.shtuemov@linux.intel.com>

-- 
 Kirill A. Shutemov
