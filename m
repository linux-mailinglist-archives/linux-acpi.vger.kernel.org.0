Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505232139B4
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jul 2020 14:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgGCMFO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Jul 2020 08:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGCMFI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Jul 2020 08:05:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C456C08C5DF
        for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2020 05:05:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so31786291wmh.4
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2020 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b/2h7xwQ3PLCO21KCpNHtwNw5XKKdaueZj6bzj1qaFI=;
        b=FwFjz9kczp/fmEq/3CY2LzY2MoAX4g3txWk2jZPo1VMcZhFboGhbIg3T8rhW0rPtbh
         qKWbZioeDBQZ9CKsivZWPupCioAGqQYcUfu4IlduD6az4TVr0iBMZzhBOKPL9J7uMbWA
         mquofFZR7KwyKNOmBpOWqsQ2cDTqZBtJ4MhCqXeld9v0yHNq686i8GUu6NvzX52yGtCB
         wdhzw6IXYtGUX0Q+WUJVgugYssLiqaRgCYqUWIi7yrmmC5szxCxNsSn3Qy+dVlKZF2Z/
         21oufd7NY1SMIhg2z1KYznt2bu66fmWXV174+G1DLqnoRRv5lvwFG0EieYGNbAm9E8hr
         EE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/2h7xwQ3PLCO21KCpNHtwNw5XKKdaueZj6bzj1qaFI=;
        b=Oukpitfb4PPg8EphMA0rqEQ84u+DM9lN4dMqVmoC05v3ZG1NI32S2zhnYKVP8Uruhd
         jcQA29M/TQNTi55NHDfPdICej8l/9LGmbAVFyxeMnhzEZENq3xatdDwEIU+O/3O0CR1t
         7QJ/LOCqXa6HyFg8cheSonm9DkvWa3PXkaS5qvP8Ur4k+Wc7Ul8jYjI+xlmUci0OR21i
         irpVrNLTCuXpC+XKxJMzBGiHs065BjCQ7ctMHpc0s9NJeHSF6CwSUDI12vUkUlxKCWsr
         /ZlZRCHb0zUFVbjU8BLa59HKS9RybYesoSbTKJQdHmjIF3D8LDBFCy81fGT7f/r+4/iN
         X9wg==
X-Gm-Message-State: AOAM533HeMd1ytApdWmh4VUwY1iBJ9ofDSg9V+F7Nc4sWmvK0G4MDvIU
        qYa3cqyqzDdmZk7JI+Bs2815Nw==
X-Google-Smtp-Source: ABdhPJwumsxgGpUFT/dRsPTyUr8OuykwTKjzsUJJ7FiUIydVdbcw33LRfbaUoxiLbcb0XM3MhDfEJQ==
X-Received: by 2002:a1c:9e84:: with SMTP id h126mr25473497wme.61.1593777905183;
        Fri, 03 Jul 2020 05:05:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:7019:4e9b:2970:f860? ([2a01:e34:ed2f:f020:7019:4e9b:2970:f860])
        by smtp.googlemail.com with ESMTPSA id k20sm13379403wmi.27.2020.07.03.05.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 05:05:04 -0700 (PDT)
Subject: Re: [PATCH 0/3] Fixes for stop monitoring disabled devices series
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Vishal Kulkarni <vishal@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Peter Kaestle <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        kernel@collabora.com
References: <20200703104354.19657-1-andrzej.p@collabora.com>
 <fc1bb7f5-2096-a604-8c30-81d34bf5b737@linaro.org>
 <91db4c89-0615-4a69-9695-ed5d3c42e1b7@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <79ae59af-d3b9-852c-d5f3-5b80d9c6ea8c@linaro.org>
Date:   Fri, 3 Jul 2020 14:05:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <91db4c89-0615-4a69-9695-ed5d3c42e1b7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 03/07/2020 13:57, Andrzej Pietrasiewicz wrote:
> Hi,
> 
> W dniu 03.07.2020 o 13:06, Daniel Lezcano pisze:
>> On 03/07/2020 12:43, Andrzej Pietrasiewicz wrote:
>>> This short series contains fixes for "Stop monitoring disabled devices"
>>> series https://www.spinics.net/lists/arm-kernel/msg817861.html
>>>
>>> Invocation of thermal_zone_device_is_enabled() in acpi/thermal is now
>>> redundant, because thermal_zone_device_update() now is capable of
>>> handling disabled devices.
>>>
>>> In imx's ->get_temp() the lock must not be taken, otherwise a deadlock
>>> happens. The decision whether explicitly running a measurement cycle
>>> is needed is taken based on driver's local irq_enabled variable.
>>>
>>> Finally, thermal_zone_device_is_enabled() is made available to the
>>> core only, as there are no driver users of it.
>>>
>>> Andrzej Pietrasiewicz (3):
>>>    acpi: thermal: Don't call thermal_zone_device_is_enabled()
>>>    thermal: imx: Use driver's local data to decide whether to run a
>>>      measurement
>>>    thermal: Make thermal_zone_device_is_enabled() available to core only
>>>
>>>   drivers/acpi/thermal.c         | 3 ---
>>>   drivers/thermal/imx_thermal.c  | 7 ++++---
>>>   drivers/thermal/thermal_core.c | 1 -
>>>   drivers/thermal/thermal_core.h | 2 ++
>>>   include/linux/thermal.h        | 5 -----
>>>   5 files changed, 6 insertions(+), 12 deletions(-)
>>
>> Is this series easily merge-able with the other series?
>>
> 
> So-so.
> 
> Some simple conflicts needed to be resolved.
> 
> I have created a branch for you to look at and decide
> how far off it is from the original and whether the
> original Acked-by/Reviewed-by can be retained.
> 
> Note that I might have lost some portions of code
> during conflict resolution. It seems to me I haven't
> but you know.
> 
> The branch:
> 
> https://gitlab.collabora.com/andrzej.p/kernel-tests/-/tree/thermal-dont-poll-disabled-for-daniel

Ok, I propose to keep the these three patches on top of V7.

Rui are you fine with that ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
