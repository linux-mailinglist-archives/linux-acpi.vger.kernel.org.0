Return-Path: <linux-acpi+bounces-11834-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380DCA4FDBA
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 12:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCE51891FD6
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036B4245022;
	Wed,  5 Mar 2025 11:34:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FFF233709;
	Wed,  5 Mar 2025 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174473; cv=none; b=DhSluGB+1gdbDMevzhcMSF33cJmQi2IseE1G5mR3cW40116PXMAow61S9wGSrlnj0RFHrnyiEUT9wdrnV2U/+vBM0ZUcuuAarzxjTkmzbgjUqOf0IBWbR5ud4LgRlwc8QNL610GAv1SKr76kh4BYeo4726+QYrgRRzrhGaxEXLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174473; c=relaxed/simple;
	bh=CVeBM0o9l0ZM7IBmK7B6KZMclTmgW0FKADOZmS1viRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouco6AdxuXHqVQ9OACXxMgjxconG8B3FIB0uaVjShbWmUNyWWscPIjQycgNhMCLiIuAByN4gTwavmv1a04GLWaBaGVaicU3aoFczSj6NR0Rb1fy/c9f2Q2JfX4SmV3JcAomm+jCEiZaT3t0pq/WEjTfTwBr3Y8MICFkQQrjj57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48A42FEC;
	Wed,  5 Mar 2025 03:34:44 -0800 (PST)
Received: from bogus (unknown [10.57.37.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B29093F673;
	Wed,  5 Mar 2025 03:34:29 -0800 (PST)
Date: Wed, 5 Mar 2025 11:34:26 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: Re: [PATCH 10/14] soc: hisilicon: kunpeng_hccs: Simplify PCC shared
 memory region handling
Message-ID: <20250305113426.bt2lebp2rfyngcpl@bogus>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-10-3b44f3d134b1@arm.com>
 <1e7560ab-2545-843a-e42a-2d37f6b7ef93@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e7560ab-2545-843a-e42a-2d37f6b7ef93@huawei.com>

On Wed, Mar 05, 2025 at 03:14:50PM +0800, lihuisong (C) wrote:
> 
> 在 2025/3/3 18:51, Sudeep Holla 写道:
> > The PCC driver now handles mapping and unmapping of shared memory
> > areas as part of pcc_mbox_{request,free}_channel(). Without these before,
> > this Kunpeng HCCS driver did handling of those mappings like several
> > other PCC mailbox client drivers.
> > 
> > There were redundant operations, leading to unnecessary code. Maintaining
> > the consistency across these driver was harder due to scattered handling
> > of shmem.
> > 
> > Just use the mapped shmem and remove all redundant operations from this
> > driver.
> > 
> > Cc: Huisong Li <lihuisong@huawei.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> With belows to change,
> Reviewed-by: Huisong Li <lihuisong@huawei.com>

Thanks!

[...]

> > -	if (!pcc_chan->shmem_base_addr ||
> > -	    pcc_chan->shmem_size != HCCS_PCC_SHARE_MEM_BYTES) {
> > +	if (pcc_chan->shmem_size != HCCS_PCC_SHARE_MEM_BYTES) {
> >   		dev_err(dev, "The base address or size (%llu) of PCC communication region is invalid.\n",
> >   			pcc_chan->shmem_size);
> 
> Now the check of shared base address is not here. The log about this address
> no need to be printed.
> 
> Can you help me fix it like:
> 
> dev_err(dev, "The base size (%llu) of PCC communication region must be %d Byte.\n",
>  			pcc_chan->shmem_size, HCCS_PCC_SHARE_MEM_BYTES
> );

Sure.

Did you get a chance to validate this driver and any other users of PCC
on your platform with these changes + the error handling fix you pointed
out ? That would be very useful as I don't have any set up to test.

--
Regards,
Sudeep

