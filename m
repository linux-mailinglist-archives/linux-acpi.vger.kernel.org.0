Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087713A78A9
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jun 2021 10:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhFOIF1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Jun 2021 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhFOIF0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jun 2021 04:05:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D8DC061574
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 01:03:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g8so21034546ejx.1
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wdI+I/lHUujwC+TG2fdDJeHoDIEtdGAbbt6V+XPJtuk=;
        b=w+uRwxflv4sk6WV3aTuO9qp0FbwtGw1hcMJ7HFwAVngxqPNxAFVh/CT96PRsj9WZMf
         N00VzbA5Kq0OgL64OdzL7UEG02m3NZc5lR0DO/q09tUx7kXpMy3uThdpaF6n3T/aoLkT
         a+3VB+bkrWAFM1p7czKoMmKHnmrwv5k27o03FVJe8ocMcs/sF4wiDbVl1GiKTQblr7wl
         sfWyFfFkfOQZzhXjA2sfLkMGfvdxl5jxjjEW8waEMED6b+kYaox1dLmiVTwPcnOXxGi0
         XmNMk11St7HZW9G4RlTSEORegRMjFuyPHRBSYADb2VNfx2o1uuCYgF+zsoU9TWSGCoQH
         lGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wdI+I/lHUujwC+TG2fdDJeHoDIEtdGAbbt6V+XPJtuk=;
        b=i4Wz3bTWL6Lm71ECX2OSrY2XCa7/VLBmtD+T6crOkP1HZxKqo76n/GY4FGQ2UyYld8
         kCX95EBMKIm4CRb4NQtND9vL+1LUC7ovqGFl/1KSDddbfJGYJ5ww9x8fhvuZD2bwJ1ye
         k5cfbgoPQgXaVIWY91WuJdfE/3Qnp7HDaLNSq/f3RgSTThCPB6ZOu2PdPlpSsWrEmzVh
         LTfJo/MSFnKAj864yBzEwBQKvu2fCxpBEa21naxQ615j9KfHLppaNSEHSTmkt5S5pQb3
         zSSnBARLnc7CTJztgaaAYaUbSfNYvcAsgFWDe8Hfm1zmCs2Yj0qZEYd5HeqiLntePLXU
         sTOQ==
X-Gm-Message-State: AOAM532NPfn7fOehy/Gg9VKPlkrGMTQ+kIH4lcSSTCl4bwBfUosi+pvc
        tyukjff3b9Wdtt0O0V2U9EFXXCd8uMAltWSLTPvVKg==
X-Google-Smtp-Source: ABdhPJxuTet90M2NLgVYa3MYWkSjzYxkKWvjEVMnEKTQudT8ZIAhxX2gd53MZccjagmA6lzAaL4w8zUYb22bLlsq3Ok=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr18865640ejj.16.1623744201193;
 Tue, 15 Jun 2021 01:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
 <2bc3ae21-f2af-ee2c-5e9d-d47633e0439e@arm.com> <9348e07e23db4522b79318b81937f221@huawei.com>
