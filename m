Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A73102AE9
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 18:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfKSRm0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 12:42:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbfKSRm0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 12:42:26 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 986A420718;
        Tue, 19 Nov 2019 17:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574185345;
        bh=5CpZAgS92mSvLsDp8eiwhNfpZxP3RgkMymtz27c4Qfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xB5OhM4wTyqZebgSeaTdJ4euEEj4BOPM5PRDEZYuixl8l9EBwhZ3TO5Hy9fJANEVA
         YpslYSOQBUj6HZGBPsxlPLf6c2stcvTVfNrkFtqZswzUrh4rfQ792h0+3z6muctUhS
         16+yUKRxY4hqlzZRMbUoZPwugHUoy16fofefBayI=
Date:   Tue, 19 Nov 2019 09:42:24 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: linux-next boot error: can't ssh into the instance (3)
Message-ID: <20191119174224.GC819@sol.localdomain>
References: <000000000000ee674f0597a18709@google.com>
 <CACT4Y+aHkU46kF26a6afuQ+UO3N3W9Ur898dFBa+mQ2q6QzoQQ@mail.gmail.com>
 <CAHp75Vf6hfh0+MxX7G5=skcTx+_37ypz_KMi-NYLGB7wW5zs5g@mail.gmail.com>
 <20191119050219.GJ163020@sol.localdomain>
 <CAJZ5v0h6EVqXpP7p=-WiLKOQAaDCn-DX_H7dbKAfQ+o=fmmEWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h6EVqXpP7p=-WiLKOQAaDCn-DX_H7dbKAfQ+o=fmmEWA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 19, 2019 at 09:27:27AM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 19, 2019 at 6:02 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Mon, Nov 18, 2019 at 07:37:27PM +0200, Andy Shevchenko wrote:
> > > On Mon, Nov 18, 2019 at 7:16 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > >
> > > > On Mon, Nov 18, 2019 at 5:35 PM syzbot
> > > > <syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    519ead8f Add linux-next specific files for 20191118
> > > > > git tree:       linux-next
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14653416e00000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=652dd3906d691711
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=ce541a23cf58c1f6b1b1
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > >
> > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > Reported-by: syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com
> > > >
> > > >
> > > > Looks at the console output, this seems to be related to:
> > > >
> > > > commit eb09878e13013f0faee0a97562da557c4026b8a1
> > > > Author: Yunfeng Ye <yeyunfeng@huawei.com>
> > > > Date:   Thu Nov 14 15:16:24 2019 +0800
> > > >
> > > >     ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
> > > >
> > > > +drivers/acpi/sysfs.c maintainers
> > >
> > > Just bisected to the same
> > >
> >
> > I had to revert this in order to boot linux-next as well.  Rafael, can this
> > please be reverted?
> 
> Dropped already from my linux-next branch, should not be there in
> linux-next any more.
> 

next-20191119 works for me, thanks for the quick revert.

Let's invalidate this syzbot report:

#syz invalid
