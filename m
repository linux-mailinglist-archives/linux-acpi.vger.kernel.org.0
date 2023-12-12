Return-Path: <linux-acpi+bounces-2312-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6F980E91C
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 11:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6743B20B73
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 10:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879455B5C8;
	Tue, 12 Dec 2023 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWSJc2xF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2843A7
	for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 02:29:00 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c517d0de5so4227305e9.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 02:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702376939; x=1702981739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SeaHyhX4qasj2Fu/2Tzw0gDqXLK0DSDWi5tqGB7yRow=;
        b=pWSJc2xFCXZLrPuMMxxRCC9WamSLAAVlaaXps9vZi3jeKCNwbPOk/mlQihc7Kk8B/I
         Y110Nhjf3FX9MsCR7rlUcwwdYNmYdTCOeykrD/lo8ALEcE1baU7nnhqcduWjrYt9Ioo9
         5pE/R3wfoTi/7UrmKyPvaZscU8f7f96JCrZxToWW5V0OLLSh820y+zwmOk68LCOiBHy/
         xCmIYw/aN3IAaNnWVLWtZREFbJawncfqTsAocTku6UAQTS4qtXlqgPxCgh/QhdV6g5Pd
         fslPcjm9XQ5D/cUkf/9aIaBODH962YSJODqpJePKf//p81xSl6KGKHaorFhlc1Mb36/t
         YgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376939; x=1702981739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeaHyhX4qasj2Fu/2Tzw0gDqXLK0DSDWi5tqGB7yRow=;
        b=QkctyUqIdtuNScP/lTsneHPD5R/9JYE68hvOIo0VHzHvT0LPD+ocbA3KE5ThbavtKc
         vFSrcm16fCsza0t9POdtLncWzGll2RdoD2hoxIUm7mFf2wkPMik9KJXuphPJfkTUjoWi
         3NJIpPb/RHJ5IKxqTs2R4oOj6Ga3HgG3954jWI1EohWf7JO7koTMe34henOLQwA3eV6A
         sQJjnzOSKaDYXegbqKudq2LBdslna2p8vHzGMWq7q4mgKsP6ESWNWuG1BuWieZN0LkUB
         HJVPg/E9rZfgiARgIBBp8ObCZFZktaOk2d4XTebjZFNj2TJG8SClEPpjvQpZd5Fo5sR7
         vkoA==
X-Gm-Message-State: AOJu0YzwMJg8BlmXaReuNyONiUKAnZopqlXSsqf+mm/uaaiozPDcaTQP
	q9ktYQv3isDf1NOYagkNkPQsGQ==
X-Google-Smtp-Source: AGHT+IG8Mi1NW4ZQL2JUpn9jDg8U09Wzj4C75n5+zKSqiV8ANwx3mL4BdG+yoSgmB2FhjMXbnihMUg==
X-Received: by 2002:a05:600c:1686:b0:40c:2992:716e with SMTP id k6-20020a05600c168600b0040c2992716emr3176778wmn.129.1702376939137;
        Tue, 12 Dec 2023 02:28:59 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id fm14-20020a05600c0c0e00b00407b93d8085sm18366061wmb.27.2023.12.12.02.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 02:28:58 -0800 (PST)
Message-ID: <727a776d-43bc-479b-bd63-80a0985f99c8@linaro.org>
Date: Tue, 12 Dec 2023 11:28:58 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] thermal: core: Rework thermal zone availability
 check
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1880915.tdWV9SEqCh@kreacher> <2258035.iZASKD2KPV@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2258035.iZASKD2KPV@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/12/2023 20:20, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to avoid running __thermal_zone_device_update() for thermal
> zones going away, the thermal zone lock is held around device_del()
> in thermal_zone_device_unregister() and thermal_zone_device_update()
> passes the given thermal zone device to device_is_registered().
> This allows thermal_zone_device_update() to skip the
> __thermal_zone_device_update() if device_del() has already run for
> the thermal zone at hand.
> 
> However, instead of looking at driver core internals, the thermal
> subsystem may as well rely on its own data structures for this
> purpose.  Namely, if the thermal zone is not present in
> thermal_tz_list, it can be regarded as unavailable, which in fact is
> already the case in thermal_zone_device_unregister().  Accordingly,
> the device_is_registered() check in thermal_zone_device_update() can
> be replaced with checking whether or not the node list_head in struct
> thermal_zone_device is empty, in which case it is not there in
> thermal_tz_list.
> 
> To make this work, though, it is necessary to initialize tz->node
> in thermal_zone_device_register_with_trips() before registering the
> thermal zone device and it needs to be added to thermal_tz_list and
> deleted from it under its zone lock.
> 
> After the above modifications, the zone lock does not need to be
> held around device_del() in thermal_zone_device_unregister() any more.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


