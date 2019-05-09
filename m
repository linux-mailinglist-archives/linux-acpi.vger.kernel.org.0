Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A6818709
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2019 10:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfEIIuK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 May 2019 04:50:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37430 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfEIIuK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 May 2019 04:50:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id w37so1310402edw.4
        for <linux-acpi@vger.kernel.org>; Thu, 09 May 2019 01:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EynZfXFAHENXdId9UWac9+EIUrOg4ejj/igrSdFswKc=;
        b=IImJvuxJLPLJKueV0aldZ+XE151rkl7VoUPqZAfo7FhT8vMzC+YcWQrmOyN4zdDAYC
         itk5lNiVWsiz9y/QGgbFRymnjLGcs91BwWU7k42ePQ5HL5mkFwH6i+RYyUO5FkbNxi6k
         xGQ5tFo8LQDN6hsK95IqyWMVAVwDwje5u+DiFb5ohNiCNwzlIcvhlgxnyURZQ2vuTnez
         VMh1p+rXNyec3tsLLR24+b2LHEj2IRGXQM4bBQVII2Sq+MhlNQuIdxfcPITkBVazpMvB
         Yzw3pAdlo7j0Itta6nMvYjEu3OO9HOTPGt/8pc5mQFliW4PKzZk8r2qJFWOLiDqbkktg
         wVrA==
X-Gm-Message-State: APjAAAVH+m8NXv/aI7Eo4CySoYXiXcsK82rU3MJQM5ToAtWX72i6vDfK
        gsDQbX2eD4yI+JRwxSOwol16YQ==
X-Google-Smtp-Source: APXvYqxJCweJPm3K7QH4oNFZhIGlW7cFmH94xQ3KxQMen+5K38osOWjUA6HIbC4Ac4zrLxKxXbHbzw==
X-Received: by 2002:a17:906:2403:: with SMTP id z3mr2154692eja.278.1557391807921;
        Thu, 09 May 2019 01:50:07 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e35sm423143eda.2.2019.05.09.01.50.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 01:50:07 -0700 (PDT)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1bb008bd-ae0d-d351-ef0c-303e23b0eca5@redhat.com>
