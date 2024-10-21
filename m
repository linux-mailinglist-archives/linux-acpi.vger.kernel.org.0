Return-Path: <linux-acpi+bounces-8873-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953539A66C8
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 13:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489DF282331
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942F01E573D;
	Mon, 21 Oct 2024 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6ZJgxmi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570161D221A;
	Mon, 21 Oct 2024 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510795; cv=none; b=YuH2nZeVF7vwzPvMUKMl9NrlUrzChzUEW0dmo4xM7ZsfKBEstNnkUOYuuy/wxtWVfVMhA33ISjLFdIsNqW011OkCJruu9lv0E61RBz6SdloGRKnfOJDNPm1wiGrbFOGMHpyJPX0ear8O5L0dXqIT+MHunof3pWcY1dR525tQR2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510795; c=relaxed/simple;
	bh=u7cpiVqoeOklwP3Eb20dPAFdje8IQD6Lx114kT0wFS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4I0fsYGMlx7GQJRLvW9o1mEp/u9/tT5Pk2bA5fBuyYHOvChhoZKynjqEBGnKNoeKbMDKrLO2eCLNGzz+LmTqRWo5FHr6cIpcguA7rGMbpNWng8OAnUjSao0/BhNgfQtpZOIdcGKMLVaITULUv3EsqaBnS72308NvkGeo90AYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6ZJgxmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2C1C4CEC3;
	Mon, 21 Oct 2024 11:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729510795;
	bh=u7cpiVqoeOklwP3Eb20dPAFdje8IQD6Lx114kT0wFS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a6ZJgxmikHn+7Wwc/v5h5D47C96hD+PWllnoOGsxby6utvdIAvI2o19JZxdjnlcfr
	 hvfHJa8KOk6cRfKagn/656YsNm0U4zlhXsUea6EbkipzRnBO/HxZDTPsMd3jRkp+0J
	 gprJgPRGnxJLiADy8PTiIxQRKi6xvoK5e/Yeq11x3BYiyZKgYjvRMGMSDhlw7pAxno
	 xvteVk5OduNihbJssHzsmiVqrz1Nz4Ve2nfdY0c8+qFeu41wjcrQ2C5QPkcL2RS+f4
	 X5JyNbxvcGjMC8gJtbKiU8+x+mtGZA+uCqlOq4FE/B7wjGOtOD3zzD2TggUAV3thVb
	 /NoEDzd3INbKw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-288642376bcso2235263fac.1;
        Mon, 21 Oct 2024 04:39:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBOdJtMG5AVo+FHg+x8V2+iTO3T4U6RPMF7rqF6qMpknQmAfHxuVQJCGI4e52eUBF4aNG9uMJVVJ+1tc6t@vger.kernel.org, AJvYcCUjCyOZHd8DtTI9NKWtZTdX1wisfDxowqc2qRHSOWh9anDxzPWlBLhWfd3eeWE4mXfsOE1oM6pWR7QqxYU=@vger.kernel.org, AJvYcCWWMeN30DnsSIGg9gMb/+zoUWSACvWittWlbNF8oKYjQhhF1WLJVUwmPu96VJrTce71ot9cXOvPQbABJH4wWD3p+72jug==@vger.kernel.org, AJvYcCXMMOw84uppJfcykzX9cTkCFQpUO4Uk5ng7aAgc7H9YWyMd3ynUFLCp8+MVRrnwf/wtDaDDAG4KgDMT@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYhP6uLHEmZMfzumqkkXAqejVmpBGCJGCxlgSwXL381SL01ac
	rEYIAWY/F7QBwk1LyEuyx/EWZUA4HRbPRFIzdQMAeKcQAkFBej5gmhBJwso92lzq55sqGpO1mN/
	8OrWfh+Kf5xB41uF1xqFKcU8TgNk=
