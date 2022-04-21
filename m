Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5649450A35F
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Apr 2022 16:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiDUOye convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 21 Apr 2022 10:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390044AbiDUOxX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Apr 2022 10:53:23 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DF9E0CA
        for <linux-acpi@vger.kernel.org>; Thu, 21 Apr 2022 07:50:09 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KkgRP36DQz1J9qw;
        Thu, 21 Apr 2022 22:49:21 +0800 (CST)
Received: from dggpemm100005.china.huawei.com (7.185.36.231) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 22:50:07 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100005.china.huawei.com (7.185.36.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 22:50:06 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Thu, 21 Apr 2022 15:50:04 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH v10 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Topic: [PATCH v10 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Index: AQHYVNbBiFMGcGX7Dk+uLBP0wkUUHKz53S4AgACVfEA=
Date:   Thu, 21 Apr 2022 14:50:03 +0000
Message-ID: <54f289c1cfc5401a978a29dc6ff2cea7@huawei.com>
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
 <20220420164836.1181-5-shameerali.kolothum.thodi@huawei.com>
 <YmD+Puk4xfPpwED9@infradead.org>
In-Reply-To: <YmD+Puk4xfPpwED9@infradead.org>
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



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: 21 April 2022 07:49
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>;
> lorenzo.pieralisi@arm.com; joro@8bytes.org; robin.murphy@arm.com;
> will@kernel.org; wanghuiqiang <wanghuiqiang@huawei.com>; Guohanjun
> (Hanjun Guo) <guohanjun@huawei.com>; steven.price@arm.com;
> Sami.Mujawar@arm.com; jon@solid-run.com; eric.auger@redhat.com;
> laurentiu.tudor@nxp.com; hch@infradead.org
> Subject: Re: [PATCH v10 4/9] ACPI/IORT: Add support to retrieve IORT RMR
> reserved regions
> 
[...]

> >  void generic_iommu_put_resv_regions(struct device *dev, struct list_head
> *list)
> >  {
> >  	struct iommu_resv_region *entry, *next;
> >
> > -	list_for_each_entry_safe(entry, next, list, list)
> > +	list_for_each_entry_safe(entry, next, list, list) {
> > +		if (entry->resv_region_free_fw_data)
> > +			entry->resv_region_free_fw_data(dev, entry);
> >  		kfree(entry);
> 
> I'd move the kfree to the free callback if present.  This would also
> allow to hide the union from the common code entirely and use a
> container structure like:
> 
> struct iommu_iort_rmr_data {
> 	struct iommu_resv_region rr;
> 
> 	/* Stream IDs associated with IORT RMR entry */
> 	const u32 *sids;
> 	u32 num_sids;
> };

Ok. I will respin soon with the above changes.

Thanks,
Shameer 
