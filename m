Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471E02DFAE5
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Dec 2020 11:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgLUKMu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Dec 2020 05:12:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:51000 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgLUKMu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Dec 2020 05:12:50 -0500
IronPort-SDR: nrIliuLNqhfsMyYtVDMPPSndcZUtqSWtA0Jfy9pgjbzZPlYNoyt9vfSgulEDmifurbSu9rPB58
 nimq6g1Ws25g==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="175802211"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="175802211"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 01:34:16 -0800
IronPort-SDR: gAi9DxMfesrQ2zuta4Om6nh7eLitGCnn/H39iJtrOL9wvaorTUC79LwFDBytBfcwjcvCvkf+Xw
 ZQxxmPgpwrJg==
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="560120081"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 01:34:10 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 8C5CB205F7; Mon, 21 Dec 2020 11:34:08 +0200 (EET)
Date:   Mon, 21 Dec 2020 11:34:08 +0200
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
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
Subject: Re: [PATCH v2 06/12] software_node: Add support for fwnode_graph*()
 family of functions
Message-ID: <20201221093408.GH26370@paasikivi.fi.intel.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-7-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217234337.1983732-7-djrscally@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel and Heikki,

On Thu, Dec 17, 2020 at 11:43:31PM +0000, Daniel Scally wrote:
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
> Changes in v2:
> 
> 	- Changed commit to specify port name prefix as port@
> 	- Accounted for that rename in *parse_endpoint()
> 
>  drivers/base/swnode.c | 110 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 109 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 2b90d380039b..0d14d5ebe441 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -540,6 +540,110 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
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
> +		if (!strncmp(to_swnode(port)->node->name, "port", 4))
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
> +	struct fwnode_handle *old = endpoint;
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
> +		endpoint = software_node_get_next_child(port, old);
> +		if (endpoint) {
> +			fwnode_handle_put(port);
> +			break;
> +		}
> +
> +		/* No more endpoints for that port, so stop passing old */
> +		old = NULL;
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
> +	struct fwnode_handle *parent;
> +
> +	if (!strcmp(swnode->parent->node->name, "ports"))
> +		parent = &swnode->parent->parent->fwnode;
> +	else
> +		parent = &swnode->parent->fwnode;

If you happen to call this function on a non-port node for whatever reason,
you may end up accessing a pointer that's NULL, can't you? Instead I'd do
something like:

swnode = swnode->parent;
if (swnode && !strcmp(swnode->node->name, "ports"))
	swnode = swnode->parent;

return swnode ? software_node_get(&swnode->fwnode) : NULL;

You can also drop parent as a by-product of this.

> +
> +	return software_node_get(parent);
> +}
> +
> +static int
> +software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
> +				   struct fwnode_endpoint *endpoint)
> +{
> +	struct swnode *swnode = to_swnode(fwnode);
> +	int ret;
> +
> +	ret = kstrtou32(swnode->parent->node->name + 5, 10, &endpoint->port);
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
> @@ -551,7 +655,11 @@ static const struct fwnode_operations software_node_ops = {
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
Kind regards,

Sakari Ailus
