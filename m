Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE094277D5
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Oct 2021 09:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhJIHIj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Oct 2021 03:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhJIHIh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Oct 2021 03:08:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280F3C061570
        for <linux-acpi@vger.kernel.org>; Sat,  9 Oct 2021 00:06:41 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v18so45111399edc.11
        for <linux-acpi@vger.kernel.org>; Sat, 09 Oct 2021 00:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K07vELiPzCo4F/6j+VByXOHQT0ZLeJFPSDZblQhoo9Q=;
        b=dsF3gSTG4a6sKrREpQ1lJdIUdFnT4SxdYRaTSNplHB5kBdPrhTaVxgqOLD98FjKCJy
         WsEhlQPXNMwprylaA22zBcIuV8mbF+/CI+aHhmhW+dCx3sd/SRL2agHq5933ChwnKi6Q
         u3prA9VL18Jg9jTNAfCN4Wr7OHvIQNw3v5O6+kZmOROAID0aJaI7r4dOs6ZezDRolh3j
         jaeT6jUwC3FG7f1vPkGRz5CXVznOl9kIzBjFfvz8/Cei3tNtMUo7mqc1fJLl57XrDgmP
         HNRS4C8c8IJXGy/mMINz02aacm6EYlJ4zx2YGAy80kr2XofVLfXoTCN5FcG1qfXG5VqW
         cAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K07vELiPzCo4F/6j+VByXOHQT0ZLeJFPSDZblQhoo9Q=;
        b=igzg3CI1TIE6ZQl6ZyGvJTXh8Wc2vLRLXZ1+6kWIGCIi9eSrPsPtzcFvbThe/fhAVT
         BRzbhfvhSZO3WCrrGKpSficG1SFcd8GuvPQ6pWz/ndppM9ZAYnUcin0FAuTKFzm04IgT
         40vJSfmsi9KJJtGhve1KW3bH+jN6Up9XIO5rCKouTuedH8UfIHpZjoqiO7+jDAgGCd1B
         hae3Lz971lhi6woSDQ1e/WEbYABFsqXy1mid9Fv/5bdhEfPigfA/YPrQJuyXedgJdTDl
         kPwD7DWURPIoyRKXyGicMMb6M+viREW8LS3Zp21wLQPqeS+mLdRvKoDv309aoHjknSX2
         BZHw==
X-Gm-Message-State: AOAM530tKOANREynEMLCcuXowzcvX/ODnNfIOiwF7UflzLARsd018baO
        tYvMOB28dbns5524uQd1iCf6fE7T+LZW2nJ6qNLKwg==
X-Google-Smtp-Source: ABdhPJw6RIWcE29bxAW/+bnTp5EI+r9Mzl9FdFtILZQ2pDra7EDOiCRifPv2nBDqKd9VGUoepLOuexNWzoqVWeh14Tk=
X-Received: by 2002:a17:906:1e55:: with SMTP id i21mr9691897ejj.547.1633763199690;
 Sat, 09 Oct 2021 00:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com> <e24df2a9-1332-0eb3-b52a-230662fe46ba@arm.com>
