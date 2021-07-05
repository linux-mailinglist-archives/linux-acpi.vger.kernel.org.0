Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012FD3BBA11
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jul 2021 11:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhGEJW4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jul 2021 05:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230149AbhGEJWz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jul 2021 05:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625476819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0lz3RieLJjLUf10tEtD9yiSmkqARYt8ggAI0tyKUM4=;
        b=ZdVftZakQ976nouOiEmYY6mjoEtqyMgF/lrn7djKeGBO4GAvvnxgnPnXcvW+i0yV71uDUo
        h1yb26B2Nf6pK+vQT/gEPHL60QsJaUYznV1dcxpcoBOVK5STP8G0VyDW4IGWznXX/EmiIA
        A2l5la2Nb4AKAmz60jk5KnEGqYfuH6g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-OnO0uqdxOEiih6o1ko088g-1; Mon, 05 Jul 2021 05:20:17 -0400
X-MC-Unique: OnO0uqdxOEiih6o1ko088g-1
Received: by mail-ej1-f71.google.com with SMTP id jl8-20020a17090775c8b02904db50c87233so868795ejc.16
        for <linux-acpi@vger.kernel.org>; Mon, 05 Jul 2021 02:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f0lz3RieLJjLUf10tEtD9yiSmkqARYt8ggAI0tyKUM4=;
        b=jZyI+9WjDDgELdhu7vF2AFmC8TN8KktR1dOtdPKZ1Zv72V4LFR1QXvV+hPaGLQzEVm
         KGDPjGM+PBszoFkouGB3sJy6tIgeq1Hl0IZhgmf+d8XqRuDpOcMoyp68WAhKLWy63n5z
         IvVjo/14kOBVY4ftVTXLrCWsaBMfWmScmFv6gkI/dYQx9AX/5zGYRL0eDTOlt7S/gkO2
         eEzp2l5ZJVKeelIQf+KlFVmKRGttjqNhStnVoMeRc6I4g4u3BKY5ybDguupQicSd2pdf
         edRRWAOXpDn8HooLya6jHvlc6FroEDGQ6SZvwQQxYLZNgvrRkmOqPHDcc+Kju0YgWFyN
         nuHw==
X-Gm-Message-State: AOAM533uECFa/LgD9bmKf2YGRwyzSeO60YDr9cMekZMzG+0RWYab8qHe
        7PbE7OfibWMKi/wbzIF9XBGAbkQAk6TqGMjaSNjvgz41BacYUiYxchIVI/hvTNWus3Sk2wIkikw
        JXcHwebGXIykoBar1UJPNgA==
X-Received: by 2002:a05:6402:406:: with SMTP id q6mr14973287edv.149.1625476816764;
        Mon, 05 Jul 2021 02:20:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRIrLpOBWg9CufEFMBVSKlqHP18qCo1jp2WopWeg8K3/0JEEn3wJhuaXfPDBljETJjT9jH0Q==
X-Received: by 2002:a05:6402:406:: with SMTP id q6mr14973275edv.149.1625476816587;
        Mon, 05 Jul 2021 02:20:16 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g23sm4094254ejh.116.2021.07.05.02.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 02:20:16 -0700 (PDT)
Subject: Re: [GIT PULL] intel-gpio for 5.14-1
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux GPIO <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <YL43SrZ8N8H+ZHE9@black.fi.intel.com>
 <YMdw6WdEQdGATBNJ@smile.fi.intel.com>
 <CAMRc=MfphPFqCaBRG6jLUFUwOB3_HTA73WXoCBg5S9GagTDeaw@mail.gmail.com>
 <75eae548-fd62-1be6-498d-9664d9c7deab@redhat.com>
Message-ID: <cb18b7d2-8636-feed-e9f8-212ce7aa7eff@redhat.com>
Date:   Mon, 5 Jul 2021 11:20:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <75eae548-fd62-1be6-498d-9664d9c7deab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/5/21 11:16 AM, Hans de Goede wrote:
> Hi,
> 
> On 7/5/21 11:03 AM, Bartosz Golaszewski wrote:
>> On Mon, Jun 14, 2021 at 5:09 PM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>>
>>> On Mon, Jun 07, 2021 at 06:12:10PM +0300, Andy Shevchenko wrote:
>>>> Hi Linux GPIO and TWIMC maintainers,
>>>>
>>>> This is GPIO material for v5.14 cycle. It contains some stuff that other
>>>> subsystems may take due to dependencies. Consider this tag immutable.
>>>
>>> Bart, any comments on this? Can you, please, pull?
>>>
>>> --
>>> With Best Regards,
>>> Andy Shevchenko
>>>
>>>
>>
>> Hi Andy,
>>
>> I was looking for you PR for this cycle and couldn't find it in my
>> inbox. Somehow this went into spam. I'll make sure your email never
>> goes to spam again. Sorry. I'm seeing Hand pulled it, is that right?
>>
>> Hans: did you take the entire thing?
> 
> Andy send me a pull-req for the intel-gpio-v5.14-1 tag because that
> contained some dependencies for a new driver which I was merging into
> drivers/platform/x86.
> 
> Given the name of the tag (and the contents) I think it is the entire
> thing and not a topic branch with just the things which the driver needed,
> I assume the pull-req Andy send to you probably also was for that tag?
> 
> If that is right then this indeed has already landed in Linus' tree
> through the platform-drivers-x86 tree.

I just noticed that this email is part of the same thread as the
pull-req which I merged, IOW it is the same pull-req as which ended
up in your spam folder.

So yes I believe that I took the entire thing.

Regards,

Hans

