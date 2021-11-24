Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6CA45C85F
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Nov 2021 16:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhKXPTZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Nov 2021 10:19:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:43962 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230158AbhKXPTY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Nov 2021 10:19:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="222517019"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="222517019"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 07:16:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="741221507"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga006.fm.intel.com with ESMTP; 24 Nov 2021 07:16:11 -0800
Subject: Re: [PATCH v2 6/7] mmc: sdhci-acpi: Remove special handling for GPD
 win/pocket devices
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20211122170536.7725-1-hdegoede@redhat.com>
 <20211122170536.7725-7-hdegoede@redhat.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a26356f7-16e7-8d57-af1f-a087354df728@intel.com>
Date:   Wed, 24 Nov 2021 17:16:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211122170536.7725-7-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 22/11/2021 19:05, Hans de Goede wrote:
> Remove the special sdhci_acpi_no_fixup_child_power() helper which was
> added to avoid triggering an ACPI tables bug on the GPD win/pocket
> devices.
> 
> The ACPI child-device triggering this bug has now been added to the
> acpi_device_override_status() quirk table, so that its status
> field is set to all 0 (instead of the wrong return value from the _STA
> ACPI method). This removes the need for the special handling in
> the sdhci-acpi code.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
> - No changes in v2 of this patch-series
> ---
>  drivers/mmc/host/sdhci-acpi.c | 61 ++---------------------------------
>  1 file changed, 3 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index f1ef0d28b0dd..1461aae13c19 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -34,7 +34,6 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/iosf_mbi.h>
> -#include <linux/pci.h>
>  #endif
>  
>  #include "sdhci.h"
> @@ -250,16 +249,6 @@ static bool sdhci_acpi_byt(void)
>  	return x86_match_cpu(byt);
>  }
>  
> -static bool sdhci_acpi_cht(void)
> -{
> -	static const struct x86_cpu_id cht[] = {
> -		X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT, NULL),
> -		{}
> -	};
> -
> -	return x86_match_cpu(cht);
> -}
> -
>  #define BYT_IOSF_SCCEP			0x63
>  #define BYT_IOSF_OCP_NETCTRL0		0x1078
>  #define BYT_IOSF_OCP_TIMEOUT_BASE	GENMASK(10, 8)
> @@ -304,43 +293,6 @@ static bool sdhci_acpi_byt_defer(struct device *dev)
>  	return false;
>  }
>  
> -static bool sdhci_acpi_cht_pci_wifi(unsigned int vendor, unsigned int device,
> -				    unsigned int slot, unsigned int parent_slot)
> -{
> -	struct pci_dev *dev, *parent, *from = NULL;
> -
> -	while (1) {
> -		dev = pci_get_device(vendor, device, from);
> -		pci_dev_put(from);
> -		if (!dev)
> -			break;
> -		parent = pci_upstream_bridge(dev);
> -		if (ACPI_COMPANION(&dev->dev) && PCI_SLOT(dev->devfn) == slot &&
> -		    parent && PCI_SLOT(parent->devfn) == parent_slot &&
> -		    !pci_upstream_bridge(parent)) {
> -			pci_dev_put(dev);
> -			return true;
> -		}
> -		from = dev;
> -	}
> -
> -	return false;
> -}
> -
> -/*
> - * GPDwin uses PCI wifi which conflicts with SDIO's use of
> - * acpi_device_fix_up_power() on child device nodes. Identifying GPDwin is
> - * problematic, but since SDIO is only used for wifi, the presence of the PCI
> - * wifi card in the expected slot with an ACPI companion node, is used to
> - * indicate that acpi_device_fix_up_power() should be avoided.
> - */
> -static inline bool sdhci_acpi_no_fixup_child_power(struct acpi_device *adev)
> -{
> -	return sdhci_acpi_cht() &&
> -	       acpi_dev_hid_uid_match(adev, "80860F14", "2") &&
> -	       sdhci_acpi_cht_pci_wifi(0x14e4, 0x43ec, 0, 28);
> -}
> -
>  #else
>  
>  static inline void sdhci_acpi_byt_setting(struct device *dev)
> @@ -352,11 +304,6 @@ static inline bool sdhci_acpi_byt_defer(struct device *dev)
>  	return false;
>  }
>  
> -static inline bool sdhci_acpi_no_fixup_child_power(struct acpi_device *adev)
> -{
> -	return false;
> -}
> -
>  #endif
>  
>  static int bxt_get_cd(struct mmc_host *mmc)
> @@ -861,11 +808,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  
>  	/* Power on the SDHCI controller and its children */
>  	acpi_device_fix_up_power(device);
> -	if (!sdhci_acpi_no_fixup_child_power(device)) {
> -		list_for_each_entry(child, &device->children, node)
> -			if (child->status.present && child->status.enabled)
> -				acpi_device_fix_up_power(child);
> -	}
> +	list_for_each_entry(child, &device->children, node)
> +		if (child->status.present && child->status.enabled)
> +			acpi_device_fix_up_power(child);
>  
>  	if (sdhci_acpi_byt_defer(dev))
>  		return -EPROBE_DEFER;
> 

