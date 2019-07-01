Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D917B552B3
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2019 17:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfFYPAX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jun 2019 11:00:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:19111 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730777AbfFYPAX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Jun 2019 11:00:23 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BFEE264AAAB815BAB1F0;
        Tue, 25 Jun 2019 23:00:16 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Jun 2019
 23:00:11 +0800
Date:   Tue, 25 Jun 2019 15:59:56 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <x86@kernel.org>, Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        <peterz@infradead.org>, <vishal.l.verma@intel.com>,
        <ard.biesheuvel@linaro.org>, <tglx@linutronix.de>,
        <linux-acpi@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/10] acpi/numa: Establish a new drivers/acpi/numa/
 directory
Message-ID: <20190625155956.00002dc4@huawei.com>
In-Reply-To: <156140037171.2951909.7432584124511649643.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
        <156140037171.2951909.7432584124511649643.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 24 Jun 2019 11:19:32 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Currently hmat.c lives under an "hmat" directory which does not enhance
> the description of the file. The initial motivation for giving hmat.c
> its own directory was to delineate it as mm functionality in contrast to
> ACPI device driver functionality.
> 
> As ACPI continues to play an increasing role in conveying
> memory location and performance topology information to the OS take the
> opportunity to co-locate these NUMA relevant tables in a combined
> directory.
> 
> numa.c is renamed to srat.c and moved to drivers/acpi/numa/ along with
> hmat.c.

Hi Dan,

srat.c now includes processing for the slit table which is a bit odd.

Now we could split this up in to a top level numa.c and then
srat.c, slit.c and hmat.c....

Does feel rather silly though.  Perhaps better to just leave it as
numa.c?

I don't really feel strongly about this though.

Jonathan

> 
> Cc: Len Brown <lenb@kernel.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/Kconfig       |    9 +--------
>  drivers/acpi/Makefile      |    3 +--
>  drivers/acpi/hmat/Makefile |    2 --
>  drivers/acpi/numa/Kconfig  |    7 ++++++-
>  drivers/acpi/numa/Makefile |    3 +++
>  drivers/acpi/numa/hmat.c   |    0 
>  drivers/acpi/numa/srat.c   |    0 
>  7 files changed, 11 insertions(+), 13 deletions(-)
>  delete mode 100644 drivers/acpi/hmat/Makefile
>  rename drivers/acpi/{hmat/Kconfig => numa/Kconfig} (72%)
>  create mode 100644 drivers/acpi/numa/Makefile
>  rename drivers/acpi/{hmat/hmat.c => numa/hmat.c} (100%)
>  rename drivers/acpi/{numa.c => numa/srat.c} (100%)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 283ee94224c6..82c4a31c8701 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -321,12 +321,6 @@ config ACPI_THERMAL
>  	  To compile this driver as a module, choose M here:
>  	  the module will be called thermal.
>  
> -config ACPI_NUMA
> -	bool "NUMA support"
> -	depends on NUMA
> -	depends on (X86 || IA64 || ARM64)
> -	default y if IA64_GENERIC || IA64_SGI_SN2 || ARM64
> -
>  config ACPI_CUSTOM_DSDT_FILE
>  	string "Custom DSDT Table file to include"
>  	default ""
> @@ -475,8 +469,7 @@ config ACPI_REDUCED_HARDWARE_ONLY
>  	  If you are unsure what to do, do not enable this option.
>  
>  source "drivers/acpi/nfit/Kconfig"
> -source "drivers/acpi/hmat/Kconfig"
> -
> +source "drivers/acpi/numa/Kconfig"
>  source "drivers/acpi/apei/Kconfig"
>  source "drivers/acpi/dptf/Kconfig"
>  
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 5d361e4e3405..f08a661274e8 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -55,7 +55,6 @@ acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
>  acpi-$(CONFIG_X86)		+= x86/apple.o
>  acpi-$(CONFIG_X86)		+= x86/utils.o
>  acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
> -acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
>  acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
>  acpi-y				+= acpi_lpat.o
>  acpi-$(CONFIG_ACPI_LPIT)	+= acpi_lpit.o
> @@ -80,7 +79,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
>  obj-$(CONFIG_ACPI)		+= container.o
>  obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
>  obj-$(CONFIG_ACPI_NFIT)		+= nfit/
> -obj-$(CONFIG_ACPI_HMAT)		+= hmat/
> +obj-$(CONFIG_ACPI_NUMA)		+= numa/
>  obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
>  obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
>  obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
> diff --git a/drivers/acpi/hmat/Makefile b/drivers/acpi/hmat/Makefile
> deleted file mode 100644
> index 1c20ef36a385..000000000000
> --- a/drivers/acpi/hmat/Makefile
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_ACPI_HMAT) := hmat.o
> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/numa/Kconfig
> similarity index 72%
> rename from drivers/acpi/hmat/Kconfig
> rename to drivers/acpi/numa/Kconfig
> index 95a29964dbea..d14582387ed0 100644
> --- a/drivers/acpi/hmat/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -1,4 +1,9 @@
> -# SPDX-License-Identifier: GPL-2.0
> +config ACPI_NUMA
> +	bool "NUMA support"
> +	depends on NUMA
> +	depends on (X86 || IA64 || ARM64)
> +	default y if IA64_GENERIC || IA64_SGI_SN2 || ARM64
> +
>  config ACPI_HMAT
>  	bool "ACPI Heterogeneous Memory Attribute Table Support"
>  	depends on ACPI_NUMA
> diff --git a/drivers/acpi/numa/Makefile b/drivers/acpi/numa/Makefile
> new file mode 100644
> index 000000000000..517a6c689a94
> --- /dev/null
> +++ b/drivers/acpi/numa/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ACPI_NUMA) += srat.o
> +obj-$(CONFIG_ACPI_HMAT) += hmat.o
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/numa/hmat.c
> similarity index 100%
> rename from drivers/acpi/hmat/hmat.c
> rename to drivers/acpi/numa/hmat.c
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa/srat.c
> similarity index 100%
> rename from drivers/acpi/numa.c
> rename to drivers/acpi/numa/srat.c
> 


