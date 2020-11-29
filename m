Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90562C7729
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Nov 2020 02:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgK2BVV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Nov 2020 20:21:21 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.112]:38249 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgK2BVT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 28 Nov 2020 20:21:19 -0500
Received: from [100.112.133.223] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.us-west-2.aws.symcld.net id 14/98-18390-376F2CF5; Sun, 29 Nov 2020 01:16:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRWlGSWpSXmKPExsWSLveKXbf426F
  4g6Pf2S32X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RouPyzgsPndMZrFYvecFs8XaL/PY
  LM6cvsTqwO0xaeYMZo+ds+6ye/zatobFY/MKLY95JwM9eto2MXm833eVzWPL1XYWj8+b5AI4o
  1gz85LyKxJYM84d385eMN26YuH+ZpYGxhcGXYxcHEIC/xkl+qfNYIRwXjBKTP+0g72LkZNDWC
  BB4lDzNVYQW0RAXWJqRw8biM0s0MEk8XKiFUTDTkaJXR2tYAk2AW2JLVt+gdm8ArYS706eB7N
  ZBFQlJjR8ZAKxRQXCJdYvWckIUSMocXLmExYQm1PATuLkjMOMEAssJGbOPw9li0vcejKfCcKW
  l2jeOpsZxJYQUJBYeecwG4SdILHs5R3mCYyCs5CMnYVk1Cwko2YhGbWAkWUVo0VSUWZ6RkluY
  maOrqGBga6hoZGuobGxrpGhsV5ilW6SXmmxbnlqcYmukV5iebFecWVuck6KXl5qySZGYGymFL
  Re3cE4580HvUOMkhxMSqK8XtcPxQvxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4P31GSgnWJSanlq
  RlpkDTBMwaQkOHiURXsuvQGne4oLE3OLMdIjUKUZFKXFeJZCEAEgiozQPrg2Wmi4xykoJ8zIy
  MDAI8RSkFuVmlqDKv2IU52BUEuY9/QVoCk9mXgnc9FdAi5mAFrv83w+yuCQRISXVwOTx+O3J5
  UtF07cmJpQkl8y5zFwQ6Gq56UD++otvFzPbXIzj7NRL5zaPSxC5oPLpOX//ve1+/hlrvF6tyd
  L2bMu0FJkX+/WV7HqvlHfmegWiv767F0rZuF9qK98hPD8uoTNVOCP0bENVTZebjP39T3b/1ze
  e37I42JTveAXT4oArRstazvUnclzZslDonYP79V4DrYcXRcQMevfcnaXskvH6bWixxg/JJ6Zz
  C++dydsaW83fVnTUaufDuHd8Hmpffd3eCzz9LbTm9/04qTX+KyKn5M6rjKsNSsi69Xqx3+rKP
  Q3ml5z3Hkxt0oo6t7StRjXtecoD6ynZ965f1ORffPyFwczEI7+YNZufcJcuUmIpzkg01GIuKk
  4EAKR/BDnIAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-13.tower-346.messagelabs.com!1606612592!57080!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19778 invoked from network); 29 Nov 2020 01:16:34 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-13.tower-346.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Nov 2020 01:16:34 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 1CF25372CFA6C885A5BF;
        Sun, 29 Nov 2020 09:16:29 +0800 (CST)
Received: from localhost.localdomain (10.64.84.236) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Sat, 28 Nov
 2020 17:16:25 -0800
Subject: Re: [External] Re: [PATCH v4 2/3] ACPI: platform-profile: Add
 platform profile support
To:     Hans de Goede <hdegoede@redhat.com>
CC:     <mgross@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <rjw@rjwysocki.net>,
        <hadess@hadess.net>, <pobrn@protonmail.com>,
        <mario.limnociello@dell.com>, <eliadevito@gmail.com>,
        <bberg@redhat.com>, <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201126165143.32776-1-markpearson@lenovo.com>
 <20201126165143.32776-2-markpearson@lenovo.com>
 <faa32924-f53f-b3fd-3f24-3848f45b67e1@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <045c3405-093c-5398-5660-40338c3becb5@lenovo.com>
