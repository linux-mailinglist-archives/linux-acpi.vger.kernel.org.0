Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12022B921B
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 13:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgKSMHK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 19 Nov 2020 07:07:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2131 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgKSMHK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2020 07:07:10 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CcJJf3lMNz67F2M;
        Thu, 19 Nov 2020 20:04:50 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 19 Nov 2020 13:07:08 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 19 Nov 2020 12:07:07 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Thu, 19 Nov 2020 12:07:07 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Sami Mujawar <Sami.Mujawar@arm.com>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Robin Murphy" <Robin.Murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>, nd <nd@arm.com>
Subject: RE: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
 parsing
Thread-Topic: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
 parsing
Thread-Index: AQHWtpQY66bs/ZNapk2zvFyjgM+sLanPaxLw
Date:   Thu, 19 Nov 2020 12:07:07 +0000
Message-ID: <735edb5c4da842609c1d2a0eed73b06c@huawei.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
         <20201027112646.44680-3-shameerali.kolothum.thodi@huawei.com>
 <d414a22fbae9575e6c04f4a557ae49a2cd8eac57.camel@linux.intel.com>
 <DB7PR08MB3097062CEEDB4635BF3F694784EA0@DB7PR08MB3097.eurprd08.prod.outlook.com>
In-Reply-To: <DB7PR08MB3097062CEEDB4635BF3F694784EA0@DB7PR08MB3097.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.210.168.73]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Sami Mujawar [mailto:Sami.Mujawar@arm.com]
> Sent: 09 November 2020 12:30
> To: david.e.box@linux.intel.com; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org; devel@acpica.org
> Cc: Linuxarm <linuxarm@huawei.com>; Lorenzo Pieralisi
> <Lorenzo.Pieralisi@arm.com>; joro@8bytes.org; Robin Murphy
> <Robin.Murphy@arm.com>; wanghuiqiang <wanghuiqiang@huawei.com>;
> Jonathan Cameron <jonathan.cameron@huawei.com>; nd <nd@arm.com>
> Subject: RE: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
> parsing
> 
> Hi,
> 
> -----Original Message-----
> From: David E. Box <david.e.box@linux.intel.com>
> Sent: 28 October 2020 06:44 PM
> To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org; devel@acpica.org
> Cc: linuxarm@huawei.com; Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>;
> joro@8bytes.org; Robin Murphy <Robin.Murphy@arm.com>;
> wanghuiqiang@huawei.com; jonathan.cameron@huawei.com
> Subject: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
> parsing
> 
> Hi,
> 
> On Tue, 2020-10-27 at 11:26 +0000, Shameer Kolothum wrote:
> 
> ...
> 
> > @@ -1647,6 +1667,100 @@ static void __init iort_enable_acs(struct
> > acpi_iort_node *iort_node)
> >  #else
> >  static inline void iort_enable_acs(struct acpi_iort_node *iort_node)
> > { }
> >  #endif
> > +static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc)
> > +{
> > +	struct iort_rmr_entry *e;
> > +	u64 end, start = desc->base_address, length = desc->length;
> > +
> > +	if ((!IS_ALIGNED(start, SZ_64K)) || (length % SZ_64K != 0))
> 
> You could just do:
> 
> if ((!IS_ALIGNED(start, SZ_64K)) || (length % SZ_64K))
> 
> [SAMI] In my opinion, the following may be better:
> 	if (!IS_ALIGNED(start, SZ_64K) || !IS_ALIGNED(length, SZ_64K))
> [/SAMI]

Thanks for your suggestions. I don't have a strong opinion on either
of those, but will change it with the latter one for now.

Thanks,
Shameer

> Regards,
> 
> Sami Mujawar
> 
> David
> _______________________________________________
> Devel mailing list -- devel@acpica.org
> To unsubscribe send an email to devel-leave@acpica.org
> %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
