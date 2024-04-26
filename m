Return-Path: <linux-acpi+bounces-5395-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEF08B343F
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Apr 2024 11:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922B4287DDC
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Apr 2024 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F3F13F450;
	Fri, 26 Apr 2024 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaEGrqzG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6A13F422
	for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2024 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124188; cv=none; b=LpySrCrMEkMCMc0XzcIb118FA3Hbr6VChnc+hudY60zeLC8CUCpzuMA+RhCr0XbEJef2FIIfZ2yzyZf1igXRpWN1duvrB/6LnHxoEiO5+Rm3rC4h00nUkWJc8Bs14OP8zPjHaKKz2JGzGmk4Y3IHAeRtG+MlaFTG0pnxBmhRbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124188; c=relaxed/simple;
	bh=Y3jENvyu7fKPEdBvKAbLTUiG9vM1ldEliX0y6fpkZxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vATT5U17aiW/PMvJR51x/jlUbbUANua6HzymwMVGiLEE/pU7BES191Z6dWrU7pFu9gJuvSIzwUIuY+Crz4XnrpR/BAOWc9k6hql12MA5TObBEpDUEhwmDC0R1C4AMIeNJLLvkBStNI8keERUgbzciVk7VaQshn8LVYb6Lji4328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VaEGrqzG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714124185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qExq3Nq0hUqrQo4qRdmB4OoXaEaQNPNwgb/ED5v1FgA=;
	b=VaEGrqzGfzFkRG57YKF4BAVpkG8W8aqoqVJ/ZVstFEUlwq8jaBO4A6YN2Ab81urBTiFjTc
	Yke45DISFdgUl3zXs0cVxjQDOkqG4k+U1y8epcyq+/tp/eLu7v1bmDR3wCckYFczT63D9C
	EruSeshc9Ud8D72OVnlYMxb9Wqhna/o=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-tT4X9SgSPJKs9aOAPFpYpw-1; Fri, 26 Apr 2024 05:36:22 -0400
X-MC-Unique: tT4X9SgSPJKs9aOAPFpYpw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e8f59d1d9bso20626295ad.1
        for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2024 02:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714124181; x=1714728981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qExq3Nq0hUqrQo4qRdmB4OoXaEaQNPNwgb/ED5v1FgA=;
        b=RgSM+j3UVDCKTv/gpa+7pPmTsH/0xCBtp29EBAPL5OH/BGgarLZQ2zedgQ6DLUuokC
         afQA7X8+wXsAoqyXf5PWUoovXKry/8Fs6wjJ6AIGS0uIge5wWu5zc0J1N6Py35sgYoYh
         5xqNlN2SFSR/MOM7yESXHhvqvqBHXyA3d7/v4BE7m3LBfU+g0HVNYReYy1YXH4wORPdX
         jyPhfx4i30q6XmgbNqOqlNuCXCRnOIzKkbNv/hoSLjxzaaPFQOafo2Z5IlpAWIeIrFtF
         COEa51gFveANd0nXx9Dq0sNNMX+2d2W4p1LJPQ4T1PIaLbXwG8tGWQZffjOkuksPoTrf
         BPfg==
X-Forwarded-Encrypted: i=1; AJvYcCU7mMN2q8xj2ELCMNXqUSA9bt+ncRYuUCqQVqmBcPHNRCeuE7Ny6Fi/Tq6iZZVau7+h192WsFN6OaQVfIYhKiLI/ewO79SwdIbwsw==
X-Gm-Message-State: AOJu0Yz92puKQvdJSWe0rQdrrA7TCpnOWZ2+WWR1fPBUidSIYLUJBTl/
	U98ffAEIXP8cEc0uIGlOyvSzWNvKNn4kuETiUUupS8iGBO6dLQ5AjwLYfqKf7ezy9xJdoZ14F1n
	K4hpODwozwdXcElSYZQ+xBxcOEZ3S2i7n0bv43G+/ZNg6X3iM11uEZV9HM3A=
X-Received: by 2002:a17:902:e743:b0:1e9:13eb:9082 with SMTP id p3-20020a170902e74300b001e913eb9082mr2650406plf.0.1714124181188;
        Fri, 26 Apr 2024 02:36:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+kB8MtLlnQihsmOFiAsNTY4H/hnM+mV/Y1YJ7mzin6YbOqhwE6PJBBN0k7jOFD1Z7EzpxaA==
X-Received: by 2002:a17:902:e743:b0:1e9:13eb:9082 with SMTP id p3-20020a170902e74300b001e913eb9082mr2650377plf.0.1714124180801;
        Fri, 26 Apr 2024 02:36:20 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e5c200b001e556734814sm15079254plf.134.2024.04.26.02.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:36:20 -0700 (PDT)
Message-ID: <e4628e32-8e76-4db4-9c85-b1246186f3be@redhat.com>
Date: Fri, 26 Apr 2024 19:36:10 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/16] arm64: psci: Ignore DENIED CPUs
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
 <20240418135412.14730-13-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-13-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:54, Jonathan Cameron wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When a CPU is marked as disabled, but online capable in the MADT, PSCI
> applies some firmware policy to control when it can be brought online.
> PSCI returns DENIED to a CPU_ON request if this is not currently
> permitted. The OS can learn the current policy from the _STA enabled bit.
> 
> Handle the PSCI DENIED return code gracefully instead of printing an
> error.
> 
> See https://developer.arm.com/documentation/den0022/f/?lang=en page 58.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [ morse: Rewrote commit message ]
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v7: No change
> ---
>   arch/arm64/kernel/psci.c | 2 +-
>   arch/arm64/kernel/smp.c  | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 29a8e444db83..fabd732d0a2d 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -40,7 +40,7 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
>   {
>   	phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
>   	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);
> -	if (err)
> +	if (err && err != -EPERM)
>   		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
>   
>   	return err;
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4ced34f62dab..dc0e0b3ec2d4 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -132,7 +132,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>   	/* Now bring the CPU into our world */
>   	ret = boot_secondary(cpu, idle);
>   	if (ret) {
> -		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
> +		if (ret != -EPERM)
> +			pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>   		return ret;
>   	}
>   

The changes in smp.c are based the assumption that PSCI is the only backend, which
isn't true. So we probably need move this error message to specific backend, which
could be PSCI, ACPI parking protocol, or smp_spin_table.

Thanks,
Gavin


