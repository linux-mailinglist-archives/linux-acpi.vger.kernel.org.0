Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9209D2DFAD6
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Dec 2020 11:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgLUKIe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Dec 2020 05:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgLUKId (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2020 05:08:33 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AF9C0613D3;
        Mon, 21 Dec 2020 02:07:52 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jx16so12596695ejb.10;
        Mon, 21 Dec 2020 02:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2OyCY7MUawhRtF8zSgGn+tDkG/srtG90JrYQFup8Chk=;
        b=r232zX9L4pt1bWMcL3zAh5nuTLsxd5quAH0m0mE7Um6SZ0HAHHAmTcCvGIp24oVJks
         mlTtso9p1uUOo+WQuksmGhR8VGgWBfFiPSO95y8SSccP6AYqeJy03puh8ZF3KkXaMvpY
         DQsE68Jq22vObIGcXb9dA09vKtnHem/Qg0qGW8WIw9TGRAYTyT3MjC4sN5ycbdtYC/He
         OL4g5Km7jAGyygO1lSarq/HBaaqkKtHI5Dw8S3T5e3Y9+f08I+eBq1wkalAvN56+8idK
         mRf6lFdbZU/N4HseUY0+VPsAbJof0kTrU3nzBB0NfgnJJxW46ycVk73iflwX5R4fuNb8
         lvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2OyCY7MUawhRtF8zSgGn+tDkG/srtG90JrYQFup8Chk=;
        b=m9nFiNXom6wQU3ep89wtHbos5w47v74n/WyNbjV+rbtfoLTSAQhoOg6kUW2az4Ki+H
         7THv0WftG8FD3JveOjahezMXx3qZHsFHngHnsfBAWAeOr+pfJ2L6dqseS7twtYHwyjDS
         tdGsDJOSRfHoun0bWoLB3TO2Ni4HafElg5mz4nWHR6JJGFpRUUH0mr+28nedNmKi1tsa
         9XW0HZqtl0n/2aVh+8m00ve3ur8wra65i3IIGEPAJQIOS9a8/gZTz8zZsAP3zG9/4eJs
         FhDrBrWjcmKiS/D5CRiL1MiPWt4uAl3Q/DM13fjIPWlWXNQtjBDjYqvIfHuu09bVZtWk
         VNDQ==
X-Gm-Message-State: AOAM532lQHiocz3N6b2v7VTf52Hbftl9+1P0EYahuLRq09+Y7MKx6Dpk
        tIf+FURmq6qohBDehKqMFiPqVgFiD/LcRSbq
X-Google-Smtp-Source: ABdhPJzHPhFrUHgP7kL2GQAEUaECuiJfhpNAkZ6c1nD3LzX82BD9u6rIoTN+YEiVFx0OZgXhyYUBNg==
X-Received: by 2002:adf:9d83:: with SMTP id p3mr18118002wre.313.1608544912002;
        Mon, 21 Dec 2020 02:01:52 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id w13sm25525501wrt.52.2020.12.21.02.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 02:01:51 -0800 (PST)
Subject: Re: [PATCH v2 06/12] software_node: Add support for fwnode_graph*()
 family of functions
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-7-djrscally@gmail.com>
 <20201221093408.GH26370@paasikivi.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <b6228b89-cbc8-9b8a-6a68-a401e2e803fc@gmail.com>
Date:   Mon, 21 Dec 2020 10:01:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201221093408.GH26370@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari - thanks for the reviews in previous emails

On 21/12/2020 09:34, Sakari Ailus wrote:
> Hi Daniel and Heikki,
>
> On Thu, Dec 17, 2020 at 11:43:31PM +0000, Daniel Scally wrote:
>
> +static struct fwnode_handle *
> +software_node_graph_get_port_parent(struct fwnode_handle *fwnode)
> +{
> +	struct swnode *swnode = to_swnode(fwnode);
> +	struct fwnode_handle *parent;
> +
> +	if (!strcmp(swnode->parent->node->name, "ports"))
> +		parent = &swnode->parent->parent->fwnode;
> +	else
> +		parent = &swnode->parent->fwnode;
> If you happen to call this function on a non-port node for whatever reason,
> you may end up accessing a pointer that's NULL, can't you?

Yes, actually.

> Instead I'd do
> something like:
>
> swnode = swnode->parent;
> if (swnode && !strcmp(swnode->node->name, "ports"))
> 	swnode = swnode->parent;
>
> return swnode ? software_node_get(&swnode->fwnode) : NULL;
>
> You can also drop parent as a by-product of this.
Yes ok, that looks good to me - thanks.
>> +
>> +	return software_node_get(parent);
>> +}
>> +
>> +static int
>> +software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>> +				   struct fwnode_endpoint *endpoint)
>> +{
>> +	struct swnode *swnode = to_swnode(fwnode);
>> +	int ret;
>> +
>> +	ret = kstrtou32(swnode->parent->node->name + 5, 10, &endpoint->port);
>> +	if (ret)
>> +		return ret;
>> +
>> +	endpoint->id = swnode->id;
>> +	endpoint->local_fwnode = fwnode;
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct fwnode_operations software_node_ops = {
>>  	.get = software_node_get,
>>  	.put = software_node_put,
>> @@ -551,7 +655,11 @@ static const struct fwnode_operations software_node_ops = {
>>  	.get_parent = software_node_get_parent,
>>  	.get_next_child_node = software_node_get_next_child,
>>  	.get_named_child_node = software_node_get_named_child_node,
>> -	.get_reference_args = software_node_get_reference_args
>> +	.get_reference_args = software_node_get_reference_args,
>> +	.graph_get_next_endpoint = software_node_graph_get_next_endpoint,
>> +	.graph_get_remote_endpoint = software_node_graph_get_remote_endpoint,
>> +	.graph_get_port_parent = software_node_graph_get_port_parent,
>> +	.graph_parse_endpoint = software_node_graph_parse_endpoint,
>>  };
>>  
>>  /* -------------------------------------------------------------------------- */
