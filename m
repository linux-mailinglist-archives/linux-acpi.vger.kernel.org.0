Return-Path: <linux-acpi+bounces-10722-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC97A13942
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 12:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894E03A2FC3
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 11:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8905F1DE3BB;
	Thu, 16 Jan 2025 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mj2Qv8y8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B31DE2B8;
	Thu, 16 Jan 2025 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027549; cv=none; b=YcfIbznkR/jIT3pWJDoqXxFCC+EHtxOrVVJ3/kIZsmBm+z0Rb1awU1xpXTdqTIgbRT/VTSes0nTuonxsevpfO/k1NQWqW2zJZrb5flxDEpYZP7ElksblPpzGli/VPjUhsDk7AoHV8fpG731t2f6i6qSxbkwCtRXllXnRqQRrmQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027549; c=relaxed/simple;
	bh=iXmKHxfX3cmFNPMxlw03hBHLwxLoJ6KyqJxiZQT+cug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmUg00+C31gCKEaV3GZ5WmuGyJEy6q5h5PqXWhAFudim5NRXJNmaBTgTD2qkXHyodOJnFtFZuKV74eoBXHAMv1CGI4svuFFoAckxS9y5tTyk+SsVXdB10MYK/TeeSxiP3Tv7vch76/Nia4GI23OMiRac4JdWsspJCjR9a/c2CdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mj2Qv8y8; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eb6b16f1a0so293090b6e.3;
        Thu, 16 Jan 2025 03:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737027547; x=1737632347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeyrR5zpiHrATXOHkGinrudHepB19bo1wvgd9FNzEGY=;
        b=Mj2Qv8y8Gj1JJSzXe/kfGc4rfMt0b8Ln8cNUF84MxiiY/LJdPqYLXiv774xPtjVbz1
         25N2BzCbx8FeB42P0TYxRy5QSEoK+ql7Pf4N52VU2W5Grt4eocLOfZPhI7EivJmor8yv
         mS808xou60oTQ8jqhcMYqAn81IQGcinkN63inW2OqIOlTDPsXnsTMxuGtpFxEgsLjond
         WOdYO8naea0NdrzDgG1ebkjY1BGsN2cbb7jFFWYlS6XyQk3kleHNA7mNa+bNu8hCIruA
         6esBzejoxbITf4ZBjiMBxDrTHdmapXmKla4XV29iW7Zwat8TrdudpkA0HEmvCNZWwhKi
         0eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737027547; x=1737632347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jeyrR5zpiHrATXOHkGinrudHepB19bo1wvgd9FNzEGY=;
        b=KWgtTlVMyGnwtOjtA/qDAvwGGKQG2iM4aMXn0Eox8O6Djb+KL6Gp4y2KefZU2IzZur
         M93d98BKErV8bIOB6A1FHGMyRu3+wRg9csy9J6rGVW9ngsuU3Gw/48N8b+Pffu02YByj
         eGUvX3Fo7BmitF+K/vdg0kv08W7IRVpUzhQwGxXAF5H1ars336pD/5av0RHOg9BdzXTy
         5Y8TCg0XYRJQg/8Bln2DSdJuv3hVxaSITcOCO3p+5ZXwtmJ49cledR7reJ3nFTjn+Mrt
         iLdNrQW3KFQRcU11CfuuWj9KER5q4H2K4FUwBRAiHeNohQQ6KE8lsOtMh4aif8+EaSpJ
         dt2g==
X-Forwarded-Encrypted: i=1; AJvYcCUVR17+/Tb5oP7ZIUJW3LxaYgNCiLrYFcuko8jw8CTvEu885+EDpOWAw1VTnOSolePrAL8VOHDAU+Q=@vger.kernel.org, AJvYcCVyVrRrA7HJatL35UgvZ43wPrOQLUtQb8utszvgvkiiUfoJve0jDNsjx0O/o+92HhGSTcA8XoNqKSug@vger.kernel.org, AJvYcCXMG4ANdX963TVfAdy7Vbaojkg7pL1/sLRxrq/6f7i0A48ubtFZNKzMQxrtycAT6S7o2WXQOc3EAyV1W4OG@vger.kernel.org
X-Gm-Message-State: AOJu0YyTtRwqtP+MDRCsIJhXht+Gr8+5cskbb11I5LOcYF2pNA6sZnve
	IiwSeTbEbVMnyBEWKZuYlAQ8ukzu1F64ddnMf/UN5JDgsoroxQPG
