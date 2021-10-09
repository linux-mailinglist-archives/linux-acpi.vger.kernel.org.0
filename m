Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455F14277CF
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Oct 2021 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhJIHA1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Oct 2021 03:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhJIHA0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Oct 2021 03:00:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F04AC061570
        for <linux-acpi@vger.kernel.org>; Fri,  8 Oct 2021 23:58:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z20so44394954edc.13
        for <linux-acpi@vger.kernel.org>; Fri, 08 Oct 2021 23:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDTl8X5yoXokOqK2zdOQtAknCzTNXPqBW0n1XanS7MI=;
        b=rNu1qpoGLb1tS097DGxH3Ff2UIstvCzkt+qWo1qxgHvl4ifiX+oRjbrlAf7AY87uM9
         bo/PUkbQGmIDm909slkixSa/KvAnJrFJ5tU2nD6RpJBIu45BtT+m++TAJHKM6wMVfYax
         ATiBhIeL0s2haTGCWgxhiISiVmfowRhkC7zluCk0WkJN2l/dtq+jcPq8szphgEpYHU2h
         yN8/sltuCjhRJjhYvkWFwV2rzAzMWWDf0pDReJlQvMK0fKjeeguKveHcX5zYO6bLm40/
         T9AQ0GmQvVr+R07o3csoWa0jIlO8V5ewHRUy5rpN7mPMdfhr6lzi9s1ZrPM5hAmRCkBb
         iZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDTl8X5yoXokOqK2zdOQtAknCzTNXPqBW0n1XanS7MI=;
        b=prmIqzm1u0E4NnHe3T4F6Hlt8oWo8QvzcdoXMyJKg0nCjs1I/m9Xdc85fea8XvJF/h
         A9pC3QO7ZmTf7HUBvErDm6AaEGUXwCIWB+8TEiku0Jr2HXlTvbpbEQT2LdUQd27xwPoS
         8xe7aL+Hio+ygT79b1NrD2L1YLbuvdBnO/au4/nbd89EECTjCPYwAoWdHiftORtP5Qxd
         YuVesdDx3/HgHD5mqajPsMUEUmmNMrv/cFAdXZoPGa0m/1/9N4mQ8PxzMRVyiTvW+8zb
         CRrc4ro+zKIRbUITb6YXsKlzx8Jv8t2kK3OIRONBkILAj63o3UhES+jdxHzRZuAPfrJs
         uImQ==
X-Gm-Message-State: AOAM532Zn5i7BwzmBByMfG0ju7o2YsLDH9ngION6aIIbqhMrg771LYUA
        NVt14bpmVsju34MX4dK7+2bUq89ekz7s9hLNRZDlrQ==
X-Google-Smtp-Source: ABdhPJwhcPwL5hzWQI/NubQfQxK8my9q4PDNQMawMoHZUBGS3OG3sxm/edyZlPDpMWXoqcQyTK4dJMNAN0nF2LxRiUM=
X-Received: by 2002:a17:906:1e55:: with SMTP id i21mr9657898ejj.547.1633762708473;
 Fri, 08 Oct 2021 23:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com> <a1eddd80-4a26-4809-e681-f338d9998a24@arm.com>
In-Reply-To: <a1eddd80-4a26-4809-e681-f338d9998a24@arm.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Sat, 9 Oct 2021 08:57:51 +0200
Message-ID: <CABdtJHtB7apg809UkrmDHQvtL012FqA_0+4_pL9NVD-mVm42YA@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] iommu: Introduce a union to struct iommu_resv_region
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

On Fri, Oct 8, 2021 at 2:14 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-05 09:07, Shameer Kolothum wrote:
> > A union is introduced to struct iommu_resv_region to hold
> > any firmware specific data. This is in preparation to add
> > support for IORT RMR reserve regions and the union now holds
> > the RMR specific information.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >   include/linux/iommu.h | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 32d448050bf7..bd0e4641c569 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -114,6 +114,13 @@ enum iommu_resv_type {
> >       IOMMU_RESV_SW_MSI,
> >   };
> >
> > +struct iommu_iort_rmr_data {
> > +#define IOMMU_RMR_REMAP_PERMITTED    (1 << 0)
> > +     u32 flags;
> > +     u32 sid;        /* Stream Id associated with RMR entry */
> > +     void *smmu;     /* Associated IORT SMMU node pointer */
> > +};
>
> Do we really need to duplicate all this data? AFAICS we could just save
> the acpi_iort_rmr pointer in the iommu_resv_region (with a forward
> declaration here if necessary) and defer parsing its actual mappings
> until the point where we can directly consume the results.

From earlier discussions on this patchset, the original goal was also for
device-tree mechanisms to be able to hook into this code to support
similar RMR's and SMMU initialization, just not through the ACPI / IORT
path.

>
> Robin.
>
> > +
> >   /**
> >    * struct iommu_resv_region - descriptor for a reserved memory region
> >    * @list: Linked list pointers
> > @@ -121,6 +128,7 @@ enum iommu_resv_type {
> >    * @length: Length of the region in bytes
> >    * @prot: IOMMU Protection flags (READ/WRITE/...)
> >    * @type: Type of the reserved region
> > + * @rmr: ACPI IORT RMR specific data
> >    */
> >   struct iommu_resv_region {
> >       struct list_head        list;
> > @@ -128,6 +136,9 @@ struct iommu_resv_region {
> >       size_t                  length;
> >       int                     prot;
> >       enum iommu_resv_type    type;
> > +     union {
> > +             struct iommu_iort_rmr_data rmr;
> > +     } fw_data;
> >   };
> >
> >   /**
> >
