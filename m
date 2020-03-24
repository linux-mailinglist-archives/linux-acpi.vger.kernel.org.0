Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B87B41905AE
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Mar 2020 07:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgCXG0h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Mar 2020 02:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCXG0h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Mar 2020 02:26:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD77520663;
        Tue, 24 Mar 2020 06:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585031197;
        bh=BSViwAiJC3sbGx+r5qKqwJNLn6pppAaGTLJ8eTWD0k0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDuirIv8lwJ65151gMjmNP7PaYnpKYQgNmiVVHZaiqVLsT3GelzvPV5k73FrVLzEt
         z4DPtpFGQx2NDKEnL5rx2AscUx7yhtXhe3GcJl94GlCEdHBP0EblnxrKVtHUS4yI7I
         fwFXnVptJItp0N1LyiTwexevnBtKLTPKFLkZM/X4=
Date:   Tue, 24 Mar 2020 07:26:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1] usb: core: Add ACPI support for USB interfaces
Message-ID: <20200324062635.GB1977781@kroah.com>
References: <20200323195543.51050-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323195543.51050-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 23, 2020 at 09:55:43PM +0200, Andy Shevchenko wrote:
> The ACPI companion of the device has to be set for USB interfaces
> in order to read and attach the properties described in the ACPI table.
> Use ACPI_COMPANION_SET macro to set this.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/usb/core/message.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 5adf489428aa..d5f834f16993 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -5,6 +5,7 @@
>   * Released under the GPLv2 only.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/pci.h>	/* for scatterlist macros */
>  #include <linux/usb.h>
>  #include <linux/module.h>
> @@ -1941,6 +1942,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  			intf->dev.of_node = usb_of_get_interface_node(dev,
>  					configuration, ifnum);
>  		}
> +		ACPI_COMPANION_SET(&intf->dev, ACPI_COMPANION(&dev->dev));
>  		intf->dev.driver = NULL;
>  		intf->dev.bus = &usb_bus_type;
>  		intf->dev.type = &usb_if_device_type;

And what does this "fix"?

Is this a new feature, what isn't working today without this change?

And if it is a fix, should it be backported to older kernels, how far?

greg k-h
