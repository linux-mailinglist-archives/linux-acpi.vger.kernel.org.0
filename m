Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E57463B43
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Nov 2021 17:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243663AbhK3QM7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Nov 2021 11:12:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:4757 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243424AbhK3QMF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Nov 2021 11:12:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="297050487"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="297050487"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:08:32 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="459653594"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:08:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ms5fC-000bYV-Uo;
        Tue, 30 Nov 2021 18:07:26 +0200
Date:   Tue, 30 Nov 2021 18:07:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        rafael@kernel.org,
        /tmp/small/0000-cover-letter.patch@punajuuri.localdomain
Subject: Re: [PATCH 1/7] device property: Fix fwnode_graph_devcon_match()
 fwnode leak
Message-ID: <YaZMPtzYumINzvz7@smile.fi.intel.com>
References: <20211130153250.935726-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130153250.935726-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 30, 2021 at 05:32:44PM +0200, Sakari Ailus wrote:
> For each endpoint it encounters, fwnode_graph_devcon_match() checks
> whether the endpoint's remote port parent device is available. If it is
> not, it ignores the endpoint but does not put the reference to the remote
> endpoint port parent fwnode. For available devices the fwnode handle
> reference is put as expected.
> 
> Put the reference for unavailable devices now.

I like the series, thanks!
For non-commented you may take my
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The rest can gain it if you are okay with my proposals.

Also, please fix Cc list, it has fancy address in the Cc list.

> Fixes: 637e9e52b185 ("device connection: Find device connections also from device graphs")
> Cc: stable@vger.kernel.org # for 5.1 and later
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/base/property.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index f1f35b48ab8b9..6df99e526ab0f 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1206,8 +1206,10 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
>  
>  	fwnode_graph_for_each_endpoint(fwnode, ep) {
>  		node = fwnode_graph_get_remote_port_parent(ep);
> -		if (!fwnode_device_is_available(node))
> +		if (!fwnode_device_is_available(node)) {
> +			fwnode_handle_put(node);
>  			continue;
> +		}
>  
>  		ret = match(node, con_id, data);
>  		fwnode_handle_put(node);
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


