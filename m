Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD0929E1C9
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 03:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgJ1VsD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 17:48:03 -0400
Received: from foss.arm.com ([217.140.110.172]:38328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbgJ1VrO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Oct 2020 17:47:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A40E1161B;
        Wed, 28 Oct 2020 12:19:33 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E642F3F73C;
        Wed, 28 Oct 2020 12:19:31 -0700 (PDT)
Subject: Re: [PATCH] Don't do panic for memory Fatal UE in ghes of x86_mce
 platform
To:     yaoaili126@163.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, yangfeng1@kingsoft.com,
        CHENGUOMIN@kingsoft.com, yaoaili@kingsoft.com
References: <20201028073540.70136-1-yaoaili126@163.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <3942f335-b905-4c8f-bf81-7bdff6c025ad@arm.com>
Date:   Wed, 28 Oct 2020 19:19:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201028073540.70136-1-yaoaili126@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi!

On 28/10/2020 07:35, yaoaili126@163.com wrote:
> From: Aili Yao <yaoaili@kingsoft.com>
> 
> For x86 with mce, when BIOS get its work done for memory UE,it will
> raise MCE exception, In MCE, it will do panic or recovery work there.
> But When BIOS option WHEA memory log is enabled,

This is GHES_ASSIST?


> BIOS also prepared one
> detailed error table which will be polled by ghes_notify_nmi from NMI
> watchdog,

heh, because the NMI notification chain has no idea what triggered it...


> ghes_notify_nmi will check the severity and do panic too, this
> panic action is not necessary and confusing, and may lead to unwanted
> results like core dump fail.
> 
> Downgrade CPER_SEV_FATAL to GHES_SEV_RECOVERABLE before panic is called
> for x86_mce

You can't know whether your platform (will?) also generate an MCE when you build the
kernel. Distros set all the Kconfig options, they aren't tuned to the platform.

This also makes fatal memory errors recoverable, which isn't true for other platforms.


Assuming this is GHES_ASSIST, I think the simplest approach is to skip the panic() for
CPER records found for those GHES. APEI is only providing assistance in this case, so its
unfair for it to take some terminal action. The machine-check handler should have the
final say in in this case.


Section 18.7 of ACPI v6.3a says we're supposed to:
| consume the additional GHES_ASSIST information in the context of an error reported
| by hardware
which would be the MCE - so there is no reason for these GHES entries to be poked whenever
an unrelated NMI occurs.

Fixing this would need a separate list for the machine check handler to poke to dump any
data from GHES_ASSIST CPER, so its more work than just skipping the register call.

(I've no idea how x86 prioritises MCE and NMI... does one block the other?)


Thanks,

James


> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 81bf71b10d44..e5e8a53beb5a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -272,7 +272,27 @@ static inline int ghes_severity(int severity)
>  	case CPER_SEV_RECOVERABLE:
>  		return GHES_SEV_RECOVERABLE;
>  	case CPER_SEV_FATAL:
> +	{
> +#ifdef CONFIG_X86_MCE
> +		int sev, sec_sev;
> +		struct acpi_hest_generic_data *gdata;
> +		guid_t *sec_type;
> +
> +		if (estatus == NULL)
> +			return GHES_SEV_PANIC;
> +
> +		apei_estatus_for_each_section(estatus, gdata) {
> +			sec_type = (guid_t *)gdata->section_type;
> +			sec_sev = gdata->error_severity;
> +			if (sec_sev == CPER_SEV_FATAL &&
> +			 !guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM))
> +				return GHES_SEV_PANIC;
> +		}
> +		return GHES_SEV_RECOVERABLE;
> +#else
>  		return GHES_SEV_PANIC;
> +#endif
> +	}
