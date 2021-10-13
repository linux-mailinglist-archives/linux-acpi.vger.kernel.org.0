Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A421942CF18
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Oct 2021 01:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhJMXVM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Oct 2021 19:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhJMXVJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Oct 2021 19:21:09 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE2BC061749
        for <linux-acpi@vger.kernel.org>; Wed, 13 Oct 2021 16:19:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f5so3748186pgc.12
        for <linux-acpi@vger.kernel.org>; Wed, 13 Oct 2021 16:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8F6QacKnx9bKC7ori5ib+tNKgUfJyKI20f72kw96skY=;
        b=tcqQxhj0A2dap2eUVPJGd1OGFkvxLd73pD6MXUP5JL4InZirOCIZkrnHuJTyJARaoJ
         JVpPuSRO/+P5fciCKjFDNlCd8lnoHq4nCRzJnado8Q/yFQEZRg2Ud4SUgYITMegipOu3
         Ic9edbY8m7bejH1ZVtiPB1tUViVTy1wtrs/4qv4m0BoOOxetHJW1nDnsQiTVHDfhh5AM
         Ys8yhLP6IhmkLYOvo2k/2T9wWiGsdXJ0dBsl3P17VFDJXq29DyoO6Xr4+dxoEOsRYL7o
         3g5AZArbSRAUYM8AWDWNkzAgBqcVwgBFV3DSGOqciHXgbNaZT9FJav9e0H9oSIehTMHj
         fgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8F6QacKnx9bKC7ori5ib+tNKgUfJyKI20f72kw96skY=;
        b=KTRQy2P8CltLFRyGDmL3kGjewmOUsYPwhgK6V05PPCGVXhOCJif1ylmh0VZIeqcy1o
         zmAARfxz1byiwVodDXRRBOEkyyDZF3MnuAvN3e1h74n64gWINpP16WYNuF5AFxUNvLci
         3P/JzkjYRaOMPMlzMnUDgIdgCSHufeDf4xHswz/U1kcoFxFt8A+WkXsbFibLu7ZoMU/+
         dcB7AYqOk3t/Nwa8xL/gKFQQFlpCovkurcMQ+Kc2xqlTFmp0HxcMY29ZaE28/Tc+GTt2
         y+f5hHY2a96QlcbVBr8AC+xH7l/J/y60bQtxLgeslxUOafNhwQSPozFS5NP6O57+u7/e
         bnPQ==
X-Gm-Message-State: AOAM532IsDpU6i9je6ExDjhAzdc8Vnv+kXDg9uTNKtWIv18mazWncUlA
        3e07QCpj4wAHYKKt82vD5OUeXwmy3AG2Rvu65wQeQg==
X-Google-Smtp-Source: ABdhPJyWelFX1/3M8Ccpjs57F+/eC2wklDYgrynWuClHTpqRcm4jFu0eaoQOyscKfD1Z2AWLasE5fON4JxoQrPrqpNk=
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr1614990pge.5.1634167145281;
 Wed, 13 Oct 2021 16:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211009015339.400383-1-alison.schofield@intel.com>