Date:   Thu, 9 May 2019 10:50:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c3dadc9d-bf3b-c992-f256-94a25fea570a@uwyo.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 09-05-19 06:24, Robert R. Howell wrote:
> On 4/30/19 8:39 AM, Hans de Goede wrote:
>>
>> Hi,
>>
>> On 4/25/19 6:38 PM, Robert R. Howell wrote:
>>> On 4/24/19 1:20 AM, Rafael J. Wysocki wrote:
>>>
>>>> On Tue, Apr 23, 2019 at 10:03 PM Robert R. Howell <RHowell@uwyo.edu> wrote:
>>>>>
>>>>> On 4/23/19 2:07 AM, Rafael J. Wysocki wrote:
>>>>>>
>>>>>> On Sat, Apr 20, 2019 at 12:44 AM Robert R. Howell <RHowell@uwyo.edu> wrote:
>>>>>>>
>>>>>>> On 4/18/19 5:42 AM, Hans de Goede wrote:
>>>>>>>
>>>>>>>>> On 4/8/19 2:16 AM, Hans de Goede wrote:>
>>>>>>>>>>
>>>>>>>>>> Hmm, interesting so you have hibernation working on a T100TA
>>>>>>>>>> (with 5.0 + 02e45646d53b reverted), right ?
>>>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I've managed to find a way around the i2c_designware timeout issues
>>>>>>> on the T100TA's.  The key is to NOT set DPM_FLAG_SMART_SUSPEND,
>>>>>>> which was added in the 02e45646d53b commit.
>>>>>>>
>>>>>>> To test that I've started with a 5.1-rc5 kernel, applied your recent patch
>>>>>>> to acpi_lpss.c, then apply the following patch of mine, removing
>>>>>>> DPM_FLAG_SMART_SUSPEND.  (For the T100 hardware I need to apply some
>>>>>>> other patches as well but those are not related to the i2c-designware or
>>>>>>> acpi issues addressed here.)
>>>>>>>
>>>>>>> On a resume from hibernation I still see one error:
>>>>>>>     "i2c_designware 80860F41:00: Error i2c_dw_xfer called while suspended"
>>>>>>> but I no longer get the i2c_designware timeouts, and audio does now work
>>>>>>> after the resume.
>>>>>>>
>>>>>>> Removing DPM_FLAG_SMART_SUSPEND may not be what you want for other
>>>>>>> hardware, but perhaps this will give you a clue as to what is going
>>>>>>> wrong with hibernate/resume on the T100TA's.
>>>>>>
>>>>>> What if you drop DPM_FLAG_LEAVE_SUSPENDED alone instead?
>>>>>>
>>>>>
>>>>> I did try dropping just DPM_FLAG_LEAVE_SUSPENDED, dropping just
>>>>> DPM_FLAG_SMART_SUSPEND, and dropping both flags.  When I just drop
>>>>> DPM_FLAG_LEAVE_SUSPENDED I still get the i2c_designware timeouts
>>>>> after the resume.  If I drop just DPM_FLAG_SMART_SUSPEND or drop both,
>>>>> then the timeouts go away.
>>>>
>>>> OK, thanks!
>>>>
>>>> Is non-hibernation system suspend affected too?
>>>
>>> I just ran some tests on a T100TA, using the 5.1-rc5 code with Hans' patch applied
>>> but without any changes to i2c-designware-platdrv.c, so the
>>> DPM_FLAG_SMART_PREPARE, DPM_FLAG_SMART_SUSPEND, and DPM_FLAG_LEAVE_SUSPENDED flags
>>> are all set.
>>>
>>> Suspend does work OK, and after resume I do NOT get any of the crippling
>>> i2c_designware timeout errors which cause sound to fail after hibernate.  I DO see one
>>>     "i2c_designware 80860F41:00: Error i2c_dw_xfer call while suspended"
>>> error on resume, just as I do on hibernate.  I've attached a portion of dmesg below.
>>> The "asus_wmi:  Unknown key 79 pressed" error is a glitch which occurs
>>> intermittently on these machines, but doesn't seem related to the other issues.
>>> I had one test run when it was absent but the rest of the messages were the
>>> same -- but then kept getting that unknown key error on all my later tries.
>>
>> I've just tried to reproduce the "Error i2c_dw_xfer call while suspended" error
>> on suspend/resume on my own T100TA and I could not reproduce this.
>>
>> Can you try without the BT keyboard paired and waking up from suspend using the
>> tablet part's power-button ?
>>
>> Also do you still have the scripts to rmmod some modules before suspend ?
>>
> 
> The T100TA keyboard is actually a hardwired connection rather than Bluetooth but I
> did physically disconnect the keyboard, and also unpaired all the actual Bluetooth
> devices (such as the mouse) and then powered down the T100TA bluetooth adapter.
> When I suspend, then resume using the tablet power button, I still get the
> i2c_dw_xfererror error during the resume.  But whatever causes this error isn't fatal,
> in the sense that after resume the sound and other i2c functions do still work OK.
> 
> While I always get this i2c_dw_xfer error on resume from suspend or hibernation on the T100TA,
> I also have a T100TAM and curiously, it NEVER shows that error -- although all the
> other suspend and hibernate behavior seems similar.  I'm not sure if the following could
> be the difference, but the T100TA uses an i2c connected ATML1000 touchscreen controller
> while the T100TAM uses an i2c connected SIS0817 touchscreen controller.  Other than that
> the hardware seems almost identical.

I've been testing on an actual T100TA, with the ATML1000 touchscreen controller.

Maybe it is a difference in BIOS version, my T100TA is running the latest BIOS, what
is the output of:

cat /sys/class/dmi/id/bios_version /sys/class/dmi/id/bios_date

?

Also do you perhaps have a microsd card inserted?  (I'm trying to figure out the
different between our setups so that I can hopefully reproduce the issue myself).


> Regarding scripts, while I do still need a systemd hibernate script which removes the
> brcmfmac and the hci_uart (bluetooth related) drivers, I've found that I no longer need
> any script for suspend.

Ok, so you are not doing any rmmod-s on suspend, right?

Regards,

Hans