X-Google-Smtp-Source: AGHT+IEGm9wUSukDAtEp3hFUdy5XpRl4ISERWG3V3XUGhuGl/CPLH7vUfXN2DT0aGkUZj+IY9Rmpz2rl7QUXTz3Fh/M=
X-Received: by 2002:a05:6870:46a6:b0:277:f722:45e1 with SMTP id
 586e51a60fabf-2892c2df4demr7593010fac.17.1729510794174; Mon, 21 Oct 2024
 04:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011061948.3211423-1-arnd@kernel.org>
In-Reply-To: <20241011061948.3211423-1-arnd@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 13:39:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jX1Ga9g8BweYJT2GQsJh03pD_imrY7tCP-Xg_gq0EbOA@mail.gmail.com>
Message-ID: <CAJZ5v0jX1Ga9g8BweYJT2GQsJh03pD_imrY7tCP-Xg_gq0EbOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] acpi: make EC support compile-time conditional
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 8:19=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
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

I think I can pick up this one as the other two patches in the series
don't depend on it.

Any concerns about doing that?

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
>           makes it possible to force the kernel to return "5" as the supp=
orted
>           ACPI revision via the "acpi_rev_override" command line switch.
>
> +config ACPI_EC
> +       bool "Embedded Controller"
> +       depends on HAS_IOPORT
> +       default X86
> +       help
> +         This driver handles communication with the microcontroller
> +         on many x86 laptops and other machines.
> +
>  config ACPI_EC_DEBUGFS
>         tristate "EC read/write access through /sys/kernel/debug/ec"
> +       depends on ACPI_EC
>         help
>           Say N to disable Embedded Controller /sys/kernel/debug interfac=
e
>
> @@ -433,7 +442,7 @@ config ACPI_HOTPLUG_IOAPIC
>
>  config ACPI_SBS
>         tristate "Smart Battery System"
> -       depends on X86
> +       depends on X86 && ACPI_EC
>         select POWER_SUPPLY
>         help
>           This driver supports the Smart Battery System, another
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 61ca4afe83dc..40208a0f5dfb 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -41,7 +41,7 @@ acpi-y                                +=3D resource.o
>  acpi-y                         +=3D acpi_processor.o
>  acpi-y                         +=3D processor_core.o
>  acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) +=3D processor_pdc.o
> -acpi-y                         +=3D ec.o
> +acpi-$(CONFIG_ACPI_EC)         +=3D ec.o
>  acpi-$(CONFIG_ACPI_DOCK)       +=3D dock.o
>  acpi-$(CONFIG_PCI)             +=3D pci_root.o pci_link.o pci_irq.o
>  obj-$(CONFIG_ACPI_MCFG)                +=3D pci_mcfg.o
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
> +static inline int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query=
_bit,
> +                             acpi_handle handle, acpi_ec_query_func func=
,
> +                             void *data)
> +{
> +       return -ENXIO;
> +}
> +static inline void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 q=
uery_bit) {}
> +static inline void acpi_ec_register_opregions(struct acpi_device *adev) =
{}
> +
> +static inline void acpi_ec_flush_work(void) {}
> +static inline bool acpi_ec_dispatch_gpe(void)
> +{
> +       return false;
> +}
> +
> +#endif
>
>  /*----------------------------------------------------------------------=
----
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
>  #define ACPI_SMB_HC_CLASS      "smbus_host_ctl"
>  #define ACPI_SMB_HC_DEVICE_NAME        "ACPI SMBus HC"
> @@ -236,12 +237,6 @@ static int smbus_alarm(void *context)
>         return 0;
>  }
>
> -typedef int (*acpi_ec_query_func) (void *data);
> -
> -extern int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
> -                             acpi_handle handle, acpi_ec_query_func func=
,
> -                             void *data);
> -
>  static int acpi_smbus_hc_add(struct acpi_device *device)
>  {
>         int status;
> @@ -278,8 +273,6 @@ static int acpi_smbus_hc_add(struct acpi_device *devi=
ce)
>         return 0;
>  }
>
> -extern void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bi=
t);
> -
>  static void acpi_smbus_hc_remove(struct acpi_device *device)
>  {
>         struct acpi_smb_hc *hc;
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 7c8dd0abcfdf..8fb33c90482f 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -238,6 +238,7 @@ config APPLICOM
>  config SONYPI
>         tristate "Sony Vaio Programmable I/O Control Device support"
>         depends on X86_32 && PCI && INPUT
> +       depends on ACPI_EC || !ACPI
>         help
>           This driver enables access to the Sony Programmable I/O Control
>           Device which can be found in many (all ?) Sony Vaio laptops.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 65ea92529406..25ae0a00ea2c 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1747,7 +1747,7 @@ source "drivers/hwmon/occ/Kconfig"
>
>  config SENSORS_OXP
>         tristate "OneXPlayer EC fan control"
> -       depends on ACPI
> +       depends on ACPI_EC
>         depends on X86
>         help
>                 If you say yes here you get support for fan readings and =
control over
> @@ -2586,6 +2586,7 @@ config SENSORS_ASUS_WMI
>  config SENSORS_ASUS_EC
>         tristate "ASUS EC Sensors"
>         depends on X86
> +       depends on ACPI_EC
>         help
>           If you say yes here you get support for the ACPI embedded contr=
oller
>           hardware monitoring interface found in ASUS motherboards. The d=
river
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 3875abba5a79..0258dd879d64 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -52,6 +52,7 @@ config WMI_BMOF
>  config HUAWEI_WMI
>         tristate "Huawei WMI laptop extras driver"
>         depends on ACPI_BATTERY
> +       depends on ACPI_EC
>         depends on ACPI_WMI
>         depends on INPUT
>         select INPUT_SPARSEKMAP
> @@ -147,7 +148,7 @@ config YT2_1380
>
>  config ACERHDF
>         tristate "Acer Aspire One temperature and fan driver"
> -       depends on ACPI && THERMAL
> +       depends on ACPI_EC && THERMAL
>         select THERMAL_GOV_BANG_BANG
>         help
>           This is a driver for Acer Aspire One netbooks. It allows to acc=
ess
> @@ -186,6 +187,7 @@ config ACER_WMI
>         depends on SERIO_I8042
>         depends on INPUT
>         depends on RFKILL || RFKILL =3D n
> +       depends on ACPI_EC
>         depends on ACPI_WMI
>         depends on ACPI_VIDEO || ACPI_VIDEO =3D n
>         depends on HWMON
> @@ -334,7 +336,7 @@ config MERAKI_MX100
>
>  config EEEPC_LAPTOP
>         tristate "Eee PC Hotkey Driver"
> -       depends on ACPI
> +       depends on ACPI_EC
>         depends on INPUT
>         depends on RFKILL || RFKILL =3D n
>         depends on ACPI_VIDEO || ACPI_VIDEO =3D n
> @@ -503,7 +505,7 @@ config SENSORS_HDAPS
>
>  config THINKPAD_ACPI
>         tristate "ThinkPad ACPI Laptop Extras"
> -       depends on ACPI
> +       depends on ACPI_EC
>         depends on ACPI_BATTERY
>         depends on INPUT
>         depends on RFKILL || RFKILL =3D n
> @@ -682,7 +684,7 @@ config MEEGOPAD_ANX7428
>
>  config MSI_EC
>         tristate "MSI EC Extras"
> -       depends on ACPI
> +       depends on ACPI_EC
>         depends on ACPI_BATTERY
>         help
>           This driver allows various MSI laptops' functionalities to be
> @@ -690,7 +692,7 @@ config MSI_EC
>
>  config MSI_LAPTOP
>         tristate "MSI Laptop Extras"
> -       depends on ACPI
> +       depends on ACPI_EC
>         depends on BACKLIGHT_CLASS_DEVICE
>         depends on ACPI_VIDEO || ACPI_VIDEO =3D n
>         depends on RFKILL
> @@ -796,7 +798,7 @@ config SAMSUNG_LAPTOP
>
>  config SAMSUNG_Q10
>         tristate "Samsung Q10 Extras"
> -       depends on ACPI
> +       depends on ACPI_EC
>         select BACKLIGHT_CLASS_DEVICE
>         help
>           This driver provides support for backlight control on Samsung Q=
10
> @@ -804,7 +806,7 @@ config SAMSUNG_Q10
>
>  config ACPI_TOSHIBA
>         tristate "Toshiba Laptop Extras"
> -       depends on ACPI
> +       depends on ACPI_EC
>         depends on ACPI_BATTERY
>         depends on ACPI_WMI
>         select LEDS_CLASS
> @@ -904,7 +906,7 @@ config ACPI_CMPC
>
>  config COMPAL_LAPTOP
>         tristate "Compal (and others) Laptop Extras"
> -       depends on ACPI
> +       depends on ACPI_EC
>         depends on BACKLIGHT_CLASS_DEVICE
>         depends on ACPI_VIDEO || ACPI_VIDEO =3D n
>         depends on RFKILL
> @@ -949,7 +951,7 @@ config PANASONIC_LAPTOP
>
>  config SONY_LAPTOP
>         tristate "Sony Laptop Extras"
> -       depends on ACPI
> +       depends on ACPI_EC
>         depends on ACPI_VIDEO || ACPI_VIDEO =3D n
>         depends on BACKLIGHT_CLASS_DEVICE
>         depends on INPUT
> @@ -972,7 +974,7 @@ config SONYPI_COMPAT
>
>  config SYSTEM76_ACPI
>         tristate "System76 ACPI Driver"
> -       depends on ACPI
> +       depends on ACPI_EC
>         depends on ACPI_BATTERY
>         depends on HWMON
>         depends on INPUT
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/del=
l/Kconfig
> index 68a49788a396..dc21227dd66e 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -194,6 +194,7 @@ config DELL_WMI
>  config DELL_WMI_PRIVACY
>         bool "Dell WMI Hardware Privacy Support"
>         depends on DELL_WMI
> +       depends on ACPI_EC
>         help
>           This option adds integration with the "Dell Hardware Privacy"
>           feature of Dell laptops to the dell-wmi driver.
> diff --git a/drivers/platform/x86/hp/Kconfig b/drivers/platform/x86/hp/Kc=
onfig
> index d776761cd5fd..dd51491b9bcd 100644
> --- a/drivers/platform/x86/hp/Kconfig
> +++ b/drivers/platform/x86/hp/Kconfig
> @@ -37,6 +37,7 @@ config HP_ACCEL
>  config HP_WMI
>         tristate "HP WMI extras"
>         default m
> +       depends on ACPI_EC
>         depends on ACPI_WMI
>         depends on INPUT
>         depends on RFKILL || RFKILL =3D n
> diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/in=
tel/Kconfig
> index ad50bbabec61..eb698dcb9af9 100644
> --- a/drivers/platform/x86/intel/Kconfig
> +++ b/drivers/platform/x86/intel/Kconfig
> @@ -62,7 +62,7 @@ config INTEL_INT0002_VGPIO
>
>  config INTEL_OAKTRAIL
>         tristate "Intel Oaktrail Platform Extras"
> -       depends on ACPI
> +       depends on ACPI_EC
>         depends on ACPI_VIDEO || ACPI_VIDEO=3Dn
>         depends on RFKILL && BACKLIGHT_CLASS_DEVICE && ACPI
>         help
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
> @@ -1176,6 +1174,12 @@ static inline int acpi_subsys_suspend(struct devic=
e *dev) { return 0; }
>  static inline int acpi_subsys_freeze(struct device *dev) { return 0; }
>  static inline int acpi_subsys_poweroff(struct device *dev) { return 0; }
>  static inline int acpi_subsys_restore_early(struct device *dev) { return=
 0; }
> +#endif
> +
> +#if defined(CONFIG_ACPI_EC) && defined(CONFIG_PM_SLEEP)
> +void acpi_ec_mark_gpe_for_wake(void);
> +void acpi_ec_set_gpe_wake_mask(u8 action);
> +#else
>  static inline void acpi_ec_mark_gpe_for_wake(void) {}
>  static inline void acpi_ec_set_gpe_wake_mask(u8 action) {}
>  #endif
> --
> 2.39.5
>

