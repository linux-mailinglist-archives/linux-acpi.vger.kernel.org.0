Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F876673DC8
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jan 2023 16:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjASPpB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 10:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjASPpA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 10:45:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A68282994;
        Thu, 19 Jan 2023 07:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674143099; x=1705679099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/1XTC1IxrpNJFJ3BFs7nKlUVR8AaUXHdeVQOS63rfdE=;
  b=OKuGKXt7dY19G3CHfPsbxEJQYmGC4DfrHlDRUfne7Ej2ba5uP13+4H6b
   SG4i+JRFJVcY0s7gjEm6kQIPaUSQsC1efCW+f/29KMrdjipyuguhu4cv4
   aP8pUQsBlQ7wb6hX4Y6rHAIdil6QLsyNqTSZ1g4BpCi4FAh5qjKk2MTfa
   KxANZ1M6Zth4eC3CZ4t27nmK93o6Fu/ZK8cCsxtf34kFQtitHUUnaAC5t
   G+f9aiib4wooKIjg5j2wiXD6wdn70anytcSgwDKtWpWPdQ/1h+BV35mvX
   rERlqLOXnNvJRxzVIANTWwDD7dWchvDw0hvHyq7VO5H5UaPtqK8hynI+G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326599079"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="326599079"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:44:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="660242357"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="660242357"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2023 07:44:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIX5z-00Bjdt-1P;
        Thu, 19 Jan 2023 17:44:55 +0200
Date:   Thu, 19 Jan 2023 17:44:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 4/8] ACPI: property: Generate camera swnodes for ACPI and
 DisCo for Imaging
Message-ID: <Y8lld1G0qN4qbCUe@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-5-sakari.ailus@linux.intel.com>
 <Y8a3xixlrr4AVBjJ@smile.fi.intel.com>
 <Y8lb1BIh7+4x9hFc@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lb1BIh7+4x9hFc@paasikivi.fi.intel.com>
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

On Thu, Jan 19, 2023 at 03:03:48PM +0000, Sakari Ailus wrote:
> On Tue, Jan 17, 2023 at 04:59:18PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 17, 2023 at 02:22:40PM +0200, Sakari Ailus wrote:

...

> > > +#define GRAPH_PORT_NAME(var, num) \
> > > +	(snprintf((var), sizeof(var), "port@%u", (num)) > sizeof(var))
> > 
> > SWNODE_GRAPH_PORT_NAME_FMT ?
> 
> The name is not used anywhere else. I would keep it as-is.

It repeats the same string literal which is the part of the firmware node graph
representation, right? I think you can rename the above mentioned format macro
and use it in your code. We will reduce the possible deviation and amount of
points of error.

...

> > > +	static const char mipi_port_prefix[] = "mipi-img-port-";
> > 
> > It's harder to read in the code, please put it in place.
> 
> There are multiple uses of it. It's better there's a single definition.

Yes and without this definition one read exact value of the property without
too much brain power, now I need to go first to remember the prefix, then
concatenate it without typo in my brain and think about the result.

...

> > > +			port->ep_props[NEXT_PROPERTY(*ep_prop_index,
> > > +						     EP_DATA_LANES)] =
> > 
> > It's hard to read, taking into account that you split on index of the array.
> > 
> > How much a new monitor costs for you? Maybe I can donate to make you use more
> > than 80 from time to time? :-)
> 
> You know newspaper pages are split into multiple columns for a reason,
> similarly web pages with text columns very seldom span the entire page
> width. The number of characters per line tends to be less than --- you
> might be surprised --- 80. The reason is readability.

Surprisingly to you, the newspaper and the limit is for quick reading the
text. The code differs to the SciFi book, for example. And doesn't have
same requirements. Code has different tokenisation which you break when
splitting in the middle of the token. That's why one line is better than
silly 80 characters limit. It _increases_ readability of the *code*.

> > > +				PROPERTY_ENTRY_U32_ARRAY_LEN("data-lanes",
> > > +							     port->data_lanes,
> > > +							     num_lanes);

Ditto for all other similar cases.

...

> > > +		if (!ret)
> > 
> > Why not positive conditional?
> 
> The success case is handled first.

And in kernel we usually check for error first. Esp. taking into account that
here you have both cases under 'if'.

...

> > > +	if (acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer) != AE_OK) {
> > 
> > We have ACPI_SUCCESS() / ACPI_FAILURE()
> 
> Yes.

Why not using them?

> > > +		acpi_handle_warn(acpi_device_handle(device), "cannot get path name\n");
> > > +		return;
> > > +	}

-- 
With Best Regards,
Andy Shevchenko


