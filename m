Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E516D2EA97A
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 12:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbhAELE0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 06:04:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729393AbhAELEZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2021 06:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609844578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1yu0cuXiaqSGTdzSjf2NfxiKizHTxlpXpVWO8iAvV0k=;
        b=RPjvv0Xr+fpU8lEbbobYJk6LqZltwlD5Yg9deYi97oOmCTnawgpKBKCa/MwwkR4VAREgn2
        9DnOVTu+cR2iVlvMOf7ZtpqAZ+ZqYSRqeRSXclq6gSqcUd7s/TGITf7IZc/OLTuxZtl4N+
        XjyoEZYLnxv35tkj9YxQ62qUgfGxekk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-SMl0iqsFM_ulita_NVkbYg-1; Tue, 05 Jan 2021 06:02:56 -0500
X-MC-Unique: SMl0iqsFM_ulita_NVkbYg-1
Received: by mail-ed1-f72.google.com with SMTP id cq17so13962196edb.17
        for <linux-acpi@vger.kernel.org>; Tue, 05 Jan 2021 03:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1yu0cuXiaqSGTdzSjf2NfxiKizHTxlpXpVWO8iAvV0k=;
        b=EuS1cjjJWfTOghBxWrkmkui6huCmkaEeY2LX4vLcic8G2GhkthB5mhCNrkmdNCFLg3
         HszHME48mLBUBZ+HWmqJ/PC/Ew5NeYu+nxVZ+Bj1pNMctJkDR2Puxqduh6fgAua64FKa
         MGkyGFu4GrRVQypJKGt7fF4xKAR1BFS9d/HokqILRHrAlZHME0KzVspSkOUgIFzNQkHm
         EH19cNq9QhQ07M6bZkbeJ7J1Gd6fJAxdjRR4Ermc6/qTT7FXNpDJPemYnymj/EWsN0bN
         XeUvS9XzDxf1RAFi5TqxQUBxWTMI+7KNPhfI50t1nHCtEg7qjXJpXhrLkQkitE+fIZYl
         49sw==
X-Gm-Message-State: AOAM53208ANSf7KrThn6LZ1ccs2xgfOxEr3oxp7oqYtlXYrWdYz7hpSp
        cY8Ypp5JGdMH+Wn/iX1oWCQq8al2XnBOb4eLfH9DJTwJXy9TuMPJNDW8veBjZJPJs4lmeMN8PJ7
        S9XkrC4FE157Psi/ZNV8Z7A==
X-Received: by 2002:a17:907:3e23:: with SMTP id hp35mr70704736ejc.254.1609844575121;
        Tue, 05 Jan 2021 03:02:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOeGosEoemnx9dXWrIb22IlmmXaFiw7bKs5F3SCEGnoh+XR/7AH6m9jPqb5hl1EGig93hX6w==
X-Received: by 2002:a17:907:3e23:: with SMTP id hp35mr70704716ejc.254.1609844574828;
        Tue, 05 Jan 2021 03:02:54 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id a2sm17426356ejt.46.2021.01.05.03.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 03:02:54 -0800 (PST)
Subject: Re: [PATCH v8 3/3] platform/x86: thinkpad_acpi: Add platform profile
 support
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     mgross@linux.intel.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <markpearson@lenovo.com>
 <20201230001827.3745-1-markpearson@lenovo.com>
 <20201230001827.3745-3-markpearson@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e0d0c5a0-bd56-90d5-35d7-3cc25798c05d@redhat.com>
Date:   Tue, 5 Jan 2021 12:02:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201230001827.3745-3-markpearson@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Some review remarks inline, mostly things I noticed while running
Rafael's bleeding-edge branch which has 1/3 and 2/3 of this series
combined with this patch.

On 12/30/20 1:18 AM, Mark Pearson wrote:
> Add support to thinkpad_acpi for Lenovo platforms that have DYTC
> version 5 support or newer to use the platform profile feature.
> 
> This will allow users to determine and control the platform modes
> between low-power, balanced operation and performance modes.
> 
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
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
>  drivers/platform/x86/thinkpad_acpi.c | 292 ++++++++++++++++++++++++++-
>  1 file changed, 286 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 6a4c54db38fb..e08b3548afd1 100644
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
> @@ -9843,16 +9844,27 @@ static bool has_lapsensor;
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
> @@ -9971,6 +9983,262 @@ static struct ibm_struct proxsensor_driver_data = {
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
> +#define DYTC_MODE_QUIET       3  /* Low power mode aka quiet */
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
> +	case DYTC_MODE_QUIET:
> +		*profile = PLATFORM_PROFILE_LOW;

This needs to be PLATFORM_PROFILE_LOW_POWER now, due to changes Rafael made while
merging 2/3 (more instances of this below).

> +		break;
> +	case DYTC_MODE_BALANCE:
> +		*profile =  PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case DYTC_MODE_PERFORM:
> +		*profile =  PLATFORM_PROFILE_PERFORM;

This needs to be PLATFORM_PROFILE_PERFORMANCE now, due to changes Rafael made while
merging 2/3 (more instances of this below).

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
> +	case PLATFORM_PROFILE_QUIET:

QUIET ? Above you translate DYTC_MODE_QUIET to PLATFORM_PROFILE_LOW_POWER and when
setting the choices bits you also use PLATFORM_PROFILE_LOW_POWER, so you should use
PLATFORM_PROFILE_LOW_POWER here too. Or replace all of them with PLATFORM_PROFILE_QUIET,
which might be better if the internal Lenovo docs describe this setting as quiet.

> +		*perfmode = DYTC_MODE_QUIET;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		*perfmode = DYTC_MODE_BALANCE;
> +		break;
> +	case PLATFORM_PROFILE_PERFORM:
> +		*perfmode = DYTC_MODE_PERFORM;

PERFORMANCE (as above).

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
> +int dytc_profile_get(enum platform_profile_option *profile)
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
> +int dytc_profile_set(enum platform_profile_option profile)
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
> +	set_bit(PLATFORM_PROFILE_LOW,      dytc_profile.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, dytc_profile.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORM,  dytc_profile.choices);

Same changes necessary as discussed above.

Regards,

Hans



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
> @@ -10019,8 +10287,14 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
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
> @@ -10463,6 +10737,12 @@ static struct ibm_init_struct ibms_init[] __initdata = {
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

