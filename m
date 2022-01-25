Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFAB49B751
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jan 2022 16:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581641AbiAYPN3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jan 2022 10:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581676AbiAYPLa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jan 2022 10:11:30 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E4CC061748
        for <linux-acpi@vger.kernel.org>; Tue, 25 Jan 2022 07:11:26 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id k4so25426174qvt.6
        for <linux-acpi@vger.kernel.org>; Tue, 25 Jan 2022 07:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WD2QjgKAr5swCHrURpeclRyMOx9X99ZWNV9mLEtclCY=;
        b=xENqrx+sID93I4lm/GJcopDToqoFbKFC8r5dz/pt7QL1pXEweVsyzD3GNkTuJo5fF2
         /Yeg8pCTCpH6ax/C08aVaDssvoRmSxO+9RaB2MG2SzfQmHXWTM7g8yUr6kHeslKguZ6J
         FSvVChvdUIF6e5M5cSAyVKmHzxO1X6zx6T2n9xq6hjateCamgBahutyad2LG3roiZ4WG
         mjKxblxuUsu89uY6BpVwIEZFpqYJ0U0kL5k1QFij6VjFgLBIbRkVuP2l0gcEhla2zoSS
         YysP+LxM0SmkatRl9qIo0KMZYyGV3OPi2fbIfn59/FQsavc4XMx/JloP6OswZiVLQ8bI
         BI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WD2QjgKAr5swCHrURpeclRyMOx9X99ZWNV9mLEtclCY=;
        b=tt/Zvb2zRSHwJlbjTLy7lAlkZkO4njdvHmPxLBF51jp1UVkDHVUDYFedT3jHp1VHQ9
         n/douzMPeoU4P9fl4IpaSeBC62479AMLapXCbRpWuQ1UT664Y/jnEt2Jr6nNHuCxvIlk
         zzMEzd+XdgE29bejyYcAk3lFCsBfm/zD8xPAQ/a25Pvn9N19H8KABjE3dUpF1ed9ZxXM
         MR6ME1XMpmkyeIYwiSqrzwvXaLbFEfWSmGZfcIsxPNI2I7tOKXtenAvjx6dB/cci0YcF
         kRXIbApj95F/34tC6ZP5TjDPAL/WIjS92gNvfZH3S483OwbHSi85fpGEd4zjJ2Lo/5dB
         BYIQ==
X-Gm-Message-State: AOAM530zM1/s+252fkRP/D1CXyxzL9ZqktesM0mG3VMohvaJto5FcF4T
        VvpBBsYIelfvaYuz2EoAyYfY2RNo5csR9IN9KhN73g==
X-Google-Smtp-Source: ABdhPJw5f6kNmOzPwWxV7B9HbD2CBSHVGHAC3wp9GemvW0SPTjCSlteYNy9tYj9RfwDxijrW/eiOhPsZ5hgKIya1dL0=
X-Received: by 2002:ad4:5de7:: with SMTP id jn7mr14271585qvb.75.1643123485280;
 Tue, 25 Jan 2022 07:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20211223082422.45637-1-heikki.krogerus@linux.intel.com>
 <20220125140033.1403-1-mike@fireburn.co.uk> <YfAJ+b0G6Yvzhpxp@kuha.fi.intel.com>
In-Reply-To: <YfAJ+b0G6Yvzhpxp@kuha.fi.intel.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 25 Jan 2022 15:11:14 +0000
Message-ID: <CAHbf0-Fs1vwhc8uFrAXSpxgpfhxcGUOjz6bTEyq=hO-TVn5U+g@mail.gmail.com>
Subject: Re: 'Re: [PATCH v5 4/5] usb: typec: port-mapper: Convert to the
 component framework'
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pmalani@chromium.org, rafael@kernel.org,
        sakari.ailus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 25 Jan 2022 at 14:32, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Jan 25, 2022 at 02:00:33PM +0000, Mike Lothian wrote:
