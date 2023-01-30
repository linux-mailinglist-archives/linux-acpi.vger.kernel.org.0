Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DC8681C95
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 22:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjA3VWI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 16:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjA3VWH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 16:22:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB1136FD8;
        Mon, 30 Jan 2023 13:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675113726; x=1706649726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bkz7I7V4uOJBEptj1PZg1CbnEqkLHyvvT+7+hty2jUU=;
  b=EkkR1wRAdc+jXsy2IGOReQTSeFJ/fG2iltFW7UvF7XStTveERNkn0PT0
   NiTl2J5QAb/a2ux96Uwyr1VvpPfpIJM1+xk14HX/2AKIcYJM590SDmm2S
   gS+kuix5nKnH5ZETHlv+g66QyULuSAokavIUbEPYfbmxJaz28j8DJXfKz
   iJoFl/dlPMR1bIlnjrGtD2zXKUxVDzhvSR7YXovYz2EAiHO+GDMPP11Cy
   iARu5GAe10QTBDxV1TqFLayY3F2NJtVtavvM/d+EaV0WcWvnvAh2pTwG8
   onij7APzOrnLoKJ1cD1MXvb8yHybNEeFgxdr98tjuZTQSE3j43XvD8K7W
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="327696191"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="327696191"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:22:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="788170348"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="788170348"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:22:04 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 57F841202B0;
        Mon, 30 Jan 2023 23:22:00 +0200 (EET)
Date:   Mon, 30 Jan 2023 23:22:00 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v3 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y9g0+L4zrdBtcpZP@kekkonen.localdomain>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
 <20230125224101.401285-5-sakari.ailus@linux.intel.com>
 <Y9Oo4L0ToRTZye2Z@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Oo4L0ToRTZye2Z@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Fri, Jan 27, 2023 at 12:35:12PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 26, 2023 at 12:40:57AM +0200, Sakari Ailus wrote:
> > Generate software nodes for information parsed from ACPI _CRS for CSI-2 as
> > well as MIPI DisCo for Imaging spec. The software nodes are compliant with
> > existing ACPI or DT definitions and are parsed by relevant drivers without
> > changes.
> 
> ...
> 
> > +static unsigned int next_csi2_port_index(struct acpi_device_software_nodes *ads,
> > +					 unsigned int port_nr)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ads->num_ports; i++) {
> > +		struct acpi_device_software_node_port *port = &ads->ports[i];
> > +
> > +		if (port->port_nr == port_nr)
> > +			return i;
> 
> > +		if (port->port_nr != NO_CSI2_PORT)
> > +			continue;
> > +
> > +		port->port_nr = port_nr;
> > +
> > +		return i;
> 
> Maybe it would be better to use the same pattern as above?
> 
> 		if (port->port_nr == NO_CSI2_PORT) {
> 			port->port_nr = port_nr;
> 			return i;
> 		}

Works for me...

> 
> > +	}
> > +
> > +	return NO_CSI2_PORT;
> > +}
> 
> ...
> 
> > +static struct fwnode_handle *get_mipi_port_handle(struct acpi_device *device,
> > +						  unsigned int port)
> > +{
> > +	static const char mipi_port_prefix[] = "mipi-img-port-";
> > +	char mipi_port_name[sizeof(mipi_port_prefix) + 2];
> 
> I think the following will be better:
> 
> 	char mipi_port_name[16];

If the array is too short, this will generate a warning but... this is
already handled better than that. Why not to keep it?

> 
> 
> > +	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "%s%u",
> > +		     mipi_port_prefix, port) >= sizeof(mipi_port_name)) {
> 
> 	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "mipi-img-port-%u",
> 		     port) >= sizeof(mipi_port_name)) {
> 
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
> > +	union {
> > +		u32 val;
> 
> OK. I stopped here, because I'm not sure you have really sent an updated
> version. For sure the val and union is not used.

Indeed. My apologies --- I missed making a few changes I intended to do.
I'll go through those once more and then send v4.

> 
> > +		/* Data lanes + the clock lane */
> > +		u8 val8[BITS_TO_BYTES(ARRAY_SIZE(port->data_lanes) + 1)];
> > +	} u;

-- 
Kind regards,

Sakari Ailus
