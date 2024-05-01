Return-Path: <linux-acpi+bounces-5551-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA778B88AB
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 12:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D38C1F2169C
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743955E75;
	Wed,  1 May 2024 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezNcIe1G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2754780
	for <linux-acpi@vger.kernel.org>; Wed,  1 May 2024 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714559626; cv=none; b=dBleGNwO1wjyTZO194THwpqIZfej5+PS+GOdcD45+YhzKj5nFpCgjSePjPhG3tocDDOw0SG6enUPT0yAKrY7TdVzSQyZmcQHb+nb5q1QRhysiHgF/CTejFedXaRSVGfJp8CaxiZttmF7vkHAEuCiCzEVj7Fv5ePP0t7JJDYgK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714559626; c=relaxed/simple;
	bh=QNBtujc6UZHL1288knXMhnVLCejZtwYmy6UxhheX4dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ua5h+x+wieVM9Vj6G/DMso0Uwh1JL+dpKDrfPRntiPVE5sFcKu07iiqVqeL93gE5l9OXxU0nOvu4qgkvptdetmGWZpRbUSGk5nm4E/XAh+QN9zt+c4gJrtFN8+L26UGKkfjM1INN7M/tz5kp0TTLpsffPaSqMab9eDQd84F17JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezNcIe1G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714559623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3Rv6xRyLMIQbC6pPBDmGwewvdeX7X4Yb9g/5DiEGHE=;
	b=ezNcIe1GDwoobN/TjDC9bceTpqsk/vEOe0hEOWvBEXA9KK9P/U19PjVCzxZtvNjMUHfqXf
	n7qeAa4E+XYMYvGIovqtVjHx40SpSnA2s/fHDjhQUYP00zncMrO02vM0kdTM8Z2aBgETKy
	Yt4CDNu9EXbMe0gtgvU+Tc7Jy8p1zNw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-R2QXHdvEM_GsjoAd1pUpWw-1; Wed, 01 May 2024 06:33:40 -0400
X-MC-Unique: R2QXHdvEM_GsjoAd1pUpWw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b35b8a9feaso77649a91.3
        for <linux-acpi@vger.kernel.org>; Wed, 01 May 2024 03:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714559620; x=1715164420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3Rv6xRyLMIQbC6pPBDmGwewvdeX7X4Yb9g/5DiEGHE=;
        b=g+AJKJMpCVnkSEysKknSbV/MEqaXTqa+FE34i3ZDhg8DmBHr//GAr2j1gM24OIi2v5
         gcrLdo7vxYFXsGkPj++6JjxmX5uclrvubHVrflCtjzwnrg2yduZoy13aIbMaoIcJfn+1
         4bGWQ4qAZb+Q2dwf71ktfrQlktTHWHCy/v9kubeYxqowUpGe8GeX9gzyBts4W7Tr7rsB
         khqP5KYSkdCuDxZ7CDJ+c1U7emxxQucdWU9kaYMzw8s0s9Uc9u351BAWwOB3LMNsy8Dv
         qSzd26hvKNHclVSHigNzDn4LSF+KKgI6A1oROzG//kDL6K6wysNxf1ddkqmWnD+nlvaW
         1XjA==
X-Forwarded-Encrypted: i=1; AJvYcCVW47Q5YDSAM6HI8rwIhDDONpz624wzzNf8KN1Yfuk9d6pXVQyPvdNqvrb/M8mRMXcVl/ygZcTfxzeBn6uByC2vHu7dNeXz7BpQ4w==
X-Gm-Message-State: AOJu0YxaYu/G2AC3LND3AWZ72frExn78WSGjoFrB3Bg+MdX3QxNVMP+r
	UzAjwoGleWJubSf8nFd7PI6ZQf64QL1KCa5KZmLigK5kQiW57JTaMKje674ScKXDM27MduDBNdm
	wCJ9yn44v6gl9x6mYHEqw/PDb9syRIYxYf3DD/Ex2a3/ujWzX4t7FPpTzVFY=