In-Reply-To: <9348e07e23db4522b79318b81937f221@huawei.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Tue, 15 Jun 2021 10:02:44 +0200
Message-ID: <CABdtJHuEpg0+whCvQn2oHOVX9wqjS3LUDyaHJr6vf31Kuj+-Fg@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 14, 2021 at 6:51 PM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Robin Murphy [mailto:robin.murphy@arm.com]
> > Sent: 14 June 2021 11:06
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > iommu@lists.linux-foundation.org
> > Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> > steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> > yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
> > wanghuiqiang <wanghuiqiang@huawei.com>
> > Subject: Re: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
> > install bypass SMR
> >
> > On 2021-05-24 12:02, Shameer Kolothum wrote:
> > > From: Jon Nettleton <jon@solid-run.com>
> > >
> > > Check if there is any RMR info associated with the devices behind
> > > the SMMU and if any, install bypass SMRs for them. This is to
> > > keep any ongoing traffic associated with these devices alive
> > > when we enable/reset SMMU during probe().
> > >
> > > Signed-off-by: Jon Nettleton <jon@solid-run.com>
> > > Signed-off-by: Steven Price <steven.price@arm.com>
> > > Signed-off-by: Shameer Kolothum
> > <shameerali.kolothum.thodi@huawei.com>
> > > ---
> > >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 65
> > +++++++++++++++++++++++++++
> > >   1 file changed, 65 insertions(+)
> > >
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > index 6f72c4d208ca..56db3d3238fc 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > @@ -2042,6 +2042,67 @@ err_reset_platform_ops: __maybe_unused;
> > >     return err;
> > >   }
> > >
> > > +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device
> > *smmu)
> > > +{
> > > +   struct list_head rmr_list;
> > > +   struct iommu_resv_region *e;
> > > +   int i, cnt =3D 0;
> > > +   u32 smr;
> > > +   u32 reg;
> > > +
> > > +   INIT_LIST_HEAD(&rmr_list);
> > > +   if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> > > +           return;
> > > +
> > > +   reg =3D arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> > > +
> > > +   if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg &
> > ARM_SMMU_sCR0_CLIENTPD)) {
> > > +           /*
> > > +            * SMMU is already enabled and disallowing bypass, so pre=
serve
> > > +            * the existing SMRs
> > > +            */
> > > +           for (i =3D 0; i < smmu->num_mapping_groups; i++) {
> > > +                   smr =3D arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(=
i));
> >
> > To reiterate, just because a bootloader/crashed kernel/whatever may hav=
e
> > left some configuration behind doesn't mean that it matters (e.g. what
> > if these SMRs are pointing at translation contexts?). All we should be
> > doing here is setting the relevant RMR accommodations in our "clean
> > slate" software state before the reset routine applies it to the
> > hardware, just like patch #5 does for SMMUv3.
> >
> > Trying to safely reset an SMMU when we discover it with CLIENTPD=3D0 is
> > really another issue entirely, and I'd say is beyond the scope of this
> > series
> >
> > > +                   if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> > > +                           continue;
> >
> > Note that that's not even necessarily correct (thanks to EXIDS).
> >
> > > +                   smmu->smrs[i].id =3D FIELD_GET(ARM_SMMU_SMR_ID, s=
mr);
> > > +                   smmu->smrs[i].mask =3D FIELD_GET(ARM_SMMU_SMR_MAS=
K,
> > smr);
> > > +                   smmu->smrs[i].valid =3D true;
> > > +           }
> > > +   }
> > > +
> > > +   list_for_each_entry(e, &rmr_list, list) {
> > > +           u32 sid =3D e->fw_data.rmr.sid;
> > > +
> > > +           i =3D arm_smmu_find_sme(smmu, sid, ~0);
> > > +           if (i < 0)
> > > +                   continue;
> > > +           if (smmu->s2crs[i].count =3D=3D 0) {
> > > +                   smmu->smrs[i].id =3D sid;
> > > +                   smmu->smrs[i].mask =3D ~0;
> >
> > This is very wrong (as has now already been pointed out).
> >
> > > +                   smmu->smrs[i].valid =3D true;
> > > +           }
> > > +           smmu->s2crs[i].count++;
> > > +           smmu->s2crs[i].type =3D S2CR_TYPE_BYPASS;
> > > +           smmu->s2crs[i].privcfg =3D S2CR_PRIVCFG_DEFAULT;
> > > +           smmu->s2crs[i].cbndx =3D 0xff;
> >
> > Nit: cbndx is left uninitialised for bypass/fault entries elsewhere, so
> > there's little point touching it here.
> >
> > > +
> > > +           cnt++;
> > > +   }
> > > +
> > > +   if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg &
> > ARM_SMMU_sCR0_CLIENTPD)) {
> > > +           /* Remove the valid bit for unused SMRs */
> > > +           for (i =3D 0; i < smmu->num_mapping_groups; i++) {
> > > +                   if (smmu->s2crs[i].count =3D=3D 0)
> > > +                           smmu->smrs[i].valid =3D false;
> > > +           }
> >
> > If this dance is only about avoiding stream match conflicts when trying
> > to reprogram live SMRs, simply turning the SMMU off beforehand would be
> > a lot simpler.
>
> Hi Steve/Jon,
>
> Since I don=E2=80=99t have access to an SMMUv2 setup, really appreciate i=
f one of you
> could please take a look at the above comments and provide me with a test=
ed
> code so that I can include it in the v6 that I am planning to send out so=
on.

Will do.  Thanks.
Jon

>
> Thanks,
> Shameer
>
> > Robin.
> >
> > > +   }
> > > +
> > > +   dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> > > +              cnt =3D=3D 1 ? "" : "s");
> > > +   iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> > > +}
> > > +
> > >   static int arm_smmu_device_probe(struct platform_device *pdev)
> > >   {
> > >     struct resource *res;
> > > @@ -2168,6 +2229,10 @@ static int arm_smmu_device_probe(struct
> > platform_device *pdev)
> > >     }
> > >
> > >     platform_set_drvdata(pdev, smmu);
> > > +
> > > +   /* Check for RMRs and install bypass SMRs if any */
> > > +   arm_smmu_rmr_install_bypass_smr(smmu);
> > > +
> > >     arm_smmu_device_reset(smmu);
> > >     arm_smmu_test_smr_masks(smmu);
> > >
> > >
