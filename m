Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D3A2F0214
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Jan 2021 18:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbhAIRJI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Jan 2021 12:09:08 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49092 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAIRJI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Jan 2021 12:09:08 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 0d85ad585c7e0c50; Sat, 9 Jan 2021 18:08:25 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "len.brown@intel.com" <len.brown@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>
Subject: Re: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by buffer overflow
Date:   Sat, 09 Jan 2021 18:08:24 +0100
Message-ID: <5464224.fTvfEN5hHQ@kreacher>
In-Reply-To: <MWHPR21MB0798C62978C2E6F23FAB953EBFAD9@MWHPR21MB0798.namprd21.prod.outlook.com>
References: <20210108072348.34091-1-decui@microsoft.com> <CAHp75VfPsMNZxN-hA3Cytjpm0K9xGoQpcGY_FZR4hUrtyqMj=w@mail.gmail.com> <MWHPR21MB0798C62978C2E6F23FAB953EBFAD9@MWHPR21MB0798.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Saturday, January 9, 2021 10:37:41 AM CET Dexuan Cui wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com> 
> > Sent: Saturday, January 9, 2021 12:52 AM
> >> 
> >> Hi Rafael, Len, and all,
> >> Can you please take a look at the v2 patch?
> >> 
> >> The Linux mainline has been broken for several weeks when it
> >> runs as a guest on Hyper-V, so we'd like this to be fixed ASAP,
> >> as more people are being affected
> > 
> > I would like to see a warning printed when the dupped
> > string violates the spec.
> 
> Hi Andy,
> Do you want a simple strlen() check like the below, or a full
> check of the AAA#### or NNNN#### format?

It would be good to check the format too while at it.

> Can we have the v2 (https://lkml.org/lkml/2021/1/8/53) merged 
> first, and then we can add another patch for the format checking?

Yes, we can.

I'm going to apply the v2 early next week.

Thanks!