X-Received: by 2002:a17:90b:4a87:b0:29d:dd93:5865 with SMTP id lp7-20020a17090b4a8700b0029ddd935865mr1797772pjb.46.1714559619356;
        Wed, 01 May 2024 03:33:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcfTC4aIqvKn1VZq3qSHCehrwat0aEX2lF7QcvX+Yac+3lmzVjHEcywM51wkm9Rg51LzaR3g==
X-Received: by 2002:a17:90b:4a87:b0:29d:dd93:5865 with SMTP id lp7-20020a17090b4a8700b0029ddd935865mr1797745pjb.46.1714559618837;
        Wed, 01 May 2024 03:33:38 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id sz15-20020a17090b2d4f00b002aff85b97dfsm1057594pjb.27.2024.05.01.03.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 03:33:38 -0700 (PDT)
Message-ID: <0febde44-99f1-48ba-a233-78b9a32468da@redhat.com>
Date: Wed, 1 May 2024 20:33:27 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/19] ACPI: processor: Move checks and availability of
 acpi_processor earlier
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, Russell King
 <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
 <20240430142434.10471-7-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> Make the per_cpu(processors, cpu) entries available earlier so that
> they are available in arch_register_cpu() as ARM64 will need access
> to the acpi_handle to distinguish between acpi_processor_add()
> and earlier registration attempts (which will fail as _STA cannot
> be checked).
> 
> Reorder the remove flow to clear this per_cpu() after
> arch_unregister_cpu() has completed, allowing it to be used in
> there as well.
> 
> Note that on x86 for the CPU hotplug case, the pr->id prior to
> acpi_map_cpu() may be invalid. Thus the per_cpu() structures
> must be initialized after that call or after checking the ID
> is valid (not hotplug path).
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v9: Add back a blank line accidentally removed in code move.
>      Fix up error returns so that the new cleanup in processor_add()
>      is triggered on detection of the bios bug.
>      Combined with the previous 2 patches, should solve the leak
>      that Gavin identified.
> ---
>   drivers/acpi/acpi_processor.c | 80 +++++++++++++++++++++--------------
>   1 file changed, 49 insertions(+), 31 deletions(-)
> 

It would be nice for acpi_processor_set_per_cpu() to return errno,
explained as below. The patch looks good to me in either me.

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 16e36e55a560..4a79b42d649e 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -183,8 +183,38 @@ static void __init acpi_pcc_cpufreq_init(void) {}
>   #endif /* CONFIG_X86 */
>   
>   /* Initialization */
> +static DEFINE_PER_CPU(void *, processor_device_array);
> +
> +static bool acpi_processor_set_per_cpu(struct acpi_processor *pr,
> +				       struct acpi_device *device)
> +{
> +	BUG_ON(pr->id >= nr_cpu_ids);
> +
> +	/*
> +	 * Buggy BIOS check.
> +	 * ACPI id of processors can be reported wrongly by the BIOS.
> +	 * Don't trust it blindly
> +	 */
> +	if (per_cpu(processor_device_array, pr->id) != NULL &&
> +	    per_cpu(processor_device_array, pr->id) != device) {
> +		dev_warn(&device->dev,
> +			 "BIOS reported wrong ACPI id %d for the processor\n",
> +			 pr->id);
> +		return false;
> +	}
> +	/*
> +	 * processor_device_array is not cleared on errors to allow buggy BIOS
> +	 * checks.
> +	 */
> +	per_cpu(processor_device_array, pr->id) = device;
> +	per_cpu(processors, pr->id) = pr;
> +
> +	return true;
> +}
> +

I think it'd better for acpi_processor_set_per_cpu() to return errno. -EINVAL
is returned if a mismatched ACPI device is found, and 0 is returned on success.

With the improvement, the callers needn't to translate boolen to errno.

