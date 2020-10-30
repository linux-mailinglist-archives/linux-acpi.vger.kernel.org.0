Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E329B2A0205
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 11:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgJ3KBq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 06:01:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbgJ3KBp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 06:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604052104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qh++YDjpLMr2T/NwgklzR0r6j7IRiLB3Ll291xVhXSE=;
        b=Jsllh/5BkR+Xc7hMaeDb6cU9VXQr5eRXu02aiyV7XhZc5mfZVF3YumJ7pae2gcq1Lv+422
        +CKZarVbYB39hO6ZEXoAh7Ufow6Y2khsDt+WEXmPL9yU0qriZeUqJPPjjGVG7OLyNZCgsG
        KyJ5HdAx8Y4V8yaffCNWZ7fXAp69EEo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-vvu4MNjCP6C0D6UL8M-Ocg-1; Fri, 30 Oct 2020 06:01:41 -0400
X-MC-Unique: vvu4MNjCP6C0D6UL8M-Ocg-1
Received: by mail-ed1-f71.google.com with SMTP id bs10so2392377edb.22
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2020 03:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qh++YDjpLMr2T/NwgklzR0r6j7IRiLB3Ll291xVhXSE=;
        b=ncXg8zYvb+PYgQmVeyBgxGVKJXOIrhzsgwYfLdSdBmpdWBqqqYP9GuWV0KJaWPMt/+
         zmnnWFCNGeaDxo3j8qaJwwxl9FhhQGfoV7x7fkYz9YHmp/fEsGcBh5/Zo4PKyY/XiaRM
         8vbp/T/SYSP5o6QCfv4KXd6aN99kmYdA7Lm3sabTIVydK7tiGoe31rPyKkTgO/kdz6zi
         Qnr4tMUvrOnGG18bj73NVMKHiQFMU1dnmjkH1P7V72yeMABQkmU+5Fp5LfO8eeK6Uwmx
         CT6+/BLwB6vjtB4NM/0qkkw+dvX3v0KNZawFbho9OuHFym+cMaduLm5xvoSp+H6Z5WFN
         HWdA==
X-Gm-Message-State: AOAM533aNmQOnD9xM3AAwmdLAh1lno45GFDbfRWL5EXymsH+WFUxF6Kp
        T0muoMKbHdsSu2H3/tim+etZ6LqA7gHQbsKQV1V0ZZ9C1vQNOsOuUP2LBE8siF2GKc1Kx+XdDzi
        GJr2XqcLynZs0OOosJ4rtpA==
X-Received: by 2002:a17:906:4d03:: with SMTP id r3mr1498838eju.364.1604052100571;
        Fri, 30 Oct 2020 03:01:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR/QgAeFT6uCvIRGJTtj36hLcVbl/CF9UaFP/+FfZZ2BEaFM1sGsXoSqK6Ey3ng9M8D0CyMw==
X-Received: by 2002:a17:906:4d03:: with SMTP id r3mr1498818eju.364.1604052100400;
        Fri, 30 Oct 2020 03:01:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id v21sm2788872edt.80.2020.10.30.03.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 03:01:39 -0700 (PDT)
Subject: Re: [PATCH] PM / reboot: Use S5 for reboot
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201030070659.16948-1-kai.heng.feng@canonical.com>
 <45641823-1866-4FF5-9A1C-BFF61A66FCE3@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f8e03d98-1732-81f8-9557-a5da8f962368@redhat.com>
Date:   Fri, 30 Oct 2020 11:01:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <45641823-1866-4FF5-9A1C-BFF61A66FCE3@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/30/20 8:09 AM, Kai-Heng Feng wrote:
> Hi Hans,
> 
>> On Oct 30, 2020, at 15:06, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>
>> After reboot, it's not possible to use hotkeys to enter BIOS setup and
>> boot menu on some HP laptops.
>>
>> BIOS folks identified the root cause is the missing _PTS call, and BIOS
>> is expecting _PTS to do proper reset.
>>
>> Using S5 for reboot is default behavior under Windows, "A full shutdown
>> (S5) occurs when a system restart is requested" [1], so let's do the
>> same here.
> 
> I wonder if this can also solve "HID: i2c-hid: Put ACPI enumerated devices in D3 on shutdown" fixed.

I just checked the _PTS of one of the devices with the SMO91D0 i2c-hid
sensor-hub and it does not appear to turn off the sensor-hub (or any
other devices for that matter). Specifically it does not touch the
GPIO used by the _PS0 / _PS3 methods of the SMO91D0.

Regards,

Hans




>> [1] https://docs.microsoft.com/en-us/windows/win32/power/system-power-states
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> kernel/reboot.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>> index e7b78d5ae1ab..7e5aa1f78693 100644
>> --- a/kernel/reboot.c
>> +++ b/kernel/reboot.c
>> @@ -244,6 +244,8 @@ void migrate_to_reboot_cpu(void)
>> void kernel_restart(char *cmd)
>> {
>> 	kernel_restart_prepare(cmd);
>> +	if (pm_power_off_prepare)
>> +		pm_power_off_prepare();
>> 	migrate_to_reboot_cpu();
>> 	syscore_shutdown();
>> 	if (!cmd)
>> -- 
>> 2.17.1
>>
> 

