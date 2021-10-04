Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156C8421138
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Oct 2021 16:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhJDOTu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Oct 2021 10:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhJDOTu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Oct 2021 10:19:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCA1C061745;
        Mon,  4 Oct 2021 07:18:01 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id np13so1655011pjb.4;
        Mon, 04 Oct 2021 07:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XhLcgnlFNKlyJR9MTmklupgjoF5kbKoz/kInQ84HTXs=;
        b=Fs1UI1CpPVw7inXXU501Vaq/TeCyfeqK0LonfYOKtAghdqg+RZYaEPOvN9vAKzKnEy
         GjYvHFA5vwWP7yHlgunUiV41+pICZZLGBk+gS9Fi2sS3tCqMiVF/z+HuDVqw8ieUW3S+
         gxvd82tu0BXeo4oXvQEXsvwSGOWHZCZQl3WXIOZ1lrGs+f1FWBAiEDk70deE1l4rc49a
         4IO/TMjhzYkIV71W/rW71q+9YIHYnf+9D81uuhk+3sFJPAGHiZYs59OfsPkDGSWfI9ji
         7l/216bgfRN3PaR3/WMR3oNB2MPV+ROP2x17COtDe1hMdoeSJLvOhVwvjF2WMAguFVss
         b3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XhLcgnlFNKlyJR9MTmklupgjoF5kbKoz/kInQ84HTXs=;
        b=elzAHeL1ekd2KZB5XN8RD3q66sT0UlkUaqas3/zT8n4Py5aMn52GlTWLIf9UOLYvuY
         BW/ayM3cTLnZTicxxLhLyo6p+FENm/BICNjDabVmFOcZexn0WLmvOHVT5cnTikx4EC2s
         ZavQVgjudR4u8s6UcKhZIw6z3DeMIblAdI0Yst6GaIKwI0dUS50nMzLclQA0a/79dwJS
         Zhc+yxvzDtnESqEoS70qsvmJJ1iR/jSlEXHLVlOm8GgG6pTqi/ZfFixRnIenW6hwq/Gn
         low0YuF7iGn3fB82LnNfU414/emr5SAZNU5NjjcQ9y/A8eo20sNNcPVeZ9KIsa0zmRYZ
         ZlYQ==
X-Gm-Message-State: AOAM533kIuuPbkwXqo7cUWCGJYwiKAVkWIyVtAv32zcFOnD4L7arH7JS
        BhG9hTfJhiyM/LfF9dCEQZoHy9HcJgI=
X-Google-Smtp-Source: ABdhPJyDwJVx7cjmytFLVZ121ggnbRtGRq97X3WYUnPTo2SDF2Z/8s/aEIqr9CuxMnyBhPaEdP/sdA==
X-Received: by 2002:a17:90b:4ac1:: with SMTP id mh1mr37397140pjb.238.1633357080415;
        Mon, 04 Oct 2021 07:18:00 -0700 (PDT)
Received: from sol (106-69-170-56.dyn.iinet.net.au. [106.69.170.56])
        by smtp.gmail.com with ESMTPSA id p27sm14642027pfq.164.2021.10.04.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:17:59 -0700 (PDT)
Date:   Mon, 4 Oct 2021 22:17:54 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: linux 5.15-rc4: refcount underflow when unloading gpio-mockup
Message-ID: <20211004141754.GA3510607@sol>
References: <20211004093416.GA2513199@sol>
 <YVrM8VdLKZUt0i8R@kroah.com>
 <20211004121942.GA3343713@sol>
 <YVrz86m3+7wDSYlh@kuha.fi.intel.com>
 <20211004124701.GA3418302@sol>
 <YVr/t7AbmP/h08GX@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVr/t7AbmP/h08GX@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 04, 2021 at 04:20:55PM +0300, Heikki Krogerus wrote:
> On Mon, Oct 04, 2021 at 08:47:01PM +0800, Kent Gibson wrote:
> > On Mon, Oct 04, 2021 at 03:30:43PM +0300, Heikki Krogerus wrote:
> > > On Mon, Oct 04, 2021 at 08:19:42PM +0800, Kent Gibson wrote:
> > > > On Mon, Oct 04, 2021 at 11:44:17AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Mon, Oct 04, 2021 at 05:34:16PM +0800, Kent Gibson wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > I'm seeing a refcount underflow when I unload the gpio-mockup module on
> > > > > > Linux v5.15-rc4 (and going back to v5.15-rc1):
> > > > > > 
> > > > > > # modprobe gpio-mockup gpio_mockup_ranges=-1,4,-1,10
> > > > > > # rmmod gpio-mockup
> > > > > > ------------[ cut here ]------------
> > > > > > refcount_t: underflow; use-after-free.
> > > > > > WARNING: CPU: 0 PID: 103 at lib/refcount.c:28 refcount_warn_saturate+0xd1/0x120
> > > > > > Modules linked in: gpio_mockup(-)
> > > > > > CPU: 0 PID: 103 Comm: rmmod Not tainted 5.15.0-rc4 #1
> > > > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> > > > > > EIP: refcount_warn_saturate+0xd1/0x120
> > > > > > Code: e8 a2 b0 3b 00 0f 0b eb 83 80 3d db 2a 8c c1 00 0f 85 76 ff ff ff c7 04 24 88 85 78 c1 b1 01 88 0d db 2a 8c c1 e8 7d b0 3b 00 <0f> 0b e9 5b ff ff ff 80 3d d9 2a 8c c1 00 0f 85 4e ff ff ff c7 04
> > > > > > EAX: 00000026 EBX: c250b100 ECX: f5fe8c28 EDX: 00000000
> > > > > > ESI: c244860c EDI: c250b100 EBP: c245be84 ESP: c245be80
> > > > > > DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00000296
> > > > > > CR0: 80050033 CR2: b7e3c3e1 CR3: 024ba000 CR4: 00000690
> > > > > > Call Trace:
> > > > > >  kobject_put+0xdc/0xf0
> > > > > >  software_node_notify_remove+0xa8/0xc0
> > > > > >  device_del+0x15a/0x3e0
> > > > > >  ? kfree_const+0xf/0x30
> > > > > >  ? kobject_put+0xa6/0xf0
> > > > > >  ? module_remove_driver+0x73/0xa0
> > > > > >  platform_device_del.part.0+0xf/0x80
> > > > > >  platform_device_unregister+0x19/0x40
> > > > > >  gpio_mockup_unregister_pdevs+0x13/0x1b [gpio_mockup]
> > > > > >  gpio_mockup_exit+0x1c/0x68c [gpio_mockup]
> > > > > >  __ia32_sys_delete_module+0x137/0x1e0
> > > > > >  ? task_work_run+0x61/0x90
> > > > > >  ? exit_to_user_mode_prepare+0x1b5/0x1c0
> > > > > >  __do_fast_syscall_32+0x50/0xc0
> > > > > >  do_fast_syscall_32+0x32/0x70
> > > > > >  do_SYSENTER_32+0x15/0x20
> > > > > >  entry_SYSENTER_32+0x98/0xe7
> > > > > > EIP: 0xb7eda549
> > > > > > Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> > > > > > EAX: ffffffda EBX: 0045a19c ECX: 00000800 EDX: 0045a160
> > > > > > ESI: fffffffe EDI: 0045a160 EBP: bff19d08 ESP: bff19cc8
> > > > > > DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000202
> > > > > > ---[ end trace 3d71387f54bc2d06 ]---
> > > > > > 
> > > > > > I suspect this is related to the recent changes to swnode.c or
> > > > > > platform.c, as gpio-mockup hasn't changed, but haven't had the
> > > > > > chance to debug further.
> > > > > 
> > > > > Any chance you can run 'git bisect' for this?
> > > > > 
> > > > 
> > > > That results in:
> > > > 
> > > > bd1e336aa8535a99f339e2d66a611984262221ce is the first bad commit
> > > > commit bd1e336aa8535a99f339e2d66a611984262221ce
> > > > Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Date:   Tue Aug 17 13:24:49 2021 +0300
> > > > 
> > > >     driver core: platform: Remove platform_device_add_properties()
> > > 
> > > Can you test does this patch help:
> > > https://lore.kernel.org/all/20210930121246.22833-3-heikki.krogerus@linux.intel.com/
> > > 
> > 
> > You sure that is the patch you have in mind? It only removes dead code,
> > so I don't see how that would help.  And it isn't quite dead either -
> > drivers/pci/quirks.c is still using device_add_properties(), so it won't
> > build.
> 
> Right, so can you test with the whole series that patch is part of?
> 

