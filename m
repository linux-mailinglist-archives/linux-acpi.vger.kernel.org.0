Return-Path: <linux-acpi+bounces-2681-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2BE822A9D
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 10:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1C01C218BC
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA8718631;
	Wed,  3 Jan 2024 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfSaECK1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96C818AE4
	for <linux-acpi@vger.kernel.org>; Wed,  3 Jan 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3368abe1093so9037987f8f.2
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jan 2024 01:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704275640; x=1704880440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yvwGK/ajNH4j3g/k9LHnvMmnVM5XM7MT9VEa1Y2TxfI=;
        b=zfSaECK1+zrgqAAWWYvPnIM2I6hERxyOYrUlz4KwOwBjKEYTme7KNyFyx1kCdtQf7P
         +1MzSDkCyLAMJNeKVgJ3ZyrUFaU2EXF4ysg5LDVUB3qHsEPx5Q6TxfXkvM0NjbwFtdi2
         CagHs3y6s0S1Ck3oiMG4BL0tHyWquSE8yeqK/kfHl7K+Yl4TeUPpNHFWus30nKFnlqms
         A7Vms/RM1P6j4lkReBIyfzUCD1gSbd2D6xDDgBNhuXFCfvvjWPuKbLHZlEU0fiPS6rpD
         HITO0EPk5gqpDG8iIViMlwqKm9J6vu/wz4tK31rv8NI7HOI93mJRvfcrUpW6WZsK58mR
         TuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275640; x=1704880440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvwGK/ajNH4j3g/k9LHnvMmnVM5XM7MT9VEa1Y2TxfI=;
        b=wQL2k9VWJUjiCvrSyGVYgn1d5xQPbpdBMY8J7aPv93+pmGUcSqZbEfkVD1qlg7eiWq
         MTv273EQDqyZcCme0ibJwIN+jDjzTAtr3nPSqfdnDWMNzPt/NhVVOXByRWVDHHld6m+l
         p18WvdYtVg+nidm7Ce/dZjBkpDXj+nhR4SKpeYCpVXla0rRBwhYF+dXhS20tpqwMISvX
         Qvgndw5ATfZVOajGv1uqpmKlOha9RKysWY8as1lxgoyiYOTxAn7ZbUXMWLp/oZUj7u/d
         rGjM5XVodgEnu0diqgF2+5uJWquCKQLqPYY3jxoix8QFGxIzpN+MCKWSSRie0X9Si7hm
         zXcA==
X-Gm-Message-State: AOJu0YzKYQ/E786ngsHdZLeewhMMESrf2jpA96Y8WqivuIZ0Bs56cF7Y
	RKwfAXxpf+Z0G/QUjXQrGm5bT0KjNPTGUH8OfHCRkqWrKcY=
X-Google-Smtp-Source: AGHT+IETruL/uOb+rdjpVP8lj+qu5BvxT0opC87FWCxIbN6EhcNQUyqHOwG2gvQDb+r8OKezB7Bsqw==
X-Received: by 2002:a05:600c:4d26:b0:40c:50d5:f7ac with SMTP id u38-20020a05600c4d2600b0040c50d5f7acmr9806511wmp.60.1704275639983;
        Wed, 03 Jan 2024 01:53:59 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r8-20020a5d4948000000b003367a5b6b69sm30115767wrs.106.2024.01.03.01.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 01:53:59 -0800 (PST)
Message-ID: <3c9f9a53-958e-4d6c-8fe1-6514f97fe1e0@linaro.org>
Date: Wed, 3 Jan 2024 10:53:58 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] thermal: netlink: Redefine the API and drop unused
 code
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <4556052.LvFx2qVVIh@kreacher>
 <CAJZ5v0hRGKjwDv0VLw550CLfUuNGaVXxmvcpbFhS=PCPqY0n4A@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hRGKjwDv0VLw550CLfUuNGaVXxmvcpbFhS=PCPqY0n4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

On 02/01/2024 14:24, Rafael J. Wysocki wrote:
> On Fri, Dec 15, 2023 at 9:02 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> Hi Everyone,
>>
>> This patch series redefines the thermal netlink API to be somewhat more
>> convenient to use on the caller side and drops some unused code from
>> the thermal netlink library.
>>
>> Please refer to the individual patch changelogs for details.
> 
> No feedback, so this series doesn't appear to be controversial, and I
> would like to get it into 6.8.
> 
> Tentatively queuing it up and please let me know if it is problematic.

I did not have time to review them properly and I'm OoO until next week. 
Is it possible to wait for the next time so I can review them ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


