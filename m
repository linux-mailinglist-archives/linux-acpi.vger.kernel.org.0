Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A368F420859
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Oct 2021 11:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhJDJgN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Oct 2021 05:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhJDJgM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Oct 2021 05:36:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF9CC061745;
        Mon,  4 Oct 2021 02:34:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v11so3362769pgb.8;
        Mon, 04 Oct 2021 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dJQWn2Sif2VCs7bc9fSojLnxy+HpF5qOK5tsXATQ6mE=;
        b=Ihuv/5aR8UBlWzjCeRAUDxXhK+LkTNza8BrE/GSAeS0X2LXl/VeoA+BMEQHmlrcX7G
         3PPSGTqP/Uw9FjOUQIuEteE1Gt/e896IRxN7KwkV7IYxEEAp1Gk/Uy1f3OsjhVzKUEbV
         f55JrNJD8XLERsrjD/LNDRRGGe1uHdRirE7j1Sf4uvIfjWOvk8Qpac7HdQ6pQHhYNJiu
         pg+gUQyZ5ID3w7RmcOZoZMn5GTkmsPfN492Yq869VEvklkushQOVBCVy370Ll/31f6Ep
         0vrZnIJlFAgNrxeyIGBEnN1u/pJ4piLb97xlH4rCSg23wzPQ7LQA1KJUAdSlP7flul5F
         W2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dJQWn2Sif2VCs7bc9fSojLnxy+HpF5qOK5tsXATQ6mE=;
        b=DliqU0s+zQW9qQIiHEdMjM/0+GNgeVAtLAkcJvns7me4OtxPfGRvduM+9Hql5FUexc
         d69J5Uo/Zn0VC3p8liLFYogGzSg7Lh+LRil8mrgno8e9+mvLtxnI1j4wb4/PrB5WXX0V
         z2om3WEDqJbQgdTtsWxpQZRMHbCIFOWT4tYWFzU40JQsAns0XA8Dp4LxnRzzWiwrwIg4
         0rRwxF/T/eijg3DkymvECBEK8SRsrqCiDCiqSic3jECFk8YOKceVkDTu/FH4AVZLpyAU
         UjXuNtZc0BGSRdczteXW8v78x8AmKKNuWBt7nv6hmgS4fR7P4GWcPxACchkkr4xB2HlF
         hQYA==
X-Gm-Message-State: AOAM533FDznqbiZhcTQG4SUq2EXOwRn6mwnAfq6AtoIdVwKIXiJIFRcE
        5O+Mj7SUVPOGPTCDKkKl8KNffhhv5WA=
X-Google-Smtp-Source: ABdhPJxpNBo9hS5TRJpWRSjoFeXpAMKnaUdujVNM36//c6ofLI2PT0MKgjn/1DdOwCVPdoKK+wCbgw==
X-Received: by 2002:a63:131f:: with SMTP id i31mr10077531pgl.207.1633340063688;
        Mon, 04 Oct 2021 02:34:23 -0700 (PDT)
Received: from sol (106-69-170-56.dyn.iinet.net.au. [106.69.170.56])
        by smtp.gmail.com with ESMTPSA id v26sm14010911pfm.175.2021.10.04.02.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 02:34:22 -0700 (PDT)
Date:   Mon, 4 Oct 2021 17:34:16 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>
Subject: linux 5.15-rc4: refcount underflow when unloading gpio-mockup
Message-ID: <20211004093416.GA2513199@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

I'm seeing a refcount underflow when I unload the gpio-mockup module on
Linux v5.15-rc4 (and going back to v5.15-rc1):

# modprobe gpio-mockup gpio_mockup_ranges=-1,4,-1,10
# rmmod gpio-mockup
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 103 at lib/refcount.c:28 refcount_warn_saturate+0xd1/0x120
Modules linked in: gpio_mockup(-)
CPU: 0 PID: 103 Comm: rmmod Not tainted 5.15.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
EIP: refcount_warn_saturate+0xd1/0x120
Code: e8 a2 b0 3b 00 0f 0b eb 83 80 3d db 2a 8c c1 00 0f 85 76 ff ff ff c7 04 24 88 85 78 c1 b1 01 88 0d db 2a 8c c1 e8 7d b0 3b 00 <0f> 0b e9 5b ff ff ff 80 3d d9 2a 8c c1 00 0f 85 4e ff ff ff c7 04
EAX: 00000026 EBX: c250b100 ECX: f5fe8c28 EDX: 00000000
ESI: c244860c EDI: c250b100 EBP: c245be84 ESP: c245be80
DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00000296
CR0: 80050033 CR2: b7e3c3e1 CR3: 024ba000 CR4: 00000690
Call Trace:
 kobject_put+0xdc/0xf0
 software_node_notify_remove+0xa8/0xc0
 device_del+0x15a/0x3e0
 ? kfree_const+0xf/0x30
 ? kobject_put+0xa6/0xf0
 ? module_remove_driver+0x73/0xa0
 platform_device_del.part.0+0xf/0x80
 platform_device_unregister+0x19/0x40
 gpio_mockup_unregister_pdevs+0x13/0x1b [gpio_mockup]
 gpio_mockup_exit+0x1c/0x68c [gpio_mockup]
 __ia32_sys_delete_module+0x137/0x1e0
 ? task_work_run+0x61/0x90
 ? exit_to_user_mode_prepare+0x1b5/0x1c0
 __do_fast_syscall_32+0x50/0xc0
 do_fast_syscall_32+0x32/0x70
 do_SYSENTER_32+0x15/0x20
 entry_SYSENTER_32+0x98/0xe7
EIP: 0xb7eda549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
EAX: ffffffda EBX: 0045a19c ECX: 00000800 EDX: 0045a160
ESI: fffffffe EDI: 0045a160 EBP: bff19d08 ESP: bff19cc8
DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000202
---[ end trace 3d71387f54bc2d06 ]---

I suspect this is related to the recent changes to swnode.c or
platform.c, as gpio-mockup hasn't changed, but haven't had the
chance to debug further.

Cheers,
Kent.
