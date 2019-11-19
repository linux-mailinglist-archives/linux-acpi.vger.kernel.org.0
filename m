Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC974101D48
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 09:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKSI1k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 03:27:40 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33737 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKSI1j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Nov 2019 03:27:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id m193so18147242oig.0;
        Tue, 19 Nov 2019 00:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTdWL/mbHMVFqnx8U/KnwfTChDme7rGemRgVyorvz5w=;
        b=l0X6O7PEaPU86WL2vwx0dORjRKiCYFVITkKrXVCwL9QqBAK/tWpnqA0tu3v8a4rTxb
         5w7FB5pqHS8zgVR0kHFDyGE1trrs/zbFkNQGnRcl4d3CiFOOkmqD2EyyAqcB9LV2RYs2
         VVMmbZ/0a4o9yywDaXUEz8LrWJdUPrVV3eh9QC9KDSDqy3GnOm/cHZqTFEcdENUB6tW/
         IBevUdkWSE59bip2iLpMl0k2kwEvDZHGQAhkGYEUpE310UukqFDl6l5qdVnYUs6l8kqk
         dlefW0R0D5yBlTwQyXvgm/ul9Oj7jrhstgfoXJr8p6MPDUDPQH3yUGNHuF7jkfDeOi8r
         BaIw==
X-Gm-Message-State: APjAAAWOJ71zZO/rMbLs8fx9UG1wm7OCcYSU/eBrvzR4wgF2ff3MRf6H
        Om3akKPmz4ZQO5VvSyY7dnc7akj6sS+f3GyyAqc=
X-Google-Smtp-Source: APXvYqw5oP+tndd0SdbE4QtLUB1pEEYEitwAwRNYCNmrtaGz9K5GIU5cpVPb+zsX08aRaDOnKXX2Nq6rtBHj8leI7kQ=
X-Received: by 2002:a05:6808:901:: with SMTP id w1mr3087853oih.57.1574152058803;
 Tue, 19 Nov 2019 00:27:38 -0800 (PST)
MIME-Version: 1.0
References: <000000000000ee674f0597a18709@google.com> <CACT4Y+aHkU46kF26a6afuQ+UO3N3W9Ur898dFBa+mQ2q6QzoQQ@mail.gmail.com>
 <CAHp75Vf6hfh0+MxX7G5=skcTx+_37ypz_KMi-NYLGB7wW5zs5g@mail.gmail.com> <20191119050219.GJ163020@sol.localdomain>
In-Reply-To: <20191119050219.GJ163020@sol.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Nov 2019 09:27:27 +0100
Message-ID: <CAJZ5v0h6EVqXpP7p=-WiLKOQAaDCn-DX_H7dbKAfQ+o=fmmEWA@mail.gmail.com>
Subject: Re: linux-next boot error: can't ssh into the instance (3)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 19, 2019 at 6:02 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Mon, Nov 18, 2019 at 07:37:27PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 18, 2019 at 7:16 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Mon, Nov 18, 2019 at 5:35 PM syzbot
> > > <syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    519ead8f Add linux-next specific files for 20191118
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14653416e00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=652dd3906d691711
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=ce541a23cf58c1f6b1b1
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > >
> > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com
> > >
> > >
> > > Looks at the console output, this seems to be related to:
> > >
> > > commit eb09878e13013f0faee0a97562da557c4026b8a1
> > > Author: Yunfeng Ye <yeyunfeng@huawei.com>
> > > Date:   Thu Nov 14 15:16:24 2019 +0800
> > >
> > >     ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
> > >
> > > +drivers/acpi/sysfs.c maintainers
> >
> > Just bisected to the same
> >
>
> I had to revert this in order to boot linux-next as well.  Rafael, can this
> please be reverted?

Dropped already from my linux-next branch, should not be there in
linux-next any more.
