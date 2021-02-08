Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F50D3143E5
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Feb 2021 00:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhBHXgR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 18:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhBHXgO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2021 18:36:14 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D505C061788
        for <linux-acpi@vger.kernel.org>; Mon,  8 Feb 2021 15:35:34 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id l8so3993298ybe.12
        for <linux-acpi@vger.kernel.org>; Mon, 08 Feb 2021 15:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+WfYcK1+ZV8R23zYWi1zlMlBGGvpKMkA8UnDsJm1Oc=;
        b=aq0w3Rjj+uR7KU5tlbnt8SRF9CFdEuy0AjgqgYqNKMir3fsFHUIThfxfnu6aqGB7eT
         vs+u57fNuc/O7ZRw5aKGWiem1cEzcuXK+XxIdxgfxTBXHmTIQp3KZHyvYv3tdTODaAav
         QoqPkDQGqZRxy0sKbdCT1rSSH9CVQWQGCrrH6bCFRUureuu+/e1sQxNUJJLoQ7V7oq1C
         /4WafwSXw2fU1fJ/QJAqBNP3vkfOAwZW/LHSpQi4qMfFU4IM0iQKD94nDyXeN9KFJ9pM
         RSovOiSyfkjD/d67bVKM0uYGDgggNUXN0564+kGokV4Qpic30xP48LDt4BmbI0KgTAsy
         trcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+WfYcK1+ZV8R23zYWi1zlMlBGGvpKMkA8UnDsJm1Oc=;
        b=chww8jQ60uGVWIVGQ7D3ppnnVFuWKJkPliWfdDAoQxd9GrVdwju7fu/uaWYVOiHRvD
         80uUvyN9RWAtSSNJDjMrGmSf9Lkh77HRdlROCO1n0bux4Ucws9uVYGKVCGN6Jy5+vObO
         UPasrBHoqBPrI2a1rF3nxA7gtF/wT/GEhaxzqg5iHml+8WeiGRYJl88MQapzT19Pnsk0
         I/msuC9UG7wB8IEDLMuVGdvLLzq9ANbRXRPTSuuqgwg9R/jYzscr58shvgS1TRywCVCn
         cNhC69WCF3tRz9EyJR0rqErTOxYf5uOAMeVBipF1CSJCP7EXN1WM5/ZasM1X5Ce8YmYd
         sf8Q==
X-Gm-Message-State: AOAM532HmJjlzb4vi3gJPJzDOvt3Imfw+1RS6jFRYVFLgSsm0/mRmUw+
        SS0+4bOXDaw5q/r8FYdsQRNVW5lOpK+0aa01Ra3Nuw==
X-Google-Smtp-Source: ABdhPJxvfXuvovy4qYPt4qo+kIvhWQQydMERIf2YxT9yDyTigYeTY9JT7AKMlyJ6w7jOmvoinijXVeHNTqdDkwzfQ44=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr2791520ybi.32.1612827333706;
 Mon, 08 Feb 2021 15:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <20210205222644.2357303-9-saravanak@google.com> <CAL_JsqJc8XRAL5Bj5LpH0M528K7ZL=wSqt8t=ibwjWutjCgB-Q@mail.gmail.com>
In-Reply-To: <CAL_JsqJc8XRAL5Bj5LpH0M528K7ZL=wSqt8t=ibwjWutjCgB-Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 8 Feb 2021 15:34:57 -0800
Message-ID: <CAGETcx9Ynzqx5vo+mqi9EGr+bVs8MBzO5sHhZiT+sB8Q_+7dPA@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] clk: Mark fwnodes when their clock provider is added/removed
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 8, 2021 at 7:39 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Feb 5, 2021 at 4:27 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > This allows fw_devlink to recognize clock provider drivers that don't
> > use the device-driver model to initialize the device. fw_devlink will
> > use this information to make sure consumers of such clock providers
> > aren't indefinitely blocked from probing, waiting for the power domain
> > device to appear and bind to a driver.
>
> Don't we have cases that are a mixture? IOW, a subset of the clock
> provider is initialized early, then the full driver takes over. You'd
> want consumers that are not a driver to succeed, but drivers to defer
> until the full driver is up.

You probably just made a typo, but to clarify, this is about ignoring
suppliers that never bind. So, in your case the clock device is the
supplier.

To answer your question, consumer devices added after the full
supplier driver takes over will still have device links created to the
supplier clock device. But consumers added before the full driver
takes over won't. So, nothing is worse off with fw_devlink=on and we
get way more dependency tracking (device links) created than what we
have today.

-Saravana
