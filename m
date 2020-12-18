Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B92DE71F
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 17:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgLRQC4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 11:02:56 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:41438 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgLRQCz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2020 11:02:55 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2BDD82CF;
        Fri, 18 Dec 2020 17:02:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1608307332;
        bh=s2SHQA0PN7urDd/Qm3xpPmk0SAd9BjjKrvkA4hZemV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFxcFcRYphMYulyRHR3ufYN6rRoNVK6eIUT4lylN+2Ep7+NVgoerI/bkEwgOUO6hw
         3kKeqs/9UiyviMhbz/17vdyHdsd48l6WXEfIhVNFmYIPNOhgYfC7df6hF5NykwaxoY
         P748LH6UxsHOv9BQDiVlWzvt0x+Vu4fjo81/1afs=
Date:   Fri, 18 Dec 2020 18:02:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
Subject: Re: [PATCH v2 04/12] software_node: Enforce parent before child
 ordering of nodes arrays
Message-ID: <X9zSfPUmHL3kho+D@pendragon.ideasonboard.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-5-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201217234337.1983732-5-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

Thank you for the patch.

On Thu, Dec 17, 2020 at 11:43:29PM +0000, Daniel Scally wrote:
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
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v2:
> 
> 	- Squashed the patches that originally touched these separately
> 	- Updated documentation
> 
>  drivers/base/swnode.c | 43 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 615a0c93e116..cfd1faea48a7 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -692,7 +692,10 @@ swnode_register(const struct software_node *node, struct swnode *parent,
>   * software_node_register_nodes - Register an array of software nodes
>   * @nodes: Zero terminated array of software nodes to be registered
>   *
> - * Register multiple software nodes at once.
> + * Register multiple software nodes at once. If any node in the array
> + * has it's .parent pointer set, then it's parent **must** have been
> + * registered before it is; either outside of this function or by
> + * ordering the array such that parent comes before child.
>   */
>  int software_node_register_nodes(const struct software_node *nodes)
>  {
> @@ -700,33 +703,47 @@ int software_node_register_nodes(const struct software_node *nodes)
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
>  /**
>   * software_node_unregister_nodes - Unregister an array of software nodes
> - * @nodes: Zero terminated array of software nodes to be unregistered
> + * @nodes: Zero terminated array of software nodes to be unregistered.

Not sure if this is needed.

>   *
> - * Unregister multiple software nodes at once.
> + * Unregister multiple software nodes at once. If parent pointers are set up
> + * in any of the software nodes then the array MUST be ordered such that

I'd either replace **must** above with MUST, or use **must** here. I'm
not sure if kerneldoc handles emphasis with **must**, if it does that
seems a bit nicer to me, but it's really up to you.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

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

-- 
Regards,

Laurent Pinchart
