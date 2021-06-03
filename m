Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF968399D35
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 10:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCIz0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Jun 2021 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhFCIz0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jun 2021 04:55:26 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65479C06174A
        for <linux-acpi@vger.kernel.org>; Thu,  3 Jun 2021 01:53:32 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id f15so2585075vsq.12
        for <linux-acpi@vger.kernel.org>; Thu, 03 Jun 2021 01:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Myemz5k16Nb16eM+VNAAZnl9WcdJHNpws7yrBRTSzQ8=;
        b=FIiLMwkjVLQwvIDeLZi02NT81EiYl8Vfp2TJ4+4aniF2IcsesHL+BydP/wXTPVWmgI
         SBAcJ2BAoTaOeIrGslJ5XmYP49OoR3Tu4uRa3pvDMs5SBYgCy+yG4VRr4v6lMaBYnDLc
         SKOeIG230/Eizv18tylHUlXlsoTt3u48K+zr+c9e31PVBp+K0OMj/IAUWRemEvdT+Or1
         p1zgDyza8IIruANBM7NvSo8ggNoATA7iKA4qQO+XsS0UTBvAR6KHhUpDQo/0CcRjMH3n
         mOIamavU9Bjb/bEFlzcfgqPwYMjHD5VeKXFFJyQKqgskoI/jocKzYi8bTUUQCfuW9xer
         xung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Myemz5k16Nb16eM+VNAAZnl9WcdJHNpws7yrBRTSzQ8=;
        b=muwuzx0zhgKvMKUopVOOSEmNJ7sHIBWDAWhApy8b3s7En8F5KRdHdSQLp7w5hGoO38
         +KpYVCs6D5Y9+3BfWD1Qk1Djs/0MBWQel69StidcNkKEruYcKqRLhprYXF5lTSJUI6gn
         NUEzVxJ5OEydd1F0V6vn/udgKLv9VuRKn9jcD93QpnLUmtGZTz+AtU5Z+la81KAyacmv
         u8bhqD1LS4B14QZ0amT3JrB1BmMQLd7Gb1dOT5nEbh2p7kXTZsuhFAYx53xUY0vzpBIy
         7BGBaMg00qBxu7yFTETbVttv4Ni9XSn2Rtm3lQHqu50k7kGgLmP/wcuw8ftaKZD8CBNV
         cgyA==
X-Gm-Message-State: AOAM5336RhaKDcBNTIW3BaQcIwuAOyFhbk6gBRxhfJhni36bdXNUu614
        r0pFe5INzifFxZwTWrvoN6CROyssAjPxyJMS/xlKXg==
X-Google-Smtp-Source: ABdhPJxj+4IT8+6qr07qq87ubJ2nmPl8BZS/9F8+PlebID2YL/LATooVU+fmNI4LSTztODs2WUyyuopyqMoKE7EXvwM=
X-Received: by 2002:a67:b406:: with SMTP id x6mr7014288vsl.10.1622710410065;
 Thu, 03 Jun 2021 01:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com> <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Thu, 3 Jun 2021 10:52:53 +0200
Message-ID: <CABdtJHvo7HZ0R1EzLrN2gVKfgcBWz5YRU-KSg==xvHR-01KWkw@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Linuxarm <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, joro@8bytes.org,
        Robin Murphy <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Steven Price <steven.price@arm.com>, Sami.Mujawar@arm.com,
        eric.auger@redhat.com, yangyicong <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 24, 2021 at 1:04 PM Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> From: Jon Nettleton <jon@solid-run.com>
