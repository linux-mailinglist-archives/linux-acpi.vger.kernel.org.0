Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF9234BB73
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Mar 2021 08:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhC1Gpp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Mar 2021 02:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhC1Gpa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 28 Mar 2021 02:45:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D0256194B;
        Sun, 28 Mar 2021 06:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616913930;
        bh=V5RpuwVxE2xlFXjlBeiGEZq40sCLDKCXJW5QQK3/0uQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xUbNqFvtb69lRSVGccaQuXiljG+0hoYeyEx7FYAtsdvwcL0D+TQj2RUyHa/qMAaH3
         c/OmnPeahOocPzuDSgNFSIQRVGFQYHuriIJCBTZTwZ7RK2+brbMMCjxhERS1rJxdjl
         vburE002jlLlfiIUmPAm/tXL5t6qZGEk7I/vEEFw=
Date:   Sun, 28 Mar 2021 08:45:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 3/8] software node: Show properties and their values
 in sysfs
Message-ID: <YGAmB2Nwph6pArXc@kroah.com>
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
 <20210327222012.54103-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327222012.54103-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Mar 28, 2021 at 12:20:07AM +0200, Andy Shevchenko wrote:
> It's very convenient to see what properties and their values
> are currently being assigned in the registered software nodes.
> 
> Show properties and their values in sysfs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/swnode.c | 137 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 132 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 19aa44bc2628..d7fe1a887d2d 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> +#include <linux/sysfs.h>
>  
>  struct swnode {
>  	int id;
> @@ -17,6 +18,10 @@ struct swnode {
>  	struct fwnode_handle fwnode;
>  	const struct software_node *node;
>  
> +	/* properties in sysfs */
> +	struct kobj_attribute *property_attrs;
> +	struct attribute_group property_group;
> +
>  	/* hierarchy */
>  	struct ida child_ids;
>  	struct list_head entry;
> @@ -25,6 +30,7 @@ struct swnode {
>  
>  	unsigned int allocated:1;
>  	unsigned int managed:1;
> +	unsigned int properties:1;
>  };
>  
>  static DEFINE_IDA(swnode_root_ids);
> @@ -299,6 +305,18 @@ static int property_entry_copy_data(struct property_entry *dst,
>  	return 0;
>  }
>  
> +static int property_entries_count(const struct property_entry *properties)
> +{
> +	int n = 0;
> +
> +	if (properties) {
> +		while (properties[n].name)
> +			n++;
> +	}
> +
> +	return n;
> +}
> +
>  /**
>   * property_entries_dup - duplicate array of properties
>   * @properties: array of properties to copy
> @@ -310,15 +328,13 @@ struct property_entry *
>  property_entries_dup(const struct property_entry *properties)
>  {
>  	struct property_entry *p;
> -	int i, n = 0;
> +	int i, n;
>  	int ret;
>  
> -	if (!properties)
> +	n = property_entries_count(properties);
> +	if (n == 0)
>  		return NULL;
>  
> -	while (properties[n].name)
> -		n++;
> -
>  	p = kcalloc(n + 1, sizeof(*p), GFP_KERNEL);
>  	if (!p)
>  		return ERR_PTR(-ENOMEM);
> @@ -746,6 +762,108 @@ static void software_node_free(const struct software_node *node)
>  	kfree(node);
>  }
>  
> +static ssize_t
> +swnode_property_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	struct swnode *swnode = kobj_to_swnode(kobj);
> +	const struct property_entry *prop;
> +	const void *pointer;
> +	ssize_t len = 0;
> +	int i;
> +
> +	prop = property_entry_get(swnode->node->properties, attr->attr.name);
> +	if (!prop)
> +		return -EINVAL;
> +
> +	/* We can't fail here, because it means boolean property */
> +	pointer = property_get_pointer(prop);
> +	if (!pointer)
> +		return sysfs_emit(buf, "\n");
> +
> +	switch (prop->type) {
> +	case DEV_PROP_U8:
> +		for (i = 0; i < prop->length / sizeof(u8); i++)
> +			len += sysfs_emit_at(buf, len, "%u,", ((u8 *)pointer)[i]);

No, sysfs is "one value per file", and that is not what you are showing
here at all :(

Also, there is no Documentation/ABI/ entries for your new sysfs files,
so that means we couldn't take this patcheset anyway :(

greg k-h
