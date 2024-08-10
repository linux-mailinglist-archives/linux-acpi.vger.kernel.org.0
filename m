Return-Path: <linux-acpi+bounces-7492-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3C794D9E0
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 03:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51661C21259
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 01:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D8338DCC;
	Sat, 10 Aug 2024 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj/r8s7h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEF7A92F;
	Sat, 10 Aug 2024 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723254479; cv=none; b=QrK8pLjBV+/VWCPOsAZMebpp5aUV4UFFYyWIKP2BnogpBtuCjP6pxo/Gcc0OipPHbSDoYVaTiR21lc4biWEH+HdJWGZ00Pb/1QzyGjok0VyQdWJkHAtHpWfXP6oBp9OTscPQFLlkt7tt8JxnMhHCVR8lQtmhDtJEMFhapQIt2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723254479; c=relaxed/simple;
	bh=x58h4NJznj3EK6nkkolCf/9m//fp7u3fqM/M4A/h2Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWaW/jb+iKy4ezGn5VBTKEjJISjn6pzpwUQpTL0rix9Utp61HPiSdIs8Q9ls20Wi8RdtjrnVbN9g2sfJbHaVjXJ2qpAJ8pmkbhC8sGJFZteZsQ/l01Bac/vCzkL3vc094xOz8hGU34lw6YlBD+4mZ+AG+D3oYsQoa6g/zYdfWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj/r8s7h; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428e0d18666so18867475e9.3;
        Fri, 09 Aug 2024 18:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723254477; x=1723859277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JvRPnBw8zvRuDKNZmNvjOjg/ecehKeM7mwNgiSlgPM=;
        b=Pj/r8s7hY9L86Ztp9EfBAyhSzvdeujIQI/vigolQ2Dv2gQ8QfF6Fl1PJyMZ6aLbeZh
         aY/zxdClZdbofoy6K+RTb6D2ZSS9yrESq+n3/2w52dob+4s3oAxl6/J2MU2HsWvvj4Fx
         swZKdfDu/tcQEWgiH/RYCB9Ijvcknm8KRSnMsV+QeDoMF8jDcNK0k/0JvJWSnf6WWeT9
         GsQyvvBgba9qhpe76yMfNeO6wAni+N81F63OOc+PS5i0nJqZ6p+kfzj1MLfZF2JP3iQZ
         Vn5828cPIQhLawqR8BZGb5sNYmpuBSFhKfCjlb7CNAUAINgSry3a6VADLJhEtphSbjIs
         Sdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723254477; x=1723859277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JvRPnBw8zvRuDKNZmNvjOjg/ecehKeM7mwNgiSlgPM=;
        b=k9BeP4mmt5P6JRTwNP7iK+doIZQOaMVErXo3WaVQhokqT016xnlaR2XLbF4zeSm1AP
         ITpEJLVol/72g9clBqFT4LZ+v32j4Fyv5MhI/rdDOgfEXriszF9NjbwQS7yLlmbn3P0S
         BfpMCd2nn8OzmYAVeHO9/5c094TfH1McLL9jsp3NySQ192uUtebaCODKDhQV+uEEohzz
         UmAFtGYiUlyWfVbTz836Tr8wRk3/FMBtyvm2qMbuB/5DrTnALIGv6w765tYq7NUv/qcE
         LhzSCymCRKpNF4rUIxJPNbY8NRVMc1xJkBhqRk1pfrbBGMhpRsO6kWuGayW3txWPEhSX
         rJAA==
X-Forwarded-Encrypted: i=1; AJvYcCXr+n6STkg3q2NJugiae43uKM4TFIoce4TKLJX/M3vJwPN60Ut5lqtRDYUMG1TXdmDr5MRnQYdu9zbazTrL0Kc9L5xRwASLb1g67q9Y+VrwYh3Wahd1m7IUBK3jIXGn83IeC796krqdHpJ3lo3Q1N/K9czB1sNBerlYeifgPWDUTuAbLkARRzrnMeUbwmHE74Uw1uQAJBGehXbcOBHmBxCcfwdssIOdzXwLcqEwYmzZsmw8IpXCNvp/mRVBg2voyYB8SJ9f2359
X-Gm-Message-State: AOJu0YzV9cALw7h+lEmqbXnXPvMBTOmTueuUkbIUOm3Wa5bps2XXWyVf
	5h4uKgadEuuaG6RExYx69w4fXp7GmknTsCZ0kltSz/JypEfFOmcc
X-Google-Smtp-Source: AGHT+IGnZKdTB6tDMSel5vmN11Ga+dqwt9R96EMmeCgt5ZQqvNotzg/Wbzy8CFRkT8rnKEh5NsUdAw==
X-Received: by 2002:a05:600c:1f96:b0:427:d8f2:479 with SMTP id 5b1f17b1804b1-429c3a1bd14mr18717575e9.14.1723254476414;
        Fri, 09 Aug 2024 18:47:56 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7a6d15sm94452585e9.45.2024.08.09.18.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 18:47:55 -0700 (PDT)
Message-ID: <c4b23a43-7ff6-450a-bdc8-3348cc935145@gmail.com>
Date: Sat, 10 Aug 2024 03:47:54 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] platform/surface: Add OF support
To: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
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
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20240810-topic-sam-v2-3-8a8eb368a4f0@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/24 3:28 AM, Konrad Dybcio wrote:
> From: Konrad Dybcio <quic_kdybcio@quicinc.com>

[...]

> @@ -299,7 +302,7 @@ static const struct attribute_group ssam_sam_group = {
>   };
>   
>   
> -/* -- ACPI based device setup. ---------------------------------------------- */
> +/* -- Serial device setup. ------------------------------------------------- */

One more :)

[...]

> diff --git a/drivers/platform/surface/surface3_power.c b/drivers/platform/surface/surface3_power.c
> index 4c0f92562a79..7eab6a124712 100644
> --- a/drivers/platform/surface/surface3_power.c
> +++ b/drivers/platform/surface/surface3_power.c
> @@ -478,7 +478,9 @@ static int mshw0011_install_space_handler(struct i2c_client *client)
>   		return -ENOMEM;
>   	}
>   
> -	acpi_dev_clear_dependencies(adev);
> +	if (adev)
> +		acpi_dev_clear_dependencies(adev);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
> index 20f3870915d2..b0d43e639db2 100644
> --- a/drivers/platform/surface/surface_acpi_notify.c
> +++ b/drivers/platform/surface/surface_acpi_notify.c
> @@ -815,7 +815,9 @@ static int san_probe(struct platform_device *pdev)
>   	if (status)
>   		goto err_install_dev;
>   
> -	acpi_dev_clear_dependencies(san);
> +	if (san)
> +		acpi_dev_clear_dependencies(san);
> +
>   	return 0;
>   
>   err_install_dev:

Are these two changes required? Surface 3 power and SAN should AFAIK be
fairly "legacy" and ACPI-only drivers, which I don't expect to be used
on any of the new ARM devices (apart from there probably being other
changes required to make them work with DT).

I think with that addressed, it should be fine. I'll give it a spin
tomorrow and send in my r-b and t-b (assuming everything goes well).

Best regards,
Max



