Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5EF13CCA8
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2020 19:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAOS6u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jan 2020 13:58:50 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:45043 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAOS6t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2020 13:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579114729; x=1610650729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=73iRbj90euAs81pmcyjRvkvGLKITpykEHoHY7B0WgBc=;
  b=MY88sdxhkCwffW7d1JacCBN5SBmu2eEdL+BLVmIVbJWRI0omoSRJiWYh
   GpzmWFS54nofsL/E5kOp0xjiLEeTJmHqyVv4hpQ3WBydizxs6GzjbKlEF
   SkNAMvDtbEvILG3/9l/FGQ/tfJ5E8lpip+H2h67Gl/w24lJlHmfZuZh6N
   o=;
IronPort-SDR: TIa88R3aFmSrGQ2PR9BpfSoRqg125frZIQoNRfhMWhKqbGW4KqwJFfkhsC3MXkt/P2FK3J5AQ0
 RLqMS6ToVvJA==
X-IronPort-AV: E=Sophos;i="5.70,323,1574121600"; 
   d="scan'208";a="20313183"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 15 Jan 2020 18:58:37 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id B9CA614190B;
        Wed, 15 Jan 2020 18:58:34 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 15 Jan 2020 18:58:34 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 15 Jan 2020 18:58:33 +0000
Received: from dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com
 (172.22.96.68) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 15 Jan 2020 18:58:32 +0000
Received: by dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com (Postfix, from userid 4335130)
        id BB3BB40E7E; Wed, 15 Jan 2020 18:58:32 +0000 (UTC)
Date:   Wed, 15 Jan 2020 18:58:32 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <sblbir@amazon.com>, <fllinden@amazon.com>,
        <linux-acpi@vger.kernel.org>, <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>, <anchalag@amazon.com>
Subject: Re: [PATCH] ACPICA: Enable sleep button on ACPI legacy wake
Message-ID: <20200115185832.GA31684@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
References: <20191101212319.1FFC440EB1@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <5749186.Fh4Yg0zt7g@kreacher>
 <20200102223919.GA22256@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <2310267.gkPY8ABrMH@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2310267.gkPY8ABrMH@kreacher>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 15, 2020 at 11:24:47AM +0100, Rafael J. Wysocki wrote:
> On Thursday, January 2, 2020 11:39:19 PM CET Anchal Agarwal wrote:
> > On Thu, Dec 12, 2019 at 11:10:32PM +0100, Rafael J. Wysocki wrote:
> > > On Monday, October 29, 2018 6:52:16 PM CET Anchal Agarwal wrote:
> > > > Currently we do not see sleep_enable bit set after guest resumes
> > > > from hibernation. Hibernation is triggered in guest on receiving
> > > > a sleep trigger from the hypervisor(S4 state). We see that power
> > > > button is enabled on wake up from S4 state however sleep button
> > > > isn't.
> > > 
> > > I'm not against this change in principle, although it may change behavior
> > > in a somewhat unexpected way on some systems.
> > > 
> > Apologies for late response, I was out on vacation. 
> > Can you please elaborate more on that?
> 
> See below.
> 
> > > > This causes subsequent invocation of sleep state to fail
> > > > in the guest.
> > > 
> > > However, can you explain this in a bit more detail?
> > >  
> > I can explain this for my particular case, however, any code path going
> > through acpi_hw_legacy_wake path will not have sleep button enabled. Why
> > is only power button event enabled and not sleep here?
> 
> Good question and related to the potentially unexpected behavior part.
> 
> Presumably, on some systems the sleep button could not be enabled
> automatically as it triggered another suspend right away after that.
> 
> That's speculation, though.
> 
> > In my case, I am using sleep button event to generate S4 state
> > which causes guest VM running on xen to hibernate.
> 
> Usually, however, the sleep button is used to trigger transitions into S3
> (or suspend-to-idle on systems that support it).
> 
> > I have found
> > in my debugging process that after first resume when kernel goes 
> > through this code path, sleep button event is not enabled and 
> > when hypervisor try to generate sci interrupt, its not received in
> > the guest since this path does not enable sleep event.
> 
> OK
> 
> So the patch can be applied AFAICS, but if it is reported to cause problems to
> happen, it will need to be reverted.
> 
> Please resend the patch with a proper CC list (including Bob, Erik, the ACPICA
> devel list etc).
> 
> Thanks!
Sure can I add your Reviewed-by or Acked-by?

Thanks,
Anchal
> 
> 
> 
