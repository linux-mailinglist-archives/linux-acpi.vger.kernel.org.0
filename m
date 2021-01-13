Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5A92F4D1E
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jan 2021 15:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbhAMObW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jan 2021 09:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbhAMObW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jan 2021 09:31:22 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37FFC061575;
        Wed, 13 Jan 2021 06:30:41 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id m13so2731443ljo.11;
        Wed, 13 Jan 2021 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NNbUko/sDEXjyFBm5d1k4QuQtucNQCWNpX1X2x6xYus=;
        b=MSVc5ob27+hb55/QE+dcgQpZj5gBv5tbCD54kU7H5/CcvZ0YbPBtWemLdZQQzF9ixo
         5hvrC/lyLpBsWX4T0SBZKlpG0de3FMhpSOmscGotJjpcxEroxXhqS5/koMP3VMKEoJ/l
         81qmRMXb+93bZqLl7AAtC3dtvcOkaoJQoKLE16RyNcDfkArnMvETX4JVVIktZqYMHm8g
         gJTpVfujyPfT2ePG2ZmJwahUr7u4c3mjVSmt+LEUZ6U7ZIVoTKzOdIzrcVfxVdvuPZJn
         kAT4+YH+eCQIZFLhXB+h4uzpi2VYXUtb7m0xZb9nDOrTf6lEmV5xPH0z3nUMt9tCmKTk
         0RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NNbUko/sDEXjyFBm5d1k4QuQtucNQCWNpX1X2x6xYus=;
        b=LmFrVc1gGLsfVh6sW0Jls90BQIIBZhGKE1PNOVP3xOElmqKb7IvBST0sN2zBeCm3An
         QNp6o66yTSMg8ROs/sBFgBjJBOwh/oNFLHrJ9ptg9x9MP05Rl+Xs5TZ1zm0AlrFejPSC
         zlBmKFGqxiAo/gRNhODETUAEzjuPeOqrDTXvIS7X6Ts/PVCnzxzLHf3hC3IOmQsTw82O
         9favCOyvVPp+uikDBWIqCbLRMIWGUzRSbwH35bL+dPShHiU1JL4TPCB9S/cctpW5xS10
         Gb8ktiRGcfBED3ga1GYnYMYL8nJJ186+gFIeKjevi3pu0PW6/mEsPJ/FW5dIf/2T0+3b
         iH0w==
X-Gm-Message-State: AOAM533XEGJvRzYnQopwCDtXO+PHNOeszoAY8lMoThf7IKL4zAmKg9BR
        Yz/wpY4RRA2oJfgj9ZDSKXo75SfX4RU=
X-Google-Smtp-Source: ABdhPJytoZuhQkqBalH1EpfzPPM96f7bc65eox1ZSt0tN8GtRnRTbDqY9/LhjpCKVs93L9kC9wC6pA==
X-Received: by 2002:a05:651c:1b2:: with SMTP id c18mr1054291ljn.385.1610548240016;
        Wed, 13 Jan 2021 06:30:40 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id p24sm230223lfh.70.2021.01.13.06.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 06:30:39 -0800 (PST)
Subject: Re: [PATCH] drivers: core: Detach device from power domain on
 shutdown
To:     Furquan Shaikh <furquan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20201201213019.1558738-1-furquan@google.com>
 <e77e0569-568a-f7fb-9f0d-e64943b467f0@gmail.com>
 <CAJZ5v0jhniqG43F6hCqXdxQiQZRc67GdkdP0BXcRut=P7k7BVQ@mail.gmail.com>
 <X/2fzghPXnuDNBPU@kroah.com>
 <CAEGmHFEpPTuRuWFt0ba022BmGfaDmSTAgEApW9EzAa5CitmtbA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b4a931cf-5974-64d0-fdf2-693e418f3110@gmail.com>
Date:   Wed, 13 Jan 2021 17:30:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <CAEGmHFEpPTuRuWFt0ba022BmGfaDmSTAgEApW9EzAa5CitmtbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

13.01.2021 04:22, Furquan Shaikh пишет:
> On Tue, Jan 12, 2021 at 5:09 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Tue, Jan 12, 2021 at 01:45:25PM +0100, Rafael J. Wysocki wrote:
>>> On Tue, Jan 12, 2021 at 10:55 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 02.12.2020 00:30, Furquan Shaikh пишет:
>>>>> When the system is powered off or rebooted, devices are not detached
>>>>> from their PM domain. This results in ACPI PM not being invoked and
>>>>> hence PowerResouce _OFF method not being invoked for any of the
>>>>> devices. Because the ACPI power resources are not turned off in case
>>>>> of poweroff and reboot, it violates the power sequencing requirements
>>>>> which impacts the reliability of the devices over the lifetime of the
>>>>> platform. This is currently observed on all Chromebooks using ACPI.
>>>>>
>>>>> In order to solve the above problem, this change detaches a device
>>>>> from its PM domain whenever it is shutdown. This action is basically
>>>>> analogous to ->remove() from driver model perspective. Detaching the
>>>>> device from its PM domain ensures that the ACPI PM gets a chance to
>>>>> turn off the power resources for the device thus complying with its
>>>>> power sequencing requirements.
>>>>>
>>>>> Signed-off-by: Furquan Shaikh <furquan@google.com>
>>>>> ---
>>>>>  drivers/base/core.c | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>>> index d661ada1518f..5823f1d719e1 100644
>>>>> --- a/drivers/base/core.c
>>>>> +++ b/drivers/base/core.c
>>>>> @@ -23,6 +23,7 @@
>>>>>  #include <linux/of_device.h>
>>>>>  #include <linux/genhd.h>
>>>>>  #include <linux/mutex.h>
>>>>> +#include <linux/pm_domain.h>
>>>>>  #include <linux/pm_runtime.h>
>>>>>  #include <linux/netdevice.h>
>>>>>  #include <linux/sched/signal.h>
>>>>> @@ -4057,6 +4058,8 @@ void device_shutdown(void)
>>>>>                       dev->driver->shutdown(dev);
>>>>>               }
>>>>>
>>>>> +             dev_pm_domain_detach(dev, true);
>>>>> +
>>>>>               device_unlock(dev);
>>>>>               if (parent)
>>>>>                       device_unlock(parent);
>>>>>
>>>>
>>>> This patch broke system shutdown on NVIDIA Tegra using today's
>>>> linux-next because power domain can't be turned off until device drivers
>>>> handed control over device resets to the power domain of Power
>>>> Management controller on Tegra. This patch introduced the wrong
>>>> behaviour, apparently it should be made specific to ACPI only.
>>>>
>>>> Please fix, thanks in advance.
> 
> Sorry about the breakage. I am working on an alternate solution that
> Rafael suggested.
> 
>>>
>>> OK, so Greg please drop it.
>>
>> Now reverted, thanks.
> 
> Thanks Greg!

Thank you all for addressing this problem!

