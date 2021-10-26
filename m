Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A79943AA79
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 04:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhJZCuH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 22:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhJZCuG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2021 22:50:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C3C061745
        for <linux-acpi@vger.kernel.org>; Mon, 25 Oct 2021 19:47:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y1-20020a17090a134100b001a27a7e9c8dso622476pjf.3
        for <linux-acpi@vger.kernel.org>; Mon, 25 Oct 2021 19:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2PXeB/4PQmmNIVv0tjcWenU81mS3DZMt84NMbEQvTyM=;
        b=UNVL/kyvv2uaSY8fN83eiLokM/XCLP55KoMB97wJu9hwO59ewFsianlRw4/bL0r3iT
         +T7tujyqpF9E7sTSMtzQ9vXNrdUP99SoOIsBikSLC1DqO80xKbIA/3DtympxmOixw7aS
         8dd/HRz7AL3bEkqcxwoEzgSHYojuX5Am5+MtO0UCOZtvodWFyE9aOa2U8xHnsQF9qRzD
         Ats5rS5Fgz6NLUw4CP3F/w3wJvlFy9KT6K23TU5/wy/vtU0mFdQ6WZpnunqIUttDvaTL
         xp/1h6B6b9rGpmSCC8UieOQFhIX4ERA41F4Ej68vqHg/oFeq/V/TSrf5pjRYaCC7fsKu
         kSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PXeB/4PQmmNIVv0tjcWenU81mS3DZMt84NMbEQvTyM=;
        b=bZLoO1QW/aab1mbt/OKfbpZbjCwi/mRPhUHO/6LOgTQQ43+LWrxNhqja1PWql3jOL2
         3KTPYwKM6wClcpqpfy0IOQ7mtXvMo1j1i543Qe72xgAHOWQ7PglhRHGVzTsyjvH6zo1K
         WW4wet1SGOdFoxOvtFzq6FbynNq78Rde5XOxzBY89BEHPXiykVSpAuonL30T2z2+FV6i
         egWG96lOcf2P1P3eJD0zLZ0he5szX1JimfBalTAEwEiuoEZGaBBknQpiOIjQ6HTHh17f
         b4hgfUAsGZ62PVwlCEwc4aHLSuyRRTGSza1et283+Uzm3FoKjFHtj9Dyh78lhPRI8PLl
         8Ing==
X-Gm-Message-State: AOAM532RGot4EcAW4pPLhQc7oBx51fZWh26nV+ACo+iHpjtCF6dS7k/K
        H0CGkDx0O8ycXK3ZAUhUqIQLxtRlycIVnK8ge1Z1ReIvbD7UPw==
X-Google-Smtp-Source: ABdhPJwFI9nPmLcgputEn/KwWMHsWvsGFhi0VPKiDfptzLE9+xq9aljgXSofGzQujcUmyuwcC5gTtCh6Ve8p0WhDi5g=
X-Received: by 2002:a17:902:ab50:b0:13f:4c70:9322 with SMTP id
 ij16-20020a170902ab5000b0013f4c709322mr19677267plb.89.1635216462978; Mon, 25
 Oct 2021 19:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211019050908.449231-1-alison.schofield@intel.com>
In-Reply-To: <20211019050908.449231-1-alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Oct 2021 19:47:32 -0700
Message-ID: <CAPcyv4hdC4Uj8YdePMZGFkxgP10VSkX1tiY+ApPctyjfURPSOg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: NUMA: Add a node and memblk for each CFMWS not
 in SRAT
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

