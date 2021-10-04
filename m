Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D256342089A
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Oct 2021 11:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhJDJqI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Oct 2021 05:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231962AbhJDJqH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Oct 2021 05:46:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD5826124B;
        Mon,  4 Oct 2021 09:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633340659;
        bh=fk61M3UGDZbik4xQrIYyiZJxiHlmJ2ySY6kXmySER+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PurdbFyUtnGgzBveLRsgnFFgIpBtnBI5T/WPmlrsXHY53rvnRWZQG2D+wazrgGNOc
         18eaoPV5ppwkpI2LZz+KuwDkUzJ1fuHxKPmH7oD9+M/HGTqozUmFNAg5yrbxzj7FMP
         fuzOYJoEJ5bqggJHQTztq0XQCYub38yfgciglf1E=
Date:   Mon, 4 Oct 2021 11:44:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: linux 5.15-rc4: refcount underflow when unloading gpio-mockup
Message-ID: <YVrM8VdLKZUt0i8R@kroah.com>
References: <20211004093416.GA2513199@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004093416.GA2513199@sol>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 04, 2021 at 05:34:16PM +0800, Kent Gibson wrote:
> Hi,
> 
> I'm seeing a refcount underflow when I unload the gpio-mockup module on
> Linux v5.15-rc4 (and going back to v5.15-rc1):
> 
> # modprobe gpio-mockup gpio_mockup_ranges=-1,4,-1,10
> # rmmod gpio-mockup
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 0 PID: 103 at lib/refcount.c:28 refcount_warn_saturate+0xd1/0x120
> Modules linked in: gpio_mockup(-)
> CPU: 0 PID: 103 Comm: rmmod Not tainted 5.15.0-rc4 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> EIP: refcount_warn_saturate+0xd1/0x120
> Code: e8 a2 b0 3b 00 0f 0b eb 83 80 3d db 2a 8c c1 00 0f 85 76 ff ff ff c7 04 24 88 85 78 c1 b1 01 88 0d db 2a 8c c1 e8 7d b0 3b 00 <0f> 0b e9 5b ff ff ff 80 3d d9 2a 8c c1 00 0f 85 4e ff ff ff c7 04
> EAX: 00000026 EBX: c250b100 ECX: f5fe8c28 EDX: 00000000
> ESI: c244860c EDI: c250b100 EBP: c245be84 ESP: c245be80
> DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00000296
> CR0: 80050033 CR2: b7e3c3e1 CR3: 024ba000 CR4: 00000690
> Call Trace:
>  kobject_put+0xdc/0xf0
>  software_node_notify_remove+0xa8/0xc0
>  device_del+0x15a/0x3e0
>  ? kfree_const+0xf/0x30
>  ? kobject_put+0xa6/0xf0
>  ? module_remove_driver+0x73/0xa0
>  platform_device_del.part.0+0xf/0x80
>  platform_device_unregister+0x19/0x40
>  gpio_mockup_unregister_pdevs+0x13/0x1b [gpio_mockup]
>  gpio_mockup_exit+0x1c/0x68c [gpio_mockup]
>  __ia32_sys_delete_module+0x137/0x1e0
>  ? task_work_run+0x61/0x90
>  ? exit_to_user_mode_prepare+0x1b5/0x1c0
>  __do_fast_syscall_32+0x50/0xc0
>  do_fast_syscall_32+0x32/0x70
>  do_SYSENTER_32+0x15/0x20
>  entry_SYSENTER_32+0x98/0xe7
> EIP: 0xb7eda549
> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> EAX: ffffffda EBX: 0045a19c ECX: 00000800 EDX: 0045a160
> ESI: fffffffe EDI: 0045a160 EBP: bff19d08 ESP: bff19cc8
> DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000202
> ---[ end trace 3d71387f54bc2d06 ]---
> 
> I suspect this is related to the recent changes to swnode.c or
> platform.c, as gpio-mockup hasn't changed, but haven't had the
> chance to debug further.

Any chance you can run 'git bisect' for this?

thanks,

greg k-h
