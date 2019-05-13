Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6B041B1FF
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2019 10:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfEMIlh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 May 2019 04:41:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42316 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfEMIlh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 May 2019 04:41:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id l25so16379615eda.9
        for <linux-acpi@vger.kernel.org>; Mon, 13 May 2019 01:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OIf8haTF2Bfq6KgXaHObQw+4UkgBzPMbJonVONG6w/E=;
        b=trnO0/ffMeTW+xTCWfgnOhau5sVQp9zvMat9/6dmjXrHW1fEAjk6Ejb8UbmjbRVW/G
         0a7/MEmOzZ+eqK0xjYWELE1hQyGX5IE/TispFfUuM12OdlKRRBAQnT69tl6ZPLAtuw4J
         re9xan74JDo11DoRStMrTf0YUoPYRaL3Gzc048mf8CtIBm0Dqrv1cFQopuiBjjDvwMdE
         MNGRmCj75e9LH7duBTR/h2/KplKcNh5CWDFmlbLY2KZFp1TI8zMt32KB13XyUSGXEIbF
         vHj8M7POAii6jsc+Rt4oveqfloPzU2KbN12n1tZvrH/N/YdzhLlw7f5aO3yPwKEiFwXB
         q3EA==
X-Gm-Message-State: APjAAAXQYs3QmxPQE5ePBuqVi5io+p9LrUtMQ3xgxK2jNpe9RhkylRI7
        TzJqk7qQw70b/Ck1Mi4oE5hCEw==
X-Google-Smtp-Source: APXvYqyw6zYGJ5SdG1gyLVimaSc5xLNuRAxlCrhe8n0P2ptykCR4qceOwKjApolyfrsXKv87bAanHg==
X-Received: by 2002:a17:906:948:: with SMTP id j8mr20805880ejd.240.1557736895160;
        Mon, 13 May 2019 01:41:35 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k57sm3588343ede.17.2019.05.13.01.41.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 01:41:34 -0700 (PDT)
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
To:     "Robert R. Howell" <RHowell@uwyo.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
 <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
 <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com>
 <0a770539-dfe9-2eb6-a90a-82f065a23a3f@uwyo.edu>
 <f6db39bc-b8d1-fda8-ad37-a8b050ef0027@redhat.com>
 <37aee883-1253-adad-82b4-4a578cc72825@uwyo.edu>
 <CAJZ5v0j9U20cFbRx6QKeQv6wyDg6nL71L0U_Rec5+W1JoD8-=w@mail.gmail.com>
 <144b56d4-54e6-bccd-4652-22303bcd9168@uwyo.edu>
 <CAJZ5v0jJEovXXiqs-tzPC7FsGjGL+qxfXCxbTrQZqAxSCv1oyQ@mail.gmail.com>
 <beab21cb-9f89-b934-e0a4-2fd85c69f4e6@uwyo.edu>
 <4fb5fc2e-e5af-6732-0228-8c73beed1afb@redhat.com>
 <c3dadc9d-bf3b-c992-f256-94a25fea570a@uwyo.edu>
 <1bb008bd-ae0d-d351-ef0c-303e23b0eca5@redhat.com>
 <cc1dacb5-ef0f-61c4-6187-99ee1da55d92@uwyo.edu>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8e5b82ce-4120-4d81-fd8c-26a16cfe3381@redhat.com>
Date:   Mon, 13 May 2019 10:41:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cc1dacb5-ef0f-61c4-6187-99ee1da55d92@uwyo.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Robert,

