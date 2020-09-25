Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74C2278B91
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 16:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgIYO6v (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 10:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbgIYO6t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 10:58:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9049DC0613CE;
        Fri, 25 Sep 2020 07:58:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so3426204pfp.11;
        Fri, 25 Sep 2020 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rwc/QyapswEQS+8sjmCFvdCCUajigTq8+2m0F7Eia9o=;
        b=OZ4qyVtAFHqmkFidhBwZQ+OyF8DGJiOyfkhenYpBOpk4ae5MR9ctmbSL/R0ZZPXSmb
         Xy0zLlaOLG5ZKjwxw8z4QBkVNy8Q1teqs7vStsvGzzR4eb94mKtviXQHM8Tx8BeCaueA
         7N1G1OUFArdGzTk8XEJN/lbFcejCIEhNim8c4rfMfG9oc87m7X2tVcjKPxPhbinnIPs4
         vlv3oMCmNwjkYUu0OI6Dy1FbtQShBQsUrSB/3m34o3KkpkgQdpS3smTg7q1HyilgDebQ
         xBdoGVDVz0DeBB3zhlnME+iXVH00nPXTcVkHfDFiRt08xXaO9VYIxnUvrz1lM8RjnBZ9
         uSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rwc/QyapswEQS+8sjmCFvdCCUajigTq8+2m0F7Eia9o=;
        b=QAU59Nk61nGvjhCurzUtp0mDWO5tpaccBSypN6ukEYx6WJu/xRTQbI0HKB3uoeyNMH
         uQClpukdDPAXKnpUrvjVTTAftVr/27njjeMwo24pOgB34EztnqEctsPgSqxb2asFsfC2
         N9Z69/VM8uhTogxKssczsoxN//fpG/jmxOyCUJGZS7fIkSb+uzScbU2zlEqtU1mzOLda
         wcOhtfOwZsqm9mggf06oT/mhTu/fV0/sX2dznWFsVMCJq2TkWf1IQhCzsfFUGEimjYWb
         Pjjk+QYvAvXM2J62imnh80ah4xUxExhKi8Y6Mdqb1gQ5mFOFhWJbb0hOIp+GQeh/7mYn
         zfPQ==
X-Gm-Message-State: AOAM533Bi8Osx75gVIp+WAhrdz/OU1A9Yw+rejdekU82vVtUQz5h/sZQ
        XC+AREmMcveI5l0lwRpY/eBuOSPJyhcfv2gz5cU=
X-Google-Smtp-Source: ABdhPJyVZF5qLQehqoGMQhSAwKdMOxNKBr4UiCXcMJJn/C5Izal8snLI+rO7UpcPE+ts5pi1F1zz8h+v0GQIY9eUKO0=
X-Received: by 2002:a63:d648:: with SMTP id d8mr412278pgj.4.1601045928817;
 Fri, 25 Sep 2020 07:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
 <CAHp75Vfp86h38Rd-VEgER7ASADdmz5ymAkuHvD0Q6WPDqZBqHw@mail.gmail.com> <95c2d02b-b8b1-59d9-1276-f2b1830fdac8@gmail.com>
In-Reply-To: <95c2d02b-b8b1-59d9-1276-f2b1830fdac8@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 25 Sep 2020 17:58:29 +0300
Message-ID: <CAHp75Vc6ohuT_Ga=p-n+gKaVhPWE2EEbkhx-EQO_vKEtgmswqA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 24, 2020 at 10:17 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> On 9/24/20 10:30 AM, Andy Shevchenko wrote:
> > On Wed, Sep 23, 2020 at 6:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Wed, Sep 23, 2020 at 5:15 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:

...

> >> I think this should go to drivers/platform/x86 or drivers/platform/surface/
> >> along with other laptop vendor specific code rather than drivers/misc/.
> >
> > +1 here. drivers/platform/surface is a good place to start.
> > And you may begin with moving a few Surface drivers out of PDx86 to
> > the new folder.
>
> Perfect, thanks! I'll draft up a patch series over the weekend.
>
> A couple questions regarding structure and maintenance:
>
>   - Should I CC the platform-driver-x86 list on future submissions to
>     drivers/platform/surface? I.e. is this something you would want to
>     review if it doesn't touch the drivers/platform/x86 directory?

Include PDx86 mailing list to the list of that. Current SURFACE*
drivers have per driver record in MAINTAINERS IIRC. So, update them as
well if needed.

>   - How would you want the layout to be, specifically regarding to the
>     surface-aggregator stuff? My suggestion would be simply:
>
>     drivers/platform/surface/

>         surface_aggregator/

Don't repeat parts of the path, the aggregator is enough as a folder
name, but the driver of course should be in its own namespace
('surface').

>             Kconfig
>             Makefile
>             core.c
>             controller.c
>             ... (all core stuff built into the surface_aggregator module)
>         Kconfig
>         Makefile

>         surface_aggregator_debugfs.c

(Not sure why it's not a part of aggregator folder)

>         surface_acpi_notify.c
>         surface_*.c        (any other surface platform driver as well
>                             as drivers dependent on surface_aggregator)
>
>   - Regarding future things like HID transport driver, battery/AC driver:
>     Submit them to drivers/platform/surface or to their respective
>     subsystem directories?

Respective subsystem _if_ it is a subsystem related driver and not
kinda board file. Use common sense and existing examples.

-- 
With Best Regards,
Andy Shevchenko
