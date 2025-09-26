Return-Path: <linux-acpi+bounces-17359-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58446BA447D
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 16:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9C21BC2A82
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7641990C7;
	Fri, 26 Sep 2025 14:48:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA618EAB;
	Fri, 26 Sep 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898097; cv=none; b=OTULOkmfveohsWQMxvbX59umoTdD5PBI4ptYekxIeKpZYvcTR47srUlAfJikQkQmVyfnEp52jODGhHddTjCMlpp11tJnWlRowfr2wYeUhohKfwdMnWfU9dmK8QmtBYNGFLJolzz5P+li9P0n1MoODCzwfmFqye6ESSePbB3nuAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898097; c=relaxed/simple;
	bh=3WOIA2hifttzbRkYMv/RbdzNE6CB2JC73pdMIOqtSGc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dH+yfbKRQabWVAelN/PRQeKvZ335AehINi0hk0H29P45Y3CLXL8TXCxzQB8mz4fr+50Zog6jsJyuwveRR2f7+gWIYyqeFfmEUKvOEJdwTYNiOBPMISHUIrXwaFUq6msiJlY2agJ9l6jZPopUvPtm+z6yD+kno0KznNKgMwXK/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cYCzn3mX8z6M4Rs;
	Fri, 26 Sep 2025 22:45:09 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 53443140278;
	Fri, 26 Sep 2025 22:48:11 +0800 (CST)
Received: from localhost (10.47.75.77) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Sep
 2025 15:48:09 +0100
Date: Fri, 26 Sep 2025 15:48:06 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: James Morse <james.morse@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>, Koba
 Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	<fenghuay@nvidia.com>, <baisheng.gao@unisoc.com>, Rob Herring
	<robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>, "Rafael Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 06/29] ACPI / MPAM: Parse the MPAM table
Message-ID: <20250926154806.0000609e@huawei.com>
In-Reply-To: <334e0e8b-3f30-48b7-896f-0b31111d2b41@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-7-james.morse@arm.com>
	<20250911141726.00002f0c@huawei.com>
	<334e0e8b-3f30-48b7-896f-0b31111d2b41@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)


Hi James

Just a few things I've picked out to reply to.
Absolutely fine with your other replies.

