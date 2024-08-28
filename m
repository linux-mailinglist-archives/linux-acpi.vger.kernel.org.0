Return-Path: <linux-acpi+bounces-7934-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6218A962EB2
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 19:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8660D1C21E99
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A7A1A7043;
	Wed, 28 Aug 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqXzXjPH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBB36130;
	Wed, 28 Aug 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866861; cv=none; b=P/zOlC2pmOFV5OBmi8VH3lnyVjGorpNX5w5LPJL74f6PDuIFVY3sLbZVj7zkM+SQPD6RIIEDSCfeIoTRMdpHp/k/la17w+f12X22Or/mWcbzd+iBNwZ51yAuQ78tSXDQRb+0Dldo29/GCU2bLCFChwOGCZm+z+lJnrbythPGnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866861; c=relaxed/simple;
	bh=gbtXHJq+mAHq+lCKykPrcJKzlc6UtbaslicjWljJIv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zs/e4zwF8nNpj6Q7cL0MHtHszSRB/GOPJYDdIwC/1IsX5OksQDNUX/YimVs+OoVvrdEDrXrtLyU/CR79S5/lVdpQIBNYUHnzBHKP0Bz+TpNJSiyEGa0/Kc5PtCWBkrAO03MZgf6RMJTHQT/hiRhrRPW7KJ4CYacladqYHEdlfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqXzXjPH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso61683725e9.1;
        Wed, 28 Aug 2024 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724866858; x=1725471658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=An0Vk1+fcXlBnERTT4Ns65sUJzJJDn81eBsrPMRL5tQ=;
        b=HqXzXjPHZEhSPeo45ilkW0gkhxz5Qx5SlZNed4nPYVsHT54Dh0vfMUd9auQ9pKVizc
         zlpbE4CdBdD50LAdTIQ7Jlw3n+q2qP1/fYNJ3Uv9DCKc3fUVAqEOdg9UXL1A8VFNPrLT
         w0pl3G1oKvUr5NvzCf5m5gSiOgwZwA/JEHrPn7xlfgYM/vg5tGJvnKhS2mOQSwg/9GX5
         f/HoK1fyVKX1N7HY0ZpokKqwwowVRz4NfJ3+Musxq/RZhH/cwy7UrnRfc4rBmc8mc3TA
         em1Su8c1BcXiFoEdiBCdPTzi4E96/McHtXFdfYqL04n7wOb9ZuGS2wNWcwYPSNElRejY
         50dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724866858; x=1725471658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=An0Vk1+fcXlBnERTT4Ns65sUJzJJDn81eBsrPMRL5tQ=;
        b=gUHrNkswXItlqjY5uL8t97PjSzd3/utxYFETnwKqqZbiVRcJfby6UJ990OQrDibEq4
         HDiSWXWwoch5dM/fnXxrCa/Nq4PU57vt2M6Gw1snYUIZFjQ4cOv02ADfvyYoFrUkLbCL
         YcTirSE9SRvJAaznfq5HbHRWvI6JLe6YAdSb1pIiCkM4iMr1tBhbB2MftxUeLGHGeXX6
         UAxNoI5NcK6nJv3JLu2Lqzpqol03aM0yBN20Ul6Xp9wje8JLTn+dJjnazYWEo63rw95S
         5c517q+Jo/TiutBnEgPImFnrl0SgNe7EDRu+RG+LqpJT2CNIytqZ8lUq2Nm/j55frRSv
         1BLw==
X-Forwarded-Encrypted: i=1; AJvYcCVsUpaE9pc2N8nXTX59fHdbP87iU7yOSUFVXIZ+tZw08inzY0W97ep8equrNLgiAs6E51ybB6DtlzNX4nvg@vger.kernel.org, AJvYcCVugZfiDlLl4UupOVjMQCRM0t7JQR0OdwOp5VS+k/Hlzg9SIE6x9+lrsNEphsSeBtBn+g8I02Re8eB1iqQKm4DKY9PZDg==@vger.kernel.org, AJvYcCWOkaDKh/u4+NwGmnxOEfImKCz46DvawCYotS4AsOFUHZHvG1G5xoQSeZtQ1Aah5Cl7envV2i/R7oOLZA==@vger.kernel.org, AJvYcCWwjp0vk0AZTvQ0dLtvfMlxKfDC+6cIvBfoBNzxvcedyJxuuDGAXayPuXddcDVbrmH+yqdGcgxRoUDcH50+@vger.kernel.org, AJvYcCX39/6DG2QjZd5pXlRZkCzyecsV67oc5lFEA926xdGhNjhWrKZbW2oTf/2v+qGEao7tiCzO3irG1PMn@vger.kernel.org
X-Gm-Message-State: AOJu0YxzmpTI75bC/Pvhnf9oB6FVtyBAh5aY2sbq5MCFUs9D13TOJ4rx
	Y93RacWSqu1MRbY7XjltN1U28nY+wRJBIdhVRzGuajvgXEJ6uX0W
