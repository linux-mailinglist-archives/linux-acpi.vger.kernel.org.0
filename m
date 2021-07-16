Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5243CBDE4
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 22:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhGPUoa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 16:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbhGPUoa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 16:44:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C317C061762
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jul 2021 13:41:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qb4so17020578ejc.11
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jul 2021 13:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEtbxbzRJfypbq28VwtBeys1nMOkBPjKemU4/5xjhFQ=;
        b=b1qbH9mms7hPB38VOsm9cAH4dPo2xvftYVHjhJXCd6FwadDNVflL+ztsiViqaBfhBk
         1Y9jQE4/+HbhCNXt/XeuNvtSXJPpdY0CgwxQ6E59FjtkHKVkSJYZ9Ntr0pxGgj7qsHHe
         KmGVIYuRLwo8q5LR7jaa2wpD3Bem4FLSNMC03wayttR2UrXHyg+MqjhEGDKb3OrkRykb
         rlj8p+q3G8YMY1RdKf/pBfrHBPRcqC6Z/bvE96tkO8ED2L02yC3T1Q0MkDzoXvL9aXpx
         Whm3JB74gWosHqbHfC4jEhzw1rmtCSyQ+UsYp1zo73fSqza5+2WSl6IOqrlh/rQ2cMW0
         F8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEtbxbzRJfypbq28VwtBeys1nMOkBPjKemU4/5xjhFQ=;
        b=aIiQWc23w0ESmPSPWglYu84uUVXA8QAJV29oV6KJiOr0JpwhC4eOqHMgohWT8gbkAy
         0GzKrpkLcKRxirfVouFC5LTFLOv10/mvxsWZHf5oSjM2arbf+fyqyBZIJsYBG3PoWB2i
         txBuau5jIsu3sZzZeH474xgHbF8HcTnvteT6NVmnZuxDA/siG3eaPKXIbyHcDAyjFdsj
         fCss6Mr1Mj9Yi5pBedXGpy7d4I9J4Py+caPmRVRzL6OgOIPdZ2Ii0Q5bVVXe0+q7TpO/
         iDQAP/V4qUXzE6mqFFSG0jmqh0EK7v++etMb7XYrQkLQpEPVeWgbtO1/2zbKNhC/rNpZ
         oufA==
X-Gm-Message-State: AOAM531LJNky5Z4ETa2TtSwc6PgbRNIk1k+Ku5XPL7hNYr4zLl7uHPcr
        SkPoEG7g5VHnhjhX0Ybc5g17EakIXOX4QYpcLjUd3w==
X-Google-Smtp-Source: ABdhPJz0X9g33SZknniYh2QG95F1sb+oMutu7eL+RPFrwLiUPi/JM18ZwbLrC4NLYIf0L8onJcpO3lgsDDKeTOges64=
X-Received: by 2002:a17:906:3699:: with SMTP id a25mr13618509ejc.452.1626468092286;
 Fri, 16 Jul 2021 13:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
 <20210716083442.1708-9-shameerali.kolothum.thodi@huawei.com> <b73d3408-7b2e-4cab-3b8c-efc22d08d99e@arm.com>
In-Reply-To: <b73d3408-7b2e-4cab-3b8c-efc22d08d99e@arm.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Fri, 16 Jul 2021 22:40:55 +0200
Message-ID: <CABdtJHu-2WxOwkKTa8o+cS_TfNv78Tes_nn3pPutv8q6vCC2CA@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To:     Steven Price <steven.price@arm.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Linuxarm <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, joro@8bytes.org,
        Robin Murphy <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>, eric.auger@redhat.com,
        yangyicong <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 16, 2021 at 3:52 PM Steven Price <steven.price@arm.com> wrote:
>
> On 16/07/2021 09:34, Shameer Kolothum wrote:
> > From: Jon Nettleton <jon@solid-run.com>
> >
> > Check if there is any RMR info associated with the devices behind
> > the SMMU and if any, install bypass SMRs for them. This is to
> > keep any ongoing traffic associated with these devices alive
> > when we enable/reset SMMU during probe().
> >
> > Signed-off-by: Jon Nettleton <jon@solid-run.com>
> > Signed-off-by: Steven Price <steven.price@arm.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c | 48 +++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index f22dbeb1e510..e9fb3d962a86 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -2063,6 +2063,50 @@ err_reset_platform_ops: __maybe_unused;
> >       return err;
> >  }
> >
> > +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> > +{
> > +     struct list_head rmr_list;
> > +     struct iommu_resv_region *e;
> > +     int i, cnt = 0;
> > +     u32 reg;
> > +
> > +     INIT_LIST_HEAD(&rmr_list);
> > +     if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> > +             return;
> > +
> > +     /*
> > +      * Rather than trying to look at existing mappings that
> > +      * are setup by the firmware and then invalidate the ones
> > +      * that do no have matching RMR entries, just disable the
> > +      * SMMU until it gets enabled again in the reset routine.
> > +      */
> > +     reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> > +     reg &= ~ARM_SMMU_sCR0_CLIENTPD;
>
> This looks backwards, the spec states:
>
>   Client Port Disable. The possible values of this bit are:
>   0 - Each SMMU client access is subject to SMMU translation, access
>       control, and attribute generation.
>   1 - Each SMMU client access bypasses SMMU translation, access control,
>       and attribute generation.
>   This bit resets to 1.
>
> And indeed with the current code if sCR0_USFCFG was set when
> sCR0_CLIENTPD is cleared then I get a blank screen until the smmu is reset.
>
> So I believe this should be ORing in the value, i.e.
>
>   reg |= ARM_SMMU_sCR0_CLIENTPD;
>
> And in my testing that works fine even if sCR0_USFCFG is set.

Sorry that is my bad.  It was a hurried and sloppy copy paste on my part.

Thanks for catching it
-Jon

>
> Steve
>
> > +     arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, reg);
> > +
> > +     list_for_each_entry(e, &rmr_list, list) {
> > +             u32 sid = e->fw_data.rmr.sid;
> > +
> > +             i = arm_smmu_find_sme(smmu, sid, ~0);
> > +             if (i < 0)
> > +                     continue;
> > +             if (smmu->s2crs[i].count == 0) {
> > +                     smmu->smrs[i].id = sid;
> > +                     smmu->smrs[i].mask = 0;
> > +                     smmu->smrs[i].valid = true;
> > +             }
> > +             smmu->s2crs[i].count++;
> > +             smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> > +             smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> > +
> > +             cnt++;
> > +     }
> > +
> > +     dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> > +                cnt == 1 ? "" : "s");
> > +     iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> > +}
> > +
> >  static int arm_smmu_device_probe(struct platform_device *pdev)
> >  {
> >       struct resource *res;
> > @@ -2189,6 +2233,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >       }
> >
> >       platform_set_drvdata(pdev, smmu);
> > +
> > +     /* Check for RMRs and install bypass SMRs if any */
> > +     arm_smmu_rmr_install_bypass_smr(smmu);
> > +
> >       arm_smmu_device_reset(smmu);
> >       arm_smmu_test_smr_masks(smmu);
> >
> >
>
