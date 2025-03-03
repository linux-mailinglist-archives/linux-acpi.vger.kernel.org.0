Return-Path: <linux-acpi+bounces-11729-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AFCA4C27B
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 14:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D7518936DC
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFCB212D66;
	Mon,  3 Mar 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+uBhUrR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31457211A28;
	Mon,  3 Mar 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010163; cv=none; b=q8WJXbhQIBrpsiUyCt0STiCL5Q+uB/WWC3WVlVqgWkCqpv/OTI4FdiQyFRAFSktoNkzbinD4TK+8aJ8FVa28hmTgushOtdQ9UK7uTtREkAq5n38He/HzJkSQnedeErp9gn/whD3RTzyLC8JmxnIWuQ2puUbnw3UmVlV29Y/80Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010163; c=relaxed/simple;
	bh=MCTeDFzPFsuhhTnj3i86r61OhjjPyU6f8ybt9FJfxJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiTFCxPDLRQzf3QpDtGI3v/d7MS0P3MXaFSEg5wTz4CotGSd9DR15+I9YO9yx1W0Z+MNVbHJxKv1RVG8Ow82h00Tpyr72G0vvJKtkVusd9xpz1mU3UWdZELlZVUPeieLgYHY1Tl7+OXx0CAkXOpjI0vN7JaSh1QFfxT2yYrRhO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+uBhUrR; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2feb91a25bdso5424496a91.1;
        Mon, 03 Mar 2025 05:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741010160; x=1741614960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tBTP2SsN8b8d1tj08ma/P1grGEnHl37Fv9ksqNgBmtw=;
        b=l+uBhUrRIt2vae8rNSALiaqNZPNbVIzSp/nkZCM2yqW0+eMAnY4qh8PSJBPlXDE0au
         a4lvHLkLukKeC75wIbJY/6HbDSvFtfsqgu4/Pdch6CG66njFzHXuL07gw/PSBXy3AFWb
         A7jqVE5dAMzcMI+6T4M65MPZF40mYTz2IvC9HSj3y0Q9KdNX7QSZQw85RTf9XNYi2HnG
         tj4vNORgYmiV+8oLmcboNsaRUeqHAyEtf6wlRx7zyauoesvGImeyv1a35gCBUU5T2hAP
         GV574/kaRk0gv09s/hps+Ta12AMb2RJ5o4DgS10z981rC+5uTq34A1zIg1HZU9oskiE8
         gJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010160; x=1741614960;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBTP2SsN8b8d1tj08ma/P1grGEnHl37Fv9ksqNgBmtw=;
        b=K16xm9EOevXY29t71la8+2kU1Cp0ysFdBH+JaYYDgvMeUYnLbTF3iqvbV5OGjVKerM
         pQL5ictwJYhXiWZTnKFj+Znv64IKmM1lg9uDe+9Ove9Vmyjkwi+WDAw3Civc//Bi123Y
         6+EQbYeDHLI4pQGJBwYoBxL+zeyJGN4O/Q1jkAzOa269mLILMWUqYTx0T/J5MPvrY2xu
         AvARCd+gPc7U+OV0YIjfk7j7/xxcvBx51F6Bt7T5d+QdonGXRCk+iIXNhoAOVsbgAyzl
         FI/G1SEOvvTfJespqG8LeQlMUvKAWfYxXFoF7bZwsquDn4xDynUOjFH1N8Q16Qmf/uk/
         v8UA==
X-Forwarded-Encrypted: i=1; AJvYcCUwakdTganp/P5UWBLWIKpw68yESsQdXbZleuoEEEcMuN0Uvdp7sRIAcdh/6eCR3GTskkdRvVR9Ny1C@vger.kernel.org, AJvYcCW2Dcor1FeZw/siSHfXJqp9FiBiEKtpiI3pkIvLfIK7BxPY7Djn8hOHB/HGHikDXr4TT2EIB9HkbPcY86JI@vger.kernel.org, AJvYcCXayjDoJcpZqoL1DbSOWishoeg3ku45PAOMfKBOBo05DjmutNtzL+rE6Qghz3IlPhjxL6Y0Po6ruFVxdi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyyjyQb2uZCXwPmKt3ETjgswWCr8cBnrV4t6JG2S48hxu4FEVx
	EnXHlUzpuAVyWc7O73GVeSITcR7qs4k01DUlcSn9FxE783GfXsp4
