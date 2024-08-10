Return-Path: <linux-acpi+bounces-7487-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 178D094D9B5
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 03:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55B31F21FED
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 01:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BB4347C7;
	Sat, 10 Aug 2024 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM27uoS5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E807D611E;
	Sat, 10 Aug 2024 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723252684; cv=none; b=j8Wl0pk40t/w0C/xFYZiyvhgTC1sT5WxG2MPyAUEYUYKEsivZDNBvB3dJ3vtBRhg76QtfvNJyH/Z9mm6WfzkFWZuvmvR5XDYvCdwLtlUHbrHtUMEhPd8yEuTIL3WlQ0SuhgOKPJFMLayItC2O/KI1gWHc+1Oo9tOPyP6YGgBdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723252684; c=relaxed/simple;
	bh=FbqkE5Z1mqOjU6e9oJ9gni56OCinpzmu9lx2bC1HRgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7vhfU7bkD8F9ezFhrB6eEq9fes1Ro6YBF2+mROjhpW7Ec6aMgiShDY0Y8x3V9EgAxPO560NmWH3ROcy+7JPRXVqdueiaF53HCZsZieCZY526nQhhmnSWf4aUMRWohglQ/+TO7xJ+gCbWtNXiliuFibRan8UCpSMUQSsh20a0o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iM27uoS5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-530d0882370so2542031e87.3;
        Fri, 09 Aug 2024 18:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723252681; x=1723857481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiHyUKVkySZubcJbigoVW/AddydrPdWYeFB33p+5Ops=;
        b=iM27uoS5gDBUJuhH6IlqLbm1Jkd/QGg2bqVePr3JBadIChy8J6zuQ8LLvzq8EmA7Qu
         1XqUNmYFpPhmKqJVwBbG7hSS7N4ncu8/Sunc7oXO/ca2YEcTaFhjqNmTfqNOgygdHmVU
         sw9dCvWPU1rygfeFcx0x7W2zviD5UdjwrenVF2xrkTc73kN/CTNHxUSf6oy+cD9FspjD
         jFknL51iw15EYDEsLaqleVmeJZG/ZztxBAflo7hKforsBxoslItAlh1BhedtnETK/lpE
         wCf+BsAncemHtmB0hSFqqjoARIFKf+T2qEqfsvZ+W1+xUgclXF7vraK7skKBxj3mfXAi
         KjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723252681; x=1723857481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiHyUKVkySZubcJbigoVW/AddydrPdWYeFB33p+5Ops=;
        b=jN1ih0ChWPrpmGBP533BfzOcVTgJUIA2VDO0O5dDDOjm2E+TC9lNMBdezDAHSRi4tA
         DitiFNJS/SpiwhlZyD9X6uYM04hM3nplwY+V4t8QPXKaz1Q0mU0dImgUHEpfMVoLM0ZY
         CjkpiuDbZFAhNyBSjAghIMJaPHBSbPNu3KkbHrSbUi1eE4JvyiqF/9JiqiywrAWapQC2
         V1Q+mw9G8LaBsNAVdoGEDRtmUR8PZkHPFllWrknuM2nZXORj2Cez/M6YbdHqHstnHYya
         6mNNeTjDUDuX0uqCWGBsjTvnMOu9nAuwlOtgmiKDlTtIZSO1IHtWeKAxlKOd1TURiWI1
         9wnw==
X-Forwarded-Encrypted: i=1; AJvYcCXAk0XJhUyCtiDGvA3Kh18RWI0ibjV8xxNSJ7Y4FQrdSGOalk8ebf7e+F93QGLZkao3bOuGQWnQfPIl3XvyFaQvS4nEBQsJFzzn3wW6Cy5/zNDF0OhuHpQci6oLMq3HU5/pZpHkux2reqgOsJ1k8ZjQ0EdLB7R/U0dPev9Wg+/lJ+fDZ4j4zQtXQrJXpE4+Z72mwYdI8JlEdgUSGgjARqWY1j3KnXHqqFe5uWvCzZU3TG0+AEOUUyungsOZOBNSjWffcd5CThbK
X-Gm-Message-State: AOJu0Yw2zt9jO+VJKkCA1JTCnfGLTqJzn/jF4loFRKzfTDpfj6VPlY92
	cRIG2qbTSvP0qHYm9Fcan8AUsAfKDtFh/RtFpCJM6HuXrKOEtSXd
X-Google-Smtp-Source: AGHT+IEa1szWAiYYE3Q8w0SfO4rsdTq5qK8AyQqTLdz7t3BCORmboLathkL4jOxjT9WqDsr+4sdsnQ==
X-Received: by 2002:a05:6512:3d09:b0:52c:f3fa:86c with SMTP id 2adb3069b0e04-530ee979d95mr2452518e87.18.1723252680431;
        Fri, 09 Aug 2024 18:18:00 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb09007asm25022066b.4.2024.08.09.18.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 18:17:59 -0700 (PDT)
Message-ID: <b4e8b275-bc5f-4a8e-9f78-20ca5b67977e@gmail.com>
Date: Sat, 10 Aug 2024 03:17:57 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] platform/surface: Add OF support
To: Maximilian Luz <luzmaximilian@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>
References: <20240809-topic-sam-v1-0-05bca1932614@quicinc.com>
 <20240809-topic-sam-v1-3-05bca1932614@quicinc.com>
 <9ee8eb9d-1e1c-439f-a382-c003fbd7259c@gmail.com>
 <ea348f62-49e9-4b5e-9041-b0a696aaa736@gmail.com>
 <f9c9601b-737b-42d1-9449-2072afdec580@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <f9c9601b-737b-42d1-9449-2072afdec580@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10.08.2024 3:15 AM, Maximilian Luz wrote:
> On 8/10/24 12:44 AM, Konrad Dybcio wrote:
>> On 9.08.2024 8:09 PM, Maximilian Luz wrote:
>>>>    +static int ssam_serdev_setup(struct acpi_device *ssh, struct serdev_device *serdev)
>>>> +{
>>>> +    if (ssh)
>>>> +        return ssam_serdev_setup_via_acpi(serdev, ssh->handle);
>>>> +
>>>> +    /* TODO: these values may differ per board/implementation */
>>>> +    serdev_device_set_baudrate(serdev, 4 * HZ_PER_MHZ);
>>>
>>> Isn't this defined in the DT spec that you're adding as "current-speed"
>>> in patch 2? Why not load it from there?
>>
>> Yeah and it's not under `required:`.. i added it for future proofing
> 
> Okay.
> 
> [...]
> 
>>>> +static const struct software_node *ssam_node_group_sl7[] = {
>>>> +    &ssam_node_root,
>>>> +    &ssam_node_bat_ac,
>>>> +    &ssam_node_bat_main,
>>>> +    &ssam_node_tmp_perf_profile_with_fan,
>>>> +    &ssam_node_fan_speed,
>>>> +    &ssam_node_hid_sam_keyboard,
>>>
>>> Did you check if there are any other HID devices connected? In the past,
>>> keyboard and touchpad have been split into two separate devices, so is
>>> it a combo keyboard + touchpad device this time? Some models also had
>>> HID-based sensor and other devices.
>>
>> No, touchpad is wired directly to the SoC via QSPI, same for the touch
>> panel
> 
> Ah I see. So somewhat similar to the SLS2 I believe. Does it work with
> multiple fingers out-of-the-box? Or does it send raw heatmaps like on
> the SLS2 that require post-processing?

We'll see when the QSPI driver for this soc is done ;)

Konrad

