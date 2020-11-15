Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0517B2B3A85
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 00:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgKOXFG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 15 Nov 2020 18:05:06 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.1]:43973 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbgKOXFF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 15 Nov 2020 18:05:05 -0500
Received: from [100.112.128.173] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.us-west-2.aws.symcld.net id 84/12-26105-D14B1BF5; Sun, 15 Nov 2020 23:05:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRWlGSWpSXmKPExsWSLveKXVd2y8Z
  4g8v7OS32X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RoumziY2i88dk1ksVu95wWyx9ss8
  Noszpy+xOnB7TJo5g9lj56y77B6/tq1h8di8Qstj3slAj562TUwe7/ddZfPYcrWdxePzJrkAz
  ijWzLyk/IoE1oxFGx+wFVz0r/h3/QNjA+Njhy5GLg4hgf+MEtM+L2OEcF4wSpzpu8nexcjJIS
  wQI/Fj72SWLkYODhEBe4kXT4JAapgFmlkkmm89YIJouMooMX/VNmaQBjYBbYktW36xgdi8ArY
  Sf2Y/ZwGxWQRUJc5P/Aw2VFQgXGL9kpWMEDWCEidnPmEBGcQp0MUo8af3BdggZgELiZnzzzNC
  2OISt57MZ4Kw5SWat85mBrlIQkBB4s6MQpCwhECCxLKXd5gnMArOQjJ2FpJJs5BMmoVk0gJGl
  lWMFklFmekZJbmJmTm6hgYGuoaGRrqGxoa6RoZmeolVuol6pcW65anFJbpGeonlxXrFlbnJOS
  l6eaklmxiB0ZlS0HxjB+OsNx/0DjFKcjApifJquW2MF+JLyk+pzEgszogvKs1JLT7EKMPBoST
  Be2cTUE6wKDU9tSItMweYKGDSEhw8SiK810DSvMUFibnFmekQqVOMilLivIkgCQGQREZpHlwb
  LDldYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMq7oZaApPZl4J3PRXQIuZgBbv0N4AsrgkE
  SEl1cBkvujK+3XtFfqMQd7FrHuPWsUL++hOZ/f788Z/v5bvgW18edteMnwSvux1VDS0x4opfG
  2qsq3PxwcGjDwRPOxmdnNrfwoEG94o5/7i/VD5wt7lM395Pbw399bDWxkLo2/0Z/BXt6q2ddT
  eucX7R8V18+yqhSllMcz8/33WHf7cfNr856VD8sF/Yl7/UEuy5Hl4/CPvK3V7Gys/A8097XPr
  N1y5ITk/76Lc2leRao9Wr1iX9vgkX/ACH2HNBRHGJwpNHy9Myl93bkGR8St1k7QXKvpVi94ms
  5W1HGz8pb/t7cVO9sdzn7bNapJ6YNiglnrg2zTrg/urCx4cZ3PgdZvJsO+QwppUpY5lc4OrFl
  5VYinOSDTUYi4qTgQARi18N8kDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-12.tower-326.messagelabs.com!1605481498!143163!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21212 invoked from network); 15 Nov 2020 23:05:00 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-12.tower-326.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Nov 2020 23:05:00 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 9FA434C200940ABF7EE7;
        Mon, 16 Nov 2020 07:04:55 +0800 (CST)
Received: from localhost.localdomain (10.38.56.206) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Sun, 15 Nov
 2020 15:04:52 -0800
Subject: Re: [External] Re: [PATCH v3] ACPI: platform-profile: Add platform
 profile support
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
 <20201115004402.342838-1-markpearson@lenovo.com>
 <qpTm5tmuwsXyXCvmpN4vhQoKis0E5jCcILd49n6_9cqzEuN_Pd9iwMEXAFRQQmGf-rCyHe-LfhjTa15-DTTu9sFQCSQaca1KVfqYggmSGts=@protonmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <3bdd8da6-a47a-fbc6-de0e-858f493a226e@lenovo.com>
Date:   Sun, 15 Nov 2020 18:04:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <qpTm5tmuwsXyXCvmpN4vhQoKis0E5jCcILd49n6_9cqzEuN_Pd9iwMEXAFRQQmGf-rCyHe-LfhjTa15-DTTu9sFQCSQaca1KVfqYggmSGts=@protonmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.56.206]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks Barnabas

On 15/11/2020 13:26, Barnabás Pőcze wrote:
> Hi
> 
> I believe it would have been easier for the maintainers
> if you had resent the whole series.
> 
> Another thing is that `mutex_lock_interruptible()` seems to be preferred
> instead of `mutex_lock()` [1].
Thanks for the reference - I wasn't aware of that and will update.

