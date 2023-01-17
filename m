Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD7E66E18A
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 16:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjAQPBq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 10:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjAQPBR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 10:01:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6E03EFDD;
        Tue, 17 Jan 2023 06:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673967563; x=1705503563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fsn12zU4AWkY70iJC06FOS0sZRnrY0FwapJncIYxE6A=;
  b=Kfp/pZ+t0LSvpyF3yw64dj5sGjK2vELhrNnaQhd014m1o/++RgYQPH+U
   FEu/tga5J/MVT3Uyd/fKLxAOWKSUCLFsVGy7Fxq5Gyf4z5bKB0InxXgr+
   KQweI2jFxFeyg9V4qFj9+Gb7cMHipGlpnSQNpwMNSE33bTDPahGE5Loa3
   D5TFnoPPakI/zxqXSHazoj91GAQluDbKJYCfIH/UuKCPZ7JhHmRoi+7B8
   KiJkR0oqSYCJ9z/SztYsoFnt6Oi9B6RZVN793aSskBI6gD5O3MZUk9Ym4
   MZhK+ga1V8FZz5iPEzhC8lPcU8QVOJw3bVwbYDBqalDOQzBttVfFYluqV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="389211457"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="389211457"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 06:59:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="727808338"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="727808338"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jan 2023 06:59:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHnQk-00Acku-2v;
        Tue, 17 Jan 2023 16:59:18 +0200
Date:   Tue, 17 Jan 2023 16:59:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 4/8] ACPI: property: Generate camera swnodes for ACPI and
 DisCo for Imaging
Message-ID: <Y8a3xixlrr4AVBjJ@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-5-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117122244.2546597-5-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 17, 2023 at 02:22:40PM +0200, Sakari Ailus wrote:
> Generate software nodes for information parsed from ACPI _CRS for CSI-2 as
> well as MIPI DisCo for Imaging spec. The software nodes are compliant with
> existing ACPI or DT definitions and are parsed by relevant drivers without
> changes.

...

> +#define GRAPH_PORT_NAME(var, num) \
> +	(snprintf((var), sizeof(var), "port@%u", (num)) > sizeof(var))

SWNODE_GRAPH_PORT_NAME_FMT ?

...

> +#define NEXT_PROPERTY(index, max)			   \
> +	(WARN_ON(++(index) > ACPI_DEVICE_SWNODE_##max + 1) ?	\

'>' -- > '>=' and drop ' + 1'?

> +	 ACPI_DEVICE_SWNODE_##max : (index) - 1)

...

> +	static const char mipi_port_prefix[] = "mipi-img-port-";

It's harder to read in the code, please put it in place.

...

> +			port->ep_props[NEXT_PROPERTY(*ep_prop_index,
> +						     EP_DATA_LANES)] =

It's hard to read, taking into account that you split on index of the array.

How much a new monitor costs for you? Maybe I can donate to make you use more
than 80 from time to time? :-)

> +				PROPERTY_ENTRY_U32_ARRAY_LEN("data-lanes",
> +							     port->data_lanes,
> +							     num_lanes);

...


> +	ret = fwnode_property_read_u8_array(mipi_port_fwnode,
> +					    "mipi-img-lane-polarities",
> +					    u.val8, sizeof(u.val8));
> +	if (ret > 0) {
> +		unsigned int bytes = ret;
> +
> +		/* Total number of lanes here is clock lane + data lanes */
> +		if (bytes << 3 >= 1 + num_lanes) {

bytes * BITS_PER_BYTE? Or if you want to be super precise BITS_PER_TYPE(u8).

> +			unsigned int i;
> +
> +			/* Move polarity bits to the lane polarity u32 array */
> +			for (i = 0; i < 1 + num_lanes; i++)
> +				port->lane_polarities[i] =
> +					(u.val8[i >> 3] & (1 << (i & 7))) ?
> +					1U : 0U;

> +			port->ep_props[NEXT_PROPERTY(*ep_prop_index,
> +						     EP_LANE_POLARITIES)] =

Index on one line?

> +				PROPERTY_ENTRY_U32_ARRAY_LEN("lane-polarities",
> +							     port->lane_polarities,
> +							     1 + num_lanes);
> +		} else {
> +			acpi_handle_warn(acpi_device_handle(device),
> +					 "too few lane polarity bytes (%u)\n",
> +					 bytes);
> +		}
> +	}

...

> +	unsigned int port_index = next_csi2_port_index(device->swnodes,
> +						       port_nr);

One line easier to read.

...

> +		if (!ret)

Why not positive conditional?
Also seems like {} are missing since the body is multi-line.

> +			port->ep_props[NEXT_PROPERTY(ep_prop_index,
> +						     EP_LINK_FREQUENCIES)] =

Index on one line?

> +				PROPERTY_ENTRY_U64_ARRAY_LEN("link-frequencies",
> +							     port->link_frequencies,
> +							     num_link_freqs);
> +		else
> +			acpi_handle_info(acpi_device_handle(device),
> +					 "can't get link frequencies (%d)\n",
> +					 ret);

...

> +	if (acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer) != AE_OK) {

We have ACPI_SUCCESS() / ACPI_FAILURE()

> +		acpi_handle_warn(acpi_device_handle(device), "cannot get path name\n");
> +		return;
> +	}

...

> +	ads->nodes[ACPI_DEVICE_SWNODE_ROOT] = (struct software_node) {
> +		.name = buffer.pointer,
> +		.properties = ads->dev_props,
> +	};

Aren't you provided a macro for this?

-- 
With Best Regards,
Andy Shevchenko


