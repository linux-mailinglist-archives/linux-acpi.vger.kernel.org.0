Return-Path: <linux-acpi+bounces-13579-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A595AADFFA
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 15:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18C04A32D6
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEE578F2B;
	Wed,  7 May 2025 13:01:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EEA2F44;
	Wed,  7 May 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622902; cv=none; b=uSAnZDQ2pQA28d2kNsI6Akn8wLgGX+iQSRRBXasCbNjnfas/c6pcwtqVTJMS2kFh/IXU1OLOZ0HBBmb7yMRtTsleykXMk8+5Tnl9ZD8QfTkXW3nm3CWQ8lcX2k4DNp8Heh1wcXvqeOyGFjuDs1JZhVv+sMYjRpyzrLSkrdx8N4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622902; c=relaxed/simple;
	bh=UhHxnwaQ7h0U4CBwveQvFF89cjUlLozsSXZdvrGgtXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVPjkXontUon852D4Yh1l+cdP1+pmE5qCmGXG3VNednr6jPBz4mKEYyD6DOyWliQoEUrUabrA9/buAAw0s+8lbE3uuxmW/86pv25BqlS/+CMcq/SErkZZmd3tpb+vo0j4Nw3rdbxyiq7/oTAagl8VklR/QKtR4IOzgyjINiPy4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50FE0339;
	Wed,  7 May 2025 06:01:29 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7D833F58B;
	Wed,  7 May 2025 06:01:37 -0700 (PDT)
Date: Wed, 7 May 2025 14:01:34 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
Message-ID: <20250507-sly-skilled-muskox-80b9a4@sudeepholla>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
 <20250506-dialog-57th-c4e70064@mheyne-amazon>
 <20250507-mysterious-emu-of-fertility-951c69@sudeepholla>
 <20250507-blend-revel-3d94099b@mheyne-amazon>
 <20250507-quantum-solid-ibex-218f1b@sudeepholla>
 <20250507-autumn-phrase-4a1eddef@mheyne-amazon>
 <CAJZ5v0jawX-4QaZG56DK6Urxrh1DMEGi7jKhm=pE1YAwUXBUqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jawX-4QaZG56DK6Urxrh1DMEGi7jKhm=pE1YAwUXBUqg@mail.gmail.com>

On Wed, May 07, 2025 at 02:50:41PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 7, 2025 at 2:42 PM Heyne, Maximilian <mheyne@amazon.de> wrote:
> >
> > On Wed, May 07, 2025 at 01:30:53PM +0100, Sudeep Holla wrote:
> > > On Wed, May 07, 2025 at 11:56:48AM +0000, Heyne, Maximilian wrote:
> > > > On Wed, May 07, 2025 at 12:52:18PM +0100, Sudeep Holla wrote:
> > > > >
> > > > > Just to understand, this node is absolutely processor node with no
> > > > > private resources ? I find it hard to trust this as most of the CPUs
> > > > > do have L1 I&D caches. If they were present the table can't abruptly end
> > > > > like this.
> > > >
> > > > Yes looks like it. In our case the ACPI subtable has length 0x14 which is
> > > > exactly sizeof(acpi_pptt_processor).
> > > >
> > >
> > > OK, this seem like it is emulated platform with no private resources as
> > > it is specified in the other similar patch clearly(QEMU/VM). So this
> > > doesn't match real platforms. Your PPTT is wrong if it is real hardware
> > > platform as you must have private resources.
> > >
> > > Anyways if we allow emulation to present CPUs without private resources
> > > we may have to consider allowing this as the computed pointer will match
> > > the table end.
> >
> > Is there a need by the ACPI specification that the Cache information
> > must come after the processor information? Because on our platform there
> > is Cache and it's described but at a different location seemingly. It
> > looks like caches are described first and then the CPUs.
> >
> > I can try to drill even deeper here if you insist. As said I'm no
> > subject matter expert here. But is there something obviously wrong with
> > my patch or would it be ok to just take it?
> 
> The code changes are fine, but the changelog is somewhat misleading.
> 

+1, may be look at the thread here[1], it make it clear that it is in
QEMU which I missed clearly for a while. You need to emphasize the fact
that this would happen only when the processor nodes are at the end
of the PPTT and they have no private resources(which is generally the
case in emulation as Rafaek explains below.

> The problem is that the original code assumed the presence of private
> resources at the end of every CPU entry, but in practice (due to
> emulation or otherwise) there are entries without them and if such an
> entry is located at the end of the table, it will not pass the sanity
> check after commit 2bd00bcd73e5.  This issue was not evident
> previously because the code didn't work as designed.

I completely agree.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20250507035124.28071-1-yangyicong@huawei.com/