> 
> 
> 2020. november 15., vasárnap 1:44 keltezéssel, Mark Pearson írta:
> 
>> [...]
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index edf1558c1105..73a99af5ec2c 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -326,6 +326,20 @@ config ACPI_THERMAL
>>   	  To compile this driver as a module, choose M here:
>>   	  the module will be called thermal.
>>
>> +config ACPI_PLATFORM_PROFILE
>> +	tristate "ACPI Platform Profile Driver"
>> +	default y
>> +	help
>> +	  This driver adds support for platform-profiles on platforms that
>> +	  support it.
>> +	  Platform-profiles can be used to control the platform behaviour. For
>> +	  example whether to operate in a lower power mode, in a higher
>> +	  power performance mode or between the two.
>> +	  This driver provides the sysfs interface and is used as the registration
>> +	  point for platform specific drivers.
>> +	  Which profiles are supported is determined on a per-platform basis and
>> +	  should be obtained from the platform specific driver.
>> +
>> [...]
>> +config ACPI_PLATFORM_PROFILE
>> +	tristate "ACPI Platform Profile Driver"
>> +	default y
>> +	help
>> +	  This driver adds support for platform-profiles on platforms that
>> +	  support it.
>> +
>> +	  Platform-profiles can be used to control the platform behaviour. For
>> +	  example whether to operate in a lower power mode, in a higher
>> +	  power performance mode or between the two.
>> +
>> +	  This driver provides the sysfs interface and is used as the registration
>> +	  point for platform specific drivers.
>> +
>> +	  Which profiles are supported is determined on a per-platform basis and
>> +	  should be obtained from the platform specific driver.
>> +
>> + >
> Am I missing something or is the ACPI_PLATFORM_PROFILE option in the Kconfig file
> twice?
It is....and it shouldn't be. I'll remove. I looked over this patch so 
many times checking that I'd put in all the pieces of feedback from 
everyone that I'm not sure how I missed that :(
> 
> 
>> [...]
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +/* Platform profile sysfs interface */
>> +
>> +#include <linux/acpi.h>
> 
> linux/bits.h is missing, I believe the rule of thumb is that if you use
> `X` and `X` is defined in `A.h`, then you should include `A.h` directly,
> and not rely on the fact that another header file you use includes `A.h`.
> An exception is ACPICA related things, I believe linux/acpi.h should be
> preferred there.
Thanks - I didn't realise that was the case and I'll update
> 
> 
>> +#include <linux/device.h>
>> +#include <linux/fs.h>
>> +#include <linux/init.h>
>> +#include <linux/kobject.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_profile.h>
>> +#include <linux/printk.h>
>> +#include <linux/string.h>
>> +#include <linux/sysfs.h>
> 
> I believe there are some unnecessary header files.
> (maybe fs.h, kobject.h, ...)
Seems likely - I did go through a few iterations and you're right that 
these should be removed.
> 
>> +
>> +static struct platform_profile_handler *cur_profile;
> 
> I think this could be `const` as well.
> (along with the argument of `platform_profile_register()`)
ack