In-Reply-To: <20211009015339.400383-1-alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Oct 2021 16:18:54 -0700
Message-ID: <CAPcyv4iOxLtX16ZDEwtfYHyK54dOqHNU54qjqvbotfF+5MHV4g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 8, 2021 at 6:45 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> During NUMA init, CXL memory defined in the SRAT Memory Affinity
> subtable may be assigned to a NUMA node. Since there is no
> requirement that the SRAT be comprehensive for CXL memory another
> mechanism is needed to assign NUMA nodes to CXL memory not identified
> in the SRAT.
>
> Use the CXL Fixed Memory Window Structure's (CFMWS) of the ACPI CXL
> Early Discovery Table (CEDT) to find all CXL memory ranges. Create a
> NUMA node for each range that is not already assigned to a NUMA node.
> Add a memblk attaching its host physical address range to the node.
>
> Note that these ranges may not actually map any memory at boot time.
> They may describe persistent capacity or may be present to enable
> hot-plug.
>
> Consumers can use phys_to_target_node() to discover the NUMA node.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/acpi/numa/srat.c | 58 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/acpi.c       |  8 +++---
>  2 files changed, 63 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index b8795fc49097..568e033e6c3f 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -300,6 +300,61 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>  }
>  #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
>
> +/* Add a NUMA node and memblk for each node-less CFMWS */
> +static int __init acpi_parse_cfmws(struct acpi_table_header *acpi_cedt)
> +{
> +       struct acpi_cedt_cfmws *cfmws;
> +       acpi_size len, cur = 0;
> +       void *cedt_subtable;
> +       int i, pxm, node;
> +       u64 start, end;
> +
> +       /* Use fake PXM values starting after the max PXM found in the SRAT */
> +       for (i = 0; i < MAX_PXM_DOMAINS - 1; i++)
> +               if (node_to_pxm_map[i] > pxm)
> +                       pxm = node_to_pxm_map[i];
> +       pxm++;
> +
> +       len = acpi_cedt->length - sizeof(*acpi_cedt);
> +       cedt_subtable = acpi_cedt + 1;
> +
> +       while (cur < len) {
> +               struct acpi_cedt_header *c = cedt_subtable + cur;
> +
> +               if (c->type != ACPI_CEDT_TYPE_CFMWS)
> +                       goto next;
> +
> +               cfmws = cedt_subtable + cur;
> +               if (cfmws->header.length < sizeof(*cfmws)) {
> +                       pr_warn_once("CFMWS entry skipped:invalid length:%u\n",
> +                                    cfmws->header.length);
> +                       goto next;
> +               }
> +
> +               start = cfmws->base_hpa;
> +               end = cfmws->base_hpa + cfmws->window_size;
> +
> +               /* Skip if the HPA is already assigned to a NUMA node */

Per below note about SRAT parsing dependency, perhaps change this to:

/* Skip if the SRAT already described the NUMA details for this HPA */


> +               node = phys_to_target_node(start);
> +               if (node != NUMA_NO_NODE)
> +                       goto next;
> +
> +               node = acpi_map_pxm_to_node(pxm);
> +               if (node == NUMA_NO_NODE) {
> +                       pr_err("ACPI NUMA: Too many proximity domains.\n");

I think this might be too harsh especially for nodes that are only
there to support potential future CXL hotplug.

Let's just report and continue for now because the CXL driver itself
can decide on a fallback node to hot-add CXL memory that the BIOS did
not setup.

> +                       return -EINVAL;
> +               }
> +               if (numa_add_memblk(node, start, end) < 0) {
> +                       pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> +                               node, start, end);

I think this error message is most likely to trigger in the case that
MAX_NUMNODES is exhausted, so the address range information should be
reported in the acpi_map_pxm_to_node() failure case.

> +               }
> +               pxm++;
> +next:
> +               cur += c->length;
> +       }
> +       return 0;
> +}
> +
>  static int __init acpi_parse_slit(struct acpi_table_header *table)
>  {
>         struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
> @@ -478,6 +533,9 @@ int __init acpi_numa_init(void)
>         /* SLIT: System Locality Information Table */
>         acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
>
> +       /* CEDT: CXL Early Discovery Table */

It might be worth a comment here that this *must* come after SRAT
parsing so that the CXL ranges that the BIOS already incorporated into
the system memory map can be skipped.

> +       acpi_table_parse(ACPI_SIG_CEDT, acpi_parse_cfmws);
> +
>         if (cnt < 0)
>                 return cnt;
>         else if (!parsed_numa_memblks)
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index dadc7f64b9ff..3798841c3418 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -144,9 +144,11 @@ static void cxl_add_cfmws_decoders(struct device *dev,
>                                 cfmws->window_size - 1);
>                         goto next;
>                 }
> -               dev_dbg(dev, "add: %s range %#llx-%#llx\n",
> -                       dev_name(&cxld->dev), cfmws->base_hpa,
> -                       cfmws->base_hpa + cfmws->window_size - 1);
> +               dev_dbg(dev, "add:%s node:%d range:%#llx-%#llx restrict:%#x\n",
> +                       dev_name(&cxld->dev),
> +                       phys_to_target_node(cxld->range.start),
> +                       cxld->range.start, cxld->range.end,
> +                       cfmws->restrictions);
>  next:
>                 cur += c->length;
>         }
> --
> 2.31.1
>