X-Google-Smtp-Source: AGHT+IEMT2J9j0NWA0FQP6JJCnxcc6TeVi0FxecAAgalOduVjWy5jaFjAtjj33iEpx2L92OLR0WBNA==
X-Received: by 2002:a05:600c:310b:b0:427:dac4:d36 with SMTP id 5b1f17b1804b1-42bb02444aamr2508925e9.7.1724866858234;
        Wed, 28 Aug 2024 10:40:58 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb01d3029sm3731855e9.42.2024.08.28.10.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 10:40:57 -0700 (PDT)
Message-ID: <53a56539-1d95-42ac-ad07-1b689702b2ed@gmail.com>
Date: Wed, 28 Aug 2024 19:40:56 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] platform/surface: Add OF support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
 <20240814-topic-sam-v3-3-a84588aad233@quicinc.com>
 <ZszrjQChQ2aS5YjV@surfacebook.localdomain>
 <d08d41ad-edcb-48ad-a848-53edc45ab8eb@gmail.com>
 <CAHp75VcbjR8HQqPASLFEGiyYLfTFQDa6Ri+jFy+7Q1xz7gY39Q@mail.gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAHp75VcbjR8HQqPASLFEGiyYLfTFQDa6Ri+jFy+7Q1xz7gY39Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/28/24 6:56 PM, Andy Shevchenko wrote:
> On Wed, Aug 28, 2024 at 12:10 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> 
>> I thought I should provide some context:
> 
> Thank you, my reply below.
> 
>> Am 26/08/2024 um 22:54 schrieb Andy Shevchenko:
>>> Wed, Aug 14, 2024 at 12:27:27PM +0200, Konrad Dybcio kirjoitti:
>>>> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
> 
> [...]
> 
>>>>       nodes = (const struct software_node **)acpi_device_get_match_data(&pdev->dev);
>>>
>>> Hmm... Why this doesn't use simple device_get_match_data()?
>>>
>>>> -    if (!nodes)
>>>> -            return -ENODEV;
>>>> +    if (!nodes) {
>>>> +            fdt_root = of_find_node_by_path("/");
>>>> +            if (!fdt_root)
>>>> +                    return -ENODEV;
>>>> +
>>>> +            match = of_match_node(ssam_platform_hub_of_match, fdt_root);
>>>> +            of_node_put(fdt_root);
>>>> +            if (!match)
>>>> +                    return -ENODEV;
>>>> +
>>>> +            nodes = (const struct software_node **)match->data;
>>>
>>> This is quite strange! Where are they being defined?
>>
>> Essentially, this whole module is a giant workaround because there
>> doesn't seem to be a way to auto-discover which functions or subdevices
>> the EC actually supports. So this module builds a registry of software
>> nodes and matches against a Surface-model-specific ACPI ID (in ACPI
>> mode). Based on that ID, we retrieve the tree of software nodes that
>> define the EC subdevices and register them using a (virtual) platform
>> hub device.
>>
>> The snippet way above registers the platform hub device for DT,
>> because there we don't have an equivalent ACPI device that we can
>> use. The code here retrieves the respective nodes.
> 
> Yes, and software nodes for DT are quite strange things! Why can't you
> simply fix the DT to begin with?

For the ARM/DT variants we could do that. But we still have to deal with
the x86/ACPI ones here. So for me it makes more sense to have it unified
and just deal with everything in this module.

Also, if we consider that at some point we might get ACPI PEP support (I
know, far fetched right now): With that, ACPI on ARM might be feasible
and then we'd have to manage the same thing in two places...

And lastly, the EC subdevices are quite contained and I don't see them
interacting with any other components in the DT, so it's more of a
stylistic choice where to put them.

>>>> +            if (!nodes)
>>>> +                    return -ENODEV;
>>>> +    }
> 
> ...
> 
>>>> +MODULE_ALIAS("platform:surface_aggregator_platform_hub");
>>>
>>> Can it be platfrom device ID table instead? But do you really need it?
>>>
>>
>> I think the explanation above already kind of answers this, but the
>> module is named differently than the driver (so that they reflect the
>> specific nature of each, registry vs hub device). And the platform hub
>> device added in the snippet I left above is named after the driver. So
>> for the registry module to load when the platform hub driver is
>> requested, it is needed.
> 
> So, I believe it warrants a platform device ID table to make it explicit.

Yes, that makes sense. (I was not arguing against that, just wanted to
explain why we need the match at all.)

Best regards,
Max