X-Gm-Gg: ASbGncum1oUIpJko+v3/LxW48dOJRYpB91taWSsMmHwxvBovZPlGG21psEOew3Iywfp
	8tH6phzuoU0uqbTrXI3MAhm+4qP9HY6BsSw14jfPjE8THaL9OVbLs0VpunQO1XeP21dS1dJzPM7
	E3fXIk369iro+k1+vWZ/2h6OHj3e8arZdEIlvD1/o2nuAHnJgfuQk5VlkNw70cj65ww8VKEJh+f
	kElaJ3KtOk/B1ywEXUIR8iy4IpiNPUyT+ylknct9Q0RoR3fC3wtooqNEF6MYRdXF440o+JS
X-Google-Smtp-Source: AGHT+IEFdGmDTMKc/IfH1eYMsdUc7ecJvD67ozxyMeX4N9BgwSLyzX9rNJ11UDGdAfFp96tFY1vrhQ==
X-Received: by 2002:a05:6808:2006:b0:3eb:58b0:ac6f with SMTP id 5614622812f47-3ef2edd1da9mr15803241b6e.32.1737027546868;
        Thu, 16 Jan 2025 03:39:06 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2ad8059e39esm7285526fac.31.2025.01.16.03.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 03:39:06 -0800 (PST)
Message-ID: <21654032-a394-4da9-8ee9-d7cb9df8c855@gmail.com>
Date: Thu, 16 Jan 2025 05:39:04 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 lenb@kernel.org, robert.moore@intel.com, viresh.kumar@linaro.org,
 mario.limonciello@amd.com, gautham.shenoy@amd.com, ray.huang@amd.com,
 pierre.gondois@arm.com
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com,
 hepeng68@huawei.com, fanghao11@huawei.com
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20250113122104.3870673-7-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

I noticed something here just as a user casually browsing the mailing list.

On 1/13/25 6:21 AM, Lifeng Zheng wrote:
> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
> driver.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
>  drivers/cpufreq/cppc_cpufreq.c                | 109 ++++++++++++++++++
>  2 files changed, 163 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 206079d3bd5b..3d87c3bb3fe2 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -268,6 +268,60 @@ Description:	Discover CPUs in the same CPU frequency coordination domain
>  		This file is only present if the acpi-cpufreq or the cppc-cpufreq
>  		drivers are in use.
>  

[...snip...]

> +What:		/sys/devices/system/cpu/cpuX/cpufreq/energy_perf
> +Date:		October 2024
> +Contact:	linux-pm@vger.kernel.org
> +Description:	Energy performance preference
> +
> +		Read/write an 8-bit integer from/to this file. This file
> +		represents a range of values from 0 (performance preference) to
> +		0xFF (energy efficiency preference) that influences the rate of
> +		performance increase/decrease and the result of the hardware's
> +		energy efficiency and performance optimization policies.
> +
> +		Writing to this file only has meaning when Autonomous Selection is
> +		enabled.
> +
> +		This file only presents if the cppc-cpufreq driver is in use.

In intel_pstate driver, there is file with near-identical semantics:

/sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference

It also accepts a few string arguments and converts them to integers.

Perhaps the same name should be used, and the semantics made exactly
identical, and then it could be documented as present for either
cppc_cpufreq OR intel_pstate?

I think would be more elegant if userspace tooling could Just Work with
either driver.

One might object that the frequency selection behavior that results from
any particular value of the register itself might be different, but they
are *already* different between Intel's P and E-cores in the same CPU
package. (Ugh.)

--
Thanks,
Russell



