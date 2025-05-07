Return-Path: <linux-acpi+bounces-13587-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 947FBAAE405
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 17:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C13987675
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F1C289E3E;
	Wed,  7 May 2025 15:12:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B86280325;
	Wed,  7 May 2025 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630749; cv=none; b=UdJRiShh+521Gr3KssbTeGUk5BbSTrGXuXmE3sWKI1ahI3Q6gQQQqksqbV7KhVFXE0aeozDKDjR3wfDXrIM0IJiyvfNmxWxMYDXMFZgqZfW6FmGWy1xQ3Hfspv4dIsxrL8I7cBfZeXftDELLGejz51eBQhyO/VdM9YkRrUovsTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630749; c=relaxed/simple;
	bh=AO4d0aQ0NxeQWXjmRYoCiD1HqBivQ1em8dNKjTse1U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjzfH1/uXQuYhvr2meOriYbBUKY+LofZwrcB9uqRscaQx8VGRmxq66dQM9AJH+z3AvWdoaYARE5ZBLa8vgBmSGcA0Bzol2bKaha5I2KTRvZypxVEXtR4L1WIw1AAJ1pvLjcC6Nlfs3A+cykW7mrgr8BZ6tf4R85baMusS7ziRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C12CF339;
	Wed,  7 May 2025 08:12:16 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17CB93F58B;
	Wed,  7 May 2025 08:12:24 -0700 (PDT)
Date: Wed, 7 May 2025 16:12:22 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
Message-ID: <20250507-singing-shrewd-stallion-ee2481@sudeepholla>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
 <20250506-dialog-57th-c4e70064@mheyne-amazon>
 <20250507-mysterious-emu-of-fertility-951c69@sudeepholla>
 <20250507-blend-revel-3d94099b@mheyne-amazon>
 <20250507-quantum-solid-ibex-218f1b@sudeepholla>
 <20250507-autumn-phrase-4a1eddef@mheyne-amazon>
 <20250507-divergent-lori-from-pluto-71daee@sudeepholla>
 <20250507-petit-capri-debaa30d@mheyne-amazon>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-petit-capri-debaa30d@mheyne-amazon>

On Wed, May 07, 2025 at 02:29:17PM +0000, Heyne, Maximilian wrote:
> On Wed, May 07, 2025 at 01:56:53PM +0100, Sudeep Holla wrote:
> > 
> > That is fine but you must have reference to those caches in the processor
> > node and the length of the node won't be 0x14 in that case and you shouldn't
> > hit this issue. So if this is real platform, then yes I am must say you
> > PPTT is wrong especially if there are caches in the table as you say just
> > that processor nodes are not pointing to them correctly then ?
> 
> The ACPI tables in our case describe a core first which references the
> cache as private resource and then a thread whose parent is the core but
> this doesn't have a private resource. This is how it looks like:
> 

Ah, right I clearly missed considering multithreaded systems in my mind.
I think SMTs processor nodes might have no private resource which I didn't
consider before. However, your example made me open the spec and read about
SMT and PPTT. There are couple of things I still don't follow below.

> [C8Eh 3214   1]                Subtable Type : 00 [Processor Hierarchy Node]
> [C8Fh 3215   1]                       Length : 1C
> [C90h 3216   2]                     Reserved : 0000
> [C92h 3218   4]        Flags (decoded below) : 00000002
>                             Physical package : 0
>                      ACPI Processor ID valid : 1
>                        Processor is a thread : 0
>                               Node is a leaf : 0
>                     Identical Implementation : 0
> [C96h 3222   4]                       Parent : 000000A2
> [C9Ah 3226   4]            ACPI Processor ID : 0000003F
> [C9Eh 3230   4]      Private Resource Number : 00000002
> [CA2h 3234   4]             Private Resource : 00000072
> [CA6h 3238   4]             Private Resource : 0000008A
>

Does the above node represent the container node for the threads within
the core ? I assumes so.

> [CAAh 3242   1]                Subtable Type : 00 [Processor Hierarchy Node]
> [CABh 3243   1]                       Length : 14
> [CACh 3244   2]                     Reserved : 0000
> [CAEh 3246   4]        Flags (decoded below) : 0000000E
>                             Physical package : 0
>                      ACPI Processor ID valid : 1
>                        Processor is a thread : 1
>                               Node is a leaf : 1
>                     Identical Implementation : 0
> [CB2h 3250   4]                       Parent : 00000C8E
> [CB6h 3254   4]            ACPI Processor ID : 0000003F
> [CBAh 3258   4]      Private Resource Number : 00000000
> 

Is this the only thread as you mentioned the table ends here ? So it
is single threaded core ? Just working what is the point in representing
it in this way ? Also the ACPI Processor ID is unique, so I hope you have
same number of container nodes as the threads. IOW, they ACPI Processor ID
for the thread and the container node match only because it is single
threaded core.

-- 
Regards,
Sudeep

