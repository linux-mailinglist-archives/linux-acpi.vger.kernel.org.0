Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5CA53D4
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 12:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfIBKQ5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 06:16:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:22474 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbfIBKQ5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 06:16:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 03:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="265985496"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 02 Sep 2019 03:16:54 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4jOH-0008PC-KJ; Mon, 02 Sep 2019 13:16:53 +0300
Date:   Mon, 2 Sep 2019 13:16:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 06/11] device property: Add a function to obtain a
 node's prefix
Message-ID: <20190902101653.GC2680@smile.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-7-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902083240.20367-7-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 02, 2019 at 11:32:35AM +0300, Sakari Ailus wrote:
> The prefix is used for printing purpose before a node, and it also works
> as a separator between two nodes.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Rob Herring <robh@kernel.org> (for OF)
> ---
>  drivers/acpi/property.c  | 22 ++++++++++++++++++++++
>  drivers/base/property.c  | 12 ++++++++++++
>  drivers/base/swnode.c    | 26 ++++++++++++++++++++++++++
>  drivers/of/property.c    | 10 ++++++++++
>  include/linux/fwnode.h   |  2 ++
>  include/linux/property.h |  1 +
>  6 files changed, 73 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 5a9397a390f41..466239d3bb345 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1336,6 +1336,27 @@ static const char *acpi_fwnode_get_name(const struct fwnode_handle *fwnode)
>  	return acpi_device_bid(adev);
>  }
>  
> +static const char *
> +acpi_fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
> +{
> +	struct fwnode_handle *parent;
> +
> +	/* Is this the root node? */
> +	parent = fwnode_get_parent(fwnode);
> +	if (!parent)
> +		return "";
> +
> +	/* Is this 2nd node from the root? */
> +	parent = fwnode_get_next_parent(parent);
> +	if (!parent)
> +		return "";
> +
> +	fwnode_handle_put(parent);
> +
> +	/* ACPI device or data node. */
> +	return ".";
> +}
> +
>  static struct fwnode_handle *
>  acpi_fwnode_get_parent(struct fwnode_handle *fwnode)
>  {
> @@ -1377,6 +1398,7 @@ acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
>  		.get_next_child_node = acpi_get_next_subnode,		\
>  		.get_named_child_node = acpi_fwnode_get_named_child_node, \
>  		.get_name = acpi_fwnode_get_name,			\
> +		.get_name_prefix = acpi_fwnode_get_name_prefix,		\
>  		.get_reference_args = acpi_fwnode_get_reference_args,	\
>  		.graph_get_next_endpoint =				\
>  			acpi_graph_get_next_endpoint,			\
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 0ce5052a7f9b7..9563db780e039 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -567,6 +567,18 @@ const char *fwnode_get_name(const struct fwnode_handle *fwnode)
>  	return fwnode_call_ptr_op(fwnode, get_name);
>  }
>  
> +/**
> + * fwnode_get_name_prefix - Return the prefix of node for printing purposes
> + * @fwnode: The firmware node
> + *
> + * Returns the prefix of a node, intended to be printed right before the node.
> + * The prefix works also as a separator between the nodes.
> + */
> +const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
> +{
> +	return fwnode_call_ptr_op(fwnode, get_name_prefix);
> +}
> +
>  /**
>   * fwnode_get_parent - Return parent firwmare node
>   * @fwnode: Firmware whose parent is retrieved
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index a4a0f5b80bad3..9cc17baa193fc 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -534,6 +534,31 @@ software_node_get_name(const struct fwnode_handle *fwnode)
>  	return kobject_name(&swnode->kobj);
>  }
>  
> +static const char *
> +software_node_get_name_prefix(const struct fwnode_handle *fwnode)
> +{
> +	struct fwnode_handle *parent;
> +	const char *prefix;
> +
> +	parent = fwnode_get_parent(fwnode);
> +	if (!parent)
> +		return "";
> +
> +	parent = fwnode_get_next_parent(parent);
> +	if (!parent)
> +		return "/";
> +
> +	/* Figure out the prefix from the parents. */
> +	while (is_software_node(parent))
> +		parent = fwnode_get_next_parent(parent);
> +
> +	prefix = fwnode_get_name_prefix(parent);
> +	fwnode_handle_put(parent);
> +
> +	/* Guess something if prefix was NULL. */
> +	return prefix ?: "/";
> +}
> +
>  static struct fwnode_handle *
>  software_node_get_parent(const struct fwnode_handle *fwnode)
>  {
> @@ -635,6 +660,7 @@ static const struct fwnode_operations software_node_ops = {
>  	.property_read_int_array = software_node_read_int_array,
>  	.property_read_string_array = software_node_read_string_array,
>  	.get_name = software_node_get_name,
> +	.get_name_prefix = software_node_get_name_prefix,
>  	.get_parent = software_node_get_parent,
>  	.get_next_child_node = software_node_get_next_child,
>  	.get_named_child_node = software_node_get_named_child_node,
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 5bed634551ea6..e8202f61a5d93 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -877,6 +877,15 @@ static const char *of_fwnode_get_name(const struct fwnode_handle *fwnode)
>  	return kbasename(to_of_node(fwnode)->full_name);
>  }
>  
> +static const char *of_fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
> +{
> +	/* Root needs no prefix here (its name is "/"). */
> +	if (!to_of_node(fwnode)->parent)
> +		return "";
> +
> +	return "/";
> +}
> +
>  static struct fwnode_handle *
>  of_fwnode_get_parent(const struct fwnode_handle *fwnode)
>  {
> @@ -999,6 +1008,7 @@ const struct fwnode_operations of_fwnode_ops = {
>  	.property_read_int_array = of_fwnode_property_read_int_array,
>  	.property_read_string_array = of_fwnode_property_read_string_array,
>  	.get_name = of_fwnode_get_name,
> +	.get_name_prefix = of_fwnode_get_name_prefix,
>  	.get_parent = of_fwnode_get_parent,
>  	.get_next_child_node = of_fwnode_get_next_child_node,
>  	.get_named_child_node = of_fwnode_get_named_child_node,
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index c331e0ef31e80..755709703fe6f 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -57,6 +57,7 @@ struct fwnode_reference_args {
>   * @property_read_string_array: Read an array of string properties. Return zero
>   *				on success, a negative error code otherwise.
>   * @get_name: Return the name of an fwnode.
> + * @get_name_prefix: Get a prefix for a node (for printing purposes).
>   * @get_parent: Return the parent of an fwnode.
>   * @get_next_child_node: Return the next child node in an iteration.
>   * @get_named_child_node: Return a child node with a given name.
> @@ -84,6 +85,7 @@ struct fwnode_operations {
>  				      const char *propname, const char **val,
>  				      size_t nval);
>  	const char *(*get_name)(const struct fwnode_handle *fwnode);
> +	const char *(*get_name_prefix)(const struct fwnode_handle *fwnode);
>  	struct fwnode_handle *(*get_parent)(const struct fwnode_handle *fwnode);
>  	struct fwnode_handle *
>  	(*get_next_child_node)(const struct fwnode_handle *fwnode,
> diff --git a/include/linux/property.h b/include/linux/property.h
> index ebc5e2016bb66..c40fcfc5774a7 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -81,6 +81,7 @@ struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
>  					    unsigned int index);
>  
>  const char *fwnode_get_name(const struct fwnode_handle *fwnode);
> +const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode);
>  struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
>  struct fwnode_handle *fwnode_get_next_parent(
>  	struct fwnode_handle *fwnode);
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


