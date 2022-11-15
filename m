Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BA9629990
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Nov 2022 14:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiKONFe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Nov 2022 08:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiKONFd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2022 08:05:33 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2BD62E8;
        Tue, 15 Nov 2022 05:05:29 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id k2so9382935qkk.7;
        Tue, 15 Nov 2022 05:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SWw5MqqbrdMF1DqGQ9iVp12fT794TfRCEwXQNWKkW4=;
        b=du7Fk4pGYOelA7kIKc6mkh8N9gQEL10iN6ftIEZh64Mra9LNAgyjAfUAxF4u7bGd3A
         Kx/DJH0o/ZK2Uqt0OfW6rlANVICcSJyvO9gcyP1vdDnNkNQdr4SGrxUWGE5VIsTyMOSN
         Ql5NXDn06Fow5CZCPSzMFoM6QWnChSqMrE9gQQTiJHWzRw5/XhzulCYyrmV+BmDLy15a
         cVRT8riBQIrMvLk6XVDFauZecrp6/rB5zWqkK7yrVEJ8NfroCsYqOGZKlQJ3kuPty/K+
         hKQs/GirJOsfIfLNZ/zx+QkBweQKuPhlcIoQHruY1JN95Hp0JZJlIrufIcwssR/2bhQm
         5kZg==
X-Gm-Message-State: ANoB5pkGZETw83QDgekodrA1bp6nTQ/e1L5+PE/Sqpn+2s8Zt/iD2EXS
        TciHwD4z3c5Gg5961Lgu/TzONBZSjRxewZhnV/E=
X-Google-Smtp-Source: AA0mqf4oP3P5ztH1eKigJEfPhPFdnChreVhMR1lypx2DeoaKHME6ppmvibS5H+/XN4zEdVn5sJIQD5I1dfivAPhGmLw=
X-Received: by 2002:a37:638f:0:b0:6ec:fa04:d97c with SMTP id
 x137-20020a37638f000000b006ecfa04d97cmr14389550qkb.764.1668517528866; Tue, 15
 Nov 2022 05:05:28 -0800 (PST)
MIME-Version: 1.0
References: <202211150900.CUzIO2xF-lkp@intel.com> <20221115101314.pz53eb54rt4ngojm@bogus>
In-Reply-To: <20221115101314.pz53eb54rt4ngojm@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Nov 2022 14:05:16 +0100
Message-ID: <CAJZ5v0jDMk=0A1ch9P9eeiKXGdaTLS-JnC-vxfKD4u0WmSTp7w@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 67/68] arch/arm64/kernel/acpi.c:433:5:
 warning: no previous prototype for 'acpi_ffh_address_space_arch_setup'
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 15, 2022 at 11:13 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi Rafael,
>
> On Tue, Nov 15, 2022 at 09:44:13AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> > head:   8992b8d17e6c314a528a5bce386de28701f2a2ef
> > commit: 1d280ce099db396e092cac1aa9bf2ea8beee6d76 [67/68] arm64: Add architecture specific ACPI FFH Opregion callbacks
> > config: arm64-allyesconfig
> > compiler: aarch64-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=1d280ce099db396e092cac1aa9bf2ea8beee6d76
> >         git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> >         git fetch --no-tags rafael-pm bleeding-edge
> >         git checkout 1d280ce099db396e092cac1aa9bf2ea8beee6d76
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    arch/arm64/kernel/acpi.c:422:30: error: field 'info' has incomplete type
> >      422 |         struct acpi_ffh_info info;
> >          |                              ^~~~
> > >> arch/arm64/kernel/acpi.c:433:5: warning: no previous prototype for 'acpi_ffh_address_space_arch_setup' [-Wmissing-prototypes]
> >      433 | int acpi_ffh_address_space_arch_setup(void *handler_ctxt, void **region_ctxt)
> >          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >> arch/arm64/kernel/acpi.c:476:5: warning: no previous prototype for 'acpi_ffh_address_space_arch_handler' [-Wmissing-prototypes]
> >      476 | int acpi_ffh_address_space_arch_handler(acpi_integer *value, void *region_context)
> >          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
>
> I am aware of these warnings and left it unaddressed for consistency. There
> are few(6-8) such instance with similar warnings upstream as well. Let me know
> if you prefer to get them fixed, I can fix them all in one go if you are fine
> with that.

Well, it would be good to fix those, at least for the sake of reducing
noise if nothing else.