> > Hi
> >
> > This patch is stopping my ASUS G513QY from booting correctly
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000008
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 0 P4D 0
> > Oops: 0000 [#1] PREEMPT SMP NOPTI
> > CPU: 1 PID: 116 Comm: kworker/1:1 Not tainted 5.16.0-rc6-tip+ #2991
> > Hardware name: ASUSTeK COMPUTER INC. ROG Strix G513QY_G513QY/G513QY, BIOS G513QY.316 11/29/2021
> > Workqueue: events_long ucsi_init_work
> > RIP: 0010:component_master_add_with_match+0x11/0x190
> > Code: cc cc 00 00 cc cc 00 00 cc 49 89 c9 49 89 d0 31 d2 31 c9 e9 c1 fe ff ff 00 55 41 57 41 56 41 54 53 48 89 d3 49 89 f4 49 89 ff <48> 8b 72 08 48 89 d7 e8 73 01 00 00 89 c5 85 c0 0f 85 55 01 00 00
> > RSP: 0018:ffff8881029f7d48 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> > RDX: 0000000000000000 RSI: ffffffff83095658 RDI: ffff888117658c08
> > RBP: 0000000000000000 R08: ffff88810158e258 R09: ffffea00045d9e00
> > R10: 0000001000000000 R11: ffffffff81be3720 R12: ffffffff83095658
> > R13: ffff888117630a68 R14: ffff888117658c08 R15: ffff888117658c08
> > FS:  0000000000000000(0000) GS:ffff888fde440000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000008 CR3: 00000000ac20c000 CR4: 0000000000150ee0
> > Call Trace:
> >  <TASK>
> >  ? typec_link_ports+0x45/0x50
> >  ? typec_register_port+0x20f/0x260
> >  ? ucsi_register_port+0x33c/0x700
> >  ? __kmalloc+0x14e/0x2a0
> >  ? ucsi_init_work+0x15a/0x330
> >  ? process_one_work+0x1dd/0x380
> >  ? worker_thread+0x26d/0x4a0
> >  ? kthread+0x182/0x1a0
> >  ? worker_clr_flags+0x40/0x40
> >  ? kthread_blkcg+0x30/0x30
> >  ? ret_from_fork+0x22/0x30
> >  </TASK>
> > Modules linked in:
> > CR2: 0000000000000008
> > ---[ end trace 9c7dfbb7c9eaa418 ]---
> > RIP: 0010:component_master_add_with_match+0x11/0x190
> > Code: cc cc 00 00 cc cc 00 00 cc 49 89 c9 49 89 d0 31 d2 31 c9 e9 c1 fe ff ff 00 55 41 57 41 56 41 54 53 48 89 d3 49 89 f4 49 89 ff <48> 8b 72 08 48 89 d7 e8 73 01 00 00 89 c5 85 c0 0f 85 55 01 00 00
> > RSP: 0018:ffff8881029f7d48 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> > RDX: 0000000000000000 RSI: ffffffff83095658 RDI: ffff888117658c08
> > RBP: 0000000000000000 R08: ffff88810158e258 R09: ffffea00045d9e00
> > R10: 0000001000000000 R11: ffffffff81be3720 R12: ffffffff83095658
> > R13: ffff888117630a68 R14: ffff888117658c08 R15: ffff888117658c08
> > FS:  0000000000000000(0000) GS:ffff888fde440000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000008 CR3: 00000000ac20c000 CR4: 0000000000150ee0
> >
> > Is it due to the USB-C port on the Radeon 6800M?
>
> No. There is a fix pending:
> https://lore.kernel.org/linux-usb/20220124090228.41396-3-heikki.krogerus@linux.intel.com/
>
> --
> heikki

Thanks Heilkki

I've found your patches on
https://patchwork.kernel.org/project/linux-usb/patch/20220124090228.41396-2-heikki.krogerus@linux.intel.com/
which work a treat

Cheers

Mike
