Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC0C2E2794
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 15:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgLXOOz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Dec 2020 09:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgLXOOz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2020 09:14:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BB8C06179C;
        Thu, 24 Dec 2020 06:14:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i9so2302261wrc.4;
        Thu, 24 Dec 2020 06:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5IQf/4MAsKE+WTlNyQCuo6jepc1CwhVN6xmkcDb3fIU=;
        b=nf8307rNrKyayWyufbV1EUOx8jMRH6o3Gm83koiFlra3TmbAw2CLkRj6RU3AR4BWe0
         W4IhyHFn7uM0YyUBigTpmrl8TN5GgU6EUhQ8PkBjYuPEtHLbvz5zxtPl6flbqlh6Yqsq
         cJKrFj5QGtpVtDbhQe0JMYOw3LnkTxsuImQW65vtTB/aFvNqvjKnX42SEI6eIN4dE+s+
         67ZuUGW9ndnOM4vjHoZBa2kUw92bJ1EdeLDLyZ23rW+YFeoeHfSmWikPf7CHvon16JK4
         vzqw+q7eF42PVLxAGdvfuE6wk9UWjRwmK9tgmifeh0WAJdlw/sYqqXmQ2ZSNzUg29Rx1
         Jksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5IQf/4MAsKE+WTlNyQCuo6jepc1CwhVN6xmkcDb3fIU=;
        b=tyxFljXOn5LVvo69phxmdHT59i+m5rRLJ/djfSh3uGj+4EDqHnP5QiEN5KNfnHs2Yd
         ifcuG5D83cL2KtQW3hOItNlsPJaoAW+V+be/3+OoMNzkpPhcZnWiWPC1hI1Z7g+RCuY4
         bFlTwFHj5HVKkv8hkFey05owh2U42jRh/6iicAGgJlPUHHDbqAKzboJjdUIR5XVgw2wc
         Jq455gqQHviLIRgDu/Xvpio1Dt2GB8NvLv9hzEP8OfeC4e9TyRD1oiHbUdiBLWtUCfqd
         jMzlUp+4yR/7uC/bIQy77fJUkmLV+VQpG2toG3U/07qkGzXaN0y7iQ4H8Ur8Ao6ubM48
         6YWQ==
X-Gm-Message-State: AOAM530wvwu2BQt2hreTSq3Uka82YeeXlzX39wEDp5cTLiypCYlWGSes
        8/afmonquKmFfvDvrw4xC/c=
X-Google-Smtp-Source: ABdhPJxGYjXpOyykLaMQVjAfA6eADmsUdE3HMzSHLW25ZR9l3/ybTlPCveS+Hf2tvWrIkS5u+eLs3Q==
X-Received: by 2002:adf:dc8b:: with SMTP id r11mr34994434wrj.131.1608819253334;
        Thu, 24 Dec 2020 06:14:13 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id z22sm3506603wml.1.2020.12.24.06.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Dec 2020 06:14:12 -0800 (PST)
Subject: Re: [PATCH v3 05/14] software_node: unregister software_nodes in
 reverse order
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
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-6-djrscally@gmail.com>
 <CAHp75VdF5NdjrSxcOafh7KNNDteYEUDk9otA0HKX-iks7G0D4g@mail.gmail.com>
 <de478ef0-0b4d-df1d-2651-9cc35bf2f45b@gmail.com>
 <CAHp75VdWuowLenNPQRNc+QXeyuvwKqh_bjw=1WvmFrzoygXFRw@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <2b415312-fe30-c73b-0077-4ec2a07116df@gmail.com>
Date:   Thu, 24 Dec 2020 14:14:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdWuowLenNPQRNc+QXeyuvwKqh_bjw=1WvmFrzoygXFRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 24/12/2020 14:12, Andy Shevchenko wrote:
> On Thu, Dec 24, 2020 at 4:00 PM Daniel Scally <djrscally@gmail.com> wrote:
>> On 24/12/2020 12:13, Andy Shevchenko wrote:
>>> On Thu, Dec 24, 2020 at 3:12 AM Daniel Scally <djrscally@gmail.com> wrote:
> ...
>
>>>> + * Unregister multiple software nodes at once. The array will be unwound in
>>>> + * reverse order (i.e. last entry first) and thus if any member of the array
>>>> + * has its .parent member set then they should appear later in the array such
>>>> + * that they are unregistered first.
>>> I'm, as being not a native speaker, a bit confused by this comment.
>>> The idea is that children are unregistered first. Can you try to make
>>> it more clear maybe?
>> Sure, how about:
>>
>> The array will be unwound in reverse order (i.e. last entry first). If
>> any member of the array is a child of another member then the child must
> children ?

Yes, you are right of course.

>
>> appear later in the array than their parent, so that they are
>> unregistered first.
> I think with the above change it will be better, yes.
>
Ok, done.
