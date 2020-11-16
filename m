Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05632B492A
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 16:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgKPPZt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 10:25:49 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.116]:7386 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727820AbgKPPZs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Nov 2020 10:25:48 -0500
Received: from [100.112.134.162] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-west-2.aws.symcld.net id D6/39-18625-AF992BF5; Mon, 16 Nov 2020 15:25:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRWlGSWpSXmKPExsWS8eIhj+6vmZv
  iDWaf57XYf13ComuhgcXC+6dYLb5+u81u8eb4dCaL5fv6GS2aOpvYLD53TGaxWL3nBbPF2i/z
  2CzOnL7E6sDtMWnmDGaPnbPusnv82raGxWPzCi2PeScDPXraNjF5vN93lc1jy9V2Fo/Pm+QCO
  KNYM/OS8isSWDMWvl7LXvBJtOLoW/0Gxr+CXYxcHEIC/xkl9p39wgjhvGSU+HNsIksXIyeHsE
  CMxI+9k4FsDg4RAXuJF0+CQGqYBZpZJJpvPWCCaGhnlrhyfyITSAObgLbEli2/2EBsXgFbiRe
  HJzKD2CwCqhJ/Pv9hBbFFBcIl1i9ZyQhRIyhxcuYTFpBBnAJdjBKnNmwF28wsYCExc/55Rghb
  XOLWk/lMELa8RPPW2WBDJQQUJdYsOcYIYSdILHt5h3kCo+AsJHNnIRk1C8moWUhGLWBkWcVok
  VSUmZ5RkpuYmaNraGCga2hopGtobALEZnqJVbpJeqXFuuWpxSW6RnqJ5cV6xZW5yTkpenmpJZ
  sYgdGZUtDWsYNx+psPeocYJTmYlER5d/ptihfiS8pPqcxILM6ILyrNSS0+xCjDwaEkwasJjHc
  hwaLU9NSKtMwcYKKASUtw8CiJ8ErOAErzFhck5hZnpkOkTjEqSonz5oMkBEASGaV5cG2w5HSJ
  UVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDva5ApPJl5JXDTXwEtZgJavEN7A8jikkSElFQDk
  67IFp4/3oHv9lmu/b5/V8r2mPyDSiddFyb6+12rzJvM/3+S1+5/rW9MD/R2d/YrSGUuSw+6OX
  n16n6vpMVf98Uc2Oquop06rVv86hm/tFdd6b0r2mavmfj+1/tM1r7CLP7ZBg/ufOryeGTz8e9
  LRY/OCn+tx31p3btfzunvmKS43VPLQDr61lozjvz5nzTbD28+J25XeVvmSkX9+RiWC8U+aT0K
  75c8ERNeZrZg8Sknnbl9M+L41JV8V+q/qL67fQLHuW+hbJ/uRHNtqJU7cerb1fObNEuL1lbtc
  y2y/RXrM/UB+9XlR8Jbd1hPOeLS9+GQfIppv1K7mVjbNb7Y2kT+ozeVeie8nCowL6vHTYmlOC
  PRUIu5qDgRAMXzduDJAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-21.tower-355.messagelabs.com!1605540345!2527!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7976 invoked from network); 16 Nov 2020 15:25:46 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-21.tower-355.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Nov 2020 15:25:46 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id A8FB64DD78DA1F5672FA;
        Mon, 16 Nov 2020 10:25:44 -0500 (EST)
Received: from localhost.localdomain (10.38.109.160) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 16 Nov
 2020 07:25:43 -0800
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
 <3bdd8da6-a47a-fbc6-de0e-858f493a226e@lenovo.com>
 <V-4DMCmZGmDmzaFHHwDhxqTzfNm25SyViOwvoJKvAUytgpL2XlM5u9GZy5AOfxN0r0QjSoCBFt5PQvUtbVRUQQE8oiRzB2j_HGM7U_4s304=@protonmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <90587ee8-4b41-642a-f679-2151c8cade81@lenovo.com>
Date:   Mon, 16 Nov 2020 10:25:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <V-4DMCmZGmDmzaFHHwDhxqTzfNm25SyViOwvoJKvAUytgpL2XlM5u9GZy5AOfxN0r0QjSoCBFt5PQvUtbVRUQQE8oiRzB2j_HGM7U_4s304=@protonmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.109.160]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Barnabás

On 16/11/2020 05:24, Barnabás Pőcze wrote:
> Hi
> 
> 
> 2020. november 16., hétfő 0:04 keltezéssel, Mark Pearson írta:
> 
>> [...]
>>>> +static ssize_t platform_profile_store(struct device *dev,
>>>> +			    struct device_attribute *attr,
>>>> +			    const char *buf, size_t count)
>>>> +{
>>>> +	int err, i;
>>>> +
>>>> +	mutex_lock(&profile_lock);
>>>> +	if (!cur_profile) {
>>>> +		mutex_unlock(&profile_lock);
>>>> +		return -EOPNOTSUPP;
>>>
>>> I'm not sure why you modified the errno. ENODEV seemed to me like a perfectly
>>> fine error to return if `cur_profile` is not set. `platform_profile_choices_show()`
>>> returns ENODEV, so there is a bit of inconsistency.
>>> (same applies to `platform_profile_show()`)
>> My thinking was it seemed a better message. I can't really see any
>> conditions when you'd get here (a driver would have registered a driver
>> and then not provided a profile?) but it seemed that if that was
>> possible it was more because changing the settings wasn't supported.
>>
>> I managed to convince myself it made more sense - but have no issue with
>> changing it back.
>>>
>>>
>>>> +	}
>>>> +
>>>> +	/* Scan for a matching profile */
>>>> +	i = sysfs_match_string(profile_names, buf);
>>>> +	if (i < 0) {
>>>> +		mutex_unlock(&profile_lock);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (!cur_profile->profile_set) {
>>>> +		mutex_unlock(&profile_lock);
>>>> +		return -EOPNOTSUPP;
>>>> +	}
>>>> +
> 
> One thing I have just noticed is that I believe the selected profile should be
> checked against `cur_profile->choices`, don't you think? I have assumed for
> some reason that this check is done, and `profile_set` is only called with values
> that the handler supports (they are in `choices`) up until now, but I see
> that that's not what's happening.
True - I guess no harm adding the check in platform_profile.c too.

> 
> 
>>>> +	err = cur_profile->profile_set(i);
>>>> +	mutex_unlock(&profile_lock);
>>>> +	if (err)
>>>> +		return err;
>>>> +
>>>> +	return count;
>>>> +}
>> [...]
>>>> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
>>>> new file mode 100644
>>>> index 000000000000..f6592434c8ce
>>>> --- /dev/null
>>>> +++ b/include/linux/platform_profile.h
>>>> @@ -0,0 +1,36 @@
>> [...]
>>>
>>> By the way, I still feel like the enum values are "too vague" and should be
>>> prefixed with `platform_`. If you're not opposed to that change.
>> Sure - I can change that. For me it made the names long but I don't mind
>> changing them.
> 
> Short and succinct names a good, but I hope you can see why I'm saying what I'm
> saying. I believe these names should be "properly namespaced" since they are in
> a "kernel-global" header file.
I do and I will update :)

Thanks for all the pointers
Mark
