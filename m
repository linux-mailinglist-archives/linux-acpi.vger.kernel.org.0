Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0874E34D2EB
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 16:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhC2O4P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 10:56:15 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:44656 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhC2O4L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2021 10:56:11 -0400
Received: by mail-oi1-f176.google.com with SMTP id a8so13300191oic.11
        for <linux-acpi@vger.kernel.org>; Mon, 29 Mar 2021 07:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+YLExpP4/+zIobSzTzQvC3+svRv8JeONZwBROeP1FA=;
        b=Fhzx+HJWqb6tkHlaNeM7RWScutKC+0Wyw6F6qQp5Cv4otvX+O85rWzBDpbGmViuLpu
         +zKFvDaZ3DjM+2FUD0uIZIXvi06aFlVdnLhF/3RVC+s5394jCiwFoo9P/l7NKjnkc5vS
         BjYBPc3xUv70tR6zQJ9f0XkuA5AIISB/76hspTkVCATOcdzlczSAcqBZdSOQ1lwgXvQ4
         ADSPmayF1yhXA6zj97//IjwvXls3g7/67Hi0bFYrCIQzZf39vwfDo7vuKK6buAu/Sl8u
         eM7AE3LXWnIji0GQ3qeCHqgpb/I/aGdPUtWjPCIvt6brJtO6h2nIC0J6aeqYyM+pmvno
         HOtQ==
X-Gm-Message-State: AOAM531Jtjz1ULcS+kDUSVWsZZ3ZJj+PAZ3Gzt5EqRRwkFrjbLh5/LRe
        NlICn75sM5TcC/vxZelfgSzS+iQqdNBcPpu9Aig=
X-Google-Smtp-Source: ABdhPJwi2kLsYokoOjTQGqB7Gb9HhcMNTsQCW5AamXZ2oJ6szujOj767Sj4ZCeuasrOWRm+3c41T03/ysUVhnaBuT+g=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr18071530oib.69.1617029771355;
 Mon, 29 Mar 2021 07:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210328112000.12502-1-hdegoede@redhat.com> <20210328112000.12502-2-hdegoede@redhat.com>
 <11743876.O9o76ZdvQC@kreacher> <299640b0-2448-3c46-a7b8-54d11d1d18c7@redhat.com>
In-Reply-To: <299640b0-2448-3c46-a7b8-54d11d1d18c7@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Mar 2021 16:56:00 +0200
Message-ID: <CAJZ5v0i7eLkW8ydn5qcqJaRLZ32mhsmP1=qvsNaFTsH_=36ZVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: scan: Fix _STA getting called on devices with
 unmet dependencies
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 29, 2021 at 4:46 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 3/29/21 3:39 PM, Rafael J. Wysocki wrote:
> > On Sunday, March 28, 2021 1:20:00 PM CEST Hans de Goede wrote:
> >> Commit 71da201f38df ("ACPI: scan: Defer enumeration of devices with
> >> _DEP lists") dropped the following 2 lines from acpi_init_device_object():
> >>
> >>      /* Assume there are unmet deps until acpi_device_dep_initialize() runs */
> >>      device->dep_unmet = 1;
> >>
> >> Leaving the initial value of dep_unmet at the 0 from the kzalloc(). This
> >> causes the acpi_bus_get_status() call in acpi_add_single_object() to
> >> actually call _STA, even though there maybe unmet deps, leading to errors
> >> like these:
> >>
> >> [    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
> >>                [GenericSerialBus] (20170831/evregion-166)
> >> [    0.123601] ACPI Error: Region GenericSerialBus (ID=9) has no handler
> >>                (20170831/exfldio-299)
> >> [    0.123618] ACPI Error: Method parse/execution failed
> >>                \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)
> >>
> >> Fix this by moving the acpi_scan_dep_init() call done for devices added
> >> during the second pass done by acpi_bus_scan() to inside
> >> acpi_add_single_object(), so that dep_unmet is properly initialized
> >> before the acpi_bus_get_status() call.
> >
> > I wonder why the change below can't be made instead.
> >
> > The behavior would be closer to the original then AFAICS.
>
> Right the behavior would be closer to the code before the 2 fase scan
> rework. But just actually making sure we have the right value in unmet_dep
> a tiny bit earlier seems cleaner to me.
>
> Note that the one acpi_add_single_object() call which actually sets the
> new init_dep parameter to true and the previous place of calling
> acpi_scan_dep_init() are very close together, here is the code before
> this patch:
>
>         acpi_add_single_object(&device, handle, type, sta, !check_dep);
>         if (!device)
>                 return AE_CTRL_DEPTH;
>
>         acpi_scan_init_hotplug(device);
>         if (!check_dep)
>                 acpi_scan_dep_init();
>
> So we are only doing the acpi_scan_dep_init() call a tiny bit earlier
> and wrt which locks are being held when it gets called no changes are
> made since it is still called as part of the call-graph below
> acpi_bus_check_add(), I explicitly checked the locking situation because
> that was my one worry with this patch.
>
> And this new approach also has the advantage of not setting dep_unmet=1
> (and never clearing it) for devices instantiated through:
>
> acpi_bus_register_early_device()
> acpi_bus_scan_fixed()
> acpi_add_power_resource()
>
> IOW while looking into fixing the regression of the errors being logged
> again I tried to do a cleaner fix then last time.
>
> With that said if you prefer the version you suggest let me know and I'll
> post a single v2 patch doing things that way.

I'd prefer to do the simple fix at this stage of the development
cycle, so yes, please.

I agree that it would be better to initialize dep_unmet properly in
acpi_add_single_object(), but I'd do that a bit differently.

> If you want to go with your suggestion, shall I then add a dep_unmet=0
> statement to the 3 mentioned functions which leave it at 1 when going back
> to the old way of handling this ?

No, I'll take care of this separately.

Cheers!
