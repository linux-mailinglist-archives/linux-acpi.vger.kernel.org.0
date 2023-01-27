Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D28567E1B9
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jan 2023 11:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjA0Kf0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Jan 2023 05:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjA0KfV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jan 2023 05:35:21 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F1783DB;
        Fri, 27 Jan 2023 02:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674815716; x=1706351716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PuhCw8UDUx1Zk7kLhlDdcgYsdjEiqfMPtf2H+4bRJRk=;
  b=mDltvMGscbyBIZlIC9IQIAHFE/younfPtpscYEfTerPOfMny7CR3wYXw
   0muEUp5ayQ1VpZnuoK3FXjYfGIb8MDcKW3SSeqKcE6b53sDtavbVIgXcM
   PXUymTJQO3VbOlcjb3QcusC170rlSxljrXD8fyyRAHMvrLLVnkGId8uaU
   r8vQaIu1u88cefyOFnr4zDXpx9MKqLPK0mAtChK6a0JiDuafgWdEoAf0G
   UwvpOYdaf+QhTxkw521JBs1ROe+jzdchG+QY/8LUVWaFR2diZb7uNlBhf
   f56LhB6UQN1oHLJjROUhHJKkUcfZh9K9ZLuSt4SloTjQBpifDElhUURe6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="315013621"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="315013621"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 02:35:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="805756714"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="805756714"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2023 02:35:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLM4f-00FuvU-0S;
        Fri, 27 Jan 2023 12:35:13 +0200
Date:   Fri, 27 Jan 2023 12:35:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v3 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y9Oo4L0ToRTZye2Z@smile.fi.intel.com>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
 <20230125224101.401285-5-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125224101.401285-5-sakari.ailus@linux.intel.com>
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

On Thu, Jan 26, 2023 at 12:40:57AM +0200, Sakari Ailus wrote:
> Generate software nodes for information parsed from ACPI _CRS for CSI-2 as
> well as MIPI DisCo for Imaging spec. The software nodes are compliant with
> existing ACPI or DT definitions and are parsed by relevant drivers without
> changes.

...

> +static unsigned int next_csi2_port_index(struct acpi_device_software_nodes *ads,
> +					 unsigned int port_nr)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ads->num_ports; i++) {
> +		struct acpi_device_software_node_port *port = &ads->ports[i];
> +
> +		if (port->port_nr == port_nr)
> +			return i;

> +		if (port->port_nr != NO_CSI2_PORT)
> +			continue;
> +
> +		port->port_nr = port_nr;
> +
> +		return i;

Maybe it would be better to use the same pattern as above?

		if (port->port_nr == NO_CSI2_PORT) {
			port->port_nr = port_nr;
			return i;
		}

> +	}
> +
> +	return NO_CSI2_PORT;
> +}

...

> +static struct fwnode_handle *get_mipi_port_handle(struct acpi_device *device,
> +						  unsigned int port)
> +{
> +	static const char mipi_port_prefix[] = "mipi-img-port-";
> +	char mipi_port_name[sizeof(mipi_port_prefix) + 2];

I think the following will be better:

	char mipi_port_name[16];


> +	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "%s%u",
> +		     mipi_port_prefix, port) >= sizeof(mipi_port_name)) {

	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "mipi-img-port-%u",
		     port) >= sizeof(mipi_port_name)) {

> +		acpi_handle_info(acpi_device_handle(device),
> +				 "mipi port name too long for port %u\n", port);
> +		return NULL;
> +	}
> +
> +	return fwnode_get_named_child_node(acpi_fwnode_handle(device),
> +					   mipi_port_name);
> +}

...

> +	union {
> +		u32 val;

OK. I stopped here, because I'm not sure you have really sent an updated
version. For sure the val and union is not used.

> +		/* Data lanes + the clock lane */
> +		u8 val8[BITS_TO_BYTES(ARRAY_SIZE(port->data_lanes) + 1)];
> +	} u;

...

Please, address all in v3.

-- 
With Best Regards,
Andy Shevchenko


