Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BA367AD0D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 09:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjAYI5N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 03:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjAYI5I (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 03:57:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D51E2FCFF;
        Wed, 25 Jan 2023 00:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674637008; x=1706173008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mn2i7e06MCggHhYXwnswA9N22qy6vuuPEAqt7YRysfs=;
  b=QX0omS0u6ujvwH2uHaTu8fk00LiPYJ6Q2MOixtpiMJIF+iPZUFSDzFk9
   xsnqLBt2eOQFPY8vzi/DuCgU4JQx7PaYQdh4AYMbYlDq/JFXpnT1HNxs4
   t8SwqyUx2BWc+BNl+gWayBrr7cOBYd4YB45YkpEn6Bq5PeEqyG3TbDVFx
   NNWyO7b5iwPeFAstfMDisCNgK1+2Rbpd+fnhmiZUX3kXArFkKdZB0dvfK
   ydU70ktGt82c5KDsslGedbWEAmehV6aXzjyfCgP9ZEeOCDVLkjqnKFstV
   vt2D4NCkUH4nm/rF5YlGlRz1pQJSTTy3jAe1nH7U7vrjCgFbtCriPjuiN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="328596969"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="328596969"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 00:56:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="770649630"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="770649630"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 00:56:46 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 4A94F120C31;
        Wed, 25 Jan 2023 10:56:41 +0200 (EET)
Date:   Wed, 25 Jan 2023 10:56:41 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y9DuyZUr3McCPGuh@kekkonen.localdomain>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-5-sakari.ailus@linux.intel.com>
 <Y9Aw5/mSYEadHRKK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Aw5/mSYEadHRKK@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Tue, Jan 24, 2023 at 09:26:31PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 23, 2023 at 03:46:13PM +0200, Sakari Ailus wrote:
> 
> As promised the idea of bitmap APIs.
> 
> Also I have stumbled over couple of suspicious places. See below.
> 
> ...
> 
> > +static void init_port_csi2_common(struct acpi_device *device,
> > +				  struct fwnode_handle *mipi_port_fwnode,
> > +				  unsigned int *ep_prop_index,
> > +				  unsigned int port_nr)
> > +{
> > +	unsigned int port_index = next_csi2_port_index(device->swnodes, port_nr);
> > +	struct acpi_device_software_nodes *ads = device->swnodes;
> > +	struct acpi_device_software_node_port *port = &ads->ports[port_index];
> > +	unsigned int num_lanes = 0;
> > +	union {
> > +		u32 val;
> 
> // Not sure why this even exists.
> // And hence why do we need union?

We could remove the union, yes, with one more u32 of stack used.

> 
> > +		/* Data lanes + the clock lane */
> > +		u8 val8[BITS_TO_BYTES(ARRAY_SIZE(port->data_lanes) + 1)];
> > +	} u;
> 
> Somewhere
> 
> #define MAX_LANES(port)		(ARRAY_SIZE((port)->data_lanes) + 1)
> 
> 	u8 val8[BITS_TO_BYTES(MAX_LANES(port))];
> 
> ...
> 
> 	/* Data lanes + the clock lane */
> 	DECLARE_BITMAP(polarity, MAX_LANES(port)));
> 
> > +	int ret;
> > +
> > +	*ep_prop_index = ACPI_DEVICE_SWNODE_EP_CLOCK_LANES;
> > +
> > +	if (GRAPH_PORT_NAME(port->port_name, port_nr))
> > +		return;
> > +
> > +	ads->nodes[ACPI_DEVICE_SWNODE_PRT(port_index)] =
> > +		SOFTWARE_NODE(port->port_name, port->port_props,
> > +			      &ads->nodes[ACPI_DEVICE_SWNODE_ROOT]);
> > +
> > +	ret = fwnode_property_read_u8(mipi_port_fwnode, "mipi-img-clock-lane", u.val8);
> > +	if (!ret) {
> > +		port->ep_props[NEXT_PROPERTY(*ep_prop_index, EP_CLOCK_LANES)] =
> > +			PROPERTY_ENTRY_U32("clock-lanes", *u.val8);
> > +	}
> 
> > +	ret = fwnode_property_count_u8(mipi_port_fwnode, "mipi-img-data-lanes");
> > +	if (ret > 0) {
> > +		num_lanes = ret;
> > +
> > +		if (num_lanes > ARRAY_SIZE(port->data_lanes)) {
> 
> 		>= MAX_LANES(port)

I find the original better: it does this by referring to the array itself.

> 
> > +			acpi_handle_warn(acpi_device_handle(device),
> > +					 "too many data lanes (%u)\n",
> > +					 num_lanes);
> > +			num_lanes = ARRAY_SIZE(port->data_lanes);
> 
> 			= MAX_LANES(port) - 1;
> 
> > +		}
> > +
> > +		ret = fwnode_property_read_u8_array(mipi_port_fwnode, "mipi-img-data-lanes",
> > +						    u.val8, num_lanes);
> 
> > +		if (!ret) {
> > +			unsigned int i;
> > +
> > +			for (i = 0; i < num_lanes; i++)
> > +				port->data_lanes[i] = u.val8[i];
> > +
> > +			port->ep_props[NEXT_PROPERTY(*ep_prop_index, EP_DATA_LANES)] =
> > +				PROPERTY_ENTRY_U32_ARRAY_LEN("data-lanes", port->data_lanes,
> > +							     num_lanes);
> > +		}
> > +	}
> 
> > +	ret = fwnode_property_read_u8_array(mipi_port_fwnode,
> > +					    "mipi-img-lane-polarities",
> > +					    u.val8, sizeof(u.val8));
> > +	if (ret > 0) {
> 
> How is it supposed to work?!

Hmm. I think in the past, some of these functions have returned the number
of the entries even when the buffer is provided
(acpi_copy_property_array_string() still does!). Good catch, I'll fix this
for v3.

> 
> > +		unsigned int bytes = ret;
> > +
> > +		/* Total number of lanes here is clock lane + data lanes */
> > +		if (bytes * BITS_PER_TYPE(u8) >= 1 + num_lanes) {
> > +			unsigned int i;
> > +
> > +			/* Move polarity bits to the lane polarity u32 array */
> > +			for (i = 0; i < 1 + num_lanes; i++)
> > +				port->lane_polarities[i] =
> > +					(u.val8[i >> 3] & (1 << (i & 7))) ?
> > +					1U : 0U;
> > +
> > +			port->ep_props[NEXT_PROPERTY(*ep_prop_index, EP_LANE_POLARITIES)] =
> > +				PROPERTY_ENTRY_U32_ARRAY_LEN("lane-polarities",
> > +							     port->lane_polarities,
> > +							     1 + num_lanes);
> > +		} else {
> > +			acpi_handle_warn(acpi_device_handle(device),
> > +					 "too few lane polarity bytes (%u)\n",
> > +					 bytes);
> > +		}
> > +	}
> 
> 	ret = fwnode_property_count_u8(mipi_port_fwnode, "mipi-img-dlane-polarities");
> 	if (ret < 0) {
> 		acpi_handle_debug(acpi_device_handle(device),
> 				  "no lane polarity provided\n");
> 	} else if (ret < 1 + num_lanes) {
> 		acpi_handle_warn(acpi_device_handle(device),
> 				 "too few lane polarity bytes (%u)\n", bytes);
> 	} else {
> 		// assuming we dropped the union and renamed to val...
> 		ret = fwnode_property_read_u8_array(mipi_port_fwnode,
> 						    "mipi-img-lane-polarities",
> 						    val, sizeof(val));
> 		if (ret) {
> 			...can't read... (debug message?)
> 		} else {
> 			unsigned int i;
> 
> 			for (i = 0; i < 1 + num_lanes; i++)
> 				bitmap_set_value8(polarity, val[i], i * BITS_PER_BYTE);

You'll still needed to access invididual bits in val.

> 
> 			// assuming that lane_polarities is zeroed by default...
> 			for_each_set_bit(i, polarity, 1 + num_lanes)
> 				port->lane_polarities[i] = 1;
> 		}
> 	}
> 
> > +	ads->nodes[ACPI_DEVICE_SWNODE_EP(port_index)] =
> > +		SOFTWARE_NODE("endpoint@0", ads->ports[port_index].ep_props,
> > +			      &ads->nodes[ACPI_DEVICE_SWNODE_PRT(port_index)]);
> > +}

-- 
Kind regards,

Sakari Ailus
