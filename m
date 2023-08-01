Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445A876BDEC
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Aug 2023 21:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjHATjX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Aug 2023 15:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjHATjW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2023 15:39:22 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992B91BF1;
        Tue,  1 Aug 2023 12:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690918759; x=1722454759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oa6jUYKUJk4xKUInJM8nAus+RSs4y5jHWcsddX766Yg=;
  b=VJzPBS0UJCH8Brf9Y3XSw38kjbdLeCtO/RSit8IM9wgFyOQtT4RvLx0G
   Oxx2p6yfMLZRnI8G/Mci+VgJHqBFdJmfxFcV5JO7MFm90+HVoP6SnvI3Q
   XWt7CpKFfzxhwRS9Q+ABUVA0zlbDq0ig1r3PYP6//kVKXJjqCjONrMoci
   HvPxQYJ9LtdHj/bLkZWOorcOnqXLpMIM1ZhGonY9ZREi4QbA4R3v7q2n4
   QI+0s++FVFk89NP1AqjVAnIT3CuTc6cGpRSI+Chv3dg9w0CuB/g/gaYxa
   xJmeOZ40ryi5R4DDCDGsMQn8iUuIw8CCsVnRyS8fR2YbFXwVWU+MHMsPp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="373038043"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="373038043"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 12:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="798793810"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="798793810"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2023 12:39:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qQvD7-00Gxg7-1t;
        Tue, 01 Aug 2023 22:39:13 +0300
Date:   Tue, 1 Aug 2023 22:39:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] drivers: fwnode: Extend device_get_match_data()
 to struct bus_type
Message-ID: <ZMlfYU3rOQle0VuH@smile.fi.intel.com>
References: <20230801170318.82682-1-biju.das.jz@bp.renesas.com>
 <20230801170318.82682-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801170318.82682-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 01, 2023 at 06:03:17PM +0100, Biju Das wrote:
> Extend device_get_match_data() to buses (for eg: I2C) by adding a
> callback device_get_match_data() to struct bus_type() and call this method
> as a fallback for generic fwnode based device_get_match_data().

Because of anticipation of v4, see one additional comment below.

...

> +/**
> + * device_get_match_data - get match data from OF/ACPI/Bus match tables
> + * @dev: device to find the match data
> + *
> + * Find match data using generic fwnode-based lookup and if there is no
> + * match, call the bus->get_match_data() for finding match data.
> + *
> + * Return: a match data pointer or NULL if there is no match in the matching
> + * table.

Also add a note for the corner case.

"""
 *
 * Besides the fact that some drivers abuse the device ID driver_data type
 * and claim it to be integer, for the bus specific ID tables the driver_data
 * may be defined as kernel_ulong_t. For these tables 0 is a valid response,
 * but not for this function. It's recommended to covert those either to avoid
 * 0 or use a real pointer to the predefined driver data.
"""

> + */

-- 
With Best Regards,
Andy Shevchenko


