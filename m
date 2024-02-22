Return-Path: <linux-acpi+bounces-3852-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F8285F679
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 12:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73CD1281F18
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BDE3FB3C;
	Thu, 22 Feb 2024 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="poKh/tGv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4605E3FB1F
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599978; cv=none; b=AHE+/QGAqTB8xD7r6w80E2SKQuKDTe3vO4JsvE6N0WMo5B8zLhcm3yjLU8cSnLgMHi/wsYsGkkUbUuSkR7IKpIvSmdYmLqPmJWrBpxSY2YIZsRJ6k7UH/XDiWgO1vQeZnVLuNSAkvkfqVdiLzuHvybKCG3vx4fAL+i8AqBBakR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599978; c=relaxed/simple;
	bh=eUO2pULCAOjDoFdOGE3rfjqQB4Mduld03rcv2+usukY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzsG/sVIWgf4ko0WS4Dy1+wluZcldXsoSULEkEFkXvOCCxxnbkUE1u2HZbUgIbUnsmzmaaau/ipY7dDgQuDlM4ztWoTpbmxySF+6Za5kaml1FtR4homAI1cJ0vteEeQnPsGB3/KPNi+8PSCaAkgzFlcKJViDtDIhHGGAFARr8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=poKh/tGv; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d2305589a2so19705101fa.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 03:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708599974; x=1709204774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMIMrYAG8AdHEKxeFmFBefuPoTIONeLm4jsBhqGprBA=;
        b=poKh/tGvzzPbXLXnVfTfwH+Z/8KfF3n9tNdhaKqE0Yc/3ffMfGrBhakNh9ujnrWHgV
         3cfsThy0YIWiPvdjOS/jB8t2ITESXQIVGoGW7hTrjXyFLtxQE0Wf+qY7oxUxDCoOqxRi
         Gss0QbYe+3uEOvs4uQ4+CkGFHKF7jxth9BNSWCMPb7VsFOoazLrKIXg/65K3yFl6+Hvg
         1rtb/iOIT2EmlKRF/Ies+61J1MgUreuwi9hG+3rRGEIYuUslR+1ldlwkuvG0M2vSip6b
         z/g38Hu+x30h1EL+wOqZcg64/r4ar6GZsqcyHA9/EwcPzuvnpvxiSpJ6vvpmCb9gbY8c
         4f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599974; x=1709204774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMIMrYAG8AdHEKxeFmFBefuPoTIONeLm4jsBhqGprBA=;
        b=DBFj1qx86MiHDjG13ji8QMMZ4VT/CSA9S16jJXfUGSLVQ9wUlsFJL6agq6o6TU8qCU
         04hElDdhsORpoyitw/TQWXrEO90pZfN+EFN3DqZoSUzCgybCXiCt+yzPi1jaKkgN7lIm
         OwtncZaWD8xsIdEx1/Fnj4M0Z90Pzjatlq20ANuQzv08oTAnUKqwx+IsPoi9FAIslS9y
         bp/R5oJ0hyYa4EoGSw7JitwWYGx2fmEZ4IHjd2n9c5+DjH5mlInEQVWNm6uRVjwinvcK
         0MqhDXskrXDK2hWyzoFECwGLW2SMjUXoFH9rBgDCaPqVS9FvCEj0+ee6tPpdRR48XAJE
         z/Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVhkGM6vtt7u1f8+CLjEPIWpUxex8RQbZ0kpv9+R7yceBRUZB2jYEX3DlfwKprszt7ipVHj1qXjRbRsKFpXgj0Vnteakx1WE19i8Q==
X-Gm-Message-State: AOJu0Yyc0dSEnZGLblM7t5qBH3I0in0Bb2sy1hPhL8zQDQHaPOtrk19V
	phaMIwSKH4Yaw99ooKiHmmHVAVzetGOkXDlOy5TieIR49b2/jlZnRJsjc2jSbhY=
X-Google-Smtp-Source: AGHT+IHiLSfsaDdgn2k5rjMUiJNduHZR3YSa1xmVy7cLP8thmp4ILrPRdvUpIp7j6hHay03gDR5OLg==
X-Received: by 2002:a2e:92ce:0:b0:2d0:b27e:2437 with SMTP id k14-20020a2e92ce000000b002d0b27e2437mr13380930ljh.39.1708599974326;
        Thu, 22 Feb 2024 03:06:14 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d2-20020adfef82000000b0033b75b39aebsm19978761wro.11.2024.02.22.03.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 03:06:13 -0800 (PST)
Message-ID: <4dc3ee0d-ca11-4574-a47d-8d9aed83e31c@linaro.org>
Date: Thu, 22 Feb 2024 12:06:13 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] thermal: intel: Adjust ops handling during thermal
 zone registration
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
References: <4551531.LvFx2qVVIh@kreacher> <3213551.5fSG56mABF@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3213551.5fSG56mABF@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 13:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal zone operations are now stored directly in struct
> thermal_zone_device, thermal zone creators can discard the operations
> structure after the zone registration is complete, or it can be made
> read-only.
> 
> Accordingly, make int340x_thermal_zone_add() use a local variable to
> represent thermal zone operations, so it is freed automatically upon the
> function exit, and make the other Intel thermal drivers use const zone
> operations structures.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


