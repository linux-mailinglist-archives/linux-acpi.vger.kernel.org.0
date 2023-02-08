Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CF168F3BC
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 17:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjBHQsc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 11:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjBHQsb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 11:48:31 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA7B38B54;
        Wed,  8 Feb 2023 08:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675874910; x=1707410910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iAT8utTiIaXePI/jAL0XlWt15gjsT+05OQqvXfOnHKw=;
  b=eITwp2z8ERy3RR6ly/X+Q7/Yb94OTjLr67FvUjGSZsfv3l2BKvdADVNf
   qcSIZrfeL/vOyjr6ou4oaxW2QxMzQ6ikJtZmy0LAOHAJr/0hhC99s9eb+
   jIYyzH0fA6Ku2p5WhHXyosmXNe2x7dyNJkLl3M0TwUfs6c2ngh0WeNzkZ
   ssL6wBKgzc3gGdBdji0VDzjulVJCr2XuYk5viR30NCNh91O9SEyKVceTb
   p3LmJJ//GwBWtevyJMjL9ucJFAikdy4msan0DniEVkf+RiY2zqTLjoHSz
   5xZWT7C9lw7gUCI9uB8TeeSzfJyzjP7W9ksuj9UOJbQg1lVXncHXI+Bqs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="317857654"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="317857654"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 08:48:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="841252684"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="841252684"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2023 08:48:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pPncI-004DO5-1r;
        Wed, 08 Feb 2023 18:48:18 +0200
Date:   Wed, 8 Feb 2023 18:48:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v4 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y+PSUoixdFoCWcSC@smile.fi.intel.com>
References: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
 <20230208152807.3064242-5-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208152807.3064242-5-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 08, 2023 at 05:28:03PM +0200, Sakari Ailus wrote:
> Generate software nodes for information parsed from ACPI _CRS for CSI-2 as
> well as MIPI DisCo for Imaging spec. The software nodes are compliant with
> existing ACPI or DT definitions and are parsed by relevant drivers without
> changes.

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
> +
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

I still think this will be better with bitmap APIs in use, but I leave it to
maintainers and you to decide.


-- 
With Best Regards,
Andy Shevchenko


