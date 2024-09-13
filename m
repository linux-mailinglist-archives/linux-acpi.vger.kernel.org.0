Return-Path: <linux-acpi+bounces-8282-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C56729784B2
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 17:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B92AB24852
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3676558A5;
	Fri, 13 Sep 2024 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="A/RwjYsX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21331C2BF
	for <linux-acpi@vger.kernel.org>; Fri, 13 Sep 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240751; cv=none; b=Xz+lLqXsQXWf3YvyZV0oOCFErlub9tc80gbsCqRs1vcqpfHYJFGFm86P9cNYnJqunMbBu7Hp8cNhdk1/MK/4SGjilJOH/eAg/CYQ0E/zn1o19lri1GOwrPcSUxWkplrT4DDouJDFO4A48TKAvlOxeOTtoSHFF38ntb4SGl/Yups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240751; c=relaxed/simple;
	bh=uTyIoxx8cjMSHGUGIV4TWEAzcatuSGegYiJJ1MwWAyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uc1dSeGPb2JfGLtfDCgCmdDlpTjFhba5v4FKLrmbRFlPPBjkHDkogdbhsLoX/vRWKSVh1aRjaHAsTj93l8owEA+T0w/1uFeNU20OUKTyBbbBnT7SE+6w+lP7vJXvJPKLHgI4/VTVBcYe22PpsQ/xkPmSAsRCAY9QFcVokEl5QSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=A/RwjYsX; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id p83bsvxkw84dOp83bsbRYo; Fri, 13 Sep 2024 17:17:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726240679;
	bh=vEs0DfPjdzBgNWGqjgymjGSq4uWAwvRLJs4XJ8PAc/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=A/RwjYsXydMMgWWA5S0poMPTy5qspRrObAPkm0Dh6HR0uvd5PUfrbxRrYlCBF24Fv
	 0q1iXfH2ac1/PELoesmNUSvCobQQ6eWK5x6VQzEy2bFcgf+Gr/d1s9BA1CJ554cJ2g
	 f6ws7xSsiW2cbrlBb2300rs1ki918H1y95Lk6fz7sl4z5+bzPDXdKO3whpLbwTLNHx
	 xEYcG1m1hNngeJ7BVY1Pa6BSu5Jl51mAFPKjzJlj+4iIJN933jwh4GP9jkXZacvGps
	 49/60T3hEA0wFfhufwB/0Ubfxc4zur0G6GDnMbanY+9LhjxEMhS5UrAou3Mc+KH3Q0
	 Z4uAzGWVWxTrQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 13 Sep 2024 17:17:59 +0200
X-ME-IP: 90.11.132.44
Message-ID: <693e5874-30bb-4076-910b-feb6488e7d85@wanadoo.fr>
Date: Fri, 13 Sep 2024 17:17:58 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: thermal: Use strscpy() instead of strcpy()
To: Abdul Rahim <abdul.rahim@myyahoo.com>, rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240912205922.302036-1-abdul.rahim.ref@myyahoo.com>
 <20240912205922.302036-1-abdul.rahim@myyahoo.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240912205922.302036-1-abdul.rahim@myyahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/09/2024 à 22:59, Abdul Rahim a écrit :
> thermal: prefer strscpy() over strcpy()
> 
> strcpy() is generally considered unsafe and use of strscpy() is
> recommended [1]
> 
> this fixes checkpatch warning:
> 	WARNING: Prefer strscpy over strcpy
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> ---
>   drivers/acpi/thermal.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 78db38c7076e..a35e40976763 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -796,9 +796,9 @@ static int acpi_thermal_add(struct acpi_device *device)
>   		return -ENOMEM;
>   
>   	tz->device = device;
> -	strcpy(tz->name, device->pnp.bus_id);
> -	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
> -	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
> +	strscpy(tz->name, device->pnp.bus_id);
> +	strscpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME, MAX_ACPI_DEVICE_NAME_LEN);

Why the 3 parameters version here only?
Is it needed?

CJ

> +	strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
>   	device->driver_data = tz;
>   
>   	acpi_thermal_aml_dependency_fix(tz);


