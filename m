Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BE0F31D3
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2019 15:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbfKGOyb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 09:54:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63452 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387870AbfKGOya (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 09:54:30 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 2b552d6f1ba461aa; Thu, 7 Nov 2019 15:54:28 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Keith Busch <keith.busch@intel.com>,
        jglisse@redhat.com, linuxarm@huawei.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH V5 1/4] ACPI: Support Generic Initiator only domains
Date:   Thu, 07 Nov 2019 15:54:28 +0100
Message-ID: <1768519.laKBN70clK@kreacher>
In-Reply-To: <20191018134656.00000f70@huawei.com>
References: <20191004114330.104746-1-Jonathan.Cameron@huawei.com> <1895971.7mY3IlW731@kreacher> <20191018134656.00000f70@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, October 18, 2019 2:46:56 PM CET Jonathan Cameron wrote:
> On Fri, 18 Oct 2019 12:18:33 +0200
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > On Friday, October 4, 2019 1:43:27 PM CEST Jonathan Cameron wrote:
> > > Generic Initiators are a new ACPI concept that allows for the
> > > description of proximity domains that contain a device which
> > > performs memory access (such as a network card) but neither
> > > host CPU nor Memory.
> > > 
> > > This patch has the parsing code and provides the infrastructure
> > > for an architecture to associate these new domains with their
> > > nearest memory processing node.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > 
> > This depends on the series from Dan at:
> > 
> > https://lore.kernel.org/linux-acpi/CAPcyv4gBSX58CWH4HZ28w0_cZRzJrhgdEFHa2g8KDqyv8aFqZQ@mail.gmail.com/T/#m1acce3ae8f29f680c0d95fd1e840e703949fbc48
> > 
> Hi Rafael,
> 
> Yes. Cover letter mentions it was rebased on v4 of that series.
> 
> > AFAICS, so please respin when that one hits the Linus' tree.
> 
> Sure, though that pushes it out another cycle and it's beginning to
> get a bit silly (just rebases since April).
> 
> I guess it can't be helped given the series hits several trees.

I've just applied the Dan's series and I can take patch [1/4] from this one,
but for the [2-3/4] I'd like to get some ACKs from the arm64 and x86 people
respectively.

Thanks!



