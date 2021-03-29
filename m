Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A33634D96C
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhC2VHI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 17:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhC2VHC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2021 17:07:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E20C061574;
        Mon, 29 Mar 2021 14:07:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso7329268wmi.0;
        Mon, 29 Mar 2021 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wymBNLQAb/qlX8skiczhdYWHj6Aq/qxq8MM3GFnILNk=;
        b=QVOE8LnKESKbPxunJ6fQ9EXEX+saGlPLvUljMlASbWCVGt5Z5v5JJ/1XrJ1SwqhLwj
         BVf10Wz+LCPJn/fexc0jfYp1j+HoH9+7Mlz030SCb/GGeZnwG0S8Ih12G3YEXMGoOi6t
         OWa6ClmRZTt+dAsNnC2Pwv/f/QUPamz/35uxAhubNGzPgDMyVFmHeJ8MQopcy5o1KNL5
         8pOawJu36repMumXomXPTuVvHbxFISk82GfRNNJT5ATjbScIMChU03DHyNnMdniDy+5W
         6a1V2OrDdNN/qyhNJt76EIaqWJdlVanuGEmTHoFajZkWaaYl08Z6w+Cykqpu58WYSckT
         LI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wymBNLQAb/qlX8skiczhdYWHj6Aq/qxq8MM3GFnILNk=;
        b=c2UUIGfm0wTOCnoKFXUHqJCnNxn+31bduI7rdWW60dVJugWYABxixXLKvdvoV9uJCt
         0C7S99ihA7/8Yz7BrZhvSus3zvxAehSpx1JvjnUKhtH/GEZBiDsUHqvIWENje1d+j7ye
         DEuaGhJReRTExIEfdPoorD0niNwh9S8Yg9j43Y5ipHneq+O//Ejar2bn40JbhqxWmQoC
         aYU+Jio2/UnKaq7FQFgcYiU9XIU9leeRGn4e/AGrG94N/9xNt/t4SVwHK7QaINZyf496
         UvQtUnTDilEDElhwcTP3boOSi3ShhIkcPlez2C+HJ7xvcmwaVQKNLmLrCwUFHAdINh2o
         dDZA==
X-Gm-Message-State: AOAM533byK9GlQDXpXY0DKt1RYdLoCQefHzvjh095/Xb/dRv/qdTPM9t
        Oogo9L4m/3XS5iGxZanfeRz7Ri6WqBU=
X-Google-Smtp-Source: ABdhPJzrCb3hXadhWOgxbjhl5szV15i9EJFpYsUh+E3AMNwO/aTgKe+zuY5tAvDd6aIFy++rKE6Qog==
X-Received: by 2002:a05:600c:2145:: with SMTP id v5mr790346wml.65.1617052020546;
        Mon, 29 Mar 2021 14:07:00 -0700 (PDT)
Received: from [192.168.1.211] ([91.110.20.103])
        by smtp.gmail.com with ESMTPSA id a15sm21389883wrr.53.2021.03.29.14.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 14:07:00 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] software node: Deduplicate code in
 fwnode_create_software_node()
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
 <20210329151207.36619-3-andriy.shevchenko@linux.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <4e922df6-4c87-9a95-538c-dc777ebaccab@gmail.com>
Date:   Mon, 29 Mar 2021 22:06:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210329151207.36619-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy

On 29/03/2021 16:12, Andy Shevchenko wrote:
> Deduplicate conditional and assignment in fwnode_create_software_node(),
> i.e. parent is checked in two out of three cases and parent software node
> is assigned by to_swnode() call.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Reviewed-by: Daniel Scally <djrscally@gmail.com>

> ---
> v2: no changes
>  drivers/base/swnode.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 19aa44bc2628..db982859171e 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -973,15 +973,14 @@ fwnode_create_software_node(const struct property_entry *properties,
>  {
>  	struct fwnode_handle *fwnode;
>  	struct software_node *node;
> -	struct swnode *p = NULL;
> -
> -	if (parent) {
> -		if (IS_ERR(parent))
> -			return ERR_CAST(parent);
> -		if (!is_software_node(parent))
> -			return ERR_PTR(-EINVAL);
> -		p = to_swnode(parent);
> -	}
> +	struct swnode *p;
> +
> +	if (IS_ERR(parent))
> +		return ERR_CAST(parent);
> +
> +	p = to_swnode(parent);
> +	if (parent && !p)
> +		return ERR_PTR(-EINVAL);
>  
>  	node = software_node_alloc(properties);
>  	if (IS_ERR(node))
