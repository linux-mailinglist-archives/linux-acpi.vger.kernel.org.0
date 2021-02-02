Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67C30C9F2
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 19:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbhBBSdb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 13:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238701AbhBBSbc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 13:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612290603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4NVHzXfkFeElDr9XmJnCbWatBBOoCAQ1UOAh9NqsA6o=;
        b=batj4W/SSJ1ICaNdkzMQ2gqeoAl7SukAUZxYfvQd9K35BdyRQahdE0HRPF8bZgefg0HDRu
        APm7ay1ZZY1UUCE+uEx6D8vGQzH88QYz3D/RTz1zwgZWr6ux/xy6erV/hG1g0ExGDe12YX
        /fLSK+DTFEF9EKHCZJbKkotR9BpMSEc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24--OMAmWgWPOuchwKpWZEpoA-1; Tue, 02 Feb 2021 13:30:01 -0500
X-MC-Unique: -OMAmWgWPOuchwKpWZEpoA-1
Received: by mail-ed1-f72.google.com with SMTP id f4so10002471eds.5
        for <linux-acpi@vger.kernel.org>; Tue, 02 Feb 2021 10:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4NVHzXfkFeElDr9XmJnCbWatBBOoCAQ1UOAh9NqsA6o=;
        b=tIRhspBujO7vo8kw0dYnA3eT4dZxQbTi47jmQe3qH+Zojc4EsJ4U4+zZpumcLXu/wr
         F0PGOBD1BiPmFmUAI8iraO1uvViGN6krJIZnozP/ntn3o8blKorSuTyfVG6EO6nXJf6s
         5rpIu8Y2FQXENIPfjPl67wCBMBi4/nQwyS1sc7DIOt5MsNtIz+0tDTk14K5Sy/Fzmhkc
         /+gphwP9Xnrl5i886PcXGQBrIbjGOCrprS6aorIJolsnNW5hG1iP6/xxmrqVYMlejcHp
         giOxoGKrhBMukC12Cam+DGVvm8c/eBfFfxAd09bHH62eL6zVjQomHWkZemoWcBiohsn/
         Uiwg==
X-Gm-Message-State: AOAM533mN/HugvTRVCKjmiIpxXw5jsvqTZxIkFCDNCLTW7CK+FfHy7Ld
        s1mEzeC/HpYL+vVSHvCdwwngTHQuD56mnN1BSC7rrT6Sly3aiN8YtyFnuUuYHW6grmt3HCjufCp
        iWxokxvBvJwlVzlWjMFX8FA==
X-Received: by 2002:a17:906:854f:: with SMTP id h15mr11668320ejy.2.1612290598933;
        Tue, 02 Feb 2021 10:29:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqCF6ajK85F9nHRQQFkVNMWqYRyBaxTWJYT+rAVAv9B6RnG4cwx9WNDbB/LGlHtRz1LXDoVg==
X-Received: by 2002:a17:906:854f:: with SMTP id h15mr11668300ejy.2.1612290598694;
        Tue, 02 Feb 2021 10:29:58 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id w14sm9820444eji.85.2021.02.02.10.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 10:29:58 -0800 (PST)
Subject: Re: [PATCH v2 2/2] platform/x86: ideapad-laptop: DYTC Platform
 profile support
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210105131447.38036-1-jiaxun.yang@flygoat.com>
 <20210105131447.38036-3-jiaxun.yang@flygoat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c032ce07-112b-ca71-60f2-2f2bd2104209@redhat.com>
Date:   Tue, 2 Feb 2021 19:29:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210105131447.38036-3-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/5/21 2:14 PM, Jiaxun Yang wrote:
> Add support to ideapad-laptop for Lenovo platforms that have DYTC
> version 5 support or newer to use the platform profile feature.
> 
> Mostly based on Mark Pearson <markpearson@lenovo.com>'s thinkpad-acpi
> work but massaged to fit ideapad driver.
> 
> Note that different from ThinkPads, IdeaPads's Thermal Hotkey won't
> trigger profile switch itself, we'll leave it for userspace programs.
> 
> Tested on Lenovo Yoga-14S ARE Chinese Edition.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Now that the acpi/platform_profile stuff has landed I've merged this patch.

