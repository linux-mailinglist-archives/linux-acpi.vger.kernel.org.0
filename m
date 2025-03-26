Return-Path: <linux-acpi+bounces-12432-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6997DA71807
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 15:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577E016FE26
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 14:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29DE1B0435;
	Wed, 26 Mar 2025 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJVLJ0Md"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371A314A09C;
	Wed, 26 Mar 2025 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997745; cv=none; b=N3KnnQpFnli2YXX/1I/VhISDsXvzjOwAXTNU0jRTWFzv+PBDW7kRicpD3GYjCrylISgbVJck3D35aMbHVFCi1wtUwRW41i6fpVKn7fgDtHPmFXdmh885q0m/j84oq5+o3MHeFjIKa4Y+dmZLnAjwb3YFlk6VZQXP12rWwg10xkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997745; c=relaxed/simple;
	bh=rLEliCf3UoNKRw3bhcnFCVsLu17piM66/Kf7LWsn94k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHWfic4DXkuTPkEgkbFo6RvXgGfMxM23fBdw2Vp8O29p1JcEYMhbaPDDASPsLHP8HHDIb6Sq42hUi7ci6V6yzCP0jb1zEOcf34Vlk0c82RAz/FnggjW9BRUFEozyTDnuuH37/GS4JRo79D9czRm/h3XGSi2KpaItWtDtagcCHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJVLJ0Md; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fb0f619dso139598885ad.1;
        Wed, 26 Mar 2025 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742997743; x=1743602543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LtfkNbhavg1rWc7Eqt04TBE6Sf4QfZ1CihUPZWQbiNE=;
        b=dJVLJ0Mdt5XI1YET4eEDzPNHrj84za+GaZeYngqZNJLjld5oyXDyBb7hpi2b/b7QM0
         iNI2IzuSwzZjHXC3AX+rSdHUxBXbPs8CAC6edHbDiTICiucNYPfWf6l8e4SB00RZ+mrP
         Gfhwn1TFdHbGESAeDDZnPzgs31Ve2yvmR6mJpRiBTYFNFDeU9AmxpQtQWyp359BhxjR9
         mnWa48HE63EhrzEl95pcJcTIYhJGglwKuTq3liyADywBqg7YrbtDcMVT78xFYsQ0QTun
         M3aTss7jmAkIg6aNgrv6LqUv32ondK93IU6m1bw+k/AYfTvUe762W+pwPENI+cu2Dqnd
         tcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997743; x=1743602543;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtfkNbhavg1rWc7Eqt04TBE6Sf4QfZ1CihUPZWQbiNE=;
        b=LRdT3gk9oCJWQaQKXF6+QnVF1MgWC7MKVlAxIQuuIw/0VnscK31JIAVfmrgHSJ6T4r
         TIQ+LBaKeRlWBMQNH66pFDKWpUT1uTRZRQ76svjOA+Wr0Q0+W5I+c1P1N32GbgESyfA8
         UA5SwZY5eN3I0LFlHSsaAYg6vtos5Bl801wGUi7+MARMyEWpTKKkdDb79QIgMLEwmje3
         0IXkytBHW+OatbgnV3oQ2MZSgIkUiFeEl+KSIpfu21Piov0kd7oZo7Z+/5tWs0dpXbHo
         uq4sogdoM+3qsjuzWDNrm9SHQwTRCHHXFcx8Oxirsx9PrGANiZ3oo5jU8TW/NJqzC+SC
         Nt9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4LfLyRXPpAQoeJvxQAU6qUb8tth53KAz4scS4fj3ACRbVcGgO9dGdfhszEiS7paLSn9WvRaAmMcsjjLsz@vger.kernel.org, AJvYcCVjkeCbLUnw4EydnW2Obpz+6Q5iop/MvCzQLuHEiU7XnYciTFLmU2NfkJHYjmNqHbdH2e80gb0pK8hKeOLAeOU=@vger.kernel.org, AJvYcCVtIqZXxMjPpByyL7KbcmcK/00q2bQgDQvHuTwvNbQhdFeMKnG7R8bbIru47TfrFV1IyGqFnxT9rFJC@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7GsrBRvPSSYTqzKOV1VYDJu5/DY8myfL36at71C6lGqqwC19
	3m+DKCtl2sfxUQYximrNQNPLq3CF67MdSbYC1GjddmKNC1P6WBzE
