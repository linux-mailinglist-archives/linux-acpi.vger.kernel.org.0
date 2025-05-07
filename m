Return-Path: <linux-acpi+bounces-13573-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DA3AADF43
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 14:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB413BDA0B
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 12:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA3D27A103;
	Wed,  7 May 2025 12:31:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C65127A903;
	Wed,  7 May 2025 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621061; cv=none; b=mm12bmMWrpD7mSLcwGlCqd+AaLiQEJXKu4dX9aYwfD+cwGYaIzy2tm8UytoBv3grf2M6wwFn+zmBFgKjibjvZhidp6LhC5PC6IQOzPy6DLHMY5sgEhdzPcy9Usr90SFGMEWPMvErXGKu6zBGHxhMgZYe/eB76HI8Cb1B9uKMIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621061; c=relaxed/simple;
	bh=SleT5/BAn/e5UeFcDh3WoEYF9U4020jEl1LzxogJCSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLQr6uIMZbCv24oglr7ryyATn2tr7LVmZJeQr5ehA8bw8bf69pfjz1OnC1YuHyyGNWsltElYFbvEOQiM1Tz0J8EyycRYk0g31NfUvkntLS8CJtoj4JX3BJbXp6ZdntZ2d4bGaKdArSqg9400Thu3d4elobQoTrm7DnlHq2C/c9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DC32339;
	Wed,  7 May 2025 05:30:48 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D828E3F5A1;
	Wed,  7 May 2025 05:30:56 -0700 (PDT)
Date: Wed, 7 May 2025 13:30:53 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
Message-ID: <20250507-quantum-solid-ibex-218f1b@sudeepholla>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
 <20250506-dialog-57th-c4e70064@mheyne-amazon>
 <20250507-mysterious-emu-of-fertility-951c69@sudeepholla>
 <20250507-blend-revel-3d94099b@mheyne-amazon>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-blend-revel-3d94099b@mheyne-amazon>

On Wed, May 07, 2025 at 11:56:48AM +0000, Heyne, Maximilian wrote:
> On Wed, May 07, 2025 at 12:52:18PM +0100, Sudeep Holla wrote:
> > 
> > Just to understand, this node is absolutely processor node with no
> > private resources ? I find it hard to trust this as most of the CPUs
> > do have L1 I&D caches. If they were present the table can't abruptly end
> > like this.
> 
> Yes looks like it. In our case the ACPI subtable has length 0x14 which is
> exactly sizeof(acpi_pptt_processor).
> 

OK, this seem like it is emulated platform with no private resources as
it is specified in the other similar patch clearly(QEMU/VM). So this
doesn't match real platforms. Your PPTT is wrong if it is real hardware
platform as you must have private resources.

Anyways if we allow emulation to present CPUs without private resources
we may have to consider allowing this as the computed pointer will match
the table end.

Rafael,

If it is OK for QEMU to present cacheless CPUs, then we need to allow
this logic. What do you think ?

-- 
Regards,
Sudeep

