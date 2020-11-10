Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3CD2AD8F9
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 15:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgKJOk1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 09:40:27 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.5]:52234 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbgKJOk0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Nov 2020 09:40:26 -0500
Received: from [100.112.131.142] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.us-west-2.aws.symcld.net id 4D/3C-13169-756AAAF5; Tue, 10 Nov 2020 14:40:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRWlGSWpSXmKPExsWSLveKTXfyklX
  xBt0buCz2X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RoumziY2i88dk1ksVu95wWyx9ss8
  Noszpy+xOnB7TJo5g9lj56y77B6/tq1h8di8Qstj3slAj562TUwe7/ddZfPYcrWdxePzJrkAz
  ijWzLyk/IoE1oylew8zFdwKrli+aAljA2OvaxcjF4eQwH9GiQW/uhkhnOeMEo2HVwA5nBzCAr
  ESXW1b2LoYOThEBOwlXjwJAqlhFmhmkWi+9YAJoqGZSaJh/3tmkAY2AW2JLVt+sYHYvAK2Em+
  +vwEbxCKgKtHzv48dxBYVCJfouLGDCaJGUOLkzCcsIIM4BboYJT69/M4KkmAWsJCYOf88I4Qt
  LnHryXwmCFteonnrbLBlEkD263ftUHaCxLKXd5gnMArOQjJ3FpJRs5CMmoVk1AJGllWMFklFm
  ekZJbmJmTm6hgYGuoaGRrqGxoa6RsameolVuol6pcW65anFJbpGeonlxXrFlbnJOSl6eaklmx
  iB8ZlS0Px6B+OGNx/0DjFKcjApifL+mbsqXogvKT+lMiOxOCO+qDQntfgQowwHh5IEb88ioJx
  gUWp6akVaZg4wVcCkJTh4lER474GkeYsLEnOLM9MhUqcYFaXEeS0XAyUEQBIZpXlwbbD0dIlR
  VkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO81kPE8mXklcNNfAS1mAloc4LgCZHFJIkJKqoFpn
  ti+FWXu5rM010QWHJDh+P3C5HHe59C9Rp8dl3xfreDk8Nh59kOxzsvfmj/H+049PKlt0Y/zh5
  uOiqi8X/R29uWwM461khtSNDoaXRmc33ROEvxgMOHaim8zL/Q8Yv6ZcWbuiwfCb1wnOm4+9UZ
  mUolQlN/tDbo9a7Zb97iZq0Zum9kS/eZxdITUh10FK3ok4nyWWF75WTq/ZZHY5QdzHmhf7ZOI
  vBXJdmyzpL9V9EdmQ6dFc46+ODddTDey6/aBqT5ei3xVq8yTZ7eVq1WvetW2PEbiJgPHou1Oz
  kXNZ/mXcLUnNzfX929bf6f2mvCm8nthehu03wbfWPZG0uyE6a3nDL4vn3i3yE6f/eP6ayWW4o
  xEQy3mouJEAGqjahLKAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-26.tower-336.messagelabs.com!1605018768!2838!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25062 invoked from network); 10 Nov 2020 14:32:50 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-26.tower-336.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Nov 2020 14:32:50 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 65F0D8D9E32EA9442406;
        Tue, 10 Nov 2020 22:32:45 +0800 (CST)
Received: from localhost.localdomain (10.46.61.15) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 10 Nov
 2020 06:32:40 -0800
Subject: Re: [External] Re: [PATCH 2/3] ACPI: platform-profile: Add platform
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
 <20201110033124.3211-1-markpearson@lenovo.com>
 <20201110033124.3211-3-markpearson@lenovo.com>
 <2gY5rkKaKLKayk0DYW0lvZ_aIAs8vSf9FOy2obdGvph_7XcpyHlkafBTpW8RHKC5nEcEz_eY-s4pJtuR2ebltW2Fu10GRssTmMxKMuS4PU8=@protonmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <72b0fb0a-8007-d795-8b1a-68fa58231c23@lenovo.com>
