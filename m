Return-Path: <linux-acpi+bounces-2291-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4398E80D3F0
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 18:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3256282048
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2660B4E616;
	Mon, 11 Dec 2023 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q99BuM+Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC10DFF
	for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 09:34:59 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3334254cfa3so2665114f8f.1
        for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 09:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702316098; x=1702920898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gstntUJJhuUruQ6CLNsepakisEqtUTeEbOuI9lM82/A=;
        b=q99BuM+YhGN4lKfpf3MGaomsJifhCbtczimCixr3f6qWNcTug2KRXhqiZgm4qKk1pm
         D6lUOVIyjQYDL6chdWBNsYypi1PRs41p/26LtIeR5zqa3l2xEIDRyoU9HgPOVaptvyt6
         +e73dW48t7eyConI/pXcdcm7VnxO3L+/liSPNb/o6pAVJqL/g21LEoo306UgBn+CsKB0
         58wxMYb4PxUH1s690OLgIbo7UVquXJ+uj38Fk6gGJrxJlrR05MXMlSlNnv1uipwC2KF4
         aY5/FbIfRoXOvbHfkZFzdWX11P3R7eNDVO5z4QcvciMilv5E+yuJ0Tv7fgllNi9gzL0i
         mYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316098; x=1702920898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gstntUJJhuUruQ6CLNsepakisEqtUTeEbOuI9lM82/A=;
        b=qQ86kMkCrbs3bP3YmMVHPe2orgFfKNeM8t9LnaUrG1zwOdJA7fwbcwpwNzjhsXCV+v
         JUcspxzXJ+9cROVJ5Z7q5fv35hjl+TlSe0mK5DqKNj8y6BxcFqjCqorFBaUFFzmuhWtz
         D3iBxttts43m7+SVd6jpYT4rUWmc7tKU+RKsSuiiFY1KNfHozFe3ALckJci1wTLEooOc
         d2RxgirdnWxdrLCWzf1gh0117WfVwthOf8jBmXxI4qbFVvLIDA0sTVRTgitebs20Y0iZ
         +dkLTXrZimjQ4/ZafiKNiLSmNVyCfYHIk2w3Tz1bf7g3YjkxhT7ESjNmp6Dq+a0Z+dJI
         P5Nw==
X-Gm-Message-State: AOJu0Yx7q/yo6oR4qKAZK5nbX2y7NsB6JgSSHgzD40wHxaTbbqsJ7+KU
	j7IX1+hrnXKgPZr1mwZFIRggGA==
X-Google-Smtp-Source: AGHT+IE1Y4VjQWuMP84YdtKDSoXd37/lYS2QFZAq/+DEf2E0klWmPSB2zntnCZYi2oLFGBPADo4Fqg==
X-Received: by 2002:a5d:4712:0:b0:332:f501:8b56 with SMTP id y18-20020a5d4712000000b00332f5018b56mr2572878wrq.23.1702316098228;
        Mon, 11 Dec 2023 09:34:58 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id g3-20020adff403000000b003335ddce799sm9046899wro.103.2023.12.11.09.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 09:34:57 -0800 (PST)
Message-ID: <535558f8-096b-4917-92d2-b0defed42b15@linaro.org>
Date: Mon, 11 Dec 2023 18:34:57 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] thermal: core: Make
 thermal_zone_device_unregister() return after freeing the zone
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1880915.tdWV9SEqCh@kreacher> <13414639.uLZWGnKmhe@kreacher>
 <0a0d5dd4-6b7a-428b-8ef1-bb6aff76fb51@linaro.org>
 <CAJZ5v0jebeWzUb-q-_xThRwZgUzaUfqS4YTGmsvbsOPrqFcYTQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jebeWzUb-q-_xThRwZgUzaUfqS4YTGmsvbsOPrqFcYTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/2023 17:42, Rafael J. Wysocki wrote:
> On Mon, Dec 11, 2023 at 5:28 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 08/12/2023 20:13, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Make thermal_zone_device_unregister() wait until all of the references
>>> to the given thermal zone object have been dropped and free it before
>>> returning.
>>>
>>> This guarantees that when thermal_zone_device_unregister() returns,
>>> there is no leftover activity regarding the thermal zone in question
>>> which is required by some of its callers (for instance, modular driver
>>> code that wants to know when it is safe to let the module go away).
>>>
>>> Subsequently, this will allow some confusing device_is_registered()
>>> checks to be dropped from the thermal sysfs and core code.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>
>> Definitively agree on the change
>>
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Thanks!
> 
>> Would it make sense to use kref_get/put ?
> 
> Why and where?

Well it is a general question. Usually this kind of removal is tied with 
a refcount

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


