Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F43A53CC
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 12:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfIBKOa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 06:14:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:20906 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbfIBKOa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 06:14:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 03:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="186965481"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 02 Sep 2019 03:14:27 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4jLu-0008Nv-C3; Mon, 02 Sep 2019 13:14:26 +0300
Date:   Mon, 2 Sep 2019 13:14:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 04/11] device property: Add functions for accessing
 node's parents
Message-ID: <20190902101426.GB2680@smile.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-5-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902083240.20367-5-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 02, 2019 at 11:32:33AM +0300, Sakari Ailus wrote:
> Add two convenience functions for accessing node's parents:
> 
> fwnode_count_parents() returns the number of parent nodes a given node
> has. fwnode_get_nth_parent() returns node's parent at a given distance
> from the node itself.
> 

Much better now, thanks!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

though one question below.

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/base/property.c  | 46 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/property.h |  3 +++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 3d9dffbe96378..d2461d79139f3 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -590,6 +590,52 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
>  }
>  EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
>  
> +/**
> + * fwnode_count_parents - Return the number of parents a node has
> + * @fwnode: The node the parents of which are to be counted
> + *
> + * Returns the number of parents a node has.
> + */
> +unsigned int fwnode_count_parents(const struct fwnode_handle *fwnode)
> +{
> +	struct fwnode_handle *__fwnode;
> +	unsigned int count;
> +
> +	__fwnode = fwnode_get_parent(fwnode);
> +
> +	for (count = 0; __fwnode; count++)
> +		__fwnode = fwnode_get_next_parent(__fwnode);
> +
> +	return count;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_count_parents);
> +
> +/**
> + * fwnode_get_nth_parent - Return an nth parent of a node
> + * @fwnode: The node the parent of which is requested
> + * @depth: Distance of the parent from the node
> + *
> + * Returns the nth parent of a node. If @depth is 0, the functionality is
> + * equivalent to fwnode_handle_get(). For @depth == 1, it is fwnode_get_parent()
> + * and so on.
> + *
> + * The caller is responsible for calling fwnode_handle_put() for the returned
> + * node.
> + */
> +struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
> +					    unsigned int depth)
> +{
> +	unsigned int i;
> +
> +	fwnode_handle_get(fwnode);
> +
> +	for (i = 0; i < depth && fwnode; i++)
> +		fwnode = fwnode_get_next_parent(fwnode);
> +

If 'fnode == NULL' and 'i < depth', shan't we return some kind of error?

> +	return fwnode;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
> +
>  /**
>   * fwnode_get_next_child_node - Return the next child node handle for a node
>   * @fwnode: Firmware node to find the next child node for.
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 421c76e53708d..5450e7ec219ac 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -83,6 +83,9 @@ struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
>  struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
>  struct fwnode_handle *fwnode_get_next_parent(
>  	struct fwnode_handle *fwnode);
> +unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
> +struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
> +					    unsigned int depth);
>  struct fwnode_handle *fwnode_get_next_child_node(
>  	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
>  struct fwnode_handle *fwnode_get_next_available_child_node(
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


