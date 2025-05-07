Return-Path: <linux-acpi+bounces-13601-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D97EAAE699
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 18:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1720A166AF0
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948CB28A721;
	Wed,  7 May 2025 16:28:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD00201266;
	Wed,  7 May 2025 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635292; cv=none; b=JiherpGZVXXsGjeP8XIKlHcuGKpIy5m1oV2FD3x5X+N5Q2iVgwLvBZqAH1WyOYQ59Pe9wtGKEpQIzcly/uTX2uxtHEaQE+YDXyEY4FwSBHOt+KoGBIifZ/LQKzoAM9dNShVMctJLHXOVWj9yPPHn+r0Y6OTiwA/XEa1XJSrGtvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635292; c=relaxed/simple;
	bh=edzU15Jt8wElkbfJIpferdW3vr+KIsFtfhHHB4ZQqYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUvFjYHvJL7pXD+KrspXgPmymuvvnMbxiBd9g5062fz+AmsWSDdZT5slYvbaVTy76rMEOb24YMBkPOlaUWzXid1Nv8LoMH7S4yKyB2zmppDUPjzjlY4g24DTS/CdUENFx4mK5At8LbkCtbQUcr+cAOD4w8OtN8eEqbhPPjo6PRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B070D16F2;
	Wed,  7 May 2025 09:27:59 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F4E53F58B;
	Wed,  7 May 2025 09:28:07 -0700 (PDT)
Date: Wed, 7 May 2025 17:28:05 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	"Heyne, Maximilian" <mheyne@amazon.de>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
Message-ID: <20250507-aromatic-wooden-leopard-ad23e0@sudeepholla>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <214c2a2d-e0ea-4ec6-9925-05e39319e813@arm.com>
 <CAJZ5v0jvWXDQQ++4wmWJ+i=jds+MZ68bRB9+26WM4tAPHFxALw@mail.gmail.com>
 <1911d3b6-f328-40a6-aa03-cde3d79554de@arm.com>
 <CAJZ5v0ii9HLfqfgcp=1qRRX6M1yThf7ZPNkSLVc5GGFhv=N-Lg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ii9HLfqfgcp=1qRRX6M1yThf7ZPNkSLVc5GGFhv=N-Lg@mail.gmail.com>

On Wed, May 07, 2025 at 06:12:40PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 7, 2025 at 5:51 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
> >

[...]
> > So if the bug being fixed is that the length check is validating that
> > the table length is less than the data in the table, that's still a
> > problem because its only validating the processor node without resources.
> 
> Admittedly, it is not my code, but I understand this check as a
> termination condition for the loop: If there's not enough space in the
> table to hold a thing that I'm looking for, I may as well bail out.
> 
> > AKA the return is still potentially returning a pointer to a structure
> > which may not be entirely contained in the table.
> 
> Right, but this check should be made anyway before comparing
> cpu_node->parent to node_entry, when it is known to be a CPU entry
> because otherwise why bother.
> 
> Roughly something like this:
> 
> proc_sz = sizeof(struct acpi_pptt_processor);
> 
> while ((unsigned long)entry + entry->length <= table_end) {

Yes, but in the last/termination run of the loop, entry will be > table_end,
is it safe to access entry->length in that case. That's the point
I was trying to make when I mentioned it is risky to use entry->length
in this check. That location(outside of PPTT) might have a value that may
result in entering the loop. We need to make sure the entry + offset(length)
is within the table_end to access it.

-- 
Regards,
Sudeep

