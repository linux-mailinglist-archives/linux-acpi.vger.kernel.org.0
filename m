Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA9E2DFA79
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Dec 2020 10:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgLUJuq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Dec 2020 04:50:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:21973 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgLUJup (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Dec 2020 04:50:45 -0500
IronPort-SDR: yvFMMTOOcKZXZnAcNXukPlpCkIZ7/MbtBoQzL/YCyumqOTxPOI++zP+S6kf7ULR7CAMZvgxIEY
 HTL/cfbyZeMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="163425485"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="163425485"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 01:21:25 -0800
IronPort-SDR: ZsYYsjfQymkNrlz2gNxFQTYaoGP4sN2o6dq4IWGgbSwH9hgigMuWqf0tuNueN1j9a1Z2fYAiOE
 A+WbzBokbxAA==
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="372380899"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 01:21:18 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id EF9F6205F7; Mon, 21 Dec 2020 11:21:16 +0200 (EET)
Date:   Mon, 21 Dec 2020 11:21:16 +0200
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
        kitakar@gmail.com, jorhand@linux.microsoft.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 05/12] software_node: unregister software_nodes in
 reverse order
Message-ID: <20201221092116.GG26370@paasikivi.fi.intel.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-6-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217234337.1983732-6-djrscally@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

On Thu, Dec 17, 2020 at 11:43:30PM +0000, Daniel Scally wrote:
> To maintain consistency with software_node_unregister_nodes(), reverse
> the order in which the software_node_unregister_node_group() function
> unregisters nodes.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v2:
> 
> 	- Initialised i properly
> 
>  drivers/base/swnode.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index cfd1faea48a7..2b90d380039b 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -778,16 +778,22 @@ EXPORT_SYMBOL_GPL(software_node_register_node_group);
>   * software_node_unregister_node_group - Unregister a group of software nodes
>   * @node_group: NULL terminated array of software node pointers to be unregistered
>   *
> - * Unregister multiple software nodes at once.
> + * Unregister multiple software nodes at once. The array will be unwound in
> + * reverse order (I.E. last entry first) and thus if any member of the array
> + * has its .parent member set then they should appear later in the array such
> + * that they are unregistered first.
>   */
>  void software_node_unregister_node_group(const struct software_node **node_group)
>  {
> -	unsigned int i;
> +	unsigned int i = 0;
>  
>  	if (!node_group)
>  		return;
>  
> -	for (i = 0; node_group[i]; i++)
> +	while (node_group[i]->name)

Why is this change made? node_group is a NULL-terminated array, and the
above accesses the name pointer on each entry before checking the entry is
non-NULL. Or do I miss something here?

> +		i++;
> +
> +	while (i--)
>  		software_node_unregister(node_group[i]);
>  }
>  EXPORT_SYMBOL_GPL(software_node_unregister_node_group);

-- 
Regards,

Sakari Ailus
