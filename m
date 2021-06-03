Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D78B39A014
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 13:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFCLuM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 3 Jun 2021 07:50:12 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2976 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhFCLuM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jun 2021 07:50:12 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fwkbq0Db8z6tvB;
        Thu,  3 Jun 2021 19:45:27 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (7.185.36.136) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 19:48:25 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500008.china.huawei.com (7.185.36.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 19:48:24 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Thu, 3 Jun 2021 12:48:22 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH v4 1/8] ACPI/IORT: Add support for RMR node parsing
Thread-Topic: [PATCH v4 1/8] ACPI/IORT: Add support for RMR node parsing
Thread-Index: AQHXR/5gVRfrEUOB7keoz3dd2/t1d6sCOK0AgAASeFA=
Date:   Thu, 3 Jun 2021 11:48:22 +0000
Message-ID: <5a73b368134e4f37bdac61756a63449e@huawei.com>
References: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
 <20210513134550.2117-2-shameerali.kolothum.thodi@huawei.com>
 <20210603113638.GB14606@lpieralisi>
In-Reply-To: <20210603113638.GB14606@lpieralisi>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.92.121]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Lorenzo,

> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: 03 June 2021 12:37
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>;
> joro@8bytes.org; robin.murphy@arm.com; wanghuiqiang
> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; steven.price@arm.com; Sami.Mujawar@arm.com;
> jon@solid-run.com; eric.auger@redhat.com; yangyicong
> <yangyicong@huawei.com>
> Subject: Re: [PATCH v4 1/8] ACPI/IORT: Add support for RMR node parsing
> 
> On Thu, May 13, 2021 at 02:45:43PM +0100, Shameer Kolothum wrote:
> > Add support for parsing RMR node information from ACPI.
> > Find associated stream id and smmu node info from the
> > RMR node and populate a linked list with RMR memory
> > descriptors.
> 
> "Add support for parsing RMR node information from ACPI.
> 
> Find the associated streamid and SMMU node info from the
> RMR node and populate a linked list with RMR memory
> descriptors."

Ok.

Thanks for taking a look. Just a quick update, there is a v5[1] of this
series and better to take a look at that before you read further. 
(Anyways, the comments so far are still valid for v5 as well I think).

Thanks,
Shameer

[1]. https://lore.kernel.org/linux-acpi/20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com/


> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/acpi/arm64/iort.c | 104
> +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 103 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 3912a1f6058e..fea1ffaedf3b 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -40,6 +40,19 @@ struct iort_fwnode {
> >  static LIST_HEAD(iort_fwnode_list);
> >  static DEFINE_SPINLOCK(iort_fwnode_lock);
> >
> > +/*
> > + * One entry for IORT RMR.
> > + */
> > +struct iort_rmr_entry {
> > +	struct list_head list;
> > +	u32 sid;
> > +	struct acpi_iort_node *smmu;
> > +	struct acpi_iort_rmr_desc *rmr_desc;
> > +	u32 flags;
> > +};
> > +
> > +static LIST_HEAD(iort_rmr_list);         /* list of RMR regions from ACPI
> */
> > +
> >  /**
> >   * iort_set_fwnode() - Create iort_fwnode and use it to register
> >   *		       iommu data in the iort_fwnode_list
> > @@ -393,7 +406,8 @@ static struct acpi_iort_node
> *iort_node_get_id(struct acpi_iort_node *node,
> >  		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> >  		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> >  		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
> > -		    node->type == ACPI_IORT_NODE_PMCG) {
> > +		    node->type == ACPI_IORT_NODE_PMCG ||
> > +		    node->type == ACPI_IORT_NODE_RMR) {
> >  			*id_out = map->output_base;
> >  			return parent;
> >  		}
> > @@ -1660,6 +1674,91 @@ static void __init iort_enable_acs(struct
> acpi_iort_node *iort_node)
> >  #else
> >  static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
> >  #endif
> > +static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc, u32 count)
> > +{
> > +	int i, j;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		u64 end, start = desc[i].base_address, length = desc[i].length;
> > +
> > +		if (!IS_ALIGNED(start, SZ_64K) || !IS_ALIGNED(length, SZ_64K))
> > +			return -EINVAL;
> > +
> > +		end = start + length - 1;
> > +
> > +		/* Check for address overlap */
> > +		for (j = i + 1; j < count; j++) {
> > +			u64 e_start = desc[j].base_address;
> > +			u64 e_end = e_start + desc[j].length - 1;
> > +
> > +			if (start <= e_end && end >= e_start)
> > +				return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init iort_parse_rmr(struct acpi_iort_node *iort_node)
> > +{
> > +	struct acpi_iort_node *smmu;
> > +	struct iort_rmr_entry *e;
> > +	struct acpi_iort_rmr *rmr;
> > +	struct acpi_iort_rmr_desc *rmr_desc;
> > +	u32 map_count = iort_node->mapping_count;
> > +	u32  sid;
>            ^
> Remove one space.
> 
> > +	int i, ret = 0;
> > +
> > +	if (iort_node->type != ACPI_IORT_NODE_RMR)
> > +		return 0;
> > +
> > +	if (!iort_node->mapping_offset || map_count != 1) {
> > +		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> > +		       iort_node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Retrieve associated smmu and stream id */
> > +	smmu = iort_node_get_id(iort_node, &sid, 0);
> > +	if (!smmu) {
> > +		pr_err(FW_BUG "Invalid SMMU reference, skipping RMR
> node %p\n",
> > +		       iort_node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Retrieve RMR data */
> > +	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
> > +	if (!rmr->rmr_offset || !rmr->rmr_count) {
> > +		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR
> node %p\n",
> > +		       iort_node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
> > +				rmr->rmr_offset);
> > +
> > +	ret = iort_rmr_desc_valid(rmr_desc, rmr->rmr_count);
> > +	if (ret) {
> > +		pr_err(FW_BUG "Invalid RMR descriptor[%d] for node %p,
> skipping...\n",
> > +		       i, iort_node);
> > +		return ret;
> > +	}
> > +
> > +	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
> > +		e = kmalloc(sizeof(*e), GFP_KERNEL);
> > +		if (!e)
> > +			return -ENOMEM;
> > +
> > +		e->sid = sid;
> > +		e->smmu = smmu;
> > +		e->rmr_desc = rmr_desc;
> > +		e->flags = rmr->flags;
> > +
> > +		list_add_tail(&e->list, &iort_rmr_list);
> > +	}
> > +
> > +	return 0;
> > +}
> >
> >  static void __init iort_init_platform_devices(void)
> >  {
> > @@ -1689,6 +1788,9 @@ static void __init iort_init_platform_devices(void)
> >
> >  		iort_enable_acs(iort_node);
> >
> > +		if (iort_table->revision == 3)
> > +			iort_parse_rmr(iort_node);
> > +
> 
> I prefer creating a iort_parse_rmr(void) function (looping through the
> nodes and only parsing the relevant ones) rather that doing this in:
> 
> iort_init_platform_devices()
> 
> it is better IMO.
> 
> Thanks,
> Lorenzo
> 
> >  		ops = iort_get_dev_cfg(iort_node);
> >  		if (ops) {
> >  			fwnode = acpi_alloc_fwnode_static();
> > --
> > 2.17.1
> >
