Return-Path: <linux-acpi+bounces-3863-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E36E85FCAF
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 16:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE34E1F2677C
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 15:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5104B14F9E0;
	Thu, 22 Feb 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="prTh+oj8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5514D443
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616401; cv=none; b=dxEf6EuqmqgH+Q7YD6BmVPdqemCLs6XJfPruUR5KYmL1XrQPsoaYOAHQ8MkVWU8GXqZo6yHoQWDRuaEDsHrqiBN/Jr8CDquv20bIf6BbfHJzXlaTUhazMkxTR02A1wk2vO5p0zNp4p3empNimDoawhXQ0mWmeGgeqzkAlZyyl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616401; c=relaxed/simple;
	bh=irUaaTgSHl9McK+IT2Ipld7BjAvthbn+fFnbtiJW/dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfXL2IXgC4JmWsXHhhLLAHhGJBdEkGp/r64zzyvnj3Lo27mahNM6ag/kRxNxlfgRLFAL9stK0oLbpewrZQ8m9995PicTLvbxxuQLOwKoe40a1a70LEB8AmZqE3dSRhQcZhTXVd3/SBmjQvEHOPzmxj1JFCd2dmC01G6hHpBhgZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=prTh+oj8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512b84bdaf1so5896071e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708616397; x=1709221197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c1npCLJELsPSC1JsXp5VaFpN9TsOulzmiEht9MHB0lk=;
        b=prTh+oj83tNb8/rX1g5my1Cv2cx4hoVfk1RyWnVChP8jt0Diog2uFzZDeNQBlpcRHn
         HPbKkYZaBUJWX5vo9k8ay8dW0A1DhGP9PFbuL7iaGv4S6qdWADLvX/aB+T4JtC76HvrE
         OFTxb55rM5Ke1hUpMk/IT1bxs9n+/w/JRqVSF/w9bA3isnW/oifNhomq6uvWWnbQkhU3
         RgY4PNLZ8pNhi785w532Y/9mNcm5zVYmBtVg+dkUFMe48eIHO4ND8yw2gAWk2RTX9r2z
         CruoXDNG5XmOJC30hkNkVR4t4aGAYyZfMVx0JMLUvDS5u/o/KKT7W74lMhMx15P0yGJS
         j1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616397; x=1709221197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1npCLJELsPSC1JsXp5VaFpN9TsOulzmiEht9MHB0lk=;
        b=jlvDvyQx8IWTRJTP3WyQIUWJMj7RNBIU6Wp37rIpxBbShIVT9CIbpqCwbMMuRVPbk0
         AdhMBwXgmk66kicKT4LuSoIjnURvGVXhxf4u53QKI+7/WiZBKRBoR6xfEVnWMSt7T6rr
         OpgNsAqMBCbUrrKDHpOO6U0tpmOnIku9nyIrIMl5QIqFCEvjpdBPTM6i7DyO7d5qwyd9
         69zvN/Wl6BjHvhB6J3j8k0Rse6TZ7IVY6A/+niuOJWEOCuvOjLC3WVTp08vh6mE/tqhQ
         Os7wTT466fbwpDAdk2PKR9rMUufW1TpHLABp/7WZqf/Gmtw4o6EsOiYQMCDZvRt5d5eG
         YsbA==
X-Forwarded-Encrypted: i=1; AJvYcCWD2J63QSA2Hx3FpnI4h6+/dkc8AMN1hCOBiUrqQ7q+QbPgSzIlhWLWvytLP2GynTVQyvbaL76jZi38IWOX4UQl3A1NwQrh22Ss9Q==
X-Gm-Message-State: AOJu0YwuN5YPKUusrNBTtLA6/UsBWNEt2vtkAHfUPJol5XmHfR/wFUly
	hJ0EgcQlE585omTmQoy2++eKB7wrPNl7x8E8c5NQNajeYll2Qzfsrs+OoJCubd8=
X-Google-Smtp-Source: AGHT+IF5oA+zj1hJdLGm59l4SglX5mVSDyz7ZtNxq7Z4/wQ0vArID2KuXJIuLjHr2LPtjtbbTxicyw==
X-Received: by 2002:a05:6512:3d8d:b0:512:be44:656f with SMTP id k13-20020a0565123d8d00b00512be44656fmr8689020lfv.63.1708616397318;
        Thu, 22 Feb 2024 07:39:57 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id u11-20020a5d468b000000b0033d4adb3ebbsm14270878wrq.26.2024.02.22.07.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:39:56 -0800 (PST)
Message-ID: <4eda4893-8db5-47f0-8566-ecf379e987c7@linaro.org>
Date: Thu, 22 Feb 2024 16:39:55 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2.2 1/6] thermal: core: Store zone trips table in struct
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
References: <4551531.LvFx2qVVIh@kreacher> <1883976.tdWV9SEqCh@kreacher>
 <12406375.O9o76ZdvQC@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12406375.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/02/2024 14:52, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current code expects thermal zone creators to pass a pointer to a
> writable trips table to thermal_zone_device_register_with_trips() and
> that trips table is then used by the thermal core going forward.
> 
> Consequently, the callers of thermal_zone_device_register_with_trips()
> are required to hold on to the trips table passed to it until the given
> thermal zone is unregistered, at which point the trips table can be
> freed, but at the same time they are not expected to access that table
> directly.  This is both error prone and confusing.
> 
> To address it, turn the trips table pointer in struct thermal_zone_device
> into a flex array (counted by its num_trips field), allocate it during
> thermal zone device allocation and copy the contents of the trips table
> supplied by the zone creator (which can be const now) into it, which
> will allow the callers of thermal_zone_device_register_with_trips() to
> drop their trip tables right after the zone registration.
> 
> This requires the imx thermal driver to be adjusted to store the new
> temperature in its internal trips table in imx_set_trip_temp(), because
> it will be separate from the core's trips table now and it has to be
> explicitly kept in sync with the latter.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> 
> v2.1 -> v2.2:
>     * Add missing kfree(trips) to thermal_of_zone_register() (Daniel).

OK for me


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


