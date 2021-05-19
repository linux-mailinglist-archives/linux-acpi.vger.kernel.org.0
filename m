Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF02389258
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 17:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhESPQN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 11:16:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:9233 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231823AbhESPQN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 May 2021 11:16:13 -0400
IronPort-SDR: kkIlW0bV0396rn6ANvfyA8bVoVVHi62e60m2YiCNsFy1OCKEINPHS34bhH8wuszw9ok7V9782K
 xR/ydeJfzW/g==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="264915694"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="264915694"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 08:14:52 -0700
IronPort-SDR: 5AMFMnRYfhCdHT3AOE0rxIaGzSu17wCrw5oS+0VCZY8282OzA+jXlwmxgb3xYpv66GIY0SZd+F
 mTKmtLWb7TPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="542675574"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 19 May 2021 08:14:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 19 May 2021 18:14:47 +0300
Date:   Wed, 19 May 2021 18:14:47 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Casey G Bowman <casey.g.bowman@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/9] thunderbolt: Add USB4 port devices
Message-ID: <YKUrZ0b4UObhtV9k@kuha.fi.intel.com>
References: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
 <20210519141259.84839-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519141259.84839-3-mika.westerberg@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 19, 2021 at 05:12:52PM +0300, Mika Westerberg wrote:
> Create devices for each USB4 port. This is needed when we add retimer
> access when there is no device connected but may be useful for other
> purposes too following what USB subsystem does. This exports a single
> attribute "link" that shows the type of the USB4 link (or "none" if
> there is no cable connected).

<snip>

> +/*
> + * USB4 port device
> + *
> + * Copyright (C) 2021, Intel Corporation
> + * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "tb.h"
> +
> +static ssize_t link_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct usb4_port *usb4 = tb_to_usb4_port_device(dev);
> +	struct tb_port *port = usb4->port;
> +	struct tb *tb = port->sw->tb;
> +	const char *link;
> +
> +	if (mutex_lock_interruptible(&tb->lock))
> +		return -ERESTARTSYS;
> +
> +	if (tb_is_upstream_port(port))
> +		link = port->sw->link_usb4 ? "usb4" : "tbt";
> +	else if (tb_port_has_remote(port))
> +		link = port->remote->sw->link_usb4 ? "usb4" : "tbt";
> +	else
> +		link = "none";
> +
> +	mutex_unlock(&tb->lock);
> +
> +	return sysfs_emit(buf, "%s\n", link);
> +}
> +static DEVICE_ATTR_RO(link);
> +
> +static struct attribute *common_attrs[] = {
> +	&dev_attr_link.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group common_group = {
> +	.attrs = common_attrs,
> +};
> +
> +static const struct attribute_group *usb4_port_device_groups[] = {
> +	&common_group,
> +	NULL
> +};
> +
> +static void usb4_port_device_release(struct device *dev)
> +{
> +	struct usb4_port *usb4 = container_of(dev, struct usb4_port, dev);
> +
> +	kfree(usb4);
> +}
> +
> +struct device_type usb4_port_device_type = {
> +	.name = "usb4_port",
> +	.groups = usb4_port_device_groups,
> +	.release = usb4_port_device_release,
> +};

I noticed that in the next patch you add acpi_bus_type for these
ports, but is that really necessary? Why not just:

int usb4_port_fwnode_match(struct tb_port *port, struct fwnode_handle *fwnode)
{
        if (is_acpi_device_node(fwnode))
                return acpi_device_adr(to_acpi_device_node(fwnode)) == port->port;

        return 0;
}

> +/**
> + * usb4_port_device_add() - Add USB4 port device
> + * @port: Lane 0 adapter port to add the USB4 port
> + *
> + * Creates and registers a USB4 port device for @port. Returns the new
> + * USB4 port device pointer or ERR_PTR() in case of error.
> + */
> +struct usb4_port *usb4_port_device_add(struct tb_port *port)
> +{

        struct fwnode_handle *child;

> +	struct usb4_port *usb4;
> +	int ret;
> +
> +	usb4 = kzalloc(sizeof(*usb4), GFP_KERNEL);
> +	if (!usb4)
> +		return ERR_PTR(-ENOMEM);
> +
> +	usb4->port = port;
> +	usb4->dev.type = &usb4_port_device_type;
> +	usb4->dev.parent = &port->sw->dev;
> +	dev_set_name(&usb4->dev, "usb4_port%d", port->port);

and then here something like this (feel free to improve this part):

        device_for_each_child_node(&port->sw->dev, child) {
                if (usb4_port_fwnode_match(port, child)) {
                        usb4->dev.fwnode = child;
                        break;
                }
        }

Or maybe I'm missing something?

> +	ret = device_register(&usb4->dev);
> +	if (ret) {
> +		put_device(&usb4->dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	pm_runtime_no_callbacks(&usb4->dev);
> +	pm_runtime_set_active(&usb4->dev);
> +	pm_runtime_enable(&usb4->dev);
> +	pm_runtime_set_autosuspend_delay(&usb4->dev, TB_AUTOSUSPEND_DELAY);
> +	pm_runtime_mark_last_busy(&usb4->dev);
> +	pm_runtime_use_autosuspend(&usb4->dev);
> +
> +	return usb4;
> +}

thanks,

-- 
heikki
