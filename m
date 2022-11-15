Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B362957F
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Nov 2022 11:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbiKOKOS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Nov 2022 05:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238441AbiKOKNx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2022 05:13:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31F1424F07;
        Tue, 15 Nov 2022 02:13:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBB08ED1;
        Tue, 15 Nov 2022 02:13:23 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7B343F73B;
        Tue, 15 Nov 2022 02:13:16 -0800 (PST)
Date:   Tue, 15 Nov 2022 10:13:14 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [rafael-pm:bleeding-edge 67/68] arch/arm64/kernel/acpi.c:433:5:
 warning: no previous prototype for 'acpi_ffh_address_space_arch_setup'
Message-ID: <20221115101314.pz53eb54rt4ngojm@bogus>
References: <202211150900.CUzIO2xF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211150900.CUzIO2xF-lkp@intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Tue, Nov 15, 2022 at 09:44:13AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   8992b8d17e6c314a528a5bce386de28701f2a2ef
> commit: 1d280ce099db396e092cac1aa9bf2ea8beee6d76 [67/68] arm64: Add architecture specific ACPI FFH Opregion callbacks
> config: arm64-allyesconfig
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=1d280ce099db396e092cac1aa9bf2ea8beee6d76
>         git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>         git fetch --no-tags rafael-pm bleeding-edge
>         git checkout 1d280ce099db396e092cac1aa9bf2ea8beee6d76
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    arch/arm64/kernel/acpi.c:422:30: error: field 'info' has incomplete type
>      422 |         struct acpi_ffh_info info;
>          |                              ^~~~
> >> arch/arm64/kernel/acpi.c:433:5: warning: no previous prototype for 'acpi_ffh_address_space_arch_setup' [-Wmissing-prototypes]
>      433 | int acpi_ffh_address_space_arch_setup(void *handler_ctxt, void **region_ctxt)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> arch/arm64/kernel/acpi.c:476:5: warning: no previous prototype for 'acpi_ffh_address_space_arch_handler' [-Wmissing-prototypes]
>      476 | int acpi_ffh_address_space_arch_handler(acpi_integer *value, void *region_context)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 

I am aware of these warnings and left it unaddressed for consistency. There
are few(6-8) such instance with similar warnings upstream as well. Let me know
if you prefer to get them fixed, I can fix them all in one go if you are fine
with that.

-- 
Regards,
Sudeep
