Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182052C7094
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Nov 2020 19:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgK1SB3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Nov 2020 13:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729753AbgK1R6h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 28 Nov 2020 12:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606586224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gREVyIci02ha2OdO2WbVEyW9Oca9cl0cY3PT2z/a1A8=;
        b=jEzhylJLNAInJsP93qhhCKI4CZ3qRELMIUgg0CeEQ0F51oabEaEBfsMt9aPq0UKBJwAjSp
        ZyZvugAckfN02rG0EUzFjM7c6h+JEp8/ghS/p15ixYr1T4luZL4dg+BwmjIk+sVahyzWpX
        PhMPLGOsj7VFGLyf74UExhqKkgS6tZM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-alW63dnYOkup9h6Ns4NcXQ-1; Sat, 28 Nov 2020 09:55:19 -0500
X-MC-Unique: alW63dnYOkup9h6Ns4NcXQ-1
Received: by mail-ed1-f72.google.com with SMTP id g1so3919154edk.0
        for <linux-acpi@vger.kernel.org>; Sat, 28 Nov 2020 06:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gREVyIci02ha2OdO2WbVEyW9Oca9cl0cY3PT2z/a1A8=;
        b=RMRBLPZAtPh2r/7IMRxxdjBV8AYxOzyTFy8LTmKpEAwIJ24cna1hnBURCu9txU3m2L
         AobEd+N1gkXXunRYcpwH+N9vzJXFravP05vQfEdHUlpWYuJvYUYY1nkqM8X8MBe6S0zu
         e+cKLrV3YrYWNw+8k4LueUOSIRaF9v/94iluCZddEHkDRat74IdmFfGXH3rfHIEPNMLt
         XGIOO1qGbhY/CHYgx2MQ0LM3pNw/GatrbplDRGk3sovTgRdrMqAnYaHThnIYRosrBwpl
         r7IaapJnJjnpVkrfccJ78mBo2Iy0UtbRQqhc3lfVYEk4irlacz7wyhKTfGnZ1FzMw66q
         dxgA==
X-Gm-Message-State: AOAM532f6dMVyyNpOe6WkShf68wvXj1t4EOdMKnkUP6KzYfD2kVQm3oC
        iyX7ZfVJgII7lmwYmyBA1svsGeORRzywj6wUuDdkiqcU2mbY8ss2Wkhhz2yq1V2KhT27ZTqttUv
        cav42y42paE9Fs42DwI79+w==
X-Received: by 2002:a17:906:314f:: with SMTP id e15mr12555009eje.496.1606575317118;
        Sat, 28 Nov 2020 06:55:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0LaxVugC1hcl7sdvuJq3ifd5L3N6UdZLHDO7zMRnfbYx0EDXi6Xqjdy0UIU/3mlJIKBBAeg==
X-Received: by 2002:a17:906:314f:: with SMTP id e15mr12554992eje.496.1606575316785;
        Sat, 28 Nov 2020 06:55:16 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id z2sm6571504edr.47.2020.11.28.06.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 06:55:16 -0800 (PST)
Subject: Re: [PATCH v4 3/3] platform/x86: thinkpad_acpi: Add platform profile
 support
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     mgross@linux.intel.com, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, rjw@rjwysocki.net,
        hadess@hadess.net, pobrn@protonmail.com,
        mario.limnociello@dell.com, eliadevito@gmail.com, bberg@redhat.com,
        dvhart@infradead.org
References: <markpearson@lenovo.com>
 <20201126165143.32776-1-markpearson@lenovo.com>
 <20201126165143.32776-3-markpearson@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e8dee4f7-3559-71a3-51d4-0b93b004715a@redhat.com>
Date:   Sat, 28 Nov 2020 15:55:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201126165143.32776-3-markpearson@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/26/20 5:51 PM, Mark Pearson wrote:
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
>   drivers/platform/x86/thinkpad_acpi.c | 306 ++++++++++++++++++++++++++-
>  1 file changed, 305 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 6a4c54db38fb..8463170391f5 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -72,6 +72,7 @@
>  #include <linux/uaccess.h>
>  #include <acpi/battery.h>
>  #include <acpi/video.h>
> +#include <linux/platform_profile.h>

