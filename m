Return-Path: <linux-acpi+bounces-7495-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC1794DCFD
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 15:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414011F218AF
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176EC158551;
	Sat, 10 Aug 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VePmWphN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE84502F;
	Sat, 10 Aug 2024 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723294826; cv=none; b=o11PtUwAjyI6SyCSXn+LB2/BBfVr0n31wV+0ttswB0AD+rBS6lXG9IsrcJzcw1G6bYs9YCiHJUIX7lFhF1d4TTd74ckVuRgJ4z05cvVThKT5nuQLBlQW3Oiw4/Xml406Oq91ZoMIzPAKmLjMG9mW5n/Fayc7GkbMCTMPPSVZ07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723294826; c=relaxed/simple;
	bh=Y56S0sBS1zQqgakZZtSHCy7NQwyEusp9WFU6p/amnQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNkbKk2tCBTREDN6PG6LA7ErZ4iwehFmimeyXc8ftZjjdWHg+WqKOR670kE7saCjn0oTbZFYMMmK4zmWFNuWU4DBgVt94jv/bBiWla4VVarvE6mYPy+/ztQRPZyDQEw1h4S5MXLqVMvXZOxIkSmELTmGyWtFFJr/2amrgUqlSEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VePmWphN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-368526b1333so2366050f8f.1;
        Sat, 10 Aug 2024 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723294823; x=1723899623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4hlcd1ZI65AoS9FRvn9neICSMrd89SuM+q6xLvHuMA8=;
        b=VePmWphNkxfHV/gPw115IoFTK3jBEGDU/wg1+EzUx8BlNeCL3j4/6+6DHNYwEw/SQ8
         QJFJWORyXJPSewfEm73QTlpMu3zFzXt7ON0ltZrfanuGWjLU/IKvvkCByZpCe6rLbd/F
         gMLFSENH3sLaiJ/FB506Bb1EfySiGRQgb0BOQVwkuHDY1X67ObsLUNwHbTAMBJHZd0hV
         8fJYSKOxjonq/NdDiy06g9ECSv3fNgtG67WQJ2FkNt1OXUxNjDDPyvSNBXWvS2o6/I/o
         LIgF+vK+6PYSiXfi3nbVLHgASWcYtxQARVw7M2ns5j2KIaHkIY9N8FtR+4qp0rYlHX2a
         jgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723294823; x=1723899623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hlcd1ZI65AoS9FRvn9neICSMrd89SuM+q6xLvHuMA8=;
        b=DXlktfMEW7eua0K217NaV8LvJIpd0imQf334H6C36TgDM4FXUtLKRsG3Q1XLQnIS9R
         pJaxtxHAxOQvh/7ipSYi1Q/X/gXPFKHEOrwWx/LrLqbixIhEgkxSnjcPyzE023bfEAus
         0tfhUcSh3Gyr/qGts8fSv7b2Xf5ihF/dHGGJQt07KNht4YZ7OlBhTo+3Z8b3AtwyjQ6S
         jWYhPlwbQ8vK64mdoHiFWr0YwMiutAUqAAancPFvo/EbpjVSDYtmIODHO1xfHBldCB4d
         gzWxLaJts9ytiGLJAhd0g6TRC0hQwN2o55ZZrAGEXlNA4XZLpnHWeDGF1438yDJSVfu9
         7UXg==
X-Forwarded-Encrypted: i=1; AJvYcCUyDrOHbzYiSxj2rIIUes49k3DDcwFSfSkI1diQA2usLxNaiF44iiOla1uD3+fj5v9yvdI/KHmHKvj2@vger.kernel.org, AJvYcCWJLzk2FlgzUcB89vsJHgfSIcRVufIG6dnD5cZAwXaQjSfnYDpZ9T21Fi6T246iCdqCAcUSMegJdOOY+Cct@vger.kernel.org, AJvYcCX7Sp9HgNU8W22GmAWw/ouhjQvgjZ9KCb1qRNW9Ap2KyTa90SQwjLvytfzIQHv2QkIT4OS5DWGJPUvMcOVM@vger.kernel.org, AJvYcCXnHR7vKNfzoj16NDb74JJ+B2P9Lxm/kPO+d7ZU75bk22ElZoC9i56wjFMVMa3QHkICuLw3+uFd3d28FA==@vger.kernel.org, AJvYcCXpn29FgZHsQ7K41aMvQV94R9eX0BEsm/ahlnolN6XpXosI3a3+hKdrPOuL6Qf/g3jo6pstiyoT4YjyZUBLbI47Mood6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/7MxxBd8SoChnaYT2AO9MItOgBxEjgh+HtbsNYXebPeFJrnU
	tV9O49BDtp0z6Xpb3vR0iuQgZbUGAM7QtyrcTEsAtsd+M0EubgLP
X-Google-Smtp-Source: AGHT+IHrDBbl0TwMtFUoaVBCUF+rb5vjaVYOgyKQKJUvVhETJDXj15C3rNpG6T8goqOIyo6sHHzQKw==
X-Received: by 2002:adf:fc4c:0:b0:363:ac4d:c44f with SMTP id ffacd0b85a97d-36d6907bcc5mr3253936f8f.17.1723294822404;
        Sat, 10 Aug 2024 06:00:22 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd35c8sm2234733f8f.107.2024.08.10.06.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 06:00:21 -0700 (PDT)
Message-ID: <f3feeda2-81cf-44d6-8c9c-f489eebd8ebd@gmail.com>
Date: Sat, 10 Aug 2024 15:00:21 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] platform/surface: Add OF support
To: Konrad Dybcio <konradybcio@gmail.com>,
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
References: <20240810-topic-sam-v2-0-8a8eb368a4f0@quicinc.com>
 <20240810-topic-sam-v2-3-8a8eb368a4f0@quicinc.com>
 <c4b23a43-7ff6-450a-bdc8-3348cc935145@gmail.com>
 <d01c19a3-dc76-46f5-bca4-f5fdc7bd8798@gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <d01c19a3-dc76-46f5-bca4-f5fdc7bd8798@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/24 1:21 PM, Konrad Dybcio wrote:
> On 10.08.2024 3:47 AM, Maximilian Luz wrote:
>> On 8/10/24 3:28 AM, Konrad Dybcio wrote:
>>> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
>>
>> [...]
>>
>>> @@ -299,7 +302,7 @@ static const struct attribute_group ssam_sam_group = {
>>>    };
>>>      -/* -- ACPI based device setup. ---------------------------------------------- */
>>> +/* -- Serial device setup. ------------------------------------------------- */
>>
>> One more :)
> 
> Right, cursor at 80 != 80-long :P
> 
> [...]
> 
>> Are these two changes required? Surface 3 power and SAN should AFAIK be
>> fairly "legacy" and ACPI-only drivers, which I don't expect to be used
>> on any of the new ARM devices (apart from there probably being other
>> changes required to make them work with DT).
>>
>> I think with that addressed, it should be fine. I'll give it a spin
>> tomorrow and send in my r-b and t-b (assuming everything goes well).
> 
> No, I went overly defensive here. Will drop for v3 next week.

Perfect, Thank you!

Best regards,
Max

