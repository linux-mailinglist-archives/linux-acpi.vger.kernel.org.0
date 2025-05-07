Return-Path: <linux-acpi+bounces-13594-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306BEAAE4E9
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 17:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355B13AE327
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7053A1F2C3B;
	Wed,  7 May 2025 15:35:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B356748D
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632122; cv=none; b=i6ZSwTIQiytJ3O9lVZv2hhk1/UrkRl2ukWjHMnlTv4UZINX4JlSKCxhkeA7njs6OfHvPDZcUdNS0SWocJ2ddWsHBdN+lolLmrUu7lCj74y4dNNzhgSUqPTC2zenuC2ZxaZYLt98b7leUYfdesz2xbmUWyG2BYRc4FuBWOv5gccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632122; c=relaxed/simple;
	bh=ySxCuKnG+VU7PXW4i5MC3ZwUovzp1SBfv4mpjbzgKCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTt92yz7+cwPObqm7PjUJms/R68Lm90Uzt5wUxqU5DUY8OCzai7T4HYHzNkFYbAgdSnUK1YDGU/OQAlZdPFSLGu+7A+gNKlCdTcEGYAXcyVNVPCmz+A7Pza1Tj2l2Jxk/bP+g1D9HtK08KVabx3lEtVK8Z4ISVISk/MV1Iw4S2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FCA7339;
	Wed,  7 May 2025 08:35:07 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63F333F58B;
	Wed,  7 May 2025 08:35:15 -0700 (PDT)
Date: Wed, 7 May 2025 16:35:12 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Yicong Yang <yangyicong@huawei.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <jmeurin@google.com>,
	<jeremy.linton@arm.com>, <zhanjie9@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <yangyicong@hisilicon.com>,
	<linuxarm@huawei.com>, <alireza.sanaee@huawei.com>
Subject: Re: [PATCH] ACPI: PPTT: Fix table length check when parsing
 processor nodes
Message-ID: <20250507-melodic-helpful-pudu-7ad0f2@sudeepholla>
References: <20250507035124.28071-1-yangyicong@huawei.com>
 <20250507-devout-mysterious-jackal-e50e00@sudeepholla>
 <CAJZ5v0iWJQnwamT0mP=A_wtAbRkguhxcvbMnm+b2chAET7=sGA@mail.gmail.com>
 <20250507-venomous-feathered-skink-77ea16@sudeepholla>
 <CAJZ5v0hyxCE3NWcCgKkut2_pJGO-Pyt27GdhMK0ZUZ-MJ6dudQ@mail.gmail.com>
 <20250507-obedient-knowing-galago-245e7c@sudeepholla>
 <20250507153550.0000340f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507153550.0000340f@huawei.com>

On Wed, May 07, 2025 at 03:35:50PM +0100, Jonathan Cameron wrote:
> On Wed, 7 May 2025 12:55:00 +0100
> Sudeep Holla <sudeep.holla@arm.com> wrote:
> 

[...]

> > 
> > Indeed and also we should have private resources like L1 cache described
> > after the initial 20 bytes of the node. So I am bit worried if this will
> > just hide other problems while it may solve this problem by looks of it.
> > This example doesn't look like a proper PPTT matching real systems.
> > 
> 
> Assuming I'm understanding the bug correctly...
> 
> SMT systems will hit this. There will typically be no private resources
> for a thread as the L1I/D shared by multiple threads (which are processor
> nodes IIRC).  Note we are trying to improve the cache description in QEMU
> at the moment as it would definitely be better to present caches in PPTT,
> but that isn't the main issue here.
> 

Indeed, I just replied in the other thread that I clearly missed SMT.

-- 
Regards,
Sudeep

