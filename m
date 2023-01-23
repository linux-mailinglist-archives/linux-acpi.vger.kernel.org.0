Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D906D6779EE
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 12:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjAWLP5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 06:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjAWLPx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 06:15:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620E2C173;
        Mon, 23 Jan 2023 03:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674472548; x=1706008548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NOX55dF+ZFRgnsP31/lh7fPCVLV26VLen72klqgd68o=;
  b=IjwtOxyuTSf6+/ZHrKCtlO+B9BaGEeqNZwY6/wJwrAq2+lAzKf0+8TZx
   Pjb9DTO5M/muTyyXXUYlrArLJYIVTK+YYC3U7fpe2652jpCWSXxcyKVkm
   WCPe5sGCaOxpnU17niwEGYFU3MsAZrONhGra4fdqoz+mwHsAx1OXrtwxh
   eZFK2S7PgCjbSBiiMYaKPrB8wnFgao38N2Lw85bzRBZjB25iA7/Y3DiAo
   Mgu6vRFlJYYRaHxYPfPlRej7jmy35e/jckle/bqkV3Rcz92uWsZiGOAgu
   PbpS0RDbieIwrCFxgDYTKBFezw+5p48MACYAfyhStI1miykABnH63FgbD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="388371131"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="388371131"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 03:15:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="693805792"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="693805792"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 03:15:46 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id B762C11F70E;
        Mon, 23 Jan 2023 13:15:43 +0200 (EET)
Date:   Mon, 23 Jan 2023 13:15:43 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 4/8] ACPI: property: Generate camera swnodes for ACPI and
 DisCo for Imaging
Message-ID: <Y85sX/rlWREqFJhv@kekkonen.localdomain>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-5-sakari.ailus@linux.intel.com>
 <Y8a3xixlrr4AVBjJ@smile.fi.intel.com>
 <Y8lb1BIh7+4x9hFc@paasikivi.fi.intel.com>
 <Y8lld1G0qN4qbCUe@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lld1G0qN4qbCUe@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Thu, Jan 19, 2023 at 05:44:55PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 19, 2023 at 03:03:48PM +0000, Sakari Ailus wrote:
> > On Tue, Jan 17, 2023 at 04:59:18PM +0200, Andy Shevchenko wrote:
> > > On Tue, Jan 17, 2023 at 02:22:40PM +0200, Sakari Ailus wrote:
> 
> ...
> 
> > > > +#define GRAPH_PORT_NAME(var, num) \
> > > > +	(snprintf((var), sizeof(var), "port@%u", (num)) > sizeof(var))
> > > 
> > > SWNODE_GRAPH_PORT_NAME_FMT ?
> > 
> > The name is not used anywhere else. I would keep it as-is.
> 
> It repeats the same string literal which is the part of the firmware node graph
> representation, right? I think you can rename the above mentioned format macro
> and use it in your code. We will reduce the possible deviation and amount of
> points of error.

Ah, I thought you had suggested using a new one. Yes, I'll use the existing
macro.

> 
> ...
> 
> > > > +	static const char mipi_port_prefix[] = "mipi-img-port-";
> > > 
> > > It's harder to read in the code, please put it in place.
> > 
> > There are multiple uses of it. It's better there's a single definition.
> 
> Yes and without this definition one read exact value of the property without
> too much brain power, now I need to go first to remember the prefix, then
> concatenate it without typo in my brain and think about the result.

Still having them exactly the same is of utmost importance and a common
definition reliably achieves that. What the string actually is is of
secondary importance.

> 
> ...
> 
> > > > +			port->ep_props[NEXT_PROPERTY(*ep_prop_index,
> > > > +						     EP_DATA_LANES)] =
> > > 
> > > It's hard to read, taking into account that you split on index of the array.
> > > 
> > > How much a new monitor costs for you? Maybe I can donate to make you use more
> > > than 80 from time to time? :-)
> > 
> > You know newspaper pages are split into multiple columns for a reason,
> > similarly web pages with text columns very seldom span the entire page
> > width. The number of characters per line tends to be less than --- you
> > might be surprised --- 80. The reason is readability.
> 
> Surprisingly to you, the newspaper and the limit is for quick reading the
> text. The code differs to the SciFi book, for example. And doesn't have
> same requirements. Code has different tokenisation which you break when
> splitting in the middle of the token. That's why one line is better than
> silly 80 characters limit. It _increases_ readability of the *code*.

I disagree. Do you know if studies have been made on the topic?

I can make some a little longer if that makes you happy (depending on other
comments, too), but I won't make the lines e.g.  200 characters long.

> 
> > > > +				PROPERTY_ENTRY_U32_ARRAY_LEN("data-lanes",
> > > > +							     port->data_lanes,
> > > > +							     num_lanes);
> 
> Ditto for all other similar cases.
> 
> ...
> 
> > > > +		if (!ret)
> > > 
> > > Why not positive conditional?
> > 
> > The success case is handled first.
> 
> And in kernel we usually check for error first. Esp. taking into account that
> here you have both cases under 'if'.

The other assignments take place just before this, so it's closer to them. I
can change this though.

> 
> ...
> 
> > > > +	if (acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer) != AE_OK) {
> > > 
> > > We have ACPI_SUCCESS() / ACPI_FAILURE()
> > 
> > Yes.
> 
> Why not using them?

Yes, in v2.

> 
> > > > +		acpi_handle_warn(acpi_device_handle(device), "cannot get path name\n");
> > > > +		return;
> > > > +	}

-- 
Kind regards,

Sakari Ailus
