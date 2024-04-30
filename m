Return-Path: <linux-acpi+bounces-5475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120888B696C
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 06:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8319A283AE5
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 04:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B30134BE;
	Tue, 30 Apr 2024 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJO84Ws0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE0125BA
	for <linux-acpi@vger.kernel.org>; Tue, 30 Apr 2024 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714451184; cv=none; b=uH+kWhDrhUJI2oBPzP4mGGPY/qOoHocNWJklvgNTZcNIaucMEmEy4B2zNKTap6hlHJ7KsiwTAlUZkrhYc/8vT0DX/TI/gISb8ZzrXnkR3/1/GXkjgBLxwzf5tP8PFkjKdojBj67yBJN/lGsYY/MR3ilxm9lXgxeFfCJF/52ctM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714451184; c=relaxed/simple;
	bh=7/LvDV66mDIzCX8Ki3ehENh2BWy+/8sMXmXZYQ9n3Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9mPmr/7PT9Z9bxL9Zh0X2HU4uNbKdTIs/JQjWC5bCiO8oOY83ISbMGSb0QS1k5xfZ+iHp2nV/q+8WArM9uXX2FmZcA4ydFo6dQixiuB7FypbB99prScWFF8ARYUTmgd7bvbL0PsVoiAeJRxVmiqRjfLefKDkTpPDxHRauKgVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJO84Ws0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714451182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/j3/XOns0oFgwfO5bxhGBltITHmRiIbor4kORGQYrjA=;
	b=GJO84Ws04msNmbJilIaROLjMXpV12WR1ttG2ubDyNe1O2ZMQ5HagGLyREqhRaSKbsipjQ2
	ZNcCPXEBEjXs2y3SqIbIT9PPg9Y0aLKy7n38Y+2IbD2r90g86A/tu5alBovMF21gXp/QS+
	J4k4IOnrljbJ34Rd22dc0rnKULrSC2Y=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-aHG1XzNgMwWgTBtJx48D-A-1; Tue, 30 Apr 2024 00:26:19 -0400
X-MC-Unique: aHG1XzNgMwWgTBtJx48D-A-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-613dbdf5c1bso1755786a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2024 21:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714451178; x=1715055978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/j3/XOns0oFgwfO5bxhGBltITHmRiIbor4kORGQYrjA=;
        b=XERjUA65qHc234D4IGk3Mil/jTHe/GoWeqFapZ9vjw4eTyQd9T1Sdeta0/wJqTAv6N
         2cPNx9ZpHfgR6a7riy3wJ2EUyK84R0fXmg8+Kix/7kzWtfGF4iY0jro3M48wRNI4h680
         ONFre/veJwqne6GL6vjUe1lgauQrs0MD1a42bJZT5Ua42QCYbkEgWze14AM477WdpeFG
         SlPHg/J8eTwOoo3dDnlj+gHNJECL+LtEHfBwaQ7p04ct3NHHWeOgaqLvtTOAFcemFHow
         mBrjlXCqIRMyHdJt8IAU2LVQKowfV2205lOElT7lh5W1unFlDrGPA+UjclsA3A1GjBEL
         sU2w==
X-Forwarded-Encrypted: i=1; AJvYcCXO8yFkmpk2qyQrHZRgdaVlO5w677TNUOXWHUgifYaiPRIOHTW7W7Y+QZ/ydNMAS4OAerDgCJkTbcROd6rwR4IsNrzbN33UscNutw==
X-Gm-Message-State: AOJu0Yyr2sAI+zRHycNLRT5y8AQcCDGMVIF/zCSCLHqa5qnO0lCfsAi3
	Q+QHBYkaoDEdClvzX7BZhS4MBNcIW6A8cNJIZUF8CZHBhFjvwgA3AKZDh4h5nUszGOeDFlrgZEX
	6g+3zutTNKPHYUEO5F7pMJOdUz8mxqFG+HOQpGFJ66bC3DQKN3eyi32dVCMk=
X-Received: by 2002:a05:6a20:43ab:b0:1af:597f:ffa4 with SMTP id i43-20020a056a2043ab00b001af597fffa4mr1773952pzl.14.1714451178657;
        Mon, 29 Apr 2024 21:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH07U3E59OEv3uasYAdnnN9/WYRlSaTmrz5sCzeoOlurs0CWJYXB3V+LTa+nYaZB59wKOeCng==
X-Received: by 2002:a05:6a20:43ab:b0:1af:597f:ffa4 with SMTP id i43-20020a056a2043ab00b001af597fffa4mr1773917pzl.14.1714451178308;
        Mon, 29 Apr 2024 21:26:18 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e74200b001e223b9eb25sm21272994plf.153.2024.04.29.21.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 21:26:17 -0700 (PDT)
Message-ID: <63f7c71a-fa01-4604-8fc6-9f52b5b31d6b@redhat.com>
Date: Tue, 30 Apr 2024 14:26:06 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/16] ACPI: processor: Add acpi_get_processor_handle()
 helper
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
 justin.he@arm.com, jianyong.wu@arm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
 <20240426135126.12802-6-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240426135126.12802-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 23:51, Jonathan Cameron wrote:
> If CONFIG_ACPI_PROCESSOR provide a helper to retrieve the
> acpi_handle for a given CPU allowing access to methods
> in DSDT.
> 
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v8: Code simplification suggested by Rafael.
>      Fixup ;; spotted by Gavin
> ---
>   drivers/acpi/acpi_processor.c | 11 +++++++++++
>   include/linux/acpi.h          |  7 +++++++
>   2 files changed, 18 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 3b180e21f325..ecc2721fecae 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -35,6 +35,17 @@ EXPORT_PER_CPU_SYMBOL(processors);
>   struct acpi_processor_errata errata __read_mostly;
>   EXPORT_SYMBOL_GPL(errata);
>   
> +acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +	struct acpi_processor *pr;
> +
> +	pr = per_cpu(processors, cpu);
> +	if (pr)
> +		return pr->handle;
> +
> +	return NULL;
> +}
> +

Maybe it's worthy to have more check here, something like below.
However, it's also fine without the extra check.

	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
		return NULL;

>   static int acpi_processor_errata_piix4(struct pci_dev *dev)
>   {
>   	u8 value1 = 0;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 34829f2c517a..9844a3f9c4e5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -309,6 +309,8 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
>   int acpi_unmap_cpu(int cpu);
>   #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>   
> +acpi_handle acpi_get_processor_handle(int cpu);
> +
>   #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>   int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
>   #endif
> @@ -1077,6 +1079,11 @@ static inline bool acpi_sleep_state_supported(u8 sleep_state)
>   	return false;
>   }
>   
> +static inline acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +	return NULL;
> +}
> +
>   #endif	/* !CONFIG_ACPI */
>   
>   extern void arch_post_acpi_subsys_init(void);

Thanks,
Gavin


