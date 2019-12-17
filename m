Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2FE61221D8
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 03:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfLQCHm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 21:07:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:36892 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfLQCHm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 21:07:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 17:37:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="217616412"
Received: from rzhang1-mobile.sh.intel.com ([10.239.195.243])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2019 17:37:09 -0800
Message-ID: <2dcde56646eea0a8d8002d0b07b1702d64284034.camel@intel.com>
Subject: Re: [PATCH v3 5/5] thermal: int340x_thermal: Add new Tiger Lake
 hardware IDs to support thermal driver
From:   Zhang Rui <rui.zhang@intel.com>
To:     Gayatri Kammela <gayatri.kammela@intel.com>,
        linux-pm@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, alex.hung@canonical.com,
        linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, charles.d.prestopine@intel.com,
        dvhart@infradead.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Date:   Tue, 17 Dec 2019 09:37:09 +0800
In-Reply-To: <354062a481f1b8b207fa7035abb50fcb80e8ce32.1576520244.git.gayatri.kammela@intel.com>
References: <cover.1576520244.git.gayatri.kammela@intel.com>
         <354062a481f1b8b207fa7035abb50fcb80e8ce32.1576520244.git.gayatri.kammela@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2019-12-16 at 10:31 -0800, Gayatri Kammela wrote:
> Tiger Lake has a new unique hardware IDs to support thermal driver.
> Hence, add them.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Zhang rui <rui.zhang@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Reviewed-by: Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
>  drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 3517883b5cdb..efae0c02d898 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -369,6 +369,7 @@ static int int3400_thermal_remove(struct
> platform_device *pdev)
>  }
>  
>  static const struct acpi_device_id int3400_thermal_match[] = {
> +	{"INT1040", 0},
>  	{"INT3400", 0},
>  	{}
>  };
> diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> index a7bbd8584ae2..aeece1e136a5 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> @@ -282,6 +282,7 @@ static int int3403_remove(struct platform_device
> *pdev)
>  }
>  
>  static const struct acpi_device_id int3403_device_ids[] = {
> +	{"INT1043", 0},
>  	{"INT3403", 0},
>  	{"", 0},
>  };

