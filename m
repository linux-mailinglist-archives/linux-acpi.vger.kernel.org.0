Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE5013BD52
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2020 11:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgAOKYu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jan 2020 05:24:50 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44599 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgAOKYu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2020 05:24:50 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id b369c068b6e70c46; Wed, 15 Jan 2020 11:24:48 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Anchal Agarwal <anchalag@amazon.com>
Cc:     sblbir@amazon.com, fllinden@amazon.com, linux-acpi@vger.kernel.org,
        erik.kaneda@intel.com, Bob Moore <robert.moore@intel.com>
Subject: Re: [PATCH] ACPICA: Enable sleep button on ACPI legacy wake
Date:   Wed, 15 Jan 2020 11:24:47 +0100
Message-ID: <2310267.gkPY8ABrMH@kreacher>
In-Reply-To: <20200102223919.GA22256@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
References: <20191101212319.1FFC440EB1@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com> <5749186.Fh4Yg0zt7g@kreacher> <20200102223919.GA22256@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, January 2, 2020 11:39:19 PM CET Anchal Agarwal wrote:
> On Thu, Dec 12, 2019 at 11:10:32PM +0100, Rafael J. Wysocki wrote:
> > On Monday, October 29, 2018 6:52:16 PM CET Anchal Agarwal wrote:
> > > Currently we do not see sleep_enable bit set after guest resumes
> > > from hibernation. Hibernation is triggered in guest on receiving
> > > a sleep trigger from the hypervisor(S4 state). We see that power
> > > button is enabled on wake up from S4 state however sleep button
> > > isn't.
> > 
> > I'm not against this change in principle, although it may change behavior
> > in a somewhat unexpected way on some systems.
> > 
> Apologies for late response, I was out on vacation. 
> Can you please elaborate more on that?

See below.

> > > This causes subsequent invocation of sleep state to fail
> > > in the guest.
> > 
> > However, can you explain this in a bit more detail?
> >  
> I can explain this for my particular case, however, any code path going
> through acpi_hw_legacy_wake path will not have sleep button enabled. Why
> is only power button event enabled and not sleep here?

Good question and related to the potentially unexpected behavior part.

Presumably, on some systems the sleep button could not be enabled
automatically as it triggered another suspend right away after that.

That's speculation, though.

> In my case, I am using sleep button event to generate S4 state
> which causes guest VM running on xen to hibernate.

Usually, however, the sleep button is used to trigger transitions into S3
(or suspend-to-idle on systems that support it).

> I have found
> in my debugging process that after first resume when kernel goes 
> through this code path, sleep button event is not enabled and 
> when hypervisor try to generate sci interrupt, its not received in
> the guest since this path does not enable sleep event.

OK

So the patch can be applied AFAICS, but if it is reported to cause problems to
happen, it will need to be reverted.

Please resend the patch with a proper CC list (including Bob, Erik, the ACPICA
devel list etc).

Thanks!



