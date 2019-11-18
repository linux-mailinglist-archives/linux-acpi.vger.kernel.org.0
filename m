Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C83A100A60
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 18:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfKRRhk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 12:37:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46111 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRRhk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Nov 2019 12:37:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id r18so9927694pgu.13;
        Mon, 18 Nov 2019 09:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6OqJ7izL96MuygRQ4WCb5TEiSDpEFGEnv/vieXTBTJg=;
        b=HdgjSeX0VyZW3CpuPTHmci6pMtIi2pICdmRk3D9vQfW4xlHbMPSGq51GjN47ghWZwO
         TdFnOmE4Ai6Jcv1VVfNFvUUDgrc9zwa8Iz4CG1zJL0Ws0nrK4FffNQZYoUfg22ruMKf2
         TPnY9H27+fpAWLYmlk3nVQVe70qo5GhyvEbNFkjNnVt1bOyVIjuIkw1RK1WXPS+6TxJ+
         xPV8oymjPEDTumQpYrAzQQIpDWBLB0AxtMpCLOKULU6JcbGtV29TDv7FpwSVAXKsIp4b
         wtJBVFrFLFBnyW8ZHQvPLY36rBwOIKG/EYfgpAYD3y8MF3nvDjEs+EqnqlEuPsiSEwNz
         6ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6OqJ7izL96MuygRQ4WCb5TEiSDpEFGEnv/vieXTBTJg=;
        b=Wuyok1Q8R+TIDL/2FT6+vsJPA3lKqk7pjiOyNirShvGuLkE3WYN/Se0T1I9Ng96i69
         YTqmWBuBgafPiILZCFmQnRPe8XKxFOmNpvYhamtxYmkp0ab7gTPOpyJOCefHTA1dDJ9H
         UZTjClrEdKWZbXNrJtspw2JIzCQE4HJBOpCgkhwiAX2lco2JcxwnGVoI0UHPI987LGIY
         1ZkbyAl336ZmMRm0fKPTuYFsNprltPIt8vF/j0q8qkBJzIEJF04HRmB/Q0RJ02WAmPwx
         RQhcNV1w3R736rZUUjGH66lkP3cdqSELVXOBfyZwWl0Y4Z7gESxYn2E3YjEOi98uA4W8
         QlMw==
X-Gm-Message-State: APjAAAWss8cH0YTrQgdWUWrb64e7sm5heNL+dG3HeM9v7X6UY33ibwB0
        gEYX80/2VUjnLrVjkJz05U9tYans/J0Fre2WrKE=
X-Google-Smtp-Source: APXvYqwlkgabyCss75HmnsM4HcFCZ4Ctl4qyu1ELlo6rx20jMnxbcNzqJM5lZgvQimF2WKEPQ0I6Y/u39dN7H4X7p9E=
X-Received: by 2002:a62:168f:: with SMTP id 137mr477886pfw.151.1574098657697;
 Mon, 18 Nov 2019 09:37:37 -0800 (PST)
MIME-Version: 1.0
References: <000000000000ee674f0597a18709@google.com> <CACT4Y+aHkU46kF26a6afuQ+UO3N3W9Ur898dFBa+mQ2q6QzoQQ@mail.gmail.com>
In-Reply-To: <CACT4Y+aHkU46kF26a6afuQ+UO3N3W9Ur898dFBa+mQ2q6QzoQQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Nov 2019 19:37:27 +0200
Message-ID: <CAHp75Vf6hfh0+MxX7G5=skcTx+_37ypz_KMi-NYLGB7wW5zs5g@mail.gmail.com>
Subject: Re: linux-next boot error: can't ssh into the instance (3)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com>,
        yeyunfeng@huawei.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 18, 2019 at 7:16 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Nov 18, 2019 at 5:35 PM syzbot
