Return-Path: <linux-acpi+bounces-251-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F487B1619
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 10:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3A67E2829B6
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 08:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249233991
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 08:33:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42C0523B
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 07:28:21 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EB599
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 00:28:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32167a4adaaso12040059f8f.1
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 00:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695886098; x=1696490898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+eHxg0xTah69doYWtwb3xmqSGP3W/4JsRuYUBMyy90=;
        b=HRzVT5LJFfeFHsA9PJuHANQuIMWT8jso4lvbqbCtgoAWcZtczokgNMafpmLBYZd1Qg
         4zs+evEFqWI+E6h7s6eQPzQnlwd9gU1viAiimV/JsLAggFPXqUqd1WrNXwbUebt7LYv8
         K86L8DYv1aAkawCZh92cVviCJ26zmrRg3zsfoSGkGGlKVO2dTZuDtnOi2IIpLU5fDYOJ
         MyBkLW1oFeQt2bTR5YQ7KQHwmqsgNkC7fZfkXvsg7BLV67/oq82EPQrstKwOzB/S9d2M
         HEo2bsQUlWD8avFFsVzw3mnwsDSgVbbcgA0M1g9zDv4eINdCMCzRseIMCud4jZ4D9w7a
         cX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695886098; x=1696490898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+eHxg0xTah69doYWtwb3xmqSGP3W/4JsRuYUBMyy90=;
        b=D/Da2JF9BLlydyvTHn4DjZnt4KulyW7ltWw2VHEBhvUsJIII/jRohAfZRdmuKpl9La
         jUNeOg1dxiyGLpm8Oif+YpSq6Opzt39PgxT/NK6YTMgwTV/VH4wHD+8KWEb5RWfvdfjk
         oNV92jUvmQQB1xPSi+XSzcGFIbXwmnFw0dKKzL1n13cZ7K1yaou0x1KIUAY/DRgbfdqJ
         klwVjDc2Yt+t42yICcnoCluyZrEqiWxVvtvxrE8car80zGr5UIipQI2Q2AF81tluFGuI
         qMvqGK2vU++QxPXQBmV+FISVNxvsxqQaeMLlST7Eie20NoYIFrVgbGcG6BbWpbH2jVuv
         TClg==
X-Gm-Message-State: AOJu0Yxvwl3tb08OMTjr0Er7kWGJCBt/+EV5yS7WntTCAh24JO3WH+ry
	JskWMEBFx0k4a6Fimdd+JyJMig==
X-Google-Smtp-Source: AGHT+IGm3aLmn1Vs2pRb4cnjAOVEm+CwfdP8RHwHV1ILVOpFUpwOuuXw0e0ssaSLKQ3S3zeXZTd9DQ==
X-Received: by 2002:a5d:4049:0:b0:31f:b0ba:f2ce with SMTP id w9-20020a5d4049000000b0031fb0baf2cemr557778wrp.9.1695886097861;
        Thu, 28 Sep 2023 00:28:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id u26-20020adfa19a000000b003232d122dbfsm8613143wru.66.2023.09.28.00.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:28:17 -0700 (PDT)
Message-ID: <a509f509-c9a8-15d3-cb79-fd6594cfb8af@linaro.org>
Date: Thu, 28 Sep 2023 09:28:16 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 13/13] ACPI: thermal: Rename structure fields holding
 temperature in deci-Kelvin
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <1968603.yKVeVyVuyW@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1968603.yKVeVyVuyW@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/09/2023 20:06, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1]
> 
> Rename structure fields holding temperature values in deci-Kelvin so as
> to avoid temperature units confusion.
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