X-Gm-Gg: ASbGncvpyox9+xNUDbfJKUMhqYgnxj6m98165xpWNBi9KylqCy/uW/qPiEDnaaVHETH
	0W6IGWUTYYAML6G071Kas+UHpPT2zOK93rWtG12HyqPqDtG7Z8vAY90KL06E4bOdgRy6HH1eZeQ
	Vv4cTX95jrJP9p4ZRq/lpCgxyxL0JvaVU2XtBl9KPWlTkqE2hDiP08K6LzivArCGJtlakP1uHt9
	+nnglzKPYF40nfRgAgQx+yeNphODdNzVXGUnzVzQ/OPg55vP+A6j0mkEeaOsSAK3ENOmXtolarC
	REkcYSUuGm2eXkR6F75th6vmUAUT51rmI/KxfrxAkmrvSrXF5RyYhUUP5bLR6BSzIHJH3Sp154L
	sd/Qi7eTC7OJ/JPXZNw==
X-Google-Smtp-Source: AGHT+IGFnv6QfkelFAzb2LcGXDlP4HTrJFjgvnFepmRe/Y1eFAkIt3hMwFZdpxLi9Y8NZu0oAF5h/A==
X-Received: by 2002:a05:6a00:14cc:b0:736:6ecd:8e32 with SMTP id d2e1a72fcca58-73905a23927mr31336614b3a.21.1742997743160;
        Wed, 26 Mar 2025 07:02:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600bbdbsm12195408b3a.80.2025.03.26.07.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 07:02:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9f4e560e-35c1-413f-be83-d537abf41183@roeck-us.net>
Date: Wed, 26 Mar 2025 07:02:21 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP
 device list
To: Diogo Ivo <diogo.ivo@siemens.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com,
 benedikt.niedermayr@siemens.com
References: <20250317-ivo-intel_oc_wdt-v3-0-32c396f4eefd@siemens.com>
 <20250317-ivo-intel_oc_wdt-v3-2-32c396f4eefd@siemens.com>
 <1beeb77c-83d6-4634-ba39-2b40efbb8437@siemens.com>
 <CAJZ5v0jh1jJy+YRMtLDnYqAhPrN2Pox+NY0Vqh_uqb7F=NwqEg@mail.gmail.com>
 <54d3c7a8-1392-4870-9bd6-48aebe3881f1@siemens.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <54d3c7a8-1392-4870-9bd6-48aebe3881f1@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/26/25 02:01, Diogo Ivo wrote:
> On 3/25/25 6:59 PM, Rafael J. Wysocki wrote:
>> On Tue, Mar 25, 2025 at 6:19 PM Diogo Ivo <diogo.ivo@siemens.com> wrote:
>>>
>>> Hello,
>>>
>>> On 3/17/25 10:55 AM, Diogo Ivo wrote:
>>>> Intel Over-Clocking Watchdogs are described in ACPI tables by both the
>>>> generic PNP0C02 _CID and their ACPI _HID. The presence of the _CID then
>>>> causes the PNP scan handler to attach to the watchdog, preventing the
>>>> actual watchdog driver from binding. Address this by adding the ACPI
>>>> _HIDs to the list of non-PNP devices, so that the PNP scan handler is
>>>> bypassed.
>>>>
>>>> Note that these watchdogs can be described by multiple _HIDs for what
>>>> seems to be identical hardware. This commit is not a complete list of
>>>> all the possible watchdog ACPI _HIDs.
>>>>
>>>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>>>> ---
>>>> v2->v3:
>>>>    - Reword the commit message to clarify purpose of patch
>>>> ---
>>>> ---
>>>>    drivers/acpi/acpi_pnp.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
>>>> index 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5d579e32963a5b29d2587 100644
>>>> --- a/drivers/acpi/acpi_pnp.c
>>>> +++ b/drivers/acpi/acpi_pnp.c
>>>> @@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, const struct acpi_device_id **matc
>>>>     * device represented by it.
>>>>     */
>>>>    static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
>>>> +     {"INT3F0D"},
>>>>        {"INTC1080"},
>>>>        {"INTC1081"},
>>>> +     {"INTC1099"},
>>>>        {""},
>>>>    };
>>>>
>>>>
>>>
>>> Gentle ping on this patch.
>>
>> Do you want me to pick it up or do you want to route it through a
>> different tree?
> 
> Unless the watchdog maintainers have any objections it's fine if you
> pick it up.
> 

Ok with me.

Guenter



