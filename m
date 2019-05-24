Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0ED629971
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2019 15:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403921AbfEXNyF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 May 2019 09:54:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38592 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403917AbfEXNyF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 May 2019 09:54:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so4223384plb.5;
        Fri, 24 May 2019 06:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KAeJ4wUrvHpOLw7ye4R6Tb6Y50k1ZsjRygN64gReTaY=;
        b=o3G4QU3iUKDI4Yn+sOyq2Wunya0S3SZMeAbdgf0jLfUS2IieDIk08IaeNje3CTh0Si
         35Z2B1TTjBz2CUk8lM2ToK3ruzwuVNnGOzgProJV37jpfsvCHsZ+bS1M4V/qqyDeMTU6
         diRb2qSpY/kIQhHXv02o5O0x77tf5Myj7NQQn2r7BcAyD48Vo6En/JzB806VJROR7OP3
         +BKGjW1vAMfwcjNnoIjCmmA9uAxA7TT0aCL7MQ35HfVmtYVoa3mfUIAwe8AiJ8S3cjek
         5XrE3luolet+3RPjAX6/MzgYAs4HFzEgLVyABl7JlpVI966fH4NA6JP+XCcBwGUwwv1V
         4bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KAeJ4wUrvHpOLw7ye4R6Tb6Y50k1ZsjRygN64gReTaY=;
        b=TsDg5VTQqYiHNzYtGBTD4N4qXy7+cN/PfuNu538W4nuydU3vdIMeJYwibnVMuiXuD9
         kJysfg4OtKyVUuA8XaKaJTLo3SZ13hYi187wBakte44XwdUpJp2Hur8R66z6I2y7Y+z6
         Wvvlc2RjGbVNelD2crtjq/wukdsp9mSzU+fOXLqGfG4q1608MiAhiChbWxZVRXY3b+Aj
         BO/0UOPYzSF1hu95zzWS7xSVhKf570TbzEueyhDwW+81EmLF3BE6AQTkZy7fcezH9X4k
         Po9ekVoSpBs82xeA6Fvzu7Q5CJGBgegWmvH//Jc7mThhzYHxjNLV4ufT9w7i+hTeyxqa
         +GOA==
X-Gm-Message-State: APjAAAXgiPjsnZ6a+JwrWd1SotyBIbqQq48dP1nFsC7eBequpEbShiPF
        nP4aGwEVlBEFL86/8ZyMJQL13bdjWcs=
X-Google-Smtp-Source: APXvYqxt0sBXbvNKCDDuFXzkLiwx1WjCENXPktOMxi3noMT4ujCq0YhAiiM5MtGU1DAS+zEj2ORk2Q==
X-Received: by 2002:a17:902:7617:: with SMTP id k23mr63034749pll.175.1558706044369;
        Fri, 24 May 2019 06:54:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id g8sm3556133pfk.83.2019.05.24.06.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 06:54:03 -0700 (PDT)
Date:   Fri, 24 May 2019 06:54:00 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.2-rc1
Message-ID: <20190524135358.GA2750@localhost.localdomain>
References: <20190516044313.GA17751@localhost.localdomain>
 <CAAObsKD0_+cJQW0YtF9AkWn8XYP9wSYHTi_UhRiba7tH5EWTdw@mail.gmail.com>
 <20190524024047.GE1936@localhost.localdomain>
 <CAAObsKB_CsPk5uFCCsQs+UD3EYzAwEAWZCiH1_L4t2rXmymjTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAObsKB_CsPk5uFCCsQs+UD3EYzAwEAWZCiH1_L4t2rXmymjTQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

On Fri, May 24, 2019 at 10:23:09AM +0200, Tomeu Vizoso wrote:
> On Fri, 24 May 2019 at 04:40, Eduardo Valentin <edubezval@gmail.com> wrote:
> >
> > On Thu, May 23, 2019 at 11:46:47AM +0200, Tomeu Vizoso wrote:
> > > Hi Eduardo,
> > >
> > > I saw that for 5.1 [0] you included a kernelci boot report for your
> > > tree, but not for 5.2. Have you found anything that should be improved
> > > in KernelCI for it to be more useful to maintainers like you?
> >
> > Honestly, I take a couple of automated testing as input before sending
> > my pulls to Linux: (a) my local test, (b) kernel-ci, and (c) 0-day.
> >
> > There was really no reason specifically for me to not add the report
> > from kernelci, except..
> > >
> > > [0] https://lore.kernel.org/lkml/20190306161207.GA7365@localhost.localdomain/
> > >
> > > I found about this when trying to understand why the boot on the
> > > veyron-jaq board has been broken in 5.2-rc1.
> > >
> >
> > I remember a report saying this failed, but from what I could tell from
> > the boot log, the board booted and hit terminal. But apparently, after
> > all reports from developers, the veyron-jaq boards were in a hang state.
> >
> > That was hard for me to tell from your logs, as they looked like
> > a regular boot that hits terminal.
> >
> > Maybe I should have looked for a specific output of a command you guys
> > run, saying "successful boot" somewhere?
> 
> I think what is easiest and clearest is to consider the bisection
> reports as a very strong indication that something is quite wrong in
> the branch.

OK. I hear you.

> 
> Because if a board stopped booting and the bisection found a
> suspicious patch, and reverting it gets the board booting again, then
> chances are very high that the patch in question broke that boot.
> 


Yeah, for sure If I had understood the report properly I could have
nacked the patch.

> Do you think the wording could be improved to make it clearer? Or
> maybe some other changes to make all this more useful to maintainers
> like you?
> 

Well, from my perspective, I need to judge if the failure on your report
is really related to my changes. Many times, specially on build errors,
we get failures that are unrelated. Build errors are more straight
forward do judge. Similarly, we need to find out if a boot issue is
caused by a change on the branch or something existing. On boot issues
from kernelci reports, I think the false negatives I have been seeing
is lab/boards failing to boot. Those can also be easy to spot as the
in most cases the kernel wont even load. 

For this particular case, as I described before, the kernel would
load and hit the shell command line, but in fact it was in hang state
IIRC. That is probably why it has not straight forward to understand
from the log. Maybe a successful boot message somewhere would have
helped to spot the problem (or the opposite of it, something
saying, I was expecting to execute a command and board was
unresponsive).

