Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EB63B766E
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 18:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhF2Q26 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 12:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhF2Q25 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jun 2021 12:28:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C880C061760
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jun 2021 09:26:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id b2so6039387ejg.8
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jun 2021 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6a5ku/KsDYb39XdizodNeqaVTk55z1jvwlHuTYEpkp8=;
        b=Yeu3St5BIPY9uQPow/7Dj5T4H0xOwk/sqNeYD+ScRUuGnKWR6yV2i9pHm5IOInbUXQ
         EMKmNWQ7MXhP3gbwyG8jM8FGqLaNM0r+lwzS58ehwcTZ/XYgXgDW25tc1uLOZtpU5cJT
         SCerYvTA3ku/BP9LkpgTO/TFcZgjn+VLzgOmfjC9+MmD+LGoSjV47Vg362ikPuhl6sNk
         NFG1eFsrweJbQFSZhvgfQSxNBWRKxEdjl2zP48k3xfoIYrVW9482iYl8k9G9MkeIwILh
         MLmjzzikAyo5aYhWK/Bo2IzMlPduW8AM1gAw7dSUtufR8zFOWwMXPEttj4DFZOnLe7Ys
         Zh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6a5ku/KsDYb39XdizodNeqaVTk55z1jvwlHuTYEpkp8=;
        b=HCdL2xWlTyNyg/Bbu5c7jMYqJjmg2Dtjuzt6UmLcWGx3KkA4us+i0ZZSW6kL/ZtMmZ
         pR0XZwcTSBG/oWRRcnzmLiOPx/lfM1PdJOnXw0KjnpEIgacGTckajCq5/yR7DLIx9s4U
         wyWP1TRAHERAGyPDny2o36qgLGZCEa+mJ1rkxtJTt1Rp0Yi51e9aB7pmpp7t3mr5X2qq
         HcPcFGCGNZ7XLYl6qbYyiIRuq1e50bckaxM/U2pI6jY6TNy8K0mKZQPupCwZwqJtu58J
         zNoTrG53JB/sIvQ1SCSyCOkcL+psfFdr/zU9fgJuBB/9KCvBJ2XjfmugjFqcHgB98niT
         Ig/A==
X-Gm-Message-State: AOAM530SgXOSnyMZ4WWcAM3ZEF3jUN96mKrAiXmoelRFr1yM27uvAZJ9
        fWoFSDnKn4S5US9/OS/9WJ7aVO3ABXaV1CvqA2rk7g==
X-Google-Smtp-Source: ABdhPJx5bnrYOid59YrT5k++0MfRlEMWuXkSqyse1E5J44TCy7mTHlhq+BiUEMzcRPQmZqf2Hm9Cm2FTrPfSWbhkP9I=
X-Received: by 2002:a17:907:d9f:: with SMTP id go31mr28318107ejc.165.1624983988705;
 Tue, 29 Jun 2021 09:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
 <2bc3ae21-f2af-ee2c-5e9d-d47633e0439e@arm.com> <CABdtJHtpN7s2gTwUkeWcachOnk6djgMaJLGtnKq5SExA82bDDA@mail.gmail.com>
 <b33c1525-5a74-a985-fd39-f4df8614f210@arm.com>
In-Reply-To: <b33c1525-5a74-a985-fd39-f4df8614f210@arm.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Tue, 29 Jun 2021 18:25:51 +0200
Message-ID: <CABdtJHsz+ycVffJTyekau_OY6ROmoTBWAGd_guikxauT=nnuJQ@mail.gmail.com>
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

