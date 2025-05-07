Return-Path: <linux-acpi+bounces-13596-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2D4AAE54A
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 17:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA83E9A7C53
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0E228C016;
	Wed,  7 May 2025 15:47:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A41B28C010;
	Wed,  7 May 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632837; cv=none; b=qelrjfptRpV/xYl0OlhhI9aE2tXB7V8dm4LA3LFWpwrjfaYo8EA3e8rndS9ACwGVOCaY6ww727D3B4zm3RGa0wWRt58YxobAj+LXZl+P42llpXYvfnNA7AMnm2IlkdulDwCIi4ezbq9mVCVvLZ3RW8mct94reFP5IS5T2zgeXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632837; c=relaxed/simple;
	bh=w2kApnDbGDviYWYaQBt9Zg0Aa/bp4BdPTRzMtx55rus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFWzmoOBYrYMAoGbjBwTJ31DVX/022WmaeNX3Le8kHYYoXcxIi3rf1NBIu9hHlbNWSs52L6x4yWOsMtNmuFjRgMYDgkVgGwot+13HR82Y4gRk5bSSandzw/Wonzgis/MOPosoJvCjQX+rtBoM0/1MwJCbqJsEQMlx/2mqkHdNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D26102008;
	Wed,  7 May 2025 08:47:04 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F9523F778;
	Wed,  7 May 2025 08:47:13 -0700 (PDT)
Date: Wed, 7 May 2025 16:47:10 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Heyne, Maximilian" <mheyne@amazon.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
Message-ID: <20250507-tasteful-wren-of-devotion-f010af@sudeepholla>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <214c2a2d-e0ea-4ec6-9925-05e39319e813@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <214c2a2d-e0ea-4ec6-9925-05e39319e813@arm.com>

On Wed, May 07, 2025 at 10:25:25AM -0500, Jeremy Linton wrote:
> Hi,
> 
> On 5/6/25 8:13 AM, Heyne, Maximilian wrote:
> > Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of
> > sizeof() calls") corrects the processer entry size but unmasked a longer
> > standing bug where the last entry in the structure can get skipped due
> > to an off-by-one mistake if the last entry ends exactly at the end of
> > the ACPI subtable.
> > 
> > The error manifests for instance on EC2 Graviton Metal instances with
> > 
> >    ACPI PPTT: PPTT table found, but unable to locate core 63 (63)
> >    [...]
> >    ACPI: SPE must be homogeneous
> > 
> > Fixes: 2bd00bcd73e5 ("ACPI/PPTT: Add Processor Properties Topology Table parsing")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> > ---
> >   drivers/acpi/pptt.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> > index f73ce6e13065d..4364da90902e5 100644
> > --- a/drivers/acpi/pptt.c
> > +++ b/drivers/acpi/pptt.c
> > @@ -231,7 +231,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
> >   			     sizeof(struct acpi_table_pptt));
> >   	proc_sz = sizeof(struct acpi_pptt_processor);
> 
> This isn't really right, it should be struct acpi_subtable_header, then once
> the header is safe, pull the length from it.
> 

Ah OK. Sorry I wasn't able to understand your point earlier. I get it now.

But just for sake of argument here, accessing entry->length before
doing some sanity check is also risky. So ideally we should be checking
if entry + entry->length <= table_end right ?

> But then, really if we are trying to fix the original bug that the table
> could be shorter than the data in it suggests, the struct
> acpi_pptt_processor length plus its resources needs to be checked once the
> subtype is known to be a processor node.
> 

Indeed.

> Otherwise the original sizeof * change isn't really fixing anything.
> 

How about extending the check for entry->length ? Do you think it will
be any better ? The entry pointer is anyway updated to jump entry->length
ahead at the end of the loop.

Regards,
Sudeep

-->8

@@ -276,7 +276,7 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
        while ((unsigned long)entry + proc_sz <= table_end) {
                cpu_node = (struct acpi_pptt_processor *)entry;

-               if (entry->length == 0) {
+               if (!entry->length || entry->length < proc_sz) {
                        pr_warn("Invalid zero length subtable\n");
                        break;
                }




