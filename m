Return-Path: <linux-acpi+bounces-9532-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D520F9C69A3
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 08:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98786282E97
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 07:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B36A17BB13;
	Wed, 13 Nov 2024 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Tz15j7pZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65282230996
	for <linux-acpi@vger.kernel.org>; Wed, 13 Nov 2024 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731481521; cv=none; b=JOIlyyAia1dZSJbzKnKLBqXWT5jBoYvyarchueNrD9MYGwrcVOszuKuiK8U1obrbMTJJeZGnRGb1L1vqEnVxaubQyIy4RReMlcYiFZaN60y5XAViDzx5M5+2hHujk1X+kHK6lJdtQQWW93/ke87/lFDYWL8neCSL+ZFi5yy0r3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731481521; c=relaxed/simple;
	bh=XzNpsyTqxzDr0Q1/DeMDEhXObeXQxZI8NonLpXgpY54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wk/pp2nfObQqNuASTimdpmL5pyA74upQsKaA0yWN1vxMwyYz6ZTroMWZKwJeN17hJIrt/swuruF3JnurbQQYGGd/CXuP9t0CItTr8IZz5nd6cotEybLax5TScCFgF15rL3W9VAfk2kfx9VTuEGhnuIRCUVktqkfU82XghxTBuYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Tz15j7pZ; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e60825aa26so3881883b6e.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2024 23:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731481518; x=1732086318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RV5mKd+SWUX0HV1zXunMJLm1pgRUmXppt4+8Yzk2GwY=;
        b=Tz15j7pZEj53QiXotR45LetjBIAQUrXYx9JLcSdgMpLHTl8IPQyJ5ehI0p3TS274OD
         yDRrqG2IMVUgBMSPGhGxZfAPb9ymi5nxRV+LhGoNt6irUXwKX6vJicAkVpSHb1wJqYfE
         x79FeBhbQmhYJLOgKkhXsKqzQ2Ds1/PgewlXMP1ijqXqj83jSEYcvmsI9QeD9ATdFAc1
         USwXt1hxYFEpuvDQmlQoI30t2h7DI/+l4dnwagp4+zrxcVh5WYMHOXUcrZHpBRJu6z9h
         XDEAiaHcnJj/Nz9bacnrT1yGnzfxLlSs5jpsOXqK4vCzwKLh04gG2/z5A073Lhg5EaAh
         3EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731481518; x=1732086318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RV5mKd+SWUX0HV1zXunMJLm1pgRUmXppt4+8Yzk2GwY=;
        b=Oo+7JDVfYifp0f1P6BQJhM5MsTVIon9KRkfuSyHqThpArRJEMLYCG2Ko7llwzsKojT
         cgOLbVvoO0D/73tT+np9i3NHMwcEhSWxdjUF1zfA7SK1BBIGcc+d33EnKW84J6i54VwK
         3Z3D7uzlZm5ZldGZELdqI6olV3Wyr1XyHeHS6iIx73rqN0TIi/4fH4Qs6qXogH+0Chr8
         RyG9oaELc1nAAQITwnKhBd8A38ZUfdhWGMit2h5sMhhcnU0VD3L37oVNo6arEVqZo/nx
         kYabtoU0BQwvQip/q5/0QlGeDp6s3pB1ba/I35X8xdLPYUN2RBP7JldLQ1YB9aeSMF+R
         iZWQ==
X-Gm-Message-State: AOJu0YyxRzIifsPP211KOTHgmbvq/Kp5QotpDBsI+BWLr0cEpL28kL/6
	VDR3JHjxHX2JxU4qaXxBUpgnkakoxXxOkVDAGX5dfQvvztsIDQ+VYowHcDja9zc=
X-Google-Smtp-Source: AGHT+IGFw7DzRMngPvx+mv65K5j0/xVV3hwA8bu8072Y2SlIKW69JCxYqNFCGgCUgZj//dtqG2WJQA==
X-Received: by 2002:a05:6808:3194:b0:3e7:5ab1:35b4 with SMTP id 5614622812f47-3e794706397mr18599233b6e.30.1731481517358;
        Tue, 12 Nov 2024 23:05:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f714e8ae59sm788632a12.28.2024.11.12.23.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 23:05:16 -0800 (PST)
Message-ID: <dfe6ca13-7c4b-4204-b3fb-7390eca3b18b@rivosinc.com>
Date: Wed, 13 Nov 2024 08:05:02 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: fix bug that causes the value written in cpc
 register to be wrong.
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhanjie9@hisilicon.com, lihuisong@huawei.com, fanghao11@huawei.com
References: <20241113024933.2100519-1-zhenglifeng1@huawei.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20241113024933.2100519-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/11/2024 03:49, Lifeng Zheng wrote:
> With these codes, the value written in cpc register will be the result of
> the OR operatiion on input value and prev_val. This will causes the value
> to be wrong.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 01192fd047a6..f69ef7cc0caf 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1146,7 +1146,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  			return -EFAULT;
>  		}
>  		val = MASK_VAL_WRITE(reg, prev_val, val);
> -		val |= prev_val;

Hi Lifeng,

Indeed, MASK_VAL_WRITE() already takes care of ORing prev_val with the
register mask. You can also add a Fixes:

Fixes: 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage")

Thanks,

Clément

>  	}
>  
>  	switch (size) {


