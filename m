Return-Path: <linux-acpi+bounces-8727-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DA599B2EA
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2024 12:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD821C21737
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2024 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F8415383E;
	Sat, 12 Oct 2024 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/F/foFB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB6A22334
	for <linux-acpi@vger.kernel.org>; Sat, 12 Oct 2024 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728328; cv=none; b=Psn7fXOqys8F6wGJcs4TJenAEo6UMB/PNP3MzM250k1uXJN4WQaXrF3VRnCimGZbKy7uLKsc3FFSCtN47HtXo1jzr9harddQWJBGPGNimF/czZD0GSNuoZMkW+ZW1yt3283bh0430dxzuCsBeS3k8ssE3/0uXiXVzIFBnvMSAeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728328; c=relaxed/simple;
	bh=4xOM8MC2EwyqmoD8ZTIT4Mo7EV8Znm3HaYlhK0DGMMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TawYF/FdWQZu+SDNVaN6/iP2AFw+OBK27LidY/MI7POGUeHAXg8jGyXaR3S9BWBHb7UwSkMlqJlRqRvDQlPzQ7b8uTOaxhnENc/lqRhl5rne9gfHIkevBr2XbR/98UD3q8X+EHB9DSzDBlRE1cV4DXQEI3qA73uPEfcGXm4b+gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/F/foFB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728728324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EGQy1IKdMVdQQEEg6lkanhZmI8siGes/J0zO83YsB0=;
	b=i/F/foFB8SgaKCoXQCV1a9+cWQ5byQeCAgd79b0td95Qph6GPl8xBitxnNyK04auCMpw31
	l4qSmp7Z+K/hKdUm/IZW/G9Hfl9T6DHL65bk0r1ySU1cvHg8+Nd3Dadjuy+a54i8C9dpJo
	dmuTLs+bMQ3eNV6uesIqpLHVECacqi8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-BOGS7jB7MZK9YF1RSUjclQ-1; Sat, 12 Oct 2024 06:18:43 -0400
X-MC-Unique: BOGS7jB7MZK9YF1RSUjclQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a99efc7d881so25146966b.1
        for <linux-acpi@vger.kernel.org>; Sat, 12 Oct 2024 03:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728728322; x=1729333122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EGQy1IKdMVdQQEEg6lkanhZmI8siGes/J0zO83YsB0=;
        b=dmhP2zF6gqOse3xmOKFgmceMs+dJJik+9dnSuEBheX2taAdVGmpKqnTJnWZ9GRwCgF
         g344H+epzA0Qov1y233V5njyff+BLo1yA+i86u6MNjNtPIw4aTdnnb1xSF2XAXiZHCiL
         /bfJQxXBg5adnsRqUZC1EyNGpeONPSmbFNIu7tDRC+Dl50ajBoxGlfLOVYsMuxF3leKa
         /cSl6mtFMVDHb0yzUANUbBsONue0UKVxbNccH1xW2R60TdgMVP5MnYxOsNG+2wHpyupm
         IDwL5sVedSadzaKTtwTERPIDCPDDX4RiJiFwNWAz4ce1kaq9LBTMflJr6Cm8AK5xDHOf
         aUJA==
X-Forwarded-Encrypted: i=1; AJvYcCValuHgtJQXNiHdbrQMi9m4GVyF29v4QKcgvxlLYKEEL8NhbZMxrtPPIv8hKFJicWdWycg5ZKdd8mhO@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzERfxWmhaCeawNpgpJFrMTc6neZtJO3XZFLJBvogqsqhUUYz
	jM19RFgRDI+PSv02b/awT5U0hNip/hNK6IoGqqORryspCXpCse7zMFISb+usB7ufhtMnE2+pWTN
	fMeFvf7UePt5ogCrsvApbk4CfiGzDIqELxGorOIFdOVW+Qr/zxhE53vVO+5o=
X-Received: by 2002:a17:906:f59b:b0:a99:f6ee:1ee3 with SMTP id a640c23a62f3a-a99f6ee218bmr24628866b.43.1728728321936;
        Sat, 12 Oct 2024 03:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRlYyzh/lT/w96zA6tYryrsPaeMciJc2g9vf0Y81D3NpdcI+siPuUrgbFzloh58FkgpR5Vag==
X-Received: by 2002:a17:906:f59b:b0:a99:f6ee:1ee3 with SMTP id a640c23a62f3a-a99f6ee218bmr24626566b.43.1728728321456;
        Sat, 12 Oct 2024 03:18:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99e79a5e10sm71696666b.187.2024.10.12.03.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 03:18:40 -0700 (PDT)
