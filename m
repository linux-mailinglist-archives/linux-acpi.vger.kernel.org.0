Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A7B3E199B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Aug 2021 18:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhHEQcm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Aug 2021 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhHEQcl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Aug 2021 12:32:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563D4C061765
        for <linux-acpi@vger.kernel.org>; Thu,  5 Aug 2021 09:32:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id yk17so10536264ejb.11
        for <linux-acpi@vger.kernel.org>; Thu, 05 Aug 2021 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQCg6OI1PKRykWCoTFREjwe6qvftl+/s1qj9qRWwyWs=;
        b=yQz1nbjdvUX/NC0VNo5bOXvWG6OQQMtlTTRJHeQaXh4N3GNGJybnReORBTmvyg2Kxe
         xqQt9aK5vBbhZW/lfOqvYT+4TCISWd1BxMNbA1Rus+Ak979zB63Wpl6sVIvdmLytHZs2
         3ATNZXMm703d+ek8PWeokRc/FyGccA0Z1jtDENHkCPzxAO8JdE6RMQBhxHJAcnI8uZWW
         FXXVdOT2BJgrFnuZk0wMDdjeUiBp0uB8iYye/qvIW4H9R9/PwDyS4+zu4/aCMFBUX17n
         1rz4oqbmqG+BONTQgiyZoAn23DgYHSt509y9D0zZ5YM8wbucwklK31FjZUf6GXDm12QS
         kqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQCg6OI1PKRykWCoTFREjwe6qvftl+/s1qj9qRWwyWs=;
        b=GVt+i1iKB/JNR56YZUeM49DrPQg/JScE4GRDyaLHrSnNR9b9PVatVFd5zg3FZzWjFM
         uBvYTB/0YZLhCBzCTQcbMeIMM5o+IpDblTuDpEIqRingDJlDuroUiIw/Sv605V9pM0G8
         SU57SYs23LI+xIlkXN1YpS649+nlSr1eoDlT4kSvDE0oFZAz/njBPcTzPGGbn9a2pEV5
         NOzawpp/Rw5D5BojWCNWqU0DHzBsk0xCZv2AiGGaBOb+CQgH7gJF102WDK9/tvKONuCC
         h8cuBnSP/vhq8hUnh77/1hHsRL+ZmpmtcXd8xlKT4VOVxgqLE7xUoRKaX4zfuBt7Kx8h
         jkdg==
X-Gm-Message-State: AOAM532v9EKxefX6leAWDn/Ajg/9lZw9I7G9W092AzOE/+70qq9MylzD
        /OzsVgJm63WcvpoZSeMopQJXL2BaGI+klUqOMv5xjg==
X-Google-Smtp-Source: ABdhPJxb1qaMZTi4dyT6LMxLcXJPZSpel7n23A9sy9aHK/FcPT3m4u095ddlSk+SVEveBE+l8doNfLvgs5DkSu1zEA0=
X-Received: by 2002:a17:906:abc2:: with SMTP id kq2mr5764176ejb.342.1628181144845;
 Thu, 05 Aug 2021 09:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com> <20210805160319.GB23085@lpieralisi>
In-Reply-To: <20210805160319.GB23085@lpieralisi>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Thu, 5 Aug 2021 18:31:47 +0200
Message-ID: <CABdtJHuhpnASw8NQb7dRo42Z5NqOzvtvjoyndsJ2jd+Qvsq7vQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Linuxarm <linuxarm@huawei.com>,
        joro@8bytes.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>, eric.auger@redhat.com,
        yangyicong <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 5, 2021 at 6:03 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Aug 05, 2021 at 09:07:17AM +0100, Shameer Kolothum wrote:
>
> [...]
>
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
> On the prot value assignment based on the remapping flag, I'd like to
> hear Robin/Joerg's opinion, I'd avoid being in a situation where
> "normally" this would work but then we have to quirk it.
>
> Is this a valid assumption _always_ ?

These assumptions were made based on the historic use cases I could
find reading the history.  There aren't many known examples "in the wild"
because so far we haven't had a mechanism other than quirks based
around device-tree implementations.

Ultimately I believe the proper solution will need to be another flag
in the RMR table that specifies the type of memory an RMR Node
describes, not just the base and length.

-Jon

>
> Thanks,
> Lorenzo
>
> > +
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
> >  static void __init iort_init_platform_devices(void)
> >  {
> > @@ -1636,6 +1767,7 @@ void __init acpi_iort_init(void)
> >       }
> >
> >       iort_init_platform_devices();
> > +     iort_parse_rmr();
> >  }
> >
> >  #ifdef CONFIG_ZONE_DMA
> > --
> > 2.17.1
> >
