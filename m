Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BBD679DCE
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jan 2023 16:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbjAXPn7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Jan 2023 10:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjAXPn6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 10:43:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F9B6A45;
        Tue, 24 Jan 2023 07:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674575036; x=1706111036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KwSmSzXNDFzeQhf+d70xYTh76xHp2WPVcGIoNfs08vs=;
  b=HGh1m3o95PRieB9rq0hok2/VfvRFKKCoCPPDtZv3NzebBFRQfe9J13ky
   YClHmnDfkzLONXfaumoOIVO2VNvMe0I6RpLh1UH1wMliFWVML5QIJnqAv
   ALzGGwyDDEkIoeq532Il/vnegnEjJv4AXQLAJqib/Qam5Poq2xkNFcECT
   f6humRrlAxQE20ecwV6detvFxU1NHPdhqC4tBCFz8EN8HZNNXyEjnrgLz
   jJ89seVOpl7ZMjv5fjFMx6u1CRhTTrSSUo/nfeJ9bq31W8vv1dUSw9A2h
   nh+EYMrmk58huHGXUpkAsfdnRz8M0RGfgQP29JuBl3eAs41ugB3tip8DH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="314223584"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="314223584"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:43:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="612083442"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="612083442"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:43:26 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 094DB122501;
        Tue, 24 Jan 2023 17:43:23 +0200 (EET)
Date:   Tue, 24 Jan 2023 17:43:22 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y8/8moorDUIseO3/@kekkonen.localdomain>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-5-sakari.ailus@linux.intel.com>
 <Y86mhdQrcWMr58wV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y86mhdQrcWMr58wV@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Mon, Jan 23, 2023 at 05:23:49PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 23, 2023 at 03:46:13PM +0200, Sakari Ailus wrote:
> > Generate software nodes for information parsed from ACPI _CRS for CSI-2 as
> > well as MIPI DisCo for Imaging spec. The software nodes are compliant with
> > existing ACPI or DT definitions and are parsed by relevant drivers without
> > changes.
> 
> ...
> 
> > +static struct acpi_device_software_nodes *
> > +crs_csi2_swnode_get(acpi_handle handle)
> 
> It's 81 on one line. Why not to join?

Works for me.

> 
> > +{
> > +	struct crs_csi2_swnodes *swnodes;
> > +
> > +	list_for_each_entry(swnodes, &crs_csi2_swnodes, list)
> > +		if (swnodes->handle == handle)
> > +			return swnodes->ads;
> > +
> > +	return NULL;
> > +}
> 
> ...
> 
> > +#define GRAPH_PORT_NAME(var, num)					   \
> > +	(snprintf((var), sizeof(var), SWNODE_GRAPH_PORT_NAME_FMT, (num)) > \
> > +	 sizeof(var))
> 
> >= ?
> 
> ("excluding the trailing '\0'")

Thanks, indeed. A bug introduced in v2.

> 
> ...
> 
> > +static struct fwnode_handle *get_mipi_port_handle(struct acpi_device *device,
> > +						  unsigned int port)
> > +{
> 
> > +	static const char mipi_port_prefix[] = "mipi-img-port-";
> 
> It's used only once in this function, why not keeping it in the format string?

Twice, not once. My point was that it's critical the strings remain the
same length, and certainly what that string actually is, is less important.

> 
> > +	char mipi_port_name[sizeof(mipi_port_prefix) + 2];
> > +
> > +	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "%s%u",
> > +		     mipi_port_prefix, port) > sizeof(mipi_port_name)) {
> > +		acpi_handle_info(acpi_device_handle(device),
> > +				 "mipi port name too long for port %u\n", port);
> > +		return NULL;
> > +	}
> > +
> > +	return fwnode_get_named_child_node(acpi_fwnode_handle(device),
> > +					   mipi_port_name);
> > +}
> 
> ...
> 
> > +			/* Move polarity bits to the lane polarity u32 array */
> > +			for (i = 0; i < 1 + num_lanes; i++)
> > +				port->lane_polarities[i] =
> > +					(u.val8[i >> 3] & (1 << (i & 7))) ?
> > +					1U : 0U;
> 
> Wouldn't
> 
> 				port->lane_polarities[i] =
> 					!!(u.val8[i >> 3] & (1 << (i & 7)));
> 
> be better?

It would work, yes, although the target is a u32. Casting to bool would
look nicer to me. I lean towards what it is at the moment but bool seems
fairly reasonable, too.

> 
> ...
> 
> > +	ret = software_node_register_node_group(ads->nodeptrs);
> > +	if (ret < 0) {
> > +		acpi_handle_warn(acpi_device_handle(device),
> > +				 "cannot register software nodes (%d)!\n", ret);
> > +		device->swnodes = NULL;
> > +		return;
> > +	}
> 
> > +	device->fwnode.secondary = software_node_fwnode(ads->nodes);
> 
> 	struct fwnode_handle *primary;
> 	...
> 	primary = acpi_fwnode_handle(device);
> 	primary->secondary = ...
> 
> ?
> 
> The point is to avoid direct dereferences of fwnode in struct acpi_device.

Yes.

> 
> 
> ...
> 
> > +static void acpi_free_swnodes(struct acpi_device *device)
> > +{
> > +	struct acpi_device_software_nodes *ads = device->swnodes;
> > +
> > +	if (!ads)
> > +		return;
> > +
> > +	software_node_unregister_node_group(ads->nodeptrs);
> 
> > +	set_secondary_fwnode(&device->dev, NULL);
> 
> Interestingly you are not use same API above. Why?

Good question.

dev->fwnode hasn't been set when assigning the secondary fwnode in
acpi_init_swnodes(), therefore set_secondary_fwnode() won't do what it
should.

It can be still called here as it just sets dev->fwnode->secondary NULL.

I can add a comment mentioning this.

I think it'd be better to have a set of fwnodes attached to a device rather
than one primary and another secondary, with various levels of success
depending on the order of assigning them. But I think it's out of scope of
this set.

> 
> > +	kfree(ads->nodes[ACPI_DEVICE_SWNODE_ROOT].name);
> > +	kfree(ads);
> > +
> > +	device->swnodes = NULL;
> > +}

-- 
Kind regards,

Sakari Ailus
