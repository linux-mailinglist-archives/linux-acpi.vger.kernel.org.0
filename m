Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7EAC956
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Sep 2019 23:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406211AbfIGVHz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 7 Sep 2019 17:07:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39597 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfIGVHz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Sep 2019 17:07:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id w144so7789101oia.6;
        Sat, 07 Sep 2019 14:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxihL36gTuIiKNJx4Op/WHeQVZ11JcB3rmyLaJHmdCo=;
        b=sf/6BHf5PSn//m9LZMozqeRG/rdCZ6T1PataFU6dEOJA5v4ZEJgwAnr7CNxM8JMawg
         oQcLaMhOzWwt91dw8IZhbWbnrE2kPx6ikqUv/6BaKRNAkT1o/UJe1czqBGMf7A4hwjIR
         Uz4Ptl+nFKElMznt1AXspTcuFaKQPABPKEoGOSiDU+m26AvcWSD19BZYpmejF1oaIE7A
         SFygmwRHDJg/185nmXJfvrx+dbRHlUcejElRECrmhCc0kaPU8FJwCkSmM5DUOloo10EE
         QAc1oLyFwGa1biEcC8G7MBrFf6OqsodGN4poZL3Gjx14p+K/gLt+mEI0xMkgHnzaEdHM
         usGg==
X-Gm-Message-State: APjAAAXuOTlKpU5nq9PW/cwOfsViCPtWRpMfDCLfbp+2SBn6oNipr/gF
        sjJ6vOlRvhMWMLJpA6TcnsQ+eouZoSMnjk/eYsc=
X-Google-Smtp-Source: APXvYqxw6Q7ZI39fbj1Yg06z2Zfw+1ml3g9QHcrVcWjLu638sWzxbHZQyQ71pyD0sHmJVs/hoPWxndejKSyVjZ8RsHk=
X-Received: by 2002:aca:da86:: with SMTP id r128mr12570871oig.103.1567890473848;
 Sat, 07 Sep 2019 14:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <201909070020.yR8k4sTf%lkp@intel.com> <847405da-8a45-653b-d544-25b58ea48db1@oracle.com>
In-Reply-To: <847405da-8a45-653b-d544-25b58ea48db1@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 7 Sep 2019 23:07:39 +0200
Message-ID: <CAJZ5v0i7Y6DSuYzh0H4n+S8Pd2YAqVZTM+0VCamzW9CBcqFs0g@mail.gmail.com>
Subject: Re: [pm:bleeding-edge 175/181] drivers/cpuidle/driver.c:270:4: error:
 'cpuidle_prev_governor' undeclared; did you mean 'cpuidle_find_governor'?
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 6, 2019 at 7:39 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 9/6/19 5:44 PM, kbuild test robot wrote:
> > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> > head:   79f0d67a241f0583b994c73437caa54a4e942737
> > commit: 73d2bcced00671c2b724a31c3a4b3401c3e278d0 [175/181] cpuidle: allow governor switch on cpuidle_register_driver()
> > config: arm-defconfig (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 73d2bcced00671c2b724a31c3a4b3401c3e278d0
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.4.0 make.cross ARCH=arm
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/cpuidle/driver.c: In function 'cpuidle_register_driver':
> >>> drivers/cpuidle/driver.c:270:4: error: 'cpuidle_prev_governor' undeclared (first use in this function); did you mean 'cpuidle_find_governor'?
> >        cpuidle_prev_governor = cpuidle_curr_governor;
> >        ^~~~~~~~~~~~~~~~~~~~~
> >        cpuidle_find_governor
> >    drivers/cpuidle/driver.c:270:4: note: each undeclared identifier is reported only once for each function it appears in
> >    drivers/cpuidle/driver.c: In function 'cpuidle_unregister_driver':
> >    drivers/cpuidle/driver.c:301:6: error: 'cpuidle_prev_governor' undeclared (first use in this function); did you mean 'cpuidle_find_governor'?
> >      if (cpuidle_prev_governor) {
> >          ^~~~~~~~~~~~~~~~~~~~~
> >          cpuidle_find_governor
> >
> Sorry, didn't build-test with CONFIG_CPU_IDLE_MULTIPLE_DRIVERS=y
>
> Rafael, should I take this message that you queued the series (and thus I submit
> a follow up fixing this), or I can just submit a v3 of this particular series?

Please submit a v3.  Thanks!
