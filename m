Return-Path: <linux-acpi+bounces-229-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A93F17B0A39
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5B9B22810FF
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441DD3C692
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B96FA2
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 15:46:28 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F21B27E64
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 08:46:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3247d69ed2cso1018287f8f.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695829581; x=1696434381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZzt5XBuyL7sQG3cvWFg8cgyTXnGH+fRJeVaRnN9Qf4=;
        b=I8qoBeGoQCFR4356SJJmVTiXDRQO2Ib/LlfXEC14r/K+CLLEcbg4IHiwu9T7q6ZKBU
         g2GOHjK8ES38mmN53GRHZbLl/v2Hb3MfZiO19qIoj4u9zUhfR4JHKA3f8G6eVERBqyeS
         I2dUVRwgjXOToApRcMIjFrfMKf3tjIU88x20dlR5BnmULiEMLE4VULE8vpLW1oZRjEn0
         9AdWH8UV8g/VcuL7OkKuueA9tNSPmx/Nd5VPTvrou1BPkAW0Cq9Gc9LEhYbzUqpqAEju
         3FDMXQCDkmR3rTRbE9qg/wV3JXj68cKPdaRXfyN0MaieLJ1Jju/fPHMdeHQ/h/ceRqEd
         MtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695829581; x=1696434381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZzt5XBuyL7sQG3cvWFg8cgyTXnGH+fRJeVaRnN9Qf4=;
        b=tGjwrof3OkbnyUORVIBq7WbFEtiveKLVS1SxdiOxA4svHZO7dp3084JcLNX0iExFxA
         n4lwxX1wE/w2l2ZI/wRh29EYpok/bqWG1cJZUhagQLc9w9e/K6dKMhWqMKrFtXvau+fv
         KZTN1+X28mhyEpgvVC/+QMbHxkAsAGX7+aBZKKHi2KodeDlNTRlk2Vv+wsYHb/4e9/JB
         35OUslF4Nw/QEBZ6hQ29POdNUUSM8cSrcnAqea9cx+VcO2Cras48bxt/+EIDW8ZtBeEh
         N0loNSlfqsTd9jw71G5zX2ohJx9/MP2OD/cmAmXiQMx+TvKRsCr4gkTRhQgguYI0JflP
         f4bQ==
X-Gm-Message-State: AOJu0YzqMuiX55e50E2sB6URNphDQNU4r+LojleHGIBZvwdR0Rrju7LS
	OXCPk9cdsGWbcwv+hVAbOpwGug==
X-Google-Smtp-Source: AGHT+IF0gGzO/1WtdXP1cP/+fuvUlycIhHLeGdWpEyYyip6IBNk7pYQnlaUas0tL6cENonjqHnBPVQ==
X-Received: by 2002:adf:f707:0:b0:31f:d8b3:e9f5 with SMTP id r7-20020adff707000000b0031fd8b3e9f5mr1972549wrp.34.1695829580788;
        Wed, 27 Sep 2023 08:46:20 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id c9-20020a05600c0ac900b0040646cf9fa7sm1394994wmr.42.2023.09.27.08.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 08:46:20 -0700 (PDT)
Message-ID: <f193e4a5-b315-a1bd-7488-7ea0d5e267f8@linaro.org>
Date: Wed, 27 Sep 2023 17:46:19 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 07/13] thermal: gov_power_allocator: Use trip pointers
 instead of trip indices
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
References: <1957441.PYKUYFuaPT@kreacher> <2590280.Lt9SDvczpP@kreacher>
 <9f1374db-f866-ff52-e86c-99fecee24d1b@linaro.org>
 <CAJZ5v0hw3LGByW=18tiFEB7JQ9rOVo6TqCGhzxWcrUQYb+VGEw@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hw3LGByW=18tiFEB7JQ9rOVo6TqCGhzxWcrUQYb+VGEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 27/09/2023 17:27, Rafael J. Wysocki wrote:
> On Wed, Sep 27, 2023 at 5:10 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 21/09/2023 19:55, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Eliminate the __thermal_zone_get_trip() usage that adds unnecessary
>>> overhead (due to pointless bounds checking and copying of trip point
>>> data) from the power allocator thermal governor and generally make it
>>> use trip pointers instead of trip indices where applicable.
>>
>> Actually the __thermal_zone_get_trip() change was done on purpose to
>> replace the 'throttle' callback index parameter by the trip pointer and
>> removing those call to __thermal_zone_get_trip() while the code was
>> using the trip pointer.
>>
>> IMO, the changes should focus on changing the trip_index parameter by
>> the trip pointer directly in the throttle ops.
> 
> So you would like .throttle() to take a trip pointer argument instead
> of an index?
> 
> The difficulty here is that the user space governor needs to expose
> the index to user space anyway, so it would need to find it if it gets
> a trip pointer instead.
> 
> Not a big deal I suppose, but a bit of extra overhead.
> 
> Also it is easier to switch the governors over to using trip pointers
> internally and then change the .throttle() argument on top of that.
> 
>> The pointer can be
>> retrieved in the handle_thermal_trip() function and passed around for
>> the rest of the actions on this trip point
> 
> Right, except for the user space governor which needs a trip index.
> And the indices are used for tracing too.

Given the userspace governor is going obsolete and the notifications are 
for the userspace, which is slow, we can retrieve the index from the 
throttling ops

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


