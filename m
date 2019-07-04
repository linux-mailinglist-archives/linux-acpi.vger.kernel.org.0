Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8AAE5F30B
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2019 08:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfGDGqW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jul 2019 02:46:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41059 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfGDGqV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jul 2019 02:46:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so2457042pff.8;
        Wed, 03 Jul 2019 23:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=7u3j/qlpuiMl7q0crcwHK5qvOp5dbyAVCcaxQlei5BY=;
        b=d/u6QSi/W+Hep7xnLOkGy1zQzus/xm9kmEi9zJteGC+By7PW4KjgQWcSHcyR+Ga6ql
         I8H3C5il13o4RAUqeRGoK6OzmIU63054kYPrcXXtpL7MbrWqdhKClhb5jCqiwIXAnKay
         XKaHDrWkk/bpKY3G54zKktlypLL1MgPOfQyFt93BtOdisfS31RODJIyEVHuTDiyPKhlZ
         xsrvAiVLNtXgqk767s8NWPBwfZxUgYq5fI0z+FEn+0ZyDskl7UbQM5AROxEpw+KH5Wc9
         AjMtSRwBN+MCLdDP9DONVwz54+Sjj5YB5NJZh3//3UFZ7/ViVX8/BcYA4v54LWpZat3j
         ZlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=7u3j/qlpuiMl7q0crcwHK5qvOp5dbyAVCcaxQlei5BY=;
        b=JjAOsTuy6i9iPhyFOYrEjufTHVwfr6Kn9hy3NImUnXngTVAvTIdCMFrqXTP/MGRlHJ
         Xb9BtnrAesMI6l5WKEukPsGX+d7B1dadug/TeoxVzYXoLYeyG4wXg2ToDWKO8yU0kLly
         Tn/3ZemZZ3DVOdG/EMAeChCIkPvafsLTznC4RjIkDVappS5vsVdsW6WFkbl9dlaazR78
         uEokP6CDLtRuG/Fb1XR5R+S9bPhlpJqcjLEx9mjfLVdDhZ4xjn9CtVC2MVM+xll0BmPt
         OJCKnPChdWOQMJdADbO4igYGSDaLZ7MHNCjT0Ql8G9c9qOd7cMrkd0nQ47Q0gxvKWnRB
         wxpg==
X-Gm-Message-State: APjAAAX5eDuH+7KAHbD7iwAhI0/pumb1uNUZSkPlg/erai10bpI1mQVn
        mN2ByIDjCOm1WxdJRJoaU8A=
X-Google-Smtp-Source: APXvYqy/s0Ljvqpnt4JWFhbvPuiQt4Q13IXhAAOtCo9uJyfuMIBmYhhpcuhs0o6/ztVpgX4DicG89w==
X-Received: by 2002:a63:2b8e:: with SMTP id r136mr13258143pgr.216.1562222781277;
        Wed, 03 Jul 2019 23:46:21 -0700 (PDT)
Received: from [0.0.0.0] ([80.240.31.150])
        by smtp.gmail.com with ESMTPSA id z20sm8169915pfk.72.2019.07.03.23.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 23:46:20 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/3] arm64: mark all the GICC nodes in MADT as
 possible cpu
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, james.morse@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, guohanjun@huawei.com,
        xiexiuqi@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com, jonathan.cameron@huawei.com
References: <1561776155-38975-1-git-send-email-wangxiongfeng2@huawei.com>
 <1561776155-38975-3-git-send-email-wangxiongfeng2@huawei.com>
From:   Jia He <jiakernel2@gmail.com>
Organization: ARM
Message-ID: <762be90e-7629-ab5e-4c2d-6566b100f2e5@gmail.com>
Date:   Thu, 4 Jul 2019 14:46:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1561776155-38975-3-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 2019/6/29 10:42, Xiongfeng Wang wrote:
> We set 'cpu_possible_mask' based on the enabled GICC node in MADT. If
> the GICC node is disabled, we will skip initializing the kernel data
> structure for that CPU.
>
> To support CPU hotplug, we need to initialize some CPU related data
> structure in advance. This patch mark all the GICC nodes as possible CPU
> and only these enabled GICC nodes as present CPU.
>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>   arch/arm64/kernel/setup.c |  2 +-
>   arch/arm64/kernel/smp.c   | 11 +++++------
>   2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 7e541f9..7f4d12a 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -359,7 +359,7 @@ static int __init topology_init(void)
>   	for_each_online_node(i)
>   		register_one_node(i);
>   
> -	for_each_possible_cpu(i) {
> +	for_each_online_cpu(i) {

Have you considered the case in non-acpi mode? and setting "maxcpus=n" in host 
kernel boot

parameters?

---
Cheers,
Justin (Jia He)


>   		struct cpu *cpu = &per_cpu(cpu_data.cpu, i);
>   		cpu->hotpluggable = 1;
>   		register_cpu(cpu, i);
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 6dcf960..6d9983c 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -525,16 +525,14 @@ struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu)
>   {
>   	u64 hwid = processor->arm_mpidr;
>   
> -	if (!(processor->flags & ACPI_MADT_ENABLED)) {
> -		pr_debug("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
> -		return;
> -	}
> -
>   	if (hwid & ~MPIDR_HWID_BITMASK || hwid == INVALID_HWID) {
>   		pr_err("skipping CPU entry with invalid MPIDR 0x%llx\n", hwid);
>   		return;
>   	}
>   
> +	if (!(processor->flags & ACPI_MADT_ENABLED))
> +		pr_debug("disabled CPU entry with 0x%llx MPIDR\n", hwid);
> +
>   	if (is_mpidr_duplicate(cpu_count, hwid)) {
>   		pr_err("duplicate CPU MPIDR 0x%llx in MADT\n", hwid);
>   		return;
> @@ -755,7 +753,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>   		if (err)
>   			continue;
>   
> -		set_cpu_present(cpu, true);
> +		if ((cpu_madt_gicc[cpu].flags & ACPI_MADT_ENABLED))
> +			set_cpu_present(cpu, true);
>   		numa_store_cpu_info(cpu);
>   	}
>   }

-- 

