Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1164745DCD5
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Nov 2021 16:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhKYPGz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Nov 2021 10:06:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232861AbhKYPEy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Nov 2021 10:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637852502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzY+nlb0WLLo3q9EhtWI9RItnRnZnbWS8p2iLJT22S4=;
        b=gQoTfj6BeePVoRDBskdRK6Sq0IKkO6158TFwpFSvcBHuO5Gd6Io0J2o9ToZL/QrhkxvdDZ
        CcoQUJsJYZftxAjo/Tl+Ug2A4b2mrFFhXYVp5oYCkFpckvHx3Kxw0FcvT/A3sQXTiKup4H
        F0EnWinonLGwGZOAAS8L1zDcpD23a2w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-F3TVicdNOVeV7nsTpTQbLg-1; Thu, 25 Nov 2021 10:01:41 -0500
X-MC-Unique: F3TVicdNOVeV7nsTpTQbLg-1
Received: by mail-ed1-f69.google.com with SMTP id a3-20020a05640213c300b003e7d12bb925so5734937edx.9
        for <linux-acpi@vger.kernel.org>; Thu, 25 Nov 2021 07:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pzY+nlb0WLLo3q9EhtWI9RItnRnZnbWS8p2iLJT22S4=;
        b=e4HPe+P0PTfa3kFZ4/aUDKRzIu2TSJqPv4gAAYgb6dYYoVWQzsDpoWD3SxDZfTOr/z
         2SrTIO8bQC6HZPg7QPsQp2ZOSWho4ACeOPW8TeCA3f6JNjjGPxcWYkFLdp4bVAYHPyqP
         ym6Qv5409Q0h28gpn2SB638tGdom793pw9QcykS01dgctV78Rxghrvblvo0/A4qas4tY
         5kdL1Bj3FvKoVd3ueQNhuTis7h77Z/Y4Uf+9By46eAWzASC/yIftSW7+baSD5qx2Nscm
         vJQB4GcBPif+Sw4FZRGbRE8owf0CfG5LYq1uWlSura8o4/T5y6aZzwLi9yWbY2enq2wh
         wyrQ==
X-Gm-Message-State: AOAM530EqWkygvPg9oiAswI4/olUtgfcBzQGS5MZjXqjt1drAw5mDCyn
        eQ2Kam26QZ4N+TeCMBTaRBfTGoW7S8510DLe+S6Kh6nRD3+he+cQa61Z7V818nkL79lNMCIC6z0
        1F96TmyarZtFkypN0SYrl8w==
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr40305209edx.306.1637852500389;
        Thu, 25 Nov 2021 07:01:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMuiDvP4QYeeLwDI2JCOjzlhRkJeTB36IJtfD88XbWM3LPA2G1s9P+fBWdUkpvYv4+DeiFNA==
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr40305178edx.306.1637852500217;
        Thu, 25 Nov 2021 07:01:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id gt18sm1725641ejc.46.2021.11.25.07.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 07:01:39 -0800 (PST)
Message-ID: <09cdb0bd-56f6-d0fe-c35a-ed86c5919b4d@redhat.com>
Date:   Thu, 25 Nov 2021 16:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re:
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J.Wysocki" <rjw@rjwysocki.net>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20211102094907.31271-1-hdegoede@redhat.com>
 <20211102094907.31271-6-hdegoede@redhat.com>
 <163588780885.2993099.2088131017920983969@swboyd.mtv.corp.google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <163588780885.2993099.2088131017920983969@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/2/21 22:16, Stephen Boyd wrote:
> Quoting Hans de Goede (2021-11-02 02:49:01)
>> diff --git a/drivers/clk/clk-tps68470.c b/drivers/clk/clk-tps68470.c
>> new file mode 100644
>> index 000000000000..2ad0ac2f4096
>> --- /dev/null
>> +++ b/drivers/clk/clk-tps68470.c
>> @@ -0,0 +1,257 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Clock driver for TPS68470 PMIC
>> + *
>> + * Copyright (c) 2021 Red Hat Inc.
>> + * Copyright (C) 2018 Intel Corporation
>> + *
>> + * Authors:
>> + *     Hans de Goede <hdegoede@redhat.com>
>> + *     Zaikuo Wang <zaikuo.wang@intel.com>
>> + *     Tianshu Qiu <tian.shu.qiu@intel.com>
>> + *     Jian Xu Zheng <jian.xu.zheng@intel.com>
>> + *     Yuning Pu <yuning.pu@intel.com>
>> + *     Antti Laakso <antti.laakso@intel.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/tps68470.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/platform_data/tps68470.h>
>> +#include <linux/regmap.h>
>> +
>> +#define TPS68470_CLK_NAME "tps68470-clk"
>> +
>> +#define to_tps68470_clkdata(clkd) \
>> +       container_of(clkd, struct tps68470_clkdata, clkout_hw)
>> +
> [...]
>> +
>> +static int tps68470_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                                unsigned long parent_rate)
>> +{
>> +       struct tps68470_clkdata *clkdata = to_tps68470_clkdata(hw);
>> +       unsigned int idx = tps68470_clk_cfg_lookup(rate);
>> +
>> +       if (rate != clk_freqs[idx].freq)
>> +               return -EINVAL;
>> +
>> +       clkdata->clk_cfg_idx = idx;
> 
> It deserves a comment that set_rate can only be called when the clk is
> gated. We have CLK_SET_RATE_GATE flag as well that should be set if the
> clk can't support changing rate while enabled. With that flag set, this
> function should be able to actually change hardware with the assumption
> that the framework won't call down into this clk_op when the clk is
> enabled.

Ok for v6 I've added the CLK_SET_RATE_GATE flag + a comment why
it used and moved the divider programming to tps68470_clk_set_rate()m
while keeping the PLL_EN + output-enable writes in tps68470_clk_prepare()


> 
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct clk_ops tps68470_clk_ops = {
>> +       .is_prepared = tps68470_clk_is_prepared,
>> +       .prepare = tps68470_clk_prepare,
>> +       .unprepare = tps68470_clk_unprepare,
>> +       .recalc_rate = tps68470_clk_recalc_rate,
>> +       .round_rate = tps68470_clk_round_rate,
>> +       .set_rate = tps68470_clk_set_rate,
>> +};
>> +
>> +static const struct clk_init_data tps68470_clk_initdata = {
> 
> Is there a reason to make this a static global? It's probably better to
> throw it on the stack so that a structure isn't sitting around after
> driver probe being unused.

Fixed for v6.

Thanks & Regards,

Hans


> 
>> +       .name = TPS68470_CLK_NAME,
>> +       .ops = &tps68470_clk_ops,
>> +};
> 

