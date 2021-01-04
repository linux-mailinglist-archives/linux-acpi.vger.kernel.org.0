Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8EC2E9F21
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 22:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbhADU7l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 15:59:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbhADU7k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 15:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609793893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tauq2uTVhyfyyoSsCOVVm7HYk337XmgPOsROG0PlEaA=;
        b=aQWNXXgiRtTPnb119j4Nn3MA5JXuYd0n+jsAHbgPLaTB1Wutax4A5Z5Hw+YUAyMStP3Suc
        QdeXgUyLqdKL48BC/pxgoWYqh74dSuT3dZe0XSL30ivQtJOLPw/nAGeZXBZEjyUbKwOX9b
        Ox/IdQDkw1FZUR0ktvxTiZCRuAmbl10=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-qf1b4pkrP5SfbWaGrzN1Eg-1; Mon, 04 Jan 2021 15:58:12 -0500
X-MC-Unique: qf1b4pkrP5SfbWaGrzN1Eg-1
Received: by mail-ed1-f70.google.com with SMTP id bf13so12735214edb.10
        for <linux-acpi@vger.kernel.org>; Mon, 04 Jan 2021 12:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tauq2uTVhyfyyoSsCOVVm7HYk337XmgPOsROG0PlEaA=;
        b=IdSuqlk47I5AuDUPTt4kft/mxVr80okB+gcxlVu2hcaiivx5SMiR9Tnx1QFccLKj6w
         lmejVXuT9sVmdn/dNhe7y+SPyLsLsXDX9MCjq21CY3ZuRZnPX+VMCCPTp89pC8p1xa5Z
         D8QK+1ox5jojcdStB0HZfTP530EdzslDEWGYcFOicllwRKNFpZNBF7XPlZTyZXEreU7W
         BvYY65SdJsvwEE9IFGAA1WyxH4cnejFUp45dqw9YocWD0XixeTDF2s8yQHqn9BN45Il2
         UjuDNSoama6J3HL/VJNWrueNQKIIf+NuzxDn/J8hCcjl+8p+MeDitD/sNl45tNh28ikx
         JDHA==
X-Gm-Message-State: AOAM531F2J91JX4vo4nWjEcX9Um55I4b5IIrWnFhZG769qKlHuF5HYds
        C6LEJvsu2jCpaUEwqHyj6A1RV+t9wiepYfEMlA9oq5iyhaQm3ubPjPkF0NJSskLbocn7ep6NgQu
        ENdWCdJqmOj4QlUY8VAQkAg==
X-Received: by 2002:a17:906:3f8d:: with SMTP id b13mr54416050ejj.464.1609793890908;
        Mon, 04 Jan 2021 12:58:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+SRXVeTiMwsWdR1ZNHioXn72NhSStHZhsqv0Mg8+4LJdimkjkZxfZ2HKLOCQJH4iautPLag==
X-Received: by 2002:a17:906:3f8d:: with SMTP id b13mr54416039ejj.464.1609793890724;
        Mon, 04 Jan 2021 12:58:10 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id hb18sm23925888ejb.86.2021.01.04.12.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 12:58:10 -0800 (PST)
Subject: Re: [PATCH 0/2] IdeaPad platform profile support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
 <35ac853a-266c-6944-6e5e-6286456865e3@redhat.com>
 <CAJZ5v0jcCD3qWUJQcS+nFVJWSCQEbq2eN3i07mN8yFr3WZD9dg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com>
