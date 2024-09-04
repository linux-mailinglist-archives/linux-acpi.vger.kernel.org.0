Return-Path: <linux-acpi+bounces-8157-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7274996C7B7
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 21:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E201F26569
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 19:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67EE1E8B68;
	Wed,  4 Sep 2024 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imk5S1Da"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F721E767E;
	Wed,  4 Sep 2024 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478840; cv=none; b=UaYG8SL5lb1pXrBF0R/KpQB8HgQbEE6bw8ah62tu1F+zsseYzRssBABpw711bV962gD66ma+h/A3l28lzSVZuYgFv9yET0nr1mT0lhGEpJ322iLgVRbzdy2izKXI4T0gSjPYIBW+nY0OyEdxOwXiSxzLtbvpT2qeuvOPsvaBCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478840; c=relaxed/simple;
	bh=cYwzTz9GsiU/4PBHM5XIMAa9OeOLvkWUEfxxR0zWAaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ih8bRi5f68phQ9jipm634BsBOY1//HSigHKm61nzhJR7GwCxQd/MCs6nzBrYxASjOeuPcxL/YZUv8i9eWDJeyLlWuRgXJYgPdp1Fq8YKN3TFDvSzAieiE9yUaLzVHtbBlZNs51kEYUlJ48qFeG3gNQEe3sRAMJfTx8hbX1p47kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Imk5S1Da; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2059204f448so120495ad.0;
        Wed, 04 Sep 2024 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725478838; x=1726083638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp/2jcYweIzZoEi4LKaVA1NnGtCZQqq4uWclBscNyBM=;
        b=Imk5S1DaczYyRJJAT3JeNpBvWYUQG6HyRWuiOE9gwiRSyaIjBKuMwhO6XXuccAbvWp
         U9E4VnkJQHzc6JgA1XlZ7z1xwHJXDGrNJa3HP0akTvFO4opprLh9oMzgKjLWhlQR0YRN
         AC7JWEKv3KjFAKjxqzoMSQkKJuIh1J3l0+D9cJp30KrM3ilWlgOc068bV6hJhmfw7/nP
         JgORh+ZSVpZx7sdpI/BNISomrF1+IUty2HeCunaUv5E7LqphbqYoxjJpDKCdGuqD21yw
         /9rq+DsTOEm2SM64tL4SwPtj/bfXalAOY90h4y+z5tpDkC16RxQMt+cG6Z4ICuv0QvL+
         yO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725478838; x=1726083638;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp/2jcYweIzZoEi4LKaVA1NnGtCZQqq4uWclBscNyBM=;
        b=QSM8ZrYYP4L6anziVKLRfwanCgk7ZQGknsDmw3yyTtf9KOy0pFdp0m1gqz+ekdLTCr
         pHUpWsQDT6+VTbMpatwcQGvQi57mfC3cxAGdBelBM49JS/yOUxsKmuMKiYyPBQVAu/jL
         TuKf+kBW/vK71DSYAVQJTBkaAO+7rZhL7uQAyFf/Oj2LHpgw4k5smIVk7/06mS70IJFp
         7cXoLamwAIO3ciHgcmSmx8iWbpniR4YdSdv7ALwQt3e8Seucg4GkvUN9thOzd5MEBXfW
         qfCxcTFSFSy1kH1Kek4mTunfhwIgmrFEypWcQBPkaQTLPgaJp35sdqGblqXnu+HTWuwo
         a9MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfzrVFVqpZwsrihGuEk7A6K0SU2fb9meinNKrinPoZBB+TnnSL9G/ItvmefVOqFUPFmrM4IEcLbG6/ItRd@vger.kernel.org, AJvYcCVgpvUDa2SnY9z6abfSPMCgEkzB5kpfpZnoGa1KRmRw6VWHPw/tgQLh6e3mnfFKdKZQgBIWlgSqmMbxfKo=@vger.kernel.org, AJvYcCXWjtXWM1gBgWytYCnkkC6BVU2wK/IsUraOtE4XCV2OxJbaColHoovFFyRHOMa/mxte5RjnJj8XyBclZK5JECe2uJiZEQ==@vger.kernel.org, AJvYcCXpyaEVan4JK4ldXk2aWajKF5Uz3Xva441SZcx8YY/46I1ZQfv/CwXGgYdaC33bSiTfVeHBFxA3Y9zd@vger.kernel.org