Date:   Sat, 28 Nov 2020 20:16:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <faa32924-f53f-b3fd-3f24-3848f45b67e1@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.64.84.236]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks Hans

On 2020-11-28 9:08 a.m., Hans de Goede wrote:
> Hi,
> 
> On 11/26/20 5:51 PM, Mark Pearson wrote:

<snip>

>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> new file mode 100644
>> index 000000000000..678cb4596ada
>> --- /dev/null
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -0,0 +1,215 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +/* Platform profile sysfs interface */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/bits.h>
>> +#include <linux/init.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_profile.h>
>> +#include <linux/sysfs.h>
>> +
>> +static const struct platform_profile_handler *cur_profile;
>> +static DEFINE_MUTEX(profile_lock);
>> +
>> +static const char * const profile_names[] = {
>> +	[platform_profile_low] = "low-power",
>> +	[platform_profile_cool] = "cool",
>> +	[platform_profile_quiet] = "quiet",
>> +	[platform_profile_balance] = "balance",
> 
> As Barnabás already pointed out the docs added in patch 1 say "balanced"
> and here you use "balance" both in the enum value/label as we as in
> the actual string. I have a slight preference for balanced, but the
> most important thing here is being consistent everywhere.
Agreed - I'll fix, my mistake.
> 
>> +	[platform_profile_perform] = "performance",
>> +};
>> +static_assert(ARRAY_SIZE(profile_names) == platform_profile_perform+1);
> 
> It would be better to add an extra member/entry at the end of the enum
> named platform_profile_no_profiles; and then use that instead of
> platform_profile_perform+1. Also see below where I use this too.
Makes sense. Will do (and update the documentation too)
> 
>> +
>> +static ssize_t platform_profile_choices_show(struct device *dev,
>> +					struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	int len = 0;
>> +	int err, i;
>> +
>> +	err = mutex_lock_interruptible(&profile_lock);
>> +	if (err)
>> +		return err;
>> +
>> +	if (!cur_profile) {
>> +		mutex_unlock(&profile_lock);
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!cur_profile->choices) {
>> +		mutex_unlock(&profile_lock);
>> +		return sysfs_emit(buf, "\n");
>> +	}
> 
> If choices is empty, the for below will never print anything and
> the end result is still just emitting "\n", so this whole if
> block is unnecessary and can be removed.
Agreed - I'll remove
> 
>> +
>> +	for (i = 0; i < ARRAY_SIZE(profile_names); i++) {
>> +		if (cur_profile->choices & BIT(i)) {
> 
> Please change the type of choices to an unsigned long array, like this:
> 
> 	unsigned long choices[BITS_TO_LONGS(platform_profile_no_profiles)];
> 
> And then replace the for + if with:
> 
> 	for_each_set_bit(i, cur_profile->choices, platform_profile_no_profiles) {
> 
> This has 2 advantages:
> 1. Using for_each_set_bit is nicer then open coding it
> 2. If we ever go over 32 profile choices this will keep working automatically
>     without needing any adjustment to the code.
> 
> Note this requires include/linux/bitops.h (in include/linux/platform_profile.h,
> since you will be using BITS_TO_LONGS there).

Neat - I hadn't come across this before. I'll give it a go. Thank you.
> 
>> +			if (len == 0)
>> +				len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>> +			else
>> +				len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>> +		}
>> +	}
>> +	len += sysfs_emit_at(buf, len, "\n");
>> +	mutex_unlock(&profile_lock);
>> +	return len;
>> +}
>> +
>> +static ssize_t platform_profile_show(struct device *dev,
>> +					struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	enum platform_profile_option profile = platform_profile_balance;
>> +	int err;
>> +
>> +	err = mutex_lock_interruptible(&profile_lock);
>> +	if (err)
>> +		return err;
>> +
>> +	if (!cur_profile) {
>> +		mutex_unlock(&profile_lock);
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!cur_profile->profile_get) {
>> +		mutex_unlock(&profile_lock);
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	err = cur_profile->profile_get(&profile);
>> +	mutex_unlock(&profile_lock);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	/* Check that profile is valid index */
>> +	if ((profile < 0) || (profile >= ARRAY_SIZE(profile_names)))
>> +		return sysfs_emit(buf, "\n");
> 
> IMHO it would be better to do "return -EIO" here, since there
> clearly is something wrong in this case.
Agreed. I'll correct this.
> 
<snip>
>> +
>> +int platform_profile_register(const struct platform_profile_handler *pprof)
>> +{
>> +	int err;
> 
> Maybe sanity check the platform_profile_handler a bit here,
> I think it would be ok to check that choices, profile_set and profile_get
> are all not 0 / NULL here and otherwise just return -EINVAL; Doing so
> allows making the code above a bit simpler, also removing some exit
> paths which require an unlock before exiting.
Makes sense - will do.
> 
>> +
>> +	err = mutex_lock_interruptible(&profile_lock);
>> +	if (err)
>> +		return err;
> 
> Please use a regular mutex_lock here, this is called during
> driver probing, so no need to handle Ctrl+C and other signals.
Will do
> 
>> +
>> +	/* We can only have one active profile */
>> +	if (cur_profile) {
>> +		mutex_unlock(&profile_lock);
>> +		return -EEXIST;
>> +	}
>> +
>> +	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>> +	if (err) {
>> +		mutex_unlock(&profile_lock);
>> +		return err;
>> +	}
>> +
>> +	cur_profile = pprof;
>> +	mutex_unlock(&profile_lock);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_register);
>> +
>> +int platform_profile_unregister(void)
>> +{
>> +	int err;
>> +
>> +	err = mutex_lock_interruptible(&profile_lock);
>> +	if (err)
>> +		return err;
> 
> Also please use a regular mutex_lock here.
Ack
> 
>> +
>> +	if (!cur_profile) {
>> +		mutex_unlock(&profile_lock);
>> +		return -ENODEV;
>> +	}
>> +
>> +	sysfs_remove_group(acpi_kobj, &platform_profile_group);
>> +	cur_profile = NULL;
>> +	mutex_unlock(&profile_lock);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_unregister);
>> +
>> +static int __init platform_profile_init(void)
>> +{
>> +	return 0;
>> +}
>> +module_init(platform_profile_init);
> 
> AFAIK you do not need to provide a module_init function, since this
> is a no-op you can just leave it out.
Ah - I never realised you could just not have init and exit functions. 
I'll remove.
> 
>> +static void __exit platform_profile_exit(void)
>> +{
>> +	/* Check if we have a registered profile, and clean up */
>> +	if (cur_profile) {
>> +		sysfs_remove_group(acpi_kobj, &platform_profile_group);
>> +		cur_profile = NULL;
>> +	}
>> +}
>> +module_exit(platform_profile_exit);
> 
> Any driver/module registering a platform_profile will depend on
> symbols from this module, so this module can only be unloaded (aka exit)
> if that other driver/module has already been unloaded. Unloading that
> other module should have already unregistered the cur_profile provider,
> otherwise things like cur_profile->profile_set will now point to no
> longer loaded code which would be really really bad. So you can drop
> this exit function entirely.
Will do
> 
> Sorry for not spotting some of these sooner. Still nothing really big,
> so hopefully you will be able to post a v5 addressing these soonish and
> then with some luck we can at least get patches 1 and 2 merged by Rafael
> in time for 5.11 (assuming Rafael is happy with v5). And then I can merge
> patch 3 once 5.11-rc1 is out.
> 
Sounds good - I'll get working on those ASAP (and as an advance note - 
I've read ahead to your other email and I'm on board with that plan)

Thanks for the review - really appreciated.
Mark

