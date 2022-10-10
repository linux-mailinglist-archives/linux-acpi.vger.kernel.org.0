Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07E25FA308
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Oct 2022 19:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJJR5Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 Oct 2022 13:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJJR5P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Oct 2022 13:57:15 -0400
X-Greylist: delayed 431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Oct 2022 10:57:13 PDT
Received: from outbound-smtp58.blacknight.com (outbound-smtp58.blacknight.com [46.22.136.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D5C77E82
        for <linux-acpi@vger.kernel.org>; Mon, 10 Oct 2022 10:57:13 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp58.blacknight.com (Postfix) with ESMTPS id BEF09FA77C
        for <linux-acpi@vger.kernel.org>; Mon, 10 Oct 2022 18:49:59 +0100 (IST)
Received: (qmail 9487 invoked from network); 10 Oct 2022 17:49:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Oct 2022 17:49:59 -0000
Date:   Mon, 10 Oct 2022 18:45:26 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-rtc@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Intermittent boot failure after 6492fed7d8c9 (v6.0-rc1)
Message-ID: <20221010174526.3yi7nziokwwpr63s@techsingularity.net>
References: <20221010141630.zfzi7mk7zvnmclzy@techsingularity.net>
 <CAJZ5v0j9JyDZupNnQUsTUVv0WapGjK7b5S-4ewZ8-b=HOret2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j9JyDZupNnQUsTUVv0WapGjK7b5S-4ewZ8-b=HOret2Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 10, 2022 at 04:47:50PM +0200, Rafael J. Wysocki wrote:
> Hi Mel,
> 
> Thanks for the report!
> 
> On Mon, Oct 10, 2022 at 4:25 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > Hi Rafael,
> >
> > I'm seeing intermittent boot failures after 6492fed7d8c9 ("rtc: rtc-cmos:
> > Do not check ACPI_FADT_LOW_POWER_S0") due to a NULL pointer exception
> > early in boot. It fails to boot 5 times after 10 boot attempts and I've
> > only observed it on one machine so far. Either a revert or the patch below
> > fixes it but it's unlikely it is the correct fix.
> >
> > --- drivers/rtc/rtc-cmos.c.orig 2022-10-10 15:11:50.335756567 +0200
> > +++ drivers/rtc/rtc-cmos.c      2022-10-10 15:11:53.211756691 +0200
> > @@ -1209,7 +1209,7 @@
> >          * Or else, ACPI SCI is enabled during suspend/resume only,
> >          * update rtc irq in that case.
> >          */
> > -       if (cmos_use_acpi_alarm())
> > +       if (cmos_use_acpi_alarm() && cmos)
> >                 cmos_interrupt(0, (void *)cmos->rtc);
> >         else {
> >                 /* Fix me: can we use cmos_interrupt() here as well? */
> 
> It looks like I've exposed a race condition there.
> 
> Generally speaking, it is misguided to install an event handler that
> is not ready to handle the event at that time before making sure that
> the event is disabled.
> 
> Does the attached patch help?
> 

It failed 3/10 times. That's less than the previous 5/10 failures but I
cannot be certain it helped without running a lot more boot tests. The
failure happens in the same function as before.

-- 
Mel Gorman
SUSE Labs
