Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1E7A36B5
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 14:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfH3MXC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Aug 2019 08:23:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:62153 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbfH3MXB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Aug 2019 08:23:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 05:23:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="186281544"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2019 05:22:58 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i3fvd-0007Oj-If; Fri, 30 Aug 2019 15:22:57 +0300
Date:   Fri, 30 Aug 2019 15:22:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 02/10] software node: Make argument to
 to_software_node const
Message-ID: <20190830122257.GZ2680@smile.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829101043.24963-3-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 29, 2019 at 01:10:35PM +0300, Sakari Ailus wrote:
> to_software_node() does not need to modify the fwnode_handle it operates
> on; therefore make it const. This allows passing a const fwnode_handle to
> to_software_node().
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/base/swnode.c    | 4 ++--
>  include/linux/property.h | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index a7cb41812cfda..951e7efd47c23 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -71,9 +71,9 @@ software_node_to_swnode(const struct software_node *node)
>  	return swnode;
>  }
>  
> -const struct software_node *to_software_node(struct fwnode_handle *fwnode)
> +const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
>  {
> -	struct swnode *swnode = to_swnode(fwnode);
> +	const struct swnode *swnode = to_swnode(fwnode);
>  
>  	return swnode ? swnode->node : NULL;
>  }
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 5a910ad795910..421c76e53708d 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -418,7 +418,8 @@ struct software_node {
>  };
>  
>  bool is_software_node(const struct fwnode_handle *fwnode);
> -const struct software_node *to_software_node(struct fwnode_handle *fwnode);
> +const struct software_node *
> +to_software_node(const struct fwnode_handle *fwnode);
>  struct fwnode_handle *software_node_fwnode(const struct software_node *node);
>  
>  int software_node_register_nodes(const struct software_node *nodes);
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


