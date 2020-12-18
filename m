Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F992DEA32
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 21:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgLRUaG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 15:30:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:19583 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbgLRUaF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Dec 2020 15:30:05 -0500
IronPort-SDR: b9D8wMx1upnFcVhD3e6kWypbC1InLGntCAWm7L+ZS4WxxnsLSnBy8fSY+l2q/EhcwhlwXGbwFk
 UZGJmALVJoSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="174729217"
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; 
   d="scan'208";a="174729217"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 12:28:20 -0800
IronPort-SDR: 5yzWuNenkCaVFwsIYBAgOCyEqtf5UoT9DU/IvUUlQXz7LRAixKI587sSRmBBFJYsY6pOfWGTbZ
 WI4B8tg9PQkQ==
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; 
   d="scan'208";a="393914420"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 12:28:15 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kqMNI-00FgGS-2m; Fri, 18 Dec 2020 22:29:16 +0200
Date:   Fri, 18 Dec 2020 22:29:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
Subject: Re: [PATCH v2 04/12] software_node: Enforce parent before child
 ordering of nodes arrays
Message-ID: <20201218202916.GA4077@smile.fi.intel.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-5-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217234337.1983732-5-djrscally@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

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

...

> + * Register multiple software nodes at once. If any node in the array
> + * has it's .parent pointer set, then it's parent **must** have been

it's => its in both cases?


> + * registered before it is; either outside of this function or by
> + * ordering the array such that parent comes before child.
>   */

...

> +		const struct software_node *parent = nodes[i].parent;
> +
> +		if (parent && !software_node_to_swnode(parent)) {

Can we have parent of swnode in an array not being an swnode?
Either comment that parent for swnode can be swnode only (Heikki, was it an
idea?) or check if parent is of swnode type and only that apply this
requirement.

> +			ret = -EINVAL;
> +			goto err_unregister_nodes;
>  		}

...

> + * Unregister multiple software nodes at once. If parent pointers are set up
> + * in any of the software nodes then the array MUST be ordered such that
> + * parents come before their children.

Shouldn't be consistent with above, i.e. **must** ?

-- 
With Best Regards,
Andy Shevchenko


