Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619D7316FE4
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 20:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhBJTQV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 14:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbhBJTQM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 14:16:12 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E588C06178A
        for <linux-acpi@vger.kernel.org>; Wed, 10 Feb 2021 11:15:32 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id m188so2578475yba.13
        for <linux-acpi@vger.kernel.org>; Wed, 10 Feb 2021 11:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMm7LhCNfiXatte+J72259TBwE3qgGrJaSabgZ25gjg=;
        b=HRIiwWTs47Szc6oxYxnhSOiBHfT4UHEE38Ch+iU28KkeDshpiC1SepDhdslHI23tt3
         OS6PP06URj7B5CC3eUzROAwtGPBWwYlZObWB0SekS4wI484RrQtNhKydUqynhO0Q8Pyk
         qguBlQPU+LMbanRwX+gBvVJF+BhQCcYxMSwMCzRFIEXITAKkGL/LKRyfcgN2HYRlGkG0
         9Em0m0j6lShbUakz/6okuTXwmW2fb5MPmmWsxUn71aH5g/bQoczVbCIQxEdxfw7rHKoN
         TLKZpTEXoYkJo9BrpaUYxzaQJytCtOK/yU8wbQvE6Yx/wkzfdo1t+bWo+N2VU47k8h1/
         XX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMm7LhCNfiXatte+J72259TBwE3qgGrJaSabgZ25gjg=;
        b=n/lwuHOEa+TVBLN2x1+D6DQpPldwQK1/OEjrVsVjeL3EjjrKlU+JFRWIdZVJL76QzT
         emGry4J1S+qjrBZkwoIYx85DW0JeJ7S/Z/PlmY8bMbDgbJkAJ7t/jSh6mqA0mGg501gn
         b2M4/FWDCCH86kSnkVK2wnGh04626oUEzSsEE/mSUzK7TIJDl3S41HugNsSDKoq+ug0n
         ZUxnaQ2CjfjNoq0ZIV398C8mxA6nhSLcxad+8JA59yLZY3GZ6HIt2byy14kStwBg6bBz
         +4GuvIf+ZIFljDc/Ci9C5v8HTvl4Ur9LGT/UIRQX70EPMk+LAJwLslS+gYW9+9OiRXx8
         Xvlw==
X-Gm-Message-State: AOAM532NxuOxDUVPHNNkpjYaruG9kuOcT9K1/vPM79kmLaVOjxGCs/1R
        ek38TqcWCBDPHHjiuyYYeLJveke2qU5D4XgEhdw4ZA==
X-Google-Smtp-Source: ABdhPJxPLs/+QIJMt+wtIBzBZGrhURUX+xSgCx7EymGDDvrfSfAubD/1PiDbpILIMYyk25/SJ0qOy+BTaFfHFwoVjsg=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr6476503ybt.96.1612984531616;
 Wed, 10 Feb 2021 11:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <47ca46aa-99f3-5203-8aa7-65c6443bd965@microchip.com> <CAGETcx862JPn8759tk-69WySBvokxMXJaaOVY7L6V8FLwfpV8g@mail.gmail.com>
 <3ec7ba3a-bbf6-aa5f-7800-4fc91ab199ec@microchip.com>
In-Reply-To: <3ec7ba3a-bbf6-aa5f-7800-4fc91ab199ec@microchip.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 10 Feb 2021 11:14:55 -0800
Message-ID: <CAGETcx87RmBAhC2Kg0xP9oYGhGWXFWoTtshzuqT2=4_svm5s5A@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Brown, Len" <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 10, 2021 at 2:02 AM <Tudor.Ambarus@microchip.com> wrote:
>
> On 2/10/21 10:54 AM, Saravana Kannan wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On Wed, Feb 10, 2021 at 12:19 AM <Tudor.Ambarus@microchip.com> wrote:
> >>
> >> Hi, Saravana,
> >>
> >> On 2/6/21 12:26 AM, Saravana Kannan wrote:
> >>> There are a lot of devices/drivers where they never have a struct device
> >>> created for them or the driver initializes the hardware without ever
> >>> binding to the struct device.
> >>>
> >>> This series is intended to avoid any boot regressions due to such
> >>> devices/drivers when fw_devlink=on and also address the handling of
> >>> optional suppliers.
> >>>
> >>> Patch 1 and 2 addresses the issue of firmware nodes that look like
> >>> they'll have struct devices created for them, but will never actually
> >>> have struct devices added for them. For example, DT nodes with a
> >>> compatible property that don't have devices added for them.
> >>>
> >>> Patch 3 and 4 allow for handling optional DT bindings.
> >>>
> >>> Patch 5 sets up a generic API to handle drivers that never bind with
> >>> their devices.
> >>>
> >>> Patch 6 through 8 update different frameworks to use the new API.
> >>>
> >>> Thanks,
> >>> Saravana
> >>>
> >>> Saravana Kannan (8):
> >>>   driver core: fw_devlink: Detect supplier devices that will never be
> >>>     added
> >>>   of: property: Don't add links to absent suppliers
> >>>   driver core: Add fw_devlink.strict kernel param
> >>>   of: property: Add fw_devlink support for optional properties
> >>>   driver core: fw_devlink: Handle suppliers that don't use driver core
> >>>   irqdomain: Mark fwnodes when their irqdomain is added/removed
> >>>   PM: domains: Mark fwnodes when their powerdomain is added/removed
> >>>   clk: Mark fwnodes when their clock provider is added/removed
> >>>
> >>>  .../admin-guide/kernel-parameters.txt         |  5 ++
> >>>  drivers/base/core.c                           | 58 ++++++++++++++++++-
> >>>  drivers/base/power/domain.c                   |  2 +
> >>>  drivers/clk/clk.c                             |  3 +
> >>>  drivers/of/property.c                         | 16 +++--
> >>>  include/linux/fwnode.h                        | 20 ++++++-
> >>>  kernel/irq/irqdomain.c                        |  2 +
> >>>  7 files changed, 98 insertions(+), 8 deletions(-)
> >>>
> >>
> >> Even with this patch set applied, sama5d2_xplained can not boot.
> >> Patch at [1] makes sama5d2_xplained boot again. Stephen applied it
> >> to clk-next.
> >
> > I'm glad you won't actually have any boot issues in 5.12, but the fact
> > you need [1] with this series doesn't make a lot of sense to me
> > because:
> >
> > 1. The FWNODE_FLAG_INITIALIZED flag will be set for the clock fwnode
> > in question way before any consumer devices are added.
>
> Looks like in my case FWNODE_FLAG_INITIALIZED is not set, because
> drivers/clk/at91/sama5d2.c uses of_clk_add_hw_provider().

Ah, that explains it.

> > 2. Any consumer device added after (1) will stop trying to link to the
> > clock device.
> >
> > Are you somehow adding a consumer to the clock fwnode before (1)?
> >
> > Can you try this patch without your clk fix? I was trying to avoid
> > looping through a list, but looks like your case might somehow need
> > it?
> >
>
> I tried it, didn't solve my boot problem.

Thanks! I should stop coding past midnight!

> The following patch makes the
> sama5d2_xplained boot again, even without the patch from [1]:

Great! I gave a reviewed-by.

-Saravana
