Return-Path: <linux-acpi+bounces-410-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6937B7D36
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 12:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 031791C208A3
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11A811182
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:32:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D666410A0B
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 09:36:59 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADCDB7
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 02:36:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-538575a38ffso3189438a12.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Oct 2023 02:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696412216; x=1697017016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Guzco4DSTTWXEfu8ybH7kjykVNG0n/YKMR7x/qH9e8=;
        b=AXBse7OIikUbZdQzQ4vENGkPzRkgu770UOtiGwMzyIsVN3bKvMrnOHduil55Mc4O9C
         8Vuo6Fvl7DNjvWIarrdWLcN0OAVH2ZMA+M/AjYygCa7ZhFENmpq4ezXDbJ9ovbnN5eRW
         MOhrIE9xGIiUEN8vjOBzdnFg36EUjsJkktfnsZ0MdpCsymzPMa9gXOWXDIz6gELF6R1B
         F33QqaP8yv99Uat09x3dU9UAZoXFUwqHCOt/SMtjlk+3Z8uIz9HOjGhNieVuya6Xwply
         lYmCIKdvTNSl+g/8Nb4QI5WLPQRzAFmJHSqSC4DuLBCaSWmUgxa731ZdVilmFLs862d2
         qu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696412216; x=1697017016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Guzco4DSTTWXEfu8ybH7kjykVNG0n/YKMR7x/qH9e8=;
        b=HB6MM+wsXKVCmFwQFXzsUNopfKD+wwzt5+mQO9e7n48wlxGPFtpwA6eDmis45HzV2z
         jHSjAi2b4MIXHFwww/RLxjxo0KCdHFyMuSKORiPC2yAKytDCU02jI6WagOXdQBT/kcKx
         CuM2GW25z1WkDFQyYinQhl+qLHBx/FcoR16bcYydcoNzsOtWGzshxcBjDjAViYlLw6HU
         Oh8en6N2owInTv2NlnT6y+hf/mlvFzTqWEXD7zYUY69nCDboH1JAanCN9XP8Zwxv4T2q
         DoAyFe4SVGjLMMLm96WPuJX5nJs9l2zeeUm2l24mng+/uKEl/zb6qV03pg449kp4EwQ5
         kCCg==
X-Gm-Message-State: AOJu0YyYMDwIeACI3xulhQug5c/2ZvLK2fJZk3nJE4np9XlNYcmpEY0l
	a7R95GMfbiTDG42m2o1lcKqmkw==
X-Google-Smtp-Source: AGHT+IEoubDP+B0lU2jNpnEUEsVHJUJVFBBTVjFgOdeCBxKG0jZjj0Ek+Gv193MqbBNX8ImHfHwjUg==
X-Received: by 2002:a17:906:8467:b0:9ae:62ec:f4a1 with SMTP id hx7-20020a170906846700b009ae62ecf4a1mr1472429ejc.33.1696412216340;
        Wed, 04 Oct 2023 02:36:56 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a496:68ab:9165:6f16? ([2a05:6e02:1041:c10:a496:68ab:9165:6f16])
        by smtp.googlemail.com with ESMTPSA id 6-20020a05600c22c600b0040303a9965asm1042161wmg.40.2023.10.04.02.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:36:55 -0700 (PDT)
Message-ID: <1c551796-0143-a511-8c51-1feafab031d8@linaro.org>
Date: Wed, 4 Oct 2023 11:36:55 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/6] thermal: core: Add function to walk trips under
 zone lock
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <4846448.GXAFRqVoOG@kreacher> <2169023.irdbgypaU6@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2169023.irdbgypaU6@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 03/10/2023 15:17, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a wrapper around for_each_thermal_trip(), called
> thermal_zone_for_each_trip(), that will invoke the former under the
> thermal zone lock and pass its return value to the caller.
> 
> Two drivers will be modified subsequently to use this new function.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


