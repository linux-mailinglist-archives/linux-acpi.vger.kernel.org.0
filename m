Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A3D268C9B
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Sep 2020 15:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgINNyt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Sep 2020 09:54:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28588 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgINNwW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Sep 2020 09:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600091529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Um8tCX9YwmvI/46vYWXlvrLavmk2Mm7vU3FQ5RmK4k=;
        b=S+2ej9R+emKFoGC+wfBcdU7LcfOsfk9m3E7ri6tGl+zocyB7o6aOGE4nzy1MGqLllwk8Xt
        D/Awaii3ovwosI5dVcMP+moSLkTSyXwGcaMi9Zhf/sPLGt9+8kLFc6j76hU9rnxSi9icj/
        ow+CH+4pLORvUhPqCNTk5RuHeqUIkHo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-GnGf1HZnOyqyb_bysvxVPA-1; Mon, 14 Sep 2020 09:52:07 -0400
X-MC-Unique: GnGf1HZnOyqyb_bysvxVPA-1
Received: by mail-wm1-f71.google.com with SMTP id l26so23530wmg.7
        for <linux-acpi@vger.kernel.org>; Mon, 14 Sep 2020 06:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Um8tCX9YwmvI/46vYWXlvrLavmk2Mm7vU3FQ5RmK4k=;
        b=bYSjOX6z6PwDWoZ1QiYPy+a5Q53myYti7o5AkXSFB7SIo9byhEaeAa9PCUqJNSUKtB
         N3y3v+Qv2IPsVTv9G/Cqvv4yOGD0I2fQFFJXE77RQTwihe/k1Qg/N2A4Fj0xX93CDVhQ
         zW6mEeSv2bzSCs0S1nQVo9DMBtrTSqJVaWF3MgA063FTvMtE+PlO1gP7WE/CxuvR9iz0
         +g0eAwlu3A/qnPsu14x8HjGj1FkLe9KBmc3ajXgUFHF8paJVFG1EQkLDq1nRyA6uKI/A
         Cc4MGy+88D47sUiVjY56/NwRARyOZrF159vQDcr6ugLE5q+HWcA5uu0StnPViSRt5W/f
         WT3Q==
X-Gm-Message-State: AOAM5319V1UqwDegjPuJG7TvZK9+NFFlpq7OYkt8yBY+lbRAE3TengQg
        PvHDJihKhn5uOlpqtdplnLSbXKJeIKAX3jUnbWrPyVDz9b5vfL88z8Mv9i3lBUwh93wpvB7VJDv
        9ieHJnveXYSkrFT2Lbqg5/A==
X-Received: by 2002:a1c:2543:: with SMTP id l64mr14427401wml.96.1600091526414;
        Mon, 14 Sep 2020 06:52:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt2FETo366O9EcczySLGiVdopF7Gk02mT+yreGZEBLgG14oYmnYiTX/HRz15WrDVmKYPNwWg==
X-Received: by 2002:a1c:2543:: with SMTP id l64mr14427382wml.96.1600091526173;
        Mon, 14 Sep 2020 06:52:06 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id m10sm18956882wmi.9.2020.09.14.06.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 06:52:05 -0700 (PDT)
Subject: Re: [PATCH 0/1] Input: soc_button_array - Work around DSDTs which
 modify the irqflags
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <897df830-4806-0118-6a27-0025268da1f5@redhat.com>
Date:   Mon, 14 Sep 2020 15:52:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VemDbswE9+yXMut1vbYvWwcTAd+b_Ry05_0QWbfnCSv9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/14/20 10:00 AM, Andy Shevchenko wrote:
> On Mon, Sep 14, 2020 at 10:45 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 9/14/20 8:12 AM, Dmitry Torokhov wrote:
>>> On Sun, Sep 06, 2020 at 02:20:15PM +0200, Hans de Goede wrote:
> 
> ...
> 
>>>> The soc_button_array code really is x86 specific glue code to translate
>>>> various incarnations of gpio-keys in ACPI tables to gpio_keys_platform_data.
>>>> As such I wonder if it would not be better to move this driver to
>>>> drivers/platform/x86?
> 
> AFAIU the above is a justification why PDx86 suits better to host it.

Correct.

>>>> I seem to be doing most if not all of the recent work on soc_button_array,
>>>> and soon I will be a co-maintainer of drivers/platform/x86. So having it
>>>> there and adding me in MAINTAINERS as maintaining it seems to be best?
>>>>
>>>> If you want I can do a patch moving soc_button_array to drivers/platform/x86
>>>> and then add the other 3 patches on top and then we can merge all of this
>>>> through drivers/platform/x86?
>>>
>>> Sorry, misread this first time through, so already merged the 3 patches,
>>> but I to not mind at all moving the driver to platform tree. If you send
>>> me such a patch I will apply it.
>>
>> Ok.
>>
>> Andy are you ok with moving the driver to the pdx86 tree too?
> 
> Taking into consideration the above, if I read it correctly, I agree.
> Feel free to add my Ack.

Ok, since Dmitry's tree currently has some changes to soc_button_array.c,
the plan is to merge the patch through Dmitry's tree.

I will prepare a patch with your Acked-by and submit it.

Regards,

Hans

