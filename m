Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B3339A0CB
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 14:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhFCM37 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Jun 2021 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhFCM37 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jun 2021 08:29:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A1FC06174A
        for <linux-acpi@vger.kernel.org>; Thu,  3 Jun 2021 05:28:03 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id dj8so6895619edb.6
        for <linux-acpi@vger.kernel.org>; Thu, 03 Jun 2021 05:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cupGVl/5IxTa3rKFLjJb5XZgvnX7W+pc3ZwSu6gCUuU=;
        b=rf0uRuH8SyYiJW8SWeFHcGQEDeU9+71HgbKqphlndA9glZbX/gj1s7bwPrvwDHpr//
         wd4rCrv2w0mWzaCSh9OcEjSYoVl0jOX4cZLQfkK4CSGar3mR9VDp9JOx1UoQrX7gw4lo
         CPR9sv5FoDbjo5il2gYeA4FGndDB7BBpiv9RQTbH3wDzr6aHXOwKjIuScOr+vWXDPUxG
         RwzBYo4nCJalkbCd4jUIUoW2XzcQ2xNuAuzHg8Ul3ZGW5tP6A+LozCti9ajxBrTT8IMQ
         6XstNKNkXalKWFbF3u0ODc6y+v+R6lPKIec1ez9yseIEGQ2tCpAD8eLhvGeQ/q+n2Uyw
         Nv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cupGVl/5IxTa3rKFLjJb5XZgvnX7W+pc3ZwSu6gCUuU=;
        b=JO0fHh9KCSEPqR4BXyV3i3u+rCZgBv8tofPgsTb14jD/cJYjrCgv0/Kqz4hqYYS5wq
         pGy5j3Z0JCr8XFEcTRL7IT2Ko5G7kV5/p0GL+PQHwFkTlZC+AMKEwLy3CH1/k5ZINkz7
         Kb+GOnVlq27Ol+RfIOLvUgsFr8EvpGskXHxDQJYZaIHwKO/hq06mm1lO1bLUyp1is+hp
         z4DeKkcRBMZqQfenG+DiuzfTq4wvP/m2OjqeVWjrsXyr0e52tdWL6FHz5/LbUZJ6EFRg
         Xpe6DZziWniQI2BnKJmbxXvzDW7G5LcjbZ2g4qRT6TPE32gLE1YorBAShOSdJh/twzlt
         1u7g==
X-Gm-Message-State: AOAM530b6mRSkoQvt4rN2LtaIzdJVq5/oP05FUsj+IRF5593e1sjRvDy
        kkEf4RYg4TUBdy1vWFAqxikQ4E8vVoZHpXyKgJoh7g==
X-Google-Smtp-Source: ABdhPJxOzOWvdmytbNa3BVIP0qM3IZFg/1c1m6StO2tWfQYWIO26jbmMbFpCBTml+0lK9VSVGualJJsU6ExeT7WiAMw=
X-Received: by 2002:a05:6402:50d2:: with SMTP id h18mr44109981edb.10.1622723282435;
 Thu, 03 Jun 2021 05:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
 <13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com> <260859e85c854b90b513599f4febfbad@huawei.com>
 <df3ac090-118e-6ee4-80ee-798cc3760775@nxp.com>
In-Reply-To: <df3ac090-118e-6ee4-80ee-798cc3760775@nxp.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Thu, 3 Jun 2021 14:27:26 +0200
Message-ID: <CABdtJHv2QBHNoWTyp51H-J_apc75imPj0FbrV70Tm8xuNjpiTA@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory regions
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
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

On Wed, May 26, 2021 at 7:11 PM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>
>
>
> On 5/26/2021 7:36 PM, Shameerali Kolothum Thodi wrote:
> >
> >
> >> -----Original Message-----
> >> From: Laurentiu Tudor [mailto:laurentiu.tudor@nxp.com]
> >> Sent: 26 May 2021 08:53
> >> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> >> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> >> iommu@lists.linux-foundation.org
> >> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> >> steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> >> yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
> >> robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> >> Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
> >> regions
> >>
> >> Hi Shameer,
> >>
> >> On 5/24/2021 2:02 PM, Shameer Kolothum wrote:
> >>> Add a helper function that retrieves RMR memory descriptors
> >>> associated with a given IOMMU. This will be used by IOMMU
> >>> drivers to setup necessary mappings.
> >>>
> >>> Now that we have this, invoke it from the generic helper
> >>> interface.
> >>>
> >>> Signed-off-by: Shameer Kolothum
> >> <shameerali.kolothum.thodi@huawei.com>
> >>> ---
> >>>  drivers/acpi/arm64/iort.c | 50
> >> +++++++++++++++++++++++++++++++++++++++
> >>>  drivers/iommu/dma-iommu.c |  4 ++++
> >>>  include/linux/acpi_iort.h |  7 ++++++
> >>>  3 files changed, 61 insertions(+)
> >>>
> >>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >>> index fea1ffaedf3b..01917caf58de 100644
> >>> --- a/drivers/acpi/arm64/iort.c
> >>> +++ b/drivers/acpi/arm64/iort.c
> >>> @@ -12,6 +12,7 @@
> >>>
> >>>  #include <linux/acpi_iort.h>
> >>>  #include <linux/bitfield.h>
> >>> +#include <linux/dma-iommu.h>
> >>>  #include <linux/iommu.h>
> >>>  #include <linux/kernel.h>
> >>>  #include <linux/list.h>
> >>> @@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct
> >> device *dev)
> >>>     return err;
> >>>  }
> >>>
> >>> +/**
> >>> + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with
> >> IOMMU
> >>> + * @iommu: fwnode for the IOMMU
> >>> + * @head: RMR list head to be populated
> >>> + *
> >>> + * Returns: 0 on success, <0 failure
> >>> + */
> >>> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> >>> +                   struct list_head *head)
> >>> +{
> >>> +   struct iort_rmr_entry *e;
> >>> +   struct acpi_iort_node *iommu;
> >>> +   int rmrs = 0;
> >>> +
> >>> +   iommu = iort_get_iort_node(iommu_fwnode);
> >>> +   if (!iommu || list_empty(&iort_rmr_list))
> >>> +           return -ENODEV;
> >>> +
> >>> +   list_for_each_entry(e, &iort_rmr_list, list) {
> >>> +           int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC |
> >> IOMMU_MMIO;
> >>
> >> We have a case with an IP block that needs EXEC rights on its reserved
> >> memory, so could you please drop the IOMMU_NOEXEC flag?
> >
> > Ok, I think I can drop that one if there are no other concerns. I was not quite
> > sure what to include here in the first place as the IORT spec is not giving any
> > further details about the RMR regions(May be the flags field can be extended to
> > describe these details).
> >
>
> That would be great, given that some preliminary investigations on my
> side revealed that our IP block seems to be quite sensitive to memory
> attributes. I need to spend some more time on this but at first sight
> looks like it needs cacheable, normal memory (not mmio mapping).
>
> ---
> Thanks & Best Regards, Laurentiu

Laurentiu,

Is this regarding the mc-bin memory block or another IP?  I am currently
running this patchset with IOMMU_NOEXEC under ACPI without any problems.

If so maybe we can touch base off list and align on the implementation.

-Jon
