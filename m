Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8092A53A6
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfIBKL5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 06:11:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:32291 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfIBKL5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 06:11:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 03:11:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="198557410"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2019 03:11:54 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4jJR-0008Me-O9; Mon, 02 Sep 2019 13:11:53 +0300
Date:   Mon, 2 Sep 2019 13:11:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 03/11] device property: Move fwnode_get_parent() up
Message-ID: <20190902101153.GA2680@smile.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902083240.20367-4-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 02, 2019 at 11:32:32AM +0300, Sakari Ailus wrote:
> Move fwnode_get_parent() above fwnode_get_next_parent(), making the order
> the same as in the header file.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/base/property.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 81bd01ed40427..3d9dffbe96378 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -556,6 +556,19 @@ int device_add_properties(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(device_add_properties);
>  
> +/**
> + * fwnode_get_parent - Return parent firwmare node
> + * @fwnode: Firmware whose parent is retrieved
> + *
> + * Return parent firmware node of the given node if possible or %NULL if no
> + * parent was available.
> + */
> +struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
> +{
> +	return fwnode_call_ptr_op(fwnode, get_parent);
> +}
> +EXPORT_SYMBOL_GPL(fwnode_get_parent);
> +
>  /**
>   * fwnode_get_next_parent - Iterate to the node's parent
>   * @fwnode: Firmware whose parent is retrieved
> @@ -577,19 +590,6 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
>  }
>  EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
>  
> -/**
> - * fwnode_get_parent - Return parent firwmare node
> - * @fwnode: Firmware whose parent is retrieved
> - *
> - * Return parent firmware node of the given node if possible or %NULL if no
> - * parent was available.
> - */
> -struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
> -{
> -	return fwnode_call_ptr_op(fwnode, get_parent);
> -}
> -EXPORT_SYMBOL_GPL(fwnode_get_parent);
> -
>  /**
>   * fwnode_get_next_child_node - Return the next child node handle for a node
>   * @fwnode: Firmware node to find the next child node for.
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


