Return-Path: <linux-acpi+bounces-217-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF527B0A27
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B0A37280E2C
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D59250F5
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:31:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA515A8
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 14:56:47 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3418FC
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:56:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3231dff4343so4969796f8f.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695826603; x=1696431403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sngrgBmcc0SNVGKMiz3UxrHAAX6L7zKBd8TMIQEgu/I=;
        b=WOgYVGT5dOoRVhJF6Qn4HMadW3x8DLaZ95Ld0oVJzxMai+4yKPSVxdwYcKZxDxsZkM
         DwSxvgz0uAXEhguosm1qU8ElSAv7BdGhut5jxgE/rbR3hWrjJbyzrsoJqMw8RV9yZwFm
         s5HXirslZWY8eR1cy8Qf4sD8ZuyvFFU9ANrusjeZSkywUDR8EVnGsN+qX4f+e//hukss
         lVA0UJqPSconPT304216rYeiVZOd9nwgt09Auj+zlACCdJjKXJIp/LfDbcsAAssTcff3
         Vjtrvet2MVzg5FZxHcjF3YFDg5JXajELiSHDWt5z5tHE2TfRnH5+vQ12vPHK08Dc9X5U
         Hkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695826603; x=1696431403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sngrgBmcc0SNVGKMiz3UxrHAAX6L7zKBd8TMIQEgu/I=;
        b=NYIJnJWiCjnqiWmv98vOB4P72IGFLuCBnEdSXMQOB1aB7JoPK9l6g0sgziUi1xbp4K
         /cJ5B+lHdUvvyu1jdaFEkmBPYm7mcavYwiDrCt41UAJlaxI7QbYWgeaaVDGNWTK6LCre
         4V3n68KPGRk37TZQnbI+xLLC4AjQefJYZwBj6R+3XGt7igt2ayaIe1tPG4R+4WRbKYWk
         TdeQ5CfrBZ8Q+AqCeSLNKh5CAgtd49c1J7tTNgKx0FIDWJHDBuaJXIRVhPqOyISz2L8F
         YoFs1rJHU2R9fm8seF5OQtVEJx8pbG81jBZ5hDKBKEWttjttFAjRp5vYI29eZuLpc/+I
         wefg==
X-Gm-Message-State: AOJu0YxjoyYm9j0lta4p/tXBJCFHBP4OYqSQZQ1ZhF3NZG+Zzm+VF+S8
	YH9NWuS0SxVQZroPVaxeplWYyaUfS6uWeVOWqL0=
X-Google-Smtp-Source: AGHT+IEmnAhUscM+ELai9UJbSrjbIHumSFpekzbWpdFz9hhQRNPdNIpgopswacO/VqV16BtM9+v2+g==
X-Received: by 2002:adf:fe09:0:b0:323:30d0:5c4d with SMTP id n9-20020adffe09000000b0032330d05c4dmr4942698wrr.19.1695826603342;
        Wed, 27 Sep 2023 07:56:43 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id r2-20020adfe682000000b0031ff89af0e4sm17283525wrm.99.2023.09.27.07.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 07:56:42 -0700 (PDT)
Message-ID: <bb7f32c9-249c-2ad8-135c-82098430bcfd@linaro.org>
Date: Wed, 27 Sep 2023 16:56:41 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 05/13] thermal: core: Store trip pointer in struct
 thermal_instance
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <1977624.usQuhbGJ8B@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1977624.usQuhbGJ8B@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/09/2023 19:52, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the integer trip number stored in struct thermal_instance with
> a pointer to the relevant trip and adjust the code using the structure
> in question accordingly.
> 
> The main reason for making this change is to allow the trip point to
> cooling device binding code more straightforward, as illustrated by
> subsequent modifications of the ACPI thermal driver, but it also helps
> to clarify the overall design and allows the governor code overhead to
> be reduced (through subsequent modifications).
> 
> The only case in which it adds complexity is trip_point_show() that
> needs to walk the trips[] table to find the index of the given trip
> point, but this is not a critical path and the interface that
> trip_point_show() belongs to is problematic anyway (for instance, it
> doesn't cover the case when the same cooling devices is associated
> with multiple trip points).
> 
> This is a preliminary change and the affected code will be refined by
> a series of subsequent modifications of thermal governors, the core and
> the ACPI thermal driver.
> 
> The general functionality is not expected to be affected by this change.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


