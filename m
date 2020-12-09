Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC42D49DB
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Dec 2020 20:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbgLITMv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Dec 2020 14:12:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733106AbgLITMl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Dec 2020 14:12:41 -0500
Date:   Wed, 9 Dec 2020 20:13:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607541120;
        bh=/mn3c6w2OPat8G5RrVOMs8d5tNT7UBX9UCtL1Xa3wVM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=xXVbbdebrU4oDwvk6TgHPsMVqPYEX4Ads4xOd07yxERxy+sHqh8vZScvYuAIfb8Fv
         dW22xclN90RfewBFKTiT6ABXB7378+Rk6QTFSdf8YwOnocDXg2xxN/g3OnXV0JDCFm
         EkjGcRIRXchuRsCVmuFtChHaSQOpQmLEXZI2uX1Y=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, lenb@kernel.org,
        rjw@rjwysocki.net, tglx@linutronix.de, maz@kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-acpi@vger.kernel.org, dwagner@suse.de
Subject: Re: [PATCH v5 4/5] Driver core: platform: Add
 devm_platform_get_irqs_affinity()
Message-ID: <X9Ehy28876ezAOLH@kroah.com>
References: <1606905417-183214-1-git-send-email-john.garry@huawei.com>
 <1606905417-183214-5-git-send-email-john.garry@huawei.com>
 <X9EYRNDXS1Xcy4iU@kroah.com>
 <36730230-9fd7-8c6c-b997-328beea2fc31@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36730230-9fd7-8c6c-b997-328beea2fc31@huawei.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 09, 2020 at 07:04:02PM +0000, John Garry wrote:
> On 09/12/2020 18:32, Greg KH wrote:
> > On Wed, Dec 02, 2020 at 06:36:56PM +0800, John Garry wrote:
> > > Drivers for multi-queue platform devices may also want managed interrupts
> > > for handling HW queue completion interrupts, so add support.
> > 
> 
> Hi Greg,
> 
> > Why would a platform device want all of this?  Shouldn't such a device
> > be on a "real" bus instead?
> 
> For this HW version, the device is on the system bus, directly addressable
> by the CPU.

What do you mean by "system bus"?

> Motivation is that I wanted to switch the HW completion queues to use
> managed interrupts.

Fair enough, seems like overkill for a "platform" bus though :)

> > What in-kernel driver needs this complexity?  I can't take new apis
> > without a real user in the tree, sorry.
> 
> It's in the final patch in the series https://lore.kernel.org/linux-scsi/1606905417-183214-1-git-send-email-john.garry@huawei.com/T/#m0df7e7cd6f0819b99aaeb6b7f8939ef1e17b8a83.

Ah, I missed that, I thought that was some high-speed scsi thing, not a
tiny platform driver...

> I don't anticipate a huge number of users of this API in future, as most
> multi-queue devices are PCI devices; so we could do the work of this API in
> the driver itself, but the preference was not to export genirq functions
> like irq_update_affinity_desc() or irq_create_affinity_masks(), and rather
> have a common helper in the core platform code.

Ok, I'd like to have the irq maintainers/developers ack this before
taking it in the driver core, as someone is going to have to maintain
this crazy thing for forever if it gets merged.

thanks,

greg k-h
