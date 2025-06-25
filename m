Return-Path: <linux-acpi+bounces-14580-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39906AE7AE1
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 10:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9074A0068
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD785283FCF;
	Wed, 25 Jun 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qdhhzZ/l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612F27D784;
	Wed, 25 Jun 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841542; cv=none; b=AQC1VIlVvxvfu2Pcexfrgn+FuThf+uvzbsK4ierZffe9nDEEwZ0WIVZ2hc23/5eBFhcQeYA71twqTJwpEMghk3/sY192v/giAz1SQhyshoGnqtX7xivcECqSyWt2LlcsBLVdhWd+J54jC8O7MAt7VZKoKPI4z5yzOeWrQaz2+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841542; c=relaxed/simple;
	bh=1aEymm9TW+31O+JYHnj+LSnYkKbL8stOxELJ4GSgqBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wpzw4k61dLOiJ+/+cKvsaovzNm1xnJvZ24VAhFHIuMI1dg8MHaZ3UPi90J4Z7x//+s6yfREX3UhNVgsIgSdr2YQfDq6Kg9j6mKgs6E2i3oIArTTvrTpGDZ5TWrJFJ5kFSgeNaUeqm7oGRXCPA1IBKPKccWrNTrsqn2NuDeXiZsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qdhhzZ/l; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kuB6DJokf+kOHeXrbarpBOCXQ2R6TXTfr6dB5Ad6/3o=; b=qdhhzZ/loUJj4/x5n1ZsfY53Nz
	Fntzcq+G7Y/WZyznoGpiZ7N4mKDED4CDh/WdAgmi3O+iNUt7rgLHT3tHo5gFYzOj9lYVZpAm+ZnrP
	G05fPGu8gkCAHZvkBTPR4I0oA+PUFsXB3oApC0I2V0hRhpNPY/5aMfB5xm29ewdmMfBHjM4tJbnLw
	QxfeCT0jEuuQkqMrvyWdmXRe5fVFGCMyj45ECw6qFjSmQaMeCSy45iIgODWENrFchbf8SeEcFryJY
	JJw69p01O0rNbx5o/QkCzhrKPISMe+xwHd1X/oTD9eXtsti2Bp90yL3XCAYmh7O5IOyLtZ1+D0yLZ
	oBU97CHw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uULrR-00000008vs3-11Ci;
	Wed, 25 Jun 2025 08:52:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C97B3308983; Wed, 25 Jun 2025 10:52:04 +0200 (CEST)
Date: Wed, 25 Jun 2025 10:52:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org,
	Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
	Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, H Peter Anvin <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 0/8] Cache coherency management subsystem
Message-ID: <20250625085204.GC1613200@noisy.programming.kicks-ass.net>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>

On Tue, Jun 24, 2025 at 04:47:56PM +0100, Jonathan Cameron wrote:

> On x86 there is the much loved WBINVD instruction that causes a write back
> and invalidate of all caches in the system. It is expensive but it is

Expensive is not the only problem. It actively interferes with things
like Cache-Allocation-Technology (RDT-CAT for the intel folks). Doing
WBINVD utterly destroys the cache subsystem for everybody on the
machine.

> necessary in a few corner cases. 

Don't we have things like CLFLUSH/CLFLUSHOPT/CLWB exactly so that we can
avoid doing dumb things like WBINVD ?!?

> These are cases where the contents of
> Physical Memory may change without any writes from the host. Whilst there
> are a few reasons this might happen, the one I care about here is when
> we are adding or removing mappings on CXL. So typically going from
> there being actual memory at a host Physical Address to nothing there
> (reads as zero, writes dropped) or visa-versa. 

> The
> thing that makes it very hard to handle with CPU flushes is that the
> instructions are normally VA based and not guaranteed to reach beyond
> the Point of Coherence or similar. You might be able to (ab)use
> various flush operations intended to ensure persistence memory but
> in general they don't work either.

Urgh so this. Dan, Dave, are we getting new instructions to deal with
this? I'm really not keen on having WBINVD in active use.


