Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734832D92C
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2019 11:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfE2JgJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 May 2019 05:36:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39021 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfE2JgJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 May 2019 05:36:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id e24so2724612edq.6
        for <linux-acpi@vger.kernel.org>; Wed, 29 May 2019 02:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+JR93oPof/EMEek7mDnj8OOcvuCQwdSytsivGNj6W1k=;
        b=uFbfIXgPur0EjGORRcPNUKGrQhCGAf6VOHX27Pwjp+4COAx3bFCJ0Me5mFKOd8+sQb
         aXtduXxfNwpTtiX/VqFS0Fd1UpJ2DdFGnMa5h6MW+plAXJ8ocCT3gmM6BhOF6dXCOIVo
         B4BWjbmuFXRE7Vyu6cyyOC/kDShw3BltSoNK40OXNusIeSvgxKIdaUJ/71Gh5Ten6nSK
         68nZycsnCY8gskijm9NToFGfSGJ0BWRMIg8SBObFe3aS+aSxVbPeo9SM4GoG9VCWaUj+
         8NYdHrgxV3zo12k38MPG+4cz9LvkU7A1hrJ2MWlJqHmUvri/ecHmM1gVN0js+6UVxjku
         StHg==
X-Gm-Message-State: APjAAAU04JXNa2Kf0Hti7IuiqWYXWhd9XtOeAIr+sQXUTDvIoKIr5LaW
        XJNrKG+9rGfEVpLCxS3XDuD+8S2zNQs=
X-Google-Smtp-Source: APXvYqxmNiiFw39c3SbWZfLqlEtorg7H+UdPzQ5FPoaOQL1v6449ESbGUuWLrRRxwJMxnqoxrSoAqA==
X-Received: by 2002:a50:b7f8:: with SMTP id i53mr134880111ede.196.1559122566947;
        Wed, 29 May 2019 02:36:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id x22sm5024494edd.59.2019.05.29.02.36.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:36:06 -0700 (PDT)
Subject: Re: [PATCH v4 15/16] platform/x86: intel_cht_int33fe: Supply fwnodes
 for the external dependencies
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
 <20190522105113.11153-16-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d174e7e9-f44c-b257-4678-d53676265d44@redhat.com>
