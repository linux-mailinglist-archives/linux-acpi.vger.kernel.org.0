Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E61F1D5BBB
	for <lists+linux-acpi@lfdr.de>; Fri, 15 May 2020 23:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgEOVl2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 May 2020 17:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726730AbgEOVl1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 May 2020 17:41:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A772BC061A0C;
        Fri, 15 May 2020 14:41:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so1447723plr.2;
        Fri, 15 May 2020 14:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6wTjQtb75vxwwUpQOuSXET7G/gWKLTlHS4eXtBSEVQs=;
        b=gOpkghCRHL3EAX5gs7prRJRg7VXtB8bVIHhwOFBx3+pdE62N55QVFUZ5o/a5lNTENi
         y+7yotxmOri7Y8CRsOp+zLAQB3Rn32rHzgGkhE0aaTVkU/0m5/nANXOFBuKfWzo3torc
         l5g1p5aVgzTJdANWIEdkMa5auAFlqvPb6M30qkHfjcBx7AwIcs9gJuuhug10W+WJhQ7l
         pKx6nxQ4FuAwcAMRMlLnzqufxM8gHA4OF0CZQIDpDaJqrgwEv9+lFZRGki7428JDIJaJ
         ZFLmQQ5Rmj+PHtnngYX8tMjQpVhQM4l7FFDlvN2HE/+ve97T1PMO7PC4lsvpjF4VlnI8
         sL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6wTjQtb75vxwwUpQOuSXET7G/gWKLTlHS4eXtBSEVQs=;
        b=jL2X35F33R+pkql3ThTIg+4pJbYUXvEG/F2P6G0QOv3JTQusDJ/Q4RkchB4WdQqWtK
         ISM7noxebi0PQhn2Fb0YMop7m5nk8yQbCjhzgiDM2FYpSA6h5vDQOTomw4LQ9dAGqAbh
         MwVm03imtPdtlYoYlB6sLl4/w3LKl3Qn3mV+BfwsGTZLRk8UbGwRrlSPcysL2WFi5HON
         F3aky2u2QElzmNfA/yIokBkh0fwJ6dYwb9LGlLcGYZLJwBn7OIg7wr4/YRoEgV142uRr
         SDPrezG2zfOkDzdhDAmz4ZXTrJSzD9bYRv57XFHWmRT7i6jHM6sFT1ri8eNODqM3Qu8J
         xqUg==
X-Gm-Message-State: AOAM5314oHAMK5UerbArhVx1AJutr2y08E7hXhAs8u/RMKB/CW8zld+o
        95sX9QiVQWGSv4nTLwZDoN/lJzn0RIpMgLTpj3r7QTdl
X-Google-Smtp-Source: ABdhPJwS0Wkz5kxUpYKWbjdCPIUB4hTjF7ZvgeUjFNqAvQ8AgR8dPU1wUc7lA/tlSrjbHm3FivGbMcrFEHf7ilSH5vw=
X-Received: by 2002:a17:90b:94a:: with SMTP id dw10mr5781646pjb.228.1589578887038;
 Fri, 15 May 2020 14:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <1505028180.591737.1589564161284.ref@mail.yahoo.com> <1505028180.591737.1589564161284@mail.yahoo.com>
In-Reply-To: <1505028180.591737.1589564161284@mail.yahoo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 May 2020 00:41:16 +0300
Message-ID: <CAHp75VfC0NdyyR1zXbk47G_9y5ResrpV+w3cOntDqP_naocuvQ@mail.gmail.com>
Subject: Re: Low Latency Tolerance preventing Intel Package from entering deep
 sleep states
To:     "larsh@apache.org" <larsh@apache.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "ibm-acpi-devel@lists.sourceforge.net" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Cc: ACPI ML and Rafael

