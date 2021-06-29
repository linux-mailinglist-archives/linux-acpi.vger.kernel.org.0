Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11DA3B6E86
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 09:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhF2HHN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 03:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhF2HHM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jun 2021 03:07:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB42C061574
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jun 2021 00:04:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o5so9496901ejy.7
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jun 2021 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYBTmnbrFY6e4uVDJho3HTMoNaiYI6JT+kpQ+czjgBc=;
        b=ubbHAgyQ+0/up/IYI6m2dbl28D92eV8V1EjvNKM2mtc2mwfewaWs651zFMwhO4/iUI
         V/QngHmNVz57v2VAELy6TB/A4Gs3HKFOsxSYkaPKMric5VI8q4e6RGpFxJl/PZRK1P1Z
         vQ4oWjoToo0geS57I9ByRm6DaObhdZWlbsgO7KhvRq26ssAgNth0DY9kNLw1deDKYXWa
         uaXW70YyHvJdDWVdW3pL97GaulAZCfJvaMkOw06iKlCjLC7LgSO+jV9b2898wO5e2Gyn
         nJKGmytoVCTwXkIaYoRDCttjNxFlnB6CwkjxtO7uz1CO1751NNXBkwrHhAM4i4C0K7MB
         EP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYBTmnbrFY6e4uVDJho3HTMoNaiYI6JT+kpQ+czjgBc=;
        b=FkyejnD3Mm+KDfjd/qaEvV0SB2cmy+tA4+bzhtLguHrfiizyVyX5B8pFow1LQKg8W1
         YfezGkt/LqSNvZyngEhIz0+5yuzVsBmnWrlO/k2qi1SZrDSsnk0lLnVhP2nqQLaV8XCm
         FgHrawnkxek6Rhg/iy/scouLf7m9z8tk/msHbJaUmaJ83vnqcc8/e7eCTX17eFPJvORo
         X2nZeWkv2zSnmD3YouO2EM37Rjn5ekM1TYOTIp0jZDVuTdmcBoubH9wuyGUT5hhaRMGx
         IAom9zmZCX8/v0IK6UXab6h9gkxgPDezZDV1uWU6meeBTBlk+dBQX9F56LDY6W6RncJi
         se2A==
X-Gm-Message-State: AOAM530+gKaOtnhQ7/skp4V96IMEQPgYwjckdzWDykGJ+SbNlfB097zC
        fl5ir67N69ge2gHFzkiQAG+eGxhdkaJcaYw6D1xPTg==
X-Google-Smtp-Source: ABdhPJxtQA+v0rp/NT2snj2jrDToSRx2to2k1C/zj58bDlD0p023vCUDoh9aRvnwnKFJjf8Le0Lu/hijhCo63Uyqk2Q=
X-Received: by 2002:a17:907:c87:: with SMTP id gi7mr28276614ejc.452.1624950274959;
 Tue, 29 Jun 2021 00:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com> <2bc3ae21-f2af-ee2c-5e9d-d47633e0439e@arm.com>
In-Reply-To: <2bc3ae21-f2af-ee2c-5e9d-d47633e0439e@arm.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Tue, 29 Jun 2021 09:03:57 +0200
Message-ID: <CABdtJHtpN7s2gTwUkeWcachOnk6djgMaJLGtnKq5SExA82bDDA@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Linuxarm <linuxarm@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>, Sami.Mujawar@arm.com,
        wanghuiqiang <wanghuiqiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 14, 2021 at 12:06 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-05-24 12:02, Shameer Kolothum wrote:
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
> >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 65 +++++++++++++++++++++++++++
> >   1 file changed, 65 insertions(+)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index 6f72c4d208ca..56db3d3238fc 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -2042,6 +2042,67 @@ err_reset_platform_ops: __maybe_unused;
> >       return err;
> >   }
> >
> > +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> > +{
> > +     struct list_head rmr_list;
> > +     struct iommu_resv_region *e;
> > +     int i, cnt = 0;
> > +     u32 smr;
> > +     u32 reg;
> > +
> > +     INIT_LIST_HEAD(&rmr_list);
> > +     if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> > +             return;
> > +
> > +     reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> > +
> > +     if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> > +             /*
> > +              * SMMU is already enabled and disallowing bypass, so preserve
> > +              * the existing SMRs
> > +              */
> > +             for (i = 0; i < smmu->num_mapping_groups; i++) {
> > +                     smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
>
> To reiterate, just because a bootloader/crashed kernel/whatever may have
> left some configuration behind doesn't mean that it matters (e.g. what
> if these SMRs are pointing at translation contexts?). All we should be
> doing here is setting the relevant RMR accommodations in our "clean
> slate" software state before the reset routine applies it to the
> hardware, just like patch #5 does for SMMUv3.
>
> Trying to safely reset an SMMU when we discover it with CLIENTPD=0 is
> really another issue entirely, and I'd say is beyond the scope of this
> series
>
> > +                     if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> > +                             continue;
>
> Note that that's not even necessarily correct (thanks to EXIDS).
>
> > +                     smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> > +                     smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> > +                     smmu->smrs[i].valid = true;
> > +             }
> > +     }
> > +
> > +     list_for_each_entry(e, &rmr_list, list) {
> > +             u32 sid = e->fw_data.rmr.sid;
> > +
> > +             i = arm_smmu_find_sme(smmu, sid, ~0);
> > +             if (i < 0)
> > +                     continue;
> > +             if (smmu->s2crs[i].count == 0) {
> > +                     smmu->smrs[i].id = sid;
> > +                     smmu->smrs[i].mask = ~0;
>
> This is very wrong (as has now already been pointed out).
>
> > +                     smmu->smrs[i].valid = true;
> > +             }
> > +             smmu->s2crs[i].count++;
> > +             smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> > +             smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> > +             smmu->s2crs[i].cbndx = 0xff;
>
> Nit: cbndx is left uninitialised for bypass/fault entries elsewhere, so
> there's little point touching it here.
>
> > +
> > +             cnt++;
> > +     }
> > +
> > +     if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> > +             /* Remove the valid bit for unused SMRs */
> > +             for (i = 0; i < smmu->num_mapping_groups; i++) {
> > +                     if (smmu->s2crs[i].count == 0)
> > +                             smmu->smrs[i].valid = false;
> > +             }
>
> If this dance is only about avoiding stream match conflicts when trying
> to reprogram live SMRs, simply turning the SMMU off beforehand would be
> a lot simpler.

Robin,

I am not sure what you mean here, and maybe Steve wants to jump in and
help clarify.

My understanding is that "dance" is required for regions that need to
continue to work
throughout the boot process.  I think the example I have seen the most
is for GOP drivers that
use system memory rather than dedicated VRAM.

-Jon

>
> Robin.
>
> > +     }
> > +
> > +     dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> > +                cnt == 1 ? "" : "s");
> > +     iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> > +}
> > +
> >   static int arm_smmu_device_probe(struct platform_device *pdev)
> >   {
> >       struct resource *res;
> > @@ -2168,6 +2229,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