X-Gm-Message-State: AOJu0YzzIHbUcubbWfz4VquMNnfze58P0Io2UcpPgEXfqN2fCHHS5zGb
	qayyam6sh3Om8ucYCVeMb5JUDI/0HVDAKnK7UjLDFXJMpRUj3vmR
X-Google-Smtp-Source: AGHT+IFgGoKOCtNS7FtR2+3Po3nWCzaa8qhDsnsGR4hwwylfAVbbDt5oqcr0HC3nEew2Cg0JRI/Qkw==
X-Received: by 2002:a17:902:f605:b0:202:5af:47fc with SMTP id d9443c01a7336-206c7922d55mr23433335ad.13.1725478838380;
        Wed, 04 Sep 2024 12:40:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae912357sm17024565ad.14.2024.09.04.12.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 12:40:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9c3139bf-b18f-4801-852e-08ac98611b1b@roeck-us.net>
Date: Wed, 4 Sep 2024 12:40:35 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] hwmon: (hp-wmi-sensors) Check if WMI event data
 exists
To: Hans de Goede <hdegoede@redhat.com>, Armin Wolf <W_Armin@gmx.de>
Cc: james@equiv.tech, jlee@suse.com, corentin.chary@gmail.com,
 luke@ljones.dev, matan@svgalib.org, coproscefalo@gmail.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com, rafael@kernel.org,
 lenb@kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240901031055.3030-1-W_Armin@gmx.de>
 <20240901031055.3030-2-W_Armin@gmx.de>
 <e90b40e9-b3a5-4228-8f12-b02a77b7789d@roeck-us.net>
 <bf7910d7-395a-4d01-960e-46789d836da4@redhat.com>
 <6f900fd9-f850-44a3-9409-18889add2cf3@roeck-us.net>
 <ea8adf37-9fe2-4a15-9666-e164c192bedb@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ea8adf37-9fe2-4a15-9666-e164c192bedb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/24 11:42, Hans de Goede wrote:
> Hi Guenter,
> 
> On 9/4/24 8:38 PM, Guenter Roeck wrote:
>> On 9/4/24 10:55, Hans de Goede wrote:
>>> Hi All,
>>>
>>> On 9/2/24 4:28 PM, Guenter Roeck wrote:
>>>> On Sun, Sep 01, 2024 at 05:10:51AM +0200, Armin Wolf wrote:
>>>>> The BIOS can choose to return no event data in response to a
>>>>> WMI event, so the ACPI object passed to the WMI notify handler
>>>>> can be NULL.
>>>>>
>>>>> Check for such a situation and ignore the event in such a case.
>>>>>
>>>>> Fixes: 23902f98f8d4 ("hwmon: add HP WMI Sensors driver")
>>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>>
>>>> Applied.
>>>
>>> Thank you.
>>>
>>> Unfortunately patch 2/5 touches the same part of the file,
>>> so I cannot apply the rest of the series without first
>>> bringing this patch into platform-drivers-x86/for-next .
>>>
>>> Guenter, can you provide an immutable branch/tag with
>>> this patch on it; or drop this patch that I merge
>>> the entire series through platform-drivers-x86/for-next ?
>>>
>>
>> Can you wait a couple of days ? Since this is a bug fix, I had
>> planned to send a pull request either later today or; with that,
>> the patch would be upstream.
> 
> Yes I can wait a couple of days, thank you.
> 

I sent a pull request, and the patch is already upstream.

Guenter



