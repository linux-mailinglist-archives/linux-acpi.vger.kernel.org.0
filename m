Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D34348BBB
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Mar 2021 09:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCYIlc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Mar 2021 04:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCYIlJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Mar 2021 04:41:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405A6C06174A
        for <linux-acpi@vger.kernel.org>; Thu, 25 Mar 2021 01:41:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y6so1497128eds.1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Mar 2021 01:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsfdlrzZwaQUGlbzbbRFzp2tp5Odd7hk+8T93wyQeVk=;
        b=AGRdPZJf107faAWLYl2hiDFZtQiwGsNLdZGgIm0Uuh5uIMA7x0K+3s/B0Ru6hH+WSG
         WGt+cPuGLVYOA8HpnNn53HD7zD0thWM8J4mdRUPZ7kQ6W80fMMHsxSuvYh5vr3tHQ3Pe
         xlTWgSj/abYDMryHkX58UELCFL/tQnKy5ytVadUk36kQSLZm4DEPOE+GewEz1/IiARLp
         GPPY8JIdFt1x1nfme2l8wbLtWTPe8aIkfuVsHJ2K37kD103BgCbhMna5Y/OhFItJc8/A
         X99A9ubqADAZqCHRWJbgyToqL0KJAqPiz8ExIn9WXzBPLttDaykEhUjXpJyisn+OHAvo
         MvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsfdlrzZwaQUGlbzbbRFzp2tp5Odd7hk+8T93wyQeVk=;
        b=Wbvfr+wU7GoYGuxJeSpmWKuFFsWKm/L5+F8Me3YJ4OJay4J8IGLloVVVouwjnopQ76
         7LTk7IC5CN1sBcX9JZWfpzCP7kBHbJiTnhW8sESbqXbsVCIqw5faGsSbOzooiG2Ta+uc
         GHPaGDzj7ou+noBgGLyUdaeR42n0iaI+dgp0WKuHbMKBa/1LEjB0OuQNihT0oaLya3j7
         aq5bVqlBKdmSzAV5qrOhda1aOS+8LpmpaP1KwU/FdfaNA/yWJeHXlwyyO95lDvtRnsj6
         0GaNrgbb2MYrv3/eOkOVkSeSwFAF1lnOUPzDSf09z3jI6GTIEHlPvHtAdGvTJXNXYcct
         OPfg==
X-Gm-Message-State: AOAM533zAtB/7eORvDHGCkuPSn0+hgX3hOWg9owpTU1jxLMaYSsA2a5v
        D3HwM8epAC7DHTYhn10w+F5ZV+Icg4QGpL7ZYIvjWg==
X-Google-Smtp-Source: ABdhPJz5d82sxLC89VlxaSjlkGqOftoNRfakhu8Zm+u1x5+OI5OjnA4F90hSLeEU2bBqOB0BGdxncDG7YwW4euoUEsI=
X-Received: by 2002:a05:6402:31a7:: with SMTP id dj7mr7852439edb.33.1616661666928;
 Thu, 25 Mar 2021 01:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com> <b7a2424941214b33803e34ba3e532440@huawei.com>
In-Reply-To: <b7a2424941214b33803e34ba3e532440@huawei.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Thu, 25 Mar 2021 09:40:29 +0100
Message-ID: <CABdtJHtZPyWpXN9JZbgdu=HswreTc2o2pRhrwHFzQJqz-kFSBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "erik.kaneda@intel.com" <erik.kaneda@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 22, 2021 at 11:37 AM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> [+]
>
> Hi Erik,
>
> As this is now just merged ino acpica-master and based on the discussion we had here,
>
> https://github.com/acpica/acpica/pull/638
>
> I had a discussion with ARM folks(Lorenzo) in the linaro-open-discussions call and
> can confirm that the IORT Revision E is not the final specification and has some issues
> which is now corrected in the latest E.b revision[1]. Also there are no current users
> for the Rev E and it may not be a good idea to push this version into the Linux kernel
> or elsewhere.

Well it was a released revision, although it was found to have issues.
Currently
HoneyComb Systems Ready certified firmware does include support for this table,
although incomplete.  Without agreement on mainline support I am fine to update
to the latest spec bump.

