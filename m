Return-Path: <linux-acpi+bounces-13565-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F521AADDAF
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD02717499D
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 11:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AE220D51E;
	Wed,  7 May 2025 11:47:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761BB202C2D
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618465; cv=none; b=eW1N78bhTLQWj2LyZ9hU1kNbgDcUc02fXhipUl/Iuc/syqHGlBTXPCKpqYGZrKWaN2L9oog/uSd4PL+bthTVH4520tPQN8ZqDoGFcg9zsYy4DSmL27eW23JzUg6kmQjpzC1xglihdt/5CrU0Iq126NTQ+e8+2KYHI37HQ1UYX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618465; c=relaxed/simple;
	bh=rr3jTZiZpFyzL+DdJCqb2xgNE2CJKOacb2jFTrw4DXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YA5X4lCJRq5Ip7gQJ1JH4tWCFMG4DOpzYa5vMgvFnh4ryHH5B/3Nz3ioI3IwGvFqn8SVLqTBrj2etVpWKPDSS6H6XktH9aWQyS+swCMinYbLOsKYXHElB/K5GsBPP4A9gIaGXGocu51zoq/TmxdQNdK0ut0MIq1lQmpncCCTwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A42E8339;
	Wed,  7 May 2025 04:47:32 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCD4C3F58B;
	Wed,  7 May 2025 04:47:40 -0700 (PDT)
Date: Wed, 7 May 2025 12:47:37 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Yicong Yang <yangyicong@huawei.com>, lenb@kernel.org,
	linux-acpi@vger.kernel.org, jmeurin@google.com,
	jeremy.linton@arm.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, prime.zeng@hisilicon.com,
	yangyicong@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH] ACPI: PPTT: Fix table length check when parsing
 processor nodes
Message-ID: <20250507-venomous-feathered-skink-77ea16@sudeepholla>
References: <20250507035124.28071-1-yangyicong@huawei.com>
 <20250507-devout-mysterious-jackal-e50e00@sudeepholla>
 <CAJZ5v0iWJQnwamT0mP=A_wtAbRkguhxcvbMnm+b2chAET7=sGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iWJQnwamT0mP=A_wtAbRkguhxcvbMnm+b2chAET7=sGA@mail.gmail.com>

On Wed, May 07, 2025 at 01:44:26PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 7, 2025 at 1:40 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, May 07, 2025 at 11:51:24AM +0800, Yicong Yang wrote:
> > > From: Yicong Yang <yangyicong@hisilicon.com>
> > >
> > > Below error is met on my board and QEMU VM on SMT or non-SMT machine:
> > >   ACPI PPTT: PPTT table found, but unable to locate core 31 (31)
> > >
> > > This is because the processor node is found by iterating the PPTT
> > > table under condition (for both acpi_find_processor_node() and
> > > acpi_pptt_leaf_node()):
> > >   while (entry + proc_sz < table_end)
> > >     [parse the processor node]
> > >
> > > If the last processor node is happened to be the last node in the
> > > PPTT table, above condition will always be false since
> > > entry + proc_sz == table_end. Thus the last CPU is not parsed.
> > > Fix the loop condition to resolve the issue.
> > >
> > > This issue is exposed by [1] but the root cause is explained above.
> > > Before [1] entry + proc_sz is always smaller than table_end.
> > >
> >
> > Another thread [1]  with similar patch.
> 
> OK, so is this a correct fix?

While it may fix the issue on the surface, I just want to be sure there
are no other issues with the PPTT table presented from the firmware.
I will asked some questions on that thread before I can agree on the solution.

-- 
Regards,
Sudeep

