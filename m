Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A596728E8
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jan 2023 21:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjARUBY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Jan 2023 15:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjARUBJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jan 2023 15:01:09 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141FC59B72
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2023 12:01:02 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k16so14947wms.2
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2023 12:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dYEwLlHafATWFxoot4gAkpZeqySUmli4e77a+Kz66Q=;
        b=YG2vrGt09g0yHnyyvId1HwQgn8Ll2rfdESrrdfrmWb1rRAXLf92doKETB0eY4JhCdV
         d8ZN3RPTPar5q3ru582m4Cb0kbKdASv0uiQMcABTflWx0A0NajrZo5pOSJQXW4Ke/gYu
         TNT0UTkw9nAtuGiQ7Pcle7xM68tzESmuBMgS6l4HYXRmZqzXi6iXffITyI67mO1lbQf2
         I4iu3rdhJwsLHUFK/mLaElQZPfd2DOoygFff0ey2+2HTidDl/8tXiHgWCNVtKBV4RKsH
         aC+EmW2ddQCDx+YvPw2o81xfKit3Ek3bJWCZ/m5c1q2l3ZR87lV4KOC0L+jI/AuetXCX
         Luew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7dYEwLlHafATWFxoot4gAkpZeqySUmli4e77a+Kz66Q=;
        b=BOhZI/R8NLvEXuswE7QcNraYkO5Z2ySgbdk7SMqTF3DmUT591EVXOOV/RTNR4jiOKX
         aRVOe/GZb3JkX+NlQnwWX3tP4qpfxwOcYoyONllVWuyvc/ivfR2WIczsXk7G+KxcI+oR
         +Uov2KfOh9VB0ZpDh9L+8DPZmQeaIrGRCfOUgnJY7KUKJ3cIvHCyThdX+yaD1KScNEMt
         +U6+b8/ctkmAYO3YYYTQXsXb777GyJG1sF6xfq/HEM4yx0oWmw5+yow3HwlDSejyvI4B
         bKAr4YG2dJ5wYgjHdvNZyurfUJXwGbyECoX/PnT9n7hAevyjCeYyzXnnZDLu6F+aA985
         z6vQ==
X-Gm-Message-State: AFqh2kp6sq8LLaZgl2zP02QZ9jv/0rsUBXaOte96rV6SVV5Ynxg03Bxe
        UtihZfFgtjx9M+G8TP+j81KMNA==
X-Google-Smtp-Source: AMrXdXsKOk9RGH34JouXfHO4lX3tTXExBI8r27KQ19DpAYc2hCkx4gJMYsL82f9A3100rJ6R74M13g==
X-Received: by 2002:a05:600c:714:b0:3d9:ed30:79d with SMTP id i20-20020a05600c071400b003d9ed30079dmr7915447wmn.18.1674072060565;
        Wed, 18 Jan 2023 12:01:00 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b5-20020a05600c150500b003daf98d7e35sm2635658wmg.14.2023.01.18.12.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 12:01:00 -0800 (PST)
Message-ID: <c210542f-0a71-15f2-c58f-ec607e60b06d@linaro.org>
Date:   Wed, 18 Jan 2023 21:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
 <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org>
 <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
 <5aabdd3010a02e361fbbe01f4af0e30d11f0ae6b.camel@linux.intel.com>
 <c7abcce47df0aaa55f1e6c65f501bc691d35eae8.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <c7abcce47df0aaa55f1e6c65f501bc691d35eae8.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 18/01/2023 20:16, srinivas pandruvada wrote:

[ ... ]

>>> But we'd better wait for the thermald test result from Srinvias.
>>
>> A quick test show that things still work with thermald and these
>> changes.
> 
> But I have a question. In some devices trip point temperature is not
> static. When hardware changes, we get notification. For example
> INT3403_PERF_TRIP_POINT_CHANGED for INT3403 drivers.
> Currently get_trip can get the latest changed value. But if we
> preregister, we need some mechanism to update them.

When the notification INT3403_PERF_TRIP_POINT_CHANGED happens, we call 
int340x_thermal_read_trips() which in turn updates the trip points.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

