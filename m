Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F2F35F083
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Apr 2021 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhDNJOC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Apr 2021 05:14:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:29997 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232081AbhDNJOB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Apr 2021 05:14:01 -0400
IronPort-SDR: 9FAL0JQT7q05lWP1+96p0NBulpnriPJeQjJAa9yWjvbTYSppnKgHXQt5p8lkexYkU3b1i+sLdP
 HBSlL/I5df2A==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="255919985"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="255919985"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 02:13:38 -0700
IronPort-SDR: NOutl8Gepr0SWfFGtfiLlZqxJPFJSvnWFpQyE0mKQfUw7u48WfSiRYNgPzPiWmm30GaiOt/tkz
 M3xcMxtZP7pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="521925571"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Apr 2021 02:13:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 14 Apr 2021 12:13:35 +0300
Date:   Wed, 14 Apr 2021 12:13:35 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: Allow node addition to already existing
 device
Message-ID: <YHayP0cTOGMSoPNR@kuha.fi.intel.com>
References: <20210414075438.64547-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414075438.64547-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Greg

Sorry about that. Should I resend this?

On Wed, Apr 14, 2021 at 10:54:38AM +0300, Heikki Krogerus wrote:
> If the node is added to an already exiting device, the node
> needs to be also linked to the device separately.
> 
> This will make sure the reference count is kept in balance
> also when the node is injected to a device afterwards.
> 
> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Fixes: e68d0119e328 ("software node: Introduce device_add_software_node()")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/swnode.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 740333629b420..3cc11b813f28c 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -1045,6 +1045,7 @@ int device_add_software_node(struct device *dev, const struct software_node *nod
>  	}
>  
>  	set_secondary_fwnode(dev, &swnode->fwnode);
> +	software_node_notify(dev, KOBJ_ADD);
>  
>  	return 0;
>  }
> @@ -1118,8 +1119,8 @@ int software_node_notify(struct device *dev, unsigned long action)
>  
>  	switch (action) {
>  	case KOBJ_ADD:
> -		ret = sysfs_create_link(&dev->kobj, &swnode->kobj,
> -					"software_node");
> +		ret = sysfs_create_link_nowarn(&dev->kobj, &swnode->kobj,
> +					       "software_node");
>  		if (ret)
>  			break;
>  
> -- 
> 2.30.2

-- 
heikki
