Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5CE2ED11D
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbhAGNqx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:46:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:46375 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbhAGNqx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 08:46:53 -0500
IronPort-SDR: FEcQSqFVlH49vunK22pYRJG7TcS5NhDjo1u+a2X/KMkBainBQFciUDYaUc15T42b8UG3ks/MGR
 n8xr+V8B/6dA==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="195982123"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="195982123"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 05:45:07 -0800
IronPort-SDR: Vw/7mPcxthNUBixNycZeCdAZ22z5w/+uDM+0bZhDdJfdHRQjBq94unP9jU4rl0YaQhlIEFRVa4
 NQ3Bm8l2x4NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="463040716"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jan 2021 05:45:00 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 07 Jan 2021 15:45:00 +0200
Date:   Thu, 7 Jan 2021 15:45:00 +0200
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 01/15] software_node: Fix refcounts in
 software_node_get_next_child()
Message-ID: <20210107134500.GC940479@kuha.fi.intel.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-2-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-2-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 07, 2021 at 01:28:24PM +0000, Daniel Scally wrote:
> The software_node_get_next_child() function currently does not hold
> references to the child software_node that it finds or put the ref that
> is held against the old child - fix that.
> 
> Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the firmware node framework")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v5:
> 
> 	- None
> 
>  drivers/base/swnode.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 4a4b2008fbc2..4fcc1a6fb724 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -443,14 +443,18 @@ software_node_get_next_child(const struct fwnode_handle *fwnode,
>  	struct swnode *c = to_swnode(child);
>  
>  	if (!p || list_empty(&p->children) ||
> -	    (c && list_is_last(&c->entry, &p->children)))
> +	    (c && list_is_last(&c->entry, &p->children))) {
> +		fwnode_handle_put(child);
>  		return NULL;
> +	}
>  
>  	if (c)
>  		c = list_next_entry(c, entry);
>  	else
>  		c = list_first_entry(&p->children, struct swnode, entry);
> -	return &c->fwnode;
> +
> +	fwnode_handle_put(child);
> +	return fwnode_handle_get(&c->fwnode);
>  }
>  
>  static struct fwnode_handle *
> -- 
> 2.25.1

thanks,

-- 
heikki
