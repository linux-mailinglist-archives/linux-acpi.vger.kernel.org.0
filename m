Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881992C513B
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 10:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbgKZJ2y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Nov 2020 04:28:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:41020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730060AbgKZJ2y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Nov 2020 04:28:54 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E352173E;
        Thu, 26 Nov 2020 09:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606382932;
        bh=RWj4wX5AYIaChRd8iz/VAmF+RKCOhZ3XebOPiy20CRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xGyHf780VVINu9Z8rovYPhKkDhHxt2/ZZAkNAEA2w1e9P/0oWX3estJ9qnGW4O6sQ
         RO7aIg121TVU0aEsYdYCD4L8emQqwZGsU07VaPYXvluFznXuGlB+ONF+SeyzeQxMSx
         n4Atnh+tg15SfEHwjtZHZXL5X5gAiN+CAGtWTl2M=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kiDa6-00DlGl-K4; Thu, 26 Nov 2020 09:28:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Nov 2020 09:28:50 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, lenb@kernel.org,
        rjw@rjwysocki.net, gregkh@linuxfoundation.org, tglx@linutronix.de,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 3/5] driver core: platform: Add platform_put_irq()
In-Reply-To: <1606324841-217570-4-git-send-email-john.garry@huawei.com>
References: <1606324841-217570-1-git-send-email-john.garry@huawei.com>
 <1606324841-217570-4-git-send-email-john.garry@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <f6fb9ff74c8b361a592a6a4ceebd032d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, jejb@linux.ibm.com, martin.petersen@oracle.com, lenb@kernel.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, linux-acpi@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-11-25 17:20, John Garry wrote:
> Add a function to tear down the work which was done in 
> platform_get_irq()
> for when the device driver is done with the irq.
> 
> For ACPI companion devices the irq resource is set as disabled, as this
> resource is configured from platform_get_irq()->acpi_irq_get() and 
> requires
> resetting.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/base/platform.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 88aef93eb4dd..3eeda3746701 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -289,6 +289,20 @@ int platform_irq_count(struct platform_device 
> *dev)
>  }
>  EXPORT_SYMBOL_GPL(platform_irq_count);
> 
> +void platform_put_irq(struct platform_device *dev, unsigned int num)
> +{
> +	unsigned int virq = platform_get_irq(dev, num);

I find it pretty odd to have to recompute the interrupt number,
which in turn results in a domain lookup. It things were refcounted
(they aren't yet), irq_dispose_mapping() would have no effect.

<pedant>
It also goes against the usual construct where if you obtain an object
based on some parameters, the release happens by specifying the object
itself, and not the parameters that lead to the object.
</pedant>

> +
> +	irq_dispose_mapping(virq);
> +	if (has_acpi_companion(&dev->dev)) {
> +		struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ,
> +							   num);
> +
> +		if (r)
> +			acpi_dev_irqresource_disabled(r, 0);

It looks to me that the ACPI thing is what needs to be promoted to a
first class function, releasing all the resources that have used by
a given device.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
