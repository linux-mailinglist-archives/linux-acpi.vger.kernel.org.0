Return-Path: <linux-acpi+bounces-2311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C8E80E914
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 11:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66033B20E3F
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 10:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960085B5C8;
	Tue, 12 Dec 2023 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hl21sWeX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D38B7
	for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 02:27:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c236624edso55511215e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 02:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702376827; x=1702981627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bP7c/myD+U4XEosySZ6ztiiSArLX1tL4AePUf2cD73I=;
        b=Hl21sWeXLsTM9tMfGNr58XTHsV1QSIURVh4TslOeOkWqoOu/cY9PeC1DNzUWT8KkDf
         JZwN17YYUUY2VlDUISj16JVYWWWoFhiDLzc0svcpGMSAFy8vs9K4UYWZv+UylkqLRHby
         oUPUflbG23zsnk10o5J+nTH5422i8D9SIbS/w0AhMvv9KbJVqshB8bX4jeb46CVsxYrs
         GGtTLRmaWEwytOgxLfGNBcJc1eSZssAQ3NiVy5Cfd93nwIqUWmjykNp/DT8y1zfnkhdF
         BPF4S/aCKY6tu1PKgAR+It2VHu/RvPcbvnZFNakSWt0CWB568suGU+8soTL9wZ9+PM38
         XdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376827; x=1702981627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bP7c/myD+U4XEosySZ6ztiiSArLX1tL4AePUf2cD73I=;
        b=Id+1g8PBT63hX+a4QMMi/ge4EcKBvMwwf2O7LiE+jZ9wcPKHIYrVq33gEXFUGHmNvk
         vCnOme7tCziqUkHFBF6Wwz8S/Y4c/6cHw7iF77C1CNW8ckJeSJBLZTpQYnqk7vCjZjIK
         KnGHgPTi2Qa7Fmv3AZCUJA3+LjFnR6Oq91zW1yFevQVz+7YTk+VwMUjzKPie+gV8jN34
         K9oheX3JWhvKipnDa3HWtQarSRcpFMrvpS1snKGWlg9dHMFeL6Dt5IM+ZVmdMZSc6PPo
         UCcMZ6+uHVYktM1PBm1iS3AoI4TXwvtbo2Pf8+3w45shmbqLAegySUwFHKy1NBt8oJeQ
         jYBA==
X-Gm-Message-State: AOJu0YxnWeP0GAL9rsmt2bLHS0cqVh/66ZBgPNIFU0aGiVReXG/ftALc
	JDImlw7VKjMsPOEvGEu4RfF0Rg==
X-Google-Smtp-Source: AGHT+IHblXeYca94XO3E77V6KfmgI1d4gvlmZb1uBnhu93oy+88S/yL9ov2zWzTICD+TC9oVsJYjmA==
X-Received: by 2002:a05:600c:45cd:b0:40c:271a:e7f7 with SMTP id s13-20020a05600c45cd00b0040c271ae7f7mr2646620wmo.145.1702376827190;
        Tue, 12 Dec 2023 02:27:07 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id b1-20020a05600c4e0100b00405959469afsm16189200wmq.3.2023.12.12.02.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 02:27:06 -0800 (PST)
Message-ID: <9d8e3701-1259-479d-98eb-46398655f1ac@linaro.org>
Date: Tue, 12 Dec 2023 11:27:06 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] thermal: Drop redundant and confusing
 device_is_registered() checks
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1880915.tdWV9SEqCh@kreacher> <8315317.T7Z3S40VBb@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8315317.T7Z3S40VBb@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/12/2023 20:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Multiple places in the thermal subsystem (most importantly, sysfs
> attribute callback functions) check if the given thermal zone device is
> still registered in order to return early in case the device_del() in
> thermal_zone_device_unregister() has run already.
> 
> However, after thermal_zone_device_unregister() has been made wait for
> all of the zone-related activity to complete before returning, it is
> not necessary to do that any more, because all of the code holding a
> reference to the thermal zone device object will be waited for even if
> it does not do anything special to enforce this.
> 
> Accordingly, drop all of the device_is_registered() checks that are now
> redundant and get rid of the zone locking that is not necessary any more
> after dropping them.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


