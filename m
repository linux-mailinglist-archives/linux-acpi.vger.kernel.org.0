Return-Path: <linux-acpi+bounces-152-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F76A7AF2F9
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 099F428181D
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EBC47C72
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:31:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7429419
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 17:18:38 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE27124
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 10:18:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4053c6f1087so85094215e9.0
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695748715; x=1696353515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/873jRuHIB8KVUpv9XQXwxtjHGUlH2X/UtfyeX7Noc=;
        b=Si3HMSDUoMibWMXh853mDl3QfwMuqGLorOYRp1vZM2s632lwxSSsTvWvGtinclTLrq
         6bUIfKKCv1SKG9Vcyx0wkv+H1gO4ggTp31oEtA3svMVjfltYFAAYQ490NFeEjcbTmQQ9
         qsOqiZQB2EDJElqx+pfG485zisQtEYd/atnR4y7uK65BJHZbrRxAdVdEt/ghc5fIGw+A
         bZRXSwVo2AjP+LWCWTAHxXUwfiSERRY9Vm4gzZLwj2x6w8W6gjZ+jvbxhoTXkGBgm9s2
         t0LSdj3Dg0DfbDQaKIvSovxSXMcn5wf5i7nENX1pZFS4SBkllKN29iZXFLIR8KGRcXRx
         vTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695748715; x=1696353515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/873jRuHIB8KVUpv9XQXwxtjHGUlH2X/UtfyeX7Noc=;
        b=E+emDGKDvHc+6tFaFu8eXaTqVVWnJWxeTt9JqrZletrTVPtqG0dQaeIR5whD0G89m+
         4ez0R03qX8M8Ugi/aMmN9mFXnueg2c/dKAlZr/Gw41YPR+1y4xI9RkZB6LStds5+Sm4r
         Orn/jpVN7zs7pBEVXx5NUc1wbSEMjJkFoWG8oy33k5DLLj9DKP0U5l1qYxmKHYzGJ08L
         M2yExKNXNyyPxognGMB5ZXgiYtUBpLe0GH1FlHgqUpQDQWUq28G3qLe3T9nU9BH97Eb3
         Ucx3yclfGvD2XvoNjlA3EXlqwWttpUksO8SaYExzvfEsW/3CXpOwqUI2E5mdgFvb3CAu
         kKkA==
X-Gm-Message-State: AOJu0YziosIKQywb+fCbkVyPESNga36ojSDhVoVoOQZ+SaTNzsZah2se
	fE1oBPycaf1sYmhF/vG08fnmvQ==
X-Google-Smtp-Source: AGHT+IEDQG3OiHowx9com9DgvI1ed+w0oyedIjlgxDirS7OxkA2/EvHN12Z6TpEqao+AYEtYtRfpDw==
X-Received: by 2002:a5d:6d87:0:b0:323:3ab5:990c with SMTP id l7-20020a5d6d87000000b003233ab5990cmr1828775wrs.44.1695748714652;
        Tue, 26 Sep 2023 10:18:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id h17-20020a5d5051000000b003197c7d08ddsm15139853wrt.71.2023.09.26.10.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 10:18:34 -0700 (PDT)
Message-ID: <38ea14aa-ecc2-c40e-34ea-05b348158cfb@linaro.org>
Date: Tue, 26 Sep 2023 19:18:32 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 02/13] ACPI: thermal: Collapse trip devices update
 functions
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <3534976.iIbC2pHGDl@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3534976.iIbC2pHGDl@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/09/2023 19:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to reduce code duplication, merge update_passive_devices() and
> update_active_devices() into one function called update_trip_devices()
> that will be used for updating both the passive and active trip points.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/thermal.c |   53 ++++++++++++++++++-------------------------------
>   1 file changed, 20 insertions(+), 33 deletions(-)
> 
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -43,6 +43,8 @@
>   #define ACPI_THERMAL_MAX_ACTIVE		10
>   #define ACPI_THERMAL_MAX_LIMIT_STR_LEN	65
>   
> +#define ACPI_THERMAL_TRIP_PASSIVE	(-1)
> +
>   /*
>    * This exception is thrown out in two cases:
>    * 1.An invalid trip point becomes invalid or a valid trip point becomes invalid
> @@ -202,18 +204,25 @@ static void acpi_thermal_update_passive_
>   		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
>   }
>   
> -static bool update_passive_devices(struct acpi_thermal *tz, bool compare)
> +static bool update_trip_devices(struct acpi_thermal *tz,
> +				struct acpi_thermal_trip *acpi_trip,
> +				int index, bool compare)
>   {
> -	struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
>   	struct acpi_handle_list devices;
> +	char method[] = "_PSL";
>   	acpi_status status;
>   
> +	if (index != ACPI_THERMAL_TRIP_PASSIVE) {
> +		method[1] = 'A';
> +		method[2] = 'L';
> +		method[3] = '0' + index;
> +	}

Could be index > 9 ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


