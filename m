Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6851A31BB77
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Feb 2021 15:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhBOOzD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 09:55:03 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46190 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhBOOy7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2021 09:54:59 -0500
Received: by mail-oi1-f177.google.com with SMTP id f3so7924716oiw.13;
        Mon, 15 Feb 2021 06:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JKsmQvDQuJ7SXoDUysYvZz5JWsAqxGnNy9od5oFkcQ=;
        b=OMMaX64o4mPp15u74VK9VLMzv/sWOMuUdKE390rlvLWsr1E5JNtvy1v48K4DlcO3zl
         xRbVV0nosf41KFBPaxpSI2bb/O+UEhEydpP7hyZfTSK7ITrZNMbZk+gnOqMk6oJJpNHl
         RIM0sfy3uYIGJrWgysYrA9KQRpa8MdlQKtMOAZ6oAbzmb7w3m5rfwjo0c2dIIx0dJagC
         kqPr45NCoemRMyrtoFy/ifR9Z1z85Vo4laDvwy2EWkbXdUMaVU3msZZSK2TGyr+2JsMP
         Ca+EZkBLGWdelHRtu2ppQOueHgehleNmxGxRKaF6ZWMoxsj1yxhAnFEB+gDFBnUlGCzy
         nqag==
X-Gm-Message-State: AOAM532SSmLStFb4E+2GGoYX6t7bNAJ9yTZ8yjEwLwbT0hDvslLVhmbB
        JHMBCBihOIYSSE/qUxIcEhHUyyCwwRwqWjHtxDk=
X-Google-Smtp-Source: ABdhPJz3NPKU0XxjlO97K+uOSpkRk9KXI05zuK6U5l7L2COytWxMtF1rAU//vQapJsGEIu2lu9WpFf7szKed1cuN/8Q=
X-Received: by 2002:a05:6808:5cf:: with SMTP id d15mr8192480oij.69.1613400858625;
 Mon, 15 Feb 2021 06:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20210211201703.658240-1-luzmaximilian@gmail.com> <898aa498-8256-d59f-9e72-0e1199b3a62a@redhat.com>
In-Reply-To: <898aa498-8256-d59f-9e72-0e1199b3a62a@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 Feb 2021 15:54:03 +0100
Message-ID: <CAJZ5v0jGUgHsNaqLarf=YLwjtOe-mQB48LkOQLi7FcZyW1Qchg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] platform/surface: Add platform profile driver for
 Surface devices
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <mgross@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 15, 2021 at 3:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/11/21 9:16 PM, Maximilian Luz wrote:
> > This series adds a driver to provide platform profile support on 5th-
> > and later generation Microsoft Surface devices with a Surface System
> > Aggregator Module. On those devices, the platform profile can be used to
> > influence cooling behavior and power consumption.
> >
> > To achieve this, a new platform profile is introduced: the
> > 'balanced-performance' profile.
> >
> > In addition, a couple of fix-ups are performed:
> > - Hide CONFIG_ACPI_PLATFORM_PROFILE and change drivers so that it is
> >   selected instead of depended on.
> > - Fix some references to documentation in a comment.
> >
> > Note: This series (or more specifically "platform/surface: Add platform
> > profile driver") depends on the "platform/surface: Add Surface
> > Aggregator device registry" series.
> >
> > Changes in v2:
> >  - Introduce new 'balanced-performance' platform profile and change
> >    profile mapping in driver.
> >  - Perform some fix-ups for the ACPI platform profile implementation:
> >    - Fix some references to documentation in a comment.
> >    - Hide CONFIG_ACPI_PLATFORM_PROFILE
>
> Thanks, the entire series looks good to me, so for the series:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Rafael, can you (once 5.12-rc1 is out) pick 1-3/4 and then provide a
> stable branch for me to merge?

Since [1-3/4] appear to be uncontroversial, so IMO it would be better
to merge them during the merge window, so they are present in
5.12-rc1.

The extra stable branch wouldn't be necessary in that case.

> Then I will pick up 4/4.
