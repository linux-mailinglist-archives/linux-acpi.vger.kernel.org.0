Return-Path: <linux-acpi+bounces-7563-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5E99518A6
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 12:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0847BB21C1E
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 10:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377541AD9DE;
	Wed, 14 Aug 2024 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYgUyrMF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F048213C684;
	Wed, 14 Aug 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631155; cv=none; b=iPp3cbEh1uClnO8BdlOnizHWXfEyGLkmfajbqGr9DNusk9klxe0obfDFQQiK+zhF9QIc7YR0kmqU3eyb7fjOj1Wpr/gZ02Se8rNZi4vjhB/lKu3Zs9YvN4Rf9V/S5gFuO7BPZHpKIqYE35B+ZiE4xaUtYRZj8pRHQiVNi69fHns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631155; c=relaxed/simple;
	bh=ftCBlPiwD1RZ3eQGns2Dn6jHwhtrQA2YnZh+/ZTI/aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/5KlyDZdFaa5jQWbgpFsYy9z5BYMVDr++OVKAUGGEeJOe304eMSJd0hpMtMtQroRWMaFgJXw2ucevCQnXjX6R/zO6dnk+64TckVDrEN6SbaKWaRM12PjOUphJT2nAEnljDYd1+N/ZVi3mCnvwe793l6Wb9yLYBVMFgLeBekDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYgUyrMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F39C32786;
	Wed, 14 Aug 2024 10:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723631154;
	bh=ftCBlPiwD1RZ3eQGns2Dn6jHwhtrQA2YnZh+/ZTI/aU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NYgUyrMF/3k9Q0BD6O7NqdaZ194K3HGHVfFYpdayYDUM7OeGGseOyTb0fQqtv2A1Q
	 lfwyXW7p+q8hPjfmaRTv9JkrmvFULVGqTSZ6uTbphB53x9w2hIdWjPzPrfgJVgpd28
	 nAsvd0TJsLL0qpo5Z8ZpfA2nH/FTWkZZZFSENVlBmo8aE6uDgSxLQIT9HL2CClkuqz
	 9nzZHrjSLSwPqpDgwocmDFqew7gjejY1HWZvQgsSR5hxBKvG2E+gXPX9B9PSs3pT7v
	 vIEuya56BzbEkspWwA4SFZcLCxadwE4rl5ZtzDKVsW6ITeQQK+DFqynXv1NHodpZBv
	 CiGRJ61xYShSw==
Message-ID: <ca411247-c640-45d7-ab1b-b595da46e6f3@kernel.org>
Date: Wed, 14 Aug 2024 12:25:46 +0200
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
 <36b0ee66-3af3-40c1-86b6-b52cd826298e@gmail.com>
 <13f254ed-68b7-438e-91a8-9d75c9e9f2a7@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <13f254ed-68b7-438e-91a8-9d75c9e9f2a7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.08.2024 8:16 AM, Krzysztof Kozlowski wrote:
> On 13/08/2024 16:27, Konrad Dybcio wrote:
>> On 11.08.2024 4:28 PM, Krzysztof Kozlowski wrote:
>>> On 10/08/2024 03:28, Konrad Dybcio wrote:
>>>> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
>>>>
>>>> Add bindings for the Surface System Aggregator Module (SAM/SSAM), the
>>>> Microsoft Surface-standard Embedded Controller, used on both x86- and
>>>> Qualcomm-based devices.
>>>>
>>>> It provides a plethora of functions, depending on what's wired up to
>>>> it. That includes but is not limited to: fan control, keyboard/touchpad
>>>> support, thermal sensors, power control, special buttons, tablet mode.
>>>>
>>>> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
>>>> ---

[...]

>>>> +  current-speed:
>>>> +    description: The baudrate in bits per second of the device as it comes
>>>> +      online, current active speed.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>
>>> This should be just "current-speed: true", because the type will be
>>> brought by serial schema. We should however have some schema with
>>> peripheral properties for serial devices. I'll come with something.
>>
>> I suppose I should just include:
>>
>> https://lore.kernel.org/linux-serial/20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org/
> 
> 
> You could, but then your patchset will depend on mine, so instead I
> propose just "current-speed: true" and later (next release) we will add
> $ref to serial-peripheral-props.

You got it!

Konrad

