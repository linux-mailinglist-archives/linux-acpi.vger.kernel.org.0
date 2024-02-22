Return-Path: <linux-acpi+bounces-3845-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A296E85F5F2
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 11:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4400A1F238B4
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 10:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587AF3FB38;
	Thu, 22 Feb 2024 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOeIXNrn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A093F9ED
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598666; cv=none; b=omvrKHOfZ3G9UI8ODbqzZi4O8aS4Q21xiJ6T6r/RgBh5N3Yy+YONvF+UlU0KlbYBESeBoTqCx/yjYfy1pHlHuwzulWbPCdDEyy69YmMEmhh7R6qIvpohg3AYIx+CI/rHyElBGlHEspou9Pv3+j6mV17pux0cQTJUYtxCyluqnho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598666; c=relaxed/simple;
	bh=I8GfOfCTLZmih12aYKjE14cKV4MXTg54Oq7SR/j3eZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MS28LlaoUHi+oPCd931jzDBRcYmm2bCExoOwwUPmcXWGuNnhLSXtT2MSmuKvbD+S9zZJ4ajrSniDGCQyvna+z+n4haNtmfdqXjYk55/VLUV1wjczllfFntZOpN6en+Jdxj7sr8CO3jV8upWvi3myHKgqrLDvrZnvfQ5Gi/EhAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BOeIXNrn; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d25a7b02d6so17673061fa.2
        for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 02:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708598662; x=1709203462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiMRQBwGLj/KPIT0lE6FKUXqjnkUTGxkru+2azcnTvM=;
        b=BOeIXNrntHg88q0ztMhKZTwdp11aOLgzRPMmQ/xvzL1DiLUoyLpkJ/zYREPOF+TbJU
         jeYHjUwv7Bxb7YmN/k6Jow5ziite1pz5l3Zf2NWIUR18QaDWFSjMoexbo9xedEPzc4pi
         LMcCCLpYM2q6Wp3G0aID7yHmPQJp0EvsstAmkmvwlkuTQkFV0fM2Q/4BIhxbQeZRY3JV
         N1isLzmP+oo0W+OfUZO6CPxnu+S6Lwo314bEyQTpFU8iskpXcYfyD1kjsj+D25dy20J2
         zv7xHf4IUBj6+MkMF1hUizBe34FQDoivg/r/wbZAMEOdHSR+7RQttIUwCCIJ/pJEyfkZ
         RUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598662; x=1709203462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiMRQBwGLj/KPIT0lE6FKUXqjnkUTGxkru+2azcnTvM=;
        b=gYdFEDtXUHiTOdLbi0Ck5fEPC5kmFOaAOAB2M0cydAVy3anRXS3SsR36EjFlS9egrd
         C8kKzGmaKFwPjAJSK1qE48DA1jQEQv8r+TWhc/pkmt0cW5lfEjb7OJP3zlOfs5odlyTZ
         ELeyruX6/SeBEq2aEfJiYQCC5Vh4wwGTOF4Etl6+ZLAA2E+RTPLDO8PYTnumhARsn6eR
         jGHZ9sf1+4jSw0rUkVtWR9ZpuQpJ0eHAHoG32jLcBuiPiZXtIFifLi2JSe8ck3AwtP9k
         wkaGlkWh65MH6x5fVq3qTJxOFVFcHMRUQdKVp3R390NzkVGf2AN3qBxhWOYkOblhULjC
         Q4eA==
X-Forwarded-Encrypted: i=1; AJvYcCWApi1S80RYdMfsH9KZepfAUnOxDp9zNNRZe4I43ChLrQEEFPYbAU9vV4IVKok0qOuPlVyCJZItgXuN1PDF6essv5n+dxZdV+F7og==
X-Gm-Message-State: AOJu0Yz0sQmdA/5dM6QaOyMDyYhXIzFoR6RtUnub7kQZUNQQe3Aim7ik
	eBA6Yjj13co9BKII5lWgrtqrVGngVCjb0kzDwunkhw6AmeDsn2Dhglk+jARSnKg=
X-Google-Smtp-Source: AGHT+IFI+YXV+IbPRZDUS5Mhza+q8qDL4tfABrK7RQ5BrnppYXtMdT6C1vmAYblahRewhKdggLFw7Q==
X-Received: by 2002:a2e:870f:0:b0:2d2:4218:6275 with SMTP id m15-20020a2e870f000000b002d242186275mr6301038lji.49.1708598661733;
        Thu, 22 Feb 2024 02:44:21 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p6-20020adfe606000000b0033cdbe335bcsm20032407wrm.71.2024.02.22.02.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:44:21 -0800 (PST)
Message-ID: <d6ecb1c6-f9a7-4303-96a0-129c42eff75a@linaro.org>
Date: Thu, 22 Feb 2024 11:44:20 +0100
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
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


