Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7F82C771E
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Nov 2020 02:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgK2BNf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Nov 2020 20:13:35 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.115]:61362 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbgK2BNf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 28 Nov 2020 20:13:35 -0500
Received: from [100.112.133.178] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-west-2.aws.symcld.net id 4A/D5-49214-574F2CF5; Sun, 29 Nov 2020 01:08:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRWlGSWpSXmKPExsWSLveKXbf0y6F
  4g6Ybohb7r0tYdC00sFh4/xSrxddvt9kt3hyfzmSxfF8/o8XHZRwWnzsms1is3vOC2WLtl3ls
  FmdOX2J14PaYNHMGs8fOWXfZPX5tW8PisXmFlse8k4EePW2bmDze77vK5rHlajuLx+dNcgGcU
  ayZeUn5FQmsGTvnvmEt2C1e8ebuepYGxlnCXYxcHEIC/xglJp/exgjhvGCUOP5lOlMXIyeHsE
  CCxKHma6xdjBwcIgL2Ei+eBIHUMAs0s0hc/byCCaKhlUni98qj7CANbALaElu2/GIDsXkFbCV
  OP37OCmKzCKhKHJr0HywuKhAusX7JSkaIGkGJkzOfsIAM4hToYpT4vv0eC0iCWcBCYub884wQ
  trjErSfzmSBseYnmrbOZQWwJAQWJlXcOs0HYCRLLXt5hnsAoOAvJ3FlIRs1CMmoWklELGFlWM
  ZonFWWmZ5TkJmbm6BoaGOgaGhrpGhqb6pqa6iVW6SbplRbrlqcWl+ga6SWWF+sVV+Ym56To5a
  WWbGIExmZKQbv5DsYXrz/oHWKU5GBSEuX1un4oXogvKT+lMiOxOCO+qDQntfgQowwHh5IEb/4
  noJxgUWp6akVaZg4wTcCkJTh4lER4D4CkeYsLEnOLM9MhUqcYFaXEeeeBJARAEhmleXBtsNR0
  iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5IwLx/IFJ7MvBK46a+AFjMBLXb5vx9kcUkiQkqqg
  ckl1LZiYg/7P08R68+3ArlclBceX6dy4Yb/O/1n17OfiNRe4JueY2K0rzNww8FIW3fxv49TtN
  VUVgv2navayLKmU//xx+AjVyb3l94wE793l/t3T93X+qvr38UmX32hovJ6xqtfRdMumTIc5uY
  Ia8lc9Txcz2aiwSm+J9efrl62ZUXmyytCzBlh+gFz1jzIyrNlKdco2ba27lyOBXdm1bQLee5f
  0jQSLhb848szjDije4RnN/9HU1sTkRcTIs2iQg8l7Z3QqJvCFXfM/LIpj1TFw5NtziduvowWD
  ti0t1546QvbGLe3Uj7MVj8/OWrPe1of8MhpfsWdzGkXdt658z25MXGu29/slc0n7ArlNimxFG
  ckGmoxFxUnAgBAXmQryAMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-27.tower-355.messagelabs.com!1606612083!58179!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1877 invoked from network); 29 Nov 2020 01:08:05 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-27.tower-355.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Nov 2020 01:08:05 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 8B2C62EA95B2E0B792A;
        Sun, 29 Nov 2020 09:08:00 +0800 (CST)
Received: from localhost.localdomain (10.64.84.236) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Sat, 28 Nov
 2020 17:07:54 -0800
Subject: Re: [External] Re: [PATCH v4 2/3] ACPI: platform-profile: Add
 platform profile support
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "mario.limnociello@dell.com" <mario.limnociello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201126165143.32776-1-markpearson@lenovo.com>
 <20201126165143.32776-2-markpearson@lenovo.com>
 <GojTnStq-_lTx1Zy0JIDn-_9ZHLyyTvtUeg4BwNAS51dogIGCn4Ou8qnRTqkJSjp6pHBv3SeuFthHhL58ID3tJSb7w31Ix-2UxExy-d-tIQ=@protonmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <f9653a23-aeea-191b-163d-ecbe9d3d352d@lenovo.com>
Date:   Sat, 28 Nov 2020 20:07:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <GojTnStq-_lTx1Zy0JIDn-_9ZHLyyTvtUeg4BwNAS51dogIGCn4Ou8qnRTqkJSjp6pHBv3SeuFthHhL58ID3tJSb7w31Ix-2UxExy-d-tIQ=@protonmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.64.84.236]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks Barnabas,

On 2020-11-27 2:14 p.m., Barnabás Pőcze wrote:
> Hi
> 
> 
> 2020. november 26., csütörtök 17:51 keltezéssel, Mark Pearson írta:
> 
>> [...]
> +static const char * const profile_names[] = {
> +	[platform_profile_low] = "low-power",
> +	[platform_profile_cool] = "cool",
> +	[platform_profile_quiet] = "quiet",
> +	[platform_profile_balance] = "balance",
> 
> Documentation says "balanced".
Ah, my bad. I will correct.
> 
> 
> +	[platform_profile_perform] = "performance",
> +};
>> [...]
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
> 
> In `platform_profile_store()`, you do
> ```
> err = cur_profile->profile_set(i);
> if (err)
>    return err;
> ```
> but here you do `if (err < 0)`, why?
At one point I had this function returning the profile, but then it 
ended up getting messy for handling errors. I changed it but didn't 
change the error handling - I'll tidy this up. Thanks!
> 
> 
>> +	/* Check that profile is valid index */
>> +	if ((profile < 0) || (profile >= ARRAY_SIZE(profile_names)))
>> +		return sysfs_emit(buf, "\n");
>> +
> 
> I'd write `if (WARN_ON(profile < 0 ....))` since that is serious error in my
> opinion which should be logged. I am also not sure if
Will do. I've not had any experience with the WARN_ON macro before - 
thanks for the suggestion.
> 
> 
>> +	return sysfs_emit(buf, "%s\n", profile_names[profile]);
>> +}
>> [...]
>> +int platform_profile_unregister(void)
>> +{
>> +	int err;
>> +
>> +	err = mutex_lock_interruptible(&profile_lock);
>> +	if (err)
>> +		return err;
>> +
> 
> I know it was me who said to prefer `mutex_lock_interruptible()`, but in this
> particular instance I believe `mutex_lock()` would be preferable to avoid the case
> where the module unloading is interrupted, and thus the profile handler is not
> unregistered properly. This could be handled in each module that uses this
> interface, however, I believe it'd be better to handle it here.
Agreed (and I know Hans makes the same point in his email). Your 
suggestion makes sense, I'll switch back to mutex_lock for the register 
and unregister functions.
> 
> 
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
>> [...]
> 
> 
> Regards,
> Barnabás Pőcze
> 
Thank you for the review!
Mark
