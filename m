Return-Path: <linux-acpi+bounces-7553-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B57395077C
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 16:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DD81C21AE8
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1290A19D085;
	Tue, 13 Aug 2024 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTdoy3Wj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84B19D07B;
	Tue, 13 Aug 2024 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559241; cv=none; b=oGvxgeH1uVcUtO+9Aoa0b5GyEp2NiCJSckRdBgRSb2nfGbFbg3P8N/NJEjjgzTMECeg3Eqkqmyy8PpE+QutCnkC+UDmvY3aBCgGsIkdXKpe7ZzmX8c6nyjVKeMzbvwE6JAg3UigjVYEO2hTa80HS9Q2NdA+uvksywgkpU+KYoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559241; c=relaxed/simple;
	bh=7o1ebO6uvNnNS0M2BIyB8SB8taid1I1qAAMAb2zKqbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cc5qfHO2Fh8rNJPNWZwtHWYoMR0QzUEwz+tRLgkZj9XprCo2nsdUIW4fnOURx+Lox2vI8QTQiPNmkkOxrOiei6ag23a+wELxRGituPzByEfFqBSMvQc8WnYA1d99uHzv7McdvOs5v/DllPFxN0caGYVe61jJgfnDh/RwYVpl1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTdoy3Wj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso7356739a12.1;
        Tue, 13 Aug 2024 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723559237; x=1724164037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0GZ9q735651QGDZf7rgdlCrHxFSRCY3h/YKc3A79Cc0=;
        b=VTdoy3WjCzQiiS5Ec7e9NVoKcUQq36ZGjs11b11P3msZmfgc45fYJXth5aYQ/kc3uv
         HPnw/aM34r77ZM+0jUajQOb7UyU4UfT/eiKRd0D9CILV+CEC9YsIFB4W5fzFH8mzRZfY
         YOLLtarvrjmFi/9PuwxqVU1f9CCbUsNMiCWx2wyRw9LtEBGxS45/Pu8HO6H1kwPnJ8YS
         PL8hGjhwAaGETH9NuzO4j4mz+pvlPjpl6nZbkTybzvbOKBPWhvJae5Ee4tbm/KILAv5/
         xRK3q09kE8zd/riXtJ0X8Ueca9WcjsOaHbooTMAxAjStsOaITISU4sfuhdCOFciHN6/9
         ds2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559237; x=1724164037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GZ9q735651QGDZf7rgdlCrHxFSRCY3h/YKc3A79Cc0=;
        b=g64BEn9uM2HHqzmSUf1MkD2xQ5E43E8SP3m7WqcfFiXjWIcGLllQY48rGWRjpYP1kC
         qHAhwNk7C7IqDp7SxZkbGgBbA/ssmdLeCbepAQckm7DWITxNaI2519C7t8XBam2TV0Nr
         zRgNzB1KkU1Hczid/cawSu4Nyzx7V+jpbVKdWjC4IbwQ+UMYyl1QUb+aRWPfrH0kgZiy
         wJCQ90yvvq/ZZfTdqimPuA0LYB9r0eDIYg4PHm+VfsS/owf0TtVjFZtWjI//SUlJlZSl
         7PzqrGtjVvC1r7LK3qKHowAKXGHll1TWgbc3ujib76OW8NLZzu9gcpPL1cJRDQSVd/8m
         APYw==
X-Forwarded-Encrypted: i=1; AJvYcCUd2ef4iqyHIzEIdNQcpyFWwXKNBHo03LNPd2FnVyeRSIGiTpfeRijwOaMhocn10ksARhzRJy+n0exTOatWB4bR2MM4tn2cZ7w2sfNLuzpOGwQKIT8fWgD2atVT4Ai0tBqTakk1H3jGWwkd0ryOLSklSr9wEpUSXOuaCKsc58RX95DyW5CE2ea+XznRRvbZ2PXDvGhf5NoqSPB+7OzFA1SXatzxAUof0VuPTh4yEcPDJsdJYkZxMDo5tX48mftxVnC+ROwoIifU
X-Gm-Message-State: AOJu0YxwAR0WppjZBmFoQozxWqdDdtpcECDVp5j9oKUjAQHpmRfEsGJl
	kTfHVUmUhBvCHfMzv4pa5+bB19cdYXbZo6iP+zTGDHBgKme5jEJC
X-Google-Smtp-Source: AGHT+IH6Tmd1OzGRfql2ZCp766sYz9QoQGSXIi39HApJlkOewrKUyajyK555rObaG/0QcWQbujM/0w==
X-Received: by 2002:a05:6402:848:b0:5a7:448b:4434 with SMTP id 4fb4d7f45d1cf-5bd44c2d6f3mr2725779a12.9.1723559236558;
        Tue, 13 Aug 2024 07:27:16 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd196a666fsm2954540a12.46.2024.08.13.07.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 07:27:15 -0700 (PDT)
Message-ID: <36b0ee66-3af3-40c1-86b6-b52cd826298e@gmail.com>
Date: Tue, 13 Aug 2024 16:27:12 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: platform: Add Surface System
 Aggregator Module
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>
References: <20240810-topic-sam-v2-0-8a8eb368a4f0@quicinc.com>
 <20240810-topic-sam-v2-2-8a8eb368a4f0@quicinc.com>
 <1a6ebc27-95ca-4f56-9971-b2a8d03f270a@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <1a6ebc27-95ca-4f56-9971-b2a8d03f270a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.08.2024 4:28 PM, Krzysztof Kozlowski wrote:
> On 10/08/2024 03:28, Konrad Dybcio wrote:
>> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
>>
>> Add bindings for the Surface System Aggregator Module (SAM/SSAM), the
>> Microsoft Surface-standard Embedded Controller, used on both x86- and
>> Qualcomm-based devices.
>>
>> It provides a plethora of functions, depending on what's wired up to
>> it. That includes but is not limited to: fan control, keyboard/touchpad
>> support, thermal sensors, power control, special buttons, tablet mode.
>>
>> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
>> ---
>>  .../bindings/platform/microsoft,surface-sam.yaml   | 50 ++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml b/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml
>> new file mode 100644
>> index 000000000000..f613738aa31d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/platform/microsoft,surface-sam.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Surface System Aggregator Module (SAM, SSAM)
>> +
>> +maintainers:
>> +  - Konrad Dybcio <konradybcio@kernel.org>
>> +
>> +description: |
> 
> No need for |

Apparently it's necessary because I have a :
> 
>> +  Surface devices use a standardized embedded controller to let the
>> +  operating system interface with various hardware functions. The
>> +  specific functionalities are modeled as subdevices and matched on
>> +  five levels: domain, category, target, instance and function.

                 ^ here

Should I e.g. s/:/-/, or keep the |?

>> +
>> +properties:
>> +  compatible:
>> +    const: microsoft,surface-sam
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  current-speed:
>> +    description: The baudrate in bits per second of the device as it comes
>> +      online, current active speed.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> This should be just "current-speed: true", because the type will be
> brought by serial schema. We should however have some schema with
> peripheral properties for serial devices. I'll come with something.

I suppose I should just include:

https://lore.kernel.org/linux-serial/20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org/

Konrad

