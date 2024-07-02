Return-Path: <linux-acpi+bounces-6747-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAAB9248BB
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 22:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FCFFB21383
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 20:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644F31D47DB;
	Tue,  2 Jul 2024 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="DRKq6Hr8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out.smtpout.orange.fr (out-15.smtpout.orange.fr [193.252.22.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0C1D363F;
	Tue,  2 Jul 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950776; cv=none; b=nHax+1YSl6NBviUFGZyR5pel2O2/WFJuxV8kchuUSmGUvM3YfZGbiJv6Q1T1z208TBBY578vVgHupzk7eMUanVs/6x2/EBkwk7Gqpqdywb8XnW1VdZUHAujRVi4REubouvTVjeiNF8V0z1QQQ2cdC03xRp7StPhLoH9hncCVFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950776; c=relaxed/simple;
	bh=HYgHf45maMm5vC6jU2kAxdSVSaDqUHvOwfljxjzEybA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mMTd8RE1V2HfU8l0VeS39sKVf45WzG67QGsaCAKF+IBY15xKkvn8i4Jlj8sh3yRZvqhomFIym54TcHPUqAKYo8LLJzZF3HDTqmGvPO0qE6vF5tZ73sa2Rt8iQega79iAOIvkEjvHKp3pHCGYVqdQUveEMeb7JeYglu/zasmw838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=DRKq6Hr8; arc=none smtp.client-ip=193.252.22.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id OjC0sb4vkwcAuOjC1sg3t4; Tue, 02 Jul 2024 21:29:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719948573;
	bh=kghFvL0qk69v98trETzF8z6G4zKMGUUWfQe6WfzbKgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=DRKq6Hr83ccpP3ZIKudTuLY7mxLy11hKph0yOrABP9GGFPdJOClST0Gg+76BmIGXz
	 pXadtMZuExpuYvUT4i1HMQArLZP0/joZzIXhGrPL531f5W3nRvxK/+/y2OfXU3WCMg
	 GSjW52SVKv5FO0xeSY0JmB1xu7v1zSjoYIVdfsWQ4i/xNtt0L1vmolS1uEv1jvBK4x
	 iqxzQkN5l6b4bZJXDwsBXci1F+yWChEcOBjzKPDnbXn6bcg8CxyoH9VN/0Cu9tv2g6
	 rEHU29nmyyAmtH9/jCTy44XiTm30Opd8L9ItTd0qYoFumBYhqjCZOkMwq28An0NXmO
	 63Z9LfGQ/5JwQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 02 Jul 2024 21:29:33 +0200
X-ME-IP: 86.243.222.230
Message-ID: <8f2284e3-bf6b-44ff-b34f-9512b1155542@wanadoo.fr>
Date: Tue, 2 Jul 2024 21:29:31 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Updating a vulnerable use of strcpy.
To: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>,
 rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240702185523.17716-1-qasim.majeed20@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240702185523.17716-1-qasim.majeed20@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 02/07/2024 à 20:55, Muhammad Qasim Abdul Majeed a écrit :
> Replacing strcpy with strscpy and memory bound the copy. strcpy is a deprecated function. It should be removed from the kernel source.
> 
> Reference: https://github.com/KSPP/linux/issues/88
> 
> Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
> 
>> In what way exactly is it vulnerable?
> strcpy is a deprecated interface (reference: https://github.com/KSPP/linux/issues/88). It should be removed from kernel source.
> It is reported as vulnerable in Enabling Linux in Safety Critical Applications (ELISA) builder.
> 
>> Why is a runtime check needed here if all of the sizes in question are known at compile time?
> Runtime check has been replaced with compile time check.
> 
> ---
> v1 -> v2: Commit message has been updated and runtime check is replace with compile time check.
> 
>   drivers/acpi/acpi_video.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 1fda30388297..be8346a66374 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1128,8 +1128,8 @@ static int acpi_video_bus_get_one_device(struct acpi_device *device, void *arg)
>   		return -ENOMEM;
>   	}
>   
> -	strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
> -	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> +	strscpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME, sizeof(ACPI_VIDEO_DEVICE_NAME));
> +	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS, sizeof(ACPI_VIDEO_CLASS));

Hi,

for that to work, shouldn't the size of the *destination* buffer be 
passed, instead of the length of the string we want to copy?

Not tested, but the 3rd argument of strscpy () is optional.
(https://elixir.bootlin.com/linux/v6.10-rc6/source/include/linux/string.h#L87), 
so maybe just:

	strscpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);

would do what you expect.

CJ

>   
>   	data->device_id = device_id;
>   	data->video = video;
> @@ -2010,8 +2010,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
>   	}
>   
>   	video->device = device;
> -	strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
> -	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> +	strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME, sizeof(ACPI_VIDEO_BUS_NAME));
> +	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS, sizeof(ACPI_VIDEO_CLASS));
>   	device->driver_data = video;
>   
>   	acpi_video_bus_find_cap(video);


