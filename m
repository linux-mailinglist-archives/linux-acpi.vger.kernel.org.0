Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E353BBA03
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jul 2021 11:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhGEJTL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jul 2021 05:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230194AbhGEJTL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jul 2021 05:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625476594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3l7ybNh+CY4L1y3oY2rb9YGWvvT90T1bWrK9MuHEA0=;
        b=HqkCXoH2i/9SRE+IKPcuNCYlvnTUl4q+K4gnNhSB3Xz//HRG8xrOdv8dy3aoeJWrexedqX
        lXhOYwA8oBFWQNs6namEN+MsOKRl9w7Hl5q2fpud9pGjLGIHaL/e3AxzSd05fhI/PxWGuc
        +8O8XKGro4Q1sk4YhgAQqGQLFO4OnSQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-mcpnPi5YNiOxAeiGdOF1jQ-1; Mon, 05 Jul 2021 05:16:33 -0400
X-MC-Unique: mcpnPi5YNiOxAeiGdOF1jQ-1
Received: by mail-ed1-f72.google.com with SMTP id i19-20020a05640200d3b02903948b71f25cso8752265edu.4
        for <linux-acpi@vger.kernel.org>; Mon, 05 Jul 2021 02:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v3l7ybNh+CY4L1y3oY2rb9YGWvvT90T1bWrK9MuHEA0=;
        b=GpVyk00Ji9mMrxniVeXMBeky9mnfbOcMCiNrQH6cx+rPe4+Ruc7qK3fZTKAmUvuUjG
         RnqRe3t2DwZif5RTmnUJJqlCCpeEt8lqIxVv4iFetXhpczrgwxfpXn+w1yOQ9iE+dRVA
         IYiLbax2X1k3SsDMULXeiw+HuRnbPKwQNDEYFs9SHwldZptat6NwtfBPjlp2TDHEHqdF
         wvq5QjFwsHuAYfCq/M10cFjGWPez3dR8tACtfzOvDluNotClK3CR6acj/W+5r/ZivzAZ
         kIwwEho42d+4ZbfwrQs47Ra4uyzCIfr9IxqL82pjThLOFB8G0Aa6fNiLdXf29bten3tQ
         iyeA==
X-Gm-Message-State: AOAM5326XsYREToiDGJqkTZlJIyHmELwL5lQb7YEwl+GWT3slke+Myz0
        ZeOtoLSF4msUKgCMaNPRSeK325x6TgFGXDihwVAw/s9N02gwvKa/jREg23gXhzvjYjSHiLpKhRO
        2QxldFKJJ2ApqRwRAFoFykg==
X-Received: by 2002:aa7:d982:: with SMTP id u2mr14811580eds.230.1625476592192;
        Mon, 05 Jul 2021 02:16:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHTh2B9xh4IrbW7NpuBQ4eOrTNtCRPDHgVuoMaKWCfPqgGp52IagJ3hbJlsZHQ+2Ka86osFw==
X-Received: by 2002:aa7:d982:: with SMTP id u2mr14811563eds.230.1625476592016;
        Mon, 05 Jul 2021 02:16:32 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d6sm5102423edp.59.2021.07.05.02.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 02:16:31 -0700 (PDT)
Subject: Re: [GIT PULL] intel-gpio for 5.14-1
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <75eae548-fd62-1be6-498d-9664d9c7deab@redhat.com>
Date:   Mon, 5 Jul 2021 11:16:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MfphPFqCaBRG6jLUFUwOB3_HTA73WXoCBg5S9GagTDeaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/5/21 11:03 AM, Bartosz Golaszewski wrote:
> On Mon, Jun 14, 2021 at 5:09 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Mon, Jun 07, 2021 at 06:12:10PM +0300, Andy Shevchenko wrote:
>>> Hi Linux GPIO and TWIMC maintainers,
>>>
>>> This is GPIO material for v5.14 cycle. It contains some stuff that other
>>> subsystems may take due to dependencies. Consider this tag immutable.
>>
>> Bart, any comments on this? Can you, please, pull?
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>>
> 
> Hi Andy,
> 
> I was looking for you PR for this cycle and couldn't find it in my
> inbox. Somehow this went into spam. I'll make sure your email never
> goes to spam again. Sorry. I'm seeing Hand pulled it, is that right?
> 
> Hans: did you take the entire thing?

Andy send me a pull-req for the intel-gpio-v5.14-1 tag because that
contained some dependencies for a new driver which I was merging into
drivers/platform/x86.

Given the name of the tag (and the contents) I think it is the entire
thing and not a topic branch with just the things which the driver needed,
I assume the pull-req Andy send to you probably also was for that tag?

If that is right then this indeed has already landed in Linus' tree
through the platform-drivers-x86 tree.

I specifically merged this:

"""
Tag: intel-gpio-v5.14-1
object 043d7f09bf614809c10c4acbf0695ef731958300
type commit
tag intel-gpio-v5.14-1
tagger Andy Shevchenko <andriy.shevchenko@linux.intel.com> 1623078244 +0300

intel-gpio for v5.14-1

* Export two functions from GPIO ACPI for wider use
* Clean up Whiskey Cove and Crystal Cove GPIO drivers

The following is an automated git shortlog grouped by driver:

crystalcove:
 -  remove platform_set_drvdata() + cleanup probe

gpiolib:
 -  acpi: Add acpi_gpio_get_io_resource()
 -  acpi: Introduce acpi_get_and_request_gpiod() helper

wcove:
 -  Split error handling for CTRL and IRQ registers
 -  Unify style of to_reg() with to_ireg()
 -  Use IRQ hardware number getter instead of direct access
-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEqaflIX74DDDzMJJtb7wzTHR8rCgFAmC+NWQACgkQb7wzTHR8
rCjp+Q//dLwxIG2YLA/A1vfEUz2qaCIel9r+VrJjljz4W5Y4GSzLTcAwlnuFLiwX
ggJjpgj37MYmu+6Y+Y6oHf1OLexeYraHtNqsKND5DJn2rSDGcH3wj0h3Sb4FCOrb
w0jOe2SSKc3iyM/W4e8AdvYgBj3gu0LsfV0vA0b2kAIv5tEi+iG7kt+8GCNH77gc
rk1VusvSb57YbYZHZ/yc6tsoJcl+O9zX/eErjAbNOOoeme3uHATRq97K4h9ZuUUM
lEV4KpHIQP4iSsAhMOIiwurTS1HhwR/hELopQbHj0xkMdVtizI5yF4nIeZGjoaIA
JEEuxwPEMRpXNmq8q0MVVSuWaqR3IH6o7knOVI5BSrJplFRrqSqslAop5CWmY4S4
waWaGOUGhBDUcs4KwxeP2kGlkl7MW3OWHIpEdqvRDYM3vp7xcQURuvtgoqdlQSAl
jfyhOpW6XwqnAQW1/6UAT8OIc16pFkaQ3L0IUE5V4as2d6edEIhfo+gb5nvnppYe
TzFLOmXKSB+NPz6zsEMFxdYPjmW5nJdMdmD3LG5uNItkm1+AjB3bz5dy85Mz5fzl
VF2xAeLoobQTeT+WZIakBs0NuB2BRkYbk70XKidlTEsGsbWK4G2zIk3sLnWxS1Ch
EkXaH4EzMkSBrk3YHbq+leVszeYKuN80NKcl7eoxN4td/iFT6BA=
=WHpx
-----END PGP SIGNATURE-----
"""

Regards,

Hans

