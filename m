Return-Path: <linux-acpi+bounces-17641-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB1BC08A2
	for <lists+linux-acpi@lfdr.de>; Tue, 07 Oct 2025 09:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4F7189B8B7
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Oct 2025 07:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591682566D3;
	Tue,  7 Oct 2025 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy02TVqg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E7E255F2D;
	Tue,  7 Oct 2025 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759823874; cv=none; b=nqSNC6CU/q8NZ2ncwNhjHSwpv58ce6w3fllPYRIuJBykqlgvWjC8PoLvWoL1VWQEeZBvRJmiaSC6xooGDx4DBr+5W1107IXm014escRtELseNscCe+Td9/TO070tJPoN6XJ6So7nNXB9hiPYp+LlaMmYAqUOMbnKAecXyKL0pIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759823874; c=relaxed/simple;
	bh=R6gtJSYLgBkYeZSH32dxucWO2BsN2sbUueDohPWa/Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYTfffEYmYeDxER885s0YQwkpUPf6NgI/Bema1Htq+8XFwFZdPE8buTZ1IttWiYQ1ntohrooF7BPUKuMKmLLH+kTnuncyK+qs1G76vJN79QLEOjOMGcef7QxAb4ZeuKACCxkJQI8S9qsPi4AcSqCiQCvNf/RD4x4sg3loTwdKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy02TVqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39DAC4CEF1;
	Tue,  7 Oct 2025 07:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759823873;
	bh=R6gtJSYLgBkYeZSH32dxucWO2BsN2sbUueDohPWa/Tg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iy02TVqgDtd4VYbHuqChQU09pyKxO7UUS/woObz6tTUwqOKp1H1Nart9SAP34DCIE
	 0YouLiu/RKYigtUOwGyASdkQCsIQa4zjRoLs0ZWynKgE37IuVyisVn2AVomehnBc++
	 ZdJz43nUdV0V+XastQJIkDH0kAIendx44FYY/V4okmOrKgzVkuW4jt98eHBKmQ5Fm5
	 AGm10UD7MjIWPSwz6bcg2OM+2Z4CyT2lab2OVBZbukS6W2kqlO4b6QaJBY9rZduqxM
	 XGoeKFfaUzF3rf36QbadmguGRZzhags4+Bwn5E1d0qZsAkThoKRfpZzUVZfnTnrfOi
	 uM7HTgVmhySjw==
Message-ID: <6942a236-ac52-4402-a0ab-bd1765e03636@kernel.org>
Date: Tue, 7 Oct 2025 16:57:46 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: of: make it possible to reference gpios probed in
 acpi in device tree
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Markus Probst <markus.probst@posteo.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251002215759.1836706-1-markus.probst@posteo.de>
 <CAMRc=Me3VLbmRksbrHmOdw8NxN7sxXjeuNFb9=6DzE=uLn0oAA@mail.gmail.com>
 <7f4057f25594ac3b50993a739af76b7b1430ee6a.camel@posteo.de>
 <CAMRc=McioBjF3WCBu0ezzuL+JJTiEpF2fz1YpbToRpijpHfAEg@mail.gmail.com>
 <64dd0bab-6036-4e06-aff5-b0f86a167ada@kernel.org>
 <CAMRc=Medke+Dr7ti6OpMW6j=RDU0AO19pJUmPa_cvSXyW16OPw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAMRc=Medke+Dr7ti6OpMW6j=RDU0AO19pJUmPa_cvSXyW16OPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/10/2025 16:49, Bartosz Golaszewski wrote:
> On Tue, Oct 7, 2025 at 3:14 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 03/10/2025 17:51, Bartosz Golaszewski wrote:
>>> On Fri, Oct 3, 2025 at 10:40 AM Markus Probst <markus.probst@posteo.de> wrote:
>>>>
>>>> On Fri, 2025-10-03 at 10:03 +0200, Bartosz Golaszewski wrote:
>>>>> On Thu, Oct 2, 2025 at 11:58 PM Markus Probst
>>>>> <markus.probst@posteo.de> wrote:
>>>>>>
>>>>>> sometimes it is necessary to use both acpi and device tree to
>>>>>> declare
>>>>>
>>>>> This is a rather controversial change so "sometimes" is not
>>>>> convincing
>>>>> me. I would like to see a user of this added in upstream to consider
>>>>> it.
>>>>>
>>>>>> devices. Not every gpio device driver which has an acpi_match_table
>>>>>> has
>>>>>> an of_match table (e.g. amd-pinctrl). Furthermore gpio is an device
>>>>>> which
>>>>>
>>>>> What is the use-case here because I'm unable to wrap my head around
>>>>> it? Referencing devices described in ACPI from DT? How would the
>>>>> associated DT source look like?
>>>> In my specific usecase for the Synology DS923+, there are gpios for
>>>> powering the usb vbus on (powered down by default), also for powering
>>>> on sata disks. An example for a regulator defined in DT using a gpio in
>>>> ACPI (in this case controlling the power of on of the usb ports):
>>>>
>>>>         gpio: gpio-controller@fed81500 {
>>>>                 acpi-path = "\\_SB_.GPIO";
>>>>                 #gpio-cells = <2>;
>>>>         };
>>>>
>>>>         vbus1_regulator: fixedregulator@0 {
>>>>                 compatible = "regulator-fixed";
>>>>                 regulator-name = "vbus1_regulator";
>>>>                 regulator-min-microvolt = <5000000>;
>>>>                 regulator-max-microvolt = <5000000>;
>>>>                 gpio = <&gpio 0x2a 0x01>;
>>>>         };
>>>>
>>>> - Markus Probst
>>>>>
>>>
>>> Krzysztof: Could you please look at this and chime in? Does this make any sense?
>>
>>
>> There is no such property as acpi-path and I don't see here any ABI
>> being documented. Nothing in dtschema, either. Nothing in DT spec. I
>> also did not receive this patch. Actually - nothing from
>> markus.probst@posteo.de in mail mailbox.
>>
>> So no clue what is this about, but if you want to use undocumented
>> property then obviously no.
>>
> 
> I interpret this as a vague proposal of adding a way of referencing
> ACPI nodes from DT source and this is my question: does this make any
> sense? It doesn't to me at first glance but we do sometimes describe
> firmware details in DT so I figured I'd ask you.


I am not aware of mixed ACPI+DT systems and it looks like that's the
purpose. And PRP0001 still assumes you are having ACPI system...
https://docs.kernel.org/firmware-guide/acpi/enumeration.html#device-tree-namespace-link-device-id

In any case, we rarely discuss ABI via driver patch. Any discussions
should come via patch proposing this ABI - either to kernel bindings or
to dtschema.

> 
> It seems like Markus found a different solution in the end so it may
> not even be important anymore.
> 
> Bartosz


Best regards,
Krzysztof

