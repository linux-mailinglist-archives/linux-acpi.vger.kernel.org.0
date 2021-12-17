Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9816B479497
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Dec 2021 20:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhLQTIS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Dec 2021 14:08:18 -0500
Received: from foss.arm.com ([217.140.110.172]:33636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231704AbhLQTIR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Dec 2021 14:08:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F1AC12FC;
        Fri, 17 Dec 2021 11:08:17 -0800 (PST)
Received: from bogus (unknown [10.57.36.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D19D33F774;
        Fri, 17 Dec 2021 11:08:13 -0800 (PST)
Date:   Fri, 17 Dec 2021 19:08:10 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 2/6] cacheinfo: Set cache 'id' based on DT data
Message-ID: <20211217190810.qz44e3ff2bq4wmf2@bogus>
References: <20211216233125.1130793-1-robh@kernel.org>
 <20211216233125.1130793-3-robh@kernel.org>
 <881f056d-d1ed-c6de-c09d-6e84d8b14530@arm.com>
 <CAL_JsqKKx5-ep5=FVA5OHM+t=T-9GTuf6Sf9P6ZDUs7RD9=c8g@mail.gmail.com>
 <20211217190345.kskfhnelqg3yx4j7@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217190345.kskfhnelqg3yx4j7@bogus>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 17, 2021 at 07:03:45PM +0000, Sudeep Holla wrote:
> On Fri, Dec 17, 2021 at 12:14:22PM -0600, Rob Herring wrote:
> > On Fri, Dec 17, 2021 at 10:57 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > On 2021-12-16 23:31, Rob Herring wrote:
> > > > Use the minimum CPU h/w id of the CPUs associated with the cache for the
> > > > cache 'id'. This will provide a stable id value for a given system. As
> 
> I am trying to follow the code. IIUC, the level one(I$ and D$) are skipped
> in this logic and the private unified cache if any will get the cpu hwid as
> the cache id which is all fine. But what happens if there are 2 levels of
> unified private cache ? I am assuming we only care about shared caches for
> MPAM and ignore private caches which sounds OK but I just wanted to confirm.
> 
> > > > we need to check all possible CPUs, we can't use the shared_cpu_map
> > > > which is just online CPUs. There's not a cache to CPUs mapping in DT, so
> > > > we have to walk all CPU nodes and then walk cache levels.
> 
> I would have preferred to add the cache IDs in DT similar to ACPI but I see
> you have certain concerns with that which are valid as well.

One thing I forgot to add is for some weird reasons, some platform supports
both DT and ACPI, this will force the ID generated here to be used in ACPI as
well to ensure same userspace scripts can be used to manage both. That doesn't
sound so great to me.

-- 
Regards,
Sudeep