Well, you could've said that to start with ;-).

> > Looking at the offending patch, it effectively replaces a call to
> > device_add_properties() with one to
> > device_create_managed_software_node(), and those two functions appear
> > quite different - at least at first glance.
> > Is that correct?
> 
> The only real difference between the two functions is that
> device_create_managed_software_node() marks the software node it
> creates (and it does it exactly the same way as
> device_add_properties()) as "managed" with a specific flag.
> 

Yeah, my bad - not sure what function I was looking at but it wasn't
device_create_managed_software_node().

> It means that when the device is removed, so is the software node.
> It happens when device_del() calls device_platform_notify_remove(),
> which then calls software_node_notify_remove().
> 
> The problem is that after doing that step, device_del() then calls
> device_remove_properties() unconditionally which also attempts to
> remove the software node. So you end up doing the same thing twice.
> 
> So the code in the patch that we're interested, and that I would like
> you to test, is this:
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 938cfcd1674eb..152a611a7e9ca 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3583,7 +3583,6 @@ void device_del(struct device *dev)
>         device_pm_remove(dev);
>         driver_deferred_probe_del(dev);
>         device_platform_notify_remove(dev);
> -       device_remove_properties(dev);
>         device_links_purge(dev);
>  
>         if (dev->bus)
> 

Makes sense.
Good news is the patch built.
Bad news is I still get the same result:

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 98 at lib/refcount.c:28 refcount_warn_saturate+0xf4/0x150
Modules linked in: gpio_mockup(-)
CPU: 0 PID: 98 Comm: rmmod Not tainted 5.15.0-rc4 #1
Hardware name: linux,dummy-virt (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0xf4/0x150
lr : refcount_warn_saturate+0xf4/0x150
sp : ffffffc010be3c50
x29: ffffffc010be3c50 x28: ffffff8001fa5780 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: ffffffc010a14518
x23: 0000000000000000 x22: ffffffc010a13798 x21: ffffffc010a7a480
x20: ffffff8002126c10 x19: ffffff8002146600 x18: fffffffffffe25f8
x17: 666f733d4d455453 x16: 5953425553003065 x15: ffffffc01098ac80
x14: fffffffffffc25f7 x13: 2e656572662d7265 x12: ffffffc01098acd0
x11: 0000000000000093 x10: 6e75203a745f746e x9 : 00000000ffffefff
x8 : ffffffc0109e2cd0 x7 : 0000000000017fe8 x6 : 0000000000000001
x5 : ffffff8007f8fa68 x4 : 0000000000000000 x3 : 0000000000000027
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff8001fa5780
Call trace:
 refcount_warn_saturate+0xf4/0x150
 kobject_put+0xf4/0x110
 software_node_notify_remove+0xc4/0xe0
 device_del+0x18c/0x430
 platform_device_del.part.0+0x1c/0x90
 platform_device_unregister+0x28/0x50
 gpio_mockup_unregister_pdevs+0x28/0x50 [gpio_mockup]
 gpio_mockup_exit+0x28/0x3c0 [gpio_mockup]
 __arm64_sys_delete_module+0x180/0x200
 invoke_syscall+0x54/0x130
 el0_svc_common.constprop.0+0x44/0xf0
 do_el0_svc+0x40/0xa0
 el0_svc+0x20/0x60
 el0t_64_sync_handler+0x1a4/0x1b0
 el0t_64_sync+0x1a0/0x1a4
---[ end trace 44421b7a22d450dd ]---


Cheers,
Kent.
