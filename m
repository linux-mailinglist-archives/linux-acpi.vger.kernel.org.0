Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACB530C27E
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 15:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhBBOvP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 09:51:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234832AbhBBOui (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 09:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612277350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wMhxmXBTMYfUZNcfSh+3TUCbsfo80TvU3ZFhwWxXcQQ=;
        b=KaZ9nlIX91BiEtP99GkM9xnRDJgWYrUslV8TcAYIfnNk9fL5wrTmJtjSeMw9d+J5ZUnbgI
        efe9D4wg+Su8CUfXqpDzNEK7uIw3nRikhmJIADdqT58KMpHSNwy/jZekTfYivY46J6V173
        pWae1GlOXablYBvZq8Mpv+lplXN/3tY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-hzs6ENIHM76oDd2Ja9JoEw-1; Tue, 02 Feb 2021 09:49:07 -0500
X-MC-Unique: hzs6ENIHM76oDd2Ja9JoEw-1
Received: by mail-ej1-f69.google.com with SMTP id d15so10043896ejc.21
        for <linux-acpi@vger.kernel.org>; Tue, 02 Feb 2021 06:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wMhxmXBTMYfUZNcfSh+3TUCbsfo80TvU3ZFhwWxXcQQ=;
        b=C+E53USjNukxiNrTmR/gMozoTFWf1NUOQ8TfaYFfwGki7WOcWPB2gj+bIs1f7YV+nI
         EbNUz/2ywJTHxfR5SwK+u44Wc8w+Csvx3UG+NyJvaCzJT0xNyDJ4EsPd4mEw55vVDzJy
         gl9yyyqm5h55I+dv3ezD4LQqZVuZuWIChGyJe+F64qn4b3nUxhwW12LHWJwyztJ0NiK7
         7jzAYTT9A6mhIvzOa/Dxz7pa+AU0oYSviBnqOLRHfacEqdF5ISPdwEouYhv/5LH8+SrP
         InEo4hsJG/SDSuZdI0KN5W7w8rNAOteZG4raPtuIz3oTq6gA8uCe9nIuw1WVt77wOnko
         FJIg==
X-Gm-Message-State: AOAM530UQhp4Mvpf0f5epYIZd1UfesVVDIU3Tq35EB5PC5hiPoBofBDg
        dNg1Iz/lyluCtA/VweE+TV7dmSXI+QkDwCUQ+Tzep+2zYuxRE6tDUiT9wRTH8ktWw/TcWGKxWbF
        jfT8eoJcoQqmzx4OAPAfYQQ==
X-Received: by 2002:a17:906:2bc2:: with SMTP id n2mr866878ejg.381.1612277346334;
        Tue, 02 Feb 2021 06:49:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxq3b4f8U93pJMr6ZkzE+qZ/HY6sJH5pn1Y9YnNZR/fTkE/N8fd+rEAAnT58Uy+z8FW0+jF3g==
X-Received: by 2002:a17:906:2bc2:: with SMTP id n2mr866855ejg.381.1612277345994;
        Tue, 02 Feb 2021 06:49:05 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id t9sm9507210ejc.51.2021.02.02.06.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 06:49:05 -0800 (PST)
Subject: Re: [PATCH v9] platform/x86: thinkpad_acpi: Add platform profile
 support
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     mgross@linux.intel.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hadess@hadess.net, njoshi1@lenovo.com
References: <markpearson@lenovo.com>
 <20210111162237.3469-1-markpearson@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <39c453b5-c6f2-7e45-ee82-64344e800711@redhat.com>
Date:   Tue, 2 Feb 2021 15:49:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210111162237.3469-1-markpearson@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/11/21 5:22 PM, Mark Pearson wrote:
> Add support to thinkpad_acpi for Lenovo platforms that have DYTC
> version 5 support or newer to use the platform profile feature.
> 
> This will allow users to determine and control the platform modes
> between low-power, balanced operation and performance modes.
> 
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>

Now that the acpi/platform_profile changes have landed I have
merged this patch (solving a trivial conflict caused by the
keyboard_lang changes).

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> Changes in v2:
>  Address (hopefully) all recommendations from review including:
>  - use IS_ENABLED instead of IS_DEFINED
>  - update driver to work with all the fixes in platform_profile update
>  - improve error handling for invalid inputs
>  - move tracking of current profile mode into this driver
> 
> Changes in v3:
>  - version update for patch series
> 
> Changes in v4:
>  - Rebase on top of palm sensor patch which led to a little bit of file
>    restructuring/clean up
>  - Use BIT macro where applicable
>  - Formatting fixes
>  - Check sysfs node created on exit function
>  - implement and use DYTC_SET_COMMAND macro
>  - in case of failure setting performance mode make sure CQL mode is
>    enabled again before returning.
>  - Clean up initialisation and error handling code
> 
> Changes in v5:
>  - Use atomic_int with ignoring events
>  - Add mutex when accessing ACPI information 
>  - Clean up registration code
>  - Use cached value in profile_get function
>  - Add dytc_cql_command function to clean up and provide common handler
>  - Update to work with changes in platform_profile implementation
> 
> Changes in v6:
>  - Update file to build against update in v6 platform_profile
> 
> Changes in v7 & v8:
>  - version bump along with rest of patch series
> 
> Changes in v9:
>  - Update define names to be correct with the linux-pm branches accepted
>    version
>  - Rename DYTC_MODE_QUIET to LOW_POWER just because it's confusing. It
>    was originally based on internal documentation.
> Note - originally this patch was part of a series but with the other two
> pieces being accepted into the acpi maintainers branch this one becomes
> standalone.
> 
>  drivers/platform/x86/thinkpad_acpi.c | 294 ++++++++++++++++++++++++++-
>  1 file changed, 288 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index e03df2881dc6..c5645331cfac 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -66,6 +66,7 @@
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
>  #include <linux/power_supply.h>
> +#include <linux/platform_profile.h>
>  #include <sound/core.h>
>  #include <sound/control.h>
>  #include <sound/initval.h>
> @@ -9854,16 +9855,27 @@ static bool has_lapsensor;
>  static bool palm_state;
>  static bool lap_state;
>  
> -static int lapsensor_get(bool *present, bool *state)
> +static int dytc_command(int command, int *output)
>  {
>  	acpi_handle dytc_handle;
> -	int output;
>  
> -	*present = false;
> -	if (ACPI_FAILURE(acpi_get_handle(hkey_handle, "DYTC", &dytc_handle)))
> +	if (ACPI_FAILURE(acpi_get_handle(hkey_handle, "DYTC", &dytc_handle))) {
> +		/* Platform doesn't support DYTC */
>  		return -ENODEV;
> -	if (!acpi_evalf(dytc_handle, &output, NULL, "dd", DYTC_CMD_GET))
> +	}
> +	if (!acpi_evalf(dytc_handle, output, NULL, "dd", command))
>  		return -EIO;
> +	return 0;
> +}
> +
> +static int lapsensor_get(bool *present, bool *state)
> +{
> +	int output, err;
> +
> +	*present = false;
> +	err = dytc_command(DYTC_CMD_GET, &output);
> +	if (err)
> +		return err;
>  
>  	*present = true; /*If we get his far, we have lapmode support*/
>  	*state = output & BIT(DYTC_GET_LAPMODE_BIT) ? true : false;
> @@ -9982,6 +9994,264 @@ static struct ibm_struct proxsensor_driver_data = {
>  	.exit = proxsensor_exit,
>  };
>  
> +#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
> +
> +/*************************************************************************
> + * DYTC Platform Profile interface
> + */
> +
> +#define DYTC_CMD_QUERY        0 /* To get DYTC status - enable/revision */
> +#define DYTC_CMD_SET          1 /* To enable/disable IC function mode */
> +#define DYTC_CMD_RESET    0x1ff /* To reset back to default */
> +
> +#define DYTC_QUERY_ENABLE_BIT 8  /* Bit        8 - 0 = disabled, 1 = enabled */
> +#define DYTC_QUERY_SUBREV_BIT 16 /* Bits 16 - 27 - sub revision */
> +#define DYTC_QUERY_REV_BIT    28 /* Bits 28 - 31 - revision */
> +
> +#define DYTC_GET_FUNCTION_BIT 8  /* Bits  8-11 - function setting */
> +#define DYTC_GET_MODE_BIT     12 /* Bits 12-15 - mode setting */
> +
> +#define DYTC_SET_FUNCTION_BIT 12 /* Bits 12-15 - function setting */
> +#define DYTC_SET_MODE_BIT     16 /* Bits 16-19 - mode setting */
> +#define DYTC_SET_VALID_BIT    20 /* Bit     20 - 1 = on, 0 = off */
> +
> +#define DYTC_FUNCTION_STD     0  /* Function = 0, standard mode */
> +#define DYTC_FUNCTION_CQL     1  /* Function = 1, lap mode */
> +#define DYTC_FUNCTION_MMC     11 /* Function = 11, desk mode */
> +
> +#define DYTC_MODE_PERFORM     2  /* High power mode aka performance */
> +#define DYTC_MODE_LOWPOWER    3  /* Low power mode */
> +#define DYTC_MODE_BALANCE   0xF  /* Default mode aka balanced */
> +
> +#define DYTC_SET_COMMAND(function, mode, on) \
> +	(DYTC_CMD_SET | (function) << DYTC_SET_FUNCTION_BIT | \
> +	 (mode) << DYTC_SET_MODE_BIT | \
> +	 (on) << DYTC_SET_VALID_BIT)
> +
> +#define DYTC_DISABLE_CQL DYTC_SET_COMMAND(DYTC_FUNCTION_CQL, DYTC_MODE_BALANCE, 0)
> +
> +#define DYTC_ENABLE_CQL DYTC_SET_COMMAND(DYTC_FUNCTION_CQL, DYTC_MODE_BALANCE, 1)
> +
> +static bool dytc_profile_available;
> +static enum platform_profile_option dytc_current_profile;
> +static atomic_t dytc_ignore_event = ATOMIC_INIT(0);
> +static DEFINE_MUTEX(dytc_mutex);
> +
> +static int convert_dytc_to_profile(int dytcmode, enum platform_profile_option *profile)
> +{
> +	switch (dytcmode) {
> +	case DYTC_MODE_LOWPOWER:
> +		*profile = PLATFORM_PROFILE_LOW_POWER;
> +		break;
> +	case DYTC_MODE_BALANCE:
> +		*profile =  PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case DYTC_MODE_PERFORM:
> +		*profile =  PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	default: /* Unknown mode */
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int convert_profile_to_dytc(enum platform_profile_option profile, int *perfmode)
> +{
> +	switch (profile) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		*perfmode = DYTC_MODE_LOWPOWER;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		*perfmode = DYTC_MODE_BALANCE;
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		*perfmode = DYTC_MODE_PERFORM;
> +		break;
> +	default: /* Unknown profile */
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * dytc_profile_get: Function to register with platform_profile
> + * handler. Returns current platform profile.
> + */
> +int dytc_profile_get(struct platform_profile_handler *pprof,
> +			enum platform_profile_option *profile)
> +{
> +	*profile = dytc_current_profile;
> +	return 0;
> +}
> +
> +/*
> + * Helper function - check if we are in CQL mode and if we are
> + *  -  disable CQL,
> + *  - run the command
> + *  - enable CQL
> + *  If not in CQL mode, just run the command
> + */
> +int dytc_cql_command(int command, int *output)
> +{
> +	int err, cmd_err, dummy;
> +	int cur_funcmode;
> +
> +	/* Determine if we are in CQL mode. This alters the commands we do */
> +	err = dytc_command(DYTC_CMD_GET, output);
> +	if (err)
> +		return err;
> +
> +	cur_funcmode = (*output >> DYTC_GET_FUNCTION_BIT) & 0xF;
> +	/* Check if we're OK to return immediately */
> +	if ((command == DYTC_CMD_GET) && (cur_funcmode != DYTC_FUNCTION_CQL))
> +		return 0;
> +
> +	if (cur_funcmode == DYTC_FUNCTION_CQL) {
> +		atomic_inc(&dytc_ignore_event);
> +		err = dytc_command(DYTC_DISABLE_CQL, &dummy);
> +		if (err)
> +			return err;
> +	}
> +
> +	cmd_err = dytc_command(command,	output);
> +	/* Check return condition after we've restored CQL state */
> +
> +	if (cur_funcmode == DYTC_FUNCTION_CQL) {
> +		err = dytc_command(DYTC_ENABLE_CQL, &dummy);
> +		if (err)
> +			return err;
> +	}
> +
> +	return cmd_err;
> +}
> +
> +/*
> + * dytc_profile_set: Function to register with platform_profile
> + * handler. Sets current platform profile.
> + */
> +int dytc_profile_set(struct platform_profile_handler *pprof,
> +			enum platform_profile_option profile)
> +{
> +	int output;
> +	int err;
> +
> +	if (!dytc_profile_available)
> +		return -ENODEV;
> +
> +	err = mutex_lock_interruptible(&dytc_mutex);
> +	if (err)
> +		return err;
> +
> +	if (profile == PLATFORM_PROFILE_BALANCED) {
> +		/* To get back to balanced mode we just issue a reset command */
> +		err = dytc_command(DYTC_CMD_RESET, &output);
> +		if (err)
> +			goto unlock;
> +	} else {
> +		int perfmode;
> +
> +		err = convert_profile_to_dytc(profile, &perfmode);
> +		if (err)
> +			goto unlock;
> +
> +		/* Determine if we are in CQL mode. This alters the commands we do */
> +		err = dytc_cql_command(DYTC_SET_COMMAND(DYTC_FUNCTION_MMC, perfmode, 1), &output);
> +		if (err)
> +			goto unlock;
> +	}
> +	/* Success - update current profile */
> +	dytc_current_profile = profile;
> +unlock:
> +	mutex_unlock(&dytc_mutex);
> +	return err;
> +}
> +
> +static void dytc_profile_refresh(void)
> +{
> +	enum platform_profile_option profile;
> +	int output, err;
> +	int perfmode;
> +
> +	mutex_lock(&dytc_mutex);
> +	err = dytc_cql_command(DYTC_CMD_GET, &output);
> +	mutex_unlock(&dytc_mutex);
> +	if (err)
> +		return;
> +
> +	perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
> +	convert_dytc_to_profile(perfmode, &profile);
> +	if (profile != dytc_current_profile) {
> +		dytc_current_profile = profile;
> +		platform_profile_notify();
> +	}
> +}
> +
> +static struct platform_profile_handler dytc_profile = {
> +	.profile_get = dytc_profile_get,
> +	.profile_set = dytc_profile_set,
> +};
> +
> +static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
> +{
> +	int err, output;
> +
> +	/* Setup supported modes */
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, dytc_profile.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, dytc_profile.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, dytc_profile.choices);
> +
> +	dytc_profile_available = false;
> +	err = dytc_command(DYTC_CMD_QUERY, &output);
> +	/*
> +	 * If support isn't available (ENODEV) then don't return an error
> +	 * and don't create the sysfs group
> +	 */
> +	if (err == -ENODEV)
> +		return 0;
> +	/* For all other errors we can flag the failure */
> +	if (err)
> +		return err;
> +
> +	/* Check DYTC is enabled and supports mode setting */
> +	if (output & BIT(DYTC_QUERY_ENABLE_BIT)) {
> +		/* Only DYTC v5.0 and later has this feature. */
> +		int dytc_version;
> +
> +		dytc_version = (output >> DYTC_QUERY_REV_BIT) & 0xF;
> +		if (dytc_version >= 5) {
> +			dbg_printk(TPACPI_DBG_INIT,
> +				   "DYTC version %d: thermal mode available\n", dytc_version);
> +			/* Create platform_profile structure and register */
> +			err = platform_profile_register(&dytc_profile);
> +			/*
> +			 * If for some reason platform_profiles aren't enabled
> +			 * don't quit terminally.
> +			 */
> +			if (err)
> +				return 0;
> +
> +			dytc_profile_available = true;
> +			/* Ensure initial values are correct */
> +			dytc_profile_refresh();
> +		}
> +	}
> +	return 0;
> +}
> +
> +static void dytc_profile_exit(void)
> +{
> +	if (dytc_profile_available) {
> +		dytc_profile_available = false;
> +		platform_profile_remove();
> +	}
> +}
> +
> +static struct ibm_struct  dytc_profile_driver_data = {
> +	.name = "dytc-profile",
> +	.exit = dytc_profile_exit,
> +};
> +#endif /* CONFIG_ACPI_PLATFORM_PROFILE */
> +
>  /****************************************************************************
>   ****************************************************************************
>   *
> @@ -10030,8 +10300,14 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
>  		mutex_unlock(&kbdlight_mutex);
>  	}
>  
> -	if (hkey_event == TP_HKEY_EV_THM_CSM_COMPLETED)
> +	if (hkey_event == TP_HKEY_EV_THM_CSM_COMPLETED) {
>  		lapsensor_refresh();
> +#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
> +		/* If we are already accessing DYTC then skip dytc update */
> +		if (!atomic_add_unless(&dytc_ignore_event, -1, 0))
> +			dytc_profile_refresh();
> +#endif
> +	}
>  }
>  
>  static void hotkey_driver_event(const unsigned int scancode)
> @@ -10474,6 +10750,12 @@ static struct ibm_init_struct ibms_init[] __initdata = {
>  		.init = tpacpi_proxsensor_init,
>  		.data = &proxsensor_driver_data,
>  	},
> +#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
> +	{
> +		.init = tpacpi_dytc_profile_init,
> +		.data = &dytc_profile_driver_data,
> +	},
> +#endif
>  };
>  
>  static int __init set_ibm_param(const char *val, const struct kernel_param *kp)
> 

