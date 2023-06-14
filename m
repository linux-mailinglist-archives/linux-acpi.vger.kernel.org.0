Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E7E724964
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 18:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjFFQl5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Jun 2023 12:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjFFQl4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2023 12:41:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952DDE62
        for <linux-acpi@vger.kernel.org>; Tue,  6 Jun 2023 09:41:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f61530506aso64553455e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 06 Jun 2023 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686069714; x=1688661714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJVhSFzwvoXL05SwEZRGFG8BPsH7hzDQHLdfK0N4XEI=;
        b=jKMO/zj8MTHMUyGzGIwHAMXxOmIVqnupiRJCkJli9mbhTU0IpdJFEbDGrDRo/71m2C
         uM4dtMlMedubAfYBiDCvD3x6E0c3xfvAm/11BRDR+6yynRnTUWaUbz5yFZAObPz7Ov9L
         rLKTwYLYqJ8i1J9zj66laViBXJM0zY4ahwF0G39Jx84REtgxXe9E41d8JdWuaXJWJ0T4
         oPUh0XhpF+iBwnTFb0TZW0sMMTbjMmntxMkMn73mNQPpg6Fvoc4tWzH57beDh04eFBKY
         S51Zjf7YLnKxC4mFGjI4lUGVANIeVGMHPBNR9AGH4rN8Y1Wnkrf7TRBILEYb1MFmB/p5
         sZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686069714; x=1688661714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJVhSFzwvoXL05SwEZRGFG8BPsH7hzDQHLdfK0N4XEI=;
        b=koBKM6vMh/DM7BtQpGzYDYPKXwtuAudCFq1ZiYskdlfn/MiSwgwi5x5jWyvO1uIYBQ
         nbrya71shgE+BWgLRsDniDWlY1CyheWee4O7eAyfYsRfgUhCWX3CdQ3CFyyniVN708ES
         AMM2Y7OqAponI6AVbfYscjrVn7Uc2vRlQNdZbHyMMdq5/EqMMkpglmNKCA4srpy4G3vH
         2EtZPjoj1/SBaqH2luzVha7v4ySLmNIwrjpSGMdm8NJtF6ze4VSnOKyJ1MpAXEbdnl1h
         tRa1zqCmyOxJ+4gT7/8RGu96lrCiox61KjPhvEiuTw6ki6fN9TjuAi7JnFDgYJMhm6GH
         Klzg==
X-Gm-Message-State: AC+VfDzER9vJUlUYpxkiN/4Jh/6AYpcC5SO91hIt6SKJA14KeTY7VJ8O
        zv7JvGNaSdjvAaxvoQYBD4QqwA==
X-Google-Smtp-Source: ACHHUZ68Q3UxcFpcphCWiDRHpz1V6fxBIaMziwmeBQ/sCgLY/1mKB8AXKDG8EJbcYUMmVERBpEbrBQ==
X-Received: by 2002:a1c:741a:0:b0:3f1:789d:ad32 with SMTP id p26-20020a1c741a000000b003f1789dad32mr3040046wmc.11.1686069714005;
        Tue, 06 Jun 2023 09:41:54 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d8fb:84d9:d402:6b22? ([2a05:6e02:1041:c10:d8fb:84d9:d402:6b22])
        by smtp.googlemail.com with ESMTPSA id f18-20020a1cc912000000b003f4e3ed98ffsm14492860wmb.35.2023.06.06.09.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 09:41:53 -0700 (PDT)
Message-ID: <0ddddee6-c01b-0989-6d49-c05568188c48@linaro.org>
Date:   Tue, 6 Jun 2023 18:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 4/7] ACPI: thermal: Move acpi_thermal_driver definition
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2703629.mvXUDI8C0e@kreacher> <3761470.kQq0lBPeGt@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3761470.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 04/06/2023 14:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move the definition of the acpi_thermal_driver structure closer to the
> initialization code that registes the driver, so some function forward
> declarations can be dropped.
> 
> Also move the module information to the end of the file where it is
> usually located.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

