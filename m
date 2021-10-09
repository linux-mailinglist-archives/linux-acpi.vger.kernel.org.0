Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EC44277D8
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Oct 2021 09:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhJIHK3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Oct 2021 03:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhJIHK3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Oct 2021 03:10:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950FFC061570
        for <linux-acpi@vger.kernel.org>; Sat,  9 Oct 2021 00:08:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i20so28402822edj.10
        for <linux-acpi@vger.kernel.org>; Sat, 09 Oct 2021 00:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxbI/uuYtuMouh6gZMpilx8L0A4TIecSt2QZc/N1Qqk=;
        b=ut6b5FvP/h3dtW4M5RgbTfFdVAeUyT+OzMK9R+jzPqdcr2H1ROwxWb3o2DmZ7XocuM
         feAEDLNwM0fvh6acD4DfWfguur+oiGEOhT9LtoqEEUaw8a078IdWa44Nr2LVmAzmuDHy
         FZgL9jwXKunsOt8vuXAdwi2ZGRuAcY4Zg3KzMVHGllN7TkRPtauzvluOL21USJ8esIw9
         HSB3R+mSGFiuN9SFnqr69dhNQ4zrF3bcK6Cc9+w/3w1fJBkxwpaqNejStzOtd4bTz2p1
         sAIJES+DZs+hHnu6ry/Y3qTnd1R34Mp258AzYihD2y6iHzZE8jrPnHBoB5+mKF+dgG5R
         rFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxbI/uuYtuMouh6gZMpilx8L0A4TIecSt2QZc/N1Qqk=;
        b=jZsi4WPuUw9GCa+VwtT+W0ln99A+f5VaVYBK4Xx0QlV4HlcAIPR0LWV9v3k+o5Y8fj
         h2PM2M6qre6ECFWvoTB85U21AmZzgkzFTtNHCQCtDU8xqqcSdIG9shGv3zlzDQhEOgbn
         suWZJHEhX6KngTD+pxSXBfussF9WAK2nPHRK0I5gqK/B8TpMowoQZ+vH5x7lRjArke5X
         sml4a3G7mbCh4hc39WAOghHVOaWeudh83m+wbdax3W7F7M5WcmhjBgprQTAAwTNROzMe
         dwJQd20Ec0uusIa7WR3JksfzEgeL+5LLQw+W4EtneyY5tSfTV0/zwi+VV8Z5kRXx4/qA
         TTRA==
X-Gm-Message-State: AOAM531Vm9wyW0P792FGecuPpFkMfOJnG4T/h01VPxWzLQLmTZZI60Y1
        qC2tyW0FsWSGJqN+LDwowCxao8oIj3u96BERVSjbNA==
X-Google-Smtp-Source: ABdhPJxOqIbSsuLd/7QjzZhiZP9syTmIR3XdifKwNKBGqI/kiluRwbLDcDxx+CANT6FUsI8vO1wCW58iyhufMzS1Ckk=
X-Received: by 2002:a17:906:318b:: with SMTP id 11mr10003258ejy.493.1633763311162;
 Sat, 09 Oct 2021 00:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-10-shameerali.kolothum.thodi@huawei.com> <44e00e32-be89-1174-beb5-9a2fca85a683@arm.com>
In-Reply-To: <44e00e32-be89-1174-beb5-9a2fca85a683@arm.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Sat, 9 Oct 2021 09:07:54 +0200
Message-ID: <CABdtJHv+SZ15RcBaFt0w4iTsMMbAjGB2Wm4GST3cNw+2Q=OeVw@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] iommu/dma: Reserve any RMR regions associated with
 a dev
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        yangyicong <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 8, 2021 at 3:10 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-05 09:07, Shameer Kolothum wrote:
> > Get ACPI IORT RMR regions associated with a dev reserved
> > so that there is a unity mapping for them in SMMU.
>
> This feels like most of it belongs in the IORT code rather than
> iommu-dma (which should save the temporary list copy as well).

See previous comment.  The original intent was for device-tree to also
be able to use these mechanisms to create RMR's and support them
in the SMMU.

-Jon

>
> Robin.
>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 56 +++++++++++++++++++++++++++++++++++----
> >   1 file changed, 51 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 1b6e27475279..c1ae0c3d4b33 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -207,22 +207,68 @@ void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
> >   }
> >   EXPORT_SYMBOL(iommu_dma_put_rmrs);
> >
> > +static bool iommu_dma_dev_has_rmr(struct iommu_fwspec *fwspec,
> > +                               struct iommu_resv_region *e)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < fwspec->num_ids; i++) {
> > +             if (e->fw_data.rmr.sid == fwspec->ids[i])
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static void iommu_dma_get_rmr_resv_regions(struct device *dev,
> > +                                        struct list_head *list)
> > +{
> > +     struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +     struct list_head rmr_list;
> > +     struct iommu_resv_region *rmr, *tmp;
> > +
> > +     INIT_LIST_HEAD(&rmr_list);
> > +     if (iommu_dma_get_rmrs(fwspec->iommu_fwnode, &rmr_list))
> > +             return;
> > +
> > +     if (dev_is_pci(dev)) {
> > +             struct pci_dev *pdev = to_pci_dev(dev);
> > +             struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
> > +
> > +             if (!host->preserve_config)
> > +                     return;
> > +     }
> > +
> > +     list_for_each_entry_safe(rmr, tmp, &rmr_list, list) {
> > +             if (!iommu_dma_dev_has_rmr(fwspec, rmr))
> > +                     continue;
> > +
> > +             /* Remove from iommu RMR list and add to dev resv_regions */
> > +             list_del_init(&rmr->list);
> > +             list_add_tail(&rmr->list, list);
> > +     }
> > +
> > +     iommu_dma_put_rmrs(fwspec->iommu_fwnode, &rmr_list);
> > +}
> > +
> >   /**
> >    * iommu_dma_get_resv_regions - Reserved region driver helper
> >    * @dev: Device from iommu_get_resv_regions()
> >    * @list: Reserved region list from iommu_get_resv_regions()
> >    *
> >    * IOMMU drivers can use this to implement their .get_resv_regions callback
> > - * for general non-IOMMU-specific reservations. Currently, this covers GICv3
> > - * ITS region reservation on ACPI based ARM platforms that may require HW MSI
> > - * reservation.
> > + * for general non-IOMMU-specific reservations. Currently this covers,
> > + *  -GICv3 ITS region reservation on ACPI based ARM platforms that may
> > + *   require HW MSI reservation.
> > + *  -Any ACPI IORT RMR memory range reservations (IORT spec rev E.b)
> >    */
> >   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
> >   {
> >
> > -     if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
> > +     if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode)) {
> >               iort_iommu_msi_get_resv_regions(dev, list);
> > -
> > +             iommu_dma_get_rmr_resv_regions(dev, list);
> > +     }
> >   }
> >   EXPORT_SYMBOL(iommu_dma_get_resv_regions);
> >
> >
