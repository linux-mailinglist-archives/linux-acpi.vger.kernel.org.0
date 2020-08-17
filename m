Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B787246679
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Aug 2020 14:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHQMk1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Aug 2020 08:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgHQMkZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Aug 2020 08:40:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FCFC061389
        for <linux-acpi@vger.kernel.org>; Mon, 17 Aug 2020 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kPX7uucdoka0ZvSXRaVntCSyiwnPatZnzCVSAO9KpxM=; b=ZpNAg+qbDhU2t2IRkndtL/kiNc
        BJCxQNgrcVn6XPOBairUbBc/dFMDwqRjf2M1eAUhsrAF6T3YTpdHqXX9isGiiEcNJeutMlRJj3lWP
        /qZfvIWsOyKcB3ZwBef696kuTi/NPC8xU7cLDJKIsZjIClt3MPWFg9tSxm0aEzjrDcaT9FxT2Tvkw
        aURO903t08VJkzMhGGBlWAi3OgbNWMRjG36YioXAosrdfui8C9WF15K8Mio4yGKybVWLKNdxAfv8U
        fOTzrVTcN6G/4OM4axFQg1ypgjsF7GliePDzqBZfzRw0LOdKBhw6u5ZNyIrS9sR1SQFI5ldBNcr1l
        1O8mPf4g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7eR4-0007kN-4F; Mon, 17 Aug 2020 12:40:22 +0000
Date:   Mon, 17 Aug 2020 13:40:22 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, rjw@rjwysocki.net, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, lenb@kernel.org
Subject: Re: [PATCH] ACPI: ioremap: avoid redundant rounding to OS page size
Message-ID: <20200817124022.GA27387@infradead.org>
References: <20200817120431.32233-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817120431.32233-1-ardb@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 17, 2020 at 02:04:31PM +0200, Ard Biesheuvel wrote:
> The arm64 implementation of acpi_os_ioremap() was recently updated to
> tighten the checks around which parts of memory are permitted to be
> mapped by ACPI code, which generally only needs access to memory regions
> that are statically described by firmware, and any attempts to access
> memory that is in active use by the OS is generally a bug or a hacking
> attempt. This tightening is based on the EFI memory map, which describes
> all memory in the system.
> 
> The AArch64 architecture permits page sizes of 16k and 64k in addition
> to the EFI default, which is 4k, which means that the EFI memory map may
> describe regions that cannot be mapped seamlessly if the OS page size is
> greater than 4k. This is usually not a problem, given that the EFI spec
> does not permit memory regions requiring different memory attributes to
> share a 64k page frame, and so the usual rounding to page size performed
> by ioremap() is sufficient to deal with this. However, this rounding does
> complicate our EFI memory map permission check, due to the loss of
> information that occurs when several small regions share a single 64k
> page frame (where rounding each of them will result in the same 64k
> single page region).
> 
> However, due to the fact that the region check occurs *before* the call
> to ioremap() where the necessary rounding is performed, we can deal
> with this issue simply by removing the redundant rounding performed by
> acpi_os_map_iomem(), as it appears to be the only place where the
> arguments to a call to acpi_os_ioremap() are rounded up. So omit the
> rounding in the call, and instead, apply the necessary offset to the
> result of kmap().
> 
> Fixes: 1583052d111f ("arm64/acpi: disallow AML memory opregions to access kernel memory")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

To me the whole acpi_map() / acpi_os_map_iomem() concept looks bogus,
especially as it mixes up iomem and RAM pages in a really bad way,
and then throws in staic fixmap-like mappings as well.

Also looking at the callers I see no point in keeping a list of the
memory mappings.  Does anyone have an idea where this craziness comes
from?  Which of the callers actually has to deal both with iomem and
RAM mappings at the same time?

It seems like we should be able to untangle the few callers and remove
this mess entirely.
