Return-Path: <linux-acpi+bounces-14243-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4635AD1F02
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 15:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F729169ADE
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CBC258CE8;
	Mon,  9 Jun 2025 13:39:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D76A320B;
	Mon,  9 Jun 2025 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476367; cv=none; b=tx4OR/DP9NdGYsFfFbLgHTgAd5XmQqFYZbAqzffPWjU2orRdvNLvFzL9/CNC3Rx7XrJA+Nl+tV13q0R1nA/hTZwaxZAm8jzHEil6KFXSYfu+IhmQH+spTEna2gDIoCK2dNGJy6L4uls7SxL0fN+JpqzWl3S4RyiEL+CoWuHMlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476367; c=relaxed/simple;
	bh=gPk48AU13jAxLAvi85enhXQMHSUKyaTIVSCLs34IgBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYFHDB8B+ULHvL9fD1xO79r6IUeCH9PbmqE10As8ZU6EvBtgfh3ddh5Fh93RvWu2KdW2ir/gT+fobT494M3C2fzoc+MV/dZqEHL1Bkes7Q8RnCTBTJ3lCLih82Xs+0ri+95RkzGye1ENaPVcjUZdxTAQ0E63WAVQsWYomGerQ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7CFE113E;
	Mon,  9 Jun 2025 06:39:04 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C2A13F59E;
	Mon,  9 Jun 2025 06:39:21 -0700 (PDT)
Date: Mon, 9 Jun 2025 14:39:19 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: <gregkh@linuxfoundation.org>, <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] CXL: ACPI: faux: Fix cxl_core.ko module load
 regression
Message-ID: <20250609-hysterical-radiant-civet-b93fac@sudeepholla>
References: <20250607033228.1475625-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607033228.1475625-1-dan.j.williams@intel.com>

On Fri, Jun 06, 2025 at 08:32:25PM -0700, Dan Williams wrote:
> git bisect flags:
> 
> 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")
> 
> ...as the reason basic CXL unit tests are failing on latest mainline. In
> addition to the fix to einj-core.c, this also needs some updates to
> faux_device to make it behave more like platform_driver_probe(). Details
> in the individual patches.
> 

Thanks for not only reporting the issue with the commit above but also
solving it and posting patches.

They all look good to me.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

