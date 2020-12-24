Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D02E26F2
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 13:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgLXMy3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Dec 2020 07:54:29 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:46288 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgLXMy3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2020 07:54:29 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 05A8BA1D;
        Thu, 24 Dec 2020 13:53:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1608814426;
        bh=rgICk9P3xeCwLrllHIuZrq7lxdkFuA3ScijDssxKLEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kq52nLi+z+pUzvuSE4GWqMNY7VIvw897/5z5BNrF4HsTHmIwEDB4iHywzCplkc/Y2
         x1FSd2HL4GxcsefU2QEElMXuhEMCG6l2/PKLE67xOIO8XRX0BCwYiPfsSjDSsvzgPY
         X2a+ji1WAupdAvXclIqJLZKdQWoUEkiR6Y3wkynI=
Date:   Thu, 24 Dec 2020 14:53:37 +0200
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
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
Subject: Re: [PATCH v3 07/14] software_node: Add support for fwnode_graph*()
 family of functions
Message-ID: <X+SPUTDn+lPdV4ny@pendragon.ideasonboard.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-8-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201224010907.263125-8-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

Thank you for the patch.

On Thu, Dec 24, 2020 at 01:09:00AM +0000, Daniel Scally wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> This implements the remaining .graph_* callbacks in the
> fwnode operations structure for the software nodes. That makes
> the fwnode_graph*() functions available in the drivers also
> when software nodes are used.
> 
> The implementation tries to mimic the "OF graph" as much as
> possible, but there is no support for the "reg" device
> property. The ports will need to have the index in their
> name which starts with "port@" (for example "port@0", "port@1",
> ...) and endpoints will use the index of the software node
> that is given to them during creation. The port nodes can
> also be grouped under a specially named "ports" subnode,
> just like in DT, if necessary.
> 
> The remote-endpoints are reference properties under the
> endpoint nodes that are named "remote-endpoint".
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Co-developed-by: Daniel Scally <djrscally@gmail.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v3
> 	- Changed software_node_get_next_endpoint() to drop the variable
> 	named "old"
> 	- Used the macros defined in 06/14 instead of magic numbers
> 	- Added some comments to explain behaviour a little where it's unclear
> 
>  drivers/base/swnode.c | 112 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 111 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 2d07eb04c6c8..ff690029060d 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -540,6 +540,112 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  	return 0;
>  }
>  
> +static struct fwnode_handle *
> +swnode_graph_find_next_port(const struct fwnode_handle *parent,
> +			    struct fwnode_handle *port)
> +{
> +	struct fwnode_handle *old = port;
> +
> +	while ((port = software_node_get_next_child(parent, old))) {
> +		/*
> +		 * ports have naming style "port@n", so we search for children
> +		 * that follow that convention (but without assuming anything
> +		 * about the index number)
> +		 */
> +		if (!strncmp(to_swnode(port)->node->name, "port@",
> +			     FWNODE_GRAPH_PORT_NAME_PREFIX_LEN))

I would either add a macro to replace the prefix ("port@"), or drop
FWNODE_GRAPH_PORT_NAME_PREFIX_LEN. I think this is the worst of both
worlds, the string and its length are defined in two different places
:-)

I would personally drop the macro, but I don't mind either way as long
as the string and its length are defined in the same place.

> +			return port;
> +		old = port;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct fwnode_handle *
> +software_node_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
> +				      struct fwnode_handle *endpoint)
> +{
> +	struct swnode *swnode = to_swnode(fwnode);
> +	struct fwnode_handle *parent;
> +	struct fwnode_handle *port;
> +
> +	if (!swnode)
> +		return NULL;
> +
> +	if (endpoint) {
> +		port = software_node_get_parent(endpoint);
> +		parent = software_node_get_parent(port);
> +	} else {
> +		parent = software_node_get_named_child_node(fwnode, "ports");
> +		if (!parent)
> +			parent = software_node_get(&swnode->fwnode);
> +
> +		port = swnode_graph_find_next_port(parent, NULL);
> +	}
> +
> +	for (; port; port = swnode_graph_find_next_port(parent, port)) {
> +		endpoint = software_node_get_next_child(port, endpoint);
> +		if (endpoint) {
> +			fwnode_handle_put(port);
> +			break;
> +		}
> +	}
> +
> +	fwnode_handle_put(parent);
> +
> +	return endpoint;
> +}
> +
> +static struct fwnode_handle *
> +software_node_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
> +{
> +	struct swnode *swnode = to_swnode(fwnode);
> +	const struct software_node_ref_args *ref;
> +	const struct property_entry *prop;
> +
> +	if (!swnode)
> +		return NULL;
> +
> +	prop = property_entry_get(swnode->node->properties, "remote-endpoint");
> +	if (!prop || prop->type != DEV_PROP_REF || prop->is_inline)
> +		return NULL;
> +
> +	ref = prop->pointer;
> +
> +	return software_node_get(software_node_fwnode(ref[0].node));
> +}
> +
> +static struct fwnode_handle *
> +software_node_graph_get_port_parent(struct fwnode_handle *fwnode)
> +{
> +	struct swnode *swnode = to_swnode(fwnode);
> +
> +	swnode = swnode->parent;
> +	if (swnode && !strcmp(swnode->node->name, "ports"))
> +		swnode = swnode->parent;
> +
> +	return swnode ? software_node_get(&swnode->fwnode) : NULL;
> +}
> +
> +static int
> +software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
> +				   struct fwnode_endpoint *endpoint)
> +{
> +	struct swnode *swnode = to_swnode(fwnode);
> +	int ret;
> +
> +	/* Ports have naming style "port@n", we need to select the n */
> +	ret = kstrtou32(swnode->parent->node->name + FWNODE_GRAPH_PORT_NAME_PREFIX_LEN,
> +			10, &endpoint->port);

Same here.

I wonder if we should add a check to ensure parent->node->name is long
enough (and possibly even start with the right prefix), as otherwise the
pointer passed to kstrtou32() may be past the end of the string. Maybe
this is overkill, if we can rely on the fact that software nodes have
correct names.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	if (ret)
> +		return ret;
> +
> +	endpoint->id = swnode->id;
> +	endpoint->local_fwnode = fwnode;
> +
> +	return 0;
> +}
> +
>  static const struct fwnode_operations software_node_ops = {
>  	.get = software_node_get,
>  	.put = software_node_put,
> @@ -551,7 +657,11 @@ static const struct fwnode_operations software_node_ops = {
>  	.get_parent = software_node_get_parent,
>  	.get_next_child_node = software_node_get_next_child,
>  	.get_named_child_node = software_node_get_named_child_node,
> -	.get_reference_args = software_node_get_reference_args
> +	.get_reference_args = software_node_get_reference_args,
> +	.graph_get_next_endpoint = software_node_graph_get_next_endpoint,
> +	.graph_get_remote_endpoint = software_node_graph_get_remote_endpoint,
> +	.graph_get_port_parent = software_node_graph_get_port_parent,
> +	.graph_parse_endpoint = software_node_graph_parse_endpoint,
>  };
>  
>  /* -------------------------------------------------------------------------- */

-- 
Regards,

Laurent Pinchart
