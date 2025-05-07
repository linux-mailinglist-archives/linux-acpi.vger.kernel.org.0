Return-Path: <linux-acpi+bounces-13567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B06DAADDC3
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C6D1B635D5
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECC9257AC8;
	Wed,  7 May 2025 11:52:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1492C221708;
	Wed,  7 May 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618745; cv=none; b=nJUWV+jSehYuRLAKDVDeKE40wtZrd9x1M2X2P80BHrjAFMTXnIGJbu8/QZl6SKVZUp9uyht1ZD5OzDKPKa7NQos0ZPtFg3QsnQ9tvfFsftbTATlNAEEjOJYMCwLYs6rUuD4dQiD729o3s90ljyOycGZVTAb5nm/fet+OHbUFBvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618745; c=relaxed/simple;
	bh=90aNRTSOUW+xT8ZY/1wC1MROhUycuPqVXBNl3mNVigA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEXEq1CblWo0M7Ve5UHJ7xShctxT4CIV+x6bwAcELjQJ06ptR7z2KfDSOQ+eJaAQZoZT5TSrruiNeKugLOodJvHcL2jiAK9XjaY3aBYw5PoOTZ7GOdtY593cT8e/3P8j2z2Aw3zpC4JX71X2q1LXvqoCMMLjl4YWZmf4Tpt+M4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DFF0339;
	Wed,  7 May 2025 04:52:13 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3C123F5A1;
	Wed,  7 May 2025 04:52:21 -0700 (PDT)
Date: Wed, 7 May 2025 12:52:18 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
Message-ID: <20250507-mysterious-emu-of-fertility-951c69@sudeepholla>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
 <20250506-dialog-57th-c4e70064@mheyne-amazon>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506-dialog-57th-c4e70064@mheyne-amazon>

On Tue, May 06, 2025 at 08:08:47PM +0000, Heyne, Maximilian wrote:
> On Tue, May 06, 2025 at 02:43:39PM +0100, Sudeep Holla wrote:
> > On Tue, May 06, 2025 at 01:13:02PM +0000, Heyne, Maximilian wrote:
> > > Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of
> > > sizeof() calls") corrects the processer entry size but unmasked a longer
> > > standing bug where the last entry in the structure can get skipped due
> > > to an off-by-one mistake if the last entry ends exactly at the end of
> > > the ACPI subtable.
> > >
> > 
> > Unless the firmware has populated an incorrect value for the header length, I
> > don't see how this is possible. The table_end should point to the address
> > immediately following the last byte of the table. None of the headers are only
> > one byte long, so what am I missing that could explain this apparent
> > off-by-one issue?.
> > 
> > -- 
> > Regards,
> > Sudeep
> 
> Maybe calling it off-by-one is not very exact. You're right table_end
> points to the address following the last byte *but*
>   (unsigned long)entry + proc_sz
> also points to this very byte if it's the last entry. And in this case
> the while condition is not taken which means we're ignoring the last
> processor node.
> 
> For example, in our specific case the table has a length of 0xCBE and
> the last processor node entry is at 0xCAA with a length of 0x14 fitting
> exactly into the table but 0xCAA + 0x14 == 0xCBE which turns the
> condition false.
> 

Just to understand, this node is absolutely processor node with no
private resources ? I find it hard to trust this as most of the CPUs
do have L1 I&D caches. If they were present the table can't abruptly end
like this.

-- 
Regards,
Sudeep

