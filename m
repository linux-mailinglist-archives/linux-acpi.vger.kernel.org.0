Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61079DE772
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2019 11:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfJUJJ6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Oct 2019 05:09:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:8279 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfJUJJ5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Oct 2019 05:09:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 02:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="209404109"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2019 02:09:55 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iMThK-0001bu-Sd; Mon, 21 Oct 2019 12:09:54 +0300
Date:   Mon, 21 Oct 2019 12:09:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/5] ACPI: button: Refactor lid_init_state module parsing
 code
Message-ID: <20191021090954.GJ32742@smile.fi.intel.com>
References: <20191018194115.93281-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018194115.93281-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 18, 2019 at 09:41:11PM +0200, Hans de Goede wrote:
> Replace the weird strncmp() calls in param_set_lid_init_state(),
> which look to me like they will also accept things like "opennnn"
> to use sysfs_match_string instead.
> 
> Also rewrite param_get_lid_init_state() using the new lid_init_state_str
> array. Instead of doing a straightforward one line replacement, e.g. :
>   return sprintf(buffer, lid_init_state_str[lid_init_state]);
> print all possible values, putting [] around the selected value, so
> that users can easily find out what the possible values are.

FWIW, after settling on the comment on one of the patches,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
for entire series.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/button.c | 62 ++++++++++++++++++++++---------------------
>  1 file changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 4a2cde2c536a..121d747a840c 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -44,9 +44,17 @@
>  #define ACPI_BUTTON_DEVICE_NAME_LID	"Lid Switch"
>  #define ACPI_BUTTON_TYPE_LID		0x05
>  
> -#define ACPI_BUTTON_LID_INIT_IGNORE	0x00
> -#define ACPI_BUTTON_LID_INIT_OPEN	0x01
> -#define ACPI_BUTTON_LID_INIT_METHOD	0x02
> +enum {
> +	ACPI_BUTTON_LID_INIT_IGNORE,
> +	ACPI_BUTTON_LID_INIT_OPEN,
> +	ACPI_BUTTON_LID_INIT_METHOD,
> +};
> +
> +static const char * const lid_init_state_str[] = {
> +	[ACPI_BUTTON_LID_INIT_IGNORE]		= "ignore",
> +	[ACPI_BUTTON_LID_INIT_OPEN]		= "open",
> +	[ACPI_BUTTON_LID_INIT_METHOD]		= "method",
> +};
>  
>  #define _COMPONENT		ACPI_BUTTON_COMPONENT
>  ACPI_MODULE_NAME("button");
> @@ -578,36 +586,30 @@ static int acpi_button_remove(struct acpi_device *device)
>  static int param_set_lid_init_state(const char *val,
>  				    const struct kernel_param *kp)
>  {
> -	int result = 0;
> -
> -	if (!strncmp(val, "open", sizeof("open") - 1)) {
> -		lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
> -		pr_info("Notify initial lid state as open\n");
> -	} else if (!strncmp(val, "method", sizeof("method") - 1)) {
> -		lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
> -		pr_info("Notify initial lid state with _LID return value\n");
> -	} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
> -		lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
> -		pr_info("Do not notify initial lid state\n");
> -	} else
> -		result = -EINVAL;
> -	return result;
> +	int i;
> +
> +	i = sysfs_match_string(lid_init_state_str, val);
> +	if (i < 0)
> +		return i;
> +
> +	lid_init_state = i;
> +	pr_info("Initial lid state set to '%s'\n", lid_init_state_str[i]);
> +	return 0;
>  }
>  
> -static int param_get_lid_init_state(char *buffer,
> -				    const struct kernel_param *kp)
> +static int param_get_lid_init_state(char *buf, const struct kernel_param *kp)
>  {
> -	switch (lid_init_state) {
> -	case ACPI_BUTTON_LID_INIT_OPEN:
> -		return sprintf(buffer, "open");
> -	case ACPI_BUTTON_LID_INIT_METHOD:
> -		return sprintf(buffer, "method");
> -	case ACPI_BUTTON_LID_INIT_IGNORE:
> -		return sprintf(buffer, "ignore");
> -	default:
> -		return sprintf(buffer, "invalid");
> -	}
> -	return 0;
> +	int i, c = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(lid_init_state_str); i++)
> +		if (i == lid_init_state)
> +			c += sprintf(buf + c, "[%s] ", lid_init_state_str[i]);
> +		else
> +			c += sprintf(buf + c, "%s ", lid_init_state_str[i]);
> +
> +	buf[c - 1] = '\n'; /* Replace the final space with a newline */
> +
> +	return c;
>  }
>  
>  module_param_call(lid_init_state,
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