On Fri, May 15, 2020 at 8:36 PM larsh@apache.org <larsh@apache.org> wrote:
>
> Hi. I hope this is the right forum to raise this...
>
> For a while I have noticed that my CPU (i9-9880H in a Lenovo X1 Extreme Gen2) never enters any sleep mode below pc2.
> (Confirmed with powertop and /sys/kernel/debug/pmc_core/package_cstate_show)
>
> Interestingly the CPU *can* reachers deeper C states *after* a resume from sleep (either S0ix or S3, i.e. freeze or mem).
>
> This article finally pointed me in the right direction: https://01.org/blogs/qwang59/2020/linux-s0ix-troubleshooting
>
> Somehow SOUTHPORT_A is requesting a max latency of 1 us.
> There are no external devices attached.
>
> This is before a resume:
>
> $ cat /sys/kernel/debug/pmc_core/ltr_show
> SOUTHPORT_A                             LTR: RAW: 0x88018c01            Non-Snoop(ns): 1024             Snoop(ns): 32768           <-------
> SOUTHPORT_B                             LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> SATA                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> GIGABIT_ETHERNET                        LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> XHCI                                    LTR: RAW: 0x13ff                Non-Snoop(ns): 0                Snoop(ns): 0
> Reserved                                LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> ME                                      LTR: RAW: 0x8000800             Non-Snoop(ns): 0                Snoop(ns): 0
> EVA                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> SOUTHPORT_C                             LTR: RAW: 0x9f409f4             Non-Snoop(ns): 0                Snoop(ns): 0
> HD_AUDIO                                LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> CNV                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> LPSS                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> SOUTHPORT_D                             LTR: RAW: 0x8c548c54            Non-Snoop(ns): 2752512          Snoop(ns): 2752512
> SOUTHPORT_E                             LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> CAMERA                                  LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> ESPI                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> SCC                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> ISH                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> UFSX2                                   LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> EMMC                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> WIGIG                                   LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> CURRENT_PLATFORM                        LTR: RAW: 0x40201               Non-Snoop(ns): 0                Snoop(ns): 0
> AGGREGATED_SYSTEM                       LTR: RAW: 0x7fbfdfe             Non-Snoop(ns): 0                Snoop(ns): 0
>
> Notice the 1000ns max latency requirement for SOUTHPORT_A.
>
> Ignoring SOUTHPORT_A via /sys/kernel/debug/pmc_core/ltr_ignore subsequently allows the CPU to reach deep sleep states.
>
> After a resume it looks like suddenly SOUTHPORT_C is active and with a less tight latency requirement:
>
> $ cat /sys/kernel/debug/pmc_core/ltr_show
> SOUTHPORT_A                             LTR: RAW: 0x8010c01             Non-Snoop(ns): 0                Snoop(ns): 0               <--------
> SOUTHPORT_B                             LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> SATA                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> GIGABIT_ETHERNET                        LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> XHCI                                    LTR: RAW: 0x13ff                Non-Snoop(ns): 0                Snoop(ns): 0
> Reserved                                LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> ME                                      LTR: RAW: 0x8000800             Non-Snoop(ns): 0                Snoop(ns): 0
> EVA                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> SOUTHPORT_C                             LTR: RAW: 0x88468846            Non-Snoop(ns): 71680            Snoop(ns): 71680           <---------
> HD_AUDIO                                LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> CNV                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> LPSS                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> SOUTHPORT_D                             LTR: RAW: 0x8c548c54            Non-Snoop(ns): 2752512          Snoop(ns): 2752512
> SOUTHPORT_E                             LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> CAMERA                                  LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> ESPI                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> SCC                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> ISH                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> UFSX2                                   LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> EMMC                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> WIGIG                                   LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> CURRENT_PLATFORM                        LTR: RAW: 0x40201               Non-Snoop(ns): 0                Snoop(ns): 0
> AGGREGATED_SYSTEM                       LTR: RAW: 0x904824              Non-Snoop(ns): 0                Snoop(ns): 0
>
> Does anybody know what's going on or how to debug this further?
>
> As stated above, I was able to work around this problem by ignoring SOUTHPORT_A via /sys/kernel/debug/pmc_core/ltr_ignore.
> There has to be a better way, and I'm sure I'm not the only one running into this.
>
> Thanks.
>
> -- Lars



-- 
With Best Regards,
Andy Shevchenko
