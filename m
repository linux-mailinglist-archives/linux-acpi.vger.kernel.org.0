Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D33F124A31
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2019 15:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLROup convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 18 Dec 2019 09:50:45 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbfLROuo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Dec 2019 09:50:44 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 250F02B0021CA52D4578;
        Wed, 18 Dec 2019 14:50:43 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 18 Dec 2019 14:50:42 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 18 Dec
 2019 14:50:42 +0000
Date:   Wed, 18 Dec 2019 14:50:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Brice Goglin <brice.goglin@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        Keith Busch <keith.busch@intel.com>, <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, <linuxarm@huawei.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tao Xu <tao3.xu@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V6 0/7] ACPI: Support Generic Initiator proximity
 domains
Message-ID: <20191218145041.00005a11@Huawei.com>
In-Reply-To: <dc5f5502-09c6-d476-db0e-0af3412bb031@gmail.com>
References: <20191216153809.105463-1-Jonathan.Cameron@huawei.com>
        <dc5f5502-09c6-d476-db0e-0af3412bb031@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 18 Dec 2019 12:32:06 +0100
Brice Goglin <brice.goglin@gmail.com> wrote:

> Le 16/12/2019 à 16:38, Jonathan Cameron a écrit :
> > Introduces a new type of NUMA node for cases where we want to represent
> > the access characteristics of a non CPU initiator of memory requests,
> > as these differ from all those for existing nodes containing CPUs and/or
> > memory.
> >
> > These Generic Initiators are presented by the node access0 class in
> > sysfs in the same way as a CPU.   It seems likely that there will be
> > usecases in which the best 'CPU' is desired and Generic Initiators
> > should be ignored.  The final few patches in this series introduced
> > access1 which is a new performance class in the sysfs node description
> > which presents only CPU to memory relationships.  Test cases for this
> > are described below.  
> 
> 
> Hello Jonathan
> 
> If I want to test this with a fake GI, what are the minimal set of
> changes I should put in my ACPI tables? Can I just specify a dummy GI in
> SRAT? What handle should I use there?

Exactly that for a dummy GI.  Also extend HMAT and SLIT for the extra
proximity domain / initiator.

For the handle, anything is fine.  This patch set doesn't currently use it.
That handle was a bit controversial when this spec feature was being
discussed because it can 'disagree' with information from _PXM.

The ACPI spec ended up effectively relying on them agreeing.  So any handle
must identify a device that either doesn't have a _PXM entry or that
has one that refers to the same proximity domain.

Also note there is a fiddly corner case which is covered by an _OSC.
If you have a device that you want to use _PXM to put in a GI only
domain then older kernels will not know about the GI domain. Hence
ACPI goes through a dance to ensure that a kernel that hasn't
announced it is GI aware, doesn't get told anything is in a GI only domain.
For testing this series though you can just ignore that.

The logic to actually pass that handle based specification through to the
devices is complex, so this set relies on _PXM in DSDT to actually associate
any device with the Generic Initiator domain.  If doing this for a PCI
device, note that you need the fix mentioned in the cover letter to actually
have _PXM apply to PCI EPs.  Note that the _PXM case needs to work anyway
as you might have a GI node with multiple GIs and there is no obligation
for them all to be specified in SRAT.

Once this initial set is in place we can work out how to use the SRAT
handle to associate it with a device.  To be honest, I haven't really
thought about how we'd do that yet.

Thanks,

Jonathan


> 
> Thanks
> 
> Brice
> 
> 


