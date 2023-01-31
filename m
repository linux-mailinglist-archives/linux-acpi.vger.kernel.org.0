Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66836831FC
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Jan 2023 16:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjAaP67 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Jan 2023 10:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjAaP66 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2023 10:58:58 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AAB4F346
        for <linux-acpi@vger.kernel.org>; Tue, 31 Jan 2023 07:58:54 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so10976380wms.2
        for <linux-acpi@vger.kernel.org>; Tue, 31 Jan 2023 07:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MuxDQCViT4/rjK57nPCOeqyGrdJQA3MVCaVUVW/eRi4=;
        b=YdAOPan771llkCfxIt3mEPtlqDgoZQW/siYU6aGXdjvgcN0PoFEOC2cguzS2N5wO3j
         r2k0IQks3V+So8Hj4IUQZj79iZTO0f8ayuAcl5VhgxiqlOi+upTGooiNFS9cKqbhbQfb
         ezFxF8JlImULUtbsrwSNNo+HFg1tYz0eKlkiJaO52tH4FwFOkHNiFald/qqIddZF3kNK
         g3CdxtpiPt4uBgojC6rC4mQgoL6tTwHHPikNngS+5F1HwASkv67c1l9j63CIvAkhe78A
         y06pdTHYwMHPLriRH+YS1ht0AmbgbgkDz8fqnabRq3OL7U7ND1rv4vPTxdCNow6PN0i+
         /DHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuxDQCViT4/rjK57nPCOeqyGrdJQA3MVCaVUVW/eRi4=;
        b=zp8CfWxiwT3Nr1LyLQjstbUd1tCDyJEj+iqdPEpmaMBto/0lAo2L3F1bIKYNmVyEc/
         CT+xg1K4NJu49SFhFJcFVU4gE9Ifi4BtkUJExH54KC6fy2JJblvZbXK8ARH2096ChQ3u
         zDI7M7Epv50H43uxid3QH2J/wGDaLT+U8Vb5gPsSC6HQBMfTk1a1zDFPMgxrPVzEEiJC
         y4cacsC+w+/UglUYV08zd7eS3BL4eBMTUSu4RnZYWCDRBizoKkdNllzj1R65kT4c2RKL
         5tFV7GfjyKkp/bhLf1/+IBtddE2uT/adNDEGH/Jj2zBS6f//rqiZ7qCLRehi8vXm6g7G
         fEJA==
X-Gm-Message-State: AO0yUKVj9MAFLyjGYHtfPeYLQ9776BbAGyaXve32yLUeo0BFTokeE3L1
        Tlej6I45zV0XmuE/JYZVxMwwfg==
X-Google-Smtp-Source: AK7set9RF8riTs5UIMbg/CPy1RXYcMBQ/8OKabm1Lq7LZ+lDz0nM9kFfWlFxQVm/tlOYUxu82e5Kog==
X-Received: by 2002:a05:600c:310f:b0:3db:8de:6993 with SMTP id g15-20020a05600c310f00b003db08de6993mr4348595wmo.4.1675180732607;
        Tue, 31 Jan 2023 07:58:52 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a11-20020a5d4d4b000000b00289bdda07b7sm14910483wru.92.2023.01.31.07.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:58:52 -0800 (PST)
Message-ID: <624ab008-cac6-def9-c2c7-809019aa3c2d@linaro.org>
Date:   Tue, 31 Jan 2023 16:58:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 5/8] thermal: intel: intel_pch: Fold two functions into
 their callers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
References: <1751684.VLH7GnMWUR@kreacher> <3662399.MHq7AAxBmi@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3662399.MHq7AAxBmi@kreacher>
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

On 30/01/2023 20:03, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fold two functions, pch_hw_init() and pch_get_temp(), that each have
> only one caller, into their respective callers to make the code somewhat
> easier to follow.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

