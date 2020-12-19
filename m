Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFC52DF23B
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Dec 2020 00:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgLSXdx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 19 Dec 2020 18:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgLSXdw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Dec 2020 18:33:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626A4C0613CF;
        Sat, 19 Dec 2020 15:33:09 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w5so6914505wrm.11;
        Sat, 19 Dec 2020 15:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TGv42L+B9aa7qAxpWRyBbZLY6ULcN/FlT5xeAN8dMuw=;
        b=txs63BaDu3RVQvLZajEowBUpTB2XwwuRjU9slG6rxCGc7sXPTJ9ieDRip7gzuFoyx+
         QaUrpdv9ma+8K2TMyaUk2XiFSC10FRi/AVsP74EgbMDieTzsFuqM8NUMSLadiUQw8SMs
         KGVBrnP9glmMr9tzk5AiD2xeD/AqoTa08k+L2TwGBCb4YoE5eJ47BgqZBQdfc93tr81F
         sw6mawRq/WDi0MDgddnz4GDyLpkRiHbRqjgfJ3Whh9nHaJLJtY8fxJebEDszNodGCqIq
         zEAc7CS6kXeWW1vUNiTVeCCtw1McRTo5sHcQn/0NIdipeyC65t8XOewwY7FUuyD0i1n0
         JZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TGv42L+B9aa7qAxpWRyBbZLY6ULcN/FlT5xeAN8dMuw=;
        b=pXDrzWc1SdQSYBWTS+CNnmpSklXemLUNYcF8wuqiIQiGHPj7iDCXGmulb/RBc7ZXhO
         FhTJWFSI83CncYWzrp6eo10cYGu3JV4FDPtUWyIgdBhfI0f50osSCFMOX2mE3+jY9hQM
         psfj7WmKR2K4gISOyO5BXs5DEkvaT25W8q26wJDT48qWweXF2k0V26pCbCgj+BYEBz96
         sfGo9axEOorsAP1UJL44ogp8VdsXvsqv1fGygnKRxz2vTFUuX4fkIu+flqIINynv3Yxy
         +cEB4cFGqCZgSDC7TTns0G5Vdd3/pfxuVImdT3tYTzMipef2f//57s3GfAu7gNoeUOz4
         u1JQ==
X-Gm-Message-State: AOAM533iAeOngCb4G5NRM+q95ujM7IAB/P3WeB97ort4oGXtLeFreshy
        rw+sKCq/Ksn2Df6qqznu4hA=
X-Google-Smtp-Source: ABdhPJy3OLsPYXnsRbw4Xij6Mj6NtjxS9hHB1cnQtv7nU8dYukoTPjK1mnD7xjHwvyYV00NejCbArQ==
X-Received: by 2002:adf:bb89:: with SMTP id q9mr11546619wrg.250.1608420788072;
        Sat, 19 Dec 2020 15:33:08 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id l11sm20511730wrt.23.2020.12.19.15.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Dec 2020 15:33:07 -0800 (PST)
Subject: Re: [PATCH v2 04/12] software_node: Enforce parent before child
 ordering of nodes arrays
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
 <20201217234337.1983732-5-djrscally@gmail.com>
 <20201218202916.GA4077@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <f7fd8cb5-6c1e-fc72-c380-cedb4a459355@gmail.com>
Date:   Sat, 19 Dec 2020 23:33:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218202916.GA4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 18/12/2020 20:29, Andy Shevchenko wrote:
>> + * Register multiple software nodes at once. If any node in the array
>> + * has it's .parent pointer set, then it's parent **must** have been
> 
> it's => its in both cases?

Done, ty

>> + * registered before it is; either outside of this function or by
>> + * ordering the array such that parent comes before child.
>>   */
> 
> ...
> 
>> +		const struct software_node *parent = nodes[i].parent;
>> +
>> +		if (parent && !software_node_to_swnode(parent)) {
> 
> Can we have parent of swnode in an array not being an swnode?
> Either comment that parent for swnode can be swnode only (Heikki, was it an
> idea?) or check if parent is of swnode type and only that apply this
> requirement.

.parent can be a pointer to software_node only yes; I can add that to
the document comment.

>> +			ret = -EINVAL;
>> +			goto err_unregister_nodes;
>>  		}
> 
> ...
> 
>> + * Unregister multiple software nodes at once. If parent pointers are set up
>> + * in any of the software nodes then the array MUST be ordered such that
>> + * parents come before their children.
> 
> Shouldn't be consistent with above, i.e. **must** ?

Done also

