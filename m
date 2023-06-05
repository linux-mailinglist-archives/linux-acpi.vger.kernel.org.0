Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE71722E01
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jun 2023 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjFER5i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjFER5h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 13:57:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B71AD3
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 10:57:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 548232F4;
        Mon,  5 Jun 2023 10:58:18 -0700 (PDT)
Received: from bogus (unknown [10.57.96.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E62CB3F587;
        Mon,  5 Jun 2023 10:57:30 -0700 (PDT)
Date:   Mon, 5 Jun 2023 18:57:25 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] ACPI: bus: Consolidate all arm specific initialisation
 into acpi_arm_init()
Message-ID: <20230605175725.spc2k6q43pnsdehx@bogus>
References: <20230605103550.2427459-1-sudeep.holla@arm.com>
 <cddea4a2-79ec-ab3e-2e67-be3a2e10824c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cddea4a2-79ec-ab3e-2e67-be3a2e10824c@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 05, 2023 at 04:24:10PM +0100, Robin Murphy wrote:
> On 2023-06-05 11:35, Sudeep Holla wrote:
> > Move all of the ARM-specific initialization into one function namely
> > acpi_arm_init(), so it is not necessary to modify/update bus.c every
> > time a new piece of it is added.
> > 
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Hanjun Guo <guohanjun@huawei.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Link: https://lore.kernel.org/r/CAJZ5v0iBZRZmV_oU+VurqxnVMbFN_ttqrL=cLh0sUH+=u0PYsw@mail.gmail.com
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >   drivers/acpi/arm64/Makefile |  2 +-
> >   drivers/acpi/arm64/agdi.c   |  2 +-
> >   drivers/acpi/arm64/apmt.c   |  2 +-
> >   drivers/acpi/arm64/init.c   | 10 ++++++++++
> >   drivers/acpi/arm64/init.h   | 20 ++++++++++++++++++++
> >   drivers/acpi/arm64/iort.c   |  1 +
> >   drivers/acpi/bus.c          |  7 +------
> >   include/linux/acpi.h        |  6 ++++++
> >   include/linux/acpi_agdi.h   | 13 -------------
> >   include/linux/acpi_apmt.h   | 19 -------------------
> >   include/linux/acpi_iort.h   |  2 --
> >   11 files changed, 41 insertions(+), 43 deletions(-)
> >   create mode 100644 drivers/acpi/arm64/init.c
> >   create mode 100644 drivers/acpi/arm64/init.h
> >   delete mode 100644 include/linux/acpi_agdi.h
> >   delete mode 100644 include/linux/acpi_apmt.h
> > 
> > diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> > index e21a9e84e394..f81fe24894b2 100644
> > --- a/drivers/acpi/arm64/Makefile
> > +++ b/drivers/acpi/arm64/Makefile
> > @@ -3,4 +3,4 @@ obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
> >   obj-$(CONFIG_ACPI_IORT) 	+= iort.o
> >   obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
> >   obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
> > -obj-y				+= dma.o
> > +obj-y				+= dma.o init.o
> > diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> > index f605302395c3..8b3c7d42b41b 100644
> > --- a/drivers/acpi/arm64/agdi.c
> > +++ b/drivers/acpi/arm64/agdi.c
> > @@ -9,11 +9,11 @@
> >   #define pr_fmt(fmt) "ACPI: AGDI: " fmt
> >   #include <linux/acpi.h>
> > -#include <linux/acpi_agdi.h>
> >   #include <linux/arm_sdei.h>
> >   #include <linux/io.h>
> >   #include <linux/kernel.h>
> >   #include <linux/platform_device.h>
> > +#include "init.h"
> >   struct agdi_data {
> >   	int sdei_event;
> > diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> > index 8cab69fa5d59..e5c3bc99fc79 100644
> > --- a/drivers/acpi/arm64/apmt.c
> > +++ b/drivers/acpi/arm64/apmt.c
> > @@ -10,10 +10,10 @@
> >   #define pr_fmt(fmt)	"ACPI: APMT: " fmt
> >   #include <linux/acpi.h>
> > -#include <linux/acpi_apmt.h>
> >   #include <linux/init.h>
> >   #include <linux/kernel.h>
> >   #include <linux/platform_device.h>
> > +#include "init.h"
> >   #define DEV_NAME "arm-cs-arch-pmu"
> > diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
> > new file mode 100644
> > index 000000000000..b4f6ba1c8ef1
> > --- /dev/null
> > +++ b/drivers/acpi/arm64/init.c
> > @@ -0,0 +1,10 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/acpi.h>
> > +#include "init.h"
> > +
> > +void __init acpi_arm_init(void)
> > +{
> > +	acpi_agdi_init();
> > +	acpi_apmt_init();
> > +	acpi_iort_init();
> > +}
> > diff --git a/drivers/acpi/arm64/init.h b/drivers/acpi/arm64/init.h
> > new file mode 100644
> > index 000000000000..85b0541ce3cc
> > --- /dev/null
> > +++ b/drivers/acpi/arm64/init.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#include <linux/init.h>
> > +
> > +#ifdef CONFIG_ACPI_AGDI
> > +void acpi_agdi_init(void);
> > +#else
> > +static inline void acpi_agdi_init(void) { }
> > +#endif /* CONFIG_ACPI_AGDI */
> 
> Hmm, I wonder if it might be any nicer to make the declarations
> unconditional and guard the calls in "if (IS_ENABLED(...))" instead. No
> particular preference, just musing - either way this looks like a sensible
> refactor, so FWIW,
> 

Agreed, I was not so happy but the thought of using IS_ENABLED didn't come
to me. Thanks for that, will update it.

> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>

Thanks.

-- 
Regards,
Sudeep
