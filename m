Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435BE463B4A
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Nov 2021 17:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbhK3QNy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Nov 2021 11:13:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:58232 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238364AbhK3QMY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Nov 2021 11:12:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="216262163"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="216262163"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:06:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="540458379"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:06:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ms5dJ-000bVC-IB;
        Tue, 30 Nov 2021 18:05:29 +0200
Date:   Tue, 30 Nov 2021 18:05:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        rafael@kernel.org,
        /tmp/small/0000-cover-letter.patch@punajuuri.localdomain
Subject: Re: [PATCH 7/7] device property: Drop fwnode_graph_get_remote_node()
Message-ID: <YaZLydKDBV9w+ve5@smile.fi.intel.com>
References: <20211130153250.935726-1-sakari.ailus@linux.intel.com>
 <20211130153250.935726-7-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130153250.935726-7-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 30, 2021 at 05:32:50PM +0200, Sakari Ailus wrote:
> fwnode_graph_get_remote_node() is only used by the tegra-video driver.
> Convert it to use newer fwnode_graph_get_endpoint_by_id() and drop
> now-unused fwnode_graph_get_remote_node().

...

> -		remote = fwnode_graph_get_remote_node(fwnode, chan->portnos[0],
> -						      0);
> -		if (!remote)
> +		struct fwnode_handle *ep, *remote;
> +
> +		ep = fwnode_graph_get_endpoint_by_id(fwnode,
> +						     chan->portnos[0], 0, 0);

What makes you to move portnos to the next line? It's pretty much under 80.

> +		if (!ep)
>  			continue;
>  
> +		remote = fwnode_graph_get_remote_port_parent(ep);
> +		fwnode_handle_put(ep);

-- 
With Best Regards,
Andy Shevchenko


