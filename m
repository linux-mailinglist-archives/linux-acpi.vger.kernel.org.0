Return-Path: <linux-acpi+bounces-409-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CB77B7D34
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 12:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 3BA6B1C203BE
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB3411199
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:32:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AA010970
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 09:27:45 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D96AB
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 02:27:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313e742a787so402435f8f.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Oct 2023 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696411662; x=1697016462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GV07epPUhdpXIZJvIiHNiYuLVJzB4+rIWncb07cQYck=;
        b=MRZnoeQ+khQZhRHvI1Se/LvEa/r8QQl4OqSpf71hRo+OpzJPATmQE27WyOaTVvyqNA
         O02KiZsP+8JLcTjs2O97d4mLOPUIFL9MwfwkR8phSAuBByV2lzxclUQAzVhKbbW07iaQ
         WK5IYHLAjs9Teo4oSrqL8JuCvZuH6WCjEIjpJQR/zxgb2BJu6tekENLbDLfwlK0X8cGM
         hm77yLP9pMUyvp44R3YjTJape2xDVPNLBco1ldfpK3hgYlSChX+3hqDU7Bk2+WsWUJME
         rM85lAmZ8kb9RbbrIe2V8cThQ2MfkPnSpktCvsyAE/cOPI92WPIVViZCKo/NMoS63T3+
         s3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696411662; x=1697016462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GV07epPUhdpXIZJvIiHNiYuLVJzB4+rIWncb07cQYck=;
        b=guMfZd+VunflX40ykKyvb8AmFIqtTbH9hySzSXfxrxegE79RyiZtCZVA/or8eNLh9V
         g267aQS8G97duJ2J9qaXLEnAUnW3/0hxItRcW2KbakKXGWDgjq/iCAR1w89Eoy8IpePz
         FpcnlzWOEpqTZG0Ly5VY42yUKLtocZq6zkPrF45hUWMd/COils1NSE2a+B5F2S8jxSuQ
         wzWUL+EBCZZnyQSUJPbVRaUiV0LBmTAVvsVq6F0mEoW8HUTc0ib8A6W9wsGVP3UAPnBT
         kv5LacX6v6iAKvLPQxdB10fwpaBlxXlh65RZR58yPHeEZMPYLdofhp+uNDzY5uJChdAc
         YPMw==
X-Gm-Message-State: AOJu0Ywp5c2KqoVyHaluRSMYs41KNQ3L+loQmyXsMwMuMIaDqinjVxT1
	ZtrXwLzAeCIM+JBqVU+0UMue2mTDa4bHUI2/huA=
X-Google-Smtp-Source: AGHT+IEhGkRm0jB/vOVqBUcw85K/yXWd9yl+QL/eAUriv9nNYkaNvnaOfk3tmGC0ovEn+CPTO1Vprg==
X-Received: by 2002:a5d:4691:0:b0:31f:335b:f436 with SMTP id u17-20020a5d4691000000b0031f335bf436mr4531952wrq.22.1696411662543;
        Wed, 04 Oct 2023 02:27:42 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a496:68ab:9165:6f16? ([2a05:6e02:1041:c10:a496:68ab:9165:6f16])
        by smtp.googlemail.com with ESMTPSA id f8-20020adfdb48000000b0031ff89af0e4sm3526249wrj.99.2023.10.04.02.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:27:42 -0700 (PDT)
Message-ID: <264060f0-0cbc-d9ef-cc4f-cd327d5725b1@linaro.org>
Date: Wed, 4 Oct 2023 11:27:41 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/6] thermal: core: Drop thermal_zone_device_exec()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <4846448.GXAFRqVoOG@kreacher> <7586518.EvYhyI6sBW@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <7586518.EvYhyI6sBW@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 03/10/2023 15:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal_zone_device_exec() has no users any more and there are
> no plans to use it anywhere, revert commit 9a99a996d1ec ("thermal: core:
> Introduce thermal_zone_device_exec()") that introduced it.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
> 
> v1 -> v2: No changes
> 
> ---
>   drivers/thermal/thermal_core.c |   19 -------------------
>   include/linux/thermal.h        |    4 ----
>   2 files changed, 23 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -493,25 +493,6 @@ void thermal_zone_device_update(struct t
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_device_update);
>   
> -/**
> - * thermal_zone_device_exec - Run a callback under the zone lock.
> - * @tz: Thermal zone.
> - * @cb: Callback to run.
> - * @data: Data to pass to the callback.
> - */
> -void thermal_zone_device_exec(struct thermal_zone_device *tz,
> -			      void (*cb)(struct thermal_zone_device *,
> -					 unsigned long),
> -			      unsigned long data)
> -{
> -	mutex_lock(&tz->lock);
> -
> -	cb(tz, data);
> -
> -	mutex_unlock(&tz->lock);
> -}
> -EXPORT_SYMBOL_GPL(thermal_zone_device_exec);
> -
>   static void thermal_zone_device_check(struct work_struct *work)
>   {
>   	struct thermal_zone_device *tz = container_of(work, struct
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -340,10 +340,6 @@ int thermal_zone_unbind_cooling_device(s
>   				       struct thermal_cooling_device *);
>   void thermal_zone_device_update(struct thermal_zone_device *,
>   				enum thermal_notify_event);
> -void thermal_zone_device_exec(struct thermal_zone_device *tz,
> -			      void (*cb)(struct thermal_zone_device *,
> -					 unsigned long),
> -			      unsigned long data);
>   
>   struct thermal_cooling_device *thermal_cooling_device_register(const char *,
>   		void *, const struct thermal_cooling_device_ops *);
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