Date:   Tue, 10 Nov 2020 09:32:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <2gY5rkKaKLKayk0DYW0lvZ_aIAs8vSf9FOy2obdGvph_7XcpyHlkafBTpW8RHKC5nEcEz_eY-s4pJtuR2ebltW2Fu10GRssTmMxKMuS4PU8=@protonmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.46.61.15]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks Barnabas

On 10/11/2020 05:15, Barnabás Pőcze wrote:
> Hi
> 
> I've added some questions and comments inline.
> 
> 
> 
> 2020. november 10., kedd 4:31 keltezéssel, Mark Pearson írta:
> 
>> [...]
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> new file mode 100644
>> index 000000000000..3c460c0a3857
>> --- /dev/null
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -0,0 +1,172 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +/*
>> + *  platform_profile.c - Platform profile sysfs interface
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/printk.h>
>> +#include <linux/kobject.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/init.h>
>> +#include <linux/fs.h>
>> +#include <linux/string.h>
>> +#include <linux/device.h>
>> +#include <linux/acpi.h>
>> +#include <linux/mutex.h>
>> +#include <acpi/acpi_bus.h>
>> +#include <linux/platform_profile.h>
> 
> This should preferably be alphabetically sorted.
Ack - I hadn't realised that was a requirement. I'll update
> 
> 
>> +
>> +struct platform_profile *cur_profile;
> 
> This should be `static`.
Agreed.

> 
> 
>> +DEFINE_MUTEX(profile_lock);
>> +
>> +/* Ensure the first char of each profile is unique */
> 
> I wholeheartedly disagree that only the first character should be considered.
> It is not future-proof, potentially subverts user expectation, and even worse,
> someone could rely on this (undocumented) behaviour.
OK, fair enough. I debated about it and it's nice just to do
    echo 'L' > platform_profile
instead of typing in a whole string, but I appreciate it's lazy.

I'm OK with fixing based on your points.

