Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEFA4F13B
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Jun 2019 01:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFUXmt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jun 2019 19:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfFUXms (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jun 2019 19:42:48 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC20B2084E;
        Fri, 21 Jun 2019 23:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561160568;
        bh=9jNNQ6ZuBBOjZIW3HIow9t4gY+OUpSdjtQl5zrDEMdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RDDEklul7g0TwzW9+rYABCiLxD3N9O7GjpeOksdPT5+/ufp4LUGpriR31HgIwLS4N
         su+rzFDliqa/VpGbuq7WC+iq0nUGUObMkXCICTQFtPxehIJZ4EugjMAlfNTPpNEqd2
         UO3XDcH6k2EANV4YmvD/OKPZrb5GXc3G08Mo32mA=
Date:   Fri, 21 Jun 2019 16:42:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, Andrew Banman <andrew.banman@hpe.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arun KS <arunks@codeaurora.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juergen Gross <jgross@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Len Brown <lenb@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Oscar Salvador <osalvador@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v3 0/6] mm: Further memory block device cleanups
Message-Id: <20190621164246.9a2354a571da41950bb74562@linux-foundation.org>
In-Reply-To: <1c2edc22-afd7-2211-c4c7-40e54e5007e8@redhat.com>
References: <20190620183139.4352-1-david@redhat.com>
        <1561130120.5154.47.camel@lca.pw>
        <1c2edc22-afd7-2211-c4c7-40e54e5007e8@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 21 Jun 2019 20:24:59 +0200 David Hildenbrand <david@redhat.com> wrote:

> @Qian Cai, unfortunately I can't reproduce.
> 
> If you get the chance, it would be great if you could retry with
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 972c5336bebf..742f99ddd148 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -868,6 +868,9 @@ int walk_memory_blocks(unsigned long start, unsigned
> long size,
>         unsigned long block_id;
>         int ret = 0;
> 
> +       if (!size)
> +               return;
> +
>         for (block_id = start_block_id; block_id <= end_block_id;
> block_id++) {
>                 mem = find_memory_block_by_id(block_id);
>                 if (!mem)
> 
> 
> 
> If both, start and size are 0, we would get a veeeery long loop. This
> would mean that we have an online node that does not span any pages at
> all (pgdat->node_start_pfn = 0, start_pfn + pgdat->node_spanned_pages = 0).

I think I'll make that a `return 0' and I won't drop patches 4-6 for
now, as we appear to have this fixed.



From: David Hildenbrand <david@redhat.com>
Subject: drivers-base-memoryc-get-rid-of-find_memory_block_hinted-v3-fix

handle zero-length walks

Link: http://lkml.kernel.org/r/1c2edc22-afd7-2211-c4c7-40e54e5007e8@redhat.com
Reported-by: Qian Cai <cai@lca.pw>
Tested-by: Qian Cai <cai@lca.pw>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/base/memory.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/base/memory.c~drivers-base-memoryc-get-rid-of-find_memory_block_hinted-v3-fix
+++ a/drivers/base/memory.c
@@ -866,6 +866,9 @@ int walk_memory_blocks(unsigned long sta
 	unsigned long block_id;
 	int ret = 0;
 
+	if (!size)
+		return 0;
+
 	for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
 		mem = find_memory_block_by_id(block_id);
 		if (!mem)


