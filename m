Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792AB360461
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Apr 2021 10:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhDOIg2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 04:36:28 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57206 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230090AbhDOIg1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Apr 2021 04:36:27 -0400
Received: from localhost.localdomain (unknown [10.40.54.95])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr+_n+ndg9zsIAA--.1292S3;
        Thu, 15 Apr 2021 16:35:56 +0800 (CST)
Subject: Re: [PATCH] ACPICA: Events: support fixed pcie wake event
To:     "Moore, Robert" <robert.moore@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
References: <1617278736-7400-1-git-send-email-lvjianmin@loongson.cn>
 <BYAPR11MB3256C7F3C17D14C1DF544430877B9@BYAPR11MB3256.namprd11.prod.outlook.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <4385b7c8-5f3b-99a5-e584-660e4555ec3b@loongson.cn>
Date:   Thu, 15 Apr 2021 04:35:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB3256C7F3C17D14C1DF544430877B9@BYAPR11MB3256.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxr+_n+ndg9zsIAA--.1292S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyrAF1xAry8XFyrXF15XFb_yoWrCw4DpF
        9I9aySkr4UtF4I9anrtw1UuFyYgay8Cry7CF4qg347ZF4DCr1rWF4qgF1DGFZ8Cwsxua1I
        ya4DKFyUKay5XFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
        twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
        j04E_UUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Bob

Thanks for your reply!

I have submitted V2 in which related description in ACPI spec are added, 
please review it.


See V2 at:

https://lore.kernel.org/linux-acpi/1617335733-5942-1-git-send-email-lvjianmin@loongson.cn/T/#u

Thanks sincerely!

On 04/01/2021 04:56 PM, Moore, Robert wrote:
> Can you send/point us to the spec that this change is based upon?
> Thanks,
> Bob
>
>
> -----Original Message-----
> From: Jianmin Lv <lvjianmin@loongson.cn>
> Sent: Thursday, April 01, 2021 5:06 AM
> To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; lvjianmin <lvjianmin@loongson.cn>
> Subject: [PATCH] ACPICA: Events: support fixed pcie wake event
>
> From: lvjianmin <lvjianmin@loongson.cn>
>
> Some chipsets support fixed pcie wake event which is defined in the PM1 block, such as LS7A1000 of Loongson company, so we add code to handle it.
>
> Signed-off-by: lvjianmin <lvjianmin@loongson.cn>
>
> diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c index 35385148fedb..08ba368beb2d 100644
> --- a/drivers/acpi/acpica/evevent.c
> +++ b/drivers/acpi/acpica/evevent.c
> @@ -185,6 +185,10 @@ u32 acpi_ev_fixed_event_detect(void)
>   		return (int_status);
>   	}
>   
> +	if (fixed_enable & ACPI_BITMASK_PCIEXP_WAKE_DISABLE)
> +		fixed_enable &= ~ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
> +	else
> +		fixed_enable |= ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
>   	ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
>   			  "Fixed Event Block: Enable %08X Status %08X\n",
>   			  fixed_enable, fixed_status));
> @@ -250,8 +254,8 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
>   	if (!acpi_gbl_fixed_event_handlers[event].handler) {
>   		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
>   					      enable_register_id,
> -					      ACPI_DISABLE_EVENT);
> -
> +						event == ACPI_EVENT_PCIE_WAKE ?
> +						ACPI_ENABLE_EVENT : ACPI_DISABLE_EVENT);
>   		ACPI_ERROR((AE_INFO,
>   			    "No installed handler for fixed event - %s (%u), disabling",
>   			    acpi_ut_get_event_name(event), event)); diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c index 14baa13bf848..7e7ea4c2e914 100644
> --- a/drivers/acpi/acpica/hwsleep.c
> +++ b/drivers/acpi/acpica/hwsleep.c
> @@ -312,6 +312,18 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
>   				    [ACPI_EVENT_SLEEP_BUTTON].
>   				    status_register_id, ACPI_CLEAR_STATUS);
>   
> +	/* Enable pcie wake event if support */
> +	if ((acpi_gbl_FADT.flags & ACPI_FADT_PCI_EXPRESS_WAKE)) {
> +		(void)
> +		acpi_write_bit_register(acpi_gbl_fixed_event_info
> +				[ACPI_EVENT_PCIE_WAKE].
> +				enable_register_id, ACPI_DISABLE_EVENT);
> +		(void)
> +		acpi_write_bit_register(acpi_gbl_fixed_event_info
> +				[ACPI_EVENT_PCIE_WAKE].
> +				status_register_id, ACPI_CLEAR_STATUS);
> +	}
> +
>   	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKING);
>   	return_ACPI_STATUS(status);
>   }
> diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c index 59a48371a7bc..68baf16d8a02 100644
> --- a/drivers/acpi/acpica/utglobal.c
> +++ b/drivers/acpi/acpica/utglobal.c
> @@ -186,6 +186,10 @@ struct acpi_fixed_event_info acpi_gbl_fixed_event_info[ACPI_NUM_FIXED_EVENTS] =
>   					ACPI_BITREG_RT_CLOCK_ENABLE,
>   					ACPI_BITMASK_RT_CLOCK_STATUS,
>   					ACPI_BITMASK_RT_CLOCK_ENABLE},
> +	/* ACPI_EVENT_PCIE_WAKE		*/ {ACPI_BITREG_PCIEXP_WAKE_STATUS,
> +					ACPI_BITREG_PCIEXP_WAKE_DISABLE,
> +					ACPI_BITMASK_PCIEXP_WAKE_STATUS,
> +					ACPI_BITMASK_PCIEXP_WAKE_DISABLE},
>   };
>   #endif				/* !ACPI_REDUCED_HARDWARE */
>   
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index 92c71dfce0d5..0b6c72033487 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -714,7 +714,8 @@ typedef u32 acpi_event_type;
>   #define ACPI_EVENT_POWER_BUTTON         2
>   #define ACPI_EVENT_SLEEP_BUTTON         3
>   #define ACPI_EVENT_RTC                  4
> -#define ACPI_EVENT_MAX                  4
> +#define ACPI_EVENT_PCIE_WAKE            5
> +#define ACPI_EVENT_MAX                  5
>   #define ACPI_NUM_FIXED_EVENTS           ACPI_EVENT_MAX + 1
>   
>   /*
> --
> 2.27.0

