Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C5E17890
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2019 13:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfEHLpQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 May 2019 07:45:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:49957 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfEHLpQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 May 2019 07:45:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 04:40:13 -0700
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 08 May 2019 04:40:10 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 May 2019 14:40:09 +0300
Date:   Wed, 8 May 2019 14:40:09 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 13/13] platform/x86: intel_cht_int33fe: Replacing the
 old connections with references
Message-ID: <20190508114009.GD19816@kuha.fi.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
 <20190412134122.82903-14-heikki.krogerus@linux.intel.com>
 <a91a1d75-f224-9c9d-873a-f80467d2fb0c@redhat.com>
 <20190417063918.GI1747@kuha.fi.intel.com>
 <76d9ab79-a1d0-f3cd-ba5d-2325740c72ff@redhat.com>
 <6f08b4b6-8303-5dc9-eb9e-30196bd95692@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f08b4b6-8303-5dc9-eb9e-30196bd95692@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 17, 2019 at 11:14:19PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 17-04-19 11:19, Hans de Goede wrote:
> > Note that another problem with this series which I noticed while testing
> > is that the usb-role-switch is not being found at all anymore after
> > this ("Replacing the old connections with references") patch. I still need
> > start debugging that.
> 
> Ok, I've just finished debugging this and I'm attaching 2 FIXUP
> patches (to be squased) and a new patch, which those 3 small fixes
> added the problem of tcpm.c being unable to get the role-switch
> goes away.
> 
> The second FIXUP patch might be a bit controversial; and we may
> need another solution for the problem it fixes. I've tried to
> explain it in more detail in the commit msg.

Thanks. I'll go over those, and probable squash them in. I'll think
about the second patch.

I'm going to first split the series in two so that I'll first
introduce all the other changes, and then in a separate series the
node reference stuff. I think it makes sense, since there are really
to major changes here: firstly starting to use the software nodes with
the connector fwnode and others, and secondly introducing the software
node references.

I'll send you an RFC of the first patches soon. Hope you have time to
check and test it.

> >From 3a2e047608a53caaefe8364eceb7e315ec413698 Mon Sep 17 00:00:00 2001
> From: Hans de Goede <hdegoede@redhat.com>
> Date: Wed, 17 Apr 2019 22:54:47 +0200
> Subject: [PATCH v2 1/3] FIXUP: "platform/x86: intel_cht_int33fe: Link with
>  external dependencies using fwnodes"
> 
> In the else path of: if (dev->fwnode) ... else ..., we should set
> dev->fwnode to our own fwnode not to dev->fwnode, which is NULL as we
> just tested.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index e6a1ea7f33af..07bf92ece6cd 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -189,7 +189,7 @@ static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
>  		data->node[INT33FE_NODE_ROLE_SWITCH] = dev->fwnode;
>  	} else {
>  		/* The node can be tied to the lifetime of the device. */
> -		dev->fwnode = fwnode_handle_get(dev->fwnode);
> +		dev->fwnode = fwnode_handle_get(fwnode);
>  	}
>  
>  	put_device(dev);
> -- 
> 2.21.0
> 

> >From 5133467f116dff6e111d4bc0610ccbcedb397f1d Mon Sep 17 00:00:00 2001
> From: Hans de Goede <hdegoede@redhat.com>
> Date: Wed, 17 Apr 2019 23:00:59 +0200
> Subject: [PATCH v2 2/3] FIXUP: "device connection: Find connections also by
>  checking the references"
> 
> The reference we are looking for might be in a child node, rather then
> directly in the device's own fwnode. A typical example of this is a
> usb connector node with references to various muxes / switches.
> 
> Note that we do not hit this problem for the device_connection_find_match
> calls in typec_switch_get and typec_mux_get because these get called
> from typec_register_port and typec_register_port creates a new device
> with its fwnode pointing to the usb-connector fwnode and that new
> device (rather then the parent) is passed to typec_switch/mux_get and
> thus to device_connection_find_match.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/base/devcon.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
> index 4cdf95532b63..6f6f870c21eb 100644
> --- a/drivers/base/devcon.c
> +++ b/drivers/base/devcon.c
> @@ -76,7 +76,7 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
>  void *device_connection_find_match(struct device *dev, const char *con_id,
>  				   void *data, devcon_match_fn_t match)
>  {
> -	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +	struct fwnode_handle *child, *fwnode = dev_fwnode(dev);
>  	const char *devname = dev_name(dev);
>  	struct device_connection *con;
>  	void *ret = NULL;
> @@ -93,6 +93,12 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
>  		ret = fwnode_devcon_match(fwnode, con_id, data, match);
>  		if (ret)
>  			return ret;
> +
> +		fwnode_for_each_child_node(fwnode, child) {
> +			ret = fwnode_devcon_match(child, con_id, data, match);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	mutex_lock(&devcon_lock);
> -- 
> 2.21.0
> 

> >From a69f76993dfe5f43d3e6c4b2bcfbaacf2c247d6e Mon Sep 17 00:00:00 2001
> From: Hans de Goede <hdegoede@redhat.com>
> Date: Wed, 17 Apr 2019 22:57:00 +0200
> Subject: [PATCH v2 3/3] usb: roles: Check for NULL con_id
> 
> When usb_role_switch_match gets called by device_connection_find_match
> because of a fwnode_reference matching the con_id passed to
> device_connection_find_match, then con->id will be NULL and in this
> case we do not need to check it since our caller has already checked it.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/usb/roles/class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index f45d8df5cfb8..86defca6623e 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -101,7 +101,7 @@ static void *usb_role_switch_match(struct device_connection *con, int ep,
>  	struct device *dev;
>  
>  	if (con->fwnode) {
> -		if (!fwnode_property_present(con->fwnode, con->id))
> +		if (con->id && !fwnode_property_present(con->fwnode, con->id))
>  			return NULL;
>  
>  		dev = class_find_device(role_class, NULL, con->fwnode,
> -- 
> 2.21.0
> 

thanks,

-- 
heikki
