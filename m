Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A0FE44D2
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 09:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437166AbfJYHrl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 03:47:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:33872 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfJYHrl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 03:47:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 00:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="201737589"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 00:47:38 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNuJt-0001d3-PY; Fri, 25 Oct 2019 10:47:37 +0300
Date:   Fri, 25 Oct 2019 10:47:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mfd: intel_soc_pmic_crc: Add "cht_crystal_cove_pmic"
 cell to CHT cells
Message-ID: <20191025074737.GA32742@smile.fi.intel.com>
References: <20191024213827.144974-1-hdegoede@redhat.com>
 <20191024213827.144974-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024213827.144974-5-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 24, 2019 at 11:38:27PM +0200, Hans de Goede wrote:
> Add a "cht_crystal_cove_pmic" cell to the cells for the Cherry Trail
> variant of the Crystal Cove PMIC. Adding this cell enables / hooks-up
> the new Cherry Trail Crystal Cove PMIC OpRegion driver.
> 

The code below is fine, although same wondering about naming scheme for PWM /
GPIO.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
> index ab09b8225b76..429efa1f8e55 100644
> --- a/drivers/mfd/intel_soc_pmic_crc.c
> +++ b/drivers/mfd/intel_soc_pmic_crc.c
> @@ -88,6 +88,9 @@ static struct mfd_cell crystal_cove_cht_dev[] = {
>  		.num_resources = ARRAY_SIZE(gpio_resources),
>  		.resources = gpio_resources,
>  	},
> +	{
> +		.name = "cht_crystal_cove_pmic",
> +	},
>  	{
>  		.name = "crystal_cove_pwm",
>  	},
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


