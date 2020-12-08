Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659B12D334E
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Dec 2020 21:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgLHUQM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Dec 2020 15:16:12 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.5]:45377 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731114AbgLHUNi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2020 15:13:38 -0500
Received: from [100.112.131.75] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.us-west-2.aws.symcld.net id 65/14-49539-848DFCF5; Tue, 08 Dec 2020 19:47:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRWlGSWpSXmKPExsWS8eIhr67HjfP
  xBp+mclvsvy5h0bXQwGLh/VOsFl+/3Wa3eHN8OpPF8n39jBZNnU1sFp87JrNYrN7zgtli7Zd5
  bBZzv0xltjhz+hKrxYTFG9kdeD0mzZzB7LFz1l12j1/b1rB4bF6h5bFpVSebx7yTgR49bZuYP
  N7vu8rmseVqO4vH501yAVxRrJl5SfkVCawZF6b/ZSr4oVXROG0GawPjDoUuRi4OIYH/jBIXT1
  1lhXCeM0qcvPGKvYuRk0NYIEFi+qyfjCC2iIC2xJJFV5lBipgF5rFInGvYwQzRcZRJ4vrk/yw
  gVWxAVVu2/GIDsXkFbCX+Hl0JFmcRUJFYf+IkE4gtKhAusX7JSkaIGkGJkzOfgNVwCgRKvOu9
  DnQGB9AGTYn1u/RBwswC4hK3nsxngrDlJba/ncMMYksIKEj0v+ljh7ATJJa9vMM8gVFwFpKps
  xAmzUIyaRaSSQsYWVYxWiQVZaZnlOQmZuboGhoY6BoaGukaGhvoGhmZ6yVW6SbqlRbrlqcWl+
  ga6SWWF+sVV+Ym56To5aWWbGIERm5KQdPjHYw733zQO8QoycGkJMqbcfl8vBBfUn5KZUZicUZ
  8UWlOavEhRhkODiUJXo3rQDnBotT01Iq0zBxgEoFJS3DwKInwCoKkeYsLEnOLM9MhUqcYFaXE
  eWdfA0oIgCQySvPg2mCJ6xKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYV4FkPE8mXklcNNfA
  S1mAlrMcwlscUkiQkqqgUlG6f2K9T0Lrtdttqqx98/+rpH8ZFup9RW7apGbzO8z46TaF69e+F
  Lj/hOrfVF1RwPYfiqEP38yNXujt6pB9azJwh5OrrUxwkbeP6a8TWcrfeJ6c8H6Hez2SbtFXAs
  rHQ8qT7dLNvx65s+lq5v4RO1KvZ2ytdZdsL3r8ev4DqPTNSGC7M1HGMScBQSrmxwWtKs55/dL
  Hzt1+2uTxan526TucImHHelf7OV+devdwt9v3N8VPDiw0+nsmw91P66vXtzBZR+1ZJcJv5AVw
  8UToXZr3rmceWtpZpa15OEDG92NV5zSVH7fLpn+rT67U+g6Q4l2qLHT7DP1evvWma58HBOSxR
  q6/fbjsu+pf/bVvVBiKc5INNRiLipOBABRCsri1wMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-33.tower-336.messagelabs.com!1607456839!4060!1
X-Originating-IP: [104.232.225.13]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6959 invoked from network); 8 Dec 2020 19:47:20 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.13)
  by server-33.tower-336.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 8 Dec 2020 19:47:20 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id B540D14D5B2ACD255752;
        Tue,  8 Dec 2020 14:47:18 -0500 (EST)
Received: from localhost.localdomain (10.38.54.222) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 8 Dec 2020
 11:47:17 -0800
Subject: Re: [External] Re: [PATCH v5 2/3] ACPI: platform-profile: Add
 platform profile support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <markpearson@lenovo.com>
 <20201202171120.65269-1-markpearson@lenovo.com>
 <20201202171120.65269-2-markpearson@lenovo.com>
 <CAJZ5v0j9jZBoyvr4=2mTq1A8dc+rbUaf=Woy3PnpKh8Bbg=-RQ@mail.gmail.com>
 <2516bd75-952a-3b5e-0519-4c94d81eed4a@lenovo.com>
 <CAJZ5v0iaOcciagBekn8Y8qRVc0Q7Swt6-tJAYfvNhx0siLXX2w@mail.gmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <88bd78c5-2edc-005d-2281-115bbdca187f@lenovo.com>