> 
> >> +	char uid[16];
> >> +	u32 acpi_id;
> >> +
> >> +	if (acpi_disabled || !system_supports_mpam() || IS_ERR(table))
> >> +		return 0;
> >> +
> >> +	if (table->revision < 1)
> >> +		return 0;
> >> +
> >> +	table_end = (char *)table + table->length;
> >> +
> >> +	while (table_offset < table_end) {
> >> +		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
> >> +		table_offset += tbl_msc->length;
> >> +
> >> +		if (table_offset > table_end) {
> >> +			pr_debug("MSC entry overlaps end of ACPI table\n");
> >> +			break;  
> 
> > That this isn't considered an error is a bit subtle and made me wonder
> > if there was a use of uninitialized pdev (there isn't because err == 0)  
> 
> Its somewhat a philosophical arguement. I don't expect the kernel to have to validate
> these tables, they're not provided by the user and there quickly becomes a point where
> you have to trust them, and they have to be correct.

Potential buffer overrun is to me always worth error out screaming, but I get your
broader point.   Maybe just make it a pr_err()

> At the other extreme is the asusmption the table is line-noise and we should check
> everything to avoid out of bounds accesses. Dave wanted the diagnostic messages on these.
> 
> As this is called from an initcall, the best you get is an inexplicable print message.
> (what should we say - update your firmware?)

Depends on whether you can lean hard on the firmware team. Much easier
for me if I can tell them the board doesn't boot because they got it wrong.

That would have been safer if we had this upstream in advance of hardware, but indeed
a little high risk today as who knows what borked tables are out there.

Personal preference though is to error out on things like this and handle the papering
over at the top level.  Don't put extra effort into checking tables are invalid
but if we happen to notice as part of code safety stuff like sizes then good to scream
about it.

> 
> 
> Silently failing in this code is always safe as the driver has a count of the number of
> MSC, and doesn't start accessing the hardware until its found them all.
> (this is because to find the system wide minimum value - and its not worth starting if
>  its not possible to finish).
> 
> 
> > Why not return here?  
> 
> Just because there was no other return in the loop, and I hate surprise returns.
> 
> I'll change it if it avoids thinking about how that platform_device_put() gets skipped!
> 
> 
> >   
> >> +		}
> >> +
> >> +		/*
> >> +		 * If any of the reserved fields are set, make no attempt to
> >> +		 * parse the MSC structure. This MSC will still be counted,
> >> +		 * meaning the MPAM driver can't probe against all MSC, and
> >> +		 * will never be enabled. There is no way to enable it safely,
> >> +		 * because we cannot determine safe system-wide partid and pmg
> >> +		 * ranges in this situation.
> >> +		 */  
> 
> > This is decidedly paranoid. I'd normally expect the architecture to be based
> > on assumption that is fine for old software to ignore new fields.  ACPI itself
> > has fairly firm rules on this (though it goes wrong sometimes :)  
> 
> Yeah - the MPAM table isn't properly structured as subtables. I don't see how they are
> going to extend it if they need to.
> 
> The paranoia is that anything set in these reserved fields probably indicates something
> the driver needs to know about: a case in point is the way PCC was added.
> 
> I'd much prefer we skip creation of MSC devices that have properties we don't understand.
> acpi_mpam_count_msc() still counts them - which means the driver never finds all the MSC,
> and never touches the hardware.
> 
> MPAM isn't a critical feature, its better that it be disabled than make things worse.
> (the same attitude holds with the response to the MPAM error interrupt - reset everything
>  and pack up shop. This is bettern than accidentally combining important/unimportant
>  tasks)
> 
> 
> > I'm guessing there is something out there that made this necessary though so
> > keep it if you actually need it.  
> 
> It's a paranoid/violent reaction to the way PCC was added - without something like this,
> that would have led to the OS trying to map the 0 page and poking around in it - never
> likely to go well.
> 
> Doing this does let them pull another PCC without stable kernels going wrong.
> Ultimately I think they'll need to replace the table with one that is properly structured.
> For now - this is working with what we have.

Fair enough. I'm too lazy / behind with reviews to go scream via our channels about
problems here.  Paranoia it is.  Maybe we'll end up backporting some 'fixes' that
ignore nicely added fields with appropriate control bits to turn them on.
So be it if that happens.

> 
> 
> >> +		if (tbl_msc->reserved || tbl_msc->reserved1 || tbl_msc->reserved2) {
> >> +			pr_err_once("Unrecognised MSC, MPAM not usable\n");
> >> +			pr_debug("MSC.%u: reserved field set\n", tbl_msc->identifier);
> >> +			continue;
> >> +		}
> >> +
> >> +		if (!tbl_msc->mmio_size) {
> >> +			pr_debug("MSC.%u: marked as disabled\n", tbl_msc->identifier);
> >> +			continue;
> >> +		}
> >> +
> >> +		if (decode_interface_type(tbl_msc, &iface)) {
> >> +			pr_debug("MSC.%u: unknown interface type\n", tbl_msc->identifier);
> >> +			continue;
> >> +		}
> >> +
> >> +		next_res = 0;
> >> +		next_prop = 0;
> >> +		memset(res, 0, sizeof(res));
> >> +		memset(props, 0, sizeof(props));
> >> +
> >> +		pdev = platform_device_alloc("mpam_msc", tbl_msc->identifier);  
> > 
> > https://lore.kernel.org/all/20241009124120.1124-13-shiju.jose@huawei.com/
> > was a proposal to add a DEFINE_FREE() to clean these up.  Might be worth a revisit.
> > Then Greg was against the use it was put to and asking for an example of where
> > it helped.  Maybe this is that example.
> > 
> > If you do want to do that, I'd factor out a bunch of the stuff here as a helper
> > so we can have the clean ownership pass of a return_ptr().  
> > Similar to what Shiju did here (this is the usecase for platform device that
> > Greg didn't like).
> > https://lore.kernel.org/all/20241009124120.1124-14-shiju.jose@huawei.com/
> > 
> > Even without that I think factoring some of this out and hence being able to
> > do returns on errors and put the if (err) into the loop would be a nice
> > improvement to readability.  
> 
> If you think its more readable I'll structure it like that.

The refactor yes. I'd keep clear of the the DEFINE_FREE() unless you have
some spare time ;)
> 
> 
> >> +		if (!pdev) {
> >> +			err = -ENOMEM;
> >> +			break;
> >> +		}

> >> +int acpi_mpam_count_msc(void)
> >> +{
> >> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
> >> +	char *table_end, *table_offset = (char *)(table + 1);
> >> +	struct acpi_mpam_msc_node *tbl_msc;
> >> +	int count = 0;
> >> +
> >> +	if (IS_ERR(table))
> >> +		return 0;
> >> +
> >> +	if (table->revision < 1)
> >> +		return 0;
> >> +
> >> +	table_end = (char *)table + table->length;  
> 
> > Trivial so feel free to ignore.
> > Perhaps should aim for consistency.  Whilst I prefer pointers for this stuff
> > PPTT did use unsigned longs.  
> 
> I prefer the pointers, and as it's a separate file, I don't think it needs to be
> concistent with PPTT.

Fair enough.  Maybe PPTT is ripe for some cleanup once you are done messing with it.
I'm certainly going to add churn now.

J

