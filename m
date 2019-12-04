Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB3112D2F
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2019 15:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfLDOEZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Dec 2019 09:04:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:26902 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfLDOEZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Dec 2019 09:04:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 06:04:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,277,1571727600"; 
   d="scan'208";a="218933982"
Received: from yuanwan1-mobl.ccr.corp.intel.com ([10.249.174.225])
  by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2019 06:04:22 -0800
Message-ID: <2991d01601fdbcf25d745a387eda74926f1192b2.camel@intel.com>
Subject: Re: [PATCH] ACPI: PM: Avoid attaching ACPI PM domain to certain
 devices
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Brandt, Todd E" <todd.e.brandt@intel.com>
Date:   Wed, 04 Dec 2019 22:04:23 +0800
In-Reply-To: <1773028.iBGNyVBcMc@kreacher>
References: <1773028.iBGNyVBcMc@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2019-12-04 at 02:54 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Certain ACPI-enumerated devices represented as platform devices in
> Linux, like fans, require special low-level power management handling
> implemented by their drivers that is not in agreement with the ACPI
> PM domain behavior.  That leads to problems with managing ACPI fans
> during system-wide suspend and resume.
> 
> For this reason, make acpi_dev_pm_attach() skip the affected devices
> by adding a list of device IDs to avoid to it and putting the IDs of
> the affected devices into that list.
> 
> Fixes: e5cc8ef31267 (ACPI / PM: Provide ACPI PM callback routines for
> subsystems)
> Reported-by: Zhang Rui <rui.zhang@intel.com>
> Cc: 3.10+ <stable@vger.kernel.org> # 3.10+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Rui,
> 
> Please test this on the machine(s) affected by the fan suspend/resume
> issues.

Sure, Todd and I will re-run stress test with this patch applied when
5.5-rc1 released.

thanks,
rui

> 
> I don't really see any cleaner way to address this problem, because
> the
> ACPI PM domain should not be used with the devices in question even
> if
> the driver that binds to them is not loaded.
> 
> Cheers,
> Rafael
> 
> ---
>  drivers/acpi/device_pm.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -1314,9 +1314,19 @@ static void acpi_dev_pm_detach(struct de
>   */
>  int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  {
> +	/*
> +	 * Skip devices whose ACPI companions match the device IDs
> below,
> +	 * because they require special power management handling
> incompatible
> +	 * with the generic ACPI PM domain.
> +	 */
> +	static const struct acpi_device_id special_pm_ids[] = {
> +		{"PNP0C0B", }, /* Generic ACPI fan */
> +		{"INT3404", }, /* Fan */
> +		{}
> +	};
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
>  
> -	if (!adev)
> +	if (!adev || !acpi_match_device_ids(adev, special_pm_ids))
>  		return 0;
>  
>  	/*
> 
> 
> 

