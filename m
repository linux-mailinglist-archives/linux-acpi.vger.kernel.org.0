Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 145421C6AF
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2019 12:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfENKLD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 May 2019 06:11:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45926 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfENKLD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 May 2019 06:11:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id g57so22036981edc.12
        for <linux-acpi@vger.kernel.org>; Tue, 14 May 2019 03:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3VpRLg8NJLZAav9EnwymaMY+zgZMT88zMFcqJQzQ/Ac=;
        b=UPRn76v0MoESs2/XX0UBV4Aqx8d6Vd/kM1/KLnMUl1MkFE8Rmc+sY4VEV4E97Ov+p7
         +Tzq3USh/0xlLRxFk1Bu0n1AtE5jfVL9iZFYDLHcmrgTjJVC18VJToRAnc9rmv1iaJyH
         ICWZr7h/5btbUr8rb4fZFNL+D1Jg1G7Lwwa1HLLzXyBTsmqD2K5CW54KC76IpBFakB2a
         b9OzCpVBLp9tGpzFBl5IpKRyOq5AA3hHcyApI4Cc9YcDv2LjATODplpl5syr6aOO4omE
         eLeWkHfFzGXDEfGrrdd1z4rw/WYwYln5v4xu6oa1oJKXEXQ30OCuVEou0CYr/sVmTpl2
         ENjA==
X-Gm-Message-State: APjAAAXPgfWM8Mk/Q97RWaxGromSeuvMQL191ZqK3sTBZekLbmJFuWLE
        /1FTPxcGDxel6tczEIEHYi4yYQ==
X-Google-Smtp-Source: APXvYqwQ1M7+2IwC8+Ag7mbbnIGtPsFvd3nhiw/xiOfmQHxosgmZdMvZUm2GMUBqbezTPHW76hO4HQ==
X-Received: by 2002:a17:906:6a50:: with SMTP id n16mr27031422ejs.119.1557828661574;
        Tue, 14 May 2019 03:11:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id k18sm4400849eda.92.2019.05.14.03.11.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 03:11:00 -0700 (PDT)
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
Message-ID: <0b3eaf00-1a28-441b-e1fd-dd57e118f7a3@redhat.com>
Date:   Tue, 14 May 2019 12:10:59 +0200
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

Hi,

On 5/9/19 8:09 PM, Robert R. Howell wrote:
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

My T100TA has version T100TA.314, date 08/13/2015

> while the T100TA which does NOT show the i2c_dw_xfer error reports:
> T100TAM.205
> 07/25/2014
>>
>> Also do you perhaps have a microsd card inserted?  (I'm trying to figure out the
>> different between our setups so that I can hopefully reproduce the issue myself).
>>
> I do have a microsd card inserted in both the T100TA and the T100TAM.

Ok, so I tried reproducing the suspend/resume problem on my T100TA with a microsd
inserted and mounted and I still cannot reproduce the problem. So either you are
hitting a BIOS bug which since has been fixed, or the suspend/resume
problem is caused by you removing the DPM_FLAG_SMART_SUSPEND flag.

Regards,

Hans