Date:   Mon, 4 Jan 2021 21:58:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jcCD3qWUJQcS+nFVJWSCQEbq2eN3i07mN8yFr3WZD9dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/4/21 9:33 PM, Rafael J. Wysocki wrote:
> On Mon, Jan 4, 2021 at 3:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 1/1/21 1:56 PM, Jiaxun Yang wrote:
>>> Tested on Lenovo Yoga-14SARE Chinese Edition.
>>>
>>> Jiaxun Yang (2):
>>>   ACPI: platform-profile: Introduce data parameter to handler
>>>   platform/x86: ideapad-laptop: DYTC Platform profile support
>>>
>>>  drivers/acpi/platform_profile.c       |   4 +-
>>>  drivers/platform/x86/Kconfig          |   1 +
>>>  drivers/platform/x86/ideapad-laptop.c | 281 ++++++++++++++++++++++++++
>>>  include/linux/platform_profile.h      |   5 +-
>>>  4 files changed, 287 insertions(+), 4 deletions(-)
>>
>>
>> Thank you for your series, unfortunately the
>> "ACPI: platform-profile: Introduce data parameter to handler"
>> patch causes a conflict with the pending:
>> "[PATCH v8 3/3] platform/x86: thinkpad_acpi: Add platform profile support"
>> patch.
>>
>> But I do agree that adding that data parameter makes sense, so
>> it might be best to merge:
>>
>> "ACPI: platform-profile: Introduce data parameter to handler"
>>
>> First and then rebase the thinkpad_acpi patch on top.
>>
>> Rafael, do you think you could add:
>>
>> "ACPI: platform-profile: Introduce data parameter to handler"
>>
>> To the 2 ACPI: platform-profile patches which you already have pending for 5.11-rc# ?
> 
> I'm not sure why that patch is needed at all, because whoever
> registers a platform profile handler needs to have access to the
> original handler object anyway.

True, I was actually thinking that instead of the data argument, we might
pass a pointer to the original handler object like this:

@@ -64,7 +64,7 @@ static ssize_t platform_profile_show(struct device *dev,
 		return -ENODEV;
 	}
 
-	err = cur_profile->profile_get(&profile);
+	err = cur_profile->profile_get(cur_profile, &profile);
 	mutex_unlock(&profile_lock);
 	if (err)
 		return err;

And then the driver which has registered the cur_profile, can get to
its own data by using container of on the cur_profile pointer.

With the code currently in your bleeding-edge branch, there is no way
for any driver-code to get to its own (possibly/likely dynamically
allocated) driver-data struct.

E.g. a typical driver using only dynamic data tied to device_get_drvdata,
might have this:

struct driver_data {
	...
	struct platform_profile_handler profile_handler;
	...
};

int probe(...) {
	struct driver_data *my_data;

	my_data = devm_kzalloc(dev, sizeof(*my_data), GFP_KERNEL);

	...

	ret = platform_profile_register(&my_data->profile_handler);
	...
}

And with the change which I suggest above would then be able to
get the struct driver_data *my_data back from the profile_get callback by
using container_of on the struct platform_profile_handler *profile_handler
argument added to the profile_get callback.

I know that the platform_profile stuff is intended to only have a
single provider, so this could use global variables, but some
drivers which may be a provider use 0 global variables (other then
module_params) atm and it would be a lot cleaner from the pov
of the design of these drivers to be able to do something like the
pseudo code above. Which is why I added my Reviewed-by to patch 1/2
of the series from this thread.

Patch 1/2 does use a slightly different approach then I suggest above,
thinking more about this it would be cleaner IMHO to just pass the
cur_profile pointer to the callbacks as the pseudo-code patch which I
wrote above does. Drivers which use globals can then just ignore
the extra argument (and keep the platform_profile_handler struct const)
where as drivers which use dynamic allocation can embed the struct in
their driver's data-struct.

> Also, on a somewhat related note, I'm afraid that it may not be a good
> idea to push this series for 5.11-rc in the face of recent objections
> against new material going in after the merge window.

That is fine with me, since this did not make rc1 (nor rc2) I'm not entirely
comfortable with sending out a late pull-req for the pdx86 side of this
either, so lets postpone this to 5.12 (sorry Mark).

Rafael, once we have the discussion with the passing a pointer back to
the drivers data thing resolved (and a patch merged for that if we go
that route) can you provide me with an immutable branch to merge into
pdx86/for-next so that I can then merge the pdx86 bits on top ?

Note this does not need to be done right now around say rc4 would be fine,
so that we have some time for the patches currently in bleeding-edge to
settle a bit.

Regards,

Hans

