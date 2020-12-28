Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79792E6B1D
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 00:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgL1Wzd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 17:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgL1ViG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Dec 2020 16:38:06 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C3EC0613D6;
        Mon, 28 Dec 2020 13:37:26 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g185so580623wmf.3;
        Mon, 28 Dec 2020 13:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tjuMWqX61cGzZmrb8GDkFEtjw2wV3E0sLXdDVgdaJmk=;
        b=TnSrLGWZjyaP3rgw3j4fiQoBIh8cvOL0+WDZ0EbvpQHJZTJhOTHX48H8wGz05VjGBX
         tbfgknkczgZejJewupBEZu4ut4R6zdrgmrmFDVc5xeJwG1EoDP6Mo73AaSJ+N9KkpxYg
         HtZTCOOAWLTDh1XKEb5KcSg9SJz0bUO941aAebv/VWFSelMnHv0wV9HbdOYwtwVJIkLZ
         C9eiQhyAlRqJ6T7xOaXUB84DV/cOaW4hvQejvwuH5bKh3qS8aq123biI31i8FlpYtx6m
         s8OLWYbF9IKGYQbZmRvkUAp8BXL+qSFVLp2Oe8BvH2BMaLaWsY2C6wNJH5oUoWfQI84G
         /s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tjuMWqX61cGzZmrb8GDkFEtjw2wV3E0sLXdDVgdaJmk=;
        b=msrRLGjLlJGK+0B4bPHg6oQ7f4SWDAEc43PUuXHuyGDiXAuZXHAo1wC2XHIEAU+ABX
         hPyvE28Zl6sQJQGjRC8H5a46I/aD1405UuK5bYZf28FO7f+GGCup1u/3EO6frurQodhs
         BvCYJqi6BTuDlrmbdC/aPp0eg8aF4/wVIbjgbF04WpUFPHNbvigLThJqxlFFvPJQa1+W
         d3I5RP13ttREUpdTqA8zb7wMYciWYcMK1WaJ8S+MMkrcXE4xk5aQGtSWtNJ7fPeRxcH8
         rix6GFBMXXsLgNYlFvzYsGyIjs7C58KsU6YCTX8XmzSJ/3WqLUZuXar/I0dzxXLkmdKj
         45CQ==
X-Gm-Message-State: AOAM5327WldCdl66D+usY3FQKn4uPTkfM9wlTm9JSgX/H/KVhaeOtlT+
        JuWQ7zTo3rYV6MnQLfjnM9I=
X-Google-Smtp-Source: ABdhPJxYAGP9CKttVXbiBA2bxywgtHY78VspJDUQexBoFrhwBMaUGe2gStN33DaKS/q/8Uwf6GKLUQ==
X-Received: by 2002:a1c:a9cc:: with SMTP id s195mr675559wme.97.1609191444945;
        Mon, 28 Dec 2020 13:37:24 -0800 (PST)
Received: from [192.168.1.158] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b83sm674105wmd.48.2020.12.28.13.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 13:37:24 -0800 (PST)
Subject: Re: [PATCH v3 07/14] software_node: Add support for fwnode_graph*()
 family of functions
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        niklas.soderlund+renesas@ragnatech.se,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-8-djrscally@gmail.com>
 <CAHp75Vft7gg1AcKCEU+E74eB_ZMouHFd-8uZ7pcVj5CoJzZpvQ@mail.gmail.com>
 <X+SPsks5itN9OFqB@pendragon.ideasonboard.com>
 <CAHp75Ve6YHm-tdqFPvOhfJiT=uRK_dpKY3mnhQd6Mg3KkSuKqA@mail.gmail.com>
 <d47e0ccf-9def-e9c9-fdfb-390ad5d2ee5e@gmail.com>
 <20201228164101.GY26370@paasikivi.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <46c23435-e32e-9de1-5055-efebc001ebad@gmail.com>
Date:   Mon, 28 Dec 2020 21:37:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201228164101.GY26370@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari

On 28/12/2020 16:41, Sakari Ailus wrote:
> Hi Daniel,
> 
> On Thu, Dec 24, 2020 at 02:21:15PM +0000, Daniel Scally wrote:
>> Hi Andy, Laurent
>>
>>> On Thu, Dec 24, 2020 at 2:55 PM Laurent Pinchart
>>> <laurent.pinchart@ideasonboard.com> wrote:
>>>> On Thu, Dec 24, 2020 at 02:24:12PM +0200, Andy Shevchenko wrote:
>>>>> On Thu, Dec 24, 2020 at 3:14 AM Daniel Scally wrote:
>>>
>>> ...
>>>
>>>>>> +               if (!strncmp(to_swnode(port)->node->name, "port@",
>>>>>
>>>>> You may use here corresponding _FMT macro.
>>>>>
>>>>>> +                            FWNODE_GRAPH_PORT_NAME_PREFIX_LEN))
>>>>>> +                       return port;
>>>
>>> ...
>>>
>>>>>> +       /* Ports have naming style "port@n", we need to select the n */
>>>>>
>>>>>> +       ret = kstrtou32(swnode->parent->node->name + FWNODE_GRAPH_PORT_NAME_PREFIX_LEN,
>>>>>
>>>>> Maybe a temporary variable?
>>>>>
>>>>>   unsigned int prefix_len = FWNODE_GRAPH_PORT_NAME_PREFIX_LEN;
>>>>>   ...
>>>>>   ret = kstrtou32(swnode->parent->node->name + prefix_len,
>>>>
>>>> Honestly I'm wondering if those macros don't hinder readability. I'd
>>>> rather write
>>>>
>>>>         + strlen("port@")
>>>
>>> Works for me, since the compiler optimizes this away to be a plain constant.
>>
>> Well, how about instead of the LEN macro, we have:
>>
>> #define FWNODE_GRAPH_PORT_NAME_PREFIX	"port@"
>> #define FWNODE_GRAPH_PORT_NAME_FMT FWNODE_GRAPH_PORT_NAME_PREFIX "%u"
>>
>> And then it's still maintainable in one place but (I think) slightly
>> less clunky, since we can do strlen(FWNODE_GRAPH_PORT_NAME_PREFIX)
>>
>> Or we can do strlen("port@"), I'm good either way :)
> 
> I'd be in favour of using strlen("port@") here.
> 
> At least for now. I think refactoring the use of such strings could be a
> separate set at another time, if that's seen as the way to go.

Alright - thanks. In that case I'll switch to strlen("port@0"), and
FWNODE_GRAPH_PORT_NAME_LEN can be dropped then I think.
