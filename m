Return-Path: <linux-acpi+bounces-13578-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EBCAADFE4
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 14:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED623B675D
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BB728151E;
	Wed,  7 May 2025 12:57:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929D8221730;
	Wed,  7 May 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622620; cv=none; b=TFfpTIhMRAmIXWXGQXYYzP/CUv23a0+nTKGGbH+373XpNSfSJpG9of2n5veHDAPmR5VRUukVPAcLsuUW3tRoxZJUY/QyJEU2LqVSUMnUZI15m70/eNsnm2AcNA0xil7ZIATMZhdAeNzi/gzOWp3QlL/bYeLS1SFoZCu58TAiXe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622620; c=relaxed/simple;
	bh=iG0+dHhwPB3yH7dz5m/x4QeUilQ8cbP9CurzUJjTEdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0QAp7aLwu7f2ee9HP0HPtLO8sD0dUQ9Gqb8Ngp7DvwDreusxKB0CLDWYZsuCwG4CyBXMsSdPDdHbBnMYY+I1kA1OlX9oZmWX8np78DrWYM1SySZQq5JmYG6o11UByNondtTuQd3MMCGUgmSBFvfeZOq0H3vQzkDjD1rDa++2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDC65339;
	Wed,  7 May 2025 05:56:47 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F11B3F58B;
	Wed,  7 May 2025 05:56:56 -0700 (PDT)
Date: Wed, 7 May 2025 13:56:53 +0100
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
Message-ID: <20250507-divergent-lori-from-pluto-71daee@sudeepholla>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
 <20250506-dialog-57th-c4e70064@mheyne-amazon>
 <20250507-mysterious-emu-of-fertility-951c69@sudeepholla>
 <20250507-blend-revel-3d94099b@mheyne-amazon>
 <20250507-quantum-solid-ibex-218f1b@sudeepholla>
 <20250507-autumn-phrase-4a1eddef@mheyne-amazon>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-autumn-phrase-4a1eddef@mheyne-amazon>

On Wed, May 07, 2025 at 12:42:14PM +0000, Heyne, Maximilian wrote:
> On Wed, May 07, 2025 at 01:30:53PM +0100, Sudeep Holla wrote:
> > On Wed, May 07, 2025 at 11:56:48AM +0000, Heyne, Maximilian wrote:
> > > On Wed, May 07, 2025 at 12:52:18PM +0100, Sudeep Holla wrote:
> > > > 
> > > > Just to understand, this node is absolutely processor node with no
> > > > private resources ? I find it hard to trust this as most of the CPUs
> > > > do have L1 I&D caches. If they were present the table can't abruptly end
> > > > like this.
> > > 
> > > Yes looks like it. In our case the ACPI subtable has length 0x14 which is
> > > exactly sizeof(acpi_pptt_processor).
> > > 
> > 
> > OK, this seem like it is emulated platform with no private resources as
> > it is specified in the other similar patch clearly(QEMU/VM). So this
> > doesn't match real platforms. Your PPTT is wrong if it is real hardware
> > platform as you must have private resources.
> > 
> > Anyways if we allow emulation to present CPUs without private resources
> > we may have to consider allowing this as the computed pointer will match
> > the table end.
> 
> Is there a need by the ACPI specification that the Cache information
> must come after the processor information? Because on our platform there
> is Cache and it's described but at a different location seemingly. It
> looks like caches are described first and then the CPUs.
>

That is fine but you must have reference to those caches in the processor
node and the length of the node won't be 0x14 in that case and you shouldn't
hit this issue. So if this is real platform, then yes I am must say you
PPTT is wrong especially if there are caches in the table as you say just
that processor nodes are not pointing to them correctly then ?

> I can try to drill even deeper here if you insist. As said I'm no
> subject matter expert here. But is there something obviously wrong with
> my patch or would it be ok to just take it?
>

Yes you much check your PPTT if it is real hardware platform. I am OK
with the change in terms of QEMU or VM. You may need to reword commit
message a bit. I will respond separately.

-- 
Regards,
Sudeep

