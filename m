Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66ED5338F0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 10:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiEYI7q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 25 May 2022 04:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiEYI7p (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 04:59:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B681070350
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 01:59:43 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L7Q496S71zDqSw;
        Wed, 25 May 2022 16:59:37 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 16:59:41 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 16:59:40 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Wed, 25 May 2022 09:59:39 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: RE: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYXwu3gTgIMyz0zUiu6Dja1BmGsa0PbqaAgAhOLiD///4qAIAE064AgAYtdiCADLBS4A==
Date:   Wed, 25 May 2022 08:59:39 +0000
Message-ID: <0c12f81f62f8415f8061cb844f779904@huawei.com>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
 <2234ad60-c49f-8c72-616c-dfa5300354ef@huawei.com>
 <8e4f012717e34195a53cb73f8ce28627@huawei.com>
 <5c8ae673-f8e3-0ed3-e62d-d445913b012c@arm.com>
 <20220513094940.GA23371@lpieralisi> 
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: 17 May 2022 08:18
> To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>; Robin Murphy
> <robin.murphy@arm.com>; rafael@kernel.org; joro@8bytes.org
> Cc: Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>;
> will@kernel.org; wanghuiqiang <wanghuiqiang@huawei.com>;
> steven.price@arm.com; Sami.Mujawar@arm.com; jon@solid-run.com;
> eric.auger@redhat.com; laurentiu.tudor@nxp.com; hch@infradead.org
> Subject: RE: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
> 
> 
> > -----Original Message-----
> > From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> > Sent: 13 May 2022 10:50
> > To: Robin Murphy <robin.murphy@arm.com>; Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>; rafael@kernel.org;
> > joro@8bytes.org
> > Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> > linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>;
> > will@kernel.org; wanghuiqiang <wanghuiqiang@huawei.com>;
> > steven.price@arm.com; Sami.Mujawar@arm.com; jon@solid-run.com;
> > eric.auger@redhat.com; laurentiu.tudor@nxp.com; hch@infradead.org
> > Subject: Re: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
> >
> > [with Christoph's correct email address]
> >
> > On Tue, May 10, 2022 at 09:07:00AM +0100, Robin Murphy wrote:
> > > On 2022-05-10 08:23, Shameerali Kolothum Thodi wrote:
> > > > Hi Joerg/Robin,
> > > >
> > > > I think this series is now ready to be merged. Could you please let
> > > > me know if there is anything missing.
> > >
> > > Fine by me - these patches have had enough review and testing now that
> > > even if anything else did come up, I think it would be better done as
> > > follow-up work on the merged code.
> >
> > Given the ACPICA dependency I believe it is best for this series
> > to go via the ACPI tree, right ?
> >
> > I assume there are all the required ACKs for that to happen.
> 
> The SMMUv3/SMMU related changes (patches 6 - 9) still doesn't have
> explicit ACK from maintainers other than the go ahead above from Robin.
> 
> Just thought of highlighting it as not sure that will be an issue or not.
> 

All,

Just a gentle ping on this series again. Any chance this can make into 5.19?

Please consider.

Thanks,
Shameer

