Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F03412F8A4
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jan 2020 14:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgACNIy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 3 Jan 2020 08:08:54 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2227 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727587AbgACNIy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Jan 2020 08:08:54 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 398379D5653B36C4EBDE;
        Fri,  3 Jan 2020 13:08:52 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 3 Jan 2020 13:08:51 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 13:08:51 +0000
Date:   Fri, 3 Jan 2020 13:08:50 +0000
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
Message-ID: <20200103130850.00000ace@Huawei.com>
In-Reply-To: <13b2cc22-df30-ebee-fb94-cd66d8334507@gmail.com>
References: <20191216153809.105463-1-Jonathan.Cameron@huawei.com>
        <dc5f5502-09c6-d476-db0e-0af3412bb031@gmail.com>
        <20191218145041.00005a11@Huawei.com>
        <1867024e-b0c4-c291-7190-262cc4b297a8@gmail.com>
        <20200102152604.000039f1@Huawei.com>
        <b428d231-4879-4462-ac42-900b5d094eee@gmail.com>
        <20200103100920.00006a18@Huawei.com>
        <13b2cc22-df30-ebee-fb94-cd66d8334507@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 3 Jan 2020 13:18:59 +0100
Brice Goglin <brice.goglin@gmail.com> wrote:

> Le 03/01/2020 à 11:09, Jonathan Cameron a écrit :
> >
> > 1) If the memory and processor are in the same domain, that should mean the
> > access characteristics within that domain are the best in the system.
> > It is possible to have a setup with very low latency access
> > from a particular processor but also low bandwidth.  Another domain may have
> > high bandwidth but long latency.   Such systems may occur, but they are probably
> > going to not be for 'normal memory the OS can just use'.
> >
> > 2) If we have a relevant "Memory Proximity Domain Attributes Structure"
> > Note this was renamed in acpi 6.3 from "Address Range Structure" as
> > it no longer has any address ranges.
> > (which are entirely optional btw) that indicates that the memory controller
> > for a given memory lies in the proximity domain of the Initiator specified.
> > If that happens we ignore cases where hmat says somewhere else is nearer
> > via bandwidth and latency.
> >
> > For case 1) I'm not sure we actually enforce it.
> > I think you've hit case 2).  
> >
> > Removing the address range structures should work, or as you say you can
> > move that memory into separate memory nodes.  
> 
> 
> I removed the "processor proximity domain valid" flag from the address
> range structure of node2, and the GI is now its access0 initiator
> instead of node2 itself. Looks like it confirms I was in case 2)
> 
> Thanks
> 
> Brice

Cool. I was wondering if that change would work fine.
It is a somewhat crazy setup so I didn't have an equivalent in my test set.

Sounds like all is working as expected.

Thanks,

Jonathan

