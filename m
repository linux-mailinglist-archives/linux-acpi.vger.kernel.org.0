Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B672E936D
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 11:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbhADKfy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 05:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbhADKfx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 05:35:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A8CC061574;
        Mon,  4 Jan 2021 02:35:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t16so31656544wra.3;
        Mon, 04 Jan 2021 02:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=S9leJBbZwK+TyUz26rmbmhoxgzjzl0t4ObrdlbkBZTw=;
        b=eo9BGLigweyV09+xjei/SdrwpwbavZ8ys+r3iIIuS+bigeDGAaCW1VUyz1xvb1jWcl
         5tD1K28UVh8g/S6dg3u9t50VVbB7S7SLhgPmIKR3WcCfz67anVHE+2VzVp8KAa+tw/m7
         IA/JwKp6QmDE8b9d1bMfMQhWe8dFrqpq1eyozk55gOGOaMdFiONx2traxgEUAcFaHvWW
         dUjFQJXuBd6ai+Uh7u+MasZrZE3Idj/bFHdB0Xi005CrahrKgWUzQ9r844Ey+jzT+ZPx
         oF/t6PHfkDTBZrKLxQm31yrVmE2dA4cKWCZCyMskWGv8/SQBE3+YO83lTsnfnN/jM7OS
         BrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=S9leJBbZwK+TyUz26rmbmhoxgzjzl0t4ObrdlbkBZTw=;
        b=KGVUtY5Q/ZdJaAn68PL5mM8gXTCDhytl+KUWfOx0isVyEqiouTYghDNPgndxh8Glll
         VonDyqM7hqS9EVkliEQFp55vASluugL/CV+pAQ43cQLb5sgAxIPG0D+MUWmewDnoFlrs
         bXLr+ZjjqTmpl7bIm2Kpups+Hdea5b3QuF/plWexXbyOT1kcsW3HOba8BTDSnRd+9cxN
         7JRiakS/rcUXkWXMisBYLqTArUfocZe7foKgfFWcDq7P0ApIUOAPmxBWxuePz2hSVaZN
         bQ4U+FcSw/6gLphB472zYCCPoZ3YsIqUACIjsDkFmeVpBEYwVGrMcVcoG3fHKYgZLh2e
         6Mhg==
X-Gm-Message-State: AOAM533V4+DMhgBWhbqve0ozPZ7J/YaEa/Rflf5+MDgeDHB8kclrs6de
        Hm+ShBElHHfp9SdavLlMsew=
X-Google-Smtp-Source: ABdhPJzED6wW3YagjcUwfqXJxwW5+Asxe3pfgjwQQ0/4l+hIHACspERo+CVNaiEFJAkV0fo5PA42pQ==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr78960388wru.64.1609756511883;
        Mon, 04 Jan 2021 02:35:11 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id z6sm94507074wrw.58.2021.01.04.02.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 02:35:11 -0800 (PST)
Subject: Re: [PATCH v4 08/15] software_node: Add support for fwnode_graph*()
 family of functions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org, lenb@kernel.org,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
 <20210103231235.792999-9-djrscally@gmail.com>
 <20210104102238.GQ4077@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <3a9bb04b-98d4-9fdb-8c67-0f05ee57d1fd@gmail.com>
Date:   Mon, 4 Jan 2021 10:35:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104102238.GQ4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy

On 04/01/2021 10:22, Andy Shevchenko wrote:
> On Sun, Jan 03, 2021 at 11:12:28PM +0000, Daniel Scally wrote:
>> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>> This implements the remaining .graph_*() callbacks in the fwnode
>> operations structure for the software nodes. That makes the
>> fwnode_graph_*() functions available in the drivers also when software
>> nodes are used.
>>
>> The implementation tries to mimic the "OF graph" as much as possible, but
>> there is no support for the "reg" device property. The ports will need to
>> have the index in their  name which starts with "port@" (for example
>> "port@0", "port@1", ...) and endpoints will use the index of the software
>> node that is given to them during creation. The port nodes can also be
>> grouped under a specially named "ports" subnode, just like in DT, if
>> necessary.
>>
>> The remote-endpoints are reference properties under the endpoint nodes
>> that are named "remote-endpoint".
> Couple of nitpicks below (can be considered as follow up, depends on yours and
> maintainer wishes).
>
Thanks
> +static int
> +software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
> +				   struct fwnode_endpoint *endpoint)
> +{
> +	struct swnode *swnode = to_swnode(fwnode);
> +	const char *parent_name = swnode->parent->node->name;
> +	int ret;
> +
> +	if (!(strlen(parent_name) > strlen("port@")) ||
> A nit:
>
> 	if (strlen("port@") >= strlen(parent_name) ||
>
> better to read

yeah agreed

>
>> +	    strncmp(parent_name, "port@", strlen("port@")))
>> +		return -EINVAL;
>> +
>> +	/* Ports have naming style "port@n", we need to select the n */
>> +	ret = kstrtou32(parent_name + strlen("port@"),
>> +			10, &endpoint->port);
> A nit:
>
> 	ret = kstrtou32(parent_name + strlen("port@"), 10, &endpoint->port);
>
> (perhaps you need to adjust your editor settings, this still fits 80)
Ah - my bad. Originally instead of parent_name there was
swnode->parent->node->name, which didn't fit. When I added the temp
variable I forgot to fix the line break - thanks.
