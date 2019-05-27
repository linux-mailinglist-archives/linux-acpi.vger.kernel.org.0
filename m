Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4192B32B
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2019 13:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfE0L00 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 May 2019 07:26:26 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52331 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfE0L0X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 May 2019 07:26:23 -0400
Received: by mail-it1-f196.google.com with SMTP id t184so9003438itf.2
        for <linux-acpi@vger.kernel.org>; Mon, 27 May 2019 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVFEAxn6QDUK2Q7FjsZ+cPDp6Vvn72el2LW5H6kkAPk=;
        b=kifWJ4/+v4gg0CSUL7cfMAfOFnkVyxOXCJvUADl2wh6FLYOfY28hSFeB3XW0HrAUI+
         +83Rhdr7qVmfV1TgRFXW5FYFYSl3KXzojbr6VaCRAILLyf79JQJQxVVQ/oW7h39F7+Y4
         NXv9DLVOAke8BtRnIAKCZExLOzA+8SOgCHe3YINU2w8EBVKdeS9UbndFofRYM9GNwyNC
         aIkoq5Q/K31sviUYQ2HbKce48pTqVY6+GwZsmbg4Wp6ryNVBvOlMpQRL3xDHMlbPAJgb
         Pc2wzHmWgcJQOkHNoSPopjD50DtF57Lg9djilDsx3pEKUtRueRliNi1CpUDlBsAkpti/
         RCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVFEAxn6QDUK2Q7FjsZ+cPDp6Vvn72el2LW5H6kkAPk=;
        b=WSXUfDcqt6ukiLAXhVkpqn17P4TQw8Mmp5aseW3I2n+Hq8BJkXdmxbF9myDQ7E/hvJ
         sHdGR3rea5wE7HxP2V8f8y3TvYqD4RtLbY/qXSd1kHpy8bcj43kl+F1aL8tvu/W5gxPx
         5ONM1o6+ZRDimVkw9mNa2OGqrvMaC719h9RN0fYeKvuwio3EcgeCSFCrFvt9LBvvrwVo
         vGqSwNE8kWCSybFdZMM4MZH+biKyYD3KcopHPWwuuyq1URuTpYqYAnC1ETd/5xnRdo8U
         lwtlLyi9YNR1TvDWFfVIyO98bLVIbQMCMRqzuojp9Nef611ObDPEeGpLWxkxQYs8D55v
         EPnA==
X-Gm-Message-State: APjAAAUR4Fm8J6JengkhO/rFt6ZtFYvQHSBtQ48KpgvCFjHxl3R2tU/X
        TTOVJEoXqzKY+BmSQtQLUhQawpjQcrM=
X-Google-Smtp-Source: APXvYqz+Hr6WlhzDmdRVoHgp3K8TDvFEypUU6s0bJ4nTrg2c9AQx9qtIbA5dPhPqhttwSPY2YlsWYg==
X-Received: by 2002:a05:660c:64f:: with SMTP id y15mr29494582itk.180.1558956381758;
        Mon, 27 May 2019 04:26:21 -0700 (PDT)
