Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2628CA07
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Oct 2020 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgJMITo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Oct 2020 04:19:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:46000 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbgJMITo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Oct 2020 04:19:44 -0400
IronPort-SDR: fEfkkYdkS0uo2KaS6Q6fZ7T2bODXyodiv5sMdJ5+B1Em7aJtRb9x4yNwOr1Wvr+wx7pxzjTWpm
 gVaJY5IziGkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="230051494"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="230051494"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 01:19:44 -0700
IronPort-SDR: 8Rw5R9cEjwCD0B8B9refVwF0/sb56zKMxpSv/u5yIQ3/SBy0kadJ8qdQWlHQLB6s5KLLdvqd4k
 ykEqD4jYj1pg==
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="463406008"
Received: from qhan2-mobl1.ccr.corp.intel.com ([10.255.30.158])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 01:19:42 -0700
Message-ID: <147e71b70b123b37be982158946784da3ff35a04.camel@intel.com>
Subject: Re: [PATCH] acpi: reboot: fix racing after writing to ACPI RESET_REG
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, sukumar.ghorai@intel.com
Date:   Tue, 13 Oct 2020 16:19:39 +0800
In-Reply-To: <CAJZ5v0jM-B5VxGSVYf9DVoWkwbGpNFZw_-wTxLxifGap6OA2ug@mail.gmail.com>
References: <20201010022606.27669-1-rui.zhang@intel.com>
         <CAJZ5v0jM-B5VxGSVYf9DVoWkwbGpNFZw_-wTxLxifGap6OA2ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2020-10-12 at 12:42 +0200, Rafael J. Wysocki wrote:
> On Sat, Oct 10, 2020 at 4:36 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > According to the ACPI spec, "The system must reset immediately
> > following
> > the write to the ACPI RESET_REG register.", but there are cases
> > that the
> > system does not follow this and results in racing with the
> > subsequetial
> > reboot mechanism, which brings unexpected behavior.
> > 
> > Fix this by adding a 15ms delay after writing to the ACPI
> > RESET_REG.
> > 
> > Reported-by: Ghorai, Sukumar <sukumar.ghorai@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/reboot.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
> > index ca707f5b521d..88e6b083d702 100644
> > --- a/drivers/acpi/reboot.c
> > +++ b/drivers/acpi/reboot.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/acpi.h>
> >  #include <acpi/reboot.h>
> > +#include <linux/delay.h>
> > 
> >  #ifdef CONFIG_PCI
> >  static void acpi_pci_reboot(struct acpi_generic_address *rr, u8
> > reset_value)
> > @@ -66,4 +67,10 @@ void acpi_reboot(void)
> >                 acpi_reset();
> >                 break;
> >         }
> > +
> > +       /*
> > +        * delay for 15ms in case the system does not shutdown
> > immediately after
> > +        * writing to the ACPI reset register
> 
> It would also be good to make a note of where the 15ms value comes
> from.
> 
> Even if it has been guessed, it will still be good to know that, say,
> 5 years from now.
> 
Agreed, patch V2 sent out.

-rui
> > +        */
> > +       mdelay(15);
> >  }
> > --
> > 2.17.1
> > 

