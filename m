Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6558AB4CD
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 11:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbfIFJWF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 05:22:05 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51209 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728356AbfIFJWE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Sep 2019 05:22:04 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5BDA320FBE;
        Fri,  6 Sep 2019 05:22:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 06 Sep 2019 05:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=BPvuWYNA+G8sZz2Nil7DPB4BngH
        FT5qJQJJYiYcW98o=; b=ADKzolOT8/sapcyd3E1FYIcGQVmuabSqmv0dt77iwxK
        2rQ6z5HdXcZc7OzE0903ufw/Jjw8in8+0bzgf+TxtEPBhocACOi1qzD8sMwgGLcG
        JrjuUYcF/u5mJYfOfmYS0i/F3ePPzVJrSjhcrfBeyBYECmeKhKpBuBOwmb7H7WAY
        fwnPEZ5EAZ2KD3jvMYQG3kxpshFzNp9glCuXFYuLuEN4iVVsuphQzM7vZcxgyhVV
        z+jIEc4OMmpvDvNXn0P++E//TZf9psQM+0WCcxhandQ/UEQsKG08KS9s4oDK+OZV
        sbQuO6pqVuqent3EyBTnHni8iZWIZ/rJ3dxfbvreHuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=BPvuWY
        NA+G8sZz2Nil7DPB4BngHFT5qJQJJYiYcW98o=; b=RFsvcXsHXMJPE5b48930fw
        zNCtoPFNemKtkrmrIHT5zDEEH9jAP6cXVdGjUVMvNh/Tequ061xMG4hzN/c28ENv
        iJs8ghXt0duxnfWoDPpwYiBIpUjDNz8LOogFc7CaM0G24byAkR4zLkxYeRICDW0/
        +ndd73ZNiQmD9p1qAZZxrSByZ2BvvnoGjSZB8EAKvYo57ZL8GTGb7r8IKwsOpGFm
        qimTX2cKJiSGrOQNcfShTkfR/VX5XDPuEGsLmq3Xv2rjUAPsfpZCFdlwwD4vBBkk
        0JmTkVMDhfieqvxaMQYRzLH5RwaMABVH4wZZbzqhpS6LfLPV9O7pwXGxO1utcYDA
        ==
X-ME-Sender: <xms:OSVyXTgtcDt1ANI4fkLwm6x1BNuE1XeAW5SYv0LO_Ug_FnSbMWQxdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejledgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:OSVyXSzdTX9SvVlZQwsuxNbXN7Z0Lz5xYNkcOLTdEm3Rbsx7G69i0w>
    <xmx:OSVyXf9OycgIWPOHtrD6uWi7IP7_kAYkB6myvjobU0ARVbsbePWY0A>
    <xmx:OSVyXXxtwkwB-O2Pu1QzCS4rhgLdPVRhpHaZL8PVp_1lYeouRi7-6g>
    <xmx:OyVyXfmqKXW5QtSaNYom57F26OE-BQO89kc7qJaPEoYm_NHipkFkyw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9EC66D6005D;
        Fri,  6 Sep 2019 05:22:01 -0400 (EDT)
Date:   Fri, 6 Sep 2019 11:22:00 +0200
From:   Greg KH <greg@kroah.com>
To:     Charles Hyde <chip.programmer@gmail.com>
Cc:     Oliver Neukum <oliver@neukum.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Charles Hyde <charles.hyde@dellteam.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
Message-ID: <20190906092200.GA31500@kroah.com>
References: <20190906015115.12796-1-chip.programmer@gmail.com>
 <20190906015115.12796-4-chip.programmer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906015115.12796-4-chip.programmer@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 05, 2019 at 08:51:15PM -0500, Charles Hyde wrote:
> This change adds support to cdc_ncm for ACPI MAC address pass through
> functionality that also exists in the Realtek r8152 driver.  This is in
> support of Dell's Universal Dock D6000, to give it the same feature
> capability as is currently available in Windows and advertized on Dell's
> product web site.
> 
> Today's v3 patch series includes a function named get_ethernet_addr()
> which replaces two instances where the same code snippet was located in
> teh previous patch series.  I also created a post reset function to set
> the MAC address, if there exists an ACPI MAC address pass through (MAPT)
> method.  Oliver Neukum had requested a post reset function for this
> purpose.
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

As other people have pointed out, that's funny.

No, this is explicitly what the USB vendor/product ids are for, don't
try to make up something that will be guaranteed to not work
correctly...

> +		sa.sa_family = dev->net->type;
> +		if (get_acpi_mac_passthru(sa.sa_data)) {
> +			if (!memcmp(dev->net->dev_addr, sa.sa_data,
> +				    ETH_ALEN)) {
> +				if (!cdc_ncm_set_ethernet_address(dev, &sa))
> +					memcpy(dev->net->dev_addr, sa.sa_data,
> +					       ETH_ALEN);
> +			}
> +		}
> +	}
> +	dev_info(&intf->dev, "MAC-Address: %pM\n", dev->net->dev_addr);

If a driver is working properly, it should not spit out any kernel log
messages.  Make this dev_dbg() if you need it for your own debugging
logic.

thanks,

greg k-h
