Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480402E6994
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Dec 2020 18:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbgL1RNq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 12:13:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:39164 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbgL1RNq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Dec 2020 12:13:46 -0500
IronPort-SDR: /ipTn7WxUzfZ7KB3b34w2ZrR2SJRkHL7qcWSRiVvsIg6p5SKtsAPpk/YXHCOFKPCWjJ6HIu5rb
 ocFyhZnTDKRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="175629613"
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="175629613"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 09:11:59 -0800
IronPort-SDR: WRVGj2qDss7KfMJ1w2COGNtnoiCeMZJ8qQMLYX8Zeind3Nsq0w4uWCqowMOtQ2q0YQBOmWhShy
 a768qvpekwxg==
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="375717721"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 09:11:52 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id EA1F9207BF; Mon, 28 Dec 2020 19:11:50 +0200 (EET)
Date:   Mon, 28 Dec 2020 19:11:50 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
Subject: Re: [PATCH v3 06/14] include: fwnode.h: Define format macros for
 ports and endpoints
Message-ID: <20201228171150.GA26370@paasikivi.fi.intel.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-7-djrscally@gmail.com>
 <20201228163024.GW26370@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228163024.GW26370@paasikivi.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 28, 2020 at 06:30:24PM +0200, Sakari Ailus wrote:
> Hi Daniel, Andy,
> 
> On Thu, Dec 24, 2020 at 01:08:59AM +0000, Daniel Scally wrote:
> > OF, ACPI and software_nodes all implement graphs including nodes for ports
> > and endpoints. These are all intended to be named with a common schema,
> > as "port@n" and "endpoint@n" where n is an unsigned int representing the
> > index of the node. To ensure commonality across the subsystems, provide a
> > set of macros to define the format.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Daniel Scally <djrscally@gmail.com>
> > ---
> > Changes in v3
> > 	- Patch introduced
> > 
> >  include/linux/fwnode.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > index 9506f8ec0974..52889efceb7d 100644
> > --- a/include/linux/fwnode.h
> > +++ b/include/linux/fwnode.h
> > @@ -32,6 +32,19 @@ struct fwnode_endpoint {
> >  	const struct fwnode_handle *local_fwnode;
> >  };
> >  
> > +/*
> > + * ports and endpoints defined in OF, ACPI and as software_nodes should all
> > + * follow a common naming scheme; use these macros to ensure commonality across
> > + * the subsystems.
> > + *
> > + * The *PREFIX_LEN macros refer to the length of the "port@" and "endpoint@"
> > + * sections of the naming scheme.
> > + */
> > +#define FWNODE_GRAPH_PORT_NAME_FORMAT		"port@%u"
> > +#define FWNODE_GRAPH_PORT_NAME_PREFIX_LEN	5
> > +#define FWNODE_GRAPH_ENDPOINT_NAME_FORMAT	"endpoint@%u"
> > +#define FWNODE_GRAPH_ENDPOINT_PREFIX_LEN	9
> > +
> >  #define NR_FWNODE_REFERENCE_ARGS	8
> 
> I'd keep such definitions local to the swnode implementation as neither
> ACPI nor DT have an apparent need for them. They do use the naming, but
> don't appear to format such strings.

Ah, I noticed these are used by the later patches. Please ignore that
comment then.

But these are still definitions, so I'd use SWNODE prefix rather than
FWNODE. That should also be reflected in the comment.

ACPI does not have a format port concept so the definitions that are being
used can be said to be specific to Linux.

-- 
Kind regards,

Sakari Ailus
