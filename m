Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A1C392651
	for <lists+linux-acpi@lfdr.de>; Thu, 27 May 2021 06:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhE0E2C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 May 2021 00:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhE0E2C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 May 2021 00:28:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BDAC061574
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 21:26:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z16so5247624ejr.4
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 21:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MuUPMsBblFv1sa2XEzf9FhR5nku7Yzg5FRIozyJMbVs=;
        b=oJ1RrS93T/Y6l9C/Be0U5byek0L3iZSx6/E+PjohXK+Dv5uJuO8eVhzUpS56Cu4Rxr
         C08Cn0ETIGdwku0hFEhDGcnBiUfcj6hVZJXx78N03q7cQaLV547HCzm8/7tTVUli9aJC
         HWn378qDga97k1q+GMZxBZmHRkrU6lox/pb0wnYZgwZCG1s5TVDEzOyJdQQYivkAwlGN
         t2/YidV7QghniSvTFUIBiAMQi/8UEs7zJ90UskmBvE2pZSGEVCcJqQ5LgkEt+8RNN9t+
         obZjJEF2g4vH72lVxTlm7WGemQm2v8+0NIroYYLVRcb/GwcLf8+5AI/eVlpiC9djkhKL
         4jwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MuUPMsBblFv1sa2XEzf9FhR5nku7Yzg5FRIozyJMbVs=;
        b=cUwUdQywM+2QbW+GnWpFqBmJ1ZDwZScEKGMtJAtg2JdoJn84H5slphGWwZWryevfsd
         xW+xb8/cAjZHc7lBsixhgYDUdFF/598yhvAvTXaO+LmdY/07hDtrakJemDJ5mqJU7hy4
         Nlf8aBAjADno5KE9kzyHP8lm0b6H6bRfZd7iHYl0srWMkWuzmQGcTbBNb2gvqov1Ydcy
         Vnwi8/1sk6ABS5vaZ2Og6NOiQy97L+cjGWSY63wB3886aDFYhmFFyzfH8uD4SnKYQu06
         0RpBZnqh876uc7mqT/zhFhqqg1TjsuihKs799VoNJ97cZvF/v2JBQIE3bpYiKpTFE8W9
         eafA==
X-Gm-Message-State: AOAM530gcPBQ2KL2UCAxfxrFsaPQse36QI2YJ+/gVhKTEWK3AieU1Een
        Zy0zHeL0osu1f6ECfTwIoN9cvTmSyasoTFKLkaBmBQ==
X-Google-Smtp-Source: ABdhPJwLBPm+M32hCgK1/i4GtoIfZcGVvMGzA9iXyPCuW/JYMi8Lqp3Mepx9n6LiB4zDvZG1eZkKf5Y8jqeCKL158Lc=
X-Received: by 2002:a17:906:4704:: with SMTP id y4mr1759294ejq.68.1622089587584;
 Wed, 26 May 2021 21:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
 <13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com> <260859e85c854b90b513599f4febfbad@huawei.com>
In-Reply-To: <260859e85c854b90b513599f4febfbad@huawei.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Thu, 27 May 2021 06:25:48 +0200
Message-ID: <CABdtJHsoN8-9+uogbRP+Tn2d0wjo8XNzKFOPOUwE+S4NVRoawQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory regions
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 26, 2021 at 6:36 PM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Laurentiu Tudor [mailto:laurentiu.tudor@nxp.com]
> > Sent: 26 May 2021 08:53
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > iommu@lists.linux-foundation.org
> > Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> > steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> > yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
> > robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> > Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
> > regions
> >
> > Hi Shameer,
> >
> > On 5/24/2021 2:02 PM, Shameer Kolothum wrote:
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
> > >  drivers/acpi/arm64/iort.c | 50
> > +++++++++++++++++++++++++++++++++++++++
> > >  drivers/iommu/dma-iommu.c |  4 ++++
> > >  include/linux/acpi_iort.h |  7 ++++++
> > >  3 files changed, 61 insertions(+)
> > >
> > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > index fea1ffaedf3b..01917caf58de 100644
> > > --- a/drivers/acpi/arm64/iort.c
> > > +++ b/drivers/acpi/arm64/iort.c
> > > @@ -12,6 +12,7 @@
> > >
> > >  #include <linux/acpi_iort.h>
> > >  #include <linux/bitfield.h>
> > > +#include <linux/dma-iommu.h>
> > >  #include <linux/iommu.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/list.h>
> > > @@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct
> > device *dev)
> > >     return err;
> > >  }
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
> >
> > We have a case with an IP block that needs EXEC rights on its reserved
> > memory, so could you please drop the IOMMU_NOEXEC flag?
>
> Ok, I think I can drop that one if there are no other concerns. I was not quite
> sure what to include here in the first place as the IORT spec is not giving any
> further details about the RMR regions(May be the flags field can be extended to
> describe these details).

We probably need to bring this back up to the ACPI forums. This is probably
something that should be attached to the memory range node which does have
4 extra reserved bytes.

-Jon

>
> Thanks,
> Shameer
>
>
