Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D6C1F66AC
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jun 2020 13:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgFKLbM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Jun 2020 07:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgFKLbL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2020 07:31:11 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA1AC08C5C3
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2020 04:31:11 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id mb16so6104576ejb.4
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2020 04:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iZI0uRQuWUt+bbhxRlulOcMky2K69l8uS5RWj37ZKSU=;
        b=O2eSC5h/UIUSN8YdTXYoM2GxMaLHDuLBL80QYWThofDsGoN2ZvZDRRRABrEyrHkaEI
         K0j0bTbw35reBwy6NRKAeV4Kg2bGKdfRN6Rr/eO5ltxDH7bADZ00TU5bQWVhQcSvCJFq
         7UljWwRep6eDGm0fydTBVFsCHIb/OAQs8X4iyu2KLchotcgWLCzWqabmVBxw1kCmNVqM
         +h6KETWJPOF3So1hsyuxKCqvjudWGRJQliU2IDpvW64yNiOFDyZVprw/v5QcPhIMw0cf
         35BSxMTc4umjRhqy3Uw+tQzWT0n18q/sO0i5xbe09Sw0KI0HOSdBooaFns7GEAoMUgi6
         Z6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iZI0uRQuWUt+bbhxRlulOcMky2K69l8uS5RWj37ZKSU=;
        b=KL+HUXWgAtDcvdgEB82zFK654VbO9VtZbEXgi2+H2OzggRZmil/ifqLQvt9fKXHiAu
         P+CU7LtTiCf8NKtFfhrzITvkNW+qr/1hSRMTJEcm9GK5LjfPKFbXvcyX+kCLRD/cWPSd
         fk+yUmgpZkW9Oa56oZi/BdQEgySNFvM+TE8H2AJh5Aeq2IQWZxcZLruYE//P8XuyvsB0
         ZlA6awm6kPX1jQMjSS4+FbKj4HYueFb73wTGC3hobSWbBxoozc6wiT1ZJj24kLpkvqhd
         8BUGO6yu0tRHoiXu0I4Tyho66cHJ4swOQD7oMGLH2alAuPfYV7pbFP9MUS3bG3vP/Zdf
         wPFA==
X-Gm-Message-State: AOAM530BmE26+Rq7D6UrIHhdu1mYjglxPWYXdxVatub2xBdRGiRKV2kA
        EwQGJveBibZ2ugBoqWggPpUSzQ==
X-Google-Smtp-Source: ABdhPJyQ1qn7IO1LzSekQnj4oHhjiJ9BS1eH8JqyujBg91YWEFxFDPUx+MplfmXECktgGP6foP9h9A==
X-Received: by 2002:a17:906:f155:: with SMTP id gw21mr7806470ejb.388.1591875070279;
        Thu, 11 Jun 2020 04:31:10 -0700 (PDT)
Received: from [192.168.1.5] (212-5-158-114.ip.btc-net.bg. [212.5.158.114])
        by smtp.googlemail.com with ESMTPSA id q14sm1381962edj.47.2020.06.11.04.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 04:31:09 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] venus: Make debug infrastructure more flexible
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, Jason Baron <jbaron@akamai.com>
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
 <20200609104604.1594-7-stanimir.varbanov@linaro.org>
 <20200609111414.GC780233@kroah.com>
 <dc85bf9e-e3a6-15a1-afaa-0add3e878573@linaro.org>
 <20200610133717.GB1906670@kroah.com>
 <31e1aa72b41f9ff19094476033511442bb6ccda0.camel@perches.com>
 <2fab7f999a6b5e5354b23d06aea31c5018b9ce18.camel@perches.com>
 <20200611062648.GA2529349@kroah.com>
 <bc92ee5948c3e71b8f1de1930336bbe162d00b34.camel@perches.com>
 <20200611105217.73xwkd2yczqotkyo@holly.lan>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <ed7dd5b4-aace-7558-d012-fb16ce8c92d6@linaro.org>
Date:   Thu, 11 Jun 2020 14:31:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611105217.73xwkd2yczqotkyo@holly.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 6/11/20 1:52 PM, Daniel Thompson wrote:
> On Wed, Jun 10, 2020 at 11:42:43PM -0700, Joe Perches wrote:
>> On Thu, 2020-06-11 at 08:26 +0200, Greg Kroah-Hartman wrote:
>>> On Wed, Jun 10, 2020 at 01:23:56PM -0700, Joe Perches wrote:
>>>> On Wed, 2020-06-10 at 12:49 -0700, Joe Perches wrote:
>>>>> On Wed, 2020-06-10 at 15:37 +0200, Greg Kroah-Hartman wrote:
>>>>>> Please work with the infrastructure we have, we have spent a lot of time
>>>>>> and effort to make it uniform to make it easier for users and
>>>>>> developers.
>>>>>
>>>>> Not quite.
>>>>>
>>>>> This lack of debug grouping by type has been a
>>>>> _long_ standing issue with drivers.
>>>>>
>>>>>> Don't regress and try to make driver-specific ways of doing
>>>>>> things, that way lies madness...
>>>>>
>>>>> It's not driver specific, it allows driver developers to
>>>>> better isolate various debug states instead of keeping
>>>>> lists of specific debug messages and enabling them
>>>>> individually.
>>>>
>>>> For instance, look at the homebrew content in
>>>> drivers/gpu/drm/drm_print.c that does _not_ use
>>>> dynamic_debug.
>>>>
>>>> MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
>>>> "\t\tBit 0 (0x01)  will enable CORE messages (drm core code)\n"
>>>> "\t\tBit 1 (0x02)  will enable DRIVER messages (drm controller code)\n"
>>>> "\t\tBit 2 (0x04)  will enable KMS messages (modesetting code)\n"
>>>> "\t\tBit 3 (0x08)  will enable PRIME messages (prime code)\n"
>>>> "\t\tBit 4 (0x10)  will enable ATOMIC messages (atomic code)\n"
>>>> "\t\tBit 5 (0x20)  will enable VBL messages (vblank code)\n"
>>>> "\t\tBit 7 (0x80)  will enable LEASE messages (leasing code)\n"
>>>> "\t\tBit 8 (0x100) will enable DP messages (displayport code)");
>>>> module_param_named(debug, __drm_debug, int, 0600);
>>>>
>>>> void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
>>>> 		 const char *format, ...)
>>>> {
>>>> 	struct va_format vaf;
>>>> 	va_list args;
>>>>
>>>> 	if (!drm_debug_enabled(category))
>>>> 		return;
>>>
>>> Ok, and will this proposal be able to handle stuff like this?
>>
>> Yes, that's the entire point.
> 
> Currently I think there not enough "levels" to map something like
> drm.debug to the new dyn dbg feature. I don't think it is intrinsic
> but I couldn't find the bit of the code where the 5-bit level in struct
> _ddebug is converted from a mask to a bit number and vice-versa.

Here [1] is Joe's initial suggestion. But I decided that bitmask is a
good start for the discussion.

I guess we can add new member uint "level" in struct _ddebug so that we
can cover more "levels" (types, groups).

-- 
regards,
Stan

[1] https://lkml.org/lkml/2020/5/21/915
