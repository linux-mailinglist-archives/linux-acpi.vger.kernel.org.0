Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D462BC3DE
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Nov 2020 06:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgKVF2G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 22 Nov 2020 00:28:06 -0500
Received: from lonlinode-sdnproxy-1.icoremail.net ([139.162.193.133]:42394
        "HELO lonlinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1727110AbgKVF2G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 22 Nov 2020 00:28:06 -0500
Received: from localhost (unknown [113.247.217.134])
        by c1app7 (Coremail) with SMTP id BwINCgA3PQHb9rlfssnpAA--.12609S3;
        Sun, 22 Nov 2020 13:27:55 +0800 (CST)
Date:   Sun, 22 Nov 2020 13:27:52 +0800
From:   Chen Baozi <chenbaozi@phytium.com.cn>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: Let ACPI know we support Generic Initiator
 Affinity Structures
Message-ID: <20201122052752.GA23348@debian-gnu-linux-vm.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: BwINCgA3PQHb9rlfssnpAA--.12609S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw43XF4Duw15CFW5ArWrKrg_yoW8ZF47pF
        sY9w4DCrykCaykCa4kCw4FqFy5Ja13AFyjvr9rK3yUZ34rGr1DJr4ktryUKayj9rs3JF4F
        gFn0qr15tayDu3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc2xSY4AK67AK6r4rMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07boxhJUUUUU=
X-CM-SenderInfo: hfkh0updr2xqxsk13x1xpou0fpof0/1tbiDAPkP17uHyDXUAAAsc
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jonathan,

I have found the value of OSC_SB_GENERIC_INITIATOR_SUPPORT is wrong
when reading source code of driver/acpi/bus.c in the linux-next

On Wed, Sep 30, 2020 at 10:05:44PM +0800, Jonathan Cameron wrote:
> Until we tell ACPI that we support generic initiators, it will have
> to operate in fall back domain mode and all _PXM entries should
> be on existing non GI domains.
> 
> This patch sets the relevant OSC bit to make that happen.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/bus.c   | 4 ++++
>  include/linux/acpi.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 54002670cb7a..113c661eb848 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -303,7 +303,11 @@ static void acpi_bus_osc_support(void)
>  	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
>  	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
>  
> +#ifdef CONFIG_ARM64
> +	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
> +#endif
>  #ifdef CONFIG_X86
> +	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
>  	if (boot_cpu_has(X86_FEATURE_HWP)) {
>  		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
>  		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index e9f6cd67943e..edbf3c4116b4 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -545,6 +545,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
>  #define OSC_SB_PCLPI_SUPPORT			0x00000080
>  #define OSC_SB_OSLPI_SUPPORT			0x00000100
>  #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
> +#define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000

Since the Generic Initiator Support is the Bit 17, it should be
0x20000 rather than 0x2000.

Baozi.