X-Gm-Gg: ASbGncsvGa1PxmEuKBnTi2GMJXG1qYPih1vHWdUKn39btsUUj+1dixGwkTkwFFzW9JD
	P/eN+b8nxegXZhEsIx3z+xFK69EFDrDgH2fb6sJI1e1fp6ywd+lXKRqZeY2AtowJif0SvsLmhnU
	gnQ7j+i+Iw2ha7EgWd/q1BF5Ip39jncbsek/gNas+0x3umjr1Io7XBzZ0DHsrvXyUwl/7N0CvG8
	KKOkb4PGgZhJkdZ+rz0po5fDbw5q9WjuisPhGfQR36L4nrO3Pgq2xWzt+bjFmrpxSv5ohz6UPSw
	+HSiFOsmAE7+vJ8bdJAGNIGaGtYR0yCbwi5AIVUpXGxQ9noX/8b1G0BCjotmxBFXAV7iBzavXQt
	0yQlfOayYlmsBT2H/aA==
X-Google-Smtp-Source: AGHT+IGTn6ar+i21IthOT0JS9e6dJdyXIRsagA4YhnhB00hq/ZrlppOYJSELP4R84rv2YxZxVFKujQ==
X-Received: by 2002:a17:90b:4b41:b0:2fe:8217:2da6 with SMTP id 98e67ed59e1d1-2febabc804cmr16947066a91.22.1741010160288;
        Mon, 03 Mar 2025 05:56:00 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea696e3f0sm8957394a91.37.2025.03.03.05.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 05:55:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <afb9a22f-7d21-42a2-a8dc-87537caad027@roeck-us.net>
Date: Mon, 3 Mar 2025 05:55:57 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] hwmon: (xgene-hwmon) Simplify PCC shared memory
 region handling
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>,
 Adam Young <admiyo@os.amperecomputing.com>, Jean Delvare
 <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-12-3b44f3d134b1@arm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250303-pcc_fixes_updates-v1-12-3b44f3d134b1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/25 02:51, Sudeep Holla wrote:
> The PCC driver now handles mapping and unmapping of shared memory
> areas as part of pcc_mbox_{request,free}_channel(). Without these before,
> this xgene hwmon driver did handling of those mappings like several
> other PCC mailbox client drivers.
> 
> There were redundant operations, leading to unnecessary code. Maintaining
> the consistency across these driver was harder due to scattered handling
> of shmem.
> 
> Just use the mapped shmem and remove all redundant operations from this
> driver.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Note that I'll apply a fix this week which will cause a context conflict.
See below.

> ---
>   drivers/hwmon/xgene-hwmon.c | 40 ++++------------------------------------
...
> @@ -685,34 +681,6 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
>   			goto out;
>   		}
>   
> -		/*
> -		 * This is the shared communication region
> -		 * for the OS and Platform to communicate over.
> -		 */
> -		ctx->comm_base_addr = pcc_chan->shmem_base_addr;
> -		if (ctx->comm_base_addr) {
> -			if (version == XGENE_HWMON_V2)
> -				ctx->pcc_comm_addr = (void __force *)devm_ioremap(&pdev->dev,
> -								  ctx->comm_base_addr,
> -								  pcc_chan->shmem_size);
> -			else
> -				ctx->pcc_comm_addr = devm_memremap(&pdev->dev,
> -								   ctx->comm_base_addr,
> -								   pcc_chan->shmem_size,
> -								   MEMREMAP_WB);
> -		} else {
> -			dev_err(&pdev->dev, "Failed to get PCC comm region\n");
> -			rc = -ENODEV;
> -			goto out;
> -		}
> -
> -		if (!ctx->pcc_comm_addr) {

This needed to be IS_ERR_OR_NULL() since devm_memremap() returns an ERR_PTR.

Thanks,
Guenter