Date:   Wed, 29 May 2019 11:36:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522105113.11153-16-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/22/19 12:51 PM, Heikki Krogerus wrote:
> Supplying also external devices, the DisplayPort connector
> and the USB role switch, software fwnodes. After this the
> driver has access to all the components tied to the USB
> Type-C connector and can start creating software node
> references to actually associate them with the USB Type-C
> connector device.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>   drivers/platform/x86/intel_cht_int33fe.c | 128 ++++++++++++++++++++++-
>   1 file changed, 125 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 34bc2d178760..e5c0b6573618 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -21,6 +21,7 @@
>   #include <linux/i2c.h>
>   #include <linux/interrupt.h>
>   #include <linux/module.h>
> +#include <linux/pci.h>
>   #include <linux/platform_device.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
> @@ -32,6 +33,8 @@ enum {
>   	INT33FE_NODE_FUSB302,
>   	INT33FE_NODE_MAX17047,
>   	INT33FE_NODE_PI3USB30532,
> +	INT33FE_NODE_DISPLAYPORT,
> +	INT33FE_NODE_ROLE_SWITCH,
>   	INT33FE_NODE_USB_CONNECTOR,
>   	INT33FE_NODE_MAX,
>   };
> @@ -42,6 +45,9 @@ struct cht_int33fe_data {
>   	struct i2c_client *pi3usb30532;
>   	/* Contain a list-head must be per device */
>   	struct device_connection connections[4];
> +
> +	struct fwnode_handle *dp;
> +	struct fwnode_handle *mux;
>   };
>   
>   /*
> @@ -110,10 +116,126 @@ static const struct software_node nodes[] = {
>   	{ "fusb302", NULL, fusb302_props },
>   	{ "max17047", NULL, max17047_props },
>   	{ "pi3usb30532" },
> +	{ "displayport" },
> +	{ "usb-role-switch" },
>   	{ "connector", &nodes[0], usb_connector_props },
>   	{ }
>   };
>   
> +static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
> +{
> +	struct fwnode_handle *fwnode;
> +	struct device *dev;
> +	struct device *p;
> +
> +	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_ROLE_SWITCH]);
> +	if (!fwnode)
> +		return -ENODEV;
> +
> +	/* First finding the platform device */
> +	p = bus_find_device_by_name(&platform_bus_type, NULL,
> +				    "intel_xhci_usb_sw");
> +	if (!p)
> +		return -EPROBE_DEFER;
> +
> +	/* Then the mux child device */
> +	dev = device_find_child_by_name(p, "intel_xhci_usb_sw-role-switch");
> +	put_device(p);
> +	if (!dev)
> +		return -EPROBE_DEFER;
> +
> +	/* If there already is a node for the mux, using that one. */
> +	if (dev->fwnode)
> +		fwnode_remove_software_node(fwnode);
> +	else
> +		dev->fwnode = fwnode;
> +
> +	data->mux = fwnode_handle_get(dev->fwnode);
> +	put_device(dev);
> +
> +	return 0;
> +}
> +
> +static int cht_int33fe_setup_dp(struct cht_int33fe_data *data)
> +{
> +	struct fwnode_handle *fwnode;
> +	struct pci_dev *pdev;
> +
> +	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_DISPLAYPORT]);
> +	if (!fwnode)
> +		return -ENODEV;
> +
> +	/* First let's find the GPU PCI device */
> +	pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
> +	if (!pdev || pdev->vendor != PCI_VENDOR_ID_INTEL) {
> +		pci_dev_put(pdev);
> +		return -ENODEV;
> +	}
> +
> +	/* Then the DP child device node */
> +	data->dp = device_get_named_child_node(&pdev->dev, "DD02");
> +	pci_dev_put(pdev);
> +	if (!data->dp)
> +		return -ENODEV;
> +
> +	fwnode->secondary = ERR_PTR(-ENODEV);
> +	data->dp->secondary = fwnode;
> +
> +	return 0;
> +}
> +
> +static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
> +{
> +	software_node_unregister_nodes(nodes);
> +
> +	if (data->mux) {
> +		fwnode_handle_put(data->mux);
> +		data->mux = NULL;
> +	}
> +
> +	if (data->dp) {
> +		data->dp->secondary = NULL;
> +		fwnode_handle_put(data->dp);
> +		data->dp = NULL;
> +	}
> +}
> +
> +static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
> +{
> +	int ret;
> +
> +	ret = software_node_register_nodes(nodes);
> +	if (ret)
> +		return ret;
> +
> +	/* The devices that are not created in this driver need extra steps. */
> +
> +	/*
> +	 * There is no ACPI device node for the USB role mux, so we need to find
> +	 * the mux device and assign our node directly to it. That means we
> +	 * depend on the mux driver. This function will return -PROBE_DEFER
> +	 * until the mux device is registered.
> +	 */
> +	ret = cht_int33fe_setup_mux(data);
> +	if (ret)
> +		goto err_remove_nodes;
> +
> +	/*
> +	 * The DP connector does have ACPI device node. In this case we can just
> +	 * find that ACPI node and assing our node as the secondary node to it.
> +	 */


s/assing/adding/  I presume ?

Regards,

Hans



> +	ret = cht_int33fe_setup_dp(data);
> +	if (ret)
> +		goto err_remove_nodes;
> +
> +	return 0;
> +
> +err_remove_nodes:
> +	cht_int33fe_remove_nodes(data);
> +
> +	return ret;
> +}
> +
>   static int
>   cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
>   {
> @@ -211,7 +333,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>   	if (!data)
>   		return -ENOMEM;
>   
> -	ret = software_node_register_nodes(nodes);
> +	ret = cht_int33fe_add_nodes(data);
>   	if (ret)
>   		return ret;
>   
> @@ -280,7 +402,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>   	device_connections_remove(data->connections);
>   
>   out_remove_nodes:
> -	software_node_unregister_nodes(nodes);
> +	cht_int33fe_remove_nodes(data);
>   
>   	return ret;
>   }
> @@ -294,7 +416,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
>   	i2c_unregister_device(data->max17047);
>   
>   	device_connections_remove(data->connections);
> -	software_node_unregister_nodes(nodes);
> +	cht_int33fe_remove_nodes(data);
>   
>   	return 0;
>   }
> 
