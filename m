Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ABC673D03
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jan 2023 16:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjASPFY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 10:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjASPFL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 10:05:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809EC3D939;
        Thu, 19 Jan 2023 07:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674140709; x=1705676709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+/O9o3aiPQB5lPqPPuURHYG6nM0Q+9YhwVmnwbM/g4k=;
  b=isjHNJD6k6d8IdNaitL2fiNalbuddDr0JldgRgfYTZ0TIBmGakgaQ+1P
   XddASxgIIi+ct+j5kyilMkOmXDOvxB74V6MIpUobbKgPrXKki3zHa50fP
   Z5cbokh4UNYMvp9I0sOtbgU/cFbYXmX+ybPsvNw6BgPI28H3HlWphq6Za
   dmEfpqQwMx4OKmK1buGaYgBJTgxfYQPnHLMST5Mn8VdehwCpNH6I1y1tt
   isB+9lQ1kS05Mv1ZcpIo97mNY/wY4VmecPVsvgK+xdz5yGkMgrZVse2mo
   X/IfJPQwQCkMiFJrDx9Tlm0isDuDFvWZ5VOox3EerciMH7mHGWhvxgMkp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305674808"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="305674808"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:03:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="660235541"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="660235541"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:03:50 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 8A150203C4;
        Thu, 19 Jan 2023 17:03:48 +0200 (EET)
Date:   Thu, 19 Jan 2023 15:03:48 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 4/8] ACPI: property: Generate camera swnodes for ACPI and
 DisCo for Imaging
Message-ID: <Y8lb1BIh7+4x9hFc@paasikivi.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-5-sakari.ailus@linux.intel.com>
 <Y8a3xixlrr4AVBjJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8a3xixlrr4AVBjJ@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Tue, Jan 17, 2023 at 04:59:18PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 02:22:40PM +0200, Sakari Ailus wrote:
> > Generate software nodes for information parsed from ACPI _CRS for CSI-2 as
> > well as MIPI DisCo for Imaging spec. The software nodes are compliant with
> > existing ACPI or DT definitions and are parsed by relevant drivers without
> > changes.
> 
> ...
> 
> > +#define GRAPH_PORT_NAME(var, num) \
> > +	(snprintf((var), sizeof(var), "port@%u", (num)) > sizeof(var))
> 
> SWNODE_GRAPH_PORT_NAME_FMT ?

The name is not used anywhere else. I would keep it as-is.

> 
> ...
> 
> > +#define NEXT_PROPERTY(index, max)			   \
> > +	(WARN_ON(++(index) > ACPI_DEVICE_SWNODE_##max + 1) ?	\
> 
> '>' -- > '>=' and drop ' + 1'?

Yeah.

> 
> > +	 ACPI_DEVICE_SWNODE_##max : (index) - 1)
> 
> ...
> 
> > +	static const char mipi_port_prefix[] = "mipi-img-port-";
> 
> It's harder to read in the code, please put it in place.

There are multiple uses of it. It's better there's a single definition.

> 
> ...
> 
> > +			port->ep_props[NEXT_PROPERTY(*ep_prop_index,
> > +						     EP_DATA_LANES)] =
> 
> It's hard to read, taking into account that you split on index of the array.
> 
> How much a new monitor costs for you? Maybe I can donate to make you use more
> than 80 from time to time? :-)

You know newspaper pages are split into multiple columns for a reason,
similarly web pages with text columns very seldom span the entire page
width. The number of characters per line tends to be less than --- you
might be surprised --- 80. The reason is readability.

> 
> > +				PROPERTY_ENTRY_U32_ARRAY_LEN("data-lanes",
> > +							     port->data_lanes,
> > +							     num_lanes);
> 
> ...
> 
> 
> > +	ret = fwnode_property_read_u8_array(mipi_port_fwnode,
> > +					    "mipi-img-lane-polarities",
> > +					    u.val8, sizeof(u.val8));
> > +	if (ret > 0) {
> > +		unsigned int bytes = ret;
> > +
> > +		/* Total number of lanes here is clock lane + data lanes */
> > +		if (bytes << 3 >= 1 + num_lanes) {
> 
> bytes * BITS_PER_BYTE? Or if you want to be super precise BITS_PER_TYPE(u8).

I think of these two, BITS_PER_TYPE(u8) looks better.

> 
> > +			unsigned int i;
> > +
> > +			/* Move polarity bits to the lane polarity u32 array */
> > +			for (i = 0; i < 1 + num_lanes; i++)
> > +				port->lane_polarities[i] =
> > +					(u.val8[i >> 3] & (1 << (i & 7))) ?
> > +					1U : 0U;
> 
> > +			port->ep_props[NEXT_PROPERTY(*ep_prop_index,
> > +						     EP_LANE_POLARITIES)] =
> 
> Index on one line?
> 
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
> ...
> 
> > +	unsigned int port_index = next_csi2_port_index(device->swnodes,
> > +						       port_nr);
> 
> One line easier to read.
> 
> ...
> 
> > +		if (!ret)
> 
> Why not positive conditional?

The success case is handled first.

> Also seems like {} are missing since the body is multi-line.

Multiple lines as such isn't a reason to add braces (per coding style).

> 
> > +			port->ep_props[NEXT_PROPERTY(ep_prop_index,
> > +						     EP_LINK_FREQUENCIES)] =
> 
> Index on one line?

This is more or less random.

> 
> > +				PROPERTY_ENTRY_U64_ARRAY_LEN("link-frequencies",
> > +							     port->link_frequencies,
> > +							     num_link_freqs);
> > +		else
> > +			acpi_handle_info(acpi_device_handle(device),
> > +					 "can't get link frequencies (%d)\n",
> > +					 ret);
> 
> ...
> 
> > +	if (acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer) != AE_OK) {
> 
> We have ACPI_SUCCESS() / ACPI_FAILURE()

Yes.

> 
> > +		acpi_handle_warn(acpi_device_handle(device), "cannot get path name\n");
> > +		return;
> > +	}
> 
> ...
> 
> > +	ads->nodes[ACPI_DEVICE_SWNODE_ROOT] = (struct software_node) {
> > +		.name = buffer.pointer,
> > +		.properties = ads->dev_props,
> > +	};
> 
> Aren't you provided a macro for this?

I think I added a macro for this but forgot to use it. I'll address this
(and other issues) in v2.

-- 
Regards,

Sakari Ailus
