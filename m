Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF52B1012BC
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 06:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfKSFCW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 00:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfKSFCV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 00:02:21 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC23F222A4;
        Tue, 19 Nov 2019 05:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574139741;
        bh=rFN7FtR8VY7lJ+xyujHLbuOglcKaHGGxuJ28YM4gUNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojsaZnLlamg5M40NlAuVcaTjr7CPLYi1ITJd+IkMMsh1Ho7BWttf16bwMuQzO3HVq
         /5FO5hwSTSJDTbHlaBTiz0Y4rTYdy++/U5YeVox+z7vm0CTCoQYTiwRBl55Ds31zw2
         MmWwBSonhiXqsH0TBSO947VdYDFXUzD8ZXPUWb/g=
Date:   Mon, 18 Nov 2019 21:02:19 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        yeyunfeng@huawei.com, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: linux-next boot error: can't ssh into the instance (3)
Message-ID: <20191119050219.GJ163020@sol.localdomain>
References: <000000000000ee674f0597a18709@google.com>
 <CACT4Y+aHkU46kF26a6afuQ+UO3N3W9Ur898dFBa+mQ2q6QzoQQ@mail.gmail.com>
 <CAHp75Vf6hfh0+MxX7G5=skcTx+_37ypz_KMi-NYLGB7wW5zs5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf6hfh0+MxX7G5=skcTx+_37ypz_KMi-NYLGB7wW5zs5g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 18, 2019 at 07:37:27PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 18, 2019 at 7:16 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Mon, Nov 18, 2019 at 5:35 PM syzbot
> > <syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    519ead8f Add linux-next specific files for 20191118
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14653416e00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=652dd3906d691711
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=ce541a23cf58c1f6b1b1
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com
> >
> >
> > Looks at the console output, this seems to be related to:
> >
> > commit eb09878e13013f0faee0a97562da557c4026b8a1
> > Author: Yunfeng Ye <yeyunfeng@huawei.com>
> > Date:   Thu Nov 14 15:16:24 2019 +0800
> >
> >     ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
> >
> > +drivers/acpi/sysfs.c maintainers
> 
> Just bisected to the same
> 

I had to revert this in order to boot linux-next as well.  Rafael, can this
please be reverted?

Thanks,

- Eric
