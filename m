Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CCA2B3A93
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 00:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgKOXWc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 15 Nov 2020 18:22:32 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.4]:15018 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726719AbgKOXWb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 15 Nov 2020 18:22:31 -0500
Received: from [100.112.131.148] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.us-west-2.aws.symcld.net id CE/B7-03087-338B1BF5; Sun, 15 Nov 2020 23:22:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRWlGSWpSXmKPExsWS8eIhj67xjo3
  xBlNqLPZfl7DoWmhgsfD+KVaLr99us1u8OT6dyWL5vn5Gi6bOJjaLzx2TWSxW73nBbLH2yzw2
  izOnL7E6cHtMmjmD2WPnrLvsHr+2rWHx2LxCy2PeyUCPnrZNTB7v911l89hytZ3F4/MmuQDOK
  NbMvKT8igTWjH0vtjEXvEismH1zDWMD4wnfLkZODiGB/4wSK3ZbdjFyAdkvGCUefjvB3MXIwS
  EskCrxsdkQxBQRsJd48SQIpIRZoJlFovnWAyaI+nYmic+djxhBBrEJaEts2fKLDcTmFbCVWP9
  qKjuIzSKgKjF7xk6wGlGBcIn1S1YyQtQISpyc+YQFZBCnQBejxMuzl8CamQUsJGbOP88IYYtL
  3HoynwnClpdo3job7DgJAQWJOzMKQcISAgkSy17eYZ7AKDgLydhZSCbNQjJpFpJJCxhZVjFaJ
  BVlpmeU5CZm5ugaGhjoGhoa6RoaWeoaGpvoJVbpJuqVFuuWpxaX6BrpJZYX6xVX5ibnpOjlpZ
  ZsYgTGZUpBY9sOxplvPugdYpTkYFIS5dVy2xgvxJeUn1KZkVicEV9UmpNafIhRhoNDSYJXcDt
  QTrAoNT21Ii0zB5giYNISHDxKIrw8IGne4oLE3OLMdIjUKUZdjpOrlixiFmLJy89LlRLnZdwG
  VCQAUpRRmgc3ApauLjHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5hUHWcWTmVcCt+kV0BFMQ
  Efs0N4AckRJIkJKqoFp9rLJHi3Fc/Ztc7qZ8Mhyz7ZXC5rnqndK3Nyh8Sbc1HdPwa5vNoctL1
  2SzD+7McTKxGpxTfSSRceipGqf76nYx7DOaH6C2nwG9rAixc/rJ7SWdC2cz77i3npPm1cTr+/
  m9/Tg3l37dMOrlVM3vu46l5N6YfKTTOXF30r+HVk6VX1jv/IsFmuuRVelbGx9+Dd8uOUhcfz5
  zZNFHe9fL5Preru+fr6HrtMvNhuVz0l7AgPS02tZJ1ZElng9+rqpPC3kVu76TLfnwsz7zL74N
  qZWdvG1HtD5l3p7ja+ZpxnTQYPn09ozlvE5FBlsXxvgX7/167P5MSXZze+0u2doaFYo1m/4Oe
  lP0fLtYovDl+8OVGIpzkg01GIuKk4EALIaVRvSAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-6.tower-336.messagelabs.com!1605482545!144229!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25942 invoked from network); 15 Nov 2020 23:22:26 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-6.tower-336.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Nov 2020 23:22:26 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id E262FB0DB0BF49AF7AD4;
        Sun, 15 Nov 2020 18:22:24 -0500 (EST)
Received: from localhost.localdomain (10.38.56.206) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Sun, 15 Nov
 2020 15:22:23 -0800
Subject: Re: [External] Re: [PATCH v2 3/3] platform/x86: thinkpad_acpi: Add
 platform profile support
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201114150102.340618-1-markpearson@lenovo.com>
 <20201114150102.340618-3-markpearson@lenovo.com>
 <bC_Z4v6vrGG27schT2V4eci6RtrHSQrt1okyeocu4rdL0tka_bmMM43h9pphEknHKMPs5dbnXG-Kzs2SwSuwTO4dOkIeIVHUgYZ5EvNrkm0=@protonmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <746e3f26-bca4-9659-abf2-98d81aa84f63@lenovo.com>
