Return-Path: <linux-acpi+bounces-8155-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A8896C68D
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7331C225B0
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 18:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3101E1A34;
	Wed,  4 Sep 2024 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxAKbpBa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648701E1A3D;
	Wed,  4 Sep 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475133; cv=none; b=JEapSMLq3votpkJP8LPnMetrei9FU31O/eIgIbOP2+6Dup0zHYZMVUFf392ZtPUtZLtLWPXBP55Dd/snMefJg64L4GufQ6pIKcn9k8kDMR72w30ueiTBJsPXowQVChx8tYKVxhqMy+92K2yiOhmTN7TDgCGLKNdz/7Y2wSJnBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475133; c=relaxed/simple;
	bh=qg4NUsEOPpCCwOtefQbcTH0RSELJyVlG5zTVjNbGmss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8drInjBp5JTer5xaYHQl5MfzwWAkJsQMU22Q/jxQwznf9cRKk8z3+ucwB1bisJOtIJJrBLXcDsTsjn6726/mDaHaM1+fy/e0ynBWtWiyq2m4Cr9vP/cFGUSsEItkO+6ITfw31TG++HR/0VSNxDNpjn9VXhVqGy5jfyFIHATqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxAKbpBa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-715cdc7a153so899834b3a.0;
        Wed, 04 Sep 2024 11:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725475131; x=1726079931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KpiXXcb1muj3hQuJu0kR9lU0hmn7QWT878x1F5SeS6c=;
        b=HxAKbpBaewxLH+/25ludyUKcMR7aE8/iplh+nmKWyE3G2NRv4erAk4OgjKJFBP8VEm
         Hf42OEmHy7daGVsANJV6BiiroLxQk6VrayOWHF4pGvTqORqyVNW0gQgtNPL16TiAzbyg
         wtMo5sw8kuR9NQfwa7SDYC/fJltIHrVZRyuP0h5a64B662yP5+uP6shjZefn0yMuzeip
         K0FnkxV47687Qpqdud3bxD8w0NwSGGrz+O48vQhgFLatdHVbUghwPdxRACEUcgO2ZGhn
         jisheDoVnyAYEwzVXJxmCgT0LKN3L3lYyItlbUXldLCOkYVYkonqZzsth9VOQyVvYDxd
         +aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725475131; x=1726079931;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpiXXcb1muj3hQuJu0kR9lU0hmn7QWT878x1F5SeS6c=;
        b=di7yghHj1fCgACaP/0EVxOQjN99tzYXiLTeuB+np1NbTWqlGUdNShWeTXYME3Pxtq2
         TrTKs62h+h+BgP0AoL6Bi3NzK2Y16dcBMNoxerXH2oSrQ+7/P5Z0x58nFE2xIYXKUzZG
         l3aSw48i3GMEzlKZnaeCqnYUQHclz1dJ8U5u0LPVeDJgwiQc+BBKYipD6X9HGTB773u/
         4ERFKeDtvf7bmZ3hk/WZwPXbpNP7LsO+6wW6VFe4XzpPUc9UNJdI/mgQYc9OMOAfoGsz
         AzUtOMFblbplhYsSrmJil9Bbj7BSocJZoJryRbkUgRepQ4ZWlQeTWs1FCQX3HA0oFG17
         7nHg==
X-Forwarded-Encrypted: i=1; AJvYcCVX0ZXWy/1tiHXlM4eDHmJacfdhlmD8QItvXzpqX5Un+Mblv51btcZypcNjIP+l886ZVtJRV/XlPP2DDg3X@vger.kernel.org, AJvYcCVpXqMzpVqGBnduw5kbY7OHIoOHynrkFVyDE03dur8Jk+8819gDQx+BWKfkCGIqRY0ajgLnNqJkCurz@vger.kernel.org, AJvYcCXrhryEvDmH+XTgzN/4PUviz1DWYQJiz0lRDeB8Z8Rgiy6gJKxx8XPWoKIUZCXCPhCpxlOuW03MK/GEJ9g=@vger.kernel.org, AJvYcCXv3RD++/XHaDw+dPxkzP0RkXqgkTKNyHJcXZz75wWVzflMKlCxGSqTiVMjFhNUk5U2IY4kQ+dFxecPTFcGDpBw4DRHbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgV00HxSK/XCUDx1ZiJ8uUWc8+Y3wQjyviHc8YYVIATBrSDNT8
	4SuRFmbWnM+LcWqMyp8Cblx7LqqZAeYFf6EDcReixtcLh84N+rSQFSyRKg==
X-Google-Smtp-Source: AGHT+IGw3RJiWeQ8vFJ+QKsWYpJQS+Ea5RiO6rI1QuasU9FBub3OHP+GV//dd+vhO6ca4geviesJOg==
X-Received: by 2002:aa7:88d5:0:b0:70d:2a1b:422c with SMTP id d2e1a72fcca58-7177a943322mr5219922b3a.7.1725475130506;
        Wed, 04 Sep 2024 11:38:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778536fd2sm1934787b3a.88.2024.09.04.11.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:38:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6f900fd9-f850-44a3-9409-18889add2cf3@roeck-us.net>
Date: Wed, 4 Sep 2024 11:38:47 -0700
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <bf7910d7-395a-4d01-960e-46789d836da4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/24 10:55, Hans de Goede wrote:
> Hi All,
> 
> On 9/2/24 4:28 PM, Guenter Roeck wrote:
>> On Sun, Sep 01, 2024 at 05:10:51AM +0200, Armin Wolf wrote:
>>> The BIOS can choose to return no event data in response to a
>>> WMI event, so the ACPI object passed to the WMI notify handler
>>> can be NULL.
>>>
>>> Check for such a situation and ignore the event in such a case.
>>>
>>> Fixes: 23902f98f8d4 ("hwmon: add HP WMI Sensors driver")
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>
>> Applied.
> 
> Thank you.
> 
> Unfortunately patch 2/5 touches the same part of the file,
> so I cannot apply the rest of the series without first
> bringing this patch into platform-drivers-x86/for-next .
> 
> Guenter, can you provide an immutable branch/tag with
> this patch on it; or drop this patch that I merge
> the entire series through platform-drivers-x86/for-next ?
> 

Can you wait a couple of days ? Since this is a bug fix, I had
planned to send a pull request either later today or; with that,
the patch would be upstream.

Guenter


