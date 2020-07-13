Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7344521DAB7
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jul 2020 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgGMPsk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jul 2020 11:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbgGMPsj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jul 2020 11:48:39 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC4CC061755
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2020 08:48:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b15so14075381edy.7
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2020 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W36OcjXryM8jgoewQfeJp3IZBi2EgGKHyNoHZfcaUKg=;
        b=NB7aPTPiP9qMPZ0y5PyZjEZciyC3DGD/+k/bgqBjuSVN7xIiMDgNbsaF6/pgADNch+
         Ppp6lmsRYZBZaFrRPXfH/OKEHROSUnQaiibSBid42105KDuiFDu1QwTgOqxAL6c2lRjW
         MB7BlEtHL+kZqmH7hAMfNq/xbtRyDjIYnMpKNKQ38wZaBZBH3mGvzkSQ9nxlcL+jduGt
         GFhsoxForK/GfjOiwcjP4X5Npt3KHapXh9bsKOxwM98za+n3VD8+3bVQ2bTLNFDGInhy
         BOsBa2M/13YjYvQeW8U+bOZfC3IeaBPpjGLKUN+S0b/5sR0Bwju5V17YorGeaFaOIYCu
         VGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W36OcjXryM8jgoewQfeJp3IZBi2EgGKHyNoHZfcaUKg=;
        b=tGWU1ei7uSdtHZR7qpoWOsrM53op6eLQnvNVxyPLb+ERVQC/H0VpasRMxTLKxWYDe1
         BInUIokGarwXxO4IDmJGNR4+41t0yjFQLM2xoUojQF4PIXPELgjTDyCAOe51h+40MCoN
         IXGQJF2sRVPdYysRerXmq4GT3PMCO2IHS8pBDAePFqiQJH+pm2MfZKkH0d3hNG3Xvaw/
         gIb1C7OQBmsdsWr3EykaZptqBkKKREGUwnxB1yvMuA30cmhnwUfPHg9TTxRvm/EDs8+A
         PQ8c1thL1WbPdPeg1OIe8gA/wOuzIoQE4Wtr4d1pb0oncOg7BOR0IPrBAh2xLwsiP64J
         Klew==
X-Gm-Message-State: AOAM533yeMrJVuPyQQpkna8LAmqflLw9Pu+m1H0ZwW14nBvigf5HPTA8
        r2iDYND+zPeXgo1GomV8OfqVF6IJknDjEBrF0ya+ee1v
X-Google-Smtp-Source: ABdhPJy9eW9eIp+1KepqCPSTRPe76Dr5VVVESCrZMoaRV0JKP6GTk/JYXKXYNywspxI5vIOjjZtqBIKR4ru2y3M6GsE=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr73787edo.102.1594655318157;
 Mon, 13 Jul 2020 08:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457120893.754248.7783260004248722175.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200713070304.GC11000@linux.ibm.com>
In-Reply-To: <20200713070304.GC11000@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Jul 2020 08:48:27 -0700
Message-ID: <CAPcyv4iRJRz==VRgq=M_FYz0TfNKqKASOD1+NRfMLcHzEOBApQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/22] memblock: Introduce a generic phys_addr_to_target_node()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 13, 2020 at 12:04 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi Dan,
>
> On Sun, Jul 12, 2020 at 09:26:48AM -0700, Dan Williams wrote:
> > Similar to how generic memory_add_physaddr_to_nid() interrogates
> > memblock data for numa information, introduce
> > get_reserved_pfn_range_from_nid() to enable the same operation for
> > reserved memory ranges. Example memory ranges that are reserved, but
> > still have associated numa-info are persistent memory or Soft Reserved
> > (EFI_MEMORY_SP) memory.
>
> Here again, I would prefer to add a weak default for
> phys_to_target_node() because the "generic" implementation is not really
> generic.
>
> The fallback to reserved ranges is x86 specfic because on x86 most of the
> reserved areas is not in memblock.memory. AFAIK, no other architecture
> does this.

True, I was pre-fetching ARM using the new EFI "Special Purpose"
memory attribute. However, until that becomes something that platforms
deploy in practice I'm ok with not solving that problem for now.

> And x86 anyway has implementation of phys_to_target_node().

Sure, let's go with the default stub for non-x86.

Justin, do you think it would make sense to fold your dax_kmem
enabling for arm64 series into my enabling of dax_hmem for all
memory-hotplug archs?
