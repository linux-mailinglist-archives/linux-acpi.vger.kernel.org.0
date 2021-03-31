Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D61D34FF3D
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Mar 2021 13:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhCaLGa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Mar 2021 07:06:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:26058 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhCaLGF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 Mar 2021 07:06:05 -0400
IronPort-SDR: 5OI8knrGz8q+BiCRewYicv3MqKA0Vk9h//jiW8PG4K5ePpbrJBomDDA1Hqlp1+9ZFc1TJNIOej
 4T5275G4X5+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="192083221"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="192083221"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 04:06:04 -0700
IronPort-SDR: XzGh5lSiolpa/fDBqs9RxwBFxBPEJO4O+W8I7NQ1snTiw6qs5Tw/HaHmDbflCY4qD2lHLXLIRJ
 xpitzpxrCd1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="516846513"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 31 Mar 2021 04:06:00 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Mar 2021 14:06:00 +0300
Date:   Wed, 31 Mar 2021 14:06:00 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/6] software node: Free resources explicitly when
 swnode_register() fails
Message-ID: <YGRXmOMfCTxy31Rj@kuha.fi.intel.com>
References: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 29, 2021 at 06:12:02PM +0300, Andy Shevchenko wrote:
> Currently we have a slightly twisted logic in swnode_register().
> It frees resources that it doesn't allocate on error path and
> in once case it relies on the ->release() implementation.
> 
> Untwist the logic by freeing resources explicitly when swnode_register()
> fails. Currently it happens only in fwnode_create_software_node().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It all looks OK to me. FWIW, for the whole series:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2: no changes
>  drivers/base/swnode.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index fa3719ef80e4..456f5fe58b58 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -767,22 +767,19 @@ swnode_register(const struct software_node *node, struct swnode *parent,
>  	int ret;
>  
>  	swnode = kzalloc(sizeof(*swnode), GFP_KERNEL);
> -	if (!swnode) {
> -		ret = -ENOMEM;
> -		goto out_err;
> -	}
> +	if (!swnode)
> +		return ERR_PTR(-ENOMEM);
>  
>  	ret = ida_simple_get(parent ? &parent->child_ids : &swnode_root_ids,
>  			     0, 0, GFP_KERNEL);
>  	if (ret < 0) {
>  		kfree(swnode);
> -		goto out_err;
> +		return ERR_PTR(ret);
>  	}
>  
>  	swnode->id = ret;
>  	swnode->node = node;
>  	swnode->parent = parent;
> -	swnode->allocated = allocated;
>  	swnode->kobj.kset = swnode_kset;
>  	fwnode_init(&swnode->fwnode, &software_node_ops);
>  
> @@ -803,16 +800,17 @@ swnode_register(const struct software_node *node, struct swnode *parent,
>  		return ERR_PTR(ret);
>  	}
>  
> +	/*
> +	 * Assign the flag only in the successful case, so
> +	 * the above kobject_put() won't mess up with properties.
> +	 */
> +	swnode->allocated = allocated;
> +
>  	if (parent)
>  		list_add_tail(&swnode->entry, &parent->children);
>  
>  	kobject_uevent(&swnode->kobj, KOBJ_ADD);
>  	return &swnode->fwnode;
> -
> -out_err:
> -	if (allocated)
> -		property_entries_free(node->properties);
> -	return ERR_PTR(ret);
>  }
>  
>  /**
> @@ -963,6 +961,7 @@ struct fwnode_handle *
>  fwnode_create_software_node(const struct property_entry *properties,
>  			    const struct fwnode_handle *parent)
>  {
> +	struct fwnode_handle *fwnode;
>  	struct software_node *node;
>  	struct swnode *p = NULL;
>  	int ret;
> @@ -987,7 +986,13 @@ fwnode_create_software_node(const struct property_entry *properties,
>  
>  	node->parent = p ? p->node : NULL;
>  
> -	return swnode_register(node, p, 1);
> +	fwnode = swnode_register(node, p, 1);
> +	if (IS_ERR(fwnode)) {
> +		property_entries_free(node->properties);
> +		kfree(node);
> +	}
> +
> +	return fwnode;
>  }
>  EXPORT_SYMBOL_GPL(fwnode_create_software_node);
>  
> -- 
> 2.30.2

thanks,

-- 
heikki
