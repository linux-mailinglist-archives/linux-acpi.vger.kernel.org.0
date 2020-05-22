Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32B1DE282
	for <lists+linux-acpi@lfdr.de>; Fri, 22 May 2020 10:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgEVI7C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 May 2020 04:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgEVI7B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 May 2020 04:59:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D155FC061A0E;
        Fri, 22 May 2020 01:59:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci21so4661962pjb.3;
        Fri, 22 May 2020 01:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0IWUwMc/srUWcJUu+6/hxd1H7cj5uoLmAUBBeUE/nY=;
        b=b0R2Kgc9ZuREKf/56jiSRr+W4l/4mWqn+/PTbWFmPfMPVja+B48AFFDo6iZQ/o50wv
         lUd9GO51RSvxzphhTzwGBlKW16hylYbbEplCW8ihoQch90rpeinw9Qy3H7lx/QtaoBzm
         f3Ms3h4moBV3CVgR/5AXJz6WuKuW9uGz7DUYxKyEgzyZvjNbFP2E4zwelQ7eCfqJ4zIv
         GKTzZ3SzarXIS09blxsQIaePVTmP63FOyKdh9yVbyW7BKYW+eEcZFnS2Uhiwq8byFFBo
         zsjEQYOFunlE09hit14SLny1aZU3Kl0lLb9hBpfAzhLmeoKjrPkLOmiC6Z5zcBQRYUlm
         HIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0IWUwMc/srUWcJUu+6/hxd1H7cj5uoLmAUBBeUE/nY=;
        b=ZiOQHOgtHaOp+BrNkaGOH1C+dngwLcBJhwlsu+9JheWZW2DRsUZIahkwOmkeNteNxf
         NrXKQ6cMl4SVAA9qdvsm7NytDsN0lGyXOmeCIEu+PNB4VUVHigxHgFSvuMmNbP79od+p
         HPyLQRGlO7QzbAGs+EM7tDKwgWISJZHKFfamtYHw4AcoQJOYVqg0AWHng4E+q9m82HwU
         KknNS2Zd87VBbm9ym4+qhVSY4XAgsRkAcD3TiXhT34PSIyHNHKEpYOu28kUvX2NtLG+M
         6GyPt2ad4TMtCddlmttl3RijGeWa/JKQuNGQuKFYG6T79R4PWi/q0w1N4wkYGRdsvFRy
         2vlQ==
X-Gm-Message-State: AOAM531XG/nz+5/qPTPWSglDxVKT5tHqQL3q9RYeLfM8uOAzTMVIGouw
        tO0F//eeEQGA30IurE3EfAGjv14DHxVeNewbJZI=
X-Google-Smtp-Source: ABdhPJzW1PCtrjJS+E3ZJX5U/D6yVKL3hJO8V1b3sbmsgyKBMMjWrXatV4ohJM4jUty8jBBXIxDvZvE0p2k4Egt3f+c=
X-Received: by 2002:a17:90b:113:: with SMTP id p19mr3374828pjz.129.1590137941381;
 Fri, 22 May 2020 01:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <1505028180.591737.1589564161284.ref@mail.yahoo.com>
 <1505028180.591737.1589564161284@mail.yahoo.com> <CAHp75VfC0NdyyR1zXbk47G_9y5ResrpV+w3cOntDqP_naocuvQ@mail.gmail.com>
 <2952287.p5mUHPKNZq@kreacher> <d0022af356cf9bd5b544187d9a396734d85a76b3.camel@linux.intel.com>
 <193598853.2172716.1590128099214@mail.yahoo.com>
In-Reply-To: <193598853.2172716.1590128099214@mail.yahoo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 May 2020 11:58:44 +0300
Message-ID: <CAHp75VcQSECZeK-5OhJqXaZdW0r8gnvt_PBSKGK4+BKpa9D9KQ@mail.gmail.com>
Subject: Re: Low Latency Tolerance preventing Intel Package from entering deep
 sleep states
To:     "larsh@apache.org" <larsh@apache.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "David E. Box" <david.e.box@linux.intel.com>,
        "ibm-acpi-devel@lists.sourceforge.net" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Cc: Adrian

