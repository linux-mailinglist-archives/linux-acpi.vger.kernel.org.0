Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D5E6F9F
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2019 11:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbfJ1KYJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Oct 2019 06:24:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:28313 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731694AbfJ1KYJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Oct 2019 06:24:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 03:24:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; 
   d="scan'208";a="374192692"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 28 Oct 2019 03:24:07 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iP2By-00010f-3I; Mon, 28 Oct 2019 12:24:06 +0200
Date:   Mon, 28 Oct 2019 12:24:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 5/6] ACPI / button: Add DMI quirk for Asus T200TA
Message-ID: <20191028102406.GL32742@smile.fi.intel.com>
References: <20191026202436.311894-1-hdegoede@redhat.com>
 <20191026202436.311894-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026202436.311894-5-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Oct 26, 2019 at 10:24:35PM +0200, Hans de Goede wrote:
> The Asus T200TA lid has some weird behavior where _LID keeps reporting
> closed after every second openening of the lid. Causing immediate
> re-suspend after opening every other open.
> 
> I've looked at the AML code but it involves talking to the EC and we
> have no idea what the EC is doing. Setting lid_init_state to
> ACPI_BUTTON_LID_INIT_OPEN fixes the unwanted behavior, so this commit
> adds a DMI based quirk to use ACPI_BUTTON_LID_INIT_OPEN on the T200TA.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - New patch in v2 of this series
> ---
>  drivers/acpi/button.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index e4b2aa43265b..a090e9542d82 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -77,6 +77,18 @@ MODULE_DEVICE_TABLE(acpi, button_device_ids);
>  
>  /* Please keep this list sorted alphabetically by vendor and model */
>  static const struct dmi_system_id dmi_lid_quirks[] = {
> +	{
> +		/*
> +		 * Asus T200TA, _LID keeps reporting closed after every second
> +		 * openening of the lid. Causing immediate re-suspend after
> +		 * opening every other open. Using LID_INIT_OPEN fixes this.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "T200TA"),
> +		},
> +		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
> +	},
>  	{
>  		/* GP-electronic T701, _LID method points to a floating GPIO */
>  		.matches = {
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


