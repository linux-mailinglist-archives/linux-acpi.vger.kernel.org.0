Return-Path: <linux-acpi+bounces-13900-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F649AC42C3
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 18:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CA03B8056
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC33226CF9;
	Mon, 26 May 2025 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kx/LsZgA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD6A226CF4;
	Mon, 26 May 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748275687; cv=none; b=mQMjOZ7eR8srYPNIiVJudkBkpgNtgxDIlVAx3zxs0dkjCWnCJADnH3gdhmeTywZMbwzE8exy7OLgLzllk2wJ7gaRZPTiKwBO3xtGgw7TrMmIhHX85VyCZErECQgniCq7X80OvsjouDcHQamKRPAPV/6q2rOqBslHj78Rh1gR7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748275687; c=relaxed/simple;
	bh=SdTtgDBgh9oWsF1zhJMCQ3FHaLPZZ5ytavUZR5tKXmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq56ZN4CcHp9XhGER5fzjv7ou3UKtgpPxhHCvwK2oRY79AVaF25FnG7Ck+i0slb9TdVnafVMx9cX2QvOhc4I2TWPjbJknH0vN69Ev79mHs7vxZhPQGu0z66b45GZ06fma7vZp80KeEVET0DZfgpAjMUeOpmes+FmPsBBXaLIsIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kx/LsZgA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ljZAx0JzcbzUKqpH7dD8r2cNUu+/PYVrCSbW9O39hbI=; b=kx/LsZgAtyU42ixaoxh6ZeJ7Lh
	TmH/rL5yGvLaUSiLGSnd8PvyWqXzyzY71Zz4EuCQ+uBDtAvyGOtL4Rcx57yS92LkgaavfUYQouxy5
	A0e49+DiggVJuc/PjCWi8rwKAeKA5jL44wm5bkSmuviGEUy1D2Jb+kTRuClCcx6JLF/lfTx0jVSQb
	kAj1CCvy/+JYDKeFZneVgXxZGrf+5A+W5LFIXcW3cp3go3nRc3yNDJEDPUMyzFZOVHj57BXcClMj1
	NPequRsrY0MWBu+Vn6aLdfikpA9aqShv2uAWjmsho/bjnXq2e3ouhsl1tOqnlP7CUqsRGt6D7MmbI
	TtSqeYGw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJaMk-0000000Ba9I-1XZ2;
	Mon, 26 May 2025 16:07:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 86A54300472; Mon, 26 May 2025 18:07:53 +0200 (CEST)
Date: Mon, 26 May 2025 18:07:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Khalid Ali <khaliidcaliy@gmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com, rafael@kernel.org,
	tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH] x86/ACPI: invalidate all cache lines on ACPI C-state
 transitions
Message-ID: <20250526160753.GS39944@noisy.programming.kicks-ass.net>
References: <20250526120029.GR39944@noisy.programming.kicks-ass.net>
 <20250526134600.619-1-khaliidcaliy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526134600.619-1-khaliidcaliy@gmail.com>

On Mon, May 26, 2025 at 01:45:33PM +0000, Khalid Ali wrote:
> > This is absolutely insane. This day and age, nobody should use WBINVD
> > ever. We've managed to not do this for decades, and I'm thinking that
> > either the SPEC is 'mistaken' or otherwise out of line with reality.
> 
> > If you hate performance, and you want to break things like CAT, feel
> > free to put this in your own kernel.
> Sorry, i made a mistake, i meant ACPI 6.4 and 6.5. I already resent this patch
> please check the resended one.

Doesn't matter. We're categorically not going to be doing this. Rafael,
who do we kick to get the ACPI SPEC fixed?

