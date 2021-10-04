Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C2E420B22
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Oct 2021 14:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhJDMs7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Oct 2021 08:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhJDMs6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Oct 2021 08:48:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED55C061745;
        Mon,  4 Oct 2021 05:47:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j15so11015681plh.7;
        Mon, 04 Oct 2021 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NAApgs3b3FgjGcECZteM0Q3m7OPd4W620zPewNsZRpg=;
        b=IW6a1nOd+/UFx2OKCbqz97Yx3+tmF/Q/G/kV4cfozwG/a8ktf+phov58T33e9LZ9yY
         vwNUDIm/dRypF63ppDd0eIZqPNp0b7XWjzCQsNzeKIy9mVe0SuoN09FkubMn8SIo3skV
         PtkW3lveiwE7c6lIKEpJQY+ZCCUZJ8wcGldrVMPzRZEoFLZrg9l8itXo+TCWiM4TUzba
         Q+FbCoaSVHrgTCnagPEOZaytFYxdkU8zmi5+HiXxE6D+w4WddvAvChxH5r6wh2x5p2Si
         K6NXbYnJuw3fTJ+1dDGWMhety/iNnR420/gPlalybmbVxsQasAunTKjruapd5u4TtyFw
         9c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NAApgs3b3FgjGcECZteM0Q3m7OPd4W620zPewNsZRpg=;
        b=DlEF5PqPPebL/dFW3HB32Ne+zjkfT/DiXZdK4LOgHDuWzCswtvrOo81pgxQp0MHEKB
         lv+FVd2JOPMm2WzGYHdtBhJ+U7OfriSJOHS/a6b16bH4c7U2SUqdwfJLu0AhLRRG29O/
         PI1oJEHYCLXendP319CHqjF0wSZ8yTtd5iS2hEA1n3xk02b6rBZS1s4erpmdSx4Ogklc
         fpEnLCPdj8+ztVzUp6uC5Yw/XfZQ7cO2bJo7CY/MtNeehQXdm7JjiDPXetNrPvPfWn0B
         bhAi6VwdoGieWXLecsR70TekXsMFwv+Im/i+GTMG0EgijOmStCb9OCF5xuwU4uYbDdxK
         ppiw==
X-Gm-Message-State: AOAM5325Vc9ZjQRZqndq1lTuIpjqKQLkgR7D96tHKGlTH3P9AzEvqUmQ
        rVfGsp0o+KDEgipoho7ibZY=
X-Google-Smtp-Source: ABdhPJyx7im9B7Z6MlFKieGQU7iK3CipCugSWxiToUho8xMevBisCqkdP3KczkZzdx7oN2dT8qLBUg==
X-Received: by 2002:a17:90b:1d0a:: with SMTP id on10mr8174336pjb.218.1633351628593;
        Mon, 04 Oct 2021 05:47:08 -0700 (PDT)
Received: from sol (106-69-170-56.dyn.iinet.net.au. [106.69.170.56])
        by smtp.gmail.com with ESMTPSA id o14sm14593689pfh.145.2021.10.04.05.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 05:47:07 -0700 (PDT)
Date:   Mon, 4 Oct 2021 20:47:01 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: linux 5.15-rc4: refcount underflow when unloading gpio-mockup
Message-ID: <20211004124701.GA3418302@sol>
References: <20211004093416.GA2513199@sol>
 <YVrM8VdLKZUt0i8R@kroah.com>
 <20211004121942.GA3343713@sol>
 <YVrz86m3+7wDSYlh@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVrz86m3+7wDSYlh@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 04, 2021 at 03:30:43PM +0300, Heikki Krogerus wrote:
