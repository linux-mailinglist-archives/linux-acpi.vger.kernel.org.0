Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27FA14B3CF
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 12:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgA1L4d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 06:56:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgA1L4d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 06:56:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A023D2173E;
        Tue, 28 Jan 2020 11:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580212592;
        bh=cbY4qrepDwIPYuuvBAb/JcVe9z3yv1nJQYMwmA5VtU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=viTDkRB3SuwFFXB0GKABOuQzunieTBI6/i9ObGuRtbdMsW2YLYdo10WN1QWug2Ejt
         yCyWEfx56KdFPt/iQ9o2i4YX7AfK0mhJnQbvbvuFN9vD/ZsIPz2VTO9H+vDKMrose5
         OUbGbV9VeIck5belq6/xIRFawGDNRKhGZsAAfFms=
Date:   Tue, 28 Jan 2020 12:56:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Garry <john.garry@huawei.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, jeremy.linton@arm.com,
        arnd@arndb.de, olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, guohanjun@huawei.com
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
Message-ID: <20200128115629.GB2680602@kroah.com>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580210059-199540-3-git-send-email-john.garry@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 28, 2020 at 07:14:19PM +0800, John Garry wrote:
> Add a generic driver for platforms which populate their ACPI PPTT
> processor package ID Type Structure according to suggestion in the ACPI
> spec - see ACPI 6.2, section 5.2.29.3 ID structure Type 2.
> 
> The soc_id is from member LEVEL_2_ID.
> 
> For this, we need to use a whitelist of platforms which are known to
> populate the structure as suggested.
> 
> For now, only the vendor and soc_id fields are exposed.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/soc/Makefile       |   1 +
>  drivers/soc/acpi_generic.c | 102 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>  create mode 100644 drivers/soc/acpi_generic.c
> 
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 8b49d782a1ab..2a59a30a22cd 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for the Linux Kernel SOC specific device drivers.
>  #
>  
> +obj-$(CONFIG_ACPI_PPTT)		+= acpi_generic.o
>  obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
>  obj-$(CONFIG_SOC_ASPEED)	+= aspeed/
>  obj-$(CONFIG_ARCH_AT91)		+= atmel/
> diff --git a/drivers/soc/acpi_generic.c b/drivers/soc/acpi_generic.c
> new file mode 100644
> index 000000000000..34a1f5f8e063
> --- /dev/null
> +++ b/drivers/soc/acpi_generic.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) John Garry, john.garry@huawei.com
> + */
> +
> +#define pr_fmt(fmt) "SOC ACPI GENERIC: " fmt

You have a device, why do you need pr_fmt()?

> +
> +#include <linux/acpi.h>
> +#include <linux/sys_soc.h>
> +
> +/*
> + * Known platforms that fill in PPTT package ID structures according to
> + * ACPI spec examples, that being:
> + * - Custom driver attribute is in ID Type Structure VENDOR_ID member
> + * - SoC id is in ID Type Structure LEVEL_2_ID member
> + *    See ACPI SPEC 6.2 Table 5-154 for PPTT ID Type Structure
> + */
> +static struct acpi_platform_list plat_list[] = {
> +	{"HISI  ", "HIP08   ", 0, ACPI_SIG_PPTT, all_versions},
> +	{ } /* End */
> +};
> +
> +struct acpi_generic_soc_struct {
> +	struct soc_device_attribute dev_attr;
> +	u32 vendor;
> +};
> +
> +static ssize_t vendor_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct acpi_generic_soc_struct *soc = dev_get_drvdata(dev);
> +	u8 vendor_id[5] = {};
> +
> +	*(u32 *)vendor_id = soc->vendor;
> +
> +	return sprintf(buf, "%s\n", vendor_id);
> +}
> +
> +static DEVICE_ATTR_RO(vendor);
> +
> +static __init int soc_acpi_generic_init(void)
> +{
> +	int index;
> +
> +	index = acpi_match_platform_list(plat_list);
> +	if (index < 0)
> +		return -ENOENT;
> +
> +	index = 0;
> +	while (true) {
> +		struct acpi_pptt_package_info info;
> +
> +		if (!acpi_pptt_get_package_info(index, &info)) {
> +			struct soc_device_attribute *soc_dev_attr;
> +			struct acpi_generic_soc_struct *soc;
> +			struct soc_device *soc_dev;
> +			u8 soc_id[9] = {};
> +
> +			*(u64 *)soc_id = info.LEVEL_2_ID;
> +
> +			soc = kzalloc(sizeof(*soc), GFP_KERNEL);
> +			if (!soc)
> +				return -ENOMEM;
> +
> +			soc_dev_attr = &soc->dev_attr;
> +			soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s",
> +							 soc_id);
> +			if (!soc_dev_attr->soc_id) {
> +				kfree(soc);
> +				return -ENOMEM;
> +			}
> +			soc->vendor = info.vendor_id;
> +
> +			soc_dev = soc_device_register(soc_dev_attr);
> +			if (IS_ERR(soc_dev)) {
> +				int ret = PTR_ERR(soc_dev);
> +
> +				pr_info("could not register soc (%d) index=%d\n",
> +					ret, index);

pr_err()?

And shouldn't the core print out the error, not the person who calls it?


> +				kfree(soc_dev_attr->soc_id);
> +				kfree(soc);
> +				return ret;
> +			}
> +			dev_set_drvdata(soc_device_to_device(soc_dev), soc);
> +			device_create_file(soc_device_to_device(soc_dev),
> +					   &dev_attr_vendor);

You just raced with userspace and lost.  Use the built-in api that I
made _just_ because of SOC drivers to do this correctly.

thanks,

greg k-h
