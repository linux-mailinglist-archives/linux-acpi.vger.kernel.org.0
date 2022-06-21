Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F83A553396
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jun 2022 15:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351434AbiFUNeT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jun 2022 09:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351745AbiFUNbI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jun 2022 09:31:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB3941AF1F;
        Tue, 21 Jun 2022 06:28:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B48F6165C;
        Tue, 21 Jun 2022 06:28:41 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA5FB3F7D7;
        Tue, 21 Jun 2022 06:28:38 -0700 (PDT)
Date:   Tue, 21 Jun 2022 14:28:36 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Sudeep Holla <sudeep.holla@arm.com>, linux@armlinux.org.uk,
        hkallweit1@gmail.com, gjb@semihalf.com, jaz@semihalf.com,
        tn@semihalf.com, Samer.El-Haj-Mahmoud@arm.com,
        upstream@semihalf.com
Subject: Re: [net-next: PATCH 09/12] Documentation: ACPI: DSD: introduce DSA
 description
Message-ID: <20220621132836.wiyexi4y6vjeumrv@bogus>
References: <20220620150225.1307946-1-mw@semihalf.com>
 <20220620150225.1307946-10-mw@semihalf.com>
 <20220621094556.5ev3nencnw7a5xwv@bogus>
 <YrGoXXBgHvyifny3@smile.fi.intel.com>
 <YrGqg5fHB4s+Y7wx@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrGqg5fHB4s+Y7wx@lunn.ch>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 21, 2022 at 01:24:51PM +0200, Andrew Lunn wrote:
> On Tue, Jun 21, 2022 at 02:15:41PM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 21, 2022 at 10:45:56AM +0100, Sudeep Holla wrote:
> > > On Mon, Jun 20, 2022 at 05:02:22PM +0200, Marcin Wojtas wrote:
> > > > Describe the Distributed Switch Architecture (DSA) - compliant
> > > > MDIO devices. In ACPI world they are represented as children
> > > > of the MDIO busses, which are responsible for their enumeration
> > > > based on the standard _ADR fields and description in _DSD objects
> > > > under device properties UUID [1].
> > > > 
> > > > [1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
> > 
> > > Why is this document part of Linux code base ?
> > 
> > It's fine, but your are right with your latter questions.
> > 
> > > How will the other OSes be aware of this ?
> > 
> > Should be a standard somewhere.
> > 
> > > I assume there was some repository to maintain such DSDs so that it
> > > is accessible for other OSes. I am not agreeing or disagreeing on the
> > > change itself, but I am concerned about this present in the kernel
> > > code.
> > 
> > I dunno we have a such, but the closest I may imagine is MIPI standardization,
> > that we have at least for cameras and sound.
> > 
> > I would suggest to go and work with MIPI for network / DSA / etc area, so
> > everybody else will be aware of the standard.
>
> It is the same argument as for DT. Other OSes and bootloaders seem to
> manage digging around in Linux for DT binding documentation. I don't
> see why bootloaders and other OSes can not also dig around in Linux
> for ACPI binding documentations.
>

Theoretically you are right. But in DT case majority of non-standard(by
standard I am referring to the one's in Open Firmware specification) are
in the kernel. But that is not true for ACPI. And that is the reason for
objecting it. One of the main other OS using ACPI may not look here for
any ACPI bindings(we may not care, but still OS neutral place is better
for this).

> Ideally, somebody will submit all this for acceptance into ACPI, but
> into somebody does, i suspect it will just remain a defacto standard
> in Linux.
>

DSD is not integral part of ACPI spec, so the process is never clear.
However there is this project[1], IIUC it is just guidance and doesn't
include any bindings IIUC. But we need something similar here for better
visibility and to remain OS agnostic. Even with DT, there is a strong
desire to separate it out, but it has grown so much that it is getting
harder to do that with every release. I was just trying to avoid getting
into that situation.

-- 
Regards,
Sudeep

[1] https://github.com/UEFI/DSD-Guide
