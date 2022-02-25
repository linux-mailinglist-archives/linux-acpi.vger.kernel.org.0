Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71674C4854
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 16:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiBYPLB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Feb 2022 10:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiBYPLB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 10:11:01 -0500
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC03125EB2;
        Fri, 25 Feb 2022 07:10:28 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id d21so6436569yba.11;
        Fri, 25 Feb 2022 07:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PHDsJtTHgIe1SVb8arRLmZRA4JR4a9wVJvHcDvAPGo=;
        b=C5P9W9mmY+3mQkXUuaZubjWPB1PzuHc2eCDWPxXBm9AROpq/mFILzIQFupIByoNSCa
         +pEPNiBTc1OJ0xjMtir9U+KC2gCJsQv0/x3E1Q7NomHU7BNsupJpv1ksjbv2UZfhrres
         HCjlkWOEx9ecjLr9IQ9fczR3arjBKa0utD8kNnV9fRo1z9EBFWTihT74ZRcotHI+RYjn
         PVjYwvke9wtR6fsTAGL4p7rMDy0Xr66uTSyfWV8mHM/ya2nR1qnFuAd+efHK587TaPpP
         oY3+m8272qudM3/ebISf0VKia7BWBh7qgf41AJUP8Jl4I2ZkKU5qDoQVCYxKigkUkQaB
         9KlQ==
X-Gm-Message-State: AOAM530H0YuVWV9SnfBQVyNmkK/GH9ZPEVLnnrZ2YHwYIAmYCNH72+9K
        aXtft9cIqpTjNRXXuc5eU2TYu8LVfLMK4V8O2bo=
X-Google-Smtp-Source: ABdhPJzbCNciT/Vw4E176zijmDZb74ihGVfvi1mr48gxWn7RqdXe+0jEB+k+fPXqbvyly3jKI0SkyKS4ktc28TS8YP0=
X-Received: by 2002:a25:7785:0:b0:614:c283:2a3d with SMTP id
 s127-20020a257785000000b00614c2832a3dmr7796480ybc.137.1645801828185; Fri, 25
 Feb 2022 07:10:28 -0800 (PST)
MIME-Version: 1.0
References: <202202250758.oDiHyXAy-lkp@intel.com> <0d4d70ca-a17f-b8de-53f7-a85a59304d36@redhat.com>
In-Reply-To: <0d4d70ca-a17f-b8de-53f7-a85a59304d36@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Feb 2022 16:10:17 +0100
Message-ID: <CAJZ5v0jmFJMrKT5RsR+JEfJHaYFxHTi2xjS0UnkNUhSn7-r==A@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 59/73] arch/x86/include/asm/pci_x86.h:133:19:
 error: expected ';' after top level declarator
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 25, 2022 at 12:49 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> On 2/25/22 00:24, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> > head:   8276cbee5a52543c614a1e1bc2624188d5970848
> > commit: 62fabd56faafe033eb0be3ba24000b8db13d4c17 [59/73] x86/PCI: Disable exclusion of E820 reserved addresses in some cases
> > config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220225/202202250758.oDiHyXAy-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=62fabd56faafe033eb0be3ba24000b8db13d4c17
> >         git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> >         git fetch --no-tags rafael-pm bleeding-edge
> >         git checkout 62fabd56faafe033eb0be3ba24000b8db13d4c17
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from arch/x86/kernel/resource.c:4:
> >    arch/x86/include/asm/pci_x86.h:97:8: error: unknown type name 'raw_spinlock_t'
> >    extern raw_spinlock_t pci_config_lock;
> >           ^
> >>> arch/x86/include/asm/pci_x86.h:133:19: error: expected ';' after top level declarator
> >    extern void __init dmi_check_pciprobe(void);
> >                      ^
> >                      ;
> >    arch/x86/include/asm/pci_x86.h:134:19: error: expected ';' after top level declarator
> >    extern void __init dmi_check_skip_isa_align(void);
> >                      ^
> >                      ;
>
> So the problem here seems to be that arch/x86/include/asm/pci_x86.h does not include
> all the headers which it relies on. Instead it release on the files which include it
> to include those headers before hand.
>
> This should fix the errors reported here:
>
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -5,7 +5,9 @@
>   *     (c) 1999 Martin Mares <mj@ucw.cz>
>   */
>
> +#include <linux/init.h>
>  #include <linux/ioport.h>
> +#include <linux/spinlock.h>
>
>  #undef DEBUG
>
> I believe this is best squashed into the original commit,

Done, thanks!

> but let me know if
> you want me to send this out as a proper follow up patch; or if you want a
> new version of the troublesome commit to replace the original one.