On Mon, Oct 18, 2021 at 10:01 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> During NUMA init, CXL memory defined in the SRAT Memory Affinity
> subtable may be assigned to a NUMA node. Since there is no
> requirement that the SRAT be comprehensive for CXL memory another
> mechanism is needed to assign NUMA nodes to CXL memory not identified
> in the SRAT.
>
> Use the CXL Fixed Memory Window Structure (CFMWS) of the ACPI CXL
> Early Discovery Table (CEDT) to find all CXL memory ranges.
> Create a NUMA node for each CFMWS that is not already assigned to
> a NUMA node. Add a memblk attaching its host physical address
> range to the node.
>
> Note that these ranges may not actually map any memory at boot time.
> They may describe persistent capacity or may be present to enable
> hot-plug.
>
> Consumers can use phys_to_target_node() to discover the NUMA node.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> Changes in v3:
> - Initial variable pxm (Ben)
>
> Changes in v2:
> - Use MAX_NUMNODES as max value when searching node_to_pxm_map() (0-day)
> - Add braces around single statement for loop (coding style)
> - Rename acpi_parse_cfmws() to acpi_cxl_cfmws_init to be more like other
>   functions in this file doing similar work.
> - Comments: remove superflous and state importance of the init order,
>   CFMWS after SRAT, (Ira, Dan)
> - Add prototype for numa_add_memblk() (0-day)
>
>  drivers/acpi/numa/srat.c | 70 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/acpi.c       |  8 +++--
>  include/linux/acpi.h     |  1 +
>  3 files changed, 76 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index b8795fc49097..daaaef58f1e6 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -300,6 +300,67 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>  }
>  #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
>
> +static int __init acpi_cxl_cfmws_init(struct acpi_table_header *acpi_cedt)
> +{
> +       struct acpi_cedt_cfmws *cfmws;
> +       acpi_size len, cur = 0;
> +       int i, node, pxm = 0;

Shouldn't this be -1, on the idea that the first numa node to assign
if none are set is zero?

I don't think the way you have it is a problem in practice because
SRAT should always be there in a NUMA system. However, the first CFMWS
pxm should start after the last SRAT entry, or 0 if no SRAT entries.

> +       void *cedt_subtable;
> +       u64 start, end;
> +
> +       /* Find the max PXM defined in the SRAT */
> +       for (i = 0; i < MAX_NUMNODES - 1; i++) {

How about:

    for (i = 0, pxm = -1; i < MAX_NUMNODES -1; i++)

...just to keep the initialization close to the use, but that's just a
personal style preference.

> +               if (node_to_pxm_map[i] > pxm)
> +                       pxm = node_to_pxm_map[i];
> +       }
> +       /* Start assigning fake PXM values after the SRAT max PXM */
> +       pxm++;
> +
> +       len = acpi_cedt->length - sizeof(*acpi_cedt);
> +       cedt_subtable = acpi_cedt + 1;
> +
> +       while (cur < len) {

Similarly to above I wonder if this would be cleaner as a for loop
then you could use typical "continue" statements rather than goto. I
took a stab at creating a for_each_cedt() helper which ended up a
decent cleanup for drivers/cxl/

 drivers/cxl/acpi.c |   48 +++++++++++++++---------------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

...however, I just realized this NUMA code is running at init time, so
it can just use the acpi_table_parse_entries_array() helper to walk
the CFMWS like the othe subtable walkers in acpi_numa_init(). You
would need to update the subtable helpers (acpi_get_subtable_type() et
al) to recognize the CEDT case.

[ Side note for the implications of acpi_table_parse_entries_array()
for drivers/cxl/acpi.c ]

Rafael, both the NFIT driver and now the CXL ACPI driver have open
coded subtable parsing. Any philosophical reason to keep the subtable
parsing code as __init? It can still be __init and thrown away if
those drivers are not build-time enabled.


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
> +               /*
> +                * Skip if the SRAT already described
> +                * the NUMA details for this HPA.
> +                */
> +               node = phys_to_target_node(start);
> +               if (node != NUMA_NO_NODE)
> +                       goto next;
> +
> +               node = acpi_map_pxm_to_node(pxm);
> +               if (node == NUMA_NO_NODE) {
> +                       pr_err("ACPI NUMA: Too many proximity domains.\n");

I would add "while processing CFMWS" to make it clear that the BIOS
technically did not declare too many PXMs; it was the Linux heuristic
for opportunistically emulating more PXMs.

> +                       return -EINVAL;
> +               }
> +
> +               if (numa_add_memblk(node, start, end) < 0) {
> +                       /* CXL driver must handle the NUMA_NO_NODE case */
> +                       pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> +                               node, start, end);
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
> @@ -478,6 +539,15 @@ int __init acpi_numa_init(void)
>         /* SLIT: System Locality Information Table */
>         acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
>
> +       /*
> +        * CEDT: CXL Fixed Memory Window Structures (CFMWS)
> +        * must be parsed after the SRAT. It creates NUMA
> +        * Nodes for CXL memory ranges not already defined
> +        * in the SRAT and it assigns PXMs after the max PXM
> +        * defined in the SRAT.
> +        */
> +       acpi_table_parse(ACPI_SIG_CEDT, acpi_cxl_cfmws_init);
> +
>         if (cnt < 0)
>                 return cnt;
>         else if (!parsed_numa_memblks)
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 10120e4e0b9f..ccf73f0a59a7 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -122,9 +122,11 @@ static void cxl_add_cfmws_decoders(struct device *dev,
>                                 cfmws->base_hpa, cfmws->base_hpa +
>                                 cfmws->window_size - 1);
>                 } else {
> -                       dev_dbg(dev, "add: %s range %#llx-%#llx\n",
> -                               dev_name(&cxld->dev), cfmws->base_hpa,
> -                                cfmws->base_hpa + cfmws->window_size - 1);
> +                       dev_dbg(dev, "add: %s node: %d range %#llx-%#llx\n",
> +                               dev_name(&cxld->dev),
> +                               phys_to_target_node(cxld->range.start),
> +                               cfmws->base_hpa,
> +                               cfmws->base_hpa + cfmws->window_size - 1);
>                 }
>                 cur += c->length;
>         }
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 974d497a897d..f837fd715440 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -426,6 +426,7 @@ extern bool acpi_osi_is_win8(void);
>  #ifdef CONFIG_ACPI_NUMA
>  int acpi_map_pxm_to_node(int pxm);
>  int acpi_get_node(acpi_handle handle);
> +int __init numa_add_memblk(int nodeid, u64 start, u64 end);

This doesn't belong here.

There is already a declaration for this in
arch/x86/include/asm/numa.h. I think what you are missing is that your
new code needs to be within the same ifdef guards as the other helpers
in srat.c that call numa_add_memblk(). See the line that has:

#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)

...above acpi_numa_slit_init()
