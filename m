Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14772ED169
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 15:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbhAGOHW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 09:07:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:20554 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbhAGOHW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 09:07:22 -0500
IronPort-SDR: wyyZ7DaXeH0WPdt2OG193DzTyBUw5/Ed/RByyoO/oJIIt1Nm5qkUXGdpu5qOAF567iGsAu3g8Q
 uwFYd+3guCxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="157208519"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="157208519"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 06:05:36 -0800
IronPort-SDR: SCON5tZcZd+efgwfTS2kzjVcHn3Rp7ZApShflS1T0SLf2ewL+wJX73E/zPUOxnMs2Vrd/KNh4s
 1/f2yuYhA7/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="463044894"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jan 2021 06:05:28 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 07 Jan 2021 16:05:28 +0200
Date:   Thu, 7 Jan 2021 16:05:28 +0200
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
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 06/15] software_node: unregister software_nodes in
 reverse order
Message-ID: <20210107140528.GF940479@kuha.fi.intel.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-7-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-7-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 07, 2021 at 01:28:29PM +0000, Daniel Scally wrote:
> To maintain consistency with software_node_unregister_nodes(), reverse
> the order in which the software_node_unregister_node_group() function
> unregisters nodes.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v5:
> 
> 	- None
> 
>  drivers/base/swnode.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 166c5cc73f39..6f7443c6d3b5 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -779,16 +779,23 @@ EXPORT_SYMBOL_GPL(software_node_register_node_group);
>   * software_node_unregister_node_group - Unregister a group of software nodes
>   * @node_group: NULL terminated array of software node pointers to be unregistered
>   *
> - * Unregister multiple software nodes at once.
> + * Unregister multiple software nodes at once. The array will be unwound in
> + * reverse order (i.e. last entry first) and thus if any members of the array are
> + * children of another member then the children must appear later in the list such
> + * that they are unregistered first.
>   */
> -void software_node_unregister_node_group(const struct software_node **node_group)
> +void software_node_unregister_node_group(
> +		const struct software_node **node_group)
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
> -- 
> 2.25.1

-- 
heikki
