Return-Path: <linux-acpi+bounces-14378-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07F2ADA6DF
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 05:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C75F16E54E
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 03:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8B1DF26B;
	Mon, 16 Jun 2025 03:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nt71+uJx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE81DE8BB;
	Mon, 16 Jun 2025 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750044914; cv=none; b=HPujLO9QnySghNZva3Xm5wBkqiYLVB7IJZLq3oabkQrLb0bzP24s0wtD6lxqc6xIDGbYPwTcCf1SazsM8lnEeJB+Xrpc98h8ZsojUI1S4yBh4W6hbJ7ESdke2w5wp98iQPElnFSF+DzJBacdLeNAbivRH7nZx1a9pIVBgdAYk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750044914; c=relaxed/simple;
	bh=xUiaQrK9jzGMfYv6/h+DNBKT/uNE7jcWo2wKABJN138=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cExqpE89LS+uI8TMw5NDLyxSpmFDjoyzjunIoHdG4x21m9+ZWmYhCdvJ2XwILLov7SX0kZV1v0aLLMOrunIWJtLfBEDcXhk9HzOdwHOea4BLSYK/cuK1lxL94BV75p6CabPpZHPFfEWtKOc8bFr+vn9ZU4NOum0kHjiZSRCpLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nt71+uJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13430C4CEF1;
	Mon, 16 Jun 2025 03:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750044913;
	bh=xUiaQrK9jzGMfYv6/h+DNBKT/uNE7jcWo2wKABJN138=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nt71+uJx7QXTGOtKf0VR+sAJ35Rj1uC0kefyQak5IaZLMFuMM8BdwdU4dCDqBFRfu
	 m1NNJSZwh/prl/Rqc7M/fRBReIEpgfLVOjVBiZSaxHsjkr6tyV6lA1TOiVbHWTQYY8
	 CkaQxn6HN/HrWKB9yHJrwduvcMftkG5TvjI+Fulw=
Date: Sun, 15 Jun 2025 23:35:10 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: Marc Herbert <marc.herbert@linux.intel.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Benjamin.Cheatham@amd.com,
	Jonathan.Cameron@huawei.com, dakr@kernel.org,
	dan.j.williams@intel.com, linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael.j.wysocki@intel.com, rafael@kernel.org, sudeep.holla@arm.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
Message-ID: <2025061546-exile-baggage-c231@gregkh>
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
 <2025061446-wriggle-modulator-f7f3@gregkh>
 <a3a08e5d-bfea-4569-8d13-ed0a42d81b2a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a08e5d-bfea-4569-8d13-ed0a42d81b2a@linux.intel.com>

On Sat, Jun 14, 2025 at 07:53:34AM -0700, Marc Herbert wrote:
> > the kernel relies on this not being "optimized away" by the compiler
> > in many places.
> 
> I think "undefined behavior" is the more general topic, more important
> than null pointer checks specifically?

Is this really "undefined behaviour"?  There are a lot of things that
the kernel requires for a compiler to be able to build it, and this is
one of those things, it can't do this type of "optimization" and expect
the output to actually work properly.

> > the kernel relies on the compiler to be sane :)
> 
> Undefined behavior is... insane by essence? I'm afraid a few custom
> compiler options can never fully address that.  While we might get away
> with -fno-delete-null-pointer-checks right here right now, who knows
> what else could happen in some future compiler version or future
> combination of flags. No one: that's why it's called "undefined"
> behavior!

Again, that's not the issue here.  The issue is that we rely on this
type of optimization to not happen in order to work properly.  So no
need to "fix" anything here except perhaps the compiler for not
attempting to do foolish things like this :)

> > If "tooling" trips over stuff like this, then we should fix the tooling
> 
> Because of its old age, many quirks and limitations, C needs and has a
> pretty large number of external "tools": static and run-time analyzers,
> coding rules (CERT, MISRA,...) and what not. It's not realistic to "fix"
> them all so they all "support" undefined behaviors like this one.

If they wish to analize Linux, then yes, they do need to be fixed to
recognize that this is not an issue for us.  There is no requirement
that we have that _all_ tools must be able to parse our source code.

thanks,

greg k-h

