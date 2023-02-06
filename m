Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F9B68C552
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 19:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjBFSAZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 13:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjBFSAX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 13:00:23 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5542D16C
        for <linux-acpi@vger.kernel.org>; Mon,  6 Feb 2023 10:00:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ba1so7129458wrb.5
        for <linux-acpi@vger.kernel.org>; Mon, 06 Feb 2023 10:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAzbzHAwMbORwKFGc8I4gB1/HhGTYUVUMIT2p3MVzto=;
        b=duUAnzGSjSKmhmvXBjIvZ1JQy/33pGphU6VD3fKrWWxkpTSXSv08qtxG2ysiVq8DYh
         l5yrAn366zu6qlIeEJp/zTFdkIOQzoOzyIF+mIRxSpdaZJakUUjyUUL9FT1OiCUvgQKs
         6jc4NZidbD6Sg/3X4Awg3R9I29xdb3aA5aN9/0v4bWmn+a1Ncq89QjNGYNAlXPmYov3v
         NDwKj5jYI4xHZz1kLoLGfLRE25PqdJktTHYTKAO4VhfV9ou9InW8fndaW9JWHbTLo/cl
         yy0T9gBHWWlWMJJUxLRU+PO4QHE0CA5QGDGPVvww6Dn1RLgJGoewJlSRboajNwHNhIQP
         VK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAzbzHAwMbORwKFGc8I4gB1/HhGTYUVUMIT2p3MVzto=;
        b=VVm8tHMYCoWTeVUl0RgOXRbbQ1m7LkZ167EA+gYWS6Zzsu7mI9EhBRdaRnXkAHjJy8
         m/xfXWrhh+CjCeqDj6HgRtx+yCXIYYex6sECfbO5F6BogidJPipEQGmmbmsqNjlCKXsT
         VMnZps4pISnZ2ynuCZWvJ4L2iNMiMGXMfYP5Nbc5RvUUo8fmMIFuwabsuDzp49bH6v25
         P2g5QJWvXbbGJf5VgL4VtMJx/kZTa9NQL5WTePI2xUsBq2/6k7ZV5HurdPff2B39tPhf
         iIqkBOHcabX5NyHTo76i3Wo7u7NCyivVDmGNLObifrchla78vT5EA2oUCfzlVEln+E9U
         /T3A==
X-Gm-Message-State: AO0yUKX1ewYk2qKF5OJB+DX8qlMe94WF6/xENCgYaioylSoWFvlBI6qi
        IXo5Y/I/WLe712YOFGWCxh5jhw==
X-Google-Smtp-Source: AK7set+gHrNvDG7dTutQV1RwYNQpdPvpEFYOvQc9NHBZvdR9G+YemKmTRrXYosqJpvEDpCO35gZT6Q==
X-Received: by 2002:adf:fb82:0:b0:2c2:ad22:40ba with SMTP id a2-20020adffb82000000b002c2ad2240bamr16759553wrr.68.1675706415588;
        Mon, 06 Feb 2023 10:00:15 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p4-20020a5d68c4000000b002c3e4f2ffdbsm4401533wrw.58.2023.02.06.10.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 10:00:15 -0800 (PST)
Message-ID: <474338ff-26af-061e-1166-a1bd906ffe00@linaro.org>
Date:   Mon, 6 Feb 2023 19:00:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: Hunt zero trip points thermal zones usage
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Chuansheng Liu <chuansheng.liu@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
References: <20230203175832.3406504-1-daniel.lezcano@linaro.org>
 <CAJZ5v0jzLCQt22MhfaAvL8w+RP7Y-YqxUdcgQ2u2Tz9i0CS+2A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jzLCQt22MhfaAvL8w+RP7Y-YqxUdcgQ2u2Tz9i0CS+2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 06/02/2023 17:08, Rafael J. Wysocki wrote:
> On Fri, Feb 3, 2023 at 6:59 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> Some drivers are declaring a thermal zone without any thermal trip
>> points.
>>
>> On the other side, we are introducing the function
>> thermal_zone_device_register_with_trips() which provides an array of
>> generic thermal trip points. When all the drivers will be converted to
>> the generic trip points, keeping two functions will be useless.
>>
>> Most of the drivers are now using
>> thermal_zone_device_register_with_trips() with the generic trip
>> points. As soon as the remaining drivers are merged, the
>> thermal_zone_device_register_with_trips() will be renamed to
>> thermal_zone_device_register().
> 
> So why is this the first time I'm learning about this plan?

Well it is not a plan, it looked purely logical to me that the 
_with_trips variant was added to support the generic trip points in 
addition to the specific trips. As soon as all the drivers are 
converted, there is no need to have these two functions anymore and we 
can fall back to the previous name (or a shorter one).

>> Obviously this renaming can only happen if there are no more user of
>> the thermal_zone_device_register() function.
>>
>> This change uses thermal_zone_device_register_with_trips() with a NULL
>> parameter for the trip point array instead of
>> thermal_zone_device_register().
> 
> And later it will be renamed to thermal_zone_device_register() again?

Yes, that was the idea, unify the name and then use a cocci script to 
rename them all.

> Can we just stop confusing people this way?
> 
> What would be wrong with changing both
> thermal_zone_device_register_with_trips() and
> thermal_zone_device_register() together when we are ready?  And why
> can't the both be replaced with something line thermal_zone_register()
> doing all of the necessary things in one go?  Why do we have to make
> confusing and redundant changes?

For me the result will be the same, if you prefer to wait for all the 
drivers to be converted then it is fine for me.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

