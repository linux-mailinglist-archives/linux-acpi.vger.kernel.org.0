Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC0C210DAD
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Jul 2020 16:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbgGAOZz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Jul 2020 10:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbgGAOZy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2020 10:25:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B22AC08C5DC
        for <linux-acpi@vger.kernel.org>; Wed,  1 Jul 2020 07:25:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so22657145wmj.0
        for <linux-acpi@vger.kernel.org>; Wed, 01 Jul 2020 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bzxWUOb25TYvscIF9N4MMene00x35xMy0V9YTIPCvEw=;
        b=Les4jxi+eQeD1WT6Qp6mIFEtHFoL2Xnxk7pXe2myRsbelv7n1VGJ2KaPP5bueTaj+p
         Ws0ZeIj3EKbuDp54QOSPqNSrx1Vs5Rr5aWn7OVocTi4YjblOE5DyZS1ftrIfz9pYa/jr
         szUO3UsdDch3lGHQeL88e06vcoFSR2oq3tuxrUF0lLAHIa/retTlgJkr/Y3S+oYlUHoW
         VrkbrOKxnOT9vxZYzK6UVniGsbbZpTig8cJdpUcTP/yWj7Yn803bPMnqrL80zMkwwjIX
         Aux9sAXy7wImthnbVxLQU9n0Uj1rXSL1I4qY6sxjbaOn+7DM2PE51ZkTpb39UeHL8/OK
         ci3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bzxWUOb25TYvscIF9N4MMene00x35xMy0V9YTIPCvEw=;
        b=rubWk2GULkCEMUK1vAOyhhqIVobeRNM3Q5yiHKhGJCTFWjFG2D0F3+OHyfPYBel10X
         m+NxbbI/degWuHXpsa7S8OkIKPPFlZddNVJm8Uf2haNh5mFMFOvu7Taei3WmpCDlS4df
         WXr4nyVyKukObfFVG3hBCFxuRI9wZaOx+LpNACBltL8C2lCfieFj69NUaFSqXYGluj55
         rdsMDhBmOxoTqLGmB6dSYM9JXyOGLASUlIvL/x80Muic7uOaTQn9Poncg7Z2M7aJM9cm
         M854wPg2Grb7+GOwzNdjQWJ9Fkv+SeXz4v4aKItx1NQEjG1835kKy+n+8m9VvbnJssg6
         i4hg==
X-Gm-Message-State: AOAM5306usui6dSNw6hd1QYfy4SJlEBCqwcxHaWoYiD6eJKlsorGyy2D
        4tq/3KgQKj9t3sC30x+fAGyMAw==
X-Google-Smtp-Source: ABdhPJxNJbgGXlTsOmTodMV5Dfnt24WopKgYqjBK+3slHN4EbVmyAyteCotRWf0oQTewKCuWuIkiDg==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr28362215wmc.140.1593613553010;
        Wed, 01 Jul 2020 07:25:53 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id c2sm7658210wrv.47.2020.07.01.07.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 07:25:52 -0700 (PDT)
Subject: Re: [PATCH v7 00/11] Stop monitoring disabled devices
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
References: <20200629122925.21729-1-andrzej.p@collabora.com>
 <aab40d90-3f72-657c-5e14-e53a34c4b420@linaro.org>
 <3d03d1a2-ac06-b69b-93cb-e0203be62c10@collabora.com>
 <47111821-d691-e71d-d740-e4325e290fa4@linaro.org>
 <be9b7ee3-cad0-e462-126d-08de9b226285@collabora.com>
 <4353a939-3f5e-8369-5bc0-ad8162b5ffc7@linaro.org>
 <a531d80f-afd1-2dec-6c77-ed984e97595c@collabora.com>
 <db1ff4e1-cbf8-89b3-5d64-b91a1fd88a41@linaro.org>
 <73942aea-ae79-753c-fe90-d4a99423d548@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5dba166b-ecef-c9ee-a13a-0e9bbf74ce4c@linaro.org>
Date:   Wed, 1 Jul 2020 16:25:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <73942aea-ae79-753c-fe90-d4a99423d548@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 01/07/2020 12:23, Andrzej Pietrasiewicz wrote:
> Hi,
> 

[ ... ]

>>>>
>>>> I did reproduce:
>>>>
>>>> v5.8-rc3 + series => imx6 hang at boot time
>>>> v5.8-rc3 => imx6 boots correctly
>>>>
> 
> What did you reproduce? Timeout logging in to the test system or a
> "real" failure of a test?

Timeout logging. Boot hangs.

>>> I kindly ask for a bisect.
>>
>> I will give a try but it is a very long process as the board is running
>> on kernelci.
>>
>> I was not able to reproduce it on imx7 despite it is the same sensor :/
>>
>>
> 
> Could it be that the thermal sensors somehow contribute to entropy and
> after
> the series is applied on some machines it takes more time to gather enough
> entropy?

I assume you are talking about the entropy for random?

It would be really surprising if it is the case. The message appears
asynchronously, I believe the boot flow is stuck in a mutex.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
