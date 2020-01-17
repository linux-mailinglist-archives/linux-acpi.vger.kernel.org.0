Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D4114098C
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2020 13:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgAQMO4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Jan 2020 07:14:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgAQMO4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Jan 2020 07:14:56 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0BB12073A;
        Fri, 17 Jan 2020 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579263295;
        bh=d47gxuWmCSayfNRtGqrb+qmEhviKiKpxW6b00GdGhhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7iAkMi2OyjFfNHwdzi9yzKrCvbaxZZUcO7xT/HzFAL/6rZf971OGdHO6q2PAllrX
         oJOG+I3BSwCQfnEUUQybnhqwwCOp19eUgvNyFdMmxI45ZkdGfl7r6+L0+oio6vLIY3
         NBBhdnfBZ6xI4fSVZPtpso/goGDz2BcX3IDn8ob8=
Date:   Fri, 17 Jan 2020 12:14:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Message-ID: <20200117121448.GA8199@willie-the-truck>
References: <1579004051-48797-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579004051-48797-1-git-send-email-guohanjun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 14, 2020 at 08:14:11PM +0800, Hanjun Guo wrote:
> The IORT specification [0] (Section 3, table 4, page 9) defines the
> 'Number of IDs' as 'The number of IDs in the range minus one'.
> 
> However, the IORT ID mapping function iort_id_map() treats the 'Number
> of IDs' field as if it were the full IDs mapping count, with the
> following check in place to detect out of boundary input IDs:
> 
> InputID >= Input base + Number of IDs
> 
> This check is flawed in that it considers the 'Number of IDs' field as
> the full number of IDs mapping and disregards the 'minus one' from
> the IDs count.
> 
> The correct check in iort_id_map() should be implemented as:
> 
> InputID > Input base + Number of IDs
> 
> this implements the specification correctly but unfortunately it breaks
> existing firmwares that erroneously set the 'Number of IDs' as the full
> IDs mapping count rather than IDs mapping count minus one.
> 
> e.g.
> 
> PCI hostbridge mapping entry 1:
> Input base:  0x1000
> ID Count:    0x100
> Output base: 0x1000
> Output reference: 0xC4  //ITS reference
> 
> PCI hostbridge mapping entry 2:
> Input base:  0x1100
> ID Count:    0x100
> Output base: 0x2000
> Output reference: 0xD4  //ITS reference
> 
> Two mapping entries which the second entry's Input base = the first
> entry's Input base + ID count, so for InputID 0x1100 and with the
> correct InputID check in place in iort_id_map() the kernel would map
> the InputID to ITS 0xC4 not 0xD4 as it would be expected.
> 
> Therefore, to keep supporting existing flawed firmwares, introduce a
> workaround that instructs the kernel to use the old InputID range check
> logic in iort_id_map(), so that we can support both firmwares written
> with the flawed 'Number of IDs' logic and the correct one as defined in
> the specifications.
> 
> [0]: http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf
> 
> Reported-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> Link: https://lore.kernel.org/linux-acpi/20191215203303.29811-1-pankaj.bansal@nxp.com/
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---

I'm a bit confused about the SoB chain here and which tree this is
targetting.

Lorenzo?

Will
