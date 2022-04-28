Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65B9513582
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Apr 2022 15:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbiD1Nrb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 28 Apr 2022 09:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347589AbiD1NrZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Apr 2022 09:47:25 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030F55C77F
        for <linux-acpi@vger.kernel.org>; Thu, 28 Apr 2022 06:44:09 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kpxdr0gfqz1JBgp;
        Thu, 28 Apr 2022 21:43:12 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 21:44:07 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 21:44:06 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Thu, 28 Apr 2022 14:44:04 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: RE: [PATCH v11 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Topic: [PATCH v11 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Index: AQHYVmZKfsv4Ue0JXEuZq1FbubftY60CR10AgAMWlzA=
Date:   Thu, 28 Apr 2022 13:44:04 +0000
Message-ID: <998324e8df75458aa28de6727e84333c@huawei.com>
References: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
 <20220422162907.1276-5-shameerali.kolothum.thodi@huawei.com>
 <YmgP7KFe/tNYXKd2@lpieralisi>
In-Reply-To: <YmgP7KFe/tNYXKd2@lpieralisi>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Lorenzo,

> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: 26 April 2022 16:30
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>;
> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; steven.price@arm.com; Sami.Mujawar@arm.com;
> jon@solid-run.com; eric.auger@redhat.com; laurentiu.tudor@nxp.com;
> hch@infradead.org
> Subject: Re: [PATCH v11 4/9] ACPI/IORT: Add support to retrieve IORT RMR
> reserved regions
> 
> On Fri, Apr 22, 2022 at 05:29:02PM +0100, Shameer Kolothum wrote:
> > Parse through the IORT RMR nodes and populate the reserve region list
> > corresponding to a given IOMMU and device(optional). Also, go through
> > the ID mappings of the RMR node and retrieve all the SIDs associated
> > with it.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/acpi/arm64/iort.c | 290
> ++++++++++++++++++++++++++++++++++++++
> >  include/linux/iommu.h     |   8 ++
> >  2 files changed, 298 insertions(+)
> 
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks. I just realized that need a R-by from you for patch #2 as well.

Also for patch #5, I dropped your R-by tag as there is a minor change w.r.t
free up. If you are Ok, I can add that back.

Thanks,
Shameer
 
