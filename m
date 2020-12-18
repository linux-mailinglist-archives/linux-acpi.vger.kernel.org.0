Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7292DEB83
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 23:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgLRW05 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 17:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgLRW05 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2020 17:26:57 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA08C0617A7;
        Fri, 18 Dec 2020 14:26:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 91so3947423wrj.7;
        Fri, 18 Dec 2020 14:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=undQte4X2FcEvPuG/YAR1Svj9MB+K1VydBFnJEQJ3j0=;
        b=D/8EuaaHdROnnKgZudh1+gjHHjcTJyrP15sHF1tfdNXNjHCikAnzMMm8yRuXthdtQL
         NjYBlhi4cgCZToa/9En9vH3aztLOIsYc6TLz5SGFmV3mJhfNMSjOvFMjSJjK5BX4iKj5
         1v31BC8Q420vkDKC7VcLPJdTj6KJQuLk8Y0zTapaYz/xUoXRqB7nV1BNJ6TebsygfKuQ
         mJAVj3gCa6Sr2XKRRWqy9vfPmJc5P6WQ76su4oS4yE8oaaKDPmWDUGDVheEdy7qDMuGE
         k7K8yn7ibsGBtCZTxj5n2qLzXaq+N1WDDH53aS2mDog204Fml0MyzrtdDcblsjwmxA8Q
         9udQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=undQte4X2FcEvPuG/YAR1Svj9MB+K1VydBFnJEQJ3j0=;
        b=aVFzI2kne1lR1eD1BLOyOiYRPkoORoQGJRONIBGuwHLOAUkYQxWd2HOSqSYRVzWc3m
         h7+QjFooaYYegC4/8WEEInWfZrBINhYd1GBR9w3fI3o7xoMcg2pWyK8IXKHrCkzX24Sv
         zn9rENz+Vhi+jIcUvYbZ2GC7AO3PY+UYsW9R2vCbvWsFl0xzEEVKPW5TSgsJejQSLl6N
         XSj5gAv9iESq3RIhYB63Tcg+osOLQvio7br4DDRB1XRdF6wXx8ZIqTLpjLOj/P8DjbPy
         CbZHqclWDG1M6VBnSGq37nbUnTV0HGyqDqLNszwpTAvCFtmqND7290g6xguh7XfaYXI7
         p9lQ==
X-Gm-Message-State: AOAM533XlIS0hPiCi8jvmYoZD0q+gb+JHebHKxVicqnxiEg1mSff4QWx
        l37oPMeBxYDP4DeymytHvoM=
X-Google-Smtp-Source: ABdhPJw1a04trNyvSCGWpW8jL6UL3dyhHbCvFT4+ZBFflDqnDWWnGf83ElAPouwz0Eh5ChMtiiyPAw==
X-Received: by 2002:a5d:4f8a:: with SMTP id d10mr6583266wru.219.1608330375620;
        Fri, 18 Dec 2020 14:26:15 -0800 (PST)
Received: from [192.168.1.158] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b4sm14701628wrr.30.2020.12.18.14.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 14:26:14 -0800 (PST)
Subject: Re: [PATCH v2 06/12] software_node: Add support for fwnode_graph*()
 family of functions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-7-djrscally@gmail.com>
 <20201218203728.GC4077@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <6ba5c14a-e88b-0bb3-86f7-a7d93741bc31@gmail.com>
Date:   Fri, 18 Dec 2020 22:26:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218203728.GC4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 18/12/2020 20:37, Andy Shevchenko wrote:
> On Thu, Dec 17, 2020 at 11:43:31PM +0000, Daniel Scally wrote:
>> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>> This implements the remaining .graph_* callbacks in the
>> fwnode operations structure for the software nodes. That makes
>> the fwnode_graph*() functions available in the drivers also
>> when software nodes are used.
>>
>> The implementation tries to mimic the "OF graph" as much as
>> possible, but there is no support for the "reg" device
>> property. The ports will need to have the index in their
>> name which starts with "port@" (for example "port@0", "port@1",
>> ...) and endpoints will use the index of the software node
>> that is given to them during creation. The port nodes can
>> also be grouped under a specially named "ports" subnode,
>> just like in DT, if necessary.
>>
>> The remote-endpoints are reference properties under the
>> endpoint nodes that are named "remote-endpoint".
> 
> ...
> 
>> +	while ((port = software_node_get_next_child(parent, old))) {
>> +		if (!strncmp(to_swnode(port)->node->name, "port", 4))
>> +			return port;
>> +		old = port;
>> +	}
> 
> Dunno if we need defines for port and its length here.

Mmm, maybe a comment?

> ...
> 
>> +	ret = kstrtou32(swnode->parent->node->name + 5, 10, &endpoint->port);
> 
> But here at least comment is needed what 5 means ('port@' I suppose).

Ack - I'll add an explanatory comment (and yep, it's 'port@')

>> +	if (ret)
>> +		return ret;
> 
> 