On Tue, Jun 29, 2021 at 3:23 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-06-29 08:03, Jon Nettleton wrote:
> > On Mon, Jun 14, 2021 at 12:06 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2021-05-24 12:02, Shameer Kolothum wrote:
> >>> From: Jon Nettleton <jon@solid-run.com>
> >>>
> >>> Check if there is any RMR info associated with the devices behind
> >>> the SMMU and if any, install bypass SMRs for them. This is to
> >>> keep any ongoing traffic associated with these devices alive
> >>> when we enable/reset SMMU during probe().
> >>>
> >>> Signed-off-by: Jon Nettleton <jon@solid-run.com>
> >>> Signed-off-by: Steven Price <steven.price@arm.com>
> >>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> >>> ---
> >>>    drivers/iommu/arm/arm-smmu/arm-smmu.c | 65 +++++++++++++++++++++++++++
> >>>    1 file changed, 65 insertions(+)
> >>>
> >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>> index 6f72c4d208ca..56db3d3238fc 100644
> >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>> @@ -2042,6 +2042,67 @@ err_reset_platform_ops: __maybe_unused;
> >>>        return err;
> >>>    }
> >>>
> >>> +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> >>> +{
> >>> +     struct list_head rmr_list;
> >>> +     struct iommu_resv_region *e;
> >>> +     int i, cnt = 0;
> >>> +     u32 smr;
> >>> +     u32 reg;
> >>> +
> >>> +     INIT_LIST_HEAD(&rmr_list);
> >>> +     if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> >>> +             return;
> >>> +
> >>> +     reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> >>> +
> >>> +     if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> >>> +             /*
> >>> +              * SMMU is already enabled and disallowing bypass, so preserve
> >>> +              * the existing SMRs
> >>> +              */
> >>> +             for (i = 0; i < smmu->num_mapping_groups; i++) {
> >>> +                     smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> >>
> >> To reiterate, just because a bootloader/crashed kernel/whatever may have
> >> left some configuration behind doesn't mean that it matters (e.g. what
> >> if these SMRs are pointing at translation contexts?). All we should be
> >> doing here is setting the relevant RMR accommodations in our "clean
> >> slate" software state before the reset routine applies it to the
> >> hardware, just like patch #5 does for SMMUv3.
> >>
> >> Trying to safely reset an SMMU when we discover it with CLIENTPD=0 is
> >> really another issue entirely, and I'd say is beyond the scope of this
> >> series
> >>
> >>> +                     if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> >>> +                             continue;
> >>
> >> Note that that's not even necessarily correct (thanks to EXIDS).
> >>
> >>> +                     smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> >>> +                     smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> >>> +                     smmu->smrs[i].valid = true;
> >>> +             }
> >>> +     }
> >>> +
> >>> +     list_for_each_entry(e, &rmr_list, list) {
> >>> +             u32 sid = e->fw_data.rmr.sid;
> >>> +
> >>> +             i = arm_smmu_find_sme(smmu, sid, ~0);
> >>> +             if (i < 0)
> >>> +                     continue;
> >>> +             if (smmu->s2crs[i].count == 0) {
> >>> +                     smmu->smrs[i].id = sid;
> >>> +                     smmu->smrs[i].mask = ~0;
> >>
> >> This is very wrong (as has now already been pointed out).
> >>
> >>> +                     smmu->smrs[i].valid = true;
> >>> +             }
> >>> +             smmu->s2crs[i].count++;
> >>> +             smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> >>> +             smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> >>> +             smmu->s2crs[i].cbndx = 0xff;
> >>
> >> Nit: cbndx is left uninitialised for bypass/fault entries elsewhere, so
> >> there's little point touching it here.
> >>
> >>> +
> >>> +             cnt++;
> >>> +     }
> >>> +
> >>> +     if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> >>> +             /* Remove the valid bit for unused SMRs */
> >>> +             for (i = 0; i < smmu->num_mapping_groups; i++) {
> >>> +                     if (smmu->s2crs[i].count == 0)
> >>> +                             smmu->smrs[i].valid = false;
> >>> +             }
> >>
> >> If this dance is only about avoiding stream match conflicts when trying
> >> to reprogram live SMRs, simply turning the SMMU off beforehand would be
> >> a lot simpler.
> >
> > Robin,
> >
> > I am not sure what you mean here, and maybe Steve wants to jump in and
> > help clarify.
> >
> > My understanding is that "dance" is required for regions that need to
> > continue to work
> > throughout the boot process.  I think the example I have seen the most
> > is for GOP drivers that
> > use system memory rather than dedicated VRAM.
>
> All that is required is to install bypass SMEs for the relevant streams
> before enabling the SMMU. That much is achieved by the
> list_for_each_entry(e, &rmr_list, list) loop setting up initial state
> followed by arm_smmu_device_reset(). The "dance" I'm referring to is the
> additional reading out of (possibly nonsense) SMR state beforehand to
> pre-bias the SMR allocator, then trying to clean up the remnants afterwards.
>
> If we're going to pretend to be robust against finding the SMMU already
> enabled *with* live traffic ongoing, there's frankly an awful lot more
> care we'd need to take beyond here (and for some aspects there's still
> no right answer). If on the other hand we're implicitly assuming that
> any boot-time enabled SMRs exactly match the RMR configuration anyway,
> then simply disabling the SMMU until we enable it again in the reset
> routine still preserves the necessary bypass behaviour for RMR streams
> while sidestepping any issues related to reprogramming live SMMU state.
>
> Robin.
>
> >>> +     }
> >>> +
> >>> +     dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> >>> +                cnt == 1 ? "" : "s");
> >>> +     iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> >>> +}
> >>> +
> >>>    static int arm_smmu_device_probe(struct platform_device *pdev)
> >>>    {
> >>>        struct resource *res;
> >>> @@ -2168,6 +2229,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >>>        }
> >>>
> >>>        platform_set_drvdata(pdev, smmu);
> >>> +
> >>> +     /* Check for RMRs and install bypass SMRs if any */
> >>> +     arm_smmu_rmr_install_bypass_smr(smmu);
> >>> +
> >>>        arm_smmu_device_reset(smmu);
> >>>        arm_smmu_test_smr_masks(smmu);
> >>>
> >>>

