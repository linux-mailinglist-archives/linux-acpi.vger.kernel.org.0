Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE476CC6F1
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 17:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjC1Ppo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjC1Pp1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 11:45:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA2CA5C5;
        Tue, 28 Mar 2023 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680018307; x=1711554307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yjwcvbrE0LatVPMR8h6pQwwZImyW4TofRG3h7cfvXgA=;
  b=XO9jcgd12PsMuK3EHdTDWUy7NZ4clGAMExhxjqIQvFbeQ997EFSCgQAg
   0Vpi4WtRn0r2+N3j2ma/UMqUPxr/fGkn9w3H3MN1dHbjmVX5agyH0jFO0
   s1lVKsaksTGuk3m9RrpF//lC5po34EDmCjzcGWRPHdBCwUcQjrvR6UMdb
   GuWdLiUbc6j/RX7fUBwh28WBRFGrt/RYNFT9j1dBE7IjLc0ziKoeHTnsJ
   aSwLfEHYGdVkv8/Kd7m9jOH37npVCOhajM2JSXM8F1VYBDSpRNB4CgkYi
   xdsqh2iidnS8wuxUaB4gcotTZ9MY6F0NeXE2AvTCa+jXNFbj+qiGTRc76
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="324501561"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="324501561"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="827506050"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="827506050"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2023 08:44:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phBV3-009gDi-0k;
        Tue, 28 Mar 2023 18:44:41 +0300
Date:   Tue, 28 Mar 2023 18:44:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 05/10] ACPI: property: Prepare generating swnodes for
 ACPI and DisCo for Imaging
Message-ID: <ZCMLaKpPrdl6kDIT@smile.fi.intel.com>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-6-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328101303.1458570-6-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 28, 2023 at 01:12:58PM +0300, Sakari Ailus wrote:
> Prepare generating software nodes for information parsed from ACPI _CRS for
> CSI-2 as well as MIPI DisCo for Imaging spec. The software nodes are
> compliant with existing ACPI or DT definitions and are parsed by relevant
> drivers without changes.

...

>  #define NO_CSI2_PORT (UINT_MAX - 1)

Has it been used before this patch?

...

> +/* Print graph port name into a buffer, return non-zero if failed. */
> +#define GRAPH_PORT_NAME(var, num)					    \
> +	(snprintf((var), sizeof(var), SWNODE_GRAPH_PORT_NAME_FMT, (num)) >= \
> +	 sizeof(var))

This macro evaluates sizeof(var) twice. Is it a problem?

...

> +#define NEXT_PROPERTY(index, max)				\
> +	(WARN_ON(++(index) > ACPI_DEVICE_SWNODE_##max + 1) ?	\
> +	 ACPI_DEVICE_SWNODE_##max : (index) - 1)

This macro full of interesting effects. On top of that it's written in
hard-to-read form.

Why not at least

#define NEXT_PROPERTY(index, max)				\
	(WARN_ON((index) > ACPI_DEVICE_SWNODE_##max) ?	\
	 ACPI_DEVICE_SWNODE_##max : (index)++)

?

...

> +	ret = fwnode_property_count_u8(mipi_port_fwnode, "mipi-img-lane-polarities");
> +	if (ret > 0) {
> +		unsigned int bytes = min_t(unsigned int, ret, sizeof(val));
> +
> +		fwnode_property_read_u8_array(mipi_port_fwnode,
> +					      "mipi-img-lane-polarities",
> +					      val, bytes);
> +
> +		/* Total number of lanes here is clock lane + data lanes */
> +		if (bytes * BITS_PER_TYPE(u8) >= 1 + num_lanes) {
> +			unsigned int i;
> +
> +			/* Move polarity bits to the lane polarity u32 array */
> +			for (i = 0; i < 1 + num_lanes; i++)
> +				port->lane_polarities[i] =
> +					(bool)(val[i >> 3] & (1 << (i & 7)));

Casting to bool?!

Can we read the array and convert it to bitmap, then this voodoo-ish code can
be simplified to

	for_each_set_bit(i, ...)
		..._polarities[i] = 1;

(assuming initially they are 0:s)?

> +			port->ep_props[NEXT_PROPERTY(*ep_prop_index, EP_LANE_POLARITIES)] =
> +				PROPERTY_ENTRY_U32_ARRAY_LEN("lane-polarities",
> +							     port->lane_polarities,
> +							     1 + num_lanes);
> +		} else {
> +			acpi_handle_warn(acpi_device_handle(device),
> +					 "too few lane polarity bytes (%u)\n",
> +					 bytes);
> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko


