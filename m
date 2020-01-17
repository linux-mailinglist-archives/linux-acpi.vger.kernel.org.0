Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048461409C8
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2020 13:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgAQMcd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Jan 2020 07:32:33 -0500
Received: from foss.arm.com ([217.140.110.172]:40664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgAQMcd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Jan 2020 07:32:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2F1411D4;
        Fri, 17 Jan 2020 04:32:32 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E1BB3F6C4;
        Fri, 17 Jan 2020 04:32:31 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:32:26 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <20200117123226.GA9918@e121166-lin.cambridge.arm.com>
References: <1579004051-48797-1-git-send-email-guohanjun@huawei.com>
 <20200117121448.GA8199@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117121448.GA8199@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 17, 2020 at 12:14:49PM +0000, Will Deacon wrote:
> On Tue, Jan 14, 2020 at 08:14:11PM +0800, Hanjun Guo wrote:
> > The IORT specification [0] (Section 3, table 4, page 9) defines the
> > 'Number of IDs' as 'The number of IDs in the range minus one'.
> > 
> > However, the IORT ID mapping function iort_id_map() treats the 'Number
> > of IDs' field as if it were the full IDs mapping count, with the
> > following check in place to detect out of boundary input IDs:
> > 
> > InputID >= Input base + Number of IDs
> > 
> > This check is flawed in that it considers the 'Number of IDs' field as
> > the full number of IDs mapping and disregards the 'minus one' from
> > the IDs count.
> > 
> > The correct check in iort_id_map() should be implemented as:
> > 
> > InputID > Input base + Number of IDs
> > 
> > this implements the specification correctly but unfortunately it breaks
> > existing firmwares that erroneously set the 'Number of IDs' as the full
> > IDs mapping count rather than IDs mapping count minus one.
> > 
> > e.g.
> > 
> > PCI hostbridge mapping entry 1:
> > Input base:  0x1000
> > ID Count:    0x100
> > Output base: 0x1000
> > Output reference: 0xC4  //ITS reference
> > 
> > PCI hostbridge mapping entry 2:
> > Input base:  0x1100
> > ID Count:    0x100
> > Output base: 0x2000
> > Output reference: 0xD4  //ITS reference
> > 
> > Two mapping entries which the second entry's Input base = the first
> > entry's Input base + ID count, so for InputID 0x1100 and with the
> > correct InputID check in place in iort_id_map() the kernel would map
> > the InputID to ITS 0xC4 not 0xD4 as it would be expected.
> > 
> > Therefore, to keep supporting existing flawed firmwares, introduce a
> > workaround that instructs the kernel to use the old InputID range check
> > logic in iort_id_map(), so that we can support both firmwares written
> > with the flawed 'Number of IDs' logic and the correct one as defined in
> > the specifications.
> > 
> > [0]: http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf
> > 
> > Reported-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> > Link: https://lore.kernel.org/linux-acpi/20191215203303.29811-1-pankaj.bansal@nxp.com/
> > Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > ---
> 
> I'm a bit confused about the SoB chain here and which tree this is
> targetting.
> 
> Lorenzo?

Hi Will,

sorry about that. It targets arm64 - previously wasn't addressed
to you and Catalin:

https://lore.kernel.org/linux-arm-kernel/1577708824-4873-1-git-send-email-guohanjun@huawei.com/

I rewrote the commit log and asked Hanjun to repost it to target an arm64
merge.

Having said that, this patch makes me nervous, it can break on platforms
that have non-compliant firmware, I wonder whether it is best to leave
it in -next for a whole cycle (I can send it to -next) to catch any
fall-out rather than targeting v5.6 given that technically is _not_ a
fix (we may even have to revert it - it requires coverage on all ARM64
ACPI systems).

What do you think ?

Lorenzo