Shameer,

Sorry for the delays.  Here is a diff of the changes that should
address the issues pointed out by Robin,
I have tested that this works as expected on my HoneyComb LX2160A.

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index ab7b9db77625..a358bd326d0b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2068,29 +2068,21 @@ static void
arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
        struct list_head rmr_list;
        struct iommu_resv_region *e;
        int i, cnt = 0;
-       u32 smr;
        u32 reg;

        INIT_LIST_HEAD(&rmr_list);
        if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
                return;

-       reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
+       /* Rather than trying to look at existing mappings that
+        * are setup by the firmware and then invalidate the ones
+        * that do no have matching RMR entries, just disable the
+        * SMMU until it gets enabled again in the reset routine.
+        */

-       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
-               /*
-                * SMMU is already enabled and disallowing bypass, so preserve
-                * the existing SMRs
-                */
-               for (i = 0; i < smmu->num_mapping_groups; i++) {
-                       smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
-                       if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
-                               continue;
-                       smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
-                       smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
-                       smmu->smrs[i].valid = true;
-               }
-       }
+       reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
+       reg &= ~ARM_SMMU_sCR0_CLIENTPD;
+       arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, reg);

        list_for_each_entry(e, &rmr_list, list) {
                u32 sid = e->fw_data.rmr.sid;
@@ -2100,25 +2092,16 @@ static void
arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
                        continue;
                if (smmu->s2crs[i].count == 0) {
                        smmu->smrs[i].id = sid;
-                       smmu->smrs[i].mask = ~0;
+                       smmu->smrs[i].mask = 0;
                        smmu->smrs[i].valid = true;
                }
                smmu->s2crs[i].count++;
                smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
                smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
-               smmu->s2crs[i].cbndx = 0xff;

                cnt++;
        }

-       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
-               /* Remove the valid bit for unused SMRs */
-               for (i = 0; i < smmu->num_mapping_groups; i++) {
-                       if (smmu->s2crs[i].count == 0)
-                               smmu->smrs[i].valid = false;
-               }
-       }
-
        dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
                   cnt == 1 ? "" : "s");
        iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);

Please include that in your next patch series.  Let me know if you
want me to send you the patch direct
off the list.

Thanks,
Jon
