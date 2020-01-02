Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9024E12EE98
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jan 2020 23:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbgABWjd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Jan 2020 17:39:33 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:6960 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730817AbgABWjc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jan 2020 17:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578004772; x=1609540772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7TqGOOQRMXQDqfI/H8WiMMbhJkMIrk3PbyXq26nkMlM=;
  b=VcwwnPXQ1Anm5BJSTzOVMNT8jOLlnu9N48XAOW9wx/yFV84qe3UsGkEe
   PZdLYHx2X4j3/RvCHO0i+eE/pKSwpAEp3pBgh/QPIlv4I1bnlve1btAty
   dFah9PKXQ1hH+6vo4HD5ufvjpgySOKC47G1g80Ed8PZmYcyx+uPeyr6z4
   8=;
IronPort-SDR: lJXWZKDknXh8LPPE46OV9+Fk4+2ahxiBSsKmRn2G4IQrmch99sc/KA1NQ+IMlfUjAX6yxe7X55
 UvrfEqMCp8Hg==
X-IronPort-AV: E=Sophos;i="5.69,388,1571702400"; 
   d="scan'208";a="8135281"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 02 Jan 2020 22:39:21 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id C5723A1BDE;
        Thu,  2 Jan 2020 22:39:20 +0000 (UTC)
Received: from EX13D13UWB001.ant.amazon.com (10.43.161.156) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 22:39:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UWB001.ant.amazon.com (10.43.161.156) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 22:39:20 +0000
Received: from dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com
 (172.22.96.68) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Thu, 2 Jan 2020 22:39:19 +0000
Received: by dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com (Postfix, from userid 4335130)
        id 1C37C40311; Thu,  2 Jan 2020 22:39:19 +0000 (UTC)
Date:   Thu, 2 Jan 2020 22:39:19 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <sblbir@amazon.com>, <fllinden@amazon.com>,
        <linux-acpi@vger.kernel.org>, <erik.kaneda@intel.com>
Subject: Re: [PATCH] ACPICA: Enable sleep button on ACPI legacy wake
Message-ID: <20200102223919.GA22256@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
References: <20191101212319.1FFC440EB1@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <5749186.Fh4Yg0zt7g@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5749186.Fh4Yg0zt7g@kreacher>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 12, 2019 at 11:10:32PM +0100, Rafael J. Wysocki wrote:
> On Monday, October 29, 2018 6:52:16 PM CET Anchal Agarwal wrote:
> > Currently we do not see sleep_enable bit set after guest resumes
> > from hibernation. Hibernation is triggered in guest on receiving
> > a sleep trigger from the hypervisor(S4 state). We see that power
> > button is enabled on wake up from S4 state however sleep button
> > isn't.
> 
> I'm not against this change in principle, although it may change behavior
> in a somewhat unexpected way on some systems.
> 
Apologies for late response, I was out on vacation. 
Can you please elaborate more on that?
> > This causes subsequent invocation of sleep state to fail
> > in the guest.
> 
> However, can you explain this in a bit more detail?
>  
I can explain this for my particular case, however, any code path going
through acpi_hw_legacy_wake path will not have sleep button enabled. Why
is only power button event enabled and not sleep here?

In my case, I am using sleep button event to generate S4 state
which causes guest VM running on xen to hibernate. I have found
in my debugging process that after first resume when kernel goes 
through this code path, sleep button event is not enabled and 
when hypervisor try to generate sci interrupt, its not received in
the guest since this path does not enable sleep event.


Thanks,
Anchal
> > Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
> > Reviewed-by: Balbir Singh <sblbir@amazon.com>
> > Reviewed-by: Frank van der Linden <fllinden@amazon.com>
> > ---
> >  drivers/acpi/acpica/hwsleep.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
> > index b62db8ec446f..a176c7802760 100644
> > --- a/drivers/acpi/acpica/hwsleep.c
> > +++ b/drivers/acpi/acpica/hwsleep.c
> > @@ -300,6 +300,17 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
> >  				    [ACPI_EVENT_POWER_BUTTON].
> >  				    status_register_id, ACPI_CLEAR_STATUS);
> >  
> > +	/* Enable sleep button */
> > +	(void)
> > +	      acpi_write_bit_register(acpi_gbl_fixed_event_info
> > +				      [ACPI_EVENT_SLEEP_BUTTON].
> > +				      enable_register_id, ACPI_ENABLE_EVENT);
> > +
> > +	(void)
> > +	      acpi_write_bit_register(acpi_gbl_fixed_event_info
> > +				      [ACPI_EVENT_SLEEP_BUTTON].
> > +				      status_register_id, ACPI_CLEAR_STATUS);
> > +
> >  	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKING);
> >  	return_ACPI_STATUS(status);
> >  }
> > 
> 
> 
> 
> 