Message-ID: <2c880375-a487-4965-be83-bcd67c616e34@redhat.com>
Date: Sat, 12 Oct 2024 12:18:39 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] acpi: make EC support compile-time conditional
To: Arnd Bergmann <arnd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Len Brown <lenb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20241011061948.3211423-1-arnd@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241011061948.3211423-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11-Oct-24 8:18 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The embedded controller code is mainly used on x86 laptops and cannot
> work without PC style I/O port access.
> 
> Make this a user-visible configuration option that is default enabled
> on x86 but otherwise disabled, and that can never be enabled unless
> CONFIG_HAS_IOPORT is also available.
> 
> The empty stubs in internal.h help ignore the EC code in configurations
> that don't support it. In order to see those stubs, the sbshc code also
> has to include this header and drop duplicate declarations.
> 
> All the direct callers of ec_read/ec_write already had an x86
> dependency and now also need to depend on APCI_EC.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, patch looks good to me.

For platform/driver/x86:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/Kconfig               | 11 ++++++++++-
>  drivers/acpi/Makefile              |  2 +-
>  drivers/acpi/internal.h            | 25 +++++++++++++++++++++++++
>  drivers/acpi/sbshc.c               |  9 +--------
>  drivers/char/Kconfig               |  1 +
>  drivers/hwmon/Kconfig              |  3 ++-
>  drivers/platform/x86/Kconfig       | 22 ++++++++++++----------
>  drivers/platform/x86/dell/Kconfig  |  1 +
>  drivers/platform/x86/hp/Kconfig    |  1 +
>  drivers/platform/x86/intel/Kconfig |  2 +-
>  include/linux/acpi.h               |  8 ++++++--
>  11 files changed, 61 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index d67f63d93b2a..d65cd08ba8e1 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -132,8 +132,17 @@ config ACPI_REV_OVERRIDE_POSSIBLE
>  	  makes it possible to force the kernel to return "5" as the supported
>  	  ACPI revision via the "acpi_rev_override" command line switch.
>  
> +config ACPI_EC
> +	bool "Embedded Controller"
> +	depends on HAS_IOPORT
> +	default X86
> +	help
> +	  This driver handles communication with the microcontroller
> +	  on many x86 laptops and other machines.
> +
>  config ACPI_EC_DEBUGFS
>  	tristate "EC read/write access through /sys/kernel/debug/ec"
> +	depends on ACPI_EC
>  	help
>  	  Say N to disable Embedded Controller /sys/kernel/debug interface
>  
> @@ -433,7 +442,7 @@ config ACPI_HOTPLUG_IOAPIC
>  
>  config ACPI_SBS
>  	tristate "Smart Battery System"
> -	depends on X86
> +	depends on X86 && ACPI_EC
>  	select POWER_SUPPLY
>  	help
>  	  This driver supports the Smart Battery System, another
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 61ca4afe83dc..40208a0f5dfb 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -41,7 +41,7 @@ acpi-y				+= resource.o
>  acpi-y				+= acpi_processor.o
>  acpi-y				+= processor_core.o
>  acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) += processor_pdc.o
> -acpi-y				+= ec.o
> +acpi-$(CONFIG_ACPI_EC)		+= ec.o
>  acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
>  acpi-$(CONFIG_PCI)		+= pci_root.o pci_link.o pci_irq.o
>  obj-$(CONFIG_ACPI_MCFG)		+= pci_mcfg.o
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index ced7dff9a5db..00910ccd7eda 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -215,6 +215,8 @@ extern struct acpi_ec *first_ec;
>  /* External interfaces use first EC only, so remember */
>  typedef int (*acpi_ec_query_func) (void *data);
>  
> +#ifdef CONFIG_ACPI_EC
> +
>  void acpi_ec_init(void);
>  void acpi_ec_ecdt_probe(void);
>  void acpi_ec_dsdt_probe(void);
> @@ -231,6 +233,29 @@ void acpi_ec_flush_work(void);
>  bool acpi_ec_dispatch_gpe(void);
>  #endif
>  
> +#else
> +
> +static inline void acpi_ec_init(void) {}
> +static inline void acpi_ec_ecdt_probe(void) {}
> +static inline void acpi_ec_dsdt_probe(void) {}
> +static inline void acpi_ec_block_transactions(void) {}
> +static inline void acpi_ec_unblock_transactions(void) {}
> +static inline int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
> +			      acpi_handle handle, acpi_ec_query_func func,
> +			      void *data)
> +{
> +	return -ENXIO;
> +}
> +static inline void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit) {}
> +static inline void acpi_ec_register_opregions(struct acpi_device *adev) {}
> +
> +static inline void acpi_ec_flush_work(void) {}
> +static inline bool acpi_ec_dispatch_gpe(void)
> +{
> +	return false;
> +}
> +
> +#endif
>  
>  /*--------------------------------------------------------------------------
>                                    Suspend/Resume
> diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
> index 16f2daaa2c45..2b63cd18cca2 100644
> --- a/drivers/acpi/sbshc.c
> +++ b/drivers/acpi/sbshc.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include "sbshc.h"
> +#include "internal.h"
>  
>  #define ACPI_SMB_HC_CLASS	"smbus_host_ctl"
>  #define ACPI_SMB_HC_DEVICE_NAME	"ACPI SMBus HC"
> @@ -236,12 +237,6 @@ static int smbus_alarm(void *context)
>  	return 0;
>  }
>  
> -typedef int (*acpi_ec_query_func) (void *data);
> -
> -extern int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
> -			      acpi_handle handle, acpi_ec_query_func func,
> -			      void *data);
> -
>  static int acpi_smbus_hc_add(struct acpi_device *device)
>  {
>  	int status;
> @@ -278,8 +273,6 @@ static int acpi_smbus_hc_add(struct acpi_device *device)
>  	return 0;
>  }
>  
> -extern void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit);
> -
>  static void acpi_smbus_hc_remove(struct acpi_device *device)
>  {
>  	struct acpi_smb_hc *hc;
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 7c8dd0abcfdf..8fb33c90482f 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -238,6 +238,7 @@ config APPLICOM
>  config SONYPI
>  	tristate "Sony Vaio Programmable I/O Control Device support"
>  	depends on X86_32 && PCI && INPUT
> +	depends on ACPI_EC || !ACPI
>  	help
>  	  This driver enables access to the Sony Programmable I/O Control
>  	  Device which can be found in many (all ?) Sony Vaio laptops.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 65ea92529406..25ae0a00ea2c 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1747,7 +1747,7 @@ source "drivers/hwmon/occ/Kconfig"
>  
>  config SENSORS_OXP
>  	tristate "OneXPlayer EC fan control"
> -	depends on ACPI
> +	depends on ACPI_EC
>  	depends on X86
>  	help
>  		If you say yes here you get support for fan readings and control over
> @@ -2586,6 +2586,7 @@ config SENSORS_ASUS_WMI
>  config SENSORS_ASUS_EC
>  	tristate "ASUS EC Sensors"
>  	depends on X86
> +	depends on ACPI_EC
>  	help
>  	  If you say yes here you get support for the ACPI embedded controller
>  	  hardware monitoring interface found in ASUS motherboards. The driver
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 3875abba5a79..0258dd879d64 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -52,6 +52,7 @@ config WMI_BMOF
>  config HUAWEI_WMI
>  	tristate "Huawei WMI laptop extras driver"
>  	depends on ACPI_BATTERY
> +	depends on ACPI_EC
>  	depends on ACPI_WMI
>  	depends on INPUT
>  	select INPUT_SPARSEKMAP
> @@ -147,7 +148,7 @@ config YT2_1380
>  
>  config ACERHDF
>  	tristate "Acer Aspire One temperature and fan driver"
> -	depends on ACPI && THERMAL
> +	depends on ACPI_EC && THERMAL
>  	select THERMAL_GOV_BANG_BANG
>  	help
>  	  This is a driver for Acer Aspire One netbooks. It allows to access
> @@ -186,6 +187,7 @@ config ACER_WMI
>  	depends on SERIO_I8042
>  	depends on INPUT
>  	depends on RFKILL || RFKILL = n
> +	depends on ACPI_EC
>  	depends on ACPI_WMI
>  	depends on ACPI_VIDEO || ACPI_VIDEO = n
>  	depends on HWMON
> @@ -334,7 +336,7 @@ config MERAKI_MX100
>  
>  config EEEPC_LAPTOP
>  	tristate "Eee PC Hotkey Driver"
> -	depends on ACPI
> +	depends on ACPI_EC
>  	depends on INPUT
>  	depends on RFKILL || RFKILL = n
>  	depends on ACPI_VIDEO || ACPI_VIDEO = n
> @@ -503,7 +505,7 @@ config SENSORS_HDAPS
>  
>  config THINKPAD_ACPI
>  	tristate "ThinkPad ACPI Laptop Extras"
> -	depends on ACPI
> +	depends on ACPI_EC
>  	depends on ACPI_BATTERY
>  	depends on INPUT
>  	depends on RFKILL || RFKILL = n
> @@ -682,7 +684,7 @@ config MEEGOPAD_ANX7428
>  
>  config MSI_EC
>  	tristate "MSI EC Extras"
> -	depends on ACPI
> +	depends on ACPI_EC
>  	depends on ACPI_BATTERY
>  	help
>  	  This driver allows various MSI laptops' functionalities to be
> @@ -690,7 +692,7 @@ config MSI_EC
>  
>  config MSI_LAPTOP
>  	tristate "MSI Laptop Extras"
> -	depends on ACPI
> +	depends on ACPI_EC
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	depends on ACPI_VIDEO || ACPI_VIDEO = n
>  	depends on RFKILL
> @@ -796,7 +798,7 @@ config SAMSUNG_LAPTOP
>  
>  config SAMSUNG_Q10
>  	tristate "Samsung Q10 Extras"
> -	depends on ACPI
> +	depends on ACPI_EC
>  	select BACKLIGHT_CLASS_DEVICE
>  	help
>  	  This driver provides support for backlight control on Samsung Q10
> @@ -804,7 +806,7 @@ config SAMSUNG_Q10
>  
>  config ACPI_TOSHIBA
>  	tristate "Toshiba Laptop Extras"
> -	depends on ACPI
> +	depends on ACPI_EC
>  	depends on ACPI_BATTERY
>  	depends on ACPI_WMI
>  	select LEDS_CLASS
> @@ -904,7 +906,7 @@ config ACPI_CMPC
>  
>  config COMPAL_LAPTOP
>  	tristate "Compal (and others) Laptop Extras"
> -	depends on ACPI
> +	depends on ACPI_EC
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	depends on ACPI_VIDEO || ACPI_VIDEO = n
>  	depends on RFKILL
> @@ -949,7 +951,7 @@ config PANASONIC_LAPTOP
>  
>  config SONY_LAPTOP
>  	tristate "Sony Laptop Extras"
> -	depends on ACPI
> +	depends on ACPI_EC
>  	depends on ACPI_VIDEO || ACPI_VIDEO = n
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	depends on INPUT
> @@ -972,7 +974,7 @@ config SONYPI_COMPAT
>  
>  config SYSTEM76_ACPI
>  	tristate "System76 ACPI Driver"
> -	depends on ACPI
> +	depends on ACPI_EC
>  	depends on ACPI_BATTERY
>  	depends on HWMON
>  	depends on INPUT
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index 68a49788a396..dc21227dd66e 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -194,6 +194,7 @@ config DELL_WMI
>  config DELL_WMI_PRIVACY
>  	bool "Dell WMI Hardware Privacy Support"
>  	depends on DELL_WMI
> +	depends on ACPI_EC
>  	help
>  	  This option adds integration with the "Dell Hardware Privacy"
>  	  feature of Dell laptops to the dell-wmi driver.
> diff --git a/drivers/platform/x86/hp/Kconfig b/drivers/platform/x86/hp/Kconfig
> index d776761cd5fd..dd51491b9bcd 100644
> --- a/drivers/platform/x86/hp/Kconfig
> +++ b/drivers/platform/x86/hp/Kconfig
> @@ -37,6 +37,7 @@ config HP_ACCEL
>  config HP_WMI
>  	tristate "HP WMI extras"
>  	default m
> +	depends on ACPI_EC
>  	depends on ACPI_WMI
>  	depends on INPUT
>  	depends on RFKILL || RFKILL = n
> diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
> index ad50bbabec61..eb698dcb9af9 100644
> --- a/drivers/platform/x86/intel/Kconfig
> +++ b/drivers/platform/x86/intel/Kconfig
> @@ -62,7 +62,7 @@ config INTEL_INT0002_VGPIO
>  
>  config INTEL_OAKTRAIL
>  	tristate "Intel Oaktrail Platform Extras"
> -	depends on ACPI
> +	depends on ACPI_EC
>  	depends on ACPI_VIDEO || ACPI_VIDEO=n
>  	depends on RFKILL && BACKLIGHT_CLASS_DEVICE && ACPI
>  	help
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4d5ee84c468b..7dd24acd9ffe 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1164,8 +1164,6 @@ int acpi_subsys_suspend_noirq(struct device *dev);
>  int acpi_subsys_suspend(struct device *dev);
>  int acpi_subsys_freeze(struct device *dev);
>  int acpi_subsys_poweroff(struct device *dev);
> -void acpi_ec_mark_gpe_for_wake(void);
> -void acpi_ec_set_gpe_wake_mask(u8 action);
>  int acpi_subsys_restore_early(struct device *dev);
>  #else
>  static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
> @@ -1176,6 +1174,12 @@ static inline int acpi_subsys_suspend(struct device *dev) { return 0; }
>  static inline int acpi_subsys_freeze(struct device *dev) { return 0; }
>  static inline int acpi_subsys_poweroff(struct device *dev) { return 0; }
>  static inline int acpi_subsys_restore_early(struct device *dev) { return 0; }
> +#endif
> +
> +#if defined(CONFIG_ACPI_EC) && defined(CONFIG_PM_SLEEP)
> +void acpi_ec_mark_gpe_for_wake(void);
> +void acpi_ec_set_gpe_wake_mask(u8 action);
> +#else
>  static inline void acpi_ec_mark_gpe_for_wake(void) {}
>  static inline void acpi_ec_set_gpe_wake_mask(u8 action) {}
>  #endif


