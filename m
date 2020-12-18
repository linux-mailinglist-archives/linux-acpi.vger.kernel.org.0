Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4F92DEC19
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Dec 2020 00:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgLRXrU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 18:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgLRXrT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2020 18:47:19 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB26C0617B0;
        Fri, 18 Dec 2020 15:46:39 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r3so4245165wrt.2;
        Fri, 18 Dec 2020 15:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CVUZDewVjbnAS4rVNDdhGUv6812bBoBX8FloR4mhQfY=;
        b=LQVpwPjWC+rUHtMvyQSO2kGfFZ6mDpYwAFv8SZMMTP0bhZjlgy++49CszYHYfklMjA
         j4oKZvyOyj9AY5jJxF6p3YAggoImcqKqKa27j8BjNFkKONTSAAOSIXwthantYKZgTlok
         dBoqC1iAYNIxzruRpdR52FssBg16j3UDUTMQdExvTqVgSmokZRUVhxRgvRmUNHWvQgLM
         OhQ+m1E5b2WpjzjUKXa30v9ghy+pD0D5+MKFzC7D5L7KhN/LOfVYfpy4skqhW3eGsDk6
         XXMba55diAEeLWmRbShS44l9T+8HEOKSL37YerSWajhWu8Xa9fjCQEUMU+fPq+yuMm6E
         u6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CVUZDewVjbnAS4rVNDdhGUv6812bBoBX8FloR4mhQfY=;
        b=DClvmVC+6LmABsJaE3xYvfXqgKzwAMVTvs+ra6+Uy2HJtP1H2NUoVSc1FBFyo0DTTU
         L+8DogXrM7V4YeRXN5iDGzl50h8DDR/j/lLihuGbP7ATd4ZyF70dZEECxk6c22paVNc/
         x7mndPBw8LSWYiNWcNlaZD12DB/FwVIz9SBMZ2ngDzdmFETaSAukXV9Olhd5lMcaeyBL
         bHD+tLzlNhymwauyTUoHrUhwwkVDT4dMU/ZWnZA2Cjxp2bt0yT7hpNDRoXgF/cHfGWZJ
         hlQj4fPb1nDAr5uQW+C7eNdGrKmag5120ScB5Mxr9kHCgZrHy0YhGxBGDyV5fTL7BAF8
         tMSg==
X-Gm-Message-State: AOAM5328RMzORDgOADvasgTv+K5qWibeaDUPPyFIsRTTCP3wtawijKcK
        N6zeWugmK83hCmjuItWgJnc=
X-Google-Smtp-Source: ABdhPJx2UQOLsIf2OalZVqW5ESze04/v9Ukl2g12dxgUkqySNr4VHiXXJHF4dNUCfswYHvLpW4Iz1w==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr6814722wru.410.1608335196953;
        Fri, 18 Dec 2020 15:46:36 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id c20sm9333375wmb.38.2020.12.18.15.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 15:46:35 -0800 (PST)
Subject: Re: [PATCH v2 06/12] software_node: Add support for fwnode_graph*()
 family of functions
From:   Daniel Scally <djrscally@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-7-djrscally@gmail.com>
 <X9zXPpirfS2mCFk0@pendragon.ideasonboard.com>
 <8d448981-ddd5-9e2e-03bc-0a67b318d379@gmail.com>
Message-ID: <ea73b9ca-d0c0-060d-5af6-f7a82f36b136@gmail.com>
Date:   Fri, 18 Dec 2020 23:46:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8d448981-ddd5-9e2e-03bc-0a67b318d379@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 18/12/2020 22:13, Daniel Scally wrote:

>>> +			break;
>>> +		}
>>> +
>>> +		/* No more endpoints for that port, so stop passing old */
>>> +		old = NULL;
>>
>> I wonder if you could drop the 'old' variable and use 'enpoint' in the
>> call to software_node_get_next_child(). You could then drop these two
>> lines.
> 
> That won't work, because endpoint would at that point not be a child of
> the port we're passing, and the function relies on it being one:
> 
> 	if (!p || list_empty(&p->children) ||
> 	    (c && list_is_last(&c->entry, &p->children))) {
> 		fwnode_handle_put(child);
> 		return NULL;
> 	}
> 

Wait, that's nonsense of course, because endpoint gets set to NULL when
software_node_get_next_child() finds nothing - I'll double check but
pretty sure you're right.
