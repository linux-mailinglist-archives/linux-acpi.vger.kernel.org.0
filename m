Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5458756356
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jul 2023 14:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjGQMyv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 17 Jul 2023 08:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGQMyu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2023 08:54:50 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51F41B0;
        Mon, 17 Jul 2023 05:54:48 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5216095a698so1091812a12.0;
        Mon, 17 Jul 2023 05:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689598487; x=1690203287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2uSSqoDKdw1xON6ZQFvPCT+NY31p6OTOAF8u4sw0ok=;
        b=L5CcZyTa3jS/crsxovWsMkcNHabVn5eLj8CKeIH9Nz0pVluFIJuCV9uVpksS3NCRjG
         hgOXYmoqbYdow6tWkoGItNkGzyVt20fNaYBg902FvQ5cBHLHnfnjIRGgCZZNEgUGVPZi
         CgOGh2FgUxqJAabZmKNo0gQkH0JugKgpKbj1xmwGTZJnCAqOjuLp7f2PxBlrgCxMoWD3
         PEx3+e9S0bYE3D12n2L/kT9WAyr02wuBPHVmsZqt5ySIo4UqGs1VkBGcDfAp27vDKIlr
         8qrFHsJaPdGAN6EM+LLWchcj7dOYKjGPEVVtGP8oquIB7UU1nB5freUMAcXS2eTXLmp4
         qUvg==
X-Gm-Message-State: ABy/qLbrqBux8mL+CqqHmJztLUsQ3Tp7j/lfHzUJsHXQNmTlBH8b/vPL
        Hh9vwDFporesYSJ09pY1wT66X8sVhMGb99b/TzWL3ACF
X-Google-Smtp-Source: APBJJlG/RFN+alXBMoZub7ZXDrvQKawf7/X52T+PEZuEfvnaSfe0Xzt9b0VQh9l5v/sXc1F2JO/i0QHiWOIqqbfG0Yg=
X-Received: by 2002:a17:906:74dc:b0:994:1808:176b with SMTP id
 z28-20020a17090674dc00b009941808176bmr8581743ejl.6.1689598486971; Mon, 17 Jul
 2023 05:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <202307150637.CGq9exEE-lkp@intel.com> <6f8d0187-0a90-1fa2-61e9-0a7b9a44106e@intel.com>
In-Reply-To: <6f8d0187-0a90-1fa2-61e9-0a7b9a44106e@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Jul 2023 14:54:31 +0200
Message-ID: <CAJZ5v0gP9oGSdsH9KcMamGbc=ca7rZtSVSOSvz=GuLuMiTvt1w@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 22/40] drivers/acpi/internal.h:161:
 multiple definition of `acpi_early_processor_control_setup';
 drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 17, 2023 at 12:48 PM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
> Hi,
>
> On 7/15/2023 12:47 AM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> > head:   4f9dd7927c1cdbaffb20fcdbcc2bdc6caa0b4736
> > commit: ca805e0f04a5f9a773875ad6de914e54e41d43c7 [22/40] ACPI: processor: Use _OSC to convey OSPM processor support information
> > config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230715/202307150637.CGq9exEE-lkp@intel.com/config)
> > compiler: aarch64-linux-gcc (GCC) 12.3.0
> > reproduce: (https://download.01.org/0day-ci/archive/20230715/202307150637.CGq9exEE-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202307150637.CGq9exEE-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    aarch64-linux-ld: drivers/acpi/osi.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/osl.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/utils.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/nvs.o: in function `acpi_early_processor_control_setup':
> >    drivers/acpi/nvs.c:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/wakeup.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/device_sysfs.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/device_pm.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/bus.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/glue.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/scan.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/acpi_processor.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/ec.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/pci_root.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/pci_link.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/acpi_lpss.o: in function `acpi_early_processor_control_setup':
> >    drivers/acpi/acpi_lpss.c:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/acpi_apd.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/acpi_platform.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/acpi_pnp.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/acpi_amba.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/power.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/event.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/sysfs.o: in function `acpi_early_processor_control_setup':
> >>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/property.o: in function `acpi_early_processor_control_setup':
> >    drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/debugfs.o: in function `acpi_early_processor_control_setup':
> >    drivers/acpi/debugfs.c:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/processor_driver.o: in function `acpi_early_processor_control_setup':
> >    drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/container.o: in function `acpi_early_processor_control_setup':
> >    drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/acpi_memhotplug.o: in function `acpi_early_processor_control_setup':
> >    drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >    aarch64-linux-ld: drivers/acpi/dptf/int340x_thermal.o: in function `acpi_early_processor_control_setup':
> >    drivers/acpi/dptf/../internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
> >
> >
> > vim +161 drivers/acpi/internal.h
> >
> >    157
> >    158        void acpi_proc_quirk_mwait_check(void);
> >    159        bool processor_physically_present(acpi_handle handle);
> >    160        #else
> >  > 161        void acpi_early_processor_control_setup(void) {}
>
> I think this should be
> static inline void acpi_early_processor_control_setup(void) {}

I think so.

> Hopefully you could amend this commit ?

Done.

> Not sure why 0-day haven't caught it sooner.

Probably due to lighter coverage of individual patches.

Thanks!
