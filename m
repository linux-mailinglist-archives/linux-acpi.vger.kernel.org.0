Return-Path: <linux-acpi+bounces-3846-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D7C85F603
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 11:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59551C23B67
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9553A22099;
	Thu, 22 Feb 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tplJAyO8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B533FB3F
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598858; cv=none; b=INH8MaSYcJEJ5RwanmtYCHawJHptbQzwGOrFeLbNVDc6dMB9SvyHU2twPIVnh6bQFisS1ckp39+kOUC8GOTBnCyZNH76NG2IDP3FCE4URq9pqDSjbaNFWQuyQrnSnBClSD7HYd/3nogu4xGfTiliA4vl/vBnDH30OscdsIBz/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598858; c=relaxed/simple;
	bh=3zP/VtA1AgtaTaQw2U6AxyLni4JwLiOiv99igy1cVDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JabsGLaHjRNLx3HMA3pgHGQNfOX9gMqaCOLPrGe9NrUcHQri0q7A7nRTK3gK1IN17rCPOm8l8wRIAJmNsesMxx7+PvWf115y8LpQnV1d8YoEpHM8Odlwsx87UL6NWf7d5/mwdTjTYdcXJnphOfqPaQR7qx6FI8Isj/dgjwVm+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tplJAyO8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33adec41b55so3966117f8f.0
        for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 02:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708598855; x=1709203655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5aqpcdx+kqPsDksMwy3/1ZpsNRD3e+cH+lqKOGDH4SU=;
        b=tplJAyO8ImuOx31ipVmS25WlR0yZtap78n7NHrgNzYv5S3HdVHA72P3W2jhEvVUUmz
         e62zXAIXW9p5yY5kG60AEnjenkHxaTX9fao7uHfOzd9uPaqrWIQaiVuHfK9TBtied5Ju
         +uSUyCiTpqKFsPwLu0GtqXzPYBmrIVFrCnDUUwRBG/vg+7BG4BVs3FDVhnrACM/hyES4
         E7AJxiZg9ZsAEHAL3jeskg+eYqIDOGGAy6Wlwz3FdEiAtahWNy9ueiFpUIvYL0hdJO1W
         B3UpIUv0X1q5SXXe7a4K/cWP44JvQX60MZQpSJ2lDhY3MCVHub60iVPCSOKR2uaRT5k4
         Psag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598855; x=1709203655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aqpcdx+kqPsDksMwy3/1ZpsNRD3e+cH+lqKOGDH4SU=;
        b=diqReKMQWunc2qdIYa2+d5/66JRDMO76EWq9gWy1OVNAEdoCyGgCT5MPgPHeq2EwtW
         j3zMpOgnwwY61HWKMarBliLPpbeaNTQWe6s7QI4iV9/t4//fgwP7vVs4mAo+M8HlC8uW
         Ym/AM+DoYB1xtWIY4mmsJRE0MnlhE0CkUqiTNWBMafCYK7Bz76tXR98i0yHs5wKDJTQV
         5Qyb8c2zzQD89JWsVYbzJIxunF39X7SOO4AkVgK9cGmwllMtsl+y3oRYqJQjCn1S4VUc
         h60lVq1rg28LTv8pKj1X2BAnwxUOQllaeQMaEcubUgqy+lPGAVhqqsIbEvMPL5WrXVj/
         PbGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrydzWVZGYWNvCRDBY/Sa30UA6PI5IjbA3mNMOR0YH3Xkg0PN6lXbWpasNv62tAnbk3ykW9Tnchs/XQ/jd/XF5q4mStMNQ8Io3CA==
X-Gm-Message-State: AOJu0Yw1WFWqjwfOzcqWqg6C22ZSKr2/+bcIu5P0mb7RPypGtC7FqYg7
	qfmn5hXS0Mouw+o8+d2K3cs4qVy8lcfpHrVs8m5O43iP0L685ImSJNGyjfNqC2o=
X-Google-Smtp-Source: AGHT+IGs1kam3tuErV0BZMvW5Bv5dj9iYPqaMk+UBtUuUvBtTpsPOm3+SsvB5+lg6Z2no0OLjEXKYA==
X-Received: by 2002:adf:ec4a:0:b0:33d:82c2:ad8d with SMTP id w10-20020adfec4a000000b0033d82c2ad8dmr2582908wrn.56.1708598855237;
        Thu, 22 Feb 2024 02:47:35 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bo29-20020a056000069d00b0033d5f5571b4sm11278754wrb.44.2024.02.22.02.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:47:34 -0800 (PST)
Message-ID: <ffa37950-d850-44e2-a33e-837466238d6d@linaro.org>
Date: Thu, 22 Feb 2024 11:47:34 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] thermal: core: Store zone ops in struct
 thermal_zone_device
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
References: <4551531.LvFx2qVVIh@kreacher> <2262393.iZASKD2KPV@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2262393.iZASKD2KPV@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 13:45, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current code requires thermal zone creators to pass pointers to
> writable ops structures to thermal_zone_device_register_with_trips()
> which needs to modify the target struct thermal_zone_device_ops object
> if the "critical" operation in it is NULL.
> 
> Moreover, the callers of thermal_zone_device_register_with_trips() are
> required to hold on to the struct thermal_zone_device_ops object passed
> to it until the given thermal zone is unregistered.
> 
> Both of these requirements are quite inconvenient, so modify struct
> thermal_zone_device to contain struct thermal_zone_device_ops as field and
> make thermal_zone_device_register_with_trips() copy the contents of the
> struct thermal_zone_device_ops passed to it via a pointer (which can be
> const now) to that field.
> 
> Also adjust the code using thermal zone ops accordingly and modify
> thermal_of_zone_register() to use a local ops variable during
> thermal zone registration so ops do not need to be freed in
> thermal_of_zone_unregister() any more.

[ ... ]

>   static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
>   {
>   	struct thermal_trip *trips = tz->trips;
> -	struct thermal_zone_device_ops *ops = tz->ops;
>   
>   	thermal_zone_device_disable(tz);
>   	thermal_zone_device_unregister(tz);
>   	kfree(trips);

Not related to the current patch but with patch 1/6. Freeing the trip 
points here will lead to a double free given it is already freed from 
thermal_zone_device_unregister() after the changes introduces in patch 
1, right ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


