Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D44A2D033F
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 12:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLFLOT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 06:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFLOT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2020 06:14:19 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348A3C0613D1;
        Sun,  6 Dec 2020 03:13:33 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id r5so10545788eda.12;
        Sun, 06 Dec 2020 03:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9HTJPOk5FFnITFxQbhJiTU6I1Zj3WLYNgZXDdRPdryA=;
        b=PJ2QHglr0MqNMizxQm8koFWwYdcL60uWNgewoGJG4uFAq2b4js0pumQKqI73tYVb4E
         JAkB7GTgzB8Jr4paScqHUmfdoBGHoPueNV2w1YFCqUjLpwKi2vOrSJpuxxCTFjiS7oLf
         T9F9KyZ9TISUMutlvj4cIoxCkc0Acqy8CmVd6tvAs+8xynPgLIGmPmSqUfUQpLMA+tFW
         g9WxMJwqkr1pIm25IYkfXwEDUnTe1IWD1yEf2+Yh53J78EILitf3KJJ2O2iQ26uiz8gy
         58wedCG7fkWWcIX2tkRtAdJMznoh9hJEo9AgdtZOqiJy2a0aL1DW38Gkc1eUOQfWcLFn
         iAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9HTJPOk5FFnITFxQbhJiTU6I1Zj3WLYNgZXDdRPdryA=;
        b=MPyrQr/ekeD02GtKJ9Ckj4JyliaGfw+cwdzSr7OzNcC7+pBg8hN/VF84vdVOc3hc1U
         BAMAoWLc9Tzw7aTpWP3tt+nOo9Mgt8XqIrLx6r0Dya8yPoroYcN9Qs5+KRfOxwisrUxV
         LC0C3Ufl6Q1DNQrDXpJgKP1TD9H/PjcEYgvRw4gnF746wGHU76RwCr/wTAVJD2UcEpLY
         ijQXbxyCWn2BO5i4aYlruZVpM2X9vQFY1rB8DisuMFCgSqrDpSE6gfBir5QoyOCS+RLc
         er+L8vhUU3KKtLAp9kQ1+YIgxoM1yo3q5E0TllbEIDsfyUPxAtCrfUJYEkU6lCnRPKh9
         SKsA==
X-Gm-Message-State: AOAM532yn0JcG9n+C0lTtFeFESbAn3YAgaHTf8o/fYx/YZFIHfi4/kQr
        o+DDPcuvTJgSeDiGY3Cu12VRZlDJf6c=
X-Google-Smtp-Source: ABdhPJyF5Z4ivrqQnR+Nr78T9Og8zPFulm/Qx2XIGgSU/PU2kSUVaonqCgoBVHiizscBE7UFfckIOw==
X-Received: by 2002:a50:cd57:: with SMTP id d23mr15407120edj.95.1607253211576;
        Sun, 06 Dec 2020 03:13:31 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a241.dip0.t-ipconnect.de. [217.229.162.65])
        by smtp.gmail.com with ESMTPSA id ck27sm7294098edb.13.2020.12.06.03.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 03:13:30 -0800 (PST)
Subject: Re: [PATCH v2 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201206070705.GA686270@unreal> <X8yXHvWcBFGu1PIo@kroah.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <f2e6f52a-86a2-8dc8-979c-135624b81214@gmail.com>
Date:   Sun, 6 Dec 2020 12:13:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <X8yXHvWcBFGu1PIo@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/6/20 9:32 AM, Greg Kroah-Hartman wrote:
> On Sun, Dec 06, 2020 at 09:07:05AM +0200, Leon Romanovsky wrote:
>> On Thu, Dec 03, 2020 at 10:26:31PM +0100, Maximilian Luz wrote:
>>> Hello,
>>>
>>> Here is version two of the Surface System Aggregator Module (SAM/SSAM)
>>> driver series, adding initial support for the embedded controller on 5th
>>> and later generation Microsoft Surface devices. Initial support includes
>>> the ACPI interface to the controller, via which battery and thermal
>>> information is provided on some of these devices.
>>>
>>> The previous version and cover letter detailing what this series is
>>> about can be found at
>>>
>>>    https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/
>>>
>>> This patch-set can also be found at the following repository and
>>> reference, if you prefer to look at a kernel tree instead of these
>>> emails:
>>>
>>>    https://github.com/linux-surface/kernel tags/s/surface-aggregator/v2
>>>
>>> Thank you all for the feedback to v1, I hope I have addressed all
>>> comments.
>>
>>
>> I think that it is too far fetched to attempt and expose UAPI headers
>> for some obscure char device that we are all know won't be around in
>> a couple of years from now due to the nature of how this embedded world
>> works.
> 
> No, that's not ok, we do this for loads of devices out there.  If there
> is a device that wants to be supported for Linux, and a developer that
> wants to support it, we will take it.
> 
>> More on that, the whole purpose of proposed interface is to debug and
>> not intended to be used by any user space code.
> 
> I thought that debugfs was going to be used for most of the debugging
> code, or has that changed in newer versions of this patchset?
As per previous discussion (https://lkml.org/lkml/2020/9/24/96) I have
replaced the debugfs device by a misc-device with stable interface.

I also believe that this is probably the better option long-term. The
general idea is to have a device that has direct access to the
EC/transport protocol and can be used for development and prototyping.
Debugging is a part of that. So it's more akin to something raw access
via i2cdev, hidraw, or raw access to USB devices as Hans de Goede
mentioned in one of his mails. Note that the module must still be loaded
manually

Regards,
Max
