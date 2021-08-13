Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDFB3EB000
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Aug 2021 08:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbhHMG1a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Aug 2021 02:27:30 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13310 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbhHMG1a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Aug 2021 02:27:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GmD9Y4K3nz85pm;
        Fri, 13 Aug 2021 14:26:57 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 13 Aug 2021 14:26:57 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 13 Aug 2021 14:26:56 +0800
Subject: Re: [PATCH] x86/acpi: Don't add CPUs that are not online capable
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
References: <20210812051657.28605-1-mario.limonciello@amd.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <a671969e-526f-cdc0-6c77-0eb2d940ec5c@huawei.com>
Date:   Fri, 13 Aug 2021 14:26:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210812051657.28605-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/8/12 13:16, Mario Limonciello wrote:
> A number of systems are showing "hotplug capable" CPUs when they
> are not really hotpluggable.  This is because the MADT has extra
> CPU entries to support different CPUs that may be inserted into
> the socket with different numbers of cores.
> 
> The ACPI spec is clear that the Online Capable bit in the
> MADT should be used to determine whether or not a CPU is hotplug
> capable when the enabled bit is not set.

This was introduced in ACPI 6.3 spec, which means ACPI 6.2 and
earlier versions don't include the "Online Capable bit".

> 
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html?#local-apic-flags
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   arch/x86/kernel/acpi/boot.c | 6 ++++++
>   include/acpi/actbl2.h       | 1 +
>   2 files changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index e55e0c1fad8c..eeb10b27d6de 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -239,6 +239,12 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
>   	if (processor->id == 0xff)
>   		return 0;
>   
> +	/* don't register processors that can not be onlined */
> +	if (!(processor->lapic_flags & ACPI_MADT_ENABLED)) {
> +		if (!(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> +			return 0;
> +	}

For firmware using ACPI 6.2 and early versions, the
ACPI_MADT_ONLINE_CAPABLE bit is reserved as zero, so if
we set CPU as disabled, the code here will always return
0 in those firmwares.

> +
>   	/*
>   	 * We need to register disabled CPU as well to permit
>   	 * counting disabled CPUs. This allows us to size

So we will not register the disabled CPU and will break
CPU hotplug features.

I think we need to consider the compatibility with old versions
of firmware.

Thanks
Hanjun

