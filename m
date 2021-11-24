Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A051045C867
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Nov 2021 16:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhKXPUK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Nov 2021 10:20:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:15404 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234132AbhKXPUG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Nov 2021 10:20:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="232788921"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="232788921"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 07:16:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="741221649"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga006.fm.intel.com with ESMTP; 24 Nov 2021 07:16:51 -0800
Subject: Re: [PATCH v2 7/7] mmc: sdhci-acpi: Use the new soc_intel_is_byt()
 helper
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20211122170536.7725-1-hdegoede@redhat.com>
 <20211122170536.7725-8-hdegoede@redhat.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <87ee2f76-5f06-946d-e63a-fac654a0f01c@intel.com>
Date:   Wed, 24 Nov 2021 17:16:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211122170536.7725-8-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 22/11/2021 19:05, Hans de Goede wrote:
> Use the new soc_intel_is_byt() helper function from
> include/linux/platform_data/x86/soc.h .
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
> - No changes in v2 of this patch-series
> ---
>  drivers/mmc/host/sdhci-acpi.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 1461aae13c19..c0350e9c03f3 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -31,8 +31,7 @@
>  #include <linux/mmc/slot-gpio.h>
>  
>  #ifdef CONFIG_X86
> -#include <asm/cpu_device_id.h>
> -#include <asm/intel-family.h>
> +#include <linux/platform_data/x86/soc.h>
>  #include <asm/iosf_mbi.h>
>  #endif
>  
> @@ -239,16 +238,6 @@ static const struct sdhci_acpi_chip sdhci_acpi_chip_int = {
>  
>  #ifdef CONFIG_X86
>  
> -static bool sdhci_acpi_byt(void)
> -{
> -	static const struct x86_cpu_id byt[] = {
> -		X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT, NULL),
> -		{}
> -	};
> -
> -	return x86_match_cpu(byt);
> -}
> -
>  #define BYT_IOSF_SCCEP			0x63
>  #define BYT_IOSF_OCP_NETCTRL0		0x1078
>  #define BYT_IOSF_OCP_TIMEOUT_BASE	GENMASK(10, 8)
> @@ -257,7 +246,7 @@ static void sdhci_acpi_byt_setting(struct device *dev)
>  {
>  	u32 val = 0;
>  
> -	if (!sdhci_acpi_byt())
> +	if (!soc_intel_is_byt())
>  		return;
>  
>  	if (iosf_mbi_read(BYT_IOSF_SCCEP, MBI_CR_READ, BYT_IOSF_OCP_NETCTRL0,
> @@ -282,7 +271,7 @@ static void sdhci_acpi_byt_setting(struct device *dev)
>  
>  static bool sdhci_acpi_byt_defer(struct device *dev)
>  {
> -	if (!sdhci_acpi_byt())
> +	if (!soc_intel_is_byt())
>  		return false;
>  
>  	if (!iosf_mbi_available())
> 

