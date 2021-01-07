Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEFC2ED16C
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 15:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbhAGOIL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 09:08:11 -0500
Received: from mga07.intel.com ([134.134.136.100]:46388 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728529AbhAGOIL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 09:08:11 -0500
IronPort-SDR: 88LSNi42vGwL7ir9aUzE2z5flLwB43ubn+pUOseoMIxCBcIoQnoJOVxxbKbcnwVG+4/4WjqAN5
 StJjZo5t5bJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="241502326"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="241502326"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 06:06:24 -0800
IronPort-SDR: 9q7t1qlZZhy66zoq1IlpRL0T3OXxLg5r5F4/TNkqbN4LRr66Ehf65cC4JsOXkNr3rkpSJHbVXb
 nvvGJvLdzOFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="463045039"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jan 2021 06:06:18 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 07 Jan 2021 16:06:17 +0200
Date:   Thu, 7 Jan 2021 16:06:17 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, mchehab@kernel.org,
        sergey.senozhatsky@gmail.com, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 07/15] device property: Define format macros for ports
 and endpoints
Message-ID: <20210107140617.GG940479@kuha.fi.intel.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-8-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-8-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 07, 2021 at 01:28:30PM +0000, Daniel Scally wrote:
> OF, ACPI and software_nodes all implement graphs including nodes for ports
> and endpoints. These are all intended to be named with a common schema,
> as "port@n" and "endpoint@n" where n is an unsigned int representing the
> index of the node. To ensure commonality across the subsystems, provide a
> set of macros to define the format.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v5:
> 
> 	- Changed commit subject
> 
>  include/linux/fwnode.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index fde4ad97564c..77414e431e89 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -50,6 +50,13 @@ struct fwnode_endpoint {
>  	const struct fwnode_handle *local_fwnode;
>  };
>  
> +/*
> + * ports and endpoints defined as software_nodes should all follow a common
> + * naming scheme; use these macros to ensure commonality.
> + */
> +#define SWNODE_GRAPH_PORT_NAME_FMT		"port@%u"
> +#define SWNODE_GRAPH_ENDPOINT_NAME_FMT		"endpoint@%u"
> +
>  #define NR_FWNODE_REFERENCE_ARGS	8
>  
>  /**
> -- 
> 2.25.1

-- 
heikki