On 09-05-19 20:09, Robert R. Howell wrote:
> Hi Hans
> 
> On 5/9/19 2:50 AM, Hans de Goede wrote:
> 
>>
>> Hi,
>>
>> On 09-05-19 06:24, Robert R. Howell wrote:
>>> On 4/30/19 8:39 AM, Hans de Goede wrote:
>>>>
> 
>>>>
>>>> I've just tried to reproduce the "Error i2c_dw_xfer call while suspended" error
>>>> on suspend/resume on my own T100TA and I could not reproduce this.
>>>>
>>>> Can you try without the BT keyboard paired and waking up from suspend using the
>>>> tablet part's power-button ?
>>>>
>>>> Also do you still have the scripts to rmmod some modules before suspend ?
>>>>
>>>
>>> The T100TA keyboard is actually a hardwired connection rather than Bluetooth but I
>>> did physically disconnect the keyboard, and also unpaired all the actual Bluetooth
>>> devices (such as the mouse) and then powered down the T100TA bluetooth adapter.
>>> When I suspend, then resume using the tablet power button, I still get the
>>> i2c_dw_xfererror error during the resume.  But whatever causes this error isn't fatal,
>>> in the sense that after resume the sound and other i2c functions do still work OK.
>>>
>>> While I always get this i2c_dw_xfer error on resume from suspend or hibernation on the T100TA,
>>> I also have a T100TAM and curiously, it NEVER shows that error -- although all the
>>> other suspend and hibernate behavior seems similar.  I'm not sure if the following could
>>> be the difference, but the T100TA uses an i2c connected ATML1000 touchscreen controller
>>> while the T100TAM uses an i2c connected SIS0817 touchscreen controller.  Other than that
>>> the hardware seems almost identical.
>>
>> I've been testing on an actual T100TA, with the ATML1000 touchscreen controller.
>>
>> Maybe it is a difference in BIOS version, my T100TA is running the latest BIOS, what
>> is the output of:
>>
>> cat /sys/class/dmi/id/bios_version /sys/class/dmi/id/bios_date
>>
> On the T100TA which shows the i2c_dw_xfer error the above cat reports:
> T100TA.307
> 05/09/2014
> 
> while the T100TA which does NOT show the i2c_dw_xfer error reports:
> T100TAM.205
> 07/25/2014
>>
>> Also do you perhaps have a microsd card inserted?  (I'm trying to figure out the
>> different between our setups so that I can hopefully reproduce the issue myself).
>>
> I do have a microsd card inserted in both the T100TA and the T100TAM.

Ah, ok I already suspected that and I think that is the difference between our
2 setups. I will try to reproduce the suspend/resume problem again with a microsd
card inserted and mounted.

>>> Regarding scripts, while I do still need a systemd hibernate script which removes the
>>> brcmfmac and the hci_uart (bluetooth related) drivers, I've found that I no longer need
>>> any script for suspend.
>>
>> Ok, so you are not doing any rmmod-s on suspend, right?
>>
> Correct -- I am NOT using a script and am not doing any explicit rmmod's on suspend, just on hibernate.
>> Regards,
>>
>> Hans
> 
> All my previous tests were done using a 5.1.0-rc5, 5.1.0-rc3, or earlier kernel.
> But I just compiled the released 5.1.0 kernel and the behavior has changed for the T100TA,
> resulting in a different i2c error and a call trace.  (I still continue to NOT see any
> suspend/resume errors on the T100TAM.)

This is expected we changed / improved the code generating the:
"i2c_designware 80860F41:00: Transfer while suspended"

Warning to include a trace, so that we know which code initiated the transfer,
which, as more or less expected, is the ACPI subsystem, like some power_on (_PS0)
or off (_PS3) method.

> Note that for all the tests described in this message I'm applying your patch
> regarding .poweroff_noirq and .restore_noirq, and I'm applying my own patch removing the
> DPM_FLAG_SMART_SUSPEND flag.  I haven't yet tried to explore varying those patches
> for the 5.1.0 release as I did for the earlier rc's, as described in previous messages.

Hmm, for future testing please leave out the patch removing the DPM_FLAG_SMART_SUSPEND
flag. Usually when asking you to test something we assume you are using a pristine kernel.
What does that patch attempt to fix and what happens during suspend/resume without it ?

Regards,

Hans

