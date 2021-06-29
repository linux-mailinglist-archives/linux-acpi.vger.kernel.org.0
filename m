Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AAA3B774A
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhF2RiE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 13:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhF2RiD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jun 2021 13:38:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7852BC061760
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jun 2021 10:35:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c17so11760559ejk.13
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jun 2021 10:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AR518AYffDucPqzd6GpEc0fpZu1ity7ryBoeYS6VKpM=;
        b=s/B5H56H4gU82Gp6P64hMNmHHdlcpEN6YXZM9aJVcRaJAWvqnQ6jgSriUY14Ic/NcP
         dy5st7yhJ4DU0QHwDNFaXUCWEi0m50cR/OjM2krNjL94wOLgwxueH8cKfmlxXjkTYY7B
         6ffKcHtucifvn4CLA/aYFqkxWyGHZLlq1qRDom+3IIF3tWZAjOSQIWUnF7vR7Uk1RpgF
         aKihl+5b1owtWMmuiX7vEerJEmi5wO8MftxzE4fFgUKZg8NhVwQesUIdp7lSDtxmZreQ
         Grrc6g+MLQULEp7PnSU23VE+CqzpPDzegwf8tPAKFWkNw04CXuXzOK9+29pVzVjOokN+
         KfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AR518AYffDucPqzd6GpEc0fpZu1ity7ryBoeYS6VKpM=;
        b=JuquOAKpmoMWojo9vjNuiYfaq+4/LVriJ+1cWNysudrlAKG3tMd9TlIdMW8/9EO6Y9
         0KeZSxrmmR5wsQWGMyVDniv8HC7ERP6bWNXJv4XNyO8BCQ+AeYJZ8xSmE/4MV30JOvpI
         WNtd9mFHGH2+S4QpVEWnyl3Y+DQEWzcWEikbXKS871xWn2X3bk1ITeCQ24vt2YIjdCtL
         DI6GK+bReu3WHfEIbhsJeEK+SFKDimwcgPvM9Kz6yuhTVxN4UT31Xda3bTtDSZopUh5k
         3MyLYblI2HuzLoPYxkqYF87jnFuzxwvaGZs/Ma0+xYfLmDe6eoaVWodkwLxvmLU5uPfG
         n56w==
X-Gm-Message-State: AOAM530lMMu/Qnoku/eHsBFwHFxZzSNFr+9mQTlm8k/pWjsJkl/z+7xz
        H4j/xce3MZlSxZaZwfLYQ8jje3UoVwz9uV2Mt2fnZQ==
X-Google-Smtp-Source: ABdhPJx357cBFSDeJIq+SFagT0F9i3UmguYWEoihimZ4PczMNFpyw7EKJ6U7OhMqBkG4xqQtWP0detZF5ur4Z8O/+4o=
X-Received: by 2002:a17:906:5d06:: with SMTP id g6mr31659399ejt.342.1624988133039;
 Tue, 29 Jun 2021 10:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
 <9e788789-c1c2-10f1-d99c-93cfa6ea3348@arm.com> <3206cd67962242a69fb83adac892e34c@huawei.com>
