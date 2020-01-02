Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92BA912E80D
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jan 2020 16:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgABP1Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 2 Jan 2020 10:27:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728561AbgABP1Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Jan 2020 10:27:24 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id B45E849FCBA97A570CA8;
        Thu,  2 Jan 2020 15:27:22 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 2 Jan 2020 15:27:22 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Thu, 2 Jan 2020
 15:27:22 +0000
Date:   Thu, 2 Jan 2020 15:27:19 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Brice Goglin <brice.goglin@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        Keith Busch <kbusch@kernel.org>, <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, <linuxarm@huawei.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tao Xu <tao3.xu@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V6 0/7] ACPI: Support Generic Initiator proximity
 domains
Message-ID: <20200102152604.000039f1@Huawei.com>
In-Reply-To: <1867024e-b0c4-c291-7190-262cc4b297a8@gmail.com>
References: <20191216153809.105463-1-Jonathan.Cameron@huawei.com>
 <dc5f5502-09c6-d476-db0e-0af3412bb031@gmail.com>
 <20191218145041.00005a11@Huawei.com>
 <1867024e-b0c4-c291-7190-262cc4b297a8@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 20 Dec 2019 22:40:18 +0100
Brice Goglin <brice.goglin@gmail.com> wrote:

> Le 18/12/2019 à 15:50, Jonathan Cameron a écrit :
> > On Wed, 18 Dec 2019 12:32:06 +0100
> > Brice Goglin <brice.goglin@gmail.com> wrote:
> >  
> >> Le 16/12/2019 à 16:38, Jonathan Cameron a écrit :  
> >>> Introduces a new type of NUMA node for cases where we want to represent
> >>> the access characteristics of a non CPU initiator of memory requests,
> >>> as these differ from all those for existing nodes containing CPUs and/or
> >>> memory.
> >>>
> >>> These Generic Initiators are presented by the node access0 class in
> >>> sysfs in the same way as a CPU.   It seems likely that there will be
> >>> usecases in which the best 'CPU' is desired and Generic Initiators
> >>> should be ignored.  The final few patches in this series introduced
> >>> access1 which is a new performance class in the sysfs node description
> >>> which presents only CPU to memory relationships.  Test cases for this
> >>> are described below.    
> >>
> >> Hello Jonathan
> >>
> >> If I want to test this with a fake GI, what are the minimal set of
> >> changes I should put in my ACPI tables? Can I just specify a dummy GI in
> >> SRAT? What handle should I use there?  
> > Exactly that for a dummy GI.  Also extend HMAT and SLIT for the extra
> > proximity domain / initiator.  
> 
> 
> I couldn't get this to work (your patches on top of 5.5-rc2). I added
> the GI in SRAT, and extended HMAT and SLIT accordingly.
> 
> I don't know if that's expected but I get an additional node in sysfs,
> with 0kB memory.
> 
> However the HMAT table gets ignored because find_mem_target() fails in
> hmat_parse_proximity_domain(). The target should have been allocated in
> alloc_memory_target() which is called in srat_parse_mem_affinity(), but
> it seems to me that this function isn't called for GI nodes. Or should
> SRAT also contain a normal Memory node with same PM as the GI?
> 
Hi Brice,

Yes you should see a node with 0kB memory.  Same as you get for a processor
only node I believe.

srat_parse_mem_affinity shouldn't call alloc_memory_target for the GI nodes
as they don't have any memory.   The hmat table should only refer to
GI domains as initiators.  Just to check, do you have them listed as
a target node?  Or perhaps in some hmat proximity entry as memory_PD?

To answer your question, SRAT should not contain a normal memory node
with the same PXM as that would defeat the whole purpose as we would have
been able to have such a domain without Generic Initiators.

Also, just to check, x86 or arm64?

Thanks for testing this.

Jonathan


> Brice
> 
> 


