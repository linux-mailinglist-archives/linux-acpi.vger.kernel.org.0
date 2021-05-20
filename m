Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7C638A0C1
	for <lists+linux-acpi@lfdr.de>; Thu, 20 May 2021 11:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhETJZP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 May 2021 05:25:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:2922 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhETJZP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 May 2021 05:25:15 -0400
IronPort-SDR: eV8s90sSh9VCPABnlEPFyyuiNH9h50F6P263ZuLDkwtMIqdGGH9O81mqLp1ewzNgjcvOixD9gD
 h1dgPV2HPgVg==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="188311733"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188311733"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 02:23:52 -0700
IronPort-SDR: c7lIMaCOfzFZ2NBwACtluJW3Ai1NYYpWuAwVxoBtsVmEcgwRU50pClCpzOJ1BOHWontwoFxv4B
 OntfXOpEhc1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="543393403"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 20 May 2021 02:23:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 20 May 2021 12:23:47 +0300
Date:   Thu, 20 May 2021 12:23:47 +0300
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
Message-ID: <YKYqozRazwKc6wOF@kuha.fi.intel.com>
References: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
 <20210519141259.84839-3-mika.westerberg@linux.intel.com>
 <YKUrZ0b4UObhtV9k@kuha.fi.intel.com>
 <20210519154005.GV291593@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519154005.GV291593@lahna.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Wed, May 19, 2021 at 06:40:05PM +0300, Mika Westerberg wrote:
> > I noticed that in the next patch you add acpi_bus_type for these
> > ports, but is that really necessary? Why not just:
> > 
> > int usb4_port_fwnode_match(struct tb_port *port, struct fwnode_handle *fwnode)
> > {
> >         if (is_acpi_device_node(fwnode))
> >                 return acpi_device_adr(to_acpi_device_node(fwnode)) == port->port;
> > 
> >         return 0;
> > }
> 
> I have to say I might be missing some new additions to fwnode front but
> the acpi_bus_type is used to match the ACPI nodes to usb4_ports and also
> to routers. I see that this one may work for the former but not sure
> about the latter.

Yeah, I noticed that afterwards.

> I guess we could do similar for routers too in switch.c.

Forget about it.

> However, I would like to keep ACPI specific code in acpi.c if possible
> but if this is the preferred way then no problem doing what you say :)

Well, that's actually the thing. The matching is the only ACPI (or any
firmware type) specific thing that we need when assigning the firmware
nodes to the device. Note also that the above function works already
even with CONFIG_ACPI=n. That's why I though that there is no reason
not to just make this firmware node type agnostic from the start.

But since your acpi_bus_type handles also the routers, and also since
the node hierarchy with the separate UFP and DFP ports and everything
did not look straightforward, it's probable easier to just use that.

So sorry again for the noise.

> > > +/**
> > > + * usb4_port_device_add() - Add USB4 port device
> > > + * @port: Lane 0 adapter port to add the USB4 port
> > > + *
> > > + * Creates and registers a USB4 port device for @port. Returns the new
> > > + * USB4 port device pointer or ERR_PTR() in case of error.
> > > + */
> > > +struct usb4_port *usb4_port_device_add(struct tb_port *port)
> > > +{
> > 
> >         struct fwnode_handle *child;
> > 
> > > +	struct usb4_port *usb4;
> > > +	int ret;
> > > +
> > > +	usb4 = kzalloc(sizeof(*usb4), GFP_KERNEL);
> > > +	if (!usb4)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	usb4->port = port;
> > > +	usb4->dev.type = &usb4_port_device_type;
> > > +	usb4->dev.parent = &port->sw->dev;
> > > +	dev_set_name(&usb4->dev, "usb4_port%d", port->port);
> > 
> > and then here something like this (feel free to improve this part):
> > 
> >         device_for_each_child_node(&port->sw->dev, child) {
> >                 if (usb4_port_fwnode_match(port, child)) {
> >                         usb4->dev.fwnode = child;
> >                         break;
> >                 }
> >         }
> > 
> > Or maybe I'm missing something?
> > 
> > > +	ret = device_register(&usb4->dev);
> > > +	if (ret) {
> > > +		put_device(&usb4->dev);
> > > +		return ERR_PTR(ret);
> > > +	}
> > > +
> > > +	pm_runtime_no_callbacks(&usb4->dev);
> > > +	pm_runtime_set_active(&usb4->dev);
> > > +	pm_runtime_enable(&usb4->dev);
> > > +	pm_runtime_set_autosuspend_delay(&usb4->dev, TB_AUTOSUSPEND_DELAY);
> > > +	pm_runtime_mark_last_busy(&usb4->dev);
> > > +	pm_runtime_use_autosuspend(&usb4->dev);
> > > +
> > > +	return usb4;
> > > +}

thanks,

-- 
heikki