Received: from mail-it1-f175.google.com (mail-it1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id w139sm5107494ita.43.2019.05.27.04.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 04:26:21 -0700 (PDT)
Received: by mail-it1-f175.google.com with SMTP id t184so9003375itf.2;
        Mon, 27 May 2019 04:26:21 -0700 (PDT)
X-Received: by 2002:a05:660c:64f:: with SMTP id y15mr29494546itk.180.1558956380784;
 Mon, 27 May 2019 04:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190516044313.GA17751@localhost.localdomain> <CAAObsKD0_+cJQW0YtF9AkWn8XYP9wSYHTi_UhRiba7tH5EWTdw@mail.gmail.com>
 <20190524024047.GE1936@localhost.localdomain> <CAAObsKB_CsPk5uFCCsQs+UD3EYzAwEAWZCiH1_L4t2rXmymjTQ@mail.gmail.com>
 <20190524135358.GA2750@localhost.localdomain>
In-Reply-To: <20190524135358.GA2750@localhost.localdomain>
From:   Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date:   Mon, 27 May 2019 13:26:08 +0200
X-Gmail-Original-Message-ID: <CAAObsKC_wJJ7C-swhVoVJC0WOTyxOAdMSM6vjpCSPUwdttRxKQ@mail.gmail.com>
Message-ID: <CAAObsKC_wJJ7C-swhVoVJC0WOTyxOAdMSM6vjpCSPUwdttRxKQ@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.2-rc1
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 24 May 2019 at 15:54, Eduardo Valentin <edubezval@gmail.com> wrote:
>
> Hello,
>
> On Fri, May 24, 2019 at 10:23:09AM +0200, Tomeu Vizoso wrote:
> > On Fri, 24 May 2019 at 04:40, Eduardo Valentin <edubezval@gmail.com> wrote:
> > >
> > > On Thu, May 23, 2019 at 11:46:47AM +0200, Tomeu Vizoso wrote:
> > > > Hi Eduardo,
> > > >
> > > > I saw that for 5.1 [0] you included a kernelci boot report for your
> > > > tree, but not for 5.2. Have you found anything that should be improved
> > > > in KernelCI for it to be more useful to maintainers like you?
> > >
> > > Honestly, I take a couple of automated testing as input before sending
> > > my pulls to Linux: (a) my local test, (b) kernel-ci, and (c) 0-day.
> > >
> > > There was really no reason specifically for me to not add the report
> > > from kernelci, except..
> > > >
> > > > [0] https://lore.kernel.org/lkml/20190306161207.GA7365@localhost.localdomain/
> > > >
> > > > I found about this when trying to understand why the boot on the
> > > > veyron-jaq board has been broken in 5.2-rc1.
> > > >
> > >
> > > I remember a report saying this failed, but from what I could tell from
> > > the boot log, the board booted and hit terminal. But apparently, after
> > > all reports from developers, the veyron-jaq boards were in a hang state.
> > >
> > > That was hard for me to tell from your logs, as they looked like
> > > a regular boot that hits terminal.
> > >
> > > Maybe I should have looked for a specific output of a command you guys
> > > run, saying "successful boot" somewhere?
> >
> > I think what is easiest and clearest is to consider the bisection
> > reports as a very strong indication that something is quite wrong in
> > the branch.
>
> OK. I hear you.
>
> >
> > Because if a board stopped booting and the bisection found a
> > suspicious patch, and reverting it gets the board booting again, then
> > chances are very high that the patch in question broke that boot.
> >
>
>
> Yeah, for sure If I had understood the report properly I could have
> nacked the patch.
>
> > Do you think the wording could be improved to make it clearer? Or
> > maybe some other changes to make all this more useful to maintainers
> > like you?
> >
>
> Well, from my perspective, I need to judge if the failure on your report
> is really related to my changes. Many times, specially on build errors,
> we get failures that are unrelated. Build errors are more straight
> forward do judge. Similarly, we need to find out if a boot issue is
> caused by a change on the branch or something existing. On boot issues
> from kernelci reports, I think the false negatives I have been seeing
> is lab/boards failing to boot. Those can also be easy to spot as the
> in most cases the kernel wont even load.
>
> For this particular case, as I described before, the kernel would
> load and hit the shell command line, but in fact it was in hang state
> IIRC. That is probably why it has not straight forward to understand
> from the log. Maybe a successful boot message somewhere would have
> helped to spot the problem (or the opposite of it, something
> saying, I was expecting to execute a command and board was
> unresponsive).

Ah, I think I see now what you meant. In the boot log linked below,
near the end we have:

22:14:41.981401  ShellCommand command timed out.: Sending # in case of
corruption. Connection timeout 00:04:25, retry in 00:02:12
22:14:42.083594  #

The # character is sent by the LAVA machine that the DUT is connected
to, in the hope that a userspace shell would reply with something.

But the kernel failed to boot to userspace, so we have this at the end:

22:16:54.558087  depthcharge-retry failed: 1 of 1 attempts.
'auto-login-action timed out after 285 seconds'
22:16:54.560479  depthcharge-action failed: 1 of 1 attempts.
'auto-login-action timed out after 285 seconds'
22:16:54.855023  JobError: Your job cannot terminate cleanly.

https://storage.kernelci.org/evalenti/for-kernelci/v5.1-rc6-58-gbe827ffd38ea/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.html

Do you think that's the source of the confusion?

Thanks,

Tomeu
