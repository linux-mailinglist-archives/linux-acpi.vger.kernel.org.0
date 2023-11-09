Return-Path: <linux-acpi+bounces-1371-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B237E6840
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 11:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC7E7B2098C
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BAE199AA
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XY0jEFNI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BDC16426
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 10:09:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9E2D73
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 02:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699524580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f66C/Uco7Rn4beNRod/QtpM+fKeOVkNE1m9/M9ZsY14=;
	b=XY0jEFNIKPzoHUHhMSwhB8sXqU6m5Y49AnlMsK6EU6Xjrk6b75F5a11XVZE2gmxf6nMx9x
	Dm4FzxhvV1rFYpaU6N/0oE0bk9KIwK7XF5vgm9Lp43cVChuRaqrWeekC/QDJQx8zotC3RL
	0BIM2WE2wFeuOuM2C6gMvl7LJpK4ylg=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-o7jr3A7tMbmXIB264NZTYw-1; Thu, 09 Nov 2023 05:09:39 -0500
X-MC-Unique: o7jr3A7tMbmXIB264NZTYw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1e9f1c924f2so164840fac.0
        for <linux-acpi@vger.kernel.org>; Thu, 09 Nov 2023 02:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524578; x=1700129378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f66C/Uco7Rn4beNRod/QtpM+fKeOVkNE1m9/M9ZsY14=;
        b=uikNJ7x4mU4DHvajLgXRqbgRLMi4OmDWT9SNGcoLnsNdsVnUtuI5BZ6aYC92KNKp3S
         eIivKV4W6HzEA3Xqk9F2pb9/3P1J+9bgzV/RM/RLJqbMtuLywOxgfi5gWBdZETS6YZBe
         sFfEoFGZuSIemEb2dkrCLN0G45v5cXZpgTzcFNLxoXURjF3cS8KfPm2G5ewRDPJk8FSA
         z4QUsgvQNdxtw1mKA1hEqFVDyyYpm6CsP2CMTW8giTWHg4f48U1M85s12oBueEDiSTNJ
         gxPEb5Q2qerCjTXVSHOKnFhmsX5oRuy15Uq+0ckqmeFDwLUswGxwEhxYyupenI/0HMi7
         uEiA==
X-Gm-Message-State: AOJu0YwW+8iqQH+2u5vjUiDxZfI5AyCVeVYiNhGEUbXI4Iswv243AWtu
	Nwk9D5doj06RLqFG8/fzVaZ8YGNCqH5pfU+u8OiSHXBRM5tNi7MFt3ohh7kxKLPKh8NRQurKkBe
	4/xToRgRm5qpMy1YcFXY/PQ==
X-Received: by 2002:a05:6871:a113:b0:1e9:e8fd:bb77 with SMTP id vs19-20020a056871a11300b001e9e8fdbb77mr5119481oab.0.1699524578734;
        Thu, 09 Nov 2023 02:09:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuc2Fsk1aOG+26g+R1TKcXCB5LvcN3abO9ejRxfqdYaGILXhVW+FjXlWbJavq6vyZSTQA5Iw==
X-Received: by 2002:a05:6871:a113:b0:1e9:e8fd:bb77 with SMTP id vs19-20020a056871a11300b001e9e8fdbb77mr5119472oab.0.1699524578430;
        Thu, 09 Nov 2023 02:09:38 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q18-20020a62ae12000000b006bae6eea9d0sm10335148pff.49.2023.11.09.02.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 02:09:38 -0800 (PST)
Message-ID: <f00dd1cf-5b4c-38a8-a337-817d474d53d1@redhat.com>
Date: Thu, 9 Nov 2023 18:09:32 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 06/22] drivers: base: Use present CPUs in
 GENERIC_CPU_DEVICES
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org,
 linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, James Morse <james.morse@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLB-00CTwy-7y@rmk-PC.armlinux.org.uk>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <E1r0JLB-00CTwy-7y@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Russell,

On 11/7/23 18:29, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Three of the five ACPI architectures create sysfs entries using
> register_cpu() for present CPUs, whereas arm64, riscv and all
> GENERIC_CPU_DEVICES do this for possible CPUs.
> 
> Registering a CPU is what causes them to show up in sysfs.
> 
> It makes very little sense to register all possible CPUs. Registering
> a CPU is what triggers the udev notifications allowing user-space to
> react to newly added CPUs.
> 
> To allow all five ACPI architectures to use GENERIC_CPU_DEVICES, change
> it to use for_each_present_cpu(). Making the ACPI architectures use
> GENERIC_CPU_DEVICES is a pre-requisite step to centralise their
> cpu_register() logic, before moving it into the ACPI processor driver.
> When ACPI is disabled this work would be done by
> cpu_dev_register_generic().

What do you actually mean about when ACPI is disabled this work would be 
done by cpu_dev_register_generic()? Is the work means register the cpu?

I'm not quite understand that, and how about when ACPI is enabled, which 
function do this work?

> 
> Of the ACPI architectures that register possible CPUs, arm64 and riscv
> do not support making possible CPUs present as they use the weak 'always
> fails' version of arch_register_cpu().
> 
> Only two of the eight architectures that use GENERIC_CPU_DEVICES have a
> distinction between present and possible CPUs.
> 
> The following architectures use GENERIC_CPU_DEVICES but are not SMP,
> so possible == present:
>   * m68k
>   * microblaze
>   * nios2
> 
> The following architectures use GENERIC_CPU_DEVICES and consider
> possible == present:
>   * csky: setup_smp()
>   * processor_probe() sets possible for all CPUs and present for all CPUs
>     except the boot cpu, which will have been done by
>     init/main.c::start_kernel().
> 
> um appears to be a subarchitecture of x86.
> 
> The remaining architecture using GENERIC_CPU_DEVICES are:
>   * openrisc and hexagon:
>     where smp_init_cpus() makes all CPUs < NR_CPUS possible,
>     whereas smp_prepare_cpus() only makes CPUs < setup_max_cpus present.
> 
> After this change, openrisc and hexagon systems that use the max_cpus
> command line argument would not see the other CPUs present in sysfs.
> This should not be a problem as these CPUs can't bre brought online as
                                              ^ nit: can't be
> _cpu_up() checks cpu_present().
> 
> After this change, only CPUs which are present appear in sysfs.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks,
Shaoqin

> ---
>   drivers/base/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 9ea22e165acd..34b48f660b6b 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -533,7 +533,7 @@ static void __init cpu_dev_register_generic(void)
>   #ifdef CONFIG_GENERIC_CPU_DEVICES
>   	int i;
>   
> -	for_each_possible_cpu(i) {
> +	for_each_present_cpu(i) {
>   		if (register_cpu(&per_cpu(cpu_devices, i), i))
>   			panic("Failed to register CPU device");
>   	}


