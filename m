Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A82E2D8643
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Dec 2020 12:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438414AbgLLLlu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Dec 2020 06:41:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438416AbgLLLlX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 12 Dec 2020 06:41:23 -0500
Date:   Sat, 12 Dec 2020 12:41:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607773236;
        bh=jqjRDO6it4PIfRZs/qkqjcU0uJ3CmwvFfKshqnxbEDU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ruMxCQ1kiuFBWVpjRNsxHUsJiHQFxppEuykEu2jJG1JMO9u+CUu9k8+095VnIGgm7
         V4AkxF0t33HSAtHsO7AhaiLlNyRwzVMk5OiIJHEpHz+j8Etd4Jgw95ABY5DJkE0PBI
         LlKzBjJzjCeHrsK6ZJMbP0xc+Fuy8cOpiefMBX8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Qian Cai <qcai@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>, kernel-team@android.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: Use fwnode_init() to set up fwnode
Message-ID: <X9SsegnBlMN+RTb6@kroah.com>
References: <20201211202629.2164655-1-saravanak@google.com>
 <3491615.yqrABBVLMz@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3491615.yqrABBVLMz@kreacher>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 11, 2020 at 09:53:09PM +0100, Rafael J. Wysocki wrote:
> On Friday, December 11, 2020 9:26:29 PM CET Saravana Kannan wrote:
> > Commit 01bb86b380a3 ("driver core: Add fwnode_init()") was supposed to
> > fix up all instances of fwnode creation to use fwnode_init(). But looks
> > like this instance was missed. This causes a NULL pointer dereference
> > during device_add() [1]. So, fix it.
> > 
> > [   60.792324][    T1] Call trace:
> > [   60.795495][    T1]  device_add+0xf60/0x16b0
> > __fw_devlink_link_to_consumers at drivers/base/core.c:1583
> > (inlined by) fw_devlink_link_device at drivers/base/core.c:1726
> > (inlined by) device_add at drivers/base/core.c:3088
> > [   60.799813][    T1]  platform_device_add+0x274/0x628
> > [   60.804833][    T1]  acpi_iort_init+0x9d8/0xc50
> > [   60.809415][    T1]  acpi_init+0x45c/0x4e8
> > [   60.813556][    T1]  do_one_initcall+0x170/0xb70
> > [   60.818224][    T1]  kernel_init_freeable+0x6a8/0x734
> > [   60.823332][    T1]  kernel_init+0x18/0x12c
> > [   60.827566][    T1]  ret_from_fork+0x10/0x1c
> > [   60.838756][    T1] ---[ end trace fa5c8ce17a226d83 ]---
> > 
> > [1] - https://lore.kernel.org/linux-arm-kernel/02e7047071f0b54b046ac472adeeb3fafabc643c.camel@redhat.com/
> > Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
> > Reported-by: Qian Cai <qcai@redhat.com>
> > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > Tested-by: Marc Zyngier <maz@kernel.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Now queued up, thanks.

greg k-h
