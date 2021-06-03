Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABEA39984A
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 04:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFCC5j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 22:57:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:7145 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhFCC5j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Jun 2021 22:57:39 -0400
IronPort-SDR: zzcZjnbQkvtRMFxcR/QvUsyuXgH284QfnsMHeul+rPzbH2NPktVGg3yG59a9cAni6x7LrCYpfk
 TZ84iuAEQZUQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="202092515"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="202092515"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 19:55:55 -0700
IronPort-SDR: efKrnAO4x5cazfdnWGlQHpqEddPyvIOClF9BAXUkd4peLDILN4ONx0dHf8Zy97pXGWrnxQIeYV
 dVDmTg5ujEag==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="479987993"
Received: from yanshuol-mobl1.ccr.corp.intel.com ([10.249.172.38])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 19:55:54 -0700
Message-ID: <c873979cb0b909feb075ada203c0a075159c8119.camel@intel.com>
Subject: Re: [PATCH] Revert "ACPI: sleep: Put the FACS table after using it"
From:   Zhang Rui <rui.zhang@intel.com>
To:     Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org
Cc:     rjw@rjwysocki.net
Date:   Thu, 03 Jun 2021 10:55:51 +0800
In-Reply-To: <473f220f-b16f-b813-4246-2d1456b60d38@huawei.com>
References: <20210603023414.2389-1-rui.zhang@intel.com>
         <473f220f-b16f-b813-4246-2d1456b60d38@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2021-06-03 at 10:52 +0800, Hanjun Guo wrote:
> On 2021/6/3 10:34, Zhang Rui wrote:
> > Commit 95722237cb2a ("ACPI: sleep: Put the FACS table after using
> > it")
> > puts the FACS table during initialization.
> > But the hardware signature bits in the FACS table need to be
> > accessed,
> > after every hibernation, to compare with the original hardware
> > signature.
> > 
> > So there is no reason to release the FACS table mapping after
> > initialization.
> > 
> > This reverts commit 95722237cb2ae4f7b73471058cdb19e8f4057c93.
> > 
> > An alternative solution is to use acpi_gbl_FACS variable instead,
> > which
> > is mapped by the ACPICA core and never released.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=212277
> > Reported-by: Stephan Hohe <sth.dev@tejp.de>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >   drivers/acpi/sleep.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > index df386571da98..3bb2adef8490 100644
> > --- a/drivers/acpi/sleep.c
> > +++ b/drivers/acpi/sleep.c
> > @@ -1009,10 +1009,8 @@ static void acpi_sleep_hibernate_setup(void)
> >   		return;
> >   
> >   	acpi_get_table(ACPI_SIG_FACS, 1, (struct acpi_table_header
> > **)&facs);
> > -	if (facs) {
> > +	if (facs)
> >   		s4_hardware_signature = facs->hardware_signature;
> > -		acpi_put_table((struct acpi_table_header *)facs);
> > -	}
> >   }
> >   #else /* !CONFIG_HIBERNATION */
> >   static inline void acpi_sleep_hibernate_setup(void) {}
> 
> My bad, thanks for the fix.
> 
> Patches for ACPI subsystem, subject will have the prefix "ACPI: ",
> could you please add that?

I checked git log, and this does not apply to the revert patch.
So I guess the current subject works.

thanks,
rui

