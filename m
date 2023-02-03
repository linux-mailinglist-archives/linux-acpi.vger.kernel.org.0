Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCBC68A4DA
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 22:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjBCVro (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 16:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjBCVrn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 16:47:43 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793098E079
        for <linux-acpi@vger.kernel.org>; Fri,  3 Feb 2023 13:47:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r27so2011039wrr.1
        for <linux-acpi@vger.kernel.org>; Fri, 03 Feb 2023 13:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8TDshsiDXMdYWnpIvV/GOghPr+ioBHI9cIhZ4cJ9rQ=;
        b=EJid9QgFYrPQ6OPSPtkgVHICn00FivJrpf36zYBhP2ZizLnsmZ5kjN5Km8QtBdnNcv
         x8dnKCSwkl6gowRidZ2CtBhwLkAbWAH2bKzzXLoZ57tQIMs9le2cQzz47yab6txger6w
         X2rIB+hL6fC8DolrghQlP3B7QuYM4Ex2lUj5hmtL/EP/A/npJ9T7PDWk6VTQwFimoutc
         wXTz16wyPdpAXyZ5k1pysv1Ss6UzUP5uBKURD32ygC2V/dfia2BQdRsMwCZ+jhLOfgEl
         x5z15I5arCLDc7sdCKJlJqNyEpSaT/Z7DINEfLE+/WKpSudhswZEmds6XDZio4MDS603
         9uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8TDshsiDXMdYWnpIvV/GOghPr+ioBHI9cIhZ4cJ9rQ=;
        b=eBZXBIqwlTUatw71xGJZkMTiSgRpXgAGocg9pxZL+BhrzvwN3UfR1uwcQENrF5LnnC
         +bHe+xZniBPOHb6WGEAq9ADevdMd2Z+nqyPLmp5+mnyuH71eRhKjttf0mQVyEDoaHU5U
         OAWFBkuZcwer4kPJoapQDZjW0Ln+BuXF1moCQxCSve0zH32rhzqL32RPi8VeVUpWxsLK
         IkuIi50i9MjWfift8fCpvunwmBekZ5IxBkExtsNIejHC5f3QMU1wIf2G4vDRLlDXBG9P
         yD0jh5af/l/EZxlYcCC4TGc0MK62ntb1O+3gX7jLRZpbiO+HX3BLF62u5MpykFVd06tu
         ktAQ==
X-Gm-Message-State: AO0yUKVgPUA8jEuVv9pXAjcx4J88rfubmi7jIZzkfA73mXw6hSDAt26l
        Rh1IBmILX8dg5jK3GwD4OjnQpQ==
X-Google-Smtp-Source: AK7set/MDCSRhyInEFAIPuAWPUJirQWAI4uG90Lz9Rd6GzuaefvjBGS/B8F/a7vBnKAv60t01CLlCw==
X-Received: by 2002:adf:f006:0:b0:2bf:e778:6500 with SMTP id j6-20020adff006000000b002bfe7786500mr11690683wro.64.1675460860862;
        Fri, 03 Feb 2023 13:47:40 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t10-20020adff60a000000b002bbddb89c71sm2891608wrp.67.2023.02.03.13.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 13:47:40 -0800 (PST)
Message-ID: <a4da1cb6-80a5-a3a9-72e6-62e5ad810509@linaro.org>
Date:   Fri, 3 Feb 2023 22:47:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 00/11] Generic trip points for ACPI
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gkOfbWZWzsTKLBD9C8TaAp0qmTv0L0X7E3fBSLyMUEcQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gkOfbWZWzsTKLBD9C8TaAp0qmTv0L0X7E3fBSLyMUEcQ@mail.gmail.com>
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

On 03/02/2023 19:46, Rafael J. Wysocki wrote:
> On Fri, Feb 3, 2023 at 6:34 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> This series introduces the generic trip points usage in the thermal ACPI
>> driver. It provides a step by step changes to move the current code the
>> generic trip points.
>>
>> I don't have an ACPI platform, the code is not tested.
> 
> What's the purpose of sending this now, then?  Should it be an RFC?
> I'm certainly going to treat it this way.

I did basic testing on a x86 laptop having critical trip points but 
nothing else.

I understand it can be treated as RFC.

Is there any dummy ACPI tables with thermal available somewhere I can 
play with in Qemu ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

