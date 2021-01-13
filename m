Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B88F2F4068
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jan 2021 01:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438312AbhAMAnR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 19:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392455AbhAMAkr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2021 19:40:47 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32124C061575;
        Tue, 12 Jan 2021 16:40:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 91so286425wrj.7;
        Tue, 12 Jan 2021 16:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=agaH5FJUb4ubbdgR/UcbnaFztHWYbAMVBCEVNxmNcy8=;
        b=AEiVjcsifZD/SApb4CWBqPM8yQ6WK74QGMmg2REtPE/Tdx+vurF8XkOdcLWRXrxdPU
         bQmqmRBuCE2cCYeK2XH2DHYBG6gT3IgNU0qZGQXy794LDOIS5/1U50L9IDAf2dD8G3iN
         2budy9g2NYNdLUH3UPmHas//5wOJFn8R1LReu6FQsgJLvC7JzbAeFW+0eTfjJRlfwZMe
         1IDCPT0oiFffYb4mQO5khNTAa+zHrtXbuIKksIIn4mkzTMUx3d5/HvSlAhgDMAyNRdk4
         79z2PIuoH7rMivFXbDKjLi84he2EQA578J+tgcyEPFVIMSSuhXFfFi5bgyZV7GL/Fl4A
         Z2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=agaH5FJUb4ubbdgR/UcbnaFztHWYbAMVBCEVNxmNcy8=;
        b=oR0ntZh3YRo3LFHC+BYtK4rn1MyRT/TQgijs3csb1M53T+Qmu4Uq8TWpZKbZVF4c0+
         NDEfObIUXJzAUH2TO6uXf9869k4wu3SjFIfcIEKt1LaptUOgG+rwacKb6MmktDunq8dB
         GOegmKRaT4xVIz6n2GoqRfxHGnlsbB184JNpGjoirSRfcUESXOrttPI7CzeTIA/oVgko
         0W6Q6YPOlXkalTCiIUzSBSZ34mFfo4WBwpsvjUQYag8AFi5CiDA0+G2clgGayes6fI1v
         GTUV6Wdlk5vg2atmkcwIGbvHZsgMruOpmRrx09U+qznt6JQ0ot6YZNxtBvAGKxfikETn
         n9Uw==
X-Gm-Message-State: AOAM5309a8fgOMKwWsDGqEKnU7yQ9kGJmhKIiBeWt9dULsX/dl2zHFbZ
        AqaiGrXEgnTJDC3vqOPZs2cvaYyYX+E=
X-Google-Smtp-Source: ABdhPJwvzNZjqoLMW8eDlE/oWXuA09aJJIhBO4f5MUR/UDgX93JftIaiVDErBWpr2ggyhb/0tiuEjw==
X-Received: by 2002:adf:9467:: with SMTP id 94mr1295788wrq.235.1610498405779;
        Tue, 12 Jan 2021 16:40:05 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id l8sm202548wrb.73.2021.01.12.16.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 16:40:04 -0800 (PST)
Subject: Re: [PATCH v2 1/3] software node: Introduce
 device_add_software_node()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
 <20210111141045.14027-2-heikki.krogerus@linux.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <2f552de5-4839-a1e5-3012-c56f9fa3bdd5@gmail.com>
Date:   Wed, 13 Jan 2021 00:40:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111141045.14027-2-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Heikki

On 11/01/2021 14:10, Heikki Krogerus wrote:
> This helper will register a software node and then assign
> it to device at the same time. The function will also make
> sure that the device can't have more than one software node.
> 
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---

I like this change. One comment below, but for what it's worth:

Reviewed-by: Daniel Scally <djrscally@gmail.com>

> +/**
> + * device_remove_software_node - Remove device's software node
> + * @dev: The device with the software node.
> + *
> + * This function will unregister the software node of @dev.
> + */
> +void device_remove_software_node(struct device *dev)
> +{
> +	struct swnode *swnode;
> +
> +	swnode = dev_to_swnode(dev);
> +	if (!swnode)
> +		return;
> +
> +	kobject_put(&swnode->kobj);
> +}
> +EXPORT_SYMBOL_GPL(device_remove_software_node);

I wonder if this also ought to set dev_fwnode(dev)->secondary back to
ERR_PTR(-ENODEV)?

> +
>  int software_node_notify(struct device *dev, unsigned long action)
>  {
> -	struct fwnode_handle *fwnode = dev_fwnode(dev);
>  	struct swnode *swnode;
>  	int ret;
>  
> -	if (!fwnode)
> -		return 0;
> -
> -	if (!is_software_node(fwnode))
> -		fwnode = fwnode->secondary;
> -	if (!is_software_node(fwnode))
> +	swnode = dev_to_swnode(dev);
> +	if (!swnode)
>  		return 0;
>  
> -	swnode = to_swnode(fwnode);
> -
>  	switch (action) {
>  	case KOBJ_ADD:
>  		ret = sysfs_create_link(&dev->kobj, &swnode->kobj,
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 0a9001fe7aeab..b0e413dc59271 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -488,4 +488,7 @@ fwnode_create_software_node(const struct property_entry *properties,
>  			    const struct fwnode_handle *parent);
>  void fwnode_remove_software_node(struct fwnode_handle *fwnode);
>  
> +int device_add_software_node(struct device *dev, const struct software_node *swnode);
> +void device_remove_software_node(struct device *dev);
> +
>  #endif /* _LINUX_PROPERTY_H_ */
> 

