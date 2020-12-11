Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008E92D803A
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Dec 2020 21:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393230AbgLKUyM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Dec 2020 15:54:12 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60480 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392551AbgLKUxv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2020 15:53:51 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 852afc7a6c3a62dd; Fri, 11 Dec 2020 21:53:09 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Qian Cai <qcai@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>, kernel-team@android.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: Use fwnode_init() to set up fwnode
Date:   Fri, 11 Dec 2020 21:53:09 +0100
Message-ID: <3491615.yqrABBVLMz@kreacher>
In-Reply-To: <20201211202629.2164655-1-saravanak@google.com>
References: <20201211202629.2164655-1-saravanak@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, December 11, 2020 9:26:29 PM CET Saravana Kannan wrote:
> Commit 01bb86b380a3 ("driver core: Add fwnode_init()") was supposed to
> fix up all instances of fwnode creation to use fwnode_init(). But looks
> like this instance was missed. This causes a NULL pointer dereference
> during device_add() [1]. So, fix it.
> 
> [   60.792324][    T1] Call trace:
> [   60.795495][    T1]  device_add+0xf60/0x16b0
> __fw_devlink_link_to_consumers at drivers/base/core.c:1583
> (inlined by) fw_devlink_link_device at drivers/base/core.c:1726
> (inlined by) device_add at drivers/base/core.c:3088
> [   60.799813][    T1]  platform_device_add+0x274/0x628
> [   60.804833][    T1]  acpi_iort_init+0x9d8/0xc50
> [   60.809415][    T1]  acpi_init+0x45c/0x4e8
> [   60.813556][    T1]  do_one_initcall+0x170/0xb70
> [   60.818224][    T1]  kernel_init_freeable+0x6a8/0x734
> [   60.823332][    T1]  kernel_init+0x18/0x12c
> [   60.827566][    T1]  ret_from_fork+0x10/0x1c
> [   60.838756][    T1] ---[ end trace fa5c8ce17a226d83 ]---
> 
> [1] - https://lore.kernel.org/linux-arm-kernel/02e7047071f0b54b046ac472adeeb3fafabc643c.camel@redhat.com/
> Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
> Reported-by: Qian Cai <qcai@redhat.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Tested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Greg,
> 
> Can you please pull this into driver-core-next since the commit that
> causes this is only present in driver-core-next?
> 
> -Saravana
> 
>  include/linux/acpi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 39263c6b52e1..2630c2e953f7 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -55,7 +55,7 @@ static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
>  	if (!fwnode)
>  		return NULL;
>  
> -	fwnode->ops = &acpi_static_fwnode_ops;
> +	fwnode_init(fwnode, &acpi_static_fwnode_ops);
>  
>  	return fwnode;
>  }
> 




