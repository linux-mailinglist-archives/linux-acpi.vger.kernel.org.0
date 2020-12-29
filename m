Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D204B2E71F0
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 16:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgL2Prl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Dec 2020 10:47:41 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:40039 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgL2Prl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Dec 2020 10:47:41 -0500
Received: by mail-oi1-f170.google.com with SMTP id p5so14967017oif.7;
        Tue, 29 Dec 2020 07:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MEK4Mw7UBxOJIa/S7PzM0wAgV0d+78LiF/JzTK6IpGY=;
        b=qdj8aBOTwilPMY5oade8smWV58IfL0Edd2EXNuwQ2tfG9+SyaDsyZ1dGdtyjGW87cb
         KW30p0W2MkEHwjrfA0PFDIHW+uWaxF6lVLCJDWph8ubkAB6H8LE+Ypsq72EQiuMS2Vp2
         Q4KzfyXAHaj5PVefDueizjQ5d/XoGj9SAV1xiTfL2dg3mMd70XbLiPL45x/EOPYwk/ry
         QFDmzDgXDcFdHTodCZEl7VisuO/xcmrI6s+Brgr+SUJnl6E5YVgF6krfjSVxv8hXI8/S
         Z2Gea8foxytAE2MbWHQdWtuo7CDvZ3hzfNJ452qqL1s9IKR+JhdpjYGJ8rAGJectvcu8
         KJQw==
X-Gm-Message-State: AOAM531AuF31wxVsD/iZIRWp0ms8MsUzEQ+pmT7sGKw7ywJqJ/PUv/1e
        HgKVbIeO7RORWndDN+G8kOdAh4LKLCEMx5XAKgs=
X-Google-Smtp-Source: ABdhPJympvLKSdtn+Fy+6FP9V+9doVUVBA4W7GeIJDtKG8gT7sd01LpO7TI4S50YuBA/JEnu2FTSmmKRRj/lb9Y+FOA=
X-Received: by 2002:aca:4c1:: with SMTP id 184mr2791324oie.157.1609256820193;
 Tue, 29 Dec 2020 07:47:00 -0800 (PST)
MIME-Version: 1.0
References: <202012271352.JvNDF17O-lkp@intel.com> <34a43212-ff2b-cbc6-a670-975d39ac9f12@redhat.com>
 <16284400-7c71-ee40-b694-614d6daf21f5@lenovo.com> <CAJZ5v0je=BeU98tkXmE9Mu1aiqc4=o288S=uOuFwh=okWJC2eQ@mail.gmail.com>
 <22e7ec14-faab-bddd-fff2-303ab3bff01e@lenovo.com>
In-Reply-To: <22e7ec14-faab-bddd-fff2-303ab3bff01e@lenovo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Dec 2020 16:46:38 +0100
Message-ID: <CAJZ5v0gyAXmbbjbW=sh9UzZRaJMuc0_Btx4V+4DhrSQOPrt3Mg@mail.gmail.com>
Subject: Re: [External] Re: [pm:bleeding-edge 8612/8615] drivers/acpi/platform_profile.c:147:24:
 warning: address of array 'pprof->choices' will always evaluate to 'true'
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 29, 2020 at 4:36 PM Mark Pearson <markpearson@lenovo.com> wrote:
>
> Hi Rafael
>
> On 29/12/2020 10:23, Rafael J. Wysocki wrote:
> > On Tue, Dec 29, 2020 at 12:18 AM Mark Pearson <markpearson@lenovo.com> wrote:
> >>
> >> Hi Hans
> >>
> >> On 27/12/2020 06:56, Hans de Goede wrote:
> >>> Hi,
> >>>
> >>> On 12/27/20 6:11 AM, kernel test robot wrote:
> >>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> >>>> head:   a33520709645543f108361fe21fa9434a351c4e9
> >>>> commit: 8c9b909fb1282e43792433e6c1cba125ccfc6201 [8612/8615] ACPI: platform-profile: Add platform profile support
> >>>> config: x86_64-randconfig-a015-20201221 (attached as .config)
> >>>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
> >>>> reproduce (this is a W=1 build):
> >>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>>>         chmod +x ~/bin/make.cross
> >>>>         # install x86_64 cross compiling tool for clang build
> >>>>         # apt-get install binutils-x86-64-linux-gnu
> >>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=8c9b909fb1282e43792433e6c1cba125ccfc6201
> >>>>         git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> >>>>         git fetch --no-tags pm bleeding-edge
> >>>>         git checkout 8c9b909fb1282e43792433e6c1cba125ccfc6201
> >>>>         # save the attached .config to linux build tree
> >>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> >>>>
> >>>> If you fix the issue, kindly add following tag as appropriate
> >>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>>
> >>>> All warnings (new ones prefixed by >>):
> >>>>
> >>>>>> drivers/acpi/platform_profile.c:147:24: warning: address of array 'pprof->choices' will always evaluate to 'true' [-Wpointer-bool-conversion]
> >>>>            if (!pprof || !pprof->choices || !pprof->profile_set ||
> >>>>                          ~~~~~~~~^~~~~~~
> >>>>    1 warning generated.
> >>>
> >>>
> >>> Ah, this is caused by changing choices from a single long to:
> >>>
> >>>       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> >>>
> >>> So that we can use for_each_set_bit and are future proof for more then
> >>> 32 profiles.
> >>>
> >>> To fix this the check should be changed into this (untested):
> >>>
> >>> #include <linux/bitmap.h>
> >>>
> >>>       if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> >>>           !pprof->profile_set || !pprof->profile_get) {
> >>>               mutex_unlock(&profile_lock);
> >>>               return -EINVAL;
> >>>       }
> >>>
> >>> Mark can you provide a (tested) patch for this?
> >>>
> >>> Regards,
> >>>
> >>> Hans
> >>>
> >> Will do!
> >
> > Please note that I'm not going to push the material to Linus with this
> > warning, so if you want it to go into 5.11, that needs to be addressed
> > timely.
> >
> > Thanks!
> >
> Understood :) I tested this last night and it looks good. Do I push this
> as a v8 patch on the current series or as a new standalone patch?

An incremental patch to fix the issue, please.
