Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5885B2E9672
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 14:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbhADN5d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 08:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADN5d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 08:57:33 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F866C061574;
        Mon,  4 Jan 2021 05:56:52 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m5so32206904wrx.9;
        Mon, 04 Jan 2021 05:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LyrRUhBkoqWcAGCYsSDBZgPQ6OfRjVUqBOc3wjEtEV8=;
        b=peukgvMHKbc4pR8s8RYGql7/y3W5Zj3+lzKdEHPUnq/2rthPuY+XlF/7wfDu35DLAO
         4oZQdkJ+kNUNNCGUD0tS37DTvWqFrRs+bWzt8/1xQlGWzD/e0NU++DskCK2qw2+LcjAl
         PJeUWfGYPuTI23iTUYN2OieUZj2b/SqcZvLm+PYpK2BROpvvKDpaE0heezIxHQIlPDS3
         iykoSUMAAuDxIq3ua2CuwrTP499STfiOqC2yUVbwLMrbU7jqSKoAbNZ73OE+kQTmPmob
         oM96pSAWbunUPlhga4J70SugNYdWLhVDMlqQYfjLuXr1P+2Z3WLb9hYS7tXNQN5uoIpz
         P+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LyrRUhBkoqWcAGCYsSDBZgPQ6OfRjVUqBOc3wjEtEV8=;
        b=o0rRkiVbYEgKROQkuU2fsOSPya/RxinYKp5U6/IGH2dv6GMjVLGUQ68J+TTMYNoKa7
         lN/aWMGKiFeoAo0jc3clu+HmYtzRW8zdWW4vQn6/luthffE/rDdpBqCeyrKwLUHzt0Wb
         slDntIYrCbvNQXqcKfbJ0Dchk22zwG41kPA+I4vxPZb4JphGmk4jq+2JU8I1edHeAhtM
         YLIBQEURSWDmm2UbOdfnClENE5GeOJtB/TrfqKAgNoB4q6RzcEexliSHI0Vjjic4mcDY
         Ltdk3xjd0yTZn671RB4uFzvSeiTCUWCP/g0AP3+hmVI6Jtj+wMpKhoo19HEk1VjdsKyR
         Okbg==
X-Gm-Message-State: AOAM531srO/Xm7Y+zPM2/21kl9/mC6K2jGNYZeK2ks4oorjqYQ1EXZR0
        eQETReWhIJVKhjKsDUaeIBs=
X-Google-Smtp-Source: ABdhPJwpb88Cfo7Gp8j6dnF/Hw5fgGdPfsTA6M6ICjCrC6rfVw9+Y7Gog2Pg6F2shHFem2EIlh7Zig==
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr77835390wrn.179.1609768611288;
        Mon, 04 Jan 2021 05:56:51 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id b12sm48311878wmj.2.2021.01.04.05.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 05:56:50 -0800 (PST)
Subject: Re: [PATCH v4 15/15] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Len Brown <lenb@kernel.org>, Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        niklas.soderlund+renesas@ragnatech.se,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
 <20210103231235.792999-16-djrscally@gmail.com>
 <20210104120905.GR4077@smile.fi.intel.com>
 <2f64873d-0413-3614-34e2-139b4a4d9da6@gmail.com>
 <CAHp75VcU7DcRZD_eK+B1-CX7tVtsR5YLPdrA6oULk187xhApCw@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <287cf1cc-0e96-7609-aecd-e00dedcd90d9@gmail.com>
Date:   Mon, 4 Jan 2021 13:56:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcU7DcRZD_eK+B1-CX7tVtsR5YLPdrA6oULk187xhApCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 04/01/2021 13:38, Andy Shevchenko wrote:
> On Mon, Jan 4, 2021 at 3:02 PM Daniel Scally <djrscally@gmail.com> wrote:
>> On 04/01/2021 12:09, Andy Shevchenko wrote:
>>> On Sun, Jan 03, 2021 at 11:12:35PM +0000, Daniel Scally wrote:
> ...
>
>>>> +#define NODE_SENSOR(_HID, _PROPS)           \
>>>> +    ((const struct software_node) {         \
>>>> +            .name = _HID,                   \
>>>> +            .properties = _PROPS,           \
>>>> +    })
>>>> +
>>>> +#define NODE_PORT(_PORT, _SENSOR_NODE)              \
>>>> +    ((const struct software_node) {         \
>>>> +            .name = _PORT,                  \
>>>> +            .parent = _SENSOR_NODE,         \
>>>> +    })
>>>> +
>>>> +#define NODE_ENDPOINT(_EP, _PORT, _PROPS)   \
>>>> +    ((const struct software_node) {         \
>>>> +            .name = _EP,                    \
>>>> +            .parent = _PORT,                \
>>>> +            .properties = _PROPS,           \
>>>> +    })
>>> In all three I didn't get why you need outer parentheses. Without them it will
>>> be well defined compound literal and should work as is.
>> The code works fine, but checkpatch complains that macros with complex
>> values should be enclosed in parentheses. I guess now that I'm more
>> familiar with the code I'd call that a false-positive though, as nowhere
>> else in the kernel that I've seen encloses them the same way.
> I guess it is yet another false positive from checkpatch.
> I would ignore its complaints.
Will do so then
