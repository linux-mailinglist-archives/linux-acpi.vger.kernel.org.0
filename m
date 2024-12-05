Return-Path: <linux-acpi+bounces-9937-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490169E50ED
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 10:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA993167968
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 09:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024131D89EF;
	Thu,  5 Dec 2024 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DxNLPCOK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC221D6DDD;
	Thu,  5 Dec 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389766; cv=none; b=eezkP410FG3kX8lEw7Z8kF9UpmGfrufipOW5QchdXNyjwDznwLe0zdHs6yPH677Tta9y9VCGkxFnZAYLOAundhY00a+h0v0mLVeIysnqj+mVKdE3BQY1/x2kVBmDUrxQaNce1e/P0BLXmQs6eDxC/gKLP072yt8fRkB2EM5syAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389766; c=relaxed/simple;
	bh=At1ApeSt9ZFAhgsXP6DLvr0LFtlTwsyoo/UUTXAZRyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jhjs7sr7ghTw3o3aDu53iZ6SPhxnvq78CYB/T/ppoP3WLqUHagTjcFztrw4l11Fm4kXN8eQYaauOqbMhSbSlqtf6CxHqznvlrkEGbhG4lnyo6sAN4okzR7TSdZqrVdVeYTOrd/R318iVJZXUAT8uJfP6q15TAoG8cXtiWsBraCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DxNLPCOK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8GWz4ZX0UhYChlvMo68BPYRBmiUvh/S428x2MLXX5O0=; b=DxNLPCOKxod9a8onztLMSNYuiZ
	hbq3AIFx5fDGxn0J1JgY9q82flLg0dZ7XR+2Y/toalQgVGc+pAE3zMe+RCPRTFpr6TpPiMQS9ua52
	rw89MSB3MaWTGyPl4e89yRzM4baoS/GGY9pi/24swVo/bfIq645WjIaEXVR2q3Zxv5OqaW+pa7ur8
	+nOfXDllEEViT9pGvMv0quUkEtwT+BzsbKXfQ2zfrNnOZtNi1bPeDGSAZRgM9ShMmibmUUiQqzNjz
	69r0qbV1V23DEJyPxbjp+cfC3owTabGcknfSaoCYiN9OUgP4GXAbzzpH+8GAgxLG+74fFkeWMrWj0
	Q5TjLwgQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJ7rL-00000002oQD-10CU;
	Thu, 05 Dec 2024 09:09:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D4B3330026A; Thu,  5 Dec 2024 10:09:18 +0100 (CET)
Date: Thu, 5 Dec 2024 10:09:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Li RongQing <lirongqing@baidu.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH v7 07/12] platform/x86: hfi: add online and offline
 callback support
Message-ID: <20241205090918.GJ8562@noisy.programming.kicks-ass.net>
References: <20241130140703.557-1-mario.limonciello@amd.com>
 <20241130140703.557-8-mario.limonciello@amd.com>
 <20241202113858.GB8562@noisy.programming.kicks-ass.net>
 <89e53b9e-5cb1-4ef9-b3dc-10263f141cfd@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89e53b9e-5cb1-4ef9-b3dc-10263f141cfd@amd.com>

On Tue, Dec 03, 2024 at 02:28:37PM -0600, Mario Limonciello wrote:
> On 12/2/2024 05:38, Peter Zijlstra wrote:
> > On Sat, Nov 30, 2024 at 08:06:58AM -0600, Mario Limonciello wrote:
> > 
> > > @@ -340,6 +416,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
> > >   	if (ret)
> > >   		return ret;
> > > +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/amd_hfi:online",
> > > +				amd_hfi_online, amd_hfi_offline);
> > 
> > By using online notifier, you will already have tasks running on this
> > CPU before you initialize the HFI bits, is that okay?
> 
> Yeah; AFAICT it should be fine.

Please add a comment to clarify this for future readers of the code.

