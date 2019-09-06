Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046A4AB088
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 04:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfIFCNf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 22:13:35 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19805 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726600AbfIFCNf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Sep 2019 22:13:35 -0400
X-UUID: 5f0f387dd44c4f47a7829ab7159041db-20190906
X-UUID: 5f0f387dd44c4f47a7829ab7159041db-20190906
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 642873372; Fri, 06 Sep 2019 10:13:29 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 6 Sep
 2019 10:13:25 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Sep 2019 10:13:24 +0800
Message-ID: <1567736007.7317.71.camel@mhfsdcap03>
Subject: Re: [PATCH 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     <Charles.Hyde@dellteam.com>
CC:     <oliver@neukum.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <Mario.Limonciello@dell.com>, <chip.programmer@gmail.com>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Date:   Fri, 6 Sep 2019 10:13:27 +0800
In-Reply-To: <1567717304186.90134@Dellteam.com>
References: <1567717304186.90134@Dellteam.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 34CE9271F974A5FFB90B8AA99CD636C6B43A790E619EA2EB9E91D6023E8C62562000:8
X-MTK:  N
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2019-09-05 at 21:01 +0000, Charles.Hyde@dellteam.com wrote:
> This change adds support to cdc_ncm for ACPI MAC address pass through
> functionality that also exists in the Realtek r8152 driver.  This is in
> support of Dell's Universal Dock D6000, to give it the same feature
> capability as is currently available in Windows and advertized on Dell's
> product web site.
> 
> Signed-off-by: Charles Hyde <charles.hyde@dellteam.com>
> Cc: Mario Limonciello <mario.limonciello@dell.com>
> Cc: chip.programmer@gmail.com
> Cc: Oliver Neukum <oliver@neukum.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> ---
>  drivers/net/usb/cdc_ncm.c | 74 +++++++++++++++++++++++++++++++++------
>  1 file changed, 64 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 85093579612f..e0152d44f5af 100644
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
> @@ -833,6 +834,45 @@ static const struct net_device_ops cdc_ncm_netdev_ops = {
>  	.ndo_validate_addr   = eth_validate_addr,
>  };
>  
> +static int get_ethernet_addr(struct usb_interface *intf)
> +{
> +	struct sockaddr sa;
> +	struct usbnet *dev = usb_get_intfdata(intf);
> +	struct cdc_ncm_ctx *ctx;
> +	int ret = 0;
> +
> +	if (!dev)
> +		return 0;
> +
> +	ctx = (struct cdc_ncm_ctx *)dev->data[0];
> +	if (!ctx->ether_desc)
> +		return 0;
> +
> +	ret = cdc_ncm_get_ethernet_address(dev, ctx);
> +	if (ret) {
> +		dev_dbg(&intf->dev, "failed to get mac address\n");
> +		return ret;
> +	}
> +
> +	/* Check for a Dell Universal Dock D6000 before checking if ACPI
> +	 * supports MAC address pass through.
> +	 */
> +	if (strstr(dev->udev->product, "D6000")) {
> +		sa.sa_family = dev->net->type;
> +		if (get_acpi_mac_passthru(sa.sa_data)) {
> +			if (!memcmp(dev->net->dev_addr, sa.sa_data,
> +				    ETH_ALEN)) {
> +				if (!cdc_ncm_set_ethernet_address(dev, &sa))
How about use one if-statement instead of these three if-statement?

> +					memcpy(dev->net->dev_addr, sa.sa_data,
> +					       ETH_ALEN);
> +			}
> +		}
> +	}
> +	dev_info(&intf->dev, "MAC-Address: %pM\n", dev->net->dev_addr);
> +
> +	return 0;
> +}
> +
>  int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_altsetting, int drvflags)
>  {
>  	struct cdc_ncm_ctx *ctx;
> @@ -983,14 +1023,8 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
>  	usb_set_intfdata(ctx->data, dev);
>  	usb_set_intfdata(ctx->control, dev);
>  
> -	if (ctx->ether_desc) {
> -		temp = usbnet_get_ethernet_addr(dev, ctx->ether_desc->iMACAddress);
> -		if (temp) {
> -			dev_dbg(&intf->dev, "failed to get mac address\n");
> -			goto error2;
> -		}
> -		dev_info(&intf->dev, "MAC-Address: %pM\n", dev->net->dev_addr);
> -	}
> +	if (get_ethernet_addr(intf))
> +		goto error2;
>  
>  	/* finish setting up the device specific data */
>  	cdc_ncm_setup(dev);
> @@ -1716,6 +1750,25 @@ static void cdc_ncm_status(struct usbnet *dev, struct urb *urb)
>  	}
>  }
>  
> +static int cdc_ncm_resume(struct usb_interface *intf)
> +{
> +	int ret;
> +
> +	ret = usbnet_resume(intf);
> +	if (ret == 0)
> +		get_ethernet_addr(intf);
> +
> +	return ret;
> +}
> +
> +static int cdc_ncm_post_reset(struct usb_interface *intf)
> +{
> +	/* reset the MAC address in case of policy change */
> +	get_ethernet_addr(intf);
> +
> +	return 0;
> +}
> +
>  static const struct driver_info cdc_ncm_info = {
>  	.description = "CDC NCM",
>  	.flags = FLAG_POINTTOPOINT | FLAG_NO_SETINT | FLAG_MULTI_PACKET
> @@ -1848,8 +1901,9 @@ static struct usb_driver cdc_ncm_driver = {
>  	.probe = usbnet_probe,
>  	.disconnect = usbnet_disconnect,
>  	.suspend = usbnet_suspend,
> -	.resume = usbnet_resume,
> -	.reset_resume =	usbnet_resume,
> +	.resume = cdc_ncm_resume,
> +	.reset_resume =	cdc_ncm_resume,
> +	.post_reset = cdc_ncm_post_reset,
>  	.supports_autosuspend = 1,
>  	.disable_hub_initiated_lpm = 1,
>  };