>
> So could you please revert the merge and I am planning to work on the E.b soon.
> Please let me know if I need to explicitly send a revert pull request or not.

Can you please CC. me on your next release.  I was planning on spending time
on this regardless.  I already have a patchset for the fsl-mc-bus driver that
needs to change in order to function properly with RMR support.

Thanks.

>
> Thanks,
> Shameer
>
> 1. https://developer.arm.com/documentation/den0049/latest/
>
> > -----Original Message-----
> > From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf Of
> > Shameer Kolothum
> > Sent: 19 November 2020 12:12
> > To: linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > iommu@lists.linux-foundation.org; devel@acpica.org
> > Cc: Linuxarm <linuxarm@huawei.com>; steven.price@arm.com; Guohanjun
> > (Hanjun Guo) <guohanjun@huawei.com>; Sami.Mujawar@arm.com;
> > robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> > Subject: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
> >
> > IORT revision E contains a few additions like,
> >     -Added an identifier field in the node descriptors to aid table
> >      cross-referencing.
> >     -Introduced the Reserved Memory Range(RMR) node. This is used
> >      to describe memory ranges that are used by endpoints and requires
> >      a unity mapping in SMMU.
> >     -Introduced a flag in the RC node to express support for PRI.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  include/acpi/actbl2.h | 25 +++++++++++++++++++------
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> > ec66779cb193..274fce7b5c01 100644
> > --- a/include/acpi/actbl2.h
> > +++ b/include/acpi/actbl2.h
> > @@ -68,7 +68,7 @@
> >   * IORT - IO Remapping Table
> >   *
> >   * Conforms to "IO Remapping Table System Software on ARM Platforms",
> > - * Document number: ARM DEN 0049D, March 2018
> > + * Document number: ARM DEN 0049E, June 2020
> >   *
> >
> > ****************************************************************
> > **************/
> >
> > @@ -86,7 +86,8 @@ struct acpi_iort_node {
> >       u8 type;
> >       u16 length;
> >       u8 revision;
> > -     u32 reserved;
> > +     u16 reserved;
> > +     u16 identifier;
> >       u32 mapping_count;
> >       u32 mapping_offset;
> >       char node_data[1];
> > @@ -100,7 +101,8 @@ enum acpi_iort_node_type {
> >       ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
> >       ACPI_IORT_NODE_SMMU = 0x03,
> >       ACPI_IORT_NODE_SMMU_V3 = 0x04,
> > -     ACPI_IORT_NODE_PMCG = 0x05
> > +     ACPI_IORT_NODE_PMCG = 0x05,
> > +     ACPI_IORT_NODE_RMR = 0x06,
> >  };
> >
> >  struct acpi_iort_id_mapping {
> > @@ -167,10 +169,10 @@ struct acpi_iort_root_complex {
> >       u8 reserved[3];         /* Reserved, must be zero */
> >  };
> >
> > -/* Values for ats_attribute field above */
> > +/* Masks for ats_attribute field above */
> >
> > -#define ACPI_IORT_ATS_SUPPORTED         0x00000001   /* The root
> > complex supports ATS */
> > -#define ACPI_IORT_ATS_UNSUPPORTED       0x00000000   /* The root
> > complex doesn't support ATS */
> > +#define ACPI_IORT_ATS_SUPPORTED         (1)  /* The root complex
> > supports ATS */
> > +#define ACPI_IORT_PRI_SUPPORTED         (1<<1)       /* The root complex
> > supports PRI */
> >
> >  struct acpi_iort_smmu {
> >       u64 base_address;       /* SMMU base address */
> > @@ -241,6 +243,17 @@ struct acpi_iort_pmcg {
> >       u64 page1_base_address;
> >  };
> >
> > +struct acpi_iort_rmr {
> > +     u32 rmr_count;
> > +     u32 rmr_offset;
> > +};
> > +
> > +struct acpi_iort_rmr_desc {
> > +     u64 base_address;
> > +     u64 length;
> > +     u32 reserved;
> > +};
> > +
> >
> > /***************************************************************
> > ****************
> >   *
> >   * IVRS - I/O Virtualization Reporting Structure
> > --
> > 2.17.1
> >
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
