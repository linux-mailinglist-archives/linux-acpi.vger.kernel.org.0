Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8041D2ED15A
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 15:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbhAGOGL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 09:06:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:40102 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbhAGOGL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 09:06:11 -0500
IronPort-SDR: Wj1MXsF7h0dj3Yvtxdpu0kffpjAuuoLQQ7ruJPfY+DqHFbfa+gtzsEQVoCttlKOY1/XAoG8PmJ
 j9phpFg8MCgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="176648039"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="176648039"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 06:04:25 -0800
IronPort-SDR: L3gYmoYPMdgGKjUkUBKX/YvWN5SQmqkEwQQ+tIbuQzrr4YbnAiI+VolYkbM+jKqhsyCOINIjCY
 Uhw/79Go4eJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="463044655"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jan 2021 06:04:19 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 07 Jan 2021 16:04:18 +0200
Date:   Thu, 7 Jan 2021 16:04:18 +0200
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
Subject: Re: [PATCH v5 05/15] software_node: Enforce parent before child
 ordering of nodes arrays
Message-ID: <20210107140418.GE940479@kuha.fi.intel.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-6-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-6-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 07, 2021 at 01:28:28PM +0000, Daniel Scally wrote:
> Registering software_nodes with the .parent member set to point to a
> currently unregistered software_node has the potential for problems,
> so enforce parent -> child ordering in arrays passed in to
> software_node_register_nodes().
> 
> Software nodes that are children of another software node should be
> unregistered before their parent. To allow easy unregistering of an array
> of software_nodes ordered parent to child, reverse the order in which
> software_node_unregister_nodes() unregisters software_nodes.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v5:
> 
> 	- None
> 
>  drivers/base/swnode.c | 42 ++++++++++++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 4fcc1a6fb724..166c5cc73f39 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -692,7 +692,11 @@ swnode_register(const struct software_node *node, struct swnode *parent,
>   * software_node_register_nodes - Register an array of software nodes
>   * @nodes: Zero terminated array of software nodes to be registered
>   *
> - * Register multiple software nodes at once.
> + * Register multiple software nodes at once. If any node in the array
> + * has its .parent pointer set (which can only be to another software_node),
> + * then its parent **must** have been registered before it is; either outside
> + * of this function or by ordering the array such that parent comes before
> + * child.
>   */
>  int software_node_register_nodes(const struct software_node *nodes)
>  {
> @@ -700,14 +704,23 @@ int software_node_register_nodes(const struct software_node *nodes)
>  	int i;
>  
>  	for (i = 0; nodes[i].name; i++) {
> -		ret = software_node_register(&nodes[i]);
> -		if (ret) {
> -			software_node_unregister_nodes(nodes);
> -			return ret;
> +		const struct software_node *parent = nodes[i].parent;
> +
> +		if (parent && !software_node_to_swnode(parent)) {
> +			ret = -EINVAL;
> +			goto err_unregister_nodes;
>  		}
> +
> +		ret = software_node_register(&nodes[i]);
> +		if (ret)
> +			goto err_unregister_nodes;
>  	}
>  
>  	return 0;
> +
> +err_unregister_nodes:
> +	software_node_unregister_nodes(nodes);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(software_node_register_nodes);
>  
> @@ -715,18 +728,23 @@ EXPORT_SYMBOL_GPL(software_node_register_nodes);
>   * software_node_unregister_nodes - Unregister an array of software nodes
>   * @nodes: Zero terminated array of software nodes to be unregistered
>   *
> - * Unregister multiple software nodes at once.
> + * Unregister multiple software nodes at once. If parent pointers are set up
> + * in any of the software nodes then the array **must** be ordered such that
> + * parents come before their children.
>   *
> - * NOTE: Be careful using this call if the nodes had parent pointers set up in
> - * them before registering.  If so, it is wiser to remove the nodes
> - * individually, in the correct order (child before parent) instead of relying
> - * on the sequential order of the list of nodes in the array.
> + * NOTE: If you are uncertain whether the array is ordered such that
> + * parents will be unregistered before their children, it is wiser to
> + * remove the nodes individually, in the correct order (child before
> + * parent).
>   */
>  void software_node_unregister_nodes(const struct software_node *nodes)
>  {
> -	int i;
> +	unsigned int i = 0;
> +
> +	while (nodes[i].name)
> +		i++;
>  
> -	for (i = 0; nodes[i].name; i++)
> +	while (i--)
>  		software_node_unregister(&nodes[i]);
>  }
>  EXPORT_SYMBOL_GPL(software_node_unregister_nodes);
> -- 
> 2.25.1

-- 
heikki
