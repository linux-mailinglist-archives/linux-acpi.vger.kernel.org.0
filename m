Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B626E6652
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Apr 2023 15:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjDRNtT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Apr 2023 09:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjDRNtS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2023 09:49:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0CF14F58
        for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2023 06:48:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2eed43bfa4bso2276404f8f.2
        for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2023 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681825738; x=1684417738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLlNOIvco2D3nOysn+IPJrsLn+szsZm90IH1Z97HmY4=;
        b=FD0bNaOXgXaX5E7xKXjud23/Nss6D3oRFXV2LYTxAW/h6Gs+uzUnQn/qUATk8kZ4lP
         q3upyBQ4i47sBU4sPIIjnoviW7HYX0IwA2xxkrSQ9UTzo87crZFszWlFfY7otFsffdNX
         43BM62w+hFX6wTDxdNbfKQ0XxtEvMMvHAhYXfyiCcR1eoZ4dyE0Usd956VZqNlWsiTiK
         Hbwjqd7UHDxxvTEJZptjsBmvgdjiReNiurru9AXtKvn77GcP192Bhif6EohB27pzQINK
         twPTKD/8U3c9v5DeTNCXUZCUqT/+IpyNJpqsfAGQzbtol/cS4RiIJs3QnQkQAdcxDofi
         mnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681825738; x=1684417738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLlNOIvco2D3nOysn+IPJrsLn+szsZm90IH1Z97HmY4=;
        b=g3cnxlWgGslz8F/kvu+Ttp9INJeFP0TI5oIRyX8jFFB9mwNrQyKNvp6H8qCbDlGqpH
         5vcJ8JEy8ggIipZgTCSBPqIk3BZm2sR8yd/Zle8RqoTnzjk4sfP0LoHjQ8HLAUo2roq8
         I8PlyqT3BLvsuqxROzNHlCHy29dOhoqdmeGtiT34FrBCQlOWedGP8YNDgtfe4S5o6jmO
         r/qkrjbkxQAxoFYiIRs3rIJUQ4IXTQ0os9D1VxAEzDW++L549EfyZhOlfh0NJ0IKJwvi
         VQYf29PlMS6YDv4mSRDc7xe9KFoXuYwtD08gl9gIKAUb6uiBbht98QxyInVQe+Qv3IVM
         ms2g==
X-Gm-Message-State: AAQBX9d6Zwp6w3llfP/XELWy2gEFupU/7ocsWclA/7aZH6Bjwlqx1oVs
        a6lA75FRQGDYuRy0WAmlbx3RmA==
X-Google-Smtp-Source: AKy350Ych1GtGbv1VAW9Y+GSvdK9I/P6rLmcnh/AXvGxIQycOfZz6ubYPlYVqx3x7QDKZTBKENGQLw==
X-Received: by 2002:adf:dfc3:0:b0:2d1:9ce9:2b8f with SMTP id q3-20020adfdfc3000000b002d19ce92b8fmr2013835wrn.66.1681825738013;
        Tue, 18 Apr 2023 06:48:58 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v17-20020a05600c445100b003f09cda253esm2733760wmn.34.2023.04.18.06.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 06:48:57 -0700 (PDT)
Message-ID: <183ed2f6-0ab5-84cb-bb98-2fd6f80cfc7c@linaro.org>
Date:   Tue, 18 Apr 2023 15:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 5/6] thermal/drivers/acpi: Make cross dev link optional
 by configuration
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
References: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
 <20230413114647.3878792-6-daniel.lezcano@linaro.org>
 <CAJZ5v0jqB18c1u-eqcEiXW+fOH=nX=Uu3xi5sp2F9udsFUrYew@mail.gmail.com>
 <7fd7df2d-f473-c0fd-5c3c-40d0fb697db7@linaro.org>
 <CAJZ5v0hkF37RL4fxqE7+iUw7gEtb+KMyDKBpjdO=DE72OSHFtg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hkF37RL4fxqE7+iUw7gEtb+KMyDKBpjdO=DE72OSHFtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 18/04/2023 15:47, Rafael J. Wysocki wrote:

[ ... ]

>> I'm sorry, I'm missing something. Don't we want to make these sysfs
>> extra information optional and disable them by default ?
> 
> No, I mean no Kconfig option at all for this one at least for now.

Ok, got it

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

