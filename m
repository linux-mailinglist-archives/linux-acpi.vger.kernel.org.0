Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA8C37B514
	for <lists+linux-acpi@lfdr.de>; Wed, 12 May 2021 06:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhELEec (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 00:34:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:60318 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhELEeb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 May 2021 00:34:31 -0400
IronPort-SDR: PfhrmUqD8nFzuo0hE4rkGJEjNQ2lyOHAv+5ySRjQY6jTe74RY2D/vlkPxQhwmf+IYeK7vpnNja
 hkQbPvSHUsnA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179208021"
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; 
   d="scan'208";a="179208021"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 21:33:09 -0700
IronPort-SDR: RCPktbMKXdjBDiFM0tCFqDGuWRg2m71kCWer1MSW/vBx9OmjHNn/iIq2qaHSiTSl3SAuxq0fuM
 kuvkY/SQGNeg==
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; 
   d="scan'208";a="471301741"
Received: from maizhanx-mobl.ccr.corp.intel.com ([10.249.168.160])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 19:41:30 -0700
Message-ID: <4754266321f71d4910c2a6167e92fea6a1462813.camel@intel.com>
Subject: Re: [PATCH v2] ACPI: PM: Add ACPI ID of Alder Lake Fan
From:   Zhang Rui <rui.zhang@intel.com>
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>, rjw@rjwysocki.net,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     srinivas.pandruvada@linux.intel.com
Date:   Wed, 12 May 2021 10:41:27 +0800
In-Reply-To: <20210511180142.28472-1-sumeet.r.pawnikar@intel.com>
References: <20210511180142.28472-1-sumeet.r.pawnikar@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2021-05-11 at 23:31 +0530, Sumeet Pawnikar wrote:
> Add a new unique fan ACPI device ID for Alder Lake to
> support it in acpi_dev_pm_attach() function.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
> ---
> v1-->v2 : Fixed commit header typo APCI with ACPI.
> 
>  drivers/acpi/device_pm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 16c0fe8a72a7..d260bc1f3e6e 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1313,6 +1313,7 @@ int acpi_dev_pm_attach(struct device *dev, bool
> power_on)
>  		{"PNP0C0B", }, /* Generic ACPI fan */
>  		{"INT3404", }, /* Fan */
>  		{"INTC1044", }, /* Fan for Tiger Lake generation */
> +		{"INTC1048", }, /* Fan for Alder Lake generation */
>  		{}
>  	};
>  	struct acpi_device *adev = ACPI_COMPANION(dev);

