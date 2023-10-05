Return-Path: <linux-acpi+bounces-438-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEC97B9CFE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 14:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 859FCB207A3
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D5F12B60
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pVXUvDcx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15F125CE
	for <linux-acpi@vger.kernel.org>; Thu,  5 Oct 2023 11:20:54 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C61D24877
	for <linux-acpi@vger.kernel.org>; Thu,  5 Oct 2023 04:20:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50337b43ee6so1121093e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Oct 2023 04:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696504850; x=1697109650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfjjBx8bRosL03zIEqb5fC4vsYyRufBl5/7gyLY5YvY=;
        b=pVXUvDcxNUXW6+THwL9jZb+yNvyRIIPsCJDfdl47zAG0kTrjnhCvDX5K+zS+Zhs+ui
         tRDkiUaCK2W4pFN0R2jc2dT+Aj7BjpUmT6Tqhh6/UMoCpIUmvsqDggo8aQ8u2bvkc7qF
         sv1p1cnUoUUWwCLyQFMvMJndP1PcnYxgdOkpj3uPkDBigp2qFkdrYsgK3KYDBeElxQXs
         hKZvK4vlhUNdFJIS6y5c7VzLeO9c4G5TsSx40Vpyo2OJXApZGFwd50hkfh8ww0Dm3gmm
         jV+RcmqPdFLS8fC0ROj8eyZj3xq7h9T1/OUDUG5S78KivRYfMHRa86VNcdksxuGjzIj7
         xEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696504850; x=1697109650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfjjBx8bRosL03zIEqb5fC4vsYyRufBl5/7gyLY5YvY=;
        b=gObsPHxR5WOqAIqs0GgIFSiOyk9ho6txrTsG2KzrgcLVA691HpB4+zk+xBgnwi+Nmr
         UAHbTS/XF+HhkgmgmTSwd3E4uIbzkjwzV7ySggmuy8Gdzv3SzkuuER/ey9OgpphsCIjh
         b6dWK+k6AHu7jZcBb4RYc0XJFFXoyRPblEUlCSkjHMq0imMdPWjwMdJCd3AkHr3yahE7
         eU850lSKltq0WJsRxA86KuuN7WwxF9RdhgLMPg6gWCMMqLvWdjDhVE+iKezCsmkenQHa
         oyTV7LkeRHfGS9dxrJecfnr1ZGANHOtKZcyy+0/R+Dp2HixgQqXcgq8vJ91vDGl0r+T9
         Izmg==
X-Gm-Message-State: AOJu0Ywu74mxzmOlLDmrWIf86hi4ywdTJ8U6bOSgeTE16zn9Lkj7aybK
	bPujBmkAIreVs19J5mSQ9hTi4g==
X-Google-Smtp-Source: AGHT+IF8iEf39U3EvChPzm6UH7GQU2jK7ervLMhE6RcloOs8ZvA9CjMZCrFvVxd2JoT2k/lXG3kZhg==
X-Received: by 2002:a19:8c0e:0:b0:500:bc14:3e06 with SMTP id o14-20020a198c0e000000b00500bc143e06mr4555039lfd.44.1696504849804;
        Thu, 05 Oct 2023 04:20:49 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8bb6:12b3:863a:e5dd? ([2a05:6e02:1041:c10:8bb6:12b3:863a:e5dd])
        by smtp.googlemail.com with ESMTPSA id hn8-20020a05600ca38800b00405959bbf4fsm1297865wmb.19.2023.10.05.04.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 04:20:49 -0700 (PDT)
Message-ID: <3620cb02-c6af-cd65-439c-92ea9c369174@linaro.org>
Date: Thu, 5 Oct 2023 13:20:48 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/6] ACPI: thermal: Use thermal_zone_for_each_trip()
 for updating trips
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <4846448.GXAFRqVoOG@kreacher> <1954465.PYKUYFuaPT@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1954465.PYKUYFuaPT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 03/10/2023 15:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rearrange the code handling notifications from the platform firmware
> regarding trip point updates to carry out one loop over trip points
> instead of two of them by using thermal_zone_for_each_trip() for that,
> which is more straightforward than using a combination of
> thermal_zone_device_exec() and for_each_thermal_trip(), each with its
> own callback function.
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


