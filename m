Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C922E2F69
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Dec 2020 00:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgLZXsX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Dec 2020 18:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgLZXsW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Dec 2020 18:48:22 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F50C061757;
        Sat, 26 Dec 2020 15:47:42 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c5so7056174wrp.6;
        Sat, 26 Dec 2020 15:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kzI2MBTYva7U96gTMdRoE9qINNA+Cq6RZ4dSPhM8U1k=;
        b=hJM+G/aArmhCe9cR274A2+PGV6lQ/drZKAZwupEAAlgnFtX4aQZPx2DqEXbX7LGQkk
         YdgYKL15S6UQTVSNwr3QWdj5a0bQ/ggEQvuDO7TzVLipV0Vib95bOSvXey/5gVQez2Jc
         TiGZclktxHth2mxRD4m8Xu/QI16HD2GaRJuodWEU+7NYA08ZYjsCOEr2tZ3ZFWRnMull
         gYe3hEzyRXbW0lWl5dSKuNUI3P89K6wz8MfuBzOMuDZ6DUyL6y5kuSwhlhViSLWAB3ap
         SQLFuWIeg5v9zTwTKv1Fhr7uD8e+e2US2woYNrvXWQ23BTaRxZZ0O7BYM42npMRuw2rf
         wwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kzI2MBTYva7U96gTMdRoE9qINNA+Cq6RZ4dSPhM8U1k=;
        b=glQMUr9/fJRXqLcJbH3T+3VJwyMncsZRn2Df10BfPoYMT+2wbehHYInfXuhWWfqKOi
         DGY5hPaC++jMSHUDuQGtDC4/P8ke7X1YDZjb5W1XpvpMkZfMyAsugT+vsu+UKJQgGUn3
         heSusFKQnQAb4/ELx6hao2Vu5zD0VTOWi6aQUzvIcnHSUZO7/PNf7lMK618O6FdPvchT
         jRTIfnw/0CSsYQlMoCQytjMS5ypqc3JnDj5sNyetW+7QRuUG7lTnYWYqW9DoG8Veu+UL
         vX4DIwps3tR39QhY0rnixC1u5cHxvw6mI3LNZ1OggUBh/HfkApo6cTzeR52NkGvySAc9
         Olfg==
X-Gm-Message-State: AOAM531ZAp8kj+sWAdEFsMh7hpsevtbkV5GTDXU8cvmUGaNRd3qpLwUd
        8g8Y9Tjo7bjKT+nwh1rlN34=
X-Google-Smtp-Source: ABdhPJzwtl+Qm96JmW1M6/1w9dplkoiCaZcr7sxyqHDpk1gQAqoFP7RCWtUJRsftTRInmSLfgw167g==
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr43057569wrn.179.1609026459449;
        Sat, 26 Dec 2020 15:47:39 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id m17sm54312124wrn.0.2020.12.26.15.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Dec 2020 15:47:38 -0800 (PST)
Subject: Re: [PATCH v3 07/14] software_node: Add support for fwnode_graph*()
 family of functions
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
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
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <df4a5159-6d5e-3d4e-f164-3bd7c5e551eb@gmail.com>
Date:   Sat, 26 Dec 2020 23:47:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vft7gg1AcKCEU+E74eB_ZMouHFd-8uZ7pcVj5CoJzZpvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy

On 24/12/2020 12:24, Andy Shevchenko wrote:
> On Thu, Dec 24, 2020 at 3:14 AM Daniel Scally <djrscally@gmail.com> wrote:
>>
>> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>> This implements the remaining .graph_* callbacks in the
> 
> .graph_* ==> ->graph_*() ?
> 
>> fwnode operations structure for the software nodes. That makes
>> the fwnode_graph*() functions available in the drivers also
> 
> graph*() -> graph_*() ?

Both done.

>> when software nodes are used.
>>
>> The implementation tries to mimic the "OF graph" as much as
>> possible, but there is no support for the "reg" device
>> property. The ports will need to have the index in their
>> name which starts with "port@" (for example "port@0", "port@1",
> 
>> ...)
> 
> Looks not good, perhaps move to the previous line, or move port@1 example here?

Fixed - by expanding the lines to ~75 chars

> Few nitpicks here and there, after addressing them,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thank you!

>> +static struct fwnode_handle *
>> +swnode_graph_find_next_port(const struct fwnode_handle *parent,
>> +                           struct fwnode_handle *port)
>> +{
>> +       struct fwnode_handle *old = port;
>> +
>> +       while ((port = software_node_get_next_child(parent, old))) {
>> +               /*
>> +                * ports have naming style "port@n", so we search for children
>> +                * that follow that convention (but without assuming anything
>> +                * about the index number)
>> +                */
> 
>> +               if (!strncmp(to_swnode(port)->node->name, "port@",
> 
> You may use here corresponding _FMT macro.

>> +static int
>> +software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>> +                                  struct fwnode_endpoint *endpoint)
>> +{
>> +       struct swnode *swnode = to_swnode(fwnode);
>> +       int ret;
>> +
>> +       /* Ports have naming style "port@n", we need to select the n */
> 
>> +       ret = kstrtou32(swnode->parent->node->name + FWNODE_GRAPH_PORT_NAME_PREFIX_LEN,
> 
> Maybe a temporary variable?
> 
>   unsigned int prefix_len = FWNODE_GRAPH_PORT_NAME_PREFIX_LEN;
>   ...
>   ret = kstrtou32(swnode->parent->node->name + prefix_len,


Both discussed after Laurent's reply I think.
