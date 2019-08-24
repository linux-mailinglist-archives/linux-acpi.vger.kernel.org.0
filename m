Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F109BAEE
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Aug 2019 04:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfHXClR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Aug 2019 22:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfHXClR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Aug 2019 22:41:17 -0400
Received: from localhost (65-114-90-19.dia.static.qwest.net [65.114.90.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CCC2173B;
        Sat, 24 Aug 2019 02:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566614476;
        bh=ltzB4QfE/niiworqpZoNfCtGUH51uNpOoALudu0WIHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTBLcVVI3jEgbiAA82t/jfPhUoT+d8M6/F5YLKTvniCQhmGiteybGq5iFIwVqWCTm
         jyIENMLSXtBfq/W0OHEoplf47xlUUKCfXXwFj3TrF+q0UCxsSnGPC/c2aDXeF6cBwa
         DFG5rtbpbcqm42kpMFgG8g8bDHvNm+atwiGGi7Ag=
Date:   Fri, 23 Aug 2019 19:41:15 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Charles.Hyde@dellteam.com
Cc:     linux-acpi@vger.kernel.org, Mario.Limonciello@dell.com,
        oliver@neukum.org, nic_swsd@realtek.com, linux-usb@vger.kernel.org
Subject: Re: [RFC 2/3] ACPI: move ACPI functionality out of r8152 driver
Message-ID: <20190824024115.GA11208@kroah.com>
References: <b84b32cb144f4ba8918ee2406e69275a@AUSX13MPS303.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b84b32cb144f4ba8918ee2406e69275a@AUSX13MPS303.AMER.DELL.COM>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 23, 2019 at 10:28:24PM +0000, Charles.Hyde@dellteam.com wrote:
> --- /dev/null
> +++ b/lib/acpi_mac_passthru.c
> @@ -0,0 +1,61 @@
> +/*
> + *  Copyright (c) 2019 Dell Technology. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + */

You didn't run your patch through checkpatch.pl :(

Anyway, drop the license boilerplate please and use a SPDX line, like
checkpatch asks you to.

> +
> +#include <acpi/acpi_mac_passthru.h>
> +#include <linux/etherdevice.h>
> +
> +int get_acpi_mac_passthru(struct device *dev, struct sockaddr *sa)
> +{
> +#ifdef CONFIG_ACPI
> +	acpi_status status;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj;
> +	int ret = -EINVAL;
> +	unsigned char buf[6];
> +
> +	/* returns _AUXMAC_#AABBCCDDEEFF# */
> +	status = acpi_evaluate_object(NULL, "\\_SB.AMAC", NULL, &buffer);
> +	obj = (union acpi_object *)buffer.pointer;
> +	if (!ACPI_SUCCESS(status))
> +		return -ENODEV;
> +	if (obj->type != ACPI_TYPE_BUFFER || obj->string.length != 0x17) {
> +		dev_warn(dev,
> +			 "Invalid buffer for pass-thru MAC addr: (%d, %d)\n",
> +			 obj->type, obj->string.length);
> +		goto amacout;
> +	}
> +	if (strncmp(obj->string.pointer, "_AUXMAC_#", 9) != 0 ||
> +	    strncmp(obj->string.pointer + 0x15, "#", 1) != 0) {
> +		dev_warn(dev,
> +			 "Invalid header when reading pass-thru MAC addr\n");
> +		goto amacout;
> +	}
> +	ret = hex2bin(buf, obj->string.pointer + 9, 6);
> +	if (!(ret == 0 && is_valid_ether_addr(buf))) {
> +		dev_warn(dev,
> +			 "Invalid MAC for pass-thru MAC addr: %d, %pM\n",
> +			 ret, buf);
> +		ret = -EINVAL;
> +		goto amacout;
> +	}
> +	memcpy(sa->sa_data, buf, 6);
> +	dev_info(dev, "Pass-thru MAC addr %pM\n", sa->sa_data);
> +
> +amacout:
> +	kfree(obj);
> +	return ret;
> +
> +#else	/* !CONFIG_ACPI */
> +	(void)dev;
> +	(void)sa;
> +
> +	return -ENODEV;

No #ifdef in .c files, especially for something as trivial as this.  The
#ifdef needs to be in the .h file, and don't build this unless acpi is
enabled.  And then, just move this to the acpi core, not in lib/

thanks,

greg k-h
