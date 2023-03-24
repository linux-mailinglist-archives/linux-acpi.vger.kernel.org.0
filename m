Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69F6C7D11
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Mar 2023 12:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCXLOw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Mar 2023 07:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCXLOv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 07:14:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1E3244BC
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679656490; x=1711192490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ws8XGVO4Gh0ORy6wwh4rfX8IiGkhnjj0jTQLSw4IBjw=;
  b=TI4tfE0V3Ztfliu1j+6QOfaqR8NASWmNfsWzTYRivlwykSlmco2zUZ65
   +j6pPPAPaDNGEhrjBx3KVpJAlX46nRSAfOunA8puG5Pi8Fa+OZkzQzOGC
   QMQgHO8WSxyY7dwlWXUhv/dufa4cjJZD4xw6ooCtWTwD+LU3mmXOv3wXS
   YNikKHVaP9aLpqUAfVoCH9gJyxTsQI6Vo5cJR0QWnmVYcvwMqrVPxSHDZ
   fVC0WDErAILNFWJ1DeqfXEr4foKMrwq0q3/OWTH6Zby7F3xdTuoVqKpZQ
   QVw5QJevTWbWthJh3oQDsCNVOQMio0I5yvNc1ZPNp8nDQtZ1r/8x887o/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="320146787"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="320146787"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 04:14:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="715192338"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="715192338"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 24 Mar 2023 04:14:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pffNd-007sQJ-2G;
        Fri, 24 Mar 2023 13:14:45 +0200
Date:   Fri, 24 Mar 2023 13:14:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] device property: constify fwnode_get_phy_mode() argument
Message-ID: <ZB2GJZMAQC4CTy9E@smile.fi.intel.com>
References: <E1pfdh9-00EQ8t-HB@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1pfdh9-00EQ8t-HB@rmk-PC.armlinux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 24, 2023 at 09:26:47AM +0000, Russell King (Oracle) wrote:
> fwnode_get_phy_mode() does not modify the fwnode argument, merely
> using it to obtain the phy-mode property value. Therefore, it can
> be made const.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you!

> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Patch generated against net-next tree as that was where it was used and
> tested.
> 
>  drivers/base/property.c  | 2 +-
>  include/linux/property.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 083a95791d3b..fcc0687f5529 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -895,7 +895,7 @@ EXPORT_SYMBOL_GPL(device_get_dma_attr);
>   * 'phy-connection-type', and return its index in phy_modes table, or errno in
>   * error case.
>   */
> -int fwnode_get_phy_mode(struct fwnode_handle *fwnode)
> +int fwnode_get_phy_mode(const struct fwnode_handle *fwnode)
>  {
>  	const char *pm;
>  	int err, i;
> diff --git a/include/linux/property.h b/include/linux/property.h
> index f7100e836eb4..d18c8cc17315 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -396,7 +396,7 @@ enum dev_dma_attr device_get_dma_attr(const struct device *dev);
>  const void *device_get_match_data(const struct device *dev);
>  
>  int device_get_phy_mode(struct device *dev);
> -int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
> +int fwnode_get_phy_mode(const struct fwnode_handle *fwnode);
>  
>  void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
>  
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