Please group this together with the other linux/foo.h includes.

>  
>  /* ThinkPad CMOS commands */
>  #define TP_CMOS_VOLUME_DOWN	0
> @@ -9971,6 +9972,296 @@ static struct ibm_struct proxsensor_driver_data = {
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
> +#define DYTC_MODE_BALANCE   0xF  /* Default mode aka balance */
> +
> +#define DYTC_SET_COMMAND(function, mode, on) \
> +	(DYTC_CMD_SET | (function) << DYTC_SET_FUNCTION_BIT | \
> +	 (mode) << DYTC_SET_MODE_BIT | \
> +	 (on) << DYTC_SET_VALID_BIT)
> +
> +#define DYTC_DISABLE_CQL DYTC_SET_COMMAND(DYTC_FUNCTION_CQL, DYTC_MODE_BALANCE, 0)
> +#define DYTC_ENABLE_CQL DYTC_SET_COMMAND(DYTC_FUNCTION_CQL, DYTC_MODE_BALANCE, 1)
> +
> +static bool dytc_ignore_next_event;
> +static bool dytc_profile_available;
> +static enum platform_profile_option dytc_current_profile;
> +
> +static int dytc_command(int command, int *output)
> +{
> +	acpi_handle dytc_handle;
> +
> +	if (ACPI_FAILURE(acpi_get_handle(hkey_handle, "DYTC", &dytc_handle))) {
> +		/* Platform doesn't support DYTC */
> +		return -ENODEV;
> +	}
> +	if (!acpi_evalf(dytc_handle, output, NULL, "dd", command))
> +		return -EIO;
> +	return 0;
> +}
> +
> +static int convert_dytc_to_profile(int dytcmode, enum platform_profile_option *profile)
> +{
> +	switch (dytcmode) {
> +	case DYTC_MODE_QUIET:
> +		*profile = platform_profile_low;
> +		break;
> +	case DYTC_MODE_BALANCE:
> +		*profile =  platform_profile_balance;
> +		break;
> +	case DYTC_MODE_PERFORM:
> +		*profile =  platform_profile_perform;
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
> +	case platform_profile_low:
> +		*perfmode = DYTC_MODE_QUIET;
> +		break;
> +	case platform_profile_balance:
> +		*perfmode = DYTC_MODE_BALANCE;
> +		break;
> +	case platform_profile_perform:
> +		*perfmode = DYTC_MODE_PERFORM;
> +		break;
> +	default: /* Unknown profile */
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int dytc_perfmode_get(int *perfmode, int *funcmode)
> +{
> +	int output, err, cmd_err;
> +
> +	if (!dytc_profile_available)
> +		return -ENODEV;
> +
> +	err = dytc_command(DYTC_CMD_GET, &output);
> +	if (err)
> +		return err;
> +
> +	*funcmode = (output >> DYTC_GET_FUNCTION_BIT) & 0xF;
> +	if (*funcmode == DYTC_FUNCTION_CQL) {
> +		int dummy;
> +		/*
> +		 * We can't get the mode when in CQL mode - so we disable CQL
> +		 * mode retrieve the mode and then enable it again.
> +		 * As disabling/enabling CQL triggers an event we set a flag to
> +		 * ignore these events. This will be cleared by the event handler
> +		 */
> +		dytc_ignore_next_event = true;
> +		err = dytc_command(DYTC_DISABLE_CQL, &dummy);
> +		if (err)
> +			return err;
> +
> +		cmd_err = dytc_command(DYTC_CMD_GET, &output);
> +		/* Check return condition after we've restored CQL state */
> +
> +		/* Again ignore this event */
> +		dytc_ignore_next_event = true;

Are we sure the event-handler will have run before we do this second
setting of the ignore_next_event bool? Maybe make it an atomic integer
and increment / decrement the variable ?

E.g.:

Declaration:

static atomic_t dytc_ignore_next_event = ATOMIC_INIT();

Ignore next event:
		atomic_inc(&dytc_ignore_next_event);
		
Check if event should be ignored:

		if (!atomic_add_unless(&dytc_ignore_next_event, -1, 0))
			dytc_profile_refresh();

Note atomic_add_unless may needs some explanation, it adds -1 unless
the atomic_t already contains 0. And it returns true if the addition
was done. so if it returns true then dytc_ignore_next_event was not 0
(it might be zero afterwards).

IOW if atomic_add_unless returns true then dytc_ignore_next_event was true,
so then we should NOT continue with the refresh.




> +		err = dytc_command(DYTC_ENABLE_CQL, &dummy);
> +		if (err)
> +			return err;
> +		if (cmd_err)
> +			return cmd_err;
> +	}
> +	*perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
> +	return 0;
> +}
> +
> +/*
> + * dytc_profile_get: Function to register with platform_profile
> + * handler. Returns current platform profile.
> + */
> +int dytc_profile_get(enum platform_profile_option *profile)
> +{
> +	int funcmode, perfmode;
> +	int err;
> +
> +	err = dytc_perfmode_get(&perfmode, &funcmode);
> +	if (err)
> +		return err;

Can't we used a cached value here ? I presume we get an
event when this is changed by the hotkey ? Esp. with the
whole enable/disable CQL dance getting the value seems a
bit expensive, so using a cached value might be better?

> +
> +	/* Convert Lenovo DYTC profile to platform_profile */
> +	err = convert_dytc_to_profile(perfmode, profile);
> +	if (err)
> +		return err;
> +
> +	dytc_current_profile = *profile;
> +	return 0;
> +}
> +
> +/*
> + * dytc_profile_set: Function to register with platform_profile
> + * handler. Sets current platform profile.
> + */
> +int dytc_profile_set(enum platform_profile_option profile)
> +{
> +	int cur_perfmode, cur_funcmode;
> +	int output;
> +	int err;
> +
> +	if (!dytc_profile_available)
> +		return -ENODEV;
> +
> +	if (profile == platform_profile_balance) {
> +		/* To get back to balance mode we just issue a reset command */
> +		err = dytc_command(DYTC_CMD_RESET, &output);
> +		if (err)
> +			return err;
> +	} else {
> +		int perfmode;
> +		int cmd_err;
> +
> +		err = convert_profile_to_dytc(profile, &perfmode);
> +		if (err)
> +			return err;
> +
> +		/* Determine if we are in CQL mode. This alters the commands we do */
> +		err = dytc_perfmode_get(&cur_perfmode, &cur_funcmode);
> +		if (err)
> +			return err;
> +
> +		if (cur_funcmode == DYTC_FUNCTION_CQL) {
> +			/* To set the mode we need to disable CQL first*/
> +			dytc_ignore_next_event = true; /* Ignore event */
> +			err = dytc_command(DYTC_DISABLE_CQL, &output);
> +			if (err)
> +				return err;
> +		}

This seems somewhat duplicated from the get() code-path. Also you already doing
a DYTC_DISABLE_CQL and DYTC_ENABLE_CQL in dytc_perfmode_get, which is not necessary
to just get the funcmode which is all you need here AFAICT.

IOW it seems that when CQL is active you are now doing:

1. dytc_perfmode_get() calls DYTC_CMD_GET
2. dytc_perfmode_get() calls DYTC_DISABLE_CQL
3. dytc_perfmode_get() calls DYTC_CMD_GET again, result is ignored (not used by dytc_profile_set)
4. dytc_perfmode_get() calls DYTC_ENABLE_CQL
5. dytc_profile_set() calls DYTC_DISABLE_CQL
6. dytc_profile_set() calls DYTC_SET_COMMAND
7. dytc_profile_set() calls DYTC_ENABLE_CQL

And you can really skip step 2-4 here.

I think it would be good to add a bunch of helpers:

1. dytc_get_modes() -> DYTC_CMD_GET wrapper gets both modes, sets perfmode
to -1 when funcmode is CQL
2. dytc_disable_cql_if_necessary() which takes funcmode as argument and is
a no-op when funcmode != CQL
3. dytc_re_enable_cql_if_necessary() idem.

And then the flow in dytc_perfmode_get could look something like this
(pseudo code minus error handling):

	dytc_get_modes(&funcmode, &perfmode)
	if (funcmode != CQL) /* or alternatively check for perfmode != -1 */
		return success;

	dytc_disable_cql_if_necessary(funcmode);
	dytc_get_modes(NULL, &perfmode);
	dytc_disable_cql_if_necessary(funcmode);

And in the non-balanced path of dytc_profile_set:

	dytc_get_modes(&funcmode, NULL)

	dytc_disable_cql_if_necessary(funcmode);
	dytc_set_mode(...);
	dytc_disable_cql_if_necessary(funcmode);

Note the NULL could be a dummy, but I find NULL a bit cleaner
(at the cost of having to check for it in dytc_get_modes).

This is is just from a quick peek, when you implement this
it might turn out to be less then ideal, IOW this is just
a suggestion, feel free to deviate.

###

Since this will require a bit of work, timing wise (wrt the 5.11 merge-window)
it might be best to just keep this patch as is for v5, and only change
patch 1 and 2 of the set, so that those will hopefully be ready for
merging in time for the 5.11 window. I plan to pick this one up
once 5.11-rc1 is out (and has the necessary ACPI bits) so we have some
more time to get this one in shape.

For patch 1/2 the most important thing is to have a consumer of the
new internal APIs (almost) ready and this code fulfills that in
its current form.

Regards,

Hans









> +		cmd_err = dytc_command(DYTC_SET_COMMAND(DYTC_FUNCTION_MMC, perfmode, 1),
> +				&output);
> +		/* Check return condition after we've restored CQL state */
> +
> +		if (cur_funcmode == DYTC_FUNCTION_CQL) {
> +			dytc_ignore_next_event = true; /* Ignore event */
> +			err = dytc_command(DYTC_ENABLE_CQL, &output);
> +			if (err)
> +				return err;
> +		}
> +		if (cmd_err)
> +			return cmd_err;
> +	}
> +	/* Success - update current profile */
> +	dytc_current_profile = profile;
> +	return 0;
> +}
> +
> +static void dytc_profile_refresh(void)
> +{
> +	enum platform_profile_option profile;
> +	int perfmode, funcmode;
> +	int err;
> +
> +	err = dytc_perfmode_get(&perfmode, &funcmode);
> +	if (err)
> +		return;
> +
> +	err = convert_dytc_to_profile(perfmode, &profile);
> +	if (profile != dytc_current_profile) {
> +		dytc_current_profile = profile;
> +		platform_profile_notify();
> +	}
> +}
> +
> +static struct platform_profile_handler dytc_profile = {
> +	.choices = BIT(platform_profile_low) |
> +		BIT(platform_profile_balance) |
> +		BIT(platform_profile_perform),
> +	.profile_get = dytc_profile_get,
> +	.profile_set = dytc_profile_set,
> +};
> +
> +static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
> +{
> +	int err, output;
> +
> +	dytc_profile_available = false;
> +	dytc_ignore_next_event = false;
> +
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
> +			do {
> +				err = platform_profile_register(&dytc_profile);
> +			} while (err == -EINTR);
> +			/*
> +			 * If for some reason platform_profiles aren't enabled
> +			 * don't quit terminally.
> +			 */
> +			if (err)
> +				return 0;
> +			dytc_profile_available = true;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static void dytc_profile_exit(void)
> +{
> +	if (dytc_profile_available) {
> +		dytc_profile_available = false;
> +		platform_profile_unregister();
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
> @@ -10019,8 +10310,15 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
>  		mutex_unlock(&kbdlight_mutex);
>  	}
>  
> -	if (hkey_event == TP_HKEY_EV_THM_CSM_COMPLETED)
> +	if (hkey_event == TP_HKEY_EV_THM_CSM_COMPLETED) {
>  		lapsensor_refresh();
> +#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
> +		if (dytc_ignore_next_event)
> +			dytc_ignore_next_event = false; /*clear setting*/
> +		else
> +			dytc_profile_refresh();
> +#endif
> +	}
>  }
>  
>  static void hotkey_driver_event(const unsigned int scancode)
> @@ -10463,6 +10761,12 @@ static struct ibm_init_struct ibms_init[] __initdata = {
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

