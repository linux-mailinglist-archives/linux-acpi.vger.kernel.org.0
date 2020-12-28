Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173D62E6C58
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 00:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgL1Wzd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 17:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgL1VST (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Dec 2020 16:18:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15244C0613D6;
        Mon, 28 Dec 2020 13:17:39 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t30so12570999wrb.0;
        Mon, 28 Dec 2020 13:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6/WVNRIgvoEIoBQB5jvPaHPOS3LUIEzkSJx65mcEOyg=;
        b=FNJIWOejlt+bMS1zaJGqlv6ykzpCKkcKFXtVr2ubkzsSV1figJddONo7ITMEIUMRex
         XT0eGBJVWSmhXrtxPE7MAgch7Qox3Mw2QM5IJpO0+z6GZKTJIHE4KWOoId3sEHw2EDuw
         3nrUazxnPObf9MXUBLiEXi9x8AFtRt34mmlKaC4AwUL3PuIsPKnMPL4e4l2LzIk7CfHp
         RSWvF9lOr3mdcOD3QG9/D53sIcs0S2Q0hyVV89Wp7zuqAkR0ZRpFWZu8tJCdvx2wD0lE
         v7LMDvPy/a0y15SRXbQhwROrMRN8+3XIJsXS9c80+fB/rdV2/ZoZ/JqQRxqjI3kjgG0R
         0EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6/WVNRIgvoEIoBQB5jvPaHPOS3LUIEzkSJx65mcEOyg=;
        b=Nymle+BYp7YF0kPgOmVZo2AHF9GD0V2HK86YyiTUVETobB6FCun31cNxbJiuMrhLCo
         Wckh3jVDQ4ke4IGLQVN4oN4v+VUSOIJXzxt7yhYXRG4EUMoCqM5fRgX3wqzJg1Rx6Yer
         8GrLBX1QAIFMNbErg0H3P+ejoJyZc5iKmMeSU+UopuDjSyPRF6mg3JwDRuTCoFOwQGbM
         wQCcQgsW4BvoM2dNvpqq8pKozoAtIR7FA+8U0wBFbzVzYcFlDU5vBJBfp7+4mpQqXq9w
         11b+ANufl+N3ix7IRjyTuR/l7Ftofs0OmewqqUSvM5E9PTIbFNnf3tBgYb2GvnHfD57+
         dT/A==
X-Gm-Message-State: AOAM5316bbDmiia8PifPoM3c6i0hTsYaLm8h+/ifeWeKdlea9ezqhXHE
        ZfVJiDufGCJCPhTadQHTooI=
X-Google-Smtp-Source: ABdhPJys8O4OnUh7lIKC27LM7BkKt6guVRZ8oH2MlLfHAo+Jfm7B306edUtwKozJeH8G8NxJCjBpxw==
X-Received: by 2002:a5d:6607:: with SMTP id n7mr50870402wru.206.1609190257824;
        Mon, 28 Dec 2020 13:17:37 -0800 (PST)
Received: from [192.168.1.158] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id s63sm736343wms.18.2020.12.28.13.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 13:17:37 -0800 (PST)
Subject: Re: [PATCH v3 05/14] software_node: unregister software_nodes in
 reverse order
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Laight <David.Laight@aculab.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        "kieran.bingham+renesas@ideasonboard.com" 
        <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        "niklas.soderlund+renesas@ragnatech.se" 
        <niklas.soderlund+renesas@ragnatech.se>,
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
 <2b415312-fe30-c73b-0077-4ec2a07116df@gmail.com>
 <fcb07dea193b4b99b11f2a8e684d8acf@AcuMS.aculab.com>
 <20201228101526.GV4077@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <1a79347f-b4fe-5fe7-ccb3-a2d53ae93480@gmail.com>
Date:   Mon, 28 Dec 2020 21:17:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201228101526.GV4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 28/12/2020 10:15, Andy Shevchenko wrote:
> On Thu, Dec 24, 2020 at 06:36:10PM +0000, David Laight wrote:
>> From: Daniel Scally 
>>> Sent: 24 December 2020 14:14
>> ...
>>>>> The array will be unwound in reverse order (i.e. last entry first). If
>>>>> any member of the array is a child of another member then the child must
>>>> children ?
>>>
>>> Yes, you are right of course.
>>
>> The second 'child' is a back-reference to 'any member' so is singular
>> so 'child' is correct.
>> 'the child' could be replaced by 'it'
>>
>> You could have:
>>    If any members of the array are children of another member then the
>>    children must appear later in the list.
> 
> Works for me!
> Dan, can you consider David's proposal?

Yep - done, thanks David