>   #ifdef CONFIG_ACPI_HOTPLUG_CPU
> -static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> +static int acpi_processor_hotadd_init(struct acpi_processor *pr,
> +				      struct acpi_device *device)
>   {
>   	int ret;
>   
> @@ -198,8 +228,16 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>   	if (ret)
>   		goto out;
>   
> +	if (!acpi_processor_set_per_cpu(pr, device)) {
> +		ret = -EINVAL;
> +		acpi_unmap_cpu(pr->id);
> +		goto out;
> +	}
> +

If errno is returned from acpi_processor_set_per_cpu(), this chunk of code becomes:

	ret = acpi_processor_set_per_cpu(pr, device);
	if (ret) {
		acpi_unmap_cpu(pr->id);
		goto out;
	}

>   	ret = arch_register_cpu(pr->id);
>   	if (ret) {
> +		/* Leave the processor device array in place to detect buggy bios */
> +		per_cpu(processors, pr->id) = NULL;
>   		acpi_unmap_cpu(pr->id);
>   		goto out;
>   	}
> @@ -217,7 +255,8 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>   	return ret;
>   }
>   #else
> -static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
> +static inline int acpi_processor_hotadd_init(struct acpi_processor *pr,
> +					     struct acpi_device *device)
>   {
>   	return -ENODEV;
>   }
> @@ -316,10 +355,13 @@ static int acpi_processor_get_info(struct acpi_device *device)
>   	 *  because cpuid <-> apicid mapping is persistent now.
>   	 */
>   	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> -		int ret = acpi_processor_hotadd_init(pr);
> +		int ret = acpi_processor_hotadd_init(pr, device);
>   
>   		if (ret)
>   			return ret;
> +	} else {
> +		if (!acpi_processor_set_per_cpu(pr, device))
> +			return -EINVAL;
>   	}
>   

		ret = acpi_processor_set_per_cpu(pr, device);
		if (ret)
			return ret;

>   	/*
> @@ -365,8 +407,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
>    * (cpu_data(cpu)) values, like CPU feature flags, family, model, etc.
>    * Such things have to be put in and set up by the processor driver's .probe().
>    */
> -static DEFINE_PER_CPU(void *, processor_device_array);
> -
>   static int acpi_processor_add(struct acpi_device *device,
>   					const struct acpi_device_id *id)
>   {
> @@ -395,28 +435,6 @@ static int acpi_processor_add(struct acpi_device *device,
>   	if (result) /* Processor is not physically present or unavailable */
>   		goto err_clear_driver_data;
>   
> -	BUG_ON(pr->id >= nr_cpu_ids);
> -
> -	/*
> -	 * Buggy BIOS check.
> -	 * ACPI id of processors can be reported wrongly by the BIOS.
> -	 * Don't trust it blindly
> -	 */
> -	if (per_cpu(processor_device_array, pr->id) != NULL &&
> -	    per_cpu(processor_device_array, pr->id) != device) {
> -		dev_warn(&device->dev,
> -			"BIOS reported wrong ACPI id %d for the processor\n",
> -			pr->id);
> -		/* Give up, but do not abort the namespace scan. */
> -		goto err_clear_driver_data;
> -	}
> -	/*
> -	 * processor_device_array is not cleared on errors to allow buggy BIOS
> -	 * checks.
> -	 */
> -	per_cpu(processor_device_array, pr->id) = device;
> -	per_cpu(processors, pr->id) = pr;
> -
>   	dev = get_cpu_device(pr->id);
>   	if (!dev) {
>   		result = -ENODEV;
> @@ -470,10 +488,6 @@ static void acpi_processor_remove(struct acpi_device *device)
>   	device_release_driver(pr->dev);
>   	acpi_unbind_one(pr->dev);
>   
> -	/* Clean up. */
> -	per_cpu(processor_device_array, pr->id) = NULL;
> -	per_cpu(processors, pr->id) = NULL;
> -
>   	cpu_maps_update_begin();
>   	cpus_write_lock();
>   
> @@ -481,6 +495,10 @@ static void acpi_processor_remove(struct acpi_device *device)
>   	arch_unregister_cpu(pr->id);
>   	acpi_unmap_cpu(pr->id);
>   
> +	/* Clean up. */
> +	per_cpu(processor_device_array, pr->id) = NULL;
> +	per_cpu(processors, pr->id) = NULL;
> +
>   	cpus_write_unlock();
>   	cpu_maps_update_done();
>   

Thanks,
Gavin


