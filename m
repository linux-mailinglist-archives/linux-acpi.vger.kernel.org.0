Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5322D4A99
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Dec 2020 20:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbgLITjr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Dec 2020 14:39:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730981AbgLITjq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Dec 2020 14:39:46 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21BDB23BC6;
        Wed,  9 Dec 2020 19:39:06 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kn5Il-00HSt3-S7; Wed, 09 Dec 2020 19:39:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Dec 2020 19:39:03 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, lenb@kernel.org, rjw@rjwysocki.net,
        tglx@linutronix.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-acpi@vger.kernel.org, dwagner@suse.de
Subject: Re: [PATCH v5 4/5] Driver core: platform: Add
 devm_platform_get_irqs_affinity()
In-Reply-To: <X9Ehy28876ezAOLH@kroah.com>
References: <1606905417-183214-1-git-send-email-john.garry@huawei.com>
 <1606905417-183214-5-git-send-email-john.garry@huawei.com>
 <X9EYRNDXS1Xcy4iU@kroah.com>
 <36730230-9fd7-8c6c-b997-328beea2fc31@huawei.com>
 <X9Ehy28876ezAOLH@kroah.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <ed238cc6e4a6b865b2dc965f52fe0550@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, john.garry@huawei.com, jejb@linux.ibm.com, martin.petersen@oracle.com, lenb@kernel.org, rjw@rjwysocki.net, tglx@linutronix.de, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, linux-acpi@vger.kernel.org, dwagner@suse.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-12-09 19:13, Greg KH wrote:
> On Wed, Dec 09, 2020 at 07:04:02PM +0000, John Garry wrote:
>> On 09/12/2020 18:32, Greg KH wrote:
>> > On Wed, Dec 02, 2020 at 06:36:56PM +0800, John Garry wrote:
>> > > Drivers for multi-queue platform devices may also want managed interrupts
>> > > for handling HW queue completion interrupts, so add support.
>> >
>> 
>> Hi Greg,
>> 
>> > Why would a platform device want all of this?  Shouldn't such a device
>> > be on a "real" bus instead?
>> 
>> For this HW version, the device is on the system bus, directly 
>> addressable
>> by the CPU.
> 
> What do you mean by "system bus"?
> 
>> Motivation is that I wanted to switch the HW completion queues to use
>> managed interrupts.
> 
> Fair enough, seems like overkill for a "platform" bus though :)

You should see the box, really... ;-)

> 
>> > What in-kernel driver needs this complexity?  I can't take new apis
>> > without a real user in the tree, sorry.
>> 
>> It's in the final patch in the series 
>> https://lore.kernel.org/linux-scsi/1606905417-183214-1-git-send-email-john.garry@huawei.com/T/#m0df7e7cd6f0819b99aaeb6b7f8939ef1e17b8a83.
> 
> Ah, I missed that, I thought that was some high-speed scsi thing, not a
> tiny platform driver...
> 
>> I don't anticipate a huge number of users of this API in future, as 
>> most
>> multi-queue devices are PCI devices; so we could do the work of this 
>> API in
>> the driver itself, but the preference was not to export genirq 
>> functions
>> like irq_update_affinity_desc() or irq_create_affinity_masks(), and 
>> rather
>> have a common helper in the core platform code.
> 
> Ok, I'd like to have the irq maintainers/developers ack this before
> taking it in the driver core, as someone is going to have to maintain
> this crazy thing for forever if it gets merged.

I'm actually quite happy with this, and as it turns out, the crazy
system that has this SAS thing keeps my backside warm all year long.
As long as this machine keeps ticking, I'm happy to help with this.

So if that helps:

Acked-by: Marc Zyngier <maz@kernel.org>

We need to work out the merge strategy for the whole lot though, given
that it crosses 3 subsystems over two series...

         M.
-- 
Jazz is not dead. It just smells funny...
