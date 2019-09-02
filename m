Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D48EA532A
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 11:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfIBJno (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 05:43:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:48548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729668AbfIBJno (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 05:43:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6F57AF54;
        Mon,  2 Sep 2019 09:43:42 +0000 (UTC)
Message-ID: <1567417420.2469.3.camel@suse.com>
Subject: Re: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
From:   Oliver Neukum <oneukum@suse.com>
To:     Charles.Hyde@dellteam.com, lenb@kernel.org, rjw@rjwysocki.net
Cc:     Mario.Limonciello@dell.com, nic_swsd@realtek.com,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Mon, 02 Sep 2019 11:43:40 +0200
In-Reply-To: <5cee0eb405f2492b8086d8684f1c75ca@AUSX13MPS307.AMER.DELL.COM>
References: <5cee0eb405f2492b8086d8684f1c75ca@AUSX13MPS307.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Am Freitag, den 30.08.2019, 19:37 +0000 schrieb
Charles.Hyde@dellteam.com:
> This patch adds support for pushing a MAC address out to USB based
> ethernet controllers driven by cdc_ncm.  With this change, ifconfig can
> now set the device's MAC address.  For example, the Dell Universal Dock
> D6000 is driven by cdc_ncm.  The D6000 can now have its MAC address set
> by ifconfig, as it can be done in Windows.  This was tested with a D6000
> using ifconfig on an x86 based chromebook, where iproute2 is not
> available.

> +/* Provide method to push MAC address to the USB device's ethernet controller.
> + */
> +int cdc_ncm_set_mac_addr(struct net_device *net, void *p)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +
> +	/* Try to push the MAC address out to the device.  Ignore any errors,
> +	 * to be compatible with prior versions of this source.
> +	 */
> +	cdc_ncm_set_ethernet_address(dev, (struct sockaddr *)p);

You are throwing away error reports.

	Regards
		Oliver

