Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B2F2D5FB6
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 16:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391756AbgLJP3F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 10:29:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391693AbgLJP25 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Dec 2020 10:28:57 -0500
Date:   Thu, 10 Dec 2020 16:29:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607614097;
        bh=u7q3rTPGTQ4dUgwP4cEe+JBQSe73GUlEF/YbcVC3h3c=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yz6kmUWz/BnO7gm3cVIocivjv5KDnSrNDdI8IldyDT2ta4Jm2gCZLwwAxVcneHpT/
         BDtcTQrp4NGLiyqxGmihdKJrSZGKt3YKwZXOmxDE2r/z4bah+eXq+y0ARierYHBubD
         UhCCnm13kW4jGKfaobg+dTz9cmcTAXd89uarDCpk=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, lenb@kernel.org, rjw@rjwysocki.net,
        tglx@linutronix.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-acpi@vger.kernel.org, dwagner@suse.de
Subject: Re: [PATCH v5 4/5] Driver core: platform: Add
 devm_platform_get_irqs_affinity()
Message-ID: <X9I+2ydy8VDOaiec@kroah.com>
References: <1606905417-183214-1-git-send-email-john.garry@huawei.com>
 <1606905417-183214-5-git-send-email-john.garry@huawei.com>
 <X9EYRNDXS1Xcy4iU@kroah.com>
 <36730230-9fd7-8c6c-b997-328beea2fc31@huawei.com>
 <X9Ehy28876ezAOLH@kroah.com>
 <ed238cc6e4a6b865b2dc965f52fe0550@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed238cc6e4a6b865b2dc965f52fe0550@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 09, 2020 at 07:39:03PM +0000, Marc Zyngier wrote:
> On 2020-12-09 19:13, Greg KH wrote:
> > On Wed, Dec 09, 2020 at 07:04:02PM +0000, John Garry wrote:
> > > On 09/12/2020 18:32, Greg KH wrote:
> > > > On Wed, Dec 02, 2020 at 06:36:56PM +0800, John Garry wrote:
> > > > > Drivers for multi-queue platform devices may also want managed interrupts
> > > > > for handling HW queue completion interrupts, so add support.
> > > >
> > > 
> > > Hi Greg,
> > > 
> > > > Why would a platform device want all of this?  Shouldn't such a device
> > > > be on a "real" bus instead?
> > > 
> > > For this HW version, the device is on the system bus, directly
> > > addressable
> > > by the CPU.
> > 
> > What do you mean by "system bus"?
> > 
> > > Motivation is that I wanted to switch the HW completion queues to use
> > > managed interrupts.
> > 
> > Fair enough, seems like overkill for a "platform" bus though :)
> 
> You should see the box, really... ;-)

{sigh} why do hardware engineers ignore sane busses...

Anyway, if you all are going to maintain this, no objection from me, it
should go through the irq tree.

thanks,

greg k-h
