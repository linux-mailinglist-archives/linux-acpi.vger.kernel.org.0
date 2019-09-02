Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38AA534E
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 11:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfIBJtX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 05:49:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:55448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730106AbfIBJtX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 05:49:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 545A4AC38;
        Mon,  2 Sep 2019 09:49:21 +0000 (UTC)
Message-ID: <1567417759.2469.5.camel@suse.com>
Subject: Re: [PATCH 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
From:   Oliver Neukum <oneukum@suse.com>
To:     Charles.Hyde@dellteam.com, lenb@kernel.org, rjw@rjwysocki.net
Cc:     Mario.Limonciello@dell.com, nic_swsd@realtek.com,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Mon, 02 Sep 2019 11:49:19 +0200
In-Reply-To: <b24465a706744d99a7c1682f05a24784@AUSX13MPS307.AMER.DELL.COM>
References: <b24465a706744d99a7c1682f05a24784@AUSX13MPS307.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Am Freitag, den 30.08.2019, 19:38 +0000 schrieb
Charles.Hyde@dellteam.com:
> This change adds support to cdc_ncm for ACPI MAC address pass through
> functionality that also exists in the Realtek r8152 driver.  This is in
> support of Dell's Universal Dock D6000, to give it the same feature
> capability as is currently available in Windows and advertized on Dell's
> product web site.
> 
> Signed-off-by: Charles Hyde <charles.hyde@dellteam.com>
> Cc: Mario Limonciello <mario.limonciello@dell.com>
> Cc: Oliver Neukum <oliver@neukum.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> ---
>  drivers/net/usb/cdc_ncm.c | 67 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 85093579612f..11a04dc2298d 100644
> --- a/drivers/net/usb/cdc_ncm.c
> +++ b/drivers/net/usb/cdc_ncm.c
> @@ -52,6 +52,7 @@
>  #include <linux/usb/usbnet.h>
>  #include <linux/usb/cdc.h>
>  #include <linux/usb/cdc_ncm.h>
> +#include <acpi/acpi_mac_passthru.h>
>  
>  #if IS_ENABLED(CONFIG_USB_NET_CDC_MBIM)
>  static bool prefer_mbim = true;
> @@ -984,11 +985,30 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
>  	usb_set_intfdata(ctx->control, dev);
>  
>  	if (ctx->ether_desc) {
> -		temp = usbnet_get_ethernet_addr(dev, ctx->ether_desc->iMACAddress);
> +		struct sockaddr sa;
> +
> +		temp = cdc_ncm_get_ethernet_address(dev, ctx);
>  		if (temp) {
>  			dev_dbg(&intf->dev, "failed to get mac address\n");
>  			goto error2;
>  		}
> +
> +		/* Check for a Dell Universal Dock D6000 before checking if
> +		 * ACPI supports MAC address pass through.
> +		 */
> +		if (!strstr(dev->udev->product, "D6000"))
> +			goto skip_acpi_mapt_in_bind;
> +
> +		if (get_acpi_mac_passthru(sa.sa_data) != 0)
> +			goto skip_acpi_mapt_in_bind;
> +
> +		if (memcmp(dev->net->dev_addr, sa.sa_data, ETH_ALEN) == 0)
> +			goto skip_acpi_mapt_in_bind;
> +
> +		if (cdc_ncm_set_ethernet_address(dev, &sa) == 0)
> +			memcpy(dev->net->dev_addr, sa.sa_data, ETH_ALEN);
> +
> +skip_acpi_mapt_in_bind:
>  		dev_info(&intf->dev, "MAC-Address: %pM\n", dev->net->dev_addr);
>  	}
>  
> @@ -1716,6 +1736,47 @@ static void cdc_ncm_status(struct usbnet *dev, struct urb *urb)
>  	}
>  }
>  
> +static int cdc_ncm_resume(struct usb_interface *intf)
> +{
> +	struct usbnet *dev = usb_get_intfdata(intf);
> +	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
> +	int ret;
> +
> +	ret = usbnet_resume(intf);
> +	if (ret != 0)
> +		goto error2;
> +
> +	if (ctx->ether_desc) {
> +		struct sockaddr sa;
> +
> +		if (cdc_ncm_get_ethernet_address(dev, ctx)) {
> +			dev_dbg(&intf->dev, "failed to get mac address\n");
> +			goto error2;
> +		}
> +
> +		/* Check for a Dell Universal Dock D6000 before checking if
> +		 * ACPI supports MAC address pass through.
> +		 */
> +		if (!strstr(dev->udev->product, "D6000"))
> +			goto skip_acpi_mapt_in_resume;

This is too ugly. Use a flag for the need to restore the MAC.
And have you consider the case somebody triggers a reset through
usbfs? It looks to me like you should encapsulate the restoration
of the MAC and also use it in post_reset()

	Regards
		Oliver

