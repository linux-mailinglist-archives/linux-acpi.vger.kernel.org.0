Return-Path: <linux-acpi+bounces-11886-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94508A54661
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 10:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD11B1721B5
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053902080C5;
	Thu,  6 Mar 2025 09:31:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A26F201270;
	Thu,  6 Mar 2025 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253518; cv=none; b=XNCA9nPzWZ+7SMEiVdx4LswXTb0B9xUcRWzyxjuN88VEkZaYSTKYnjQkk2EWscVxwPVi87LWcayO0eFNarCZf67JktcP32mG1y+/UTqiTO8I4YgwJclF6pDExnuO2BObKSSWeYQLWtGsBnJOzZXZRm8d5FL4exiPChv7S1rTZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253518; c=relaxed/simple;
	bh=zU7pYtEsrKBjmyhSdvtjjV3yw8jWlxYS0uX4y/6HHoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXFFeu6OhHWvyOBfFInzkl1EEcreNAHT3DyA4v9WQjikD2LXD3RD/xhIa3kq1UPfhlYtflPo85lfLObwPLGN8h7IVS9jwbpt8rTvp6S+PkR/xuwqMlMVyh/2sCuSOKO+ReZF8lKXXyla4t2XCwj9XNsqjvL2Mev8sF0j+6AGnuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B1CAFEC;
	Thu,  6 Mar 2025 01:32:09 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35B943F673;
	Thu,  6 Mar 2025 01:31:55 -0800 (PST)
Date: Thu, 6 Mar 2025 09:31:52 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: Re: [PATCH 10/14] soc: hisilicon: kunpeng_hccs: Simplify PCC shared
 memory region handling
Message-ID: <Z8lriBJQyk-8eOZ_@bogus>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-10-3b44f3d134b1@arm.com>
 <1e7560ab-2545-843a-e42a-2d37f6b7ef93@huawei.com>
 <20250305113426.bt2lebp2rfyngcpl@bogus>
 <9eb0cd8b-00aa-e304-5b10-850c41b0c0c4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eb0cd8b-00aa-e304-5b10-850c41b0c0c4@huawei.com>

On Thu, Mar 06, 2025 at 11:55:41AM +0800, lihuisong (C) wrote:
> 
> 在 2025/3/5 19:34, Sudeep Holla 写道:
> > On Wed, Mar 05, 2025 at 03:14:50PM +0800, lihuisong (C) wrote:
> > > 在 2025/3/3 18:51, Sudeep Holla 写道:
> > > > The PCC driver now handles mapping and unmapping of shared memory
> > > > areas as part of pcc_mbox_{request,free}_channel(). Without these before,
> > > > this Kunpeng HCCS driver did handling of those mappings like several
> > > > other PCC mailbox client drivers.
> > > > 
> > > > There were redundant operations, leading to unnecessary code. Maintaining
> > > > the consistency across these driver was harder due to scattered handling
> > > > of shmem.
> > > > 
> > > > Just use the mapped shmem and remove all redundant operations from this
> > > > driver.
> > > > 
> > > > Cc: Huisong Li <lihuisong@huawei.com>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > With belows to change,
> > > Reviewed-by: Huisong Li <lihuisong@huawei.com>
> > Thanks!
> > 
> > [...]
> > 
> > > > -	if (!pcc_chan->shmem_base_addr ||
> > > > -	    pcc_chan->shmem_size != HCCS_PCC_SHARE_MEM_BYTES) {
> > > > +	if (pcc_chan->shmem_size != HCCS_PCC_SHARE_MEM_BYTES) {
> > > >    		dev_err(dev, "The base address or size (%llu) of PCC communication region is invalid.\n",
> > > >    			pcc_chan->shmem_size);
> > > Now the check of shared base address is not here. The log about this address
> > > no need to be printed.
> > > 
> > > Can you help me fix it like:
> > > 
> > > dev_err(dev, "The base size (%llu) of PCC communication region must be %d Byte.\n",
> > >   			pcc_chan->shmem_size, HCCS_PCC_SHARE_MEM_BYTES
> > > );
> > Sure.
> > 
> > Did you get a chance to validate this driver and any other users of PCC
> > on your platform with these changes + the error handling fix you pointed
> > out ? That would be very useful as I don't have any set up to test.
> Sure, I'll test this series.
> >

I have posted v2 [1] with your feedback incorporated. Please use the same.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/r/20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com