> 
> 
>> +static DEFINE_MUTEX(profile_lock);
>> +
>> +/* Ensure the first char of each profile is unique */
> 
> I think this comment is not needed anymore, no?
Agreed
> 
> 
>> [...]
>> +static ssize_t platform_profile_choices_show(struct device *dev,
>> +					struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	int len = 0;
>> +	int i;
>> +
>> +	mutex_lock(&profile_lock);
>> +	if (!cur_profile) {
>> +		mutex_unlock(&profile_lock);
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!cur_profile->choices) {
>> +		mutex_unlock(&profile_lock);
>> +		return sysfs_emit(buf, "\n");
>> +	}
>> +
>> +	for (i = profile_low; i <= profile_perform; i++) {
>> +		if (cur_profile->choices & BIT(i)) {
>> +			if (len == 0)
>> +				len += sysfs_emit_at(buf, len, "%s",  profile_names[i]);
>> +			else
>> +				len += sysfs_emit_at(buf, len, " %s",  profile_names[i]);
>                                                                       ^^
> I'm unsure why there are two spaces before `profile_names[i]` in both previous places.
I'm unsure how I introduced these too....I'll clean up
> 
> 
>> +		}
>> +	}
>> +	len += sysfs_emit_at(buf, len, "\n");
>> +	mutex_unlock(&profile_lock);
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t platform_profile_show(struct device *dev,
>> +					struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	enum platform_profile_option profile;
>> +	int err;
>> +
>> +	mutex_lock(&profile_lock);
>> +	if (!cur_profile) {
>> +		mutex_unlock(&profile_lock);
>> +		return -EOPNOTSUPP;
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
>> +	return sysfs_emit(buf, "%s\n", profile_names[profile]);
> 
> I believe `profile` should be initialized to some value, and the value after the
> call to the handler it should be checked for validity, and maybe an warning should
> be emitted if it's out of range - in my opinion.
Agreed - and a check would do no harm. I'll add.
> 
> 
>> +}
>> +
>> +static ssize_t platform_profile_store(struct device *dev,
>> +			    struct device_attribute *attr,
>> +			    const char *buf, size_t count)
>> +{
>> +	int err, i;
>> +
>> +	mutex_lock(&profile_lock);
>> +	if (!cur_profile) {
>> +		mutex_unlock(&profile_lock);
>> +		return -EOPNOTSUPP;
> 
> I'm not sure why you modified the errno. ENODEV seemed to me like a perfectly
> fine error to return if `cur_profile` is not set. `platform_profile_choices_show()`
> returns ENODEV, so there is a bit of inconsistency.
> (same applies to `platform_profile_show()`)
My thinking was it seemed a better message. I can't really see any 
conditions when you'd get here (a driver would have registered a driver 
and then not provided a profile?) but it seemed that if that was 
possible it was more because changing the settings wasn't supported.

I managed to convince myself it made more sense - but have no issue with 
changing it back.
> 
> 
>> +	}
>> +
>> +	/* Scan for a matching profile */
>> +	i = sysfs_match_string(profile_names, buf);
>> +	if (i < 0) {
>> +		mutex_unlock(&profile_lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!cur_profile->profile_set) {
>> +		mutex_unlock(&profile_lock);
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	err = cur_profile->profile_set(i);
>> +	mutex_unlock(&profile_lock);
>> +	if (err)
>> +		return err;
>> +
>> +	return count;
>> +}
>> [...]
>> +int platform_profile_register(struct platform_profile_handler *pprof)
>> +{
>> +	mutex_lock(&profile_lock);
>> +	/* We can only have one active profile */
>> +	if (cur_profile) {
>> +		mutex_unlock(&profile_lock);
>> +		return -EEXIST;
>> +	}
>> +
>> +	cur_profile = pprof;
>> +	mutex_unlock(&profile_lock);
>> +	return sysfs_create_group(acpi_kobj, &platform_profile_group);
> 
> I believe the return value of `sysfs_create_group()` should be checked here,
> and `cur_profile` should only be set if that succeeds.
agreed.
> 
> 
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_register);
>> [...]
>> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
>> new file mode 100644
>> index 000000000000..f6592434c8ce
>> --- /dev/null
>> +++ b/include/linux/platform_profile.h
>> @@ -0,0 +1,36 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Platform profile sysfs interface
>> + *
>> + * See Documentation/ABI/testing/sysfs-platform_profile.rst for more
>> + * information.
>> + */
>> +
>> +#ifndef _PLATFORM_PROFILE_H_
>> +#define _PLATFORM_PROFILE_H_
>> +
>> +/*
>> + * If more options are added please update profile_names
>> + * array in platform-profile.c and sysfs-platform-profile.rst
>> + * documentation.
>> + */
>> +
>> +enum platform_profile_option {
>> +	profile_low,
>> +	profile_cool,
>> +	profile_quiet,
>> +	profile_balance,
>> +	profile_perform
>                         ^
> I believe there's no reason to remove the comma from there, and in fact,
> having a comma after the last entry in an array, enum, etc. seems to be
> the preferred.
OK.
Have to be honest - I struggle to know when comma's are needed on the 
last entry and when they aren't (I've had similar corrections in other 
cases both ways :)). I do seem to have a knack of getting it 
consistently wrong....

> 
> If you don't want to go the `platform_profile_last` route that I suggested previously,
> then I think a comment should mention that the last profile should be used
> in the static_assert() in platform-profile.c.
ok.
> 
> By the way, I still feel like the enum values are "too vague" and should be
> prefixed with `platform_`. If you're not opposed to that change.
Sure - I can change that. For me it made the names long but I don't mind 
changing them.
> 
> 
>> +};
>> +
>> +struct platform_profile_handler {
>> +	unsigned int choices; /* Bitmap of available choices */
>> +	int (*profile_get)(enum platform_profile_option *profile);
>> +	int (*profile_set)(enum platform_profile_option profile);
>> +};
>> +
>> +int platform_profile_register(struct platform_profile_handler *pprof);
>> +int platform_profile_unregister(void);
>> +int platform_profile_notify(void);
> 
> I don't think it's a big problem, but right now, I personally can't quite see the
> purpose `platform_profile_notify()` and `platform_profile_unregister()`
> returning any value.
OK - I can update
> 
> 
>> +
>> +#endif  /*_PLATFORM_PROFILE_H_*/
>> --
>> 2.25.1
> 
> 
> [1]: https://www.kernel.org/doc/html/latest/kernel-hacking/locking.html#locking-only-in-user-context
> 
> 
> Regards,
> Barnabás Pőcze
> 
Many thanks
Mark
