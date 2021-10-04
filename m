Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC9E420AC2
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Oct 2021 14:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhJDMVv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Oct 2021 08:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhJDMVv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Oct 2021 08:21:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56848C061745;
        Mon,  4 Oct 2021 05:20:02 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 187so9915684pfc.10;
        Mon, 04 Oct 2021 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZEO7nDdq5Uxy2uV/IXvZEkXOvYwiVs0jEw95KwUv6SY=;
        b=GyJ5juukWlYzDrN89CmRoU7xHEH3UIcQAwkVJLocP3WA2VX93z0gG2Tu+umrOxUFD2
         WoBfjlD6CveVh61dH29DS1mlhluSi7SWGQVJ58Tc2rd9S4rKN1ZOl8toaNAinZDZzJFE
         HnAOblQ9nJUksBqiGhDNZ5iO3Dz8f8jZNzycGtokdzvLkZFwUv08YWKf4cD8HMD0ui3I
         JOe/YtB5+9QX2yThdYD3je7H3AOebkQv04m3gurusLB/PyJAlPJklniqIukWisbPx6gn
         zoyB7YIQ7rNuYnCrYU+22Zp5QhPJ2z6CsG/Ol60znz+mAwrJFseE2z+Vz6zNNTYYzjOD
         PUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZEO7nDdq5Uxy2uV/IXvZEkXOvYwiVs0jEw95KwUv6SY=;
        b=nWc0adsWBQBVSWMIfIptMTuojSHIsd7a+57QSADbP/0r3j8wPEB/+94T/qvnjP3sPY
         gFJ0Zfx1IFhqeLxgT8Fuju898BhmjurznRRTeBLL/fUqAlXtpPJn8VykvvJu2X+puzpv
         jR+7jRh2+Lq+Nya0JoSuRC9w3xahO7ETwrEUZM+71k9mhrwAh+NHzuJIA0rMrHBp7tpT
         Y8JeRmjAWdij/9PuPHHKs8WLZ+J5E76VGyXa4CYZltTE8IgH1m5p387r5rxu9rQedjJc
         9+Vb7ufOYJGDyp+YwGpZRRDCZFD5A9noS2IcuhiMiWLvKI7nx9B8BeDZ2PAyeTQTYWnk
         9Egw==
X-Gm-Message-State: AOAM532/w6BA3LLJxGDthhWw3aUzGNPIzM7ViWQThpsKYWamy2nXgyec
        avgFQvgcAW77DX0IvVHc/NKZDwN0uNY=
X-Google-Smtp-Source: ABdhPJyk8lEyJIdsLTBBoiJ2fVVr8AVaW3mVvFKxPVvopLX2RrchJbV9L2/D6blvRXXdHt89UTK4HA==
X-Received: by 2002:aa7:8189:0:b0:44c:293a:31e4 with SMTP id g9-20020aa78189000000b0044c293a31e4mr12424881pfi.51.1633350001663;
        Mon, 04 Oct 2021 05:20:01 -0700 (PDT)
Received: from sol (106-69-170-56.dyn.iinet.net.au. [106.69.170.56])
        by smtp.gmail.com with ESMTPSA id 16sm6909136pfu.169.2021.10.04.05.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 05:19:52 -0700 (PDT)
Date:   Mon, 4 Oct 2021 20:19:42 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: linux 5.15-rc4: refcount underflow when unloading gpio-mockup
Message-ID: <20211004121942.GA3343713@sol>
References: <20211004093416.GA2513199@sol>
 <YVrM8VdLKZUt0i8R@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVrM8VdLKZUt0i8R@kroah.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 04, 2021 at 11:44:17AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 04, 2021 at 05:34:16PM +0800, Kent Gibson wrote:
> > Hi,
> > 
> > I'm seeing a refcount underflow when I unload the gpio-mockup module on
> > Linux v5.15-rc4 (and going back to v5.15-rc1):
> > 
> > # modprobe gpio-mockup gpio_mockup_ranges=-1,4,-1,10
> > # rmmod gpio-mockup
> > ------------[ cut here ]------------
> > refcount_t: underflow; use-after-free.
> > WARNING: CPU: 0 PID: 103 at lib/refcount.c:28 refcount_warn_saturate+0xd1/0x120
> > Modules linked in: gpio_mockup(-)
> > CPU: 0 PID: 103 Comm: rmmod Not tainted 5.15.0-rc4 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> > EIP: refcount_warn_saturate+0xd1/0x120
> > Code: e8 a2 b0 3b 00 0f 0b eb 83 80 3d db 2a 8c c1 00 0f 85 76 ff ff ff c7 04 24 88 85 78 c1 b1 01 88 0d db 2a 8c c1 e8 7d b0 3b 00 <0f> 0b e9 5b ff ff ff 80 3d d9 2a 8c c1 00 0f 85 4e ff ff ff c7 04
> > EAX: 00000026 EBX: c250b100 ECX: f5fe8c28 EDX: 00000000
> > ESI: c244860c EDI: c250b100 EBP: c245be84 ESP: c245be80
> > DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00000296
> > CR0: 80050033 CR2: b7e3c3e1 CR3: 024ba000 CR4: 00000690
> > Call Trace:
> >  kobject_put+0xdc/0xf0
> >  software_node_notify_remove+0xa8/0xc0
> >  device_del+0x15a/0x3e0
> >  ? kfree_const+0xf/0x30
> >  ? kobject_put+0xa6/0xf0
> >  ? module_remove_driver+0x73/0xa0
> >  platform_device_del.part.0+0xf/0x80
> >  platform_device_unregister+0x19/0x40
> >  gpio_mockup_unregister_pdevs+0x13/0x1b [gpio_mockup]
> >  gpio_mockup_exit+0x1c/0x68c [gpio_mockup]
> >  __ia32_sys_delete_module+0x137/0x1e0
> >  ? task_work_run+0x61/0x90
> >  ? exit_to_user_mode_prepare+0x1b5/0x1c0
> >  __do_fast_syscall_32+0x50/0xc0
> >  do_fast_syscall_32+0x32/0x70
> >  do_SYSENTER_32+0x15/0x20
> >  entry_SYSENTER_32+0x98/0xe7
> > EIP: 0xb7eda549
> > Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> > EAX: ffffffda EBX: 0045a19c ECX: 00000800 EDX: 0045a160
> > ESI: fffffffe EDI: 0045a160 EBP: bff19d08 ESP: bff19cc8
> > DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000202
> > ---[ end trace 3d71387f54bc2d06 ]---
> > 
> > I suspect this is related to the recent changes to swnode.c or
> > platform.c, as gpio-mockup hasn't changed, but haven't had the
> > chance to debug further.
> 
> Any chance you can run 'git bisect' for this?
> 

That results in:

bd1e336aa8535a99f339e2d66a611984262221ce is the first bad commit
commit bd1e336aa8535a99f339e2d66a611984262221ce
Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Tue Aug 17 13:24:49 2021 +0300

    driver core: platform: Remove platform_device_add_properties()

Cheers,
Kent.
