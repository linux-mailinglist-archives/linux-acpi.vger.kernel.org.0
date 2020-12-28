Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0B52E6872
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Dec 2020 17:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634355AbgL1QhG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 11:37:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:36250 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441103AbgL1QgF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Dec 2020 11:36:05 -0500
IronPort-SDR: 8elH/iUiOfTs1DIlPIHiCPdiqrUwmwxmeE02PqGVi6exeAcSJR1iGM8/G2yUQF4uF38DNlhzdJ
 V7h6g+oddIZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="175625333"
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="175625333"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 08:34:19 -0800
IronPort-SDR: b35JriF62zCofJ9ZL8YXIcOBbyZDYqOLX87t5r6MJ5OD/E6aBCqRI65Jbsfmd2sHOqg9Galo8v
 HbMJkot5cJDA==
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="343785389"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 08:34:12 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 84608207BF; Mon, 28 Dec 2020 18:34:10 +0200 (EET)
Date:   Mon, 28 Dec 2020 18:34:10 +0200
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
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 05/14] software_node: unregister software_nodes in
 reverse order
Message-ID: <20201228163410.GX26370@paasikivi.fi.intel.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-6-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224010907.263125-6-djrscally@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

On Thu, Dec 24, 2020 at 01:08:58AM +0000, Daniel Scally wrote:
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
> Changes in v3
> 	- Fixed the dereference of the terminating NULL entry
> 	- Comment cleanup
> 
>  drivers/base/swnode.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index ade49173ff8d..2d07eb04c6c8 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -779,16 +779,22 @@ EXPORT_SYMBOL_GPL(software_node_register_node_group);
>   * software_node_unregister_node_group - Unregister a group of software nodes
>   * @node_group: NULL terminated array of software node pointers to be unregistered
>   *
> - * Unregister multiple software nodes at once.
> + * Unregister multiple software nodes at once. The array will be unwound in
> + * reverse order (i.e. last entry first) and thus if any member of the array
> + * has its .parent member set then they should appear later in the array such
> + * that they are unregistered first.
>   */
>  void software_node_unregister_node_group(const struct software_node **node_group)

With this line wrapped,

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

>  {
> -	unsigned int i;
> +	unsigned int i = 0;
>  
>  	if (!node_group)
>  		return;
>  
> -	for (i = 0; node_group[i]; i++)
> +	while (node_group[i])
> +		i++;
> +
> +	while (i--)
>  		software_node_unregister(node_group[i]);
>  }
>  EXPORT_SYMBOL_GPL(software_node_unregister_node_group);

-- 
Kind regards,

Sakari Ailus
