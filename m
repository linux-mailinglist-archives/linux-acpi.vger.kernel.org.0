Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C892E268CEB
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Sep 2020 16:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgINOId (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Sep 2020 10:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726402AbgINOIZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Sep 2020 10:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600092504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k0dgbRo+RDvZ3UA4+CQF8a3dBnr9tvYgpawTPvfNleQ=;
        b=IQ0pUea4D3EQ7FPKhlZ1GsrtH7mV+Mei3+2tc9qglswgYvRaEF3A/2w3ihCq0zlQRW9uSb
        ck1XAZ15WQBZnoeOr3B4JqvZpPsiO6C63SGOzbvG4umvFSILgxJlXWNoT2JSH52rmiXQ4e
        /W72BuOurxaYnk8g7xUH982x55JT5Es=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-tvMSyi3vN6KmW327AqBdDA-1; Mon, 14 Sep 2020 10:08:12 -0400
X-MC-Unique: tvMSyi3vN6KmW327AqBdDA-1
Received: by mail-wm1-f70.google.com with SMTP id q205so1598968wme.0
        for <linux-acpi@vger.kernel.org>; Mon, 14 Sep 2020 07:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k0dgbRo+RDvZ3UA4+CQF8a3dBnr9tvYgpawTPvfNleQ=;
        b=mKg0jn5x5MSddoKGASn/UwxTIjVU7u1fz+5vaGy58Zrl420v+MK7H8leFilmaxK16r
         B1L9+VO29XG7xy7kCtahrQnGHANyL2yt403kA6vBxKFW1oksdTXBfhPp18FyeIrXiaMv
         tc8KjMhPnLJpLFUXR6hVd6iMLmF43Fi+iyhICRfhuUvP+07rOWPHMWPrNS64LeJ9WznQ
         1eHzLkZMd6g6IFAyqynnSHbfhiPJ1/fKyE6j+lciUHeGH1AAOJDUyH95SEb5q3DjKGJ8
         qs41sI+VQHtTM1NAWU+FRbx39bJrmj6UCmmNifQHvpL2u8CCBB5B48YBLZy0YOIy0yP2
         4gNw==
X-Gm-Message-State: AOAM531h32AzKTEDi3yttoXJPlJKjAq2V2WNvfhxIf21F4UpemcHg3H0
        NkdrgMZ0xHLCcrHJJUFjIslPR85rGeY68e7BfrlUYlbF+u4/kSZ46vf99cQbuSiaS8nNOCQ9QWE
        Tn22NG/rxzb7LAFO9PeMJog==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr16116161wme.144.1600092490357;
        Mon, 14 Sep 2020 07:08:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ27kSa58tJiiyuMmAIiHYwij6veZwR4h++7Q0qwgfWPIXQ2wHhOeRx22P6H/r1LA7F616zw==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr16116137wme.144.1600092490142;
        Mon, 14 Sep 2020 07:08:10 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id i6sm22688978wra.1.2020.09.14.07.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 07:08:09 -0700 (PDT)
Subject: Re: [PATCH 0/1] Input: soc_button_array - Work around DSDTs which
 modify the irqflags
From:   Hans de Goede <hdegoede@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-input <linux-input@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20200906122016.4628-1-hdegoede@redhat.com>
 <20200914061246.GO1665100@dtor-ws>
 <61dfb476-2d55-116c-21d6-bf5972929cd3@redhat.com>
 <CAHp75VemDbswE9+yXMut1vbYvWwcTAd+b_Ry05_0QWbfnCSv9g@mail.gmail.com>
 <897df830-4806-0118-6a27-0025268da1f5@redhat.com>
Message-ID: <ead6b6f3-5fb7-d986-1bba-4f4a9350a369@redhat.com>
Date:   Mon, 14 Sep 2020 16:08:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <897df830-4806-0118-6a27-0025268da1f5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/14/20 3:52 PM, Hans de Goede wrote:
> Hi,
> 
> On 9/14/20 10:00 AM, Andy Shevchenko wrote:
>> On Mon, Sep 14, 2020 at 10:45 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>> On 9/14/20 8:12 AM, Dmitry Torokhov wrote:
>>>> On Sun, Sep 06, 2020 at 02:20:15PM +0200, Hans de Goede wrote:
>>
>> ...
>>
>>>>> The soc_button_array code really is x86 specific glue code to translate
>>>>> various incarnations of gpio-keys in ACPI tables to gpio_keys_platform_data.
>>>>> As such I wonder if it would not be better to move this driver to
>>>>> drivers/platform/x86?
>>
>> AFAIU the above is a justification why PDx86 suits better to host it.
> 
> Correct.
> 
>>>>> I seem to be doing most if not all of the recent work on soc_button_array,
>>>>> and soon I will be a co-maintainer of drivers/platform/x86. So having it
>>>>> there and adding me in MAINTAINERS as maintaining it seems to be best?
>>>>>
>>>>> If you want I can do a patch moving soc_button_array to drivers/platform/x86
>>>>> and then add the other 3 patches on top and then we can merge all of this
>>>>> through drivers/platform/x86?
>>>>
>>>> Sorry, misread this first time through, so already merged the 3 patches,
>>>> but I to not mind at all moving the driver to platform tree. If you send
>>>> me such a patch I will apply it.
>>>
>>> Ok.
>>>
>>> Andy are you ok with moving the driver to the pdx86 tree too?
>>
>> Taking into consideration the above, if I read it correctly, I agree.
>> Feel free to add my Ack.
> 
> Ok, since Dmitry's tree currently has some changes to soc_button_array.c,
> the plan is to merge the patch through Dmitry's tree.
> 
> I will prepare a patch with your Acked-by and submit it.

So to make sure that there won't be any merge issues,
I was comparing bases for
{drivers/input/misc,drivers/platform/x86}/{Makefile,Kconfig}
looking at the versions in:
https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/log/?h=next
http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/heads/for-next (which atm is just 5.9-rc1)

And the latter has a couple of commits to
drivers/platform/x86/Kconfig which the input tree is missing;
and these commits touch part of the file which moving the driver
over will also be touching.

Dmitry, it seems that your for next-tree is based on 5.7 + 2
large merges and as such does not have all the commits from
5.9-rc1 ?

Anyways this is not urgent, given the conflict I think it
might be best if I send out the patch after 5.10-rc1, using
5.10-rc1 as a base for it.

Regards,

Hans