Date:   Tue, 8 Dec 2020 14:47:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iaOcciagBekn8Y8qRVc0Q7Swt6-tJAYfvNhx0siLXX2w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.54.222]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 08/12/2020 14:18, Rafael J. Wysocki wrote:
> On Tue, Dec 8, 2020 at 7:54 PM Mark Pearson <markpearson@lenovo.com> wrote:
>>
>> Hi Rafael,
>>
>> Thanks for the review - a couple of questions (and a bunch of acks) below
>>
>> On 08/12/2020 13:26, Rafael J. Wysocki wrote:
>>> On Wed, Dec 2, 2020 at 6:16 PM Mark Pearson <markpearson@lenovo.com> wrote:
> 
> [cut]
> 
>>>> +static const struct platform_profile_handler *cur_profile;
>>>> +static DEFINE_MUTEX(profile_lock);
>>>> +
>>>> +static const char * const profile_names[] = {
>>>> +       [platform_profile_low] = "low-power",
>>>> +       [platform_profile_cool] = "cool",
>>>> +       [platform_profile_quiet] = "quiet",
>>>> +       [platform_profile_balanced] = "balanced",
>>>> +       [platform_profile_perform] = "performance",
>>>
>>> The enum values in upper case, please.
>> Sorry, I'm a bit confused here - do you mean change to "Low-power" or
>> something else (maybe PLATFORM_PROFILE_LOW?)
> 
> platform_profile_low -> PLATFORM_PROFILE_LOW
> platform_profile_cool -> PLATFORM_PROFILE_COOL
> 
> etc.
> 
Got it - I'll update. Thanks for the clarification

>> Just want to make sure I'm getting it correct. If I change the strings
>> it will impact patch1 in the series which is integrated into your
>> bleeding-edge branch.
>>
>>>
>>>> +};
>>>> +static_assert(ARRAY_SIZE(profile_names) == platform_profile_last);
>>>> +
>>>> +static ssize_t platform_profile_choices_show(struct device *dev,
>>>> +                                       struct device_attribute *attr,
>>>> +                                       char *buf)
>>>> +{
>>>> +       int len = 0;
>>>> +       int err, i;
>>>> +
>>>> +       err = mutex_lock_interruptible(&profile_lock);
>>>
>>> Why interruptible?
>>>
>>> And why is the lock needed in the first place?
>>
>> My thinking was that I don't know what happens when I hand over to thhe
>> platform driver who does the get/set, so having a lock to prevent a get
>> whilst a set is in operation seemed like a good idea.
> 
> Taking it over get/set probably is (and you need to protect the
> cur_profile pointer from concurrent updates).
> 
> And here you need to ensure that the cur_profile object doesn't go
> away while this is running.  So that's why.
> 
>> It was interruptible as a suggestion in an earlier reivew as the
>> preferred way of doing these things for functions that could be called
>> by user space.
> 
> Well, it is not used consistently this way at least.  But OK.

That was based on review comments - interruptible used where it could be
accessed from user space and not where it couldn't. Hans made some good
notes about it previously.
> 
>> Do you think the lock is a problem?
> 
> No, it isn't in principle.
> 
>>>
>>>> +       if (err)
>>>> +               return err;
>>>> +
>>>> +       if (!cur_profile) {
>>>> +               mutex_unlock(&profile_lock);
>>>> +               return -ENODEV;
>>>> +       }
>>>> +
>>>> +       for_each_set_bit(i, cur_profile->choices, platform_profile_last) {
>>>> +               if (len == 0)
>>>> +                       len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>>>> +               else
>>>> +                       len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>>>> +       }
>>>> +       len += sysfs_emit_at(buf, len, "\n");
>>>> +       mutex_unlock(&profile_lock);
>>>> +       return len;
>>>> +}
>>>> +
>>>> +static ssize_t platform_profile_show(struct device *dev,
>>>> +                                       struct device_attribute *attr,
>>>> +                                       char *buf)
>>>> +{
>>>> +       enum platform_profile_option profile = platform_profile_balanced;
>>>> +       int err;
>>>> +
>>>> +       err = mutex_lock_interruptible(&profile_lock);
>>>> +       if (err)
>>>> +               return err;
>>>> +
>>>> +       if (!cur_profile) {
>>>> +               mutex_unlock(&profile_lock);
>>>> +               return -ENODEV;
>>>> +       }
>>>> +
>>>> +       err = cur_profile->profile_get(&profile);
>>>
>>> In which cases this can fail?
>> I'm not sure - but as this is supposed to be vendor agnostic I can't
>> foresee what might be wanted or could happen on various hardware.
> 
> It returns the index of the current profile AFAICS, so I don't really
> see a reason for it to fail.
> 
> Moreover, the index could be maintained by the common code along with
> the cur_profile pointer, couldn't it?
OK - I see your point.

I think that it's good to check for an error from the driver and to not
display a potentially incorrect value in the case of an error.

I double checked and in the Lenovo case (patch 3) all of this works
exactly as you describe (so my previous comment was incorrect). The
value is cached in thinkpad_acpi and there can't be an error returned.
But it seems wrong to make assumptions on others wanting to do the same
in the future as their implementation might have different constraints.

Let me know if you feel strongly about this and I can update, from my
point of view I lean towards leaving it as it is but it doesn't impact
the Lenovo implementation.

> 
<snip>>>>> +
>>>> +enum platform_profile_option {
>>>> +       platform_profile_low,
>>>> +       platform_profile_cool,
>>>> +       platform_profile_quiet,
>>>> +       platform_profile_balanced,
>>>> +       platform_profile_perform,
>>>> +       platform_profile_last, /*must always be last */
> 
> So please use upper-case names in this list.
> 
Ack

Thanks for the clarifications
Mark