> 
> 
>> +static char *profile_str[] = {
> 
> Why is it not `const`?
My mistake. I will fix
> 
> 
>> +	"Low-power",
>> +	"Cool",
>> +	"Quiet",
>> +	"Balance",
>> +	"Performance",
>> +	"Unknown"
> 
> "unknown" is not documented, yet it may be returned to userspace.
Ack - I'll look into if it's really needed, but it seemed sensible to 
have it whilst doing the implementation.
> 
> 
>> +};
> 
> The documentation has the names in all-lowercase, and in my opinion it'd be
> better to use lowercase names here as well.
Agreed - my bad. I'll fix.
> 
> 
>> +
>> +static ssize_t platform_profile_choices_show(struct device *dev,
>> +					struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	int i;
>> +	int ret, count = 0;
>> +
>> +	mutex_lock(&profile_lock);
>> +	if (!cur_profile) {
>> +		mutex_unlock(&profile_lock);
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!cur_profile->choices) {
>> +		mutex_unlock(&profile_lock);
>> +		return snprintf(buf, PAGE_SIZE, "None");
> 
> "None" is not documented anywhere as far as I can see, maybe an empty line
> would be better in this case?
Agreed, I'll fix.
> 
> 
>> +	}
>> +
>> +	for (i = profile_low; i < profile_unknown; i++) {
>> +		if (cur_profile->choices & (1 << i)) {
> 
> `BIT(i)`?
Yes, that would be better.

> 
> 
>> +			ret = snprintf(buf+count, PAGE_SIZE, "%s ", profile_str[i]);
> 
> You could use `sysfs_emit_at()`. `ret` is only used in this block, so it could be
> defined here.
OK - I hadn't come across that function. I'll update to use it.

> 
> 
>> +			if (ret < 0)
>> +				break;
> 
> However unlikely this case is, I'm not sure if providing partial values is
> better than not providing any data at all.
Interesting point, I think I agree.
I'll look at returning an empty string if an error occurs.
> 
> 
>> +			count += ret;
>> +		}
>> +	}
>> +	mutex_unlock(&profile_lock);
> 
> I think a newline character should be written at the end (possibly overwriting
> the last space).
OK.

> 
> 
>> +	return count;
>> +}
>> +
>> +static ssize_t platform_profile_show(struct device *dev,
>> +					struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	enum profile_option profile = profile_unknown;
>> +
>> +	mutex_lock(&profile_lock);
>> +	if (!cur_profile) {
>> +		mutex_unlock(&profile_lock);
>> +		return -ENODEV;
>> +	}
>> +	if (cur_profile->profile_get)
>> +		profile = cur_profile->profile_get();
> 
> I'd assume that `profile_get()` can return any arbitrary errno, which is then
> propagated to the "reader", but it seems that's not the case?
> I think returning `-EOPNOTSUPP` would be better if `profile_get` is NULL.
OK - I went through a few iterations here and it's a bit weak. I'll look 
at it again.

> 
> 
>> +	mutex_unlock(&profile_lock);
>> +
>> +	return snprintf(buf, PAGE_SIZE, "%s", profile_str[profile]);
> 
> There is `sysfs_emit()`, as far as I know it is supposed to replace this exact
> snprintf(...) idiom. Directly indexing the `profile_str` with an unchecked
> value here is rather unsafe in my opinion.
Agreed - I'll fix this.
> 
> 
>> +}
>> +
>> +static ssize_t platform_profile_store(struct device *dev,
>> +			    struct device_attribute *attr,
>> +			    const char *buf, size_t count)
>> +{
>> +	enum profile_option profile;
>> +
>> +	mutex_lock(&profile_lock);
>> +	if (!cur_profile) {
>> +		mutex_unlock(&profile_lock);
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Scan for a matching profile */
>> +	for (profile = profile_low; profile < profile_unknown; profile++) {
>> +		if (toupper(buf[0]) == profile_str[profile][0])
>> +			break;
>> +	}
>> +	if (profile == profile_unknown) {
>> +		mutex_unlock(&profile_lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (cur_profile->profile_set)
>> +		cur_profile->profile_set(profile);
> 
> The return value is entirely discarded? I'd assume it's returned to the "writer".
> I'm also not sure if ignoring if `profile_set` is NULL is the best course of
> action. Maybe returning `-EOPNOTSUPP` would be better?
OK.

> 
> 
>> +
>> +	mutex_unlock(&profile_lock);
>> +	return count;
>> +}
>> +
>> +static DEVICE_ATTR_RO(platform_profile_choices);
>> +static DEVICE_ATTR_RW(platform_profile);
>> +
>> +static struct attribute *platform_profile_attributes[] = {
>> +	&dev_attr_platform_profile_choices.attr,
>> +	&dev_attr_platform_profile.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group platform_profile_attr_group = {
>> +	.attrs = platform_profile_attributes,
>> +};
> 
> It's a minor thing, but there is an `ATTRIBUTE_GROUPS()` macro which could possibly
> simplify the above part.
OK - I'd not come across that and will look at using it.
> 
> 
>> +
>> +int platform_profile_notify(void)
>> +{
>> +	if (!cur_profile)
>> +		return -ENODEV;
>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_notify);
>> +
>> +int platform_profile_register(struct platform_profile *pprof)
>> +{
>> +	mutex_lock(&profile_lock);
>> +	/* We can only have one active profile */
>> +	if (cur_profile) {
>> +		mutex_unlock(&profile_lock);
>> +		return -EEXIST;
>> +	}
>> +	cur_profile = pprof;
>> +	mutex_unlock(&profile_lock);
>> +	return sysfs_create_group(acpi_kobj, &platform_profile_attr_group);
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_register);
>> +
>> +int platform_profile_unregister(void)
>> +{
>> +	mutex_lock(&profile_lock);
>> +	sysfs_remove_group(acpi_kobj, &platform_profile_attr_group);
>> +	cur_profile = NULL;
>> +	mutex_unlock(&profile_lock);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_unregister);
>> +
>> +static int __init platform_profile_init(void)
>> +{
>> +	cur_profile = NULL;
> 
> If I'm not missing anything, `cur_profile` will be initialized to NULL, thus
> this is not needed.
I guess I was just playing safe here, I think you're right.
I'll remove.
> 
> 
>> +	return 0;
>> +}
>> +
>> +static void platform_profile_exit(void)
> 
> This should be marked `__exit`.
Not sure how I missed that one.... Thanks.
> 
> 
>> +{
>> +	sysfs_remove_group(acpi_kobj, &platform_profile_attr_group);
>> +	cur_profile = NULL;
>> +}
>> +
>> +MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
>> +MODULE_LICENSE("GPL");
>> +
>> +module_init(platform_profile_init);
>> +module_exit(platform_profile_exit);
>> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
>> new file mode 100644
>> index 000000000000..347a12172c09
>> --- /dev/null
>> +++ b/include/linux/platform_profile.h
>> @@ -0,0 +1,36 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * platform_profile.h - platform profile sysfs interface
>> + *
>> + * See Documentation/ABI/testing/sysfs-platform_profile for more information.
>> + */
>> +
>> +#ifndef _PLATFORM_PROFILE_H_
>> +#define _PLATFORM_PROFILE_H_
>> +
>> +/*
>> + * If more options are added please update profile_str
>> + * array in platform-profile.c
>> + */
>> +
>> +enum profile_option {
>> +	profile_low,
>> +	profile_cool,
>> +	profile_quiet,
>> +	profile_balance,
>> +	profile_perform,
>> +	profile_unknown /* Must always be last */
>> +};
> 
> Shouldn't these be prefixed by `platform_`? And I think it'd be better to have
> `profile_unknown` as the first value in the enumeration.
I can add 'platform_'
I liked having profile_unknown as the last value as it makes scanning 
from 'low' to 'unknown' more future proof if other profiles get added 
(e.g in platform_profile_choices_show).
Is this something you feel strongly about?
> 
> 
>> +
>> +struct platform_profile {
> 
> Personally, I think a name like platform_profile_(handler|provider)
> would be a better fit.
OK - happy to update that.
> 
> 
>> +	unsigned int choices; /* bitmap of available choices */
> 
> Most comments are capitalized.
Ack.
> 
> 
>> +	int cur_profile;      /* Current active profile */
> 
> `cur_profile` field doesn't seem to be used here. I see that it's utilized in the
> thinkpad_acpi driver, but I feel like this does not "belong" here.
It seemed a logical place to keep it to me. I understand where you're 
coming from, and I can change it so it's just internal to 
thinkpad_acpi.c but it just seemed a nice place to keep it and I'm 
guessing other implementations would like to have it too.

I'd be interested to see what others have to say on this one.
> 
> 
>> +	int (*profile_get)(void);
>> +	int (*profile_set)(int profile);
> 
> Why does it take an `int` instead of `enum profile_option`?
Mostly for error conditions to be propagated if needs be, though I have 
some improvements to do based on the comments above :)
> 
> 
>> +};
>> +
>> +extern int platform_profile_register(struct platform_profile *pprof);
>> +extern int platform_profile_unregister(void);
>> +extern int platform_profile_notify(void);
>> +
> 
> `extern` could be omitted from here. Although it seems rather "unregulated"
> whether `extern` is to be present in header files or not.
OK.
> 
> 
>> +#endif  /*_PLATFORM_PROFILE_H_*/
>> --
>> 2.28.0
> 
> 
> Regards,
> Barnabás Pőcze
> 
Thank you for the detailed review - really appreciate the time you spent 
going through this.

Mark
