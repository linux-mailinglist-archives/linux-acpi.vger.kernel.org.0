Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8479C60342
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfGEJlU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 05:41:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55746 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbfGEJlU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jul 2019 05:41:20 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id b84fd2b178f671ab; Fri, 5 Jul 2019 11:41:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1] ACPI / PMIC: intel: Drop double removal of address space handler
Date:   Fri, 05 Jul 2019 11:41:18 +0200
Message-ID: <2889259.JGBNQ2T1r4@kreacher>
In-Reply-To: <20190703011734.82614-1-andriy.shevchenko@linux.intel.com>
References: <20190703011734.82614-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, July 3, 2019 3:17:34 AM CEST Andy Shevchenko wrote:
> There is no need to remove address space handler twice,
> because removal is idempotent.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/pmic/intel_pmic.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
> index 1b722fd57d5e..452041398b34 100644
> --- a/drivers/acpi/pmic/intel_pmic.c
> +++ b/drivers/acpi/pmic/intel_pmic.c
> @@ -284,8 +284,6 @@ int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
>  						    intel_pmic_thermal_handler,
>  						    NULL, opregion);
>  	if (ACPI_FAILURE(status)) {
> -		acpi_remove_address_space_handler(handle, PMIC_POWER_OPREGION_ID,
> -						  intel_pmic_power_handler);
>  		ret = -ENODEV;
>  		goto out_remove_power_handler;
>  	}
> 

Applied, thanks!




