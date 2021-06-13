Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15303A56F8
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Jun 2021 09:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFMHol (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 13 Jun 2021 03:44:41 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:45842 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhFMHok (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Jun 2021 03:44:40 -0400
Received: by mail-ej1-f50.google.com with SMTP id k7so11131704ejv.12
        for <linux-acpi@vger.kernel.org>; Sun, 13 Jun 2021 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHghi3ehEDHpR81l5YKPvLBlsk0T7HfCV7TacfpzbeI=;
        b=o+cUnx2G2KEoTlVhnWeDA1LHpQNoOSamaIrl9Xany7HtsGTSTpChd1v+RUJt9V9YbP
         mK9QP64NseXN2M246A50Obv9CIKrbw0kS6kXCAxBVRpnmJtqboZRpJAbX3W4j8IWBtci
         5hwgm6eQDUXHFZTgW/lrp91ZW7MPfbSU4UraEtP4V7d0IvrTicr8JdcvIYzsY4xMnkYn
         v40CzXIknHTjwMITH18IlHB5jbnb+K4emfDXAy5pHQMPYbgdzKC56pQO2sqUJ7T2yro6
         d5CGE48TepJQSYlyaVXyaBajEEpEe2HqJheQPKrFAICmty6QIsSzBiVOHqv2yGMBEPxb
         5HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHghi3ehEDHpR81l5YKPvLBlsk0T7HfCV7TacfpzbeI=;
        b=X0gLCcPVJFyFOAEbtX7eTnpLn1BQcE+RK1I1uEP2ETU7CEbvL9K19RULJwxKIm4vkv
         cvA1mTJf9ZodDqadd/fy6ry8rPfrWFg39ynmfI2w8Hri2iayimpjXjc1RYPDqNQT+XXs
         A2an8dkgROknnKVMrjVkZst8vHhZKeodqKJOs7oD0aOsJE+kp6UlNUWua1hvFIgAf0d4
         FO4AEACvfZTwOp0bcX4v9/IQny1eqSzWJJEG/gns1QP8+7/7M9ONrQJ5Y1+BpcHzOxdo
         ZCiRhiyzcmnNy7C171seHFjMDxUS8WuopqG4FnAuY7fSJeefBgZJcVUY/dBbDkksBsBU
         9Kew==
X-Gm-Message-State: AOAM530UYa95BZ+qfS7HD6dW19bNTTKHKWDtjAK51ccIYosnr1mUcTuy
        H975nEFfx3wYONL+8p63XeikYIEQcpxEe/Qk+XZk1Q==
X-Google-Smtp-Source: ABdhPJyyHOxaif3zCXoDKw9sxiVm1/jwSz+9YN4CehDyz/mM0SNU/fqrCv/2O3iI+Xk59n2q0qBOS0emsDSI12cnDfM=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr10267396ejj.16.1623570086865;
 Sun, 13 Jun 2021 00:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
 <CABdtJHvo7HZ0R1EzLrN2gVKfgcBWz5YRU-KSg==xvHR-01KWkw@mail.gmail.com>
 <32dc72fa-534a-7eb4-dfcc-9bc244845a28@arm.com> <CABdtJHts-fO4pLU1VQddW0ra-tuh7s7j-eb3CJy6cFjv875UJg@mail.gmail.com>
In-Reply-To: <CABdtJHts-fO4pLU1VQddW0ra-tuh7s7j-eb3CJy6cFjv875UJg@mail.gmail.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Sun, 13 Jun 2021 09:40:50 +0200
Message-ID: <CABdtJHtj0UVQMCEJKeN5gb=kyRgZg7qiD9vqg_9qytVMVRFbGQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To:     Steven Price <steven.price@arm.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Linuxarm <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, joro@8bytes.org,
        Robin Murphy <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>, Sami.Mujawar@arm.com,
        eric.auger@redhat.com, yangyicong <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 3, 2021 at 1:51 PM Jon Nettleton <jon@solid-run.com> wrote:
>
> On Thu, Jun 3, 2021 at 1:27 PM Steven Price <steven.price@arm.com> wrote:
> >
> > On 03/06/2021 09:52, Jon Nettleton wrote:
> > > On Mon, May 24, 2021 at 1:04 PM Shameer Kolothum
> > > <shameerali.kolothum.thodi@huawei.com> wrote:
> > >>
> > >> From: Jon Nettleton <jon@solid-run.com>
> > >>
> > >> Check if there is any RMR info associated with the devices behind
> > >> the SMMU and if any, install bypass SMRs for them. This is to
> > >> keep any ongoing traffic associated with these devices alive
> > >> when we enable/reset SMMU during probe().
> > >>
> > >> Signed-off-by: Jon Nettleton <jon@solid-run.com>
> > >> Signed-off-by: Steven Price <steven.price@arm.com>
> > >> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > >> ---
> > >>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 65 +++++++++++++++++++++++++++
> > >>  1 file changed, 65 insertions(+)
> > >>
> > >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > >> index 6f72c4d208ca..56db3d3238fc 100644
> > >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > >> @@ -2042,6 +2042,67 @@ err_reset_platform_ops: __maybe_unused;
> > >>         return err;
> > >>  }
> > >>
> > >> +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> > >> +{
> > >> +       struct list_head rmr_list;
> > >> +       struct iommu_resv_region *e;
> > >> +       int i, cnt = 0;
> > >> +       u32 smr;
> > >> +       u32 reg;
> > >> +
> > >> +       INIT_LIST_HEAD(&rmr_list);
> > >> +       if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> > >> +               return;
> > >> +
> > >> +       reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> > >> +
> > >> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> > >> +               /*
> > >> +                * SMMU is already enabled and disallowing bypass, so preserve
> > >> +                * the existing SMRs
> > >> +                */
> > >> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
> > >> +                       smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> > >> +                       if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> > >> +                               continue;
> > >> +                       smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> > >> +                       smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> > >> +                       smmu->smrs[i].valid = true;
> > >> +               }
> > >> +       }
> > >> +
> > >> +       list_for_each_entry(e, &rmr_list, list) {
> > >> +               u32 sid = e->fw_data.rmr.sid;
> > >> +
> > >> +               i = arm_smmu_find_sme(smmu, sid, ~0);
> > >> +               if (i < 0)
> > >> +                       continue;
> > >> +               if (smmu->s2crs[i].count == 0) {
> > >> +                       smmu->smrs[i].id = sid;
> > >> +                       smmu->smrs[i].mask = ~0;
> >
> > Looking at this code again, that mask looks wrong! According to the SMMU
> > spec MASK[i]==1 means ID[i] is ignored. I.e. this means completely
> > ignore the ID...
> >
> > I'm not at all sure why they designed the hardware that way round.
> >
> > >> +                       smmu->smrs[i].valid = true;
> > >> +               }
> > >> +               smmu->s2crs[i].count++;
> > >> +               smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> > >> +               smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> > >> +               smmu->s2crs[i].cbndx = 0xff;
> > >> +
> > >> +               cnt++;
> > >> +       }
> > >> +
> > >> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> > >> +               /* Remove the valid bit for unused SMRs */
> > >> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
> > >> +                       if (smmu->s2crs[i].count == 0)
> > >> +                               smmu->smrs[i].valid = false;
> > >> +               }
> > >> +       }
> > >> +
> > >> +       dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> > >> +                  cnt == 1 ? "" : "s");
> > >> +       iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> > >> +}
> > >> +
> > >>  static int arm_smmu_device_probe(struct platform_device *pdev)
> > >>  {
> > >>         struct resource *res;
> > >> @@ -2168,6 +2229,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> > >>         }
> > >>
> > >>         platform_set_drvdata(pdev, smmu);
> > >> +
> > >> +       /* Check for RMRs and install bypass SMRs if any */
> > >> +       arm_smmu_rmr_install_bypass_smr(smmu);
> > >> +
> > >>         arm_smmu_device_reset(smmu);
> > >>         arm_smmu_test_smr_masks(smmu);
> > >>
> > >> --
> > >> 2.17.1
> > >>
> > >
> > > Shameer and Robin
> > >
> > > I finally got around to updating edk2 and the HoneyComb IORT tables to
> > > reflect the new standards.
> > > Out of the box the new patchset was generating errors immediatly after
> > > the smmu bringup.
> > >
> > > arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x2080000140,
> > > fsynr=0x1d0040, cbfrsynra=0x4000, cb=0
> > >
> > > These errors were generated even with disable_bypass=0
> > >
> > > I tracked down the issue to
> > >
> > > This code is skipped as Robin said would be correct
> >
> > If you're skipping the first bit of code, then that (hopefully) means
> > that the SMMU is disabled...
> >
> > >> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> > >> +               /*
> > >> +                * SMMU is already enabled and disallowing bypass, so preserve
> > >> +                * the existing SMRs
> > >> +                */
> > >> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
> > >> +                       smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> > >> +                       if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> > >> +                               continue;
> > >> +                       smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> > >> +                       smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> > >> +                       smmu->smrs[i].valid = true;
> > >> +               }[    2.707729] arm-smmu: setting up rmr list on 0x4000
> > > [    2.712598] arm-smmu: s2crs count is 0 smrs index 0x0
> > > [    2.717638] arm-smmu: s2crs count is 0 smrs id is 0x4000
> > > [    2.722939] arm-smmu: s2crs count is 0 smrs mask is 0x8000
> > > [    2.728417] arm-smmu arm-smmu.0.auto:        preserved 1 boot mapping
> > >
> > >> +       }
> > >
> > > Then this code block was hit which is correct
> > >
> > >> +               if (smmu->s2crs[i].count == 0) {
> > >> +                       smmu->smrs[i].id = sid;
> > >> +                       smmu->smrs[i].mask = ~0;
> > >> +                       smmu->smrs[i].valid = true;
> > >> +               }
> > >
> > > The mask was causing the issue.  If I think ammended that segment to read
> > > the mask as setup by the hardware everything was back to functioning both
> > > with and without disable_bypass set.
> >
> > ...so reading a mask from it doesn't sounds quite right.
> >
> > Can you have a go with a corrected mask of '0' rather than all-1s and
> > see if that helps? My guess is that the mask of ~0 was causing multiple
> > matches in the SMRs which is 'UNPREDICTABLE'.
> >
> > Sadly in my test setup there's only the one device behind the SMMU so
> > I didn't spot this (below patch works for me, but that's not saying
> > much).
> >
> > Steve
> >
> > --->8---
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index 56db3d3238fc..44831d0c78e4 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -2079,7 +2079,7 @@ static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> >                         continue;
> >                 if (smmu->s2crs[i].count == 0) {
> >                         smmu->smrs[i].id = sid;
> > -                       smmu->smrs[i].mask = ~0;
> > +                       smmu->smrs[i].mask = 0;
> >                         smmu->smrs[i].valid = true;
> >                 }
> >                 smmu->s2crs[i].count++;
>
> Yes this works fine. Thanks

Shameer,

Can you pick up this change into your next patch set?  Also are there
any objections to adding this to the SMMUv2 code from the maintainers?

-Jon