In-Reply-To: <e24df2a9-1332-0eb3-b52a-230662fe46ba@arm.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Sat, 9 Oct 2021 09:06:01 +0200
Message-ID: <CABdtJHvY5XnQN7wgQ9D8Zcu-NgHRmaUMFPgaPGZwM+AhmVpULw@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Will Deacon <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 8, 2021 at 2:49 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-05 09:07, Shameer Kolothum wrote:
> > Add support for parsing RMR node information from ACPI.
> >
> > Find the associated streamid and smmu node info from the
> > RMR node and populate a linked list with RMR memory
> > descriptors.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >   drivers/acpi/arm64/iort.c | 134 +++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 133 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 3b23fb775ac4..d76ba46ebe67 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -40,6 +40,8 @@ struct iort_fwnode {
> >   static LIST_HEAD(iort_fwnode_list);
> >   static DEFINE_SPINLOCK(iort_fwnode_lock);
> >
> > +static LIST_HEAD(iort_rmr_list);     /* list of RMR regions from ACPI */
> > +
> >   /**
> >    * iort_set_fwnode() - Create iort_fwnode and use it to register
> >    *                 iommu data in the iort_fwnode_list
> > @@ -393,7 +395,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
> >               if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> >                   node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> >                   node->type == ACPI_IORT_NODE_SMMU_V3 ||
> > -                 node->type == ACPI_IORT_NODE_PMCG) {
> > +                 node->type == ACPI_IORT_NODE_PMCG ||
> > +                 node->type == ACPI_IORT_NODE_RMR) {
> >                       *id_out = map->output_base;
> >                       return parent;
> >               }
> > @@ -1566,6 +1569,134 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
> >   #else
> >   static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
> >   #endif
> > +static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc, u32 count)
> > +{
> > +     int i, j;
> > +
> > +     for (i = 0; i < count; i++) {
> > +             u64 end, start = desc[i].base_address, length = desc[i].length;
> > +
> > +             end = start + length - 1;
> > +
> > +             /* Check for address overlap */
> > +             for (j = i + 1; j < count; j++) {
> > +                     u64 e_start = desc[j].base_address;
> > +                     u64 e_end = e_start + desc[j].length - 1;
> > +
> > +                     if (start <= e_end && end >= e_start)
> > +                             pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] overlaps, continue anyway\n",
> > +                                    start, end);
> > +             }
> > +     }
> > +}
> > +
> > +static void __init iort_node_get_rmr_info(struct acpi_iort_node *iort_node)
> > +{
> > +     struct acpi_iort_node *smmu;
> > +     struct acpi_iort_rmr *rmr;
> > +     struct acpi_iort_rmr_desc *rmr_desc;
> > +     u32 map_count = iort_node->mapping_count;
> > +     u32 sid;
> > +     int i;
> > +
> > +     if (!iort_node->mapping_offset || map_count != 1) {
> > +             pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> > +                    iort_node);
> > +             return;
> > +     }
> > +
> > +     /* Retrieve associated smmu and stream id */
> > +     smmu = iort_node_get_id(iort_node, &sid, 0);
> > +     if (!smmu) {
> > +             pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
> > +                    iort_node);
> > +             return;
> > +     }
> > +
> > +     /* Retrieve RMR data */
> > +     rmr = (struct acpi_iort_rmr *)iort_node->node_data;
> > +     if (!rmr->rmr_offset || !rmr->rmr_count) {
> > +             pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
> > +                    iort_node);
> > +             return;
> > +     }
> > +
> > +     rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
> > +                             rmr->rmr_offset);
> > +
> > +     iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
> > +
> > +     for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
> > +             struct iommu_resv_region *region;
> > +             enum iommu_resv_type type;
> > +             int prot = IOMMU_READ | IOMMU_WRITE;
> > +             u64 addr = rmr_desc->base_address, size = rmr_desc->length;
> > +
> > +             if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
> > +                     /* PAGE align base addr and size */
> > +                     addr &= PAGE_MASK;
> > +                     size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
> > +
> > +                     pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
> > +                            rmr_desc->base_address,
> > +                            rmr_desc->base_address + rmr_desc->length - 1,
> > +                            addr, addr + size - 1);
> > +             }
> > +             if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
> > +                     type = IOMMU_RESV_DIRECT_RELAXABLE;
> > +                     /*
> > +                      * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
> > +                      * normally used for allocated system memory that is
> > +                      * then used for device specific reserved regions.
> > +                      */
> > +                     prot |= IOMMU_CACHE;
> > +             } else {
> > +                     type = IOMMU_RESV_DIRECT;
> > +                     /*
> > +                      * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
> > +                      * for device memory like MSI doorbell.
> > +                      */
> > +                     prot |= IOMMU_MMIO;
> > +             }
>
> I'm not sure we ever got a definitive answer to this - does DPAA2
> actually go wrong if we use IOMMU_MMIO here? I'd still much prefer to
> make the fewest possible assumptions, since at this point it's basically
> just a stop-gap until we can fix the spec. It's become clear that we
> can't reliably rely on guessing attributes, so I'm not too fussed about
> theoretical cases that currently don't work (due to complete lack of RMR
> support) continuing to not work for the moment, as long as we can make
> the real-world cases we actually have work at all. Anything which only
> affects performance I'd rather leave until firmware can tell us what to do.

Well it isn't DPAA2, it is FSL_MC_BUS that fails with IOMMU_MMIO
mappings.  DPAA2 is just one connected device.

-Jon

>
> > +             region = iommu_alloc_resv_region(addr, size, prot, type);
> > +             if (region) {
> > +                     region->fw_data.rmr.flags = rmr->flags;
> > +                     region->fw_data.rmr.sid = sid;
> > +                     region->fw_data.rmr.smmu = smmu;
> > +                     list_add_tail(&region->list, &iort_rmr_list);
> > +             }
> > +     }
> > +}
> > +
> > +static void __init iort_parse_rmr(void)
> > +{
> > +     struct acpi_iort_node *iort_node, *iort_end;
> > +     struct acpi_table_iort *iort;
> > +     int i;
> > +
> > +     if (iort_table->revision < 3)
> > +             return;
> > +
> > +     iort = (struct acpi_table_iort *)iort_table;
> > +
> > +     iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> > +                              iort->node_offset);
> > +     iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> > +                             iort_table->length);
> > +
> > +     for (i = 0; i < iort->node_count; i++) {
> > +             if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
> > +                            "IORT node pointer overflows, bad table!\n"))
> > +                     return;
> > +
> > +             if (iort_node->type == ACPI_IORT_NODE_RMR)
> > +                     iort_node_get_rmr_info(iort_node);
> > +
> > +             iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> > +                                      iort_node->length);
> > +     }
> > +}
> >
> >   static void __init iort_init_platform_devices(void)
> >   {
> > @@ -1636,6 +1767,7 @@ void __init acpi_iort_init(void)
> >       }
> >
> >       iort_init_platform_devices();
> > +     iort_parse_rmr();
>
> I guess initcall ordering vs. driver registration probably covers it up,
> but for the sake of cleanliness I'd rather make sure the RMRs are fully
> discovered *before* we create the SMMU devices that we expect to start
> consuming them.
>
> Robin.
>
> >   }
> >
> >   #ifdef CONFIG_ZONE_DMA
> >
