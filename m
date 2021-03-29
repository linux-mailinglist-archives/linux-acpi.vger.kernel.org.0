Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32634DC07
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 00:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhC2WqC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 18:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhC2Wpt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2021 18:45:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DBDC061762;
        Mon, 29 Mar 2021 15:45:49 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v4so14315589wrp.13;
        Mon, 29 Mar 2021 15:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=puc4F2ZnjQMhHuMpsfbm17RPo3S8OhUZZKJo6ZoQWoo=;
        b=a9t8sWlAljKzDwku1gTNdK0a+2gm/Jk184NTjgaxqMEH3jxIKu2UPJKvLtkgLi1wvU
         G+iFrAHXsgHlzHPYHIKxKVkzMsnqLJhTT2Wj2RhdbHeRrvaNeaXEy4g26bnxWRi/NgMa
         cheKoRrQ/7HLOctaYISbJf70Ygcen+C/Jm20IdXtESIMsq+d04v9DkShPpJ6ecaTxFCl
         mZzP0eUaOddoINtbchIqkA5MHcEeLVD+dnBlChZZ71TpINBGriqdRsu6bgudRMhw5KuB
         hYUebkQpeMbvah9NLzNuT/voNvGMr/VKeISuqpzDzHeJn9v7N9WTXInA2HFW9ruZ1aO2
         UmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=puc4F2ZnjQMhHuMpsfbm17RPo3S8OhUZZKJo6ZoQWoo=;
        b=DlhhwGlrWMO4VRmuLqctFUi7fta1hD/lgSK61kRUMD0R8G4IE3kiuhgr+KL4/IOKiX
         lv7mrkmA9aIafQtpD/xsbmf4dto8mj9h0jn5uuEn+5jXsQ+dGrfUoKjuYsptX1s8+R8H
         H2zr0/cP5mlJXcfBUP6zg5wEtuZx68qNlX60oC6a0YQqj3t8JnusGnjrW930L+8lFQE7
         euXVFs5cXAqzEJafhoOgxn+SAUZqjGz6/WV6fzJCzoXEQnKALGcJkx2Bgy6mcZQwJcSM
         leoohlK+ectj/uZJiZdONBzStcg3WIv6AFkZ7VeAYYzziXZSGiN/aX8PynNCTDs1sPLz
         vjFg==
X-Gm-Message-State: AOAM531W50RfBCfeXgIe0Yq0HzxjzKDwop9Af6cEIsunnq6NDPHTrT5W
        xYuASu4nlbQSwMYQ1Hm19yw=
X-Google-Smtp-Source: ABdhPJzit7y1R+uG2U9xJOLgkbrjFRmk3WaDhMPDrTw9OzeCS2ZozED46gd8TbfRAi+6GvQd235LBQ==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr30577726wrm.32.1617057948100;
        Mon, 29 Mar 2021 15:45:48 -0700 (PDT)
Received: from [192.168.1.211] ([91.110.20.103])
        by smtp.gmail.com with ESMTPSA id y1sm805296wmq.29.2021.03.29.15.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 15:45:47 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] software node: Free resources explicitly when
 swnode_register() fails
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <16227f6b-c52e-2b29-2b2c-53cd8935d5dd@gmail.com>
Date:   Mon, 29 Mar 2021 23:45:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy

On 29/03/2021 16:12, Andy Shevchenko wrote:
> Currently we have a slightly twisted logic in swnode_register().
> It frees resources that it doesn't allocate on error path and
> in once case it relies on the ->release() implementation.
>
> Untwist the logic by freeing resources explicitly when swnode_register()
> fails. Currently it happens only in fwnode_create_software_node().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Reviewed-by: Daniel Scally <djrscally@gmail.com>

and

Tested-by: Daniel Scally <djrscally@gmail.com>

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
