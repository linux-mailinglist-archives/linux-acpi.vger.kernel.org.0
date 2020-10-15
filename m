Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5680B28F166
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Oct 2020 13:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgJOLfd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Oct 2020 07:35:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40737 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgJOLfc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2020 07:35:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id l4so2581671ota.7;
        Thu, 15 Oct 2020 04:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EV2xgnYYgtX5X8sAfXhIq7ufGHJKTdukoEvtEtKe4Zg=;
        b=Q7eo17/KX0Ipd7HbiYZ1+DE2fy7NZbL49w6GKPlkpOCVbjxfraIHfsvQBX4Tu7ypMl
         bx9pqmgC1Kudj+iy1Z1PXFTb5qBfA2QLyE9f1IuIZd/Zs3IjkO8nW7+1tIF9w8smWjh3
         X387V8JZQxPVH3/KLMfTnMPdrg8PIJOKZQPkyFDZYbIv1bfXHKRkDdp+GdZtdtEBbsGU
         qB6HpjPOvGZ45LLYrbr3bGp/38HS56S2+S8ldieCm07sUzr4Dw8Nf1cbunlNdS2DRnag
         vHW+bUW8lqnPlyyOM5H97FmqIWd9aDFr3eymAXraqUe1J2N0WCK8EX7UsCP8FBMYEYEk
         39HA==
X-Gm-Message-State: AOAM531yKymq412M2ZLg3rO/VDFqzAa+6hz0375NfBNIQfj8sKTtm3ZU
        WPEj5IcBdAOO+iD2YlfoCYFcaruYR+/Y8tV7g2w=
X-Google-Smtp-Source: ABdhPJyeS6FGw9MxaNzy5Q+U2JJWX+sFTRU1ItficcpZjwm66r2uw9bBu3SLf+1sIfbSoY/L17AZ21b4QnJRRsuZ2Zg=
X-Received: by 2002:a9d:ac9:: with SMTP id 67mr2394038otq.321.1602761730873;
 Thu, 15 Oct 2020 04:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <202009060245.jmydrp7B%lkp@intel.com> <BYAPR11MB3256FDBA54924A32BE878CF787050@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3256FDBA54924A32BE878CF787050@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Oct 2020 13:35:19 +0200
Message-ID: <CAJZ5v0he6mFq339L2o_r=ugG5auX4AUtZwABsFNFFBRcCBJszQ@mail.gmail.com>
Subject: Re: [Devel] [pm:acpica-osl 6/6] drivers/acpi/osl.c:1748:46: sparse:
 sparse: incorrect type in assignment (different address spaces)
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     lkp <lkp@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 14, 2020 at 10:37 PM Moore, Robert <robert.moore@intel.com> wrote:
>
> I believe the file " drivers/acpi/osl.c " is part of the core linux, not ACPICA.

Yes, it is.

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Saturday, September 05, 2020 11:34 AM
> To: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: kbuild-all@lists.01.org; linux-acpi@vger.kernel.org; devel@acpica.org; linux-pm@vger.kernel.org
> Subject: [Devel] [pm:acpica-osl 6/6] drivers/acpi/osl.c:1748:46: sparse: sparse: incorrect type in assignment (different address spaces)
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpica-osl
> head:   c32c3c4079f8a62616413abbead45b6622fb7602
> commit: c32c3c4079f8a62616413abbead45b6622fb7602 [6/6] ACPI: OSL: Make ACPICA use logical addresses of GPE blocks
> config: x86_64-randconfig-s022-20200904 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.2-191-g10164920-dirty
>         git checkout c32c3c4079f8a62616413abbead45b6622fb7602
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
>    drivers/acpi/osl.c:376:17: sparse: sparse: cast removes address space '__iomem' of expression
> >> drivers/acpi/osl.c:1748:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *extern [addressable] [toplevel] acpi_gbl_xgpe0_block_logical_address @@     got void [noderef] __iomem * @@
> >> drivers/acpi/osl.c:1748:46: sparse:     expected void *extern [addressable] [toplevel] acpi_gbl_xgpe0_block_logical_address
>    drivers/acpi/osl.c:1748:46: sparse:     got void [noderef] __iomem *
> >> drivers/acpi/osl.c:1750:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *extern [addressable] [toplevel] acpi_gbl_xgpe1_block_logical_address @@     got void [noderef] __iomem * @@
> >> drivers/acpi/osl.c:1750:46: sparse:     expected void *extern [addressable] [toplevel] acpi_gbl_xgpe1_block_logical_address
>    drivers/acpi/osl.c:1750:46: sparse:     got void [noderef] __iomem *
>    drivers/acpi/osl.c:1760:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *rv @@     got void [noderef] __iomem * @@
>    drivers/acpi/osl.c:1760:20: sparse:     expected void *rv
>    drivers/acpi/osl.c:1760:20: sparse:     got void [noderef] __iomem *
>    drivers/acpi/osl.c:708:1: sparse: sparse: context imbalance in 'acpi_os_read_memory' - wrong count at exit
>    drivers/acpi/osl.c:741:1: sparse: sparse: context imbalance in 'acpi_os_write_memory' - wrong count at exit
>
> # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=c32c3c4079f8a62616413abbead45b6622fb7602
> git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> git fetch --no-tags pm acpica-osl
> git checkout c32c3c4079f8a62616413abbead45b6622fb7602
> vim +1748 drivers/acpi/osl.c
>
>   1742
>   1743  acpi_status __init acpi_os_initialize(void)
>   1744  {
>   1745          acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
>   1746          acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
>   1747
> > 1748          acpi_gbl_xgpe0_block_logical_address =
>   1749                  acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe0_block);
> > 1750          acpi_gbl_xgpe1_block_logical_address =
>   1751                  acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe1_block);
>   1752
>   1753          if (acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) {
>   1754                  /*
>   1755                   * Use acpi_os_map_generic_address to pre-map the reset
>   1756                   * register if it's in system memory.
>   1757                   */
>   1758                  void *rv;
>   1759
>   1760                  rv = acpi_os_map_generic_address(&acpi_gbl_FADT.reset_register);
>   1761                  pr_debug(PREFIX "%s: map reset_reg %s\n", __func__,
>   1762                           rv ? "successful" : "failed");
>   1763          }
>   1764          acpi_os_initialized = true;
>   1765
>   1766          return AE_OK;
>   1767  }
>   1768
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