>
> Check if there is any RMR info associated with the devices behind
> the SMMU and if any, install bypass SMRs for them. This is to
> keep any ongoing traffic associated with these devices alive
> when we enable/reset SMMU during probe().
>
> Signed-off-by: Jon Nettleton <jon@solid-run.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 65 +++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 6f72c4d208ca..56db3d3238fc 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2042,6 +2042,67 @@ err_reset_platform_ops: __maybe_unused;
>         return err;
>  }
>
> +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> +{
> +       struct list_head rmr_list;
> +       struct iommu_resv_region *e;
> +       int i, cnt = 0;
> +       u32 smr;
> +       u32 reg;
> +
> +       INIT_LIST_HEAD(&rmr_list);
> +       if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> +               return;
> +
> +       reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> +
> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> +               /*
> +                * SMMU is already enabled and disallowing bypass, so preserve
> +                * the existing SMRs
> +                */
> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
> +                       smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> +                       if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> +                               continue;
> +                       smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> +                       smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> +                       smmu->smrs[i].valid = true;
> +               }
> +       }
> +
> +       list_for_each_entry(e, &rmr_list, list) {
> +               u32 sid = e->fw_data.rmr.sid;
> +
> +               i = arm_smmu_find_sme(smmu, sid, ~0);
> +               if (i < 0)
> +                       continue;
> +               if (smmu->s2crs[i].count == 0) {
> +                       smmu->smrs[i].id = sid;
> +                       smmu->smrs[i].mask = ~0;
> +                       smmu->smrs[i].valid = true;
> +               }
> +               smmu->s2crs[i].count++;
> +               smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> +               smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> +               smmu->s2crs[i].cbndx = 0xff;
> +
> +               cnt++;
> +       }
> +
> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> +               /* Remove the valid bit for unused SMRs */
> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
> +                       if (smmu->s2crs[i].count == 0)
> +                               smmu->smrs[i].valid = false;
> +               }
> +       }
> +
> +       dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> +                  cnt == 1 ? "" : "s");
> +       iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> +}
> +
>  static int arm_smmu_device_probe(struct platform_device *pdev)
>  {
>         struct resource *res;
> @@ -2168,6 +2229,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>         }
>
>         platform_set_drvdata(pdev, smmu);
> +
> +       /* Check for RMRs and install bypass SMRs if any */
> +       arm_smmu_rmr_install_bypass_smr(smmu);
> +
>         arm_smmu_device_reset(smmu);
>         arm_smmu_test_smr_masks(smmu);
>
> --
> 2.17.1
>

Shameer and Robin

I finally got around to updating edk2 and the HoneyComb IORT tables to
reflect the new standards.
Out of the box the new patchset was generating errors immediatly after
the smmu bringup.

arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x2080000140,
fsynr=0x1d0040, cbfrsynra=0x4000, cb=0

These errors were generated even with disable_bypass=0

I tracked down the issue to

This code is skipped as Robin said would be correct

> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> +               /*
> +                * SMMU is already enabled and disallowing bypass, so preserve
> +                * the existing SMRs
> +                */
> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
> +                       smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> +                       if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> +                               continue;
> +                       smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> +                       smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> +                       smmu->smrs[i].valid = true;
> +               }[    2.707729] arm-smmu: setting up rmr list on 0x4000
[    2.712598] arm-smmu: s2crs count is 0 smrs index 0x0
[    2.717638] arm-smmu: s2crs count is 0 smrs id is 0x4000
[    2.722939] arm-smmu: s2crs count is 0 smrs mask is 0x8000
[    2.728417] arm-smmu arm-smmu.0.auto:        preserved 1 boot mapping

> +       }

Then this code block was hit which is correct

> +               if (smmu->s2crs[i].count == 0) {
> +                       smmu->smrs[i].id = sid;
> +                       smmu->smrs[i].mask = ~0;
> +                       smmu->smrs[i].valid = true;
> +               }

The mask was causing the issue.  If I think ammended that segment to read
the mask as setup by the hardware everything was back to functioning both
with and without disable_bypass set.

Some debug from that section when it is working

[    2.712598] arm-smmu: s2crs count is 0 smrs index 0x0
[    2.717638] arm-smmu: s2crs count is 0 smrs id is 0x4000
[    2.722939] arm-smmu: s2crs count is 0 smrs mask is 0x8000
[    2.728417] arm-smmu arm-smmu.0.auto:        preserved 1 boot mapping

Robin if anything jumps out at you let me know, otherwise I will debug further.

-Jon
