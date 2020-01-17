Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E2F1409E4
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2020 13:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgAQMov (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Jan 2020 07:44:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgAQMov (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Jan 2020 07:44:51 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5503120730;
        Fri, 17 Jan 2020 12:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579265090;
        bh=zPwtUVW8q+p3YGHy4YZsdaGNdFuKXjOFb6ZDNggBGM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkfq2y9na1BRPh97ABqmiHjVIOABPVUMPl12zX8yYbN/6KPKN1dbvK/W3HV5VRfnQ
         UxaiXtYNrJv7axoB1b77/YJ/Jvr4M1DJxpw/ye3umkf9deT6kPdh0ThpoZMPAi8QAv
         nibITdBqQU1f7UUnt/wp+eOE4prYJrXkvU3IF7ME=
Date:   Fri, 17 Jan 2020 12:44:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com, John Garry <john.garry@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tyler Baicar <baicar@os.amperecomputing.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] ACPI/IORT: Fix 'Number of IDs' handling in
 iort_id_map()
Message-ID: <20200117124444.GC8199@willie-the-truck>
References: <1579004051-48797-1-git-send-email-guohanjun@huawei.com>
 <20200117121448.GA8199@willie-the-truck>
 <20200117123226.GA9918@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117123226.GA9918@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 17, 2020 at 12:32:26PM +0000, Lorenzo Pieralisi wrote:
> On Fri, Jan 17, 2020 at 12:14:49PM +0000, Will Deacon wrote:
> > On Tue, Jan 14, 2020 at 08:14:11PM +0800, Hanjun Guo wrote:
> > > Reported-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> > > Link: https://lore.kernel.org/linux-acpi/20191215203303.29811-1-pankaj.bansal@nxp.com/
> > > Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > 
> > I'm a bit confused about the SoB chain here and which tree this is
> > targetting.
> > 
> > Lorenzo?
> 
> sorry about that. It targets arm64 - previously wasn't addressed
> to you and Catalin:
> 
> https://lore.kernel.org/linux-arm-kernel/1577708824-4873-1-git-send-email-guohanjun@huawei.com/
> 
> I rewrote the commit log and asked Hanjun to repost it to target an arm64
> merge.

No need to apologise, just trying to figure out what's going on. Thanks for
the explanation.

> Having said that, this patch makes me nervous, it can break on platforms
> that have non-compliant firmware, I wonder whether it is best to leave
> it in -next for a whole cycle (I can send it to -next) to catch any
> fall-out rather than targeting v5.6 given that technically is _not_ a
> fix (we may even have to revert it - it requires coverage on all ARM64
> ACPI systems).
> 
> What do you think ?

My experience with linux-next is that it doesn't get tonnes of runtime
testing but rather lots of build testing, so I'd be inclined to queue
this for 5.6 (i.e. for the upcoming merge window) and revert it the moment
it causes a problem.

I'll stick it on its own branch so we can also drop it if something comes
up before then.

Will
