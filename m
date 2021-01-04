Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B942E933B
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 11:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbhADKX3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 05:23:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:26569 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbhADKX2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Jan 2021 05:23:28 -0500
IronPort-SDR: L/7JQyrEhHzOtuBZQ6MsQa9zro6nb5fOeHTc4xA8oSErf+9W+Xu6DLWCyF1hO5OlL1+jI5m+jw
 lwWWUy/wfYMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="176156295"
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="176156295"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 02:21:43 -0800
IronPort-SDR: lQQUhvUB/dAKJGyb5k4/6tJCMwUWCCy/Rt67aN7Q4vV2/kwo+KBbsQK7SdkzuqYp6WdTDPZnyc
 xe+8aWVw24Zg==
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="394827217"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 02:21:37 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kwN0Y-001Y0I-Bl; Mon, 04 Jan 2021 12:22:38 +0200
Date:   Mon, 4 Jan 2021 12:22:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org, lenb@kernel.org,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 08/15] software_node: Add support for fwnode_graph*()
 family of functions
Message-ID: <20210104102238.GQ4077@smile.fi.intel.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
 <20210103231235.792999-9-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103231235.792999-9-djrscally@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jan 03, 2021 at 11:12:28PM +0000, Daniel Scally wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> This implements the remaining .graph_*() callbacks in the fwnode
> operations structure for the software nodes. That makes the
> fwnode_graph_*() functions available in the drivers also when software
> nodes are used.
> 
> The implementation tries to mimic the "OF graph" as much as possible, but
> there is no support for the "reg" device property. The ports will need to
> have the index in their  name which starts with "port@" (for example
> "port@0", "port@1", ...) and endpoints will use the index of the software
> node that is given to them during creation. The port nodes can also be
> grouped under a specially named "ports" subnode, just like in DT, if
> necessary.
> 
> The remote-endpoints are reference properties under the endpoint nodes
> that are named "remote-endpoint".

Couple of nitpicks below (can be considered as follow up, depends on yours and
maintainer wishes).

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Co-developed-by: Daniel Scally <djrscally@gmail.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v4:
> 
> 	- Replaced the FWNODE_GRAPH_PORT_NAME_PREFIX_LEN macro with
> 	  strlen("port@") throughout
> 	- Added a check to software_node_graph_parse_endpoint() to ensure
> 	  the name of the endpoint's parent matches the expected port@n
> 	  format
> 
>  drivers/base/swnode.c | 116 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 115 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 1f43c51b431e..82f9d6326110 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -540,6 +540,116 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
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
> +		 * fwnode ports have naming style "port@", so we search for any
> +		 * children that follow that convention.
> +		 */
> +		if (!strncmp(to_swnode(port)->node->name, "port@",
> +			     strlen("port@")))
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
> +	const char *parent_name = swnode->parent->node->name;
> +	int ret;
> +
> +	if (!(strlen(parent_name) > strlen("port@")) ||

A nit:

	if (strlen("port@") >= strlen(parent_name) ||

better to read

> +	    strncmp(parent_name, "port@", strlen("port@")))
> +		return -EINVAL;
> +
> +	/* Ports have naming style "port@n", we need to select the n */
> +	ret = kstrtou32(parent_name + strlen("port@"),
> +			10, &endpoint->port);

A nit:

	ret = kstrtou32(parent_name + strlen("port@"), 10, &endpoint->port);

(perhaps you need to adjust your editor settings, this still fits 80)

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
> @@ -551,7 +661,11 @@ static const struct fwnode_operations software_node_ops = {
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
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