On Fri, May 22, 2020 at 9:15 AM larsh@apache.org <larsh@apache.org> wrote:
>
> Thanks David!
>
> With this I tracked down the SD Card Reader (Genesys Logic, Inc Device 9755) as the culprit.
> These are standard in many ThinkPads.
> The curious part is that resume from suspend (S3 or S0iX) also fixes the problem.
> Looks like the driver is not initializing correctly at boot time.
>
> Transcript:
>
> $ cat /sys/kernel/debug/pmc_core/ltr_show | grep SOUTHPORT
> SOUTHPORT_A                             LTR: RAW: 0x88018c01            Non-Snoop(ns): 1024             Snoop(ns): 32768
> SOUTHPORT_B                             LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> SOUTHPORT_C                             LTR: RAW: 0x9f409f4             Non-Snoop(ns): 0                Snoop(ns): 0
> SOUTHPORT_D                             LTR: RAW: 0x88aa88aa            Non-Snoop(ns): 174080           Snoop(ns): 174080
> SOUTHPORT_E                             LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
>
> $ lspci -t
> -[0000:00]-+-00.0
>            +-01.0-[01]--+-00.0
>            |            \-00.1
>            +-02.0
>            +-04.0
>            +-08.0
>            +-12.0
>            +-14.0
>            +-14.2
>            +-15.0
>            +-16.0
>            +-1c.0-[53]----00.0
>            +-1d.0-[02]----00.0
>            +-1d.6-[52]----00.0
>            +-1e.0
>            +-1f.0
>            +-1f.3
>            +-1f.4
>            +-1f.5
>            \-1f.6
>
> $ lspci | grep 53
> 53:00.0 SD Host controller: Genesys Logic, Inc Device 9755
>
> $ cat /sys/bus/pci/devices/0000\:53\:00.0/power/control
> auto
>
> $ echo 1 > /sys/bus/pci/devices/0000\:53\:00.0/remove
> 1
>
> $ cat /sys/kernel/debug/pmc_core/ltr_show | grep SOUTHPORT
> SOUTHPORT_A                             LTR: RAW: 0x8010c01             Non-Snoop(ns): 0                Snoop(ns): 0
> SOUTHPORT_B                             LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> SOUTHPORT_C                             LTR: RAW: 0x9f409f4             Non-Snoop(ns): 0                Snoop(ns): 0
> SOUTHPORT_D                             LTR: RAW: 0x8c548c54            Non-Snoop(ns): 2752512          Snoop(ns): 2752512
> SOUTHPORT_E                             LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
>
> Cheers.
>
> -- Lars
>
>
>
>
>
>
>
>
> On Tuesday, May 19, 2020, 9:03:53 AM PDT, David E. Box <david.e.box@linux.intel.com> wrote:
>
>
>
>
>
> > > > Does anybody know what's going on or how to debug this further?
> > > > As stated above, I was able to work around this problem by
> > > > ignoring SOUTHPORT_A via /sys/kernel/debug/pmc_core/ltr_ignore.
> > > > There has to be a better way, and I'm sure I'm not the only one
> > > > running into this.
>
> ltr_show shows the PMC's (Power Management Controller) view of SoC
> devices and busses. The SOUTHPORTs are the PCIe root ports on your
> system. When you run lspci they are the PCI bridges. Generally, the
> bridges are enumerated in the same order as the SOUTHPORTs, so
> SOUTHPORT_A is your first bridge and the device attached to it (shown
> in lspci -t) is the device that was blocking deeper PC states according
> to your debug.
>
> Determine what this device is on your system. If the ltr was low it's
> because that is what the device requested. You should first check that
> runtime pm is enabled for the device. To do this, check the control
> file in /sys/bus/pci/devices/<SSSS:BB:DD.F>/power, where SSSS:BB:DD.F
> is the enumeration of your device as shown in lspci. If it is 'on' then
> runtime pm is disabled. To enable it echo 'auto' into the file with
> root privileges. Enabling runtime pm should allow the driver to reduce
> functionality of the device when idle. This should lead to a larger
> latency request on the PCI bus which should be reflected in ltr_show.
> You can see if the device is actually runtime suspended and how much
> time it's been suspended (or active) by reading the associated files in
> the power folder.
>
> If this doesn't work, then it's possible that your device doesn't
> support runtime pm. This may be purposely for reliability reasons or
> the driver may just lack support. Check forums discussing issues with
> the device and look for possible options in the driver to force pm
> support (generally this will be centered around enabling ASPM).
>
> You can also download powertop to see the package c-state residencies
> more clearly as percentages of time. powertop also has a tunables tab
> that will show the status of runtime pm on all devices on the system
> and allow you to enable them individually.
>
>
> David
>


-- 
With Best Regards,
Andy Shevchenko
