Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9863F96A0
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2019 18:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfKLRHw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Nov 2019 12:07:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726896AbfKLRHw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Nov 2019 12:07:52 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5A1FB471603A22B30AD3;
        Wed, 13 Nov 2019 01:07:50 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 01:07:43 +0800
Date:   Tue, 12 Nov 2019 17:07:34 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        Keith Busch <keith.busch@intel.com>, <jglisse@redhat.com>,
        <linuxarm@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Dan Williams" <dan.j.williams@intel.com>, <will@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH V5 1/4] ACPI: Support Generic Initiator only domains
Message-ID: <20191112170734.0000621a@huawei.com>
In-Reply-To: <1768519.laKBN70clK@kreacher>
References: <20191004114330.104746-1-Jonathan.Cameron@huawei.com>
        <1895971.7mY3IlW731@kreacher>
        <20191018134656.00000f70@huawei.com>
        <1768519.laKBN70clK@kreacher>
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

On Thu, 7 Nov 2019 15:54:28 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Friday, October 18, 2019 2:46:56 PM CET Jonathan Cameron wrote:
> > On Fri, 18 Oct 2019 12:18:33 +0200
> > "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> >   
> > > On Friday, October 4, 2019 1:43:27 PM CEST Jonathan Cameron wrote:  
> > > > Generic Initiators are a new ACPI concept that allows for the
> > > > description of proximity domains that contain a device which
> > > > performs memory access (such as a network card) but neither
> > > > host CPU nor Memory.
> > > > 
> > > > This patch has the parsing code and provides the infrastructure
> > > > for an architecture to associate these new domains with their
> > > > nearest memory processing node.
> > > > 
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>    
> > > 
> > > This depends on the series from Dan at:
> > > 
> > > https://lore.kernel.org/linux-acpi/CAPcyv4gBSX58CWH4HZ28w0_cZRzJrhgdEFHa2g8KDqyv8aFqZQ@mail.gmail.com/T/#m1acce3ae8f29f680c0d95fd1e840e703949fbc48
> > >   
> > Hi Rafael,
> > 
> > Yes. Cover letter mentions it was rebased on v4 of that series.
> >   
> > > AFAICS, so please respin when that one hits the Linus' tree.  
> > 
> > Sure, though that pushes it out another cycle and it's beginning to
> > get a bit silly (just rebases since April).
> > 
> > I guess it can't be helped given the series hits several trees.  
> 
> I've just applied the Dan's series and I can take patch [1/4] from this one,
> but for the [2-3/4] I'd like to get some ACKs from the arm64 and x86 people
> respectively.

Thanks Rafael!

Absolutely understood on the need for Acks.

For ARM let us try a few more CCs

+CC Will, Lorenzo, Hanjun.

Also Ingo on basis of showing a passing interest in the x86 patch
previously.  Otherwise I think we have the x86 people most like to
comment already cc'd.

https://patchwork.kernel.org/cover/11174247/ has the full series.

I'd appreciate anyone who has time taking a look at these.  The
actual actions in the architectures are very simple, but I may well
be missing some subtlety.

> 
> Thanks!
> 
Thanks,

Jonathan


