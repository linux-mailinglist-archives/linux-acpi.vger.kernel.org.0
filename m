Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9840C2F7CDB
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 14:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbhAONiz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 08:38:55 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:38049 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731332AbhAONiz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jan 2021 08:38:55 -0500
Received: by mail-ot1-f54.google.com with SMTP id j20so8506677otq.5
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jan 2021 05:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LynRsSWol+ZlrySgZ9ToGMhmN8t6WL8YYePfDK8g68I=;
        b=BCSl9xhLlyJjSXTyyniAT8cUGI1C5Rv2HZdiHoz32TtfQpFrCXq7hwHk3puMWMQ/KC
         j7W1ncmJzxE07CqfZ1t9P7MEgSRGyUyQx2jy453RolmXJ+E9SQIjgRhE7QeSOB+iMib6
         38shfYkc5Qcqx6VQCzb7wvholXPZFRZQ22raO1J+NgyQ4SSwMEbz+ENusZyr0cRhfsRp
         loRBnJqjLhRXlbY/YyI2y0W/8DgtJKuYydvQLjWQ79j2bfTK1ng8Qa6lqiXmsWyBqjEo
         L4pTmgon+9Dn0D0/FsUvDZIxTlASmX0gNWTHsTJTayFDrC6hwymbgIPqF/mhFAPYifU6
         1J5Q==
X-Gm-Message-State: AOAM533RsQxY8cRLDgwgbC737OycuNNc+tDdRGLewK93iArgrMACwueU
        0O7pO47oPsKxhzH7zjILnXqv16q05+nII8n7S7s=
X-Google-Smtp-Source: ABdhPJy0OOREgs8+sUJ2/SRCYcoV6YyRL2J5Uf96BCDersttE9ho8AmQmMcb6TfLVGSGAQyEk3Kzc6ySdmttPcwTckA=
X-Received: by 2002:a9d:1710:: with SMTP id i16mr211625ota.260.1610717894583;
 Fri, 15 Jan 2021 05:38:14 -0800 (PST)
MIME-Version: 1.0
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
 <f5dae2aa-ffcb-1af1-726f-2362cb4fe470@redhat.com> <1bb7f766-4f29-55b1-882c-3d70cca0912f@linux.intel.com>
 <ce3ce3b6-c2d2-b0d0-56a6-941d3b607cb4@redhat.com>
In-Reply-To: <ce3ce3b6-c2d2-b0d0-56a6-941d3b607cb4@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jan 2021 14:38:03 +0100
Message-ID: <CAJZ5v0gmcvTAxj6VqyTS5grfibY9gYwko2uRQ_eV4c40tgUciA@mail.gmail.com>
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 15, 2021 at 9:56 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/15/21 1:49 AM, Pierre-Louis Bossart wrote:
> > Thanks Hans for your reply, much appreciated.
> >
> >> Pierre-Louis, can you see if the following hack helps? :
> >>
> >> --- a/drivers/acpi/scan.c
> >> +++ b/drivers/acpi/scan.c
> >> @@ -1939,7 +1939,6 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
> >>           /* Bail out if the number of recorded dependencies is not 0. */
> >>           if (count > 0) {
> >>               acpi_bus_scan_second_pass = true;

It would be good to add

+ acpi_handle_info(handle, "Enumeration deferred\n");

here on top of the previous debug changes so we know which device(s) to look at.

> >> -            return AE_CTRL_DEPTH;
> >>           }
> >>       }
> >>   @@ -1948,8 +1947,7 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
> >>           return AE_CTRL_DEPTH;
> >>         acpi_scan_init_hotplug(device);
> >> -    if (!check_dep)
> >> -        acpi_scan_dep_init(device);
> >> +    acpi_scan_dep_init(device);

I think that this change can be made without issues anyway.

AFAICS, this part of acpi_bus_check_add() will only be called once for
every given device anyway and initializing dep_unmet for the devices
for which acpi_scan_check_dep() above returns 0 shouldn't hurt.

> >>     out:
> >>       if (!*adev_p)
> >
> > Yep, those 'hacks' solve the boot problem on my device. I tried multiple times and it's completely reproducible.
>
> Ok, so this confirms my earlier findings (with my personal 5.10 + cherry pick tree)
> that the problem is not doing 2 scan "rounds" and thus calling e.g.
> acpi_bus_attach twice. But the problem is rather with deferring the device-creation
> of some devices to the second step.

That would be my expectation.
