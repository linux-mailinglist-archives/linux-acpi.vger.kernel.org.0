Return-Path: <linux-acpi+bounces-7494-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B136494DC71
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 13:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D0C1C20CAE
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 11:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF00157488;
	Sat, 10 Aug 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxshvrE6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC7146D75;
	Sat, 10 Aug 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723288909; cv=none; b=YriLNIPkyMwpEp/Sn6LqCP7Axe7qjK6P5L8F18sQA14lfZhSpYnyqkHXp+n/zjJUodjEBDALBWxV+l0qTy0q30HJCd31wwTfUJKUEayQLXLl2sPIi4KcOpEOoBvuu98K3Di4j9/PnWb1HG6EhsTsV/HuWEoqANqy1v/ObpinDs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723288909; c=relaxed/simple;
	bh=wLPOcrQJc9FeMQqebv2m9OcS09IY4lRJtR9nrEtBRl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4jbsg6DBjmYFnYmmOYFkNCeA+Vn0SxM7D+k9otHvf9fp2aKTTEC2HFjzyH6v0Bn+qkvAtXhUIreifAI5SFyWd6e8pJN4zpNul5DmsCjZzKvKMzLOskFElTVEgdIx0DnXZ881to7L/x9Kq5iuX8ywmpie+eTCXWyYEE4K9OCYag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxshvrE6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso3564623a12.1;
        Sat, 10 Aug 2024 04:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723288906; x=1723893706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sF0hj7C/4NCQYLu5xK63NUdOHcybLZHrNwCQSR6snIE=;
        b=XxshvrE62w04Y/J1P76A4ntyU0IS287a+jMEy6g01DC+F3HxfR91Y6v04ECVM5X1gO
         dZO81XZ2e3SW3JyITi4e6pPDMgjxBnzg1cHKWKk2bbJ2F6PGvv39qBAeZkhJvQUD61Bw
         HlnKp5GtmyzG7N094exy2sY4/hXJOAVjtIzVeu6iYcJ/ji6WDiY45kfDp1f52kmViyhb
         4J+i18Jf+PMYwPMfmcmZ5R0+psq4P1pvUOdbq53XgpXxy0SyDPYK+ESVx9M3mMr+47jT
         AMtVf4gD7cIUBkcxSZIsIJBewyw1Sio6ARTyCo3g7QSOznESd7Fka2kxfv6NUVR1bOs6
         BonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723288906; x=1723893706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sF0hj7C/4NCQYLu5xK63NUdOHcybLZHrNwCQSR6snIE=;
        b=h+qdGblTlkdCcoKimuSUIwzGZCTr4w8ij/FavJUeKOgf+t/iTGeUtpVorZFfTfxOBN
         I1wQL3Z2pY5lzMCpIG1XkrRk+t7XhP7GsMTXVms1gu9y53a4kRBoAFmkkpwVyOaLe9W9
         NOjNfyf26IhI+b/gPFDZ+RiTjgZ54GJbvTdIH6mijDY2oKpDdq4W2qk2F4NYWCjszUUh
         zX8Tdo+8FnhNBKLIP2jsesRi95eF3UnN1cRADbud/iO7OvtOjyGtQ95PvrxfpAZFDvif
         RIW2jzMnBKjz9tcwXIRX1BZtPEBULXjvUta906Lq+Rw2Nr9gzYnNDwYVRsGge5pQlNy+
         fOzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmQCqwUBils4vdZW6SjhCfKm8MK+ULfZqn7j+Z1Uvc/Nl4qps8k0+WO5VyuFsJUoTnVrMY48wmp40eC+x2dyz5N+GuM63IZSi6qTtcdmhDoXLxPklK6ZWqxFVuBgCjA3oiWBdwGrClPQN6iC8ftRN73A3wj5kiBgcS7YpxMPEaAfwFd2lvfumUqqXZzJQDr8QbKMO2OhEmBzpAqSe9ommDm9EIWSVywsY0Lgyjn79F2Vur5wJVfWPrUcWvZC9aIlglV1NXgMy1
X-Gm-Message-State: AOJu0YzwiBXbVKC9OlpmMVkBTMUYm44wOe72Ulmj3nBfOUqHdSgjPEGg
	GZCqv9PtXoduv2T7X29wC8CYI1ToDFQdj79B090ZFzEZi1FUFoYH
X-Google-Smtp-Source: AGHT+IFiMn5l0mYrV3pmmOEjFgDtqUkKKjZO23fLTyfw2nrpYHDA+qyn7nI8r77AsCjGuJgW4dPkEQ==
X-Received: by 2002:a17:906:bc1a:b0:a7a:b385:37c8 with SMTP id a640c23a62f3a-a80aa54fb24mr316599766b.5.1723288905274;
        Sat, 10 Aug 2024 04:21:45 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb08fe5dsm61155666b.3.2024.08.10.04.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 04:21:44 -0700 (PDT)
Message-ID: <d01c19a3-dc76-46f5-bca4-f5fdc7bd8798@gmail.com>
Date: Sat, 10 Aug 2024 13:21:41 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] platform/surface: Add OF support
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
References: <20240810-topic-sam-v2-0-8a8eb368a4f0@quicinc.com>
 <20240810-topic-sam-v2-3-8a8eb368a4f0@quicinc.com>
 <c4b23a43-7ff6-450a-bdc8-3348cc935145@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <c4b23a43-7ff6-450a-bdc8-3348cc935145@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10.08.2024 3:47 AM, Maximilian Luz wrote:
> On 8/10/24 3:28 AM, Konrad Dybcio wrote:
>> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
> 
> [...]
> 
>> @@ -299,7 +302,7 @@ static const struct attribute_group ssam_sam_group = {
>>   };
>>     -/* -- ACPI based device setup. ---------------------------------------------- */
>> +/* -- Serial device setup. ------------------------------------------------- */
> 
> One more :)

Right, cursor at 80 != 80-long :P

[...]

> Are these two changes required? Surface 3 power and SAN should AFAIK be
> fairly "legacy" and ACPI-only drivers, which I don't expect to be used
> on any of the new ARM devices (apart from there probably being other
> changes required to make them work with DT).
> 
> I think with that addressed, it should be fine. I'll give it a spin
> tomorrow and send in my r-b and t-b (assuming everything goes well).

No, I went overly defensive here. Will drop for v3 next week.

Konrad

