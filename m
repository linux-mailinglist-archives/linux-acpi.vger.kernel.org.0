Return-Path: <linux-acpi+bounces-15210-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBECBB08A11
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 11:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC77A7BDBF8
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 09:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D902291C3A;
	Thu, 17 Jul 2025 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhvWfng3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70121288CBE;
	Thu, 17 Jul 2025 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752746283; cv=none; b=sR2zo9dYchMXQyEgGki0jvyOdDr74+yQEWWdjpwgRm4pQbHz3kXx/dpJkkV4OON6fVmoTpIBeeDaDcOh6xMAj4bpEI+B0PGxmgniEMHlwTWlqCHhc1BVzt45tsuzRhQSEvqiGXaNXZgtUjIond3RIDLoAibaAZlfSE0bueHoMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752746283; c=relaxed/simple;
	bh=UcUgBkuYffStTu9fwls0Y3+yc53zyJShMuqRpuh0m6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im6TFTLGZlQgj81EIexbybFBpSayOKRquBPTERxosSjeDt44gPPYW6f7V3UUiulGxHC/augHznRJj6v9utIeMLepmKPKbPJnO28AgCVXIw5wn73BdKKoxWKmm6RfDu5A2Lsb8vk1EL3ZSigDkvtiqS6eF3Njcg7ekXcqsjlt/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhvWfng3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46846C4CEE3;
	Thu, 17 Jul 2025 09:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752746283;
	bh=UcUgBkuYffStTu9fwls0Y3+yc53zyJShMuqRpuh0m6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhvWfng3K9WZ0rqIyPCE+c3v/AD/aq47bpEszhmoia4fLXW3W9JL1eimyr6/pUyDq
	 H1Q4N81D1NDt4X12/6FIjOxVKPvv+VYGj5n6YQ+UmSKSNSckfFH8cOCQB6csLeRMMg
	 af2a29ptpPbP2icx80CsOlWpYonOkXMUnvz5is9fjezihWGMLl22rqg8R1ivi1sZb+
	 zELsDeUScZYjFgE94OdkQRP1J27LmHVaXw1zFlx1Pvs+ytdm+WkuNnJMCIS0vrbB00
	 1TMhIt/hDBX7S/YCwCGYqtJ+dUB2clUtoXBrPzVx/7sItHqDhlIDKIYycvrNxCDBXQ
	 0byBA1G8EV/ow==
Date: Thu, 17 Jul 2025 10:57:57 +0100
From: Will Deacon <will@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
	kernel-team@meta.com, Catalin Marinas <catalin.marinas@arm.com>,
	osandov@fb.com, leo.yan@arm.com, rmikey@meta.com
Subject: Re: [PATCH v2] arm64: Mark kernel as tainted on SAE and SError panic
Message-ID: <aHjJJf4KTzXLBjM0@willie-the-truck>
References: <20250716-vmcore_hw_error-v2-1-f187f7d62aba@debian.org>
 <aHd8uvMegWXHyhvN@J2N7QTR9R3>
 <xdvsnmcgfk7kkeq4r43l2c3h4vrlhuy4s6g2nybzsibyna3ipd@tkb7elmgn5m5>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xdvsnmcgfk7kkeq4r43l2c3h4vrlhuy4s6g2nybzsibyna3ipd@tkb7elmgn5m5>

On Wed, Jul 16, 2025 at 03:52:55AM -0700, Breno Leitao wrote:
> On Wed, Jul 16, 2025 at 11:19:38AM +0100, Mark Rutland wrote:
> > On Wed, Jul 16, 2025 at 02:42:01AM -0700, Breno Leitao wrote:
> > > Set TAINT_MACHINE_CHECK when SError or Synchronous External Abort (SEA)
> > > interrupts trigger a panic to flag potential hardware faults. This
> > > tainting mechanism aids in debugging and enables correlation of
> > > hardware-related crashes in large-scale deployments.
> > > 
> > > This change aligns with similar patches[1] that mark machine check
> > > events when the system crashes due to hardware errors.
> > > 
> > > Link: https://lore.kernel.org/all/20250702-add_tain-v1-1-9187b10914b9@debian.org/ [1]
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > > Changes in v2:
> > > - Also taint the kernel on Synchronous External Abort panics (Will Deacon)
> > > - Link to v1: https://lore.kernel.org/r/20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org
> > 
> > I think something went wrong when respinning this patch, because the v1
> > link above is incorrect, and should be:
> > 
> >   https://lore.kernel.org/linux-arm-kernel/20250710-arm_serror-v1-1-2a3def3740d7@debian.org/
> > 
> > The Cc header for this posting matches that of the unrelated patch (and
> > excludes Will, Catalin, etc), rather than that of the real v1. The
> > change-id trailer also doesn't match v1.
> > 
> > The actual patch and commit message look fine to me, so:
> 
> Sorry about it, it was totally my mess with b4 on two different
> machines/branches. I've been testing it on a arm64 hosts that
> has no email access. When I picked the patch into the machine with
> email, I messed up where to cherry pick and branches.
>  
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > I assume that Will or Catalin will be happy to pick this up. I've added
> > those missing folk to this reply, so I don't imagine this should need a
> > respin.
> 
> Thanks. I will not respin then (unless requested).
> 
> Sorry for the mess,

No probs, I'll figure it out!

Will