> <syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    519ead8f Add linux-next specific files for 20191118
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14653416e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=652dd3906d691711
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ce541a23cf58c1f6b1b1
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com
>
>
> Looks at the console output, this seems to be related to:
>
> commit eb09878e13013f0faee0a97562da557c4026b8a1
> Author: Yunfeng Ye <yeyunfeng@huawei.com>
> Date:   Thu Nov 14 15:16:24 2019 +0800
>
>     ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
>
> +drivers/acpi/sysfs.c maintainers

Just bisected to the same


# good: [ec5385196779fb927e7d8d5bf31bef14d7ce98ed] Merge tag
'iommu-fixes-v5.4-rc7' of git://git.kernel.org/pub/sc
m/linux/kernel/git/joro/iommu
git bisect good ec5385196779fb927e7d8d5bf31bef14d7ce98ed
# bad: [519ead8f6a3215406afc6e56c596388a690f2edc] Add linux-next
specific files for 20191118
git bisect bad 519ead8f6a3215406afc6e56c596388a690f2edc
# bad: [0f2c488e9643bb9f3570b2beba3f74a29521a941] Merge
remote-tracking branch 'crypto/master'
git bisect bad 0f2c488e9643bb9f3570b2beba3f74a29521a941
# good: [2cee210493eb3afdc3f6c1dc9f1513aa3e0f9c94] Merge
remote-tracking branch 'pstore/for-next/pstore'
git bisect good 2cee210493eb3afdc3f6c1dc9f1513aa3e0f9c94
# good: [50bef71900d25433418529476e7ea8f5826f6c2d] Merge tag
'wireless-drivers-next-2019-11-15' of git://git.kerne
l.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next
git bisect good 50bef71900d25433418529476e7ea8f5826f6c2d
# good: [a1db75140194a7de66f7b839e20a434e15f421b5] Merge
remote-tracking branch 'v4l-dvb/master'
git bisect good a1db75140194a7de66f7b839e20a434e15f421b5
# bad: [3d85aae50537cb659c28ba803dcf0563c00fba53] Merge
remote-tracking branch 'net-next/master'
git bisect bad 3d85aae50537cb659c28ba803dcf0563c00fba53
# bad: [1fd383f2408eeb9ca598e7141c5259dd81266e6d] Merge
remote-tracking branch 'pm/linux-next'
git bisect bad 1fd383f2408eeb9ca598e7141c5259dd81266e6d
# good: [7ddb1e341b377a64ce288f3fb546e51d9a963b20] Merge branches
'pm-sleep', 'pm-tools' and 'powercap' into linux
-next
git bisect good 7ddb1e341b377a64ce288f3fb546e51d9a963b20
# good: [678de5f0c7507eadf47ec55db584c643667d90e1] Merge branch
'pm-cpuidle' into linux-next
git bisect good 678de5f0c7507eadf47ec55db584c643667d90e1
# good: [562c41002218161c11e5b606866a07d11edab1fb] Merge branch
'pm-opp' into linux-next
git bisect good 562c41002218161c11e5b606866a07d11edab1fb
# good: [5b017fcd2f396b370a30bc72630b80bd6fbd7b05] Merge branches
'pm-sleep', 'pm-avs' and 'pm-domains' into linux
-next
git bisect good 5b017fcd2f396b370a30bc72630b80bd6fbd7b05
# good: [967c2e327214fff3b8967271dae6f5a868cbc94c] Merge branch
'pm-cpuidle' into linux-next
git bisect good 967c2e327214fff3b8967271dae6f5a868cbc94c
# good: [dc85e40f885d1614ad5e685d7f7794cb912e2f31] Merge branch
'pm-cpufreq' into linux-next
git bisect good dc85e40f885d1614ad5e685d7f7794cb912e2f31
# bad: [998570b92107eb94faa5c6536f1cba46272c1185] Merge branch
'acpi-sysfs' into linux-next
git bisect bad 998570b92107eb94faa5c6536f1cba46272c1185



>
>
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000ee674f0597a18709%40google.com.



-- 
With Best Regards,
Andy Shevchenko
