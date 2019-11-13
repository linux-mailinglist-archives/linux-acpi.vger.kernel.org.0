Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A32BFAD91
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2019 10:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfKMJsA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Nov 2019 04:48:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43040 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727674AbfKMJsA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Nov 2019 04:48:00 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6CD6BC08E7C566C8E8DB;
        Wed, 13 Nov 2019 17:47:57 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 17:47:49 +0800
Date:   Wed, 13 Nov 2019 09:47:42 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, "Keith Busch" <keith.busch@intel.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linuxarm <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH V5 1/4] ACPI: Support Generic Initiator only domains
Message-ID: <20191113094742.00000dc4@huawei.com>
In-Reply-To: <CAPcyv4jZG-5s6NsS-_-oNG45y0Qb1mVD_s8cCGqLYtzvHqEo+Q@mail.gmail.com>
References: <20191004114330.104746-1-Jonathan.Cameron@huawei.com>
        <20191004114330.104746-2-Jonathan.Cameron@huawei.com>
        <CAPcyv4jZG-5s6NsS-_-oNG45y0Qb1mVD_s8cCGqLYtzvHqEo+Q@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 12 Nov 2019 09:55:17 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> [ add Tao Xu ]
> 
> On Fri, Oct 4, 2019 at 4:45 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > Generic Initiators are a new ACPI concept that allows for the
> > description of proximity domains that contain a device which
> > performs memory access (such as a network card) but neither
> > host CPU nor Memory.
> >
> > This patch has the parsing code and provides the infrastructure
> > for an architecture to associate these new domains with their
> > nearest memory processing node.  
> 
> Thanks for this Jonathan. May I ask how this was tested? Tao has been
> working on qemu support for HMAT [1]. I have not checked if it already
> supports generic initiator entries, but it would be helpful to include
> an example of how the kernel sees these configurations in practice.
> 
> [1]: http://patchwork.ozlabs.org/cover/1096737/

Tested against qemu with SRAT and SLIT table overrides from an
initrd to actually create the node and give it distances
(those all turn up correctly in the normal places).  DSDT override
used to move an emulated network card into the GI numa node.  That
currently requires the PCI patch referred to in the cover letter.
On arm64 tested both on qemu and real hardware (overrides on tables
even for real hardware as I can't persuade our BIOS team to implement
Generic Initiators until an OS is actually using them.)

Main real requirement is memory allocations then occur from one of
the nodes at the minimal distance when you are do a devm_ allocation
from a device assigned. Also need to be able to query the distances
to allow load balancing etc.  All that works as expected.

It only has a fairly tangential connection to HMAT in that HMAT
can provide information on GI nodes.  Given HMAT code is quite happy
with memoryless nodes anyway it should work.  QEMU doesn't currently
have support to create GI SRAT entries let alone HMAT using them.

Whilst I could look at adding such support to QEMU, it's not
exactly high priority to emulate something we can test easily
by overriding the tables before the kernel reads them.

I'll look at how hard it is to build an HMAT tables for my test
configs based on the ones I used to test your HMAT patches a while
back.  Should be easy if tedious.

Jonathan


 

