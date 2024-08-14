Return-Path: <linux-acpi+bounces-7561-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 628FB95145C
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 08:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFCF283CFD
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 06:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A94524D7;
	Wed, 14 Aug 2024 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX8e7NGo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1D2D030;
	Wed, 14 Aug 2024 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616192; cv=none; b=nOYq+ZJ7OPp/JBsX/vw76okjRGY4ZHH3KP1ffA4TV1SMC4uLLlSVfUlrZoNzubVf/UGt3nqedmaUYim9rbP6vHWlCiNXjMhS5zr6Dr2w6hhOfb0i414+HgblLqx34h8/dw+GUClfCeztDHqhes+jGtlDVGMeqnMZd7bJLTm4C50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616192; c=relaxed/simple;
	bh=7J0NaordMkLnaseR0ejiQMBxcas5MlG506PR3I+zC4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzaBc5GySY4oS3a8NH698zbYLf3l9vxd10BjyHqq7k5TKyyVfpC+fl91KOYJUCE+e3xOOROBXtqoiED0VHsVkXm2Dta0VaQYWMZPoi2d9EPwoxC4sZRiLDj8SvFmn0RvAC2Yc8so3G9uNHXjEMy5pxEZZRvGs6FZk7XfwoE2FzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LX8e7NGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDCCC32786;
	Wed, 14 Aug 2024 06:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723616191;
	bh=7J0NaordMkLnaseR0ejiQMBxcas5MlG506PR3I+zC4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LX8e7NGo6PNLJWtC5fkEIQT2YeDxBP546EDRGNlrfCVfn4D1b89qXhPp45wGKw3TD
	 fSdCZB8JICVB48efGgNCRy1jdPZd49whYSfEZbcL4FVbbM/sQa/kCpGoV2UYTz46Gl
	 SR0VlRIZdf+nfKw2rjpk/3rtXXp+5bKYeujH9qFyp+6YhCCo8UUYAe9v1+VtTGUuCH
	 nLnOmKlZCiNsMo9TKxSOqix0RMopBoNi0BsD/xsWyRHmlEn1D49cajE0ezM/fItNhX
	 wfT29NzWNQgZMz9Lyx2Q41+GUgOSfcuEHNsW0NvBaO7xD6tgyxVSiLcC5Avv2dJEQ5
	 CvyHfEhBjw/6w==
Message-ID: <13f254ed-68b7-438e-91a8-9d75c9e9f2a7@kernel.org>
Date: Wed, 14 Aug 2024 08:16:22 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: platform: Add Surface System
 Aggregator Module
To: Konrad Dybcio <konradybcio@gmail.com>,
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <36b0ee66-3af3-40c1-86b6-b52cd826298e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2024 16:27, Konrad Dybcio wrote:
> On 11.08.2024 4:28 PM, Krzysztof Kozlowski wrote:
>> On 10/08/2024 03:28, Konrad Dybcio wrote:
>>> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
>>>
>>> Add bindings for the Surface System Aggregator Module (SAM/SSAM), the
>>> Microsoft Surface-standard Embedded Controller, used on both x86- and
>>> Qualcomm-based devices.
>>>
>>> It provides a plethora of functions, depending on what's wired up to
>>> it. That includes but is not limited to: fan control, keyboard/touchpad
>>> support, thermal sensors, power control, special buttons, tablet mode.
>>>
>>> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
>>> ---
>>>  .../bindings/platform/microsoft,surface-sam.yaml   | 50 ++++++++++++++++++++++
>>>  1 file changed, 50 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml b/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml
>>> new file mode 100644
>>> index 000000000000..f613738aa31d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml
>>> @@ -0,0 +1,50 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/platform/microsoft,surface-sam.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Surface System Aggregator Module (SAM, SSAM)
>>> +
>>> +maintainers:
>>> +  - Konrad Dybcio <konradybcio@kernel.org>
>>> +
>>> +description: |
>>
>> No need for |
> 
> Apparently it's necessary because I have a :
>>
>>> +  Surface devices use a standardized embedded controller to let the
>>> +  operating system interface with various hardware functions. The
>>> +  specific functionalities are modeled as subdevices and matched on
>>> +  five levels: domain, category, target, instance and function.
> 
>                  ^ here
> 
> Should I e.g. s/:/-/, or keep the |?

Keep |

> 
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: microsoft,surface-sam
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  current-speed:
>>> +    description: The baudrate in bits per second of the device as it comes
>>> +      online, current active speed.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> This should be just "current-speed: true", because the type will be
>> brought by serial schema. We should however have some schema with
>> peripheral properties for serial devices. I'll come with something.
> 
> I suppose I should just include:
> 
> https://lore.kernel.org/linux-serial/20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org/


You could, but then your patchset will depend on mine, so instead I
propose just "current-speed: true" and later (next release) we will add
$ref to serial-peripheral-props.

Best regards,
Krzysztof


