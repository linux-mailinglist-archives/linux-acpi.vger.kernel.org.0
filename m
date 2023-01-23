Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B9F677F98
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 16:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjAWPZP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 10:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjAWPYq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 10:24:46 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD94228D2B;
        Mon, 23 Jan 2023 07:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674487465; x=1706023465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DRDJqfSjegh3mnRuJBsIdTku5kJeEacaR1GSblr7dDw=;
  b=nyewBIAh/kcZNzFJGPFLnDz3t6hPvA4f7nXN8mEEEwjxXU61DCD9jyxJ
   C0osTr9sSe23u3nlPCdxmmc2IXjNA6uP1sDF85DVHjDOW5a2RCSZmvWHK
   zfhBoa7XAlWOESID4yAjr8AyWV+3aLsgvqTbDs575anC0poibU/WJQwsG
   kepeAtI5oX/989TsT8F60vvro/+SZn0Fs5+cfdOeMX8JEpK/epS4rOw/A
   gu+snGzuASKUSxuiGBz++ja6jPbe05Kod5ue0WgokmIICGl0SDPmTfB7t
   VYGu9Lake8HCmdF8HaqXHgN/96t8ldIn2iIzxO11UDGkis2eS+GdKjjHT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="326098609"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="326098609"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 07:23:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="835562114"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="835562114"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 23 Jan 2023 07:23:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pJyfl-00DncG-2S;
        Mon, 23 Jan 2023 17:23:49 +0200
Date:   Mon, 23 Jan 2023 17:23:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y86mhdQrcWMr58wV@smile.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-5-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123134617.265382-5-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 03:46:13PM +0200, Sakari Ailus wrote:
> Generate software nodes for information parsed from ACPI _CRS for CSI-2 as
> well as MIPI DisCo for Imaging spec. The software nodes are compliant with
> existing ACPI or DT definitions and are parsed by relevant drivers without
> changes.

...

> +static struct acpi_device_software_nodes *
> +crs_csi2_swnode_get(acpi_handle handle)

It's 81 on one line. Why not to join?

> +{
> +	struct crs_csi2_swnodes *swnodes;
> +
> +	list_for_each_entry(swnodes, &crs_csi2_swnodes, list)
> +		if (swnodes->handle == handle)
> +			return swnodes->ads;
> +
> +	return NULL;
> +}

...

> +#define GRAPH_PORT_NAME(var, num)					   \
> +	(snprintf((var), sizeof(var), SWNODE_GRAPH_PORT_NAME_FMT, (num)) > \
> +	 sizeof(var))

>= ?

("excluding the trailing '\0'")

...

> +static struct fwnode_handle *get_mipi_port_handle(struct acpi_device *device,
> +						  unsigned int port)
> +{

> +	static const char mipi_port_prefix[] = "mipi-img-port-";

It's used only once in this function, why not keeping it in the format string?

> +	char mipi_port_name[sizeof(mipi_port_prefix) + 2];
> +
> +	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "%s%u",
> +		     mipi_port_prefix, port) > sizeof(mipi_port_name)) {
> +		acpi_handle_info(acpi_device_handle(device),
> +				 "mipi port name too long for port %u\n", port);
> +		return NULL;
> +	}
> +
> +	return fwnode_get_named_child_node(acpi_fwnode_handle(device),
> +					   mipi_port_name);
> +}

...

> +			/* Move polarity bits to the lane polarity u32 array */
> +			for (i = 0; i < 1 + num_lanes; i++)
> +				port->lane_polarities[i] =
> +					(u.val8[i >> 3] & (1 << (i & 7))) ?
> +					1U : 0U;

Wouldn't

				port->lane_polarities[i] =
					!!(u.val8[i >> 3] & (1 << (i & 7)));

be better?

...

> +	ret = software_node_register_node_group(ads->nodeptrs);
> +	if (ret < 0) {
> +		acpi_handle_warn(acpi_device_handle(device),
> +				 "cannot register software nodes (%d)!\n", ret);
> +		device->swnodes = NULL;
> +		return;
> +	}

> +	device->fwnode.secondary = software_node_fwnode(ads->nodes);

	struct fwnode_handle *primary;
	...
	primary = acpi_fwnode_handle(device);
	primary->secondary = ...

?

The point is to avoid direct dereferences of fwnode in struct acpi_device.


...

> +static void acpi_free_swnodes(struct acpi_device *device)
> +{
> +	struct acpi_device_software_nodes *ads = device->swnodes;
> +
> +	if (!ads)
> +		return;
> +
> +	software_node_unregister_node_group(ads->nodeptrs);

> +	set_secondary_fwnode(&device->dev, NULL);

Interestingly you are not use same API above. Why?

> +	kfree(ads->nodes[ACPI_DEVICE_SWNODE_ROOT].name);
> +	kfree(ads);
> +
> +	device->swnodes = NULL;
> +}

-- 
With Best Regards,
Andy Shevchenko