In-Reply-To: <3206cd67962242a69fb83adac892e34c@huawei.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Tue, 29 Jun 2021 19:34:56 +0200
Message-ID: <CABdtJHuKT2WfsR+hrPkpXkhyvzKumrc=KNhgeo9P01=tfWfg2w@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory regions
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 14, 2021 at 2:49 PM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Robin Murphy [mailto:robin.murphy@arm.com]
> > Sent: 14 June 2021 12:23
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > iommu@lists.linux-foundation.org
> > Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> > steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> > yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
> > wanghuiqiang <wanghuiqiang@huawei.com>
> > Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
> > regions
> >
> > On 2021-05-24 12:02, Shameer Kolothum wrote:
> > > Add a helper function that retrieves RMR memory descriptors
> > > associated with a given IOMMU. This will be used by IOMMU
> > > drivers to setup necessary mappings.
> > >
> > > Now that we have this, invoke it from the generic helper
> > > interface.
> > >
> > > Signed-off-by: Shameer Kolothum
> > <shameerali.kolothum.thodi@huawei.com>
> > > ---
> > >   drivers/acpi/arm64/iort.c | 50
> > +++++++++++++++++++++++++++++++++++++++
> > >   drivers/iommu/dma-iommu.c |  4 ++++
> > >   include/linux/acpi_iort.h |  7 ++++++
> > >   3 files changed, 61 insertions(+)
> > >
> > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > index fea1ffaedf3b..01917caf58de 100644
> > > --- a/drivers/acpi/arm64/iort.c
> > > +++ b/drivers/acpi/arm64/iort.c
> > > @@ -12,6 +12,7 @@
> > >
> > >   #include <linux/acpi_iort.h>
> > >   #include <linux/bitfield.h>
> > > +#include <linux/dma-iommu.h>
> > >   #include <linux/iommu.h>
> > >   #include <linux/kernel.h>
> > >   #include <linux/list.h>
> > > @@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct
> > device *dev)
> > >     return err;
> > >   }
> > >
> > > +/**
> > > + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with
> > IOMMU
> > > + * @iommu: fwnode for the IOMMU
> > > + * @head: RMR list head to be populated
> > > + *
> > > + * Returns: 0 on success, <0 failure
> > > + */
> > > +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > > +                   struct list_head *head)
> > > +{
> > > +   struct iort_rmr_entry *e;
> > > +   struct acpi_iort_node *iommu;
> > > +   int rmrs = 0;
> > > +
> > > +   iommu = iort_get_iort_node(iommu_fwnode);
> > > +   if (!iommu || list_empty(&iort_rmr_list))
> > > +           return -ENODEV;
> > > +
> > > +   list_for_each_entry(e, &iort_rmr_list, list) {
> > > +           int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC |
> > IOMMU_MMIO;
> > > +           struct iommu_resv_region *region;
> > > +           enum iommu_resv_type type;
> > > +           struct acpi_iort_rmr_desc *rmr_desc;
> > > +
> > > +           if (e->smmu != iommu)
> > > +                   continue;
> > > +
> > > +           rmr_desc = e->rmr_desc;
> > > +           if (e->flags & IOMMU_RMR_REMAP_PERMITTED)
> > > +                   type = IOMMU_RESV_DIRECT_RELAXABLE;
> > > +           else
> > > +                   type = IOMMU_RESV_DIRECT;
> >

I have been looking at this a bit more and looking at the history of
RMR_REMAP_PERMITTED.  Based on the history I have found it
seems to me like this would be the better options for prot.

@@ -840,7 +840,7 @@ int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
                return -ENODEV;

        list_for_each_entry(e, &iort_rmr_list, list) {
-               int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+               int prot = IOMMU_READ | IOMMU_WRITE;
                struct iommu_resv_region *region;
                enum iommu_resv_type type;
                struct acpi_iort_rmr_desc *rmr_desc;
@@ -849,10 +849,13 @@ int iort_iommu_get_rmrs(struct fwnode_handle
*iommu_fwnode,
                        continue;

                rmr_desc = e->rmr_desc;
-               if (e->flags & IOMMU_RMR_REMAP_PERMITTED)
+               if (e->flags & IOMMU_RMR_REMAP_PERMITTED) {
                        type = IOMMU_RESV_DIRECT_RELAXABLE;
-               else
+                       prot |= IOMMU_CACHE;
+               } else {
                        type = IOMMU_RESV_DIRECT;
+                       prot |= IOMMU_MMIO;
+               }

                region = iommu_alloc_resv_region(rmr_desc->base_address,
                                                 rmr_desc->length,

any input on this?  My reasoning is that IOMMU_RESV_DIRECT is specifically
referenced for things like MSI doorbell and in all the examples needs
IOMMU_MMIO, while REMAP_PERMITTED seems to be used for allocated
system memory that is then used for device specific reserved regions which
commits say would be like a GPU or USB device.

-Jon

> > Wasn't the idea that we can do all this during the initial parsing, i.e.
> > we don't even have iort_rmr_entry, we store them as iommu_resv_regions
> > and simply kmemdup() or whatever at this point?
>
>
> Hmm... Not yet. I removed struct iommu_rmr() from v4. But yes, it looks like
> we can get rid of iort_rmr_entry as well. Will give it a go in next.
>
> Thanks,
> Shameer
>
> > Robin.
> >
> > > +
> > > +           region = iommu_alloc_resv_region(rmr_desc->base_address,
> > > +                                            rmr_desc->length,
> > > +                                            prot, type);
> > > +           if (region) {
> > > +                   region->fw_data.rmr.flags = e->flags;
> > > +                   region->fw_data.rmr.sid = e->sid;
> > > +                   list_add_tail(&region->list, head);
> > > +                   rmrs++;
> > > +           }
> > > +   }
> > > +
> > > +   return (rmrs == 0) ? -ENODEV : 0;
> > > +}
> > > +
> > >   /**
> > >    * iort_iommu_msi_get_resv_regions - Reserved region driver helper
> > >    * @dev: Device from iommu_get_resv_regions()
> > > @@ -1108,6 +1156,8 @@ int iort_iommu_msi_get_resv_regions(struct
> > device *dev, struct list_head *head)
> > >   const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> > >                                             const u32 *input_id)
> > >   { return NULL; }
> > > +int iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct list_head
> > *head)
> > > +{ return -ENODEV; }
> > >   #endif
> > >
> > >   static int nc_dma_get_range(struct device *dev, u64 *size)
> > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > index 229ec65d98be..f893d460cfa4 100644
> > > --- a/drivers/iommu/dma-iommu.c
> > > +++ b/drivers/iommu/dma-iommu.c
> > > @@ -185,6 +185,9 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
> > >   int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > >                    struct list_head *list)
> > >   {
> > > +   if (!is_of_node(iommu_fwnode))
> > > +           return iort_iommu_get_rmrs(iommu_fwnode, list);
> > > +
> > >     return -EINVAL;
> > >   }
> > >   EXPORT_SYMBOL(iommu_dma_get_rmrs);
> > > @@ -200,6 +203,7 @@ EXPORT_SYMBOL(iommu_dma_get_rmrs);
> > >   void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
> > >                     struct list_head *list)
> > >   {
> > > +   generic_iommu_put_resv_regions(iommu_fwnode->dev, list);
> > >   }
> > >   EXPORT_SYMBOL(iommu_dma_put_rmrs);
> > >
> > > diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> > > index 1a12baa58e40..e8c45fa59531 100644
> > > --- a/include/linux/acpi_iort.h
> > > +++ b/include/linux/acpi_iort.h
> > > @@ -39,6 +39,8 @@ const struct iommu_ops
> > *iort_iommu_configure_id(struct device *dev,
> > >                                             const u32 *id_in);
> > >   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head
> > *head);
> > >   phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
> > > +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > > +                   struct list_head *list);
> > >   #else
> > >   static inline void acpi_iort_init(void) { }
> > >   static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> > > @@ -59,6 +61,11 @@ int iort_iommu_msi_get_resv_regions(struct device
> > *dev, struct list_head *head)
> > >
> > >   static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
> > >   { return PHYS_ADDR_MAX; }
> > > +
> > > +static inline
> > > +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > > +                   struct list_head *list)
> > > +{ return -ENODEV; }
> > >   #endif
> > >
> > >   #endif /* __ACPI_IORT_H__ */
> > >
