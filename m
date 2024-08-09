Return-Path: <linux-acpi+bounces-7483-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C24694D903
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 01:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112C5B22436
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 23:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7C416CD2B;
	Fri,  9 Aug 2024 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjglO4n9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5763817557;
	Fri,  9 Aug 2024 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244981; cv=none; b=TVT2GQZ8xXHjY0BGZAquTONYrP2yPXPLk7yBby51jgiHbP6hHK6lhw/NCeB+CXh7b5LJvm7MFQ0zhdXk2oM02uT6iEoEOaL+nsYzOJkAsbZrG7pDQynm2YHXNGGr+XwXvFVSffW1IiPB6n1N2YtvPxhy4u5ZZt3FSv6LlaAqCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244981; c=relaxed/simple;
	bh=rQZ2ygm7Nh2kJz35mZERhg2qJ5vW52JPLtD7Zxys8W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLwBrZ6wDAyJ9fUYzrY0IX0Bqy1KlWHdxEgGqmmVBnrYs2SuqinS/I7K5+rgi00cpQFMtRnzLs9LOmYOQdMHJI/w9NdCgTWYnfvlpSXLsWnNzHhQUG41AkMKIzXsQwRCJhVeFgU0ttLFCohIBdEolBNdMGTed0/HNDux/7IbGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjglO4n9; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f149845fbaso27314571fa.3;
        Fri, 09 Aug 2024 16:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244977; x=1723849777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oL7ScIruNuVBu8gjRm1tQtLVmuvsz9QmRWzER6ek6Xk=;
        b=WjglO4n96W7rjgNUXIAzGPdRj0w5SMVS6DpbfCw0QeLD8zU1EuOXQktGJgZ3zeYBM7
         ERV1+nIP+Jj+aXTbSLApys2ceZVVlxt46NZesr0HCfSm35w1I/DgrzzBQpezwVaaVg4C
         W8EplfnYw/XIVHnT68p84rUCQJwD59pB+vT7Nri9RTdfBl86A/uFhUqrOZ7DVG9ysJkp
         vwahUdwoR2JEBJDk/b/Y5BBAjhr1+z/8h32bMeDDHE7qr/AJZCnzmw89YLwFRcjLSK+M
         0Jb8MYkTNKn83Ox+lEzvfOsxPRS0zjJdoZHkO5n+5mntNvBQxg0Js6znMPt9YeFO6kxL
         hsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244977; x=1723849777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oL7ScIruNuVBu8gjRm1tQtLVmuvsz9QmRWzER6ek6Xk=;
        b=LYfd3ZsRJTg+WIU2Y1azPY9yknkcY/4POd8bTtMEvlMD3AVwdcpNXVOeZ4WqJJoCQd
         Rj8+G/DtB4J/P+VnNZWTUA3USx2GlwfGYdZcBuy10D73LDwRm6vcXZUCYByX4xbfmXQq
         K35+qXK0J9tv/lXqHT1hQl/1Yrwzhe09kYIhH64oRX79jEUpoSABH597DuENvVv+ClNM
         6jMYV14Ghis+hB6QyFdkMQTPX7TAuGPgIowzUGWYFX6uKMceWPTRiLj4ZpPCG++b0AJ1
         FGg2lQFfnylNRJXUi+X2ZoH6+Yj+MneaEP+do7c6PRxoeNMR3ipEIwM6zPJMv9uq5BE4
         GTQA==
X-Forwarded-Encrypted: i=1; AJvYcCVDUHmBjmHZBVtg8T1V3h2ncBHa+sg3K7AGYqUa0WIulfZWizXcPBVC7vjovXGVA2k4TsLEEwdgHQUfDQvDH9u+WoPAkQ==@vger.kernel.org, AJvYcCVEREBDgagRQpTuxRb2A4ugwIyu56oreRLEtTeftbt0rizV7W/X6VuudYMABN53nKX4hWnqa5dOafOtSgd4@vger.kernel.org, AJvYcCVXjdrskvJVTjQsHq96FRoi4xGphK0w8pTHig3lQbFxNFplJTViDnCA1K10guTyy2pZnN/gyBXefiT7Mg==@vger.kernel.org, AJvYcCWF6i1+MCfEerBcteEFT+YOFdXzpCmcXdqtWdBtf6kZ8ITGrpZRaQ3Efg73qKgpep/MLNvK3LR9/TmHK2Qc@vger.kernel.org, AJvYcCWSIQZlmPUArGCqzvTgkHvd/EIsDP8IfcImfooFOEJ6n/QlsdH/CGWuuYSgPFERzyhca2+mGwDc83v2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ppJ+Q4vED8ThRkUb8dR2k3t79C3jZUm2D22+i+zi1No+RTOW
	NvzfJg8ws1KLSGdZNH6Gx2t5MZGhF4qXK034IjfSJnq+Rlx98V3A
X-Google-Smtp-Source: AGHT+IHG3pAD068Mr9Jclat9H/d9CIoYFgSQCGBLI9Evk398dSVc7JapswxaRVucTf09AfUTH3i2GQ==
X-Received: by 2002:a05:6512:3188:b0:530:bb10:2874 with SMTP id 2adb3069b0e04-530ee96c0b2mr2256573e87.6.1723244976456;
        Fri, 09 Aug 2024 16:09:36 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb24361csm17428066b.216.2024.08.09.16.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 16:09:35 -0700 (PDT)
Message-ID: <f0ead060-f1ef-4e7c-b402-28de69589628@gmail.com>
Date: Sat, 10 Aug 2024 01:09:33 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] platform/surface: Add OF support
To: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
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
References: <20240809-topic-sam-v1-0-05bca1932614@quicinc.com>
 <20240809-topic-sam-v1-3-05bca1932614@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <20240809-topic-sam-v1-3-05bca1932614@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9.08.2024 3:48 AM, Konrad Dybcio wrote:
> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
> 
> Add basic support for registering the aggregator module on Device Tree-
> based platforms. These include at least three generations of Qualcomm
> Snapdragon-based Surface devices:
> 
> - SC8180X / SQ1 / SQ2: Pro X,
> - SC8280XP / SQ3: Devkit 2023, Pro 9
> - X Elite: Laptop 7 / Pro11
> 
> Thankfully, the aggregators on these seem to be configured in an
> identical way, which allows for using these settings as defaults and
> no DT properties need to be introduced (until that changes, anyway).
> 
> Based on the work done by Maximilian Luz, largely rewritten.
> 
> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
> ---

[...]

> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2444,7 +2444,8 @@ static int acpi_walk_dep_device_list(acpi_handle handle,
>   */
>  void acpi_dev_clear_dependencies(struct acpi_device *supplier)
>  {
> -	acpi_walk_dep_device_list(supplier->handle, acpi_scan_clear_dep, NULL);
> +	if (supplier)
> +		acpi_walk_dep_device_list(supplier->handle, acpi_scan_clear_dep, NULL);
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);

Err this shouldn't have made it into this patch

Konrad

