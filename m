Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883892E279A
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 15:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgLXOV7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Dec 2020 09:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgLXOV7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2020 09:21:59 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ABDC061794;
        Thu, 24 Dec 2020 06:21:18 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t30so2336244wrb.0;
        Thu, 24 Dec 2020 06:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=290qlAj9/wIw73WZ0l4W99gBHafzKX3LexaIq9Kbj8U=;
        b=H9IK62WB6jMmUFDg7RSJNvniwFUqmjdFIKzyYfj+RwCDdYSPuSroL6eBRLv8eVZ1Cy
         laPMMShRTovyn+4hKMvHimz2EOcmiiM8wUEtoquUtc5qN9wwK7vhuFCtmolrJ84xCRnj
         Y56bXcM9MIdixqjr3UM8SM9DUt/Oibf+OmHSNY7bziTGwpEzqLTcisda3iqDWOMhlmqo
         nbQv7zyg+939bA6LNeL/WFyM3cFz8dIUaFsG/0x2v0tJXYR7kzkgaARUvEt5ga2+j6kn
         l+sjTN0wNnlsweBiL976XpqYLrRLfbxxLfwgXOUL+6yFVqplC36ydG4mBpxafmOwou6n
         vqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=290qlAj9/wIw73WZ0l4W99gBHafzKX3LexaIq9Kbj8U=;
        b=JCK67CWqLksLE/S5Q000u8pogUxR2nWT1UTRvUksdYLUi6SBhOr/tUE7HzLNs6QRN/
         a4PSCJ9D+LpqdQ0Vh90Xo+crEA/Uivqtmo8zkA8bPBfpICittyXJJNN+5duWs7H2/wOl
         aAfrV5FbKvHrQ28OZjjQ27rKScmDNbV2Dkxg0gZ2jOoGOWjghN4eLBSNmTiRZq3F8wTR
         4I4Rlg+HdcDMyCkSFY8ld5/v6QfIFVgrOHutJMpbkyJJ0I3w+F2PWALlMC4kcsnIW+J7
         Z2rXDXAs69glEiY4jpml+fv2N30pa52nXDKF+Wcw8GRbOHly/PsCjYvKi04na05UATds
         +j5A==
X-Gm-Message-State: AOAM530py1N1e2kSgxl0xCCeo+JR3H/sndm6sxa4c+gkOcZpU7Qdszmj
        0XN3bK1x7/+1zrqyMw5fGNY=
X-Google-Smtp-Source: ABdhPJxwdOtDBlVfQIHVLEKHHof6seG/XVVw9+uHRHUBsSzYk42WKjnntQucO6c8Fh6rR3yG8w7FCQ==
X-Received: by 2002:adf:fd05:: with SMTP id e5mr34705157wrr.225.1608819677538;
        Thu, 24 Dec 2020 06:21:17 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id l20sm44277150wrh.82.2020.12.24.06.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Dec 2020 06:21:17 -0800 (PST)
Subject: Re: [PATCH v3 07/14] software_node: Add support for fwnode_graph*()
 family of functions
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
 <X+SPsks5itN9OFqB@pendragon.ideasonboard.com>
 <CAHp75Ve6YHm-tdqFPvOhfJiT=uRK_dpKY3mnhQd6Mg3KkSuKqA@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <d47e0ccf-9def-e9c9-fdfb-390ad5d2ee5e@gmail.com>
Date:   Thu, 24 Dec 2020 14:21:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve6YHm-tdqFPvOhfJiT=uRK_dpKY3mnhQd6Mg3KkSuKqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy, Laurent

> On Thu, Dec 24, 2020 at 2:55 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> On Thu, Dec 24, 2020 at 02:24:12PM +0200, Andy Shevchenko wrote:
>>> On Thu, Dec 24, 2020 at 3:14 AM Daniel Scally wrote:
> 
> ...
> 
>>>> +               if (!strncmp(to_swnode(port)->node->name, "port@",
>>>
>>> You may use here corresponding _FMT macro.
>>>
>>>> +                            FWNODE_GRAPH_PORT_NAME_PREFIX_LEN))
>>>> +                       return port;
> 
> ...
> 
>>>> +       /* Ports have naming style "port@n", we need to select the n */
>>>
>>>> +       ret = kstrtou32(swnode->parent->node->name + FWNODE_GRAPH_PORT_NAME_PREFIX_LEN,
>>>
>>> Maybe a temporary variable?
>>>
>>>   unsigned int prefix_len = FWNODE_GRAPH_PORT_NAME_PREFIX_LEN;
>>>   ...
>>>   ret = kstrtou32(swnode->parent->node->name + prefix_len,
>>
>> Honestly I'm wondering if those macros don't hinder readability. I'd
>> rather write
>>
>>         + strlen("port@")
> 
> Works for me, since the compiler optimizes this away to be a plain constant.

Well, how about instead of the LEN macro, we have:

#define FWNODE_GRAPH_PORT_NAME_PREFIX	"port@"
#define FWNODE_GRAPH_PORT_NAME_FMT FWNODE_GRAPH_PORT_NAME_PREFIX "%u"

And then it's still maintainable in one place but (I think) slightly
less clunky, since we can do strlen(FWNODE_GRAPH_PORT_NAME_PREFIX)

Or we can do strlen("port@"), I'm good either way :)