Date:   Sun, 15 Nov 2020 18:22:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <bC_Z4v6vrGG27schT2V4eci6RtrHSQrt1okyeocu4rdL0tka_bmMM43h9pphEknHKMPs5dbnXG-Kzs2SwSuwTO4dOkIeIVHUgYZ5EvNrkm0=@protonmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.56.206]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Barnabas

On 15/11/2020 13:33, Barnabás Pőcze wrote:
> 
> 2020. november 14., szombat 16:01 keltezéssel, Mark Pearson <markpearson@lenovo.com> írta:
> 
> Hi
> 
> 
> I think there are a couple places where the BIT() macro could be used.
> 
> 
>> [...]
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>> index 890dda284a00..13352ccdfdaf 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -72,6 +72,7 @@
>>   #include <linux/uaccess.h>
>>   #include <acpi/battery.h>
>>   #include <acpi/video.h>
>> +#include <linux/platform_profile.h>
>>
>>   /* ThinkPad CMOS commands */
>>   #define TP_CMOS_VOLUME_DOWN	0
>> @@ -9832,10 +9833,40 @@ static struct ibm_struct lcdshadow_driver_data = {
>>    * DYTC subdriver, for the Lenovo lapmode feature
> 
> This comment should be updated, no? It does more than report the "lap mode" state?
Agreed.
> 
> 
>>    */
>>
>> +#define DYTC_CMD_QUERY        0 /* To get DYTC status - enable/revision */
>> +#define DYTC_CMD_SET          1 /* To enable/disable IC function mode */
>>   #define DYTC_CMD_GET          2 /* To get current IC function and mode */
>>   #define DYTC_GET_LAPMODE_BIT 17 /* Set when in lapmode */
> 
> `DYTC_GET_LAPMODE_BIT` is defined a couple lines below, I think this definition
> should be removed.
Crud - I missed that. Amazing the compiler didn't object. Will fix.
> 
> 
>> +#define DYTC_CMD_RESET    0x1ff /* To reset back to default */
>> +
>> +#define DYTC_QUERY_ENABLE_BIT 8  /* Bit 8 - 0 = disabled, 1 = enabled */
>> +#define DYTC_QUERY_SUBREV_BIT 16 /* Bits 16 - 27 - sub revisision */
>                                                            ^
> "revision"                                                |
ack
> 
> 
>> +#define DYTC_QUERY_REV_BIT    28 /* Bits 28 - 31 - revision */
>> +
>> +#define DYTC_GET_FUNCTION_BIT 8  /* Bits 8-11 - function setting */
>> +#define DYTC_GET_MODE_BIT     12 /* Bits 12-15 - mode setting */
>                                                ^
> The spacing is inconsistent in the comments.  |
ok
> 
> 
>> +#define DYTC_GET_LAPMODE_BIT  17 /* Bit 17 - lapmode. Set when on lap */
>> +
>> +#define DYTC_SET_FUNCTION_BIT 12 /* Bits 12-15 - funct setting */
> 
> If all letters of "function" were spelled a couple lines above, I think
> it should be here as well.
agreed
> 
> 
>> +#define DYTC_SET_MODE_BIT     16 /* Bits 16-19 - mode setting */
>> +#define DYTC_SET_VALID_BIT    20 /* Bit 20 - 1 = on, 0 = off */
>> +
> 
> I personally would create a DYTC_SET_COMMAND() - or similarly named - macro
> along these lines:
> ```
> #define DYTC_SET_COMMAND(function, mode, on) \
>    (DYTC_CMD_SET | (function) << DYTC_SET_FUNCTION_BIT | (mode) << DYTC_SET_MODE_BIT | (on) << DYTC_SET_VALID_BIT)
> ```
> and use that later on. I believe this helps readability and reduces the chances
> of accindental mistakes.
Sounds good
> 
> 
>> +#define DYTC_FUNCTION_STD     0  /* Function = 0, standard mode */
>> +#define DYTC_FUNCTION_CQL     1  /* Function = 1, lap mode */
>> +#define DYTC_FUNCTION_MMC     11 /* Function = 11, desk mode */
> 
> It seems strange to me that there is a leap from 1 to 11.
That one is outside my control - it's how the HW team defined the numbers :)
> 
> 
>> +
>> +#define DYTC_MODE_PERFORM     2  /* High power mode aka performance */
>> +#define DYTC_MODE_QUIET       3  /* low power mode aka quiet */
>> +#define DYTC_MODE_BALANCE   0xF  /* default mode aka balance */
> 
> I suggest you capitalize the last two comments to be consistent with the rest
> of the patch.
Ack
> 
> 
>> +
>> +#define DYTC_DISABLE_CQL ((DYTC_MODE_BALANCE << DYTC_SET_MODE_BIT) | \
>> +		(DYTC_FUNCTION_CQL << DYTC_SET_FUNCTION_BIT) | \
>> +		DYTC_CMD_SET)
>> +#define DYTC_ENABLE_CQL (DYTC_DISABLE_CQL | (1 << DYTC_SET_VALID_BIT))
>> [...]
>> +static int convert_profile_to_dytc(enum platform_profile_option profile, int *perfmode)
>> +{
>> +	switch (profile) {
>> +	case profile_low:
>> +		*perfmode = DYTC_MODE_QUIET;
>> +		break;
>> +	case profile_balance:
>> +		*perfmode = DYTC_MODE_BALANCE;
>> +		break;
>> +	case profile_perform:
>> +		*perfmode = DYTC_MODE_PERFORM;
>> +		break;
>> +	default: /* Unknown profile */
>> +		return -EOPNOTSUPP;
> 
> I personally think EINVAL would be better here,
> just like in `convert_dytc_to_profile()`.
I liked how this worked when testing.
If you put in an invalid profile name then platform_profile returned 
EINVAL but if you got this far you'd provided a valid profile setting 
that this driver doesn't support and the not supported message seemed 
clearer. As an example 'cool' is used on HP platforms but not Lenovo.
I'd like to leave this one as it is please.
> 
> 
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int dytc_perfmode_get(int *perfmode, int *funcmode)
>> +{
>> +	int output, err;
>> +
>> +	if (!dytc_available)
>> +		return -ENODEV;
>> +
>> +	err = dytc_command(DYTC_CMD_GET, &output);
>> +	if (err)
>> +		return err;
>> +
>> +	*funcmode = (output >> DYTC_GET_FUNCTION_BIT) & 0xF;
>> +	if (*funcmode == DYTC_FUNCTION_CQL) {
>> +		int dummy;
>> +		/*
>> +		 * We can't get the mode when in CQL mode - so we disable CQL
>> +		 * mode retrieve the mode and then enable it again.
>> +		 * As disabling/enabling CQL triggers an event we set a flag to
>> +		 * ignore these events. This will be cleared by the event handler
>> +		 */
>> +		dytc_ignore_next_event = true;
>> +		err = dytc_command(DYTC_DISABLE_CQL, &dummy);
>> +		if (err)
>> +			return err;
>> +		err = dytc_command(DYTC_CMD_GET, &output);
>> +		if (err)
>> +			return err;
> 
> If `DYTC_CMD_GET` fails, then CQL state is not restored. I think that may be
> undesired?
Agreed - thank you, that's an important catch.

> 
> 
>> +		/* Again ignore this event */
>> +		dytc_ignore_next_event = true;
>> +		err = dytc_command(DYTC_ENABLE_CQL, &dummy);
>> +		if (err)
>> +			return err;
>> +	}
>> +	*perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
>> +	return 0;
>> +}
>> [...]
>> +/*
>> + * dytc_profile_set: Function to register with platform_profile
>> + * handler. Sets current platform profile.
>> + */
>> +int dytc_profile_set(enum platform_profile_option profile)
>> +{
>> +	int cur_perfmode, cur_funcmode;
>> +	int err, dytc_set;
>> +	int output;
>> +
>> +	if (!dytc_available)
>> +		return -ENODEV;
>> +
>> +	if (profile == profile_balance) {
>> +		/* To get back to balance mode we just issue a reset command */
>> +		err = dytc_command(DYTC_CMD_RESET, &output);
>> +		if (err)
>> +			return err;
>> +	} else {
>> +		int perfmode;
>> +		int err;
>> +
>> +		err = convert_profile_to_dytc(profile, &perfmode);
>> +		if (err)
>> +			return err;
>> +
>> +		/* Determine if we are in CQL mode. This alters the commands we do */
>> +		err = dytc_perfmode_get(&cur_perfmode, &cur_funcmode);
>> +		if (err)
>> +			return err;
>> +
>> +		if (cur_funcmode == DYTC_FUNCTION_CQL) {
>> +			/* To set the mode we need to disable CQL first*/
>> +			dytc_ignore_next_event = true; /* Ignore event */
>> +			err = dytc_command(DYTC_DISABLE_CQL, &output);
>> +			if (err)
>> +				return err;
>> +		}
>> +		dytc_set = (1 << DYTC_SET_VALID_BIT) |
>> +			(DYTC_FUNCTION_MMC << DYTC_SET_FUNCTION_BIT) |
>> +			(perfmode << DYTC_SET_MODE_BIT) |
>> +			DYTC_CMD_SET;
>> +		err = dytc_command(dytc_set, &output);
>> +		if (err)
>> +			return err;
> 
> If I see it correctly, if CQL is turned off successfully, but the this command
> fails, then the function returns with an error, but does not restore CQL state.
> Which may or may not be desired?
Right - not desired. I'll fix
> 
> 
>> +		if (cur_funcmode == DYTC_FUNCTION_CQL) {
>> +			dytc_ignore_next_event = true; /* Ignore event */
>> +			err = dytc_command(DYTC_ENABLE_CQL, &output);
>> +			if (err)
>> +				return err;
>> +		}
>> +	}
>> +	/* Success - update current profile */
>> +	dytc_current_profile = profile;
>> +	return 0;
>> +}
>> +
>> +static void dytc_profile_refresh(void)
>> +{
>> +	enum platform_profile_option profile;
>> +	int perfmode, funcmode;
>> +	int err;
>> +
>> +	err = dytc_perfmode_get(&perfmode, &funcmode);
>> +	if (err)
>> +		return;
>> +
>> +	err = convert_dytc_to_profile(perfmode, &profile);
> 
> `err` is not checked.
ack
> 
> 
>> +	if (profile != dytc_current_profile) {
>> +		dytc_current_profile = profile;
>> +		platform_profile_notify();
>> +	}
>> +}
>> +#endif
>> +
>> +static int tpacpi_dytc_init(struct ibm_init_struct *iibm)
>> +{
>> +	int err, output;
>> +
>> +	err = dytc_command(DYTC_CMD_QUERY, &output);
>> +	/*
>> +	 * If support isn't available (ENODEV) then don't return an error
>> +	 * and don't create the sysfs group
>>   	 */
>>   	if (err == -ENODEV)
>>   		return 0;
>> @@ -9912,14 +10109,54 @@ static int tpacpi_dytc_init(struct ibm_init_struct *iibm)
>>   	if (err)
>>   		return err;
>>
>> -	/* Platform supports this feature - create the group */
>> -	err = sysfs_create_group(&tpacpi_pdev->dev.kobj, &dytc_attr_group);
>> -	return err;
>> +	/* Check DYTC is enabled and supports mode setting */
>> +	dytc_available = false;
>> +	dytc_ignore_next_event = false;
>> +
>> +	if (output & BIT(DYTC_QUERY_ENABLE_BIT)) {
>> +		/* Only DYTC v5.0 and later has this feature. */
>> +		int dytc_version;
>> +
>> +		dytc_version = (output >> DYTC_QUERY_REV_BIT) & 0xF;
>> +		if (dytc_version >= 5) {
>> +			dbg_printk(TPACPI_DBG_INIT,
>> +				   "DYTC version %d: thermal mode available\n", dytc_version);
>> +			dytc_available = true;
>> +#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
>> +			/* Create platform_profile structure and register */
>> +			dytc_profile.choices = (1 << profile_low) |
>> +				(1 << profile_balance) |
>> +				(1 << profile_perform);
>> +			dytc_profile.profile_get = dytc_profile_get;
>> +			dytc_profile.profile_set = dytc_profile_set;
> 
> By the way, wouldn't it be easier to initialize this struct when it's defined?
> ```
> static platform_profile_handler dytc_profile = {
>    .choices = ...,
>    .profile_set = ...,
>    .profile_get = ....,
> };
> ```
> ?
Yep, it would. I'll fix.
> 
> 
>> +			err = platform_profile_register(&dytc_profile);
>> +			/*
>> +			 * If for some reason platform_profiles aren't enabled
>> +			 * don't quit terminally.
>> +			 */
>> +			if (err)
>> +				return 0;
> 
> If I see it correctly, if `platform_profile_register()` fails for some reason,
> then the dytc_lapmode attribute won't be created, is that the expected behaviour?
Hmmm - that's not ideal. I'll look at this section again.

> 
> 
>> +#endif
>> +			/*
>> +			 * Note - this has been deprecated by the input sensor implementation,
>> +			 * but can't be removed until we confirm user space is no longer using
>> +			 */
>> +			dytc_lapmode_get(&dytc_lapmode);
>> +			return device_create_file(&tpacpi_pdev->dev, &dev_attr_dytc_lapmode);
> 
> Previously, the DYTC version (and the "enable bit") wasn't checked, the lap mode
> attribute was always created if DYTC was available. This patch changes that,
> why?
It's an improvement/fix.
It probably should have been in the original version really but I only 
found out after some clarification from the FW team when there were some 
issues on X1C6 with DYTC 4 returning lapmode always on.
> 
> 
>> +		}
>> +	}
>> +	return 0;
>>   }
>>
>>   static void dytc_exit(void)
>>   {
>> -	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &dytc_attr_group);
>> +	if (dytc_available) {
>> +		device_remove_file(&tpacpi_pdev->dev, &dev_attr_dytc_lapmode);
>> +#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
>> +		platform_profile_unregister();
> 
> `platform_profile_unregister()` is called even if `platform_profile_register()`
> failed.
Agreed - I'll fix
> 
> 
>> +#endif
>> +		dytc_available = false;
>> +	}
>>   }
>>
>>   static struct ibm_struct dytc_driver_data = {
>> @@ -10103,8 +10340,15 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
>>   	}
>>
>>   	if (hkey_event == TP_HKEY_EV_THM_CSM_COMPLETED) {
>> -		dytc_lapmode_refresh();
>> -		lapsensor_refresh();
>> +		if (dytc_ignore_next_event)
>> +			dytc_ignore_next_event = false; /*clear setting*/
> 
> Either none or all of the blocks should be surrounded with {} [1].
Ah - interesting. I'll fix.

> 
> 
>> +		else {
>> +			dytc_lapmode_refresh();
>> +#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
>> +			dytc_profile_refresh();
>> +#endif
>> +			lapsensor_refresh();
>> +		}
>>   	}
>>
>>   }
>> --
>> 2.25.1
> 
> 
> [1]: https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces
> 
> 
> Regards,
> Barnabás Pőcze
> 
Thank you!
Mark