Note I've made one small but important change I've replaced all
occurrences of QUIET with LOW_POWER as was done in the latest revision
of the thinkpad_acpi change.

This is not only a cosmetical thing, it also fixes an actual bug:

> +static int convert_dytc_to_profile(int dytcmode, enum platform_profile_option *profile)
> +{
> +	switch (dytcmode) {
> +	case DYTC_MODE_QUIET:
> +		*profile = PLATFORM_PROFILE_LOW_POWER;
> +		break;

QUIET -> LOW_POWER, ok there actually is a PLATFORM_PROFILE_QUIET
too, but according to the docs LOW_POWER actually is a better match
(hence the rename).

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
> +	case PLATFORM_PROFILE_QUIET:
> +		*perfmode = DYTC_MODE_QUIET;

QUIET -> QUIET erm, but we weren't using PLATFORM_PROFILE_QUIET in this driver at all, also see:

> +	/* Setup supported modes */
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->pprof.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, priv->dytc->pprof.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->dytc->pprof.choices);

See we are not advertising PLATFORM_PROFILE_LOW_POWER and above
we actually map DYTC_MODE_QUIET -> PLATFORM_PROFILE_LOW_POWER

So we should do the reverse here.

Anyways replacing all instances of QUIET with LOW_POWER clears up
the confusion which lead to this bug and also actually fixes the bug.

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
>  drivers/platform/x86/Kconfig          |   1 +
>  drivers/platform/x86/ideapad-laptop.c | 289 ++++++++++++++++++++++++++
>  2 files changed, 290 insertions(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 91e6176cdfbd..8059143c21bb 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -624,6 +624,7 @@ config IDEAPAD_LAPTOP
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	depends on ACPI_VIDEO || ACPI_VIDEO = n
>  	depends on ACPI_WMI || ACPI_WMI = n
> +	depends on ACPI_PLATFORM_PROFILE
>  	select INPUT_SPARSEKMAP
>  	help
>  	  This is a driver for Lenovo IdeaPad netbooks contains drivers for
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 7598cd46cf60..5512367c604a 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -15,6 +15,7 @@
>  #include <linux/acpi.h>
>  #include <linux/rfkill.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
>  #include <linux/input.h>
>  #include <linux/input/sparse-keymap.h>
>  #include <linux/backlight.h>
> @@ -77,6 +78,13 @@ enum {
>  	VPCCMD_W_BL_POWER = 0x33,
>  };
>  
> +struct ideapad_dytc_priv {
> +	enum platform_profile_option current_profile;
> +	struct platform_profile_handler pprof;
> +	struct mutex mutex;
> +	struct ideapad_private *priv;
> +};
> +
>  struct ideapad_rfk_priv {
>  	int dev;
>  	struct ideapad_private *priv;
> @@ -89,6 +97,7 @@ struct ideapad_private {
>  	struct platform_device *platform_device;
>  	struct input_dev *inputdev;
>  	struct backlight_device *blightdev;
> +	struct ideapad_dytc_priv *dytc;
>  	struct dentry *debug;
>  	unsigned long cfg;
>  	bool has_hw_rfkill_switch;
> @@ -136,6 +145,28 @@ static int method_int1(acpi_handle handle, char *method, int cmd)
>  	return ACPI_FAILURE(status) ? -1 : 0;
>  }
>  
> +static int method_dytc(acpi_handle handle, int cmd, int *ret)
> +{
> +	acpi_status status;
> +	unsigned long long result;
> +	struct acpi_object_list params;
> +	union acpi_object in_obj;
> +
> +	params.count = 1;
> +	params.pointer = &in_obj;
> +	in_obj.type = ACPI_TYPE_INTEGER;
> +	in_obj.integer.value = cmd;
> +
> +	status = acpi_evaluate_integer(handle, "DYTC", &params, &result);
> +
> +	if (ACPI_FAILURE(status)) {
> +		*ret = -1;
> +		return -1;
> +	}
> +	*ret = result;
> +	return 0;
> +}
> +
>  static int method_vpcr(acpi_handle handle, int cmd, int *ret)
>  {
>  	acpi_status status;
> @@ -546,6 +577,257 @@ static const struct attribute_group ideapad_attribute_group = {
>  	.attrs = ideapad_attributes
>  };
>  
> +/*
> + * DYTC Platform profile
> + */
> +#define DYTC_CMD_QUERY        0 /* To get DYTC status - enable/revision */
> +#define DYTC_CMD_SET          1 /* To enable/disable IC function mode */
> +#define DYTC_CMD_GET          2 /* To get current IC function and mode */
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
> +static int convert_dytc_to_profile(int dytcmode, enum platform_profile_option *profile)
> +{
> +	switch (dytcmode) {
> +	case DYTC_MODE_QUIET:
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
> +	case PLATFORM_PROFILE_QUIET:
> +		*perfmode = DYTC_MODE_QUIET;
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
> +	struct ideapad_dytc_priv *dytc;
> +
> +	dytc = container_of(pprof, struct ideapad_dytc_priv, pprof);
> +	*profile = dytc->current_profile;
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
> +int dytc_cql_command(struct ideapad_private *priv, int command, int *output)
> +{
> +	int err, cmd_err, dummy;
> +	int cur_funcmode;
> +
> +	/* Determine if we are in CQL mode. This alters the commands we do */
> +	err = method_dytc(priv->adev->handle, DYTC_CMD_GET, output);
> +	if (err)
> +		return err;
> +
> +	cur_funcmode = (*output >> DYTC_GET_FUNCTION_BIT) & 0xF;
> +	/* Check if we're OK to return immediately */
> +	if ((command == DYTC_CMD_GET) && (cur_funcmode != DYTC_FUNCTION_CQL))
> +		return 0;
> +
> +	if (cur_funcmode == DYTC_FUNCTION_CQL) {
> +		err = method_dytc(priv->adev->handle, DYTC_DISABLE_CQL, &dummy);
> +		if (err)
> +			return err;
> +	}
> +
> +	cmd_err = method_dytc(priv->adev->handle, command,	output);
> +	/* Check return condition after we've restored CQL state */
> +
> +	if (cur_funcmode == DYTC_FUNCTION_CQL) {
> +		err = method_dytc(priv->adev->handle, DYTC_ENABLE_CQL, &dummy);
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
> +	struct ideapad_dytc_priv *dytc;
> +	struct ideapad_private *priv;
> +	int output;
> +	int err;
> +
> +	dytc = container_of(pprof, struct ideapad_dytc_priv, pprof);
> +	priv = dytc->priv;
> +
> +	err = mutex_lock_interruptible(&dytc->mutex);
> +	if (err)
> +		return err;
> +
> +	if (profile == PLATFORM_PROFILE_BALANCED) {
> +		/* To get back to balanced mode we just issue a reset command */
> +		err = method_dytc(priv->adev->handle, DYTC_CMD_RESET, &output);
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
> +		err = dytc_cql_command(priv,
> +				DYTC_SET_COMMAND(DYTC_FUNCTION_MMC, perfmode, 1),
> +				&output);
> +		if (err)
> +			goto unlock;
> +	}
> +	/* Success - update current profile */
> +	dytc->current_profile = profile;
> +unlock:
> +	mutex_unlock(&dytc->mutex);
> +	return err;
> +}
> +
> +static void dytc_profile_refresh(struct ideapad_private *priv)
> +{
> +	enum platform_profile_option profile;
> +	int output, err;
> +	int perfmode;
> +
> +	mutex_lock(&priv->dytc->mutex);
> +	err = dytc_cql_command(priv, DYTC_CMD_GET, &output);
> +	mutex_unlock(&priv->dytc->mutex);
> +	if (err)
> +		return;
> +
> +	perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
> +	convert_dytc_to_profile(perfmode, &profile);
> +	if (profile != priv->dytc->current_profile) {
> +		priv->dytc->current_profile = profile;
> +		platform_profile_notify();
> +	}
> +}
> +
> +static int ideapad_dytc_profile_init(struct ideapad_private *priv)
> +{
> +	int err, output, dytc_version;
> +
> +	err = method_dytc(priv->adev->handle, DYTC_CMD_QUERY, &output);
> +	/* For all other errors we can flag the failure */
> +	if (err)
> +		return err;
> +
> +	/* Check DYTC is enabled and supports mode setting */
> +	if (!(output & BIT(DYTC_QUERY_ENABLE_BIT)))
> +		return -ENODEV;
> +
> +	dytc_version = (output >> DYTC_QUERY_REV_BIT) & 0xF;
> +	if (dytc_version < 5)
> +		return -ENODEV;
> +
> +	priv->dytc = kzalloc(sizeof(struct ideapad_dytc_priv), GFP_KERNEL);
> +	if (!priv->dytc)
> +		return -ENOMEM;
> +
> +	mutex_init(&priv->dytc->mutex);
> +
> +	priv->dytc->priv = priv;
> +	priv->dytc->pprof.profile_get = dytc_profile_get;
> +	priv->dytc->pprof.profile_set = dytc_profile_set;
> +
> +	/* Setup supported modes */
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->pprof.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, priv->dytc->pprof.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->dytc->pprof.choices);
> +
> +	/* Create platform_profile structure and register */
> +	err = platform_profile_register(&priv->dytc->pprof);
> +	if (err)
> +		goto mutex_destroy;
> +
> +	/* Ensure initial values are correct */
> +	dytc_profile_refresh(priv);
> +
> +	return 0;
> +
> +mutex_destroy:
> +	mutex_destroy(&priv->dytc->mutex);
> +	kfree(priv->dytc);
> +	priv->dytc = NULL;
> +	return err;
> +}
> +
> +static void ideapad_dytc_profile_exit(struct ideapad_private *priv)
> +{
> +	if (!priv->dytc)
> +		return;
> +
> +	platform_profile_remove();
> +	mutex_destroy(&priv->dytc->mutex);
> +	kfree(priv->dytc);
> +	priv->dytc = NULL;
> +}
> +
>  /*
>   * Rfkill
>   */
> @@ -1013,6 +1295,8 @@ static int ideapad_acpi_add(struct platform_device *pdev)
>  	ideapad_sync_rfk_state(priv);
>  	ideapad_sync_touchpad_state(priv);
>  
> +	ideapad_dytc_profile_init(priv);
> +
>  	if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
>  		ret = ideapad_backlight_init(priv);
>  		if (ret && ret != -ENODEV)
> @@ -1066,6 +1350,7 @@ static int ideapad_acpi_remove(struct platform_device *pdev)
>  	acpi_remove_notify_handler(priv->adev->handle,
>  		ACPI_DEVICE_NOTIFY, ideapad_acpi_notify);
>  	ideapad_backlight_exit(priv);
> +	ideapad_dytc_profile_exit(priv);
>  	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++)
>  		ideapad_unregister_rfkill(priv, i);
>  	ideapad_input_exit(priv);
> @@ -1087,6 +1372,10 @@ static int ideapad_acpi_resume(struct device *device)
>  
>  	ideapad_sync_rfk_state(priv);
>  	ideapad_sync_touchpad_state(priv);
> +
> +	if (priv->dytc)
> +		dytc_profile_refresh(priv);
> +
>  	return 0;
>  }
>  #endif
> 