> On Mon, Oct 04, 2021 at 08:19:42PM +0800, Kent Gibson wrote:
> > On Mon, Oct 04, 2021 at 11:44:17AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Oct 04, 2021 at 05:34:16PM +0800, Kent Gibson wrote:
> > > > Hi,
> > > > 
> > > > I'm seeing a refcount underflow when I unload the gpio-mockup module on
> > > > Linux v5.15-rc4 (and going back to v5.15-rc1):
> > > > 
> > > > # modprobe gpio-mockup gpio_mockup_ranges=-1,4,-1,10
> > > > # rmmod gpio-mockup
> > > > ------------[ cut here ]------------
> > > > refcount_t: underflow; use-after-free.
> > > > WARNING: CPU: 0 PID: 103 at lib/refcount.c:28 refcount_warn_saturate+0xd1/0x120
> > > > Modules linked in: gpio_mockup(-)
> > > > CPU: 0 PID: 103 Comm: rmmod Not tainted 5.15.0-rc4 #1
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> > > > EIP: refcount_warn_saturate+0xd1/0x120
> > > > Code: e8 a2 b0 3b 00 0f 0b eb 83 80 3d db 2a 8c c1 00 0f 85 76 ff ff ff c7 04 24 88 85 78 c1 b1 01 88 0d db 2a 8c c1 e8 7d b0 3b 00 <0f> 0b e9 5b ff ff ff 80 3d d9 2a 8c c1 00 0f 85 4e ff ff ff c7 04
> > > > EAX: 00000026 EBX: c250b100 ECX: f5fe8c28 EDX: 00000000
> > > > ESI: c244860c EDI: c250b100 EBP: c245be84 ESP: c245be80
> > > > DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00000296
> > > > CR0: 80050033 CR2: b7e3c3e1 CR3: 024ba000 CR4: 00000690
> > > > Call Trace:
> > > >  kobject_put+0xdc/0xf0
> > > >  software_node_notify_remove+0xa8/0xc0
> > > >  device_del+0x15a/0x3e0
> > > >  ? kfree_const+0xf/0x30
> > > >  ? kobject_put+0xa6/0xf0
> > > >  ? module_remove_driver+0x73/0xa0
> > > >  platform_device_del.part.0+0xf/0x80
> > > >  platform_device_unregister+0x19/0x40
> > > >  gpio_mockup_unregister_pdevs+0x13/0x1b [gpio_mockup]
> > > >  gpio_mockup_exit+0x1c/0x68c [gpio_mockup]
> > > >  __ia32_sys_delete_module+0x137/0x1e0
> > > >  ? task_work_run+0x61/0x90
> > > >  ? exit_to_user_mode_prepare+0x1b5/0x1c0
> > > >  __do_fast_syscall_32+0x50/0xc0
> > > >  do_fast_syscall_32+0x32/0x70
> > > >  do_SYSENTER_32+0x15/0x20
> > > >  entry_SYSENTER_32+0x98/0xe7
> > > > EIP: 0xb7eda549
> > > > Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> > > > EAX: ffffffda EBX: 0045a19c ECX: 00000800 EDX: 0045a160
> > > > ESI: fffffffe EDI: 0045a160 EBP: bff19d08 ESP: bff19cc8
> > > > DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000202
> > > > ---[ end trace 3d71387f54bc2d06 ]---
> > > > 
> > > > I suspect this is related to the recent changes to swnode.c or
> > > > platform.c, as gpio-mockup hasn't changed, but haven't had the
> > > > chance to debug further.
> > > 
> > > Any chance you can run 'git bisect' for this?
> > > 
> > 
> > That results in:
> > 
> > bd1e336aa8535a99f339e2d66a611984262221ce is the first bad commit
> > commit bd1e336aa8535a99f339e2d66a611984262221ce
> > Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Date:   Tue Aug 17 13:24:49 2021 +0300
> > 
> >     driver core: platform: Remove platform_device_add_properties()
> 
> Can you test does this patch help:
> https://lore.kernel.org/all/20210930121246.22833-3-heikki.krogerus@linux.intel.com/
> 

You sure that is the patch you have in mind? It only removes dead code,
so I don't see how that would help.  And it isn't quite dead either -
drivers/pci/quirks.c is still using device_add_properties(), so it won't
build.

Looking at the offending patch, it effectively replaces a call to
device_add_properties() with one to
device_create_managed_software_node(), and those two functions appear
quite different - at least at first glance.
Is that correct?

Cheers,
Kent.
