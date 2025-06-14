Return-Path: <linux-acpi+bounces-14375-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF9FAD9C9A
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Jun 2025 13:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8800117A37F
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Jun 2025 11:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EA627BF80;
	Sat, 14 Jun 2025 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cEOV3OI+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0B191F74;
	Sat, 14 Jun 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749902005; cv=none; b=nU5z2TzAJlXdpGyxuUBlY3oRqtAKrWpYzHFmZ37qkeFZSxjMuI2mdbuS/ewBmp4aUEAIlJHEOFZSPz7AsO4f+fDW0Iq8jb+tZWkQe3kCme0uTftTQutKLZsmdvquY62vqRsd8TUH+0RT4UZUBcPvjEn3FFYhdkScSlzawnjRabM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749902005; c=relaxed/simple;
	bh=l6N+hRoEUaHWFxgmCEaWsWHq8KeFgi8XNKiOXAlGLFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dASHI0bd2DaG6fB8f3nfZrj3zMP+uV2jxzP6v2Il8SIXvOBEOSC3Ez9qz1fA+KHiPyTIN0aOItyQsRElAKi9nCdv05oh7JMtIMQ5WppDd4uCdbvqh5h4cIEsSzkL2A4t35dHsGkmwpiBJAP7avoVpJaUu18xx73lS2F8b9Naemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cEOV3OI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31603C4CEEB;
	Sat, 14 Jun 2025 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749902004;
	bh=l6N+hRoEUaHWFxgmCEaWsWHq8KeFgi8XNKiOXAlGLFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cEOV3OI+liS8s0kKXZDTUzPuvEB5VrsQTDMTlnUuuNq7CwZjHzr7Rk+TXdoRQOE9h
	 w8f4pe4WnD4cmCppLp0WpKqcFBY9br69xT4M4KQcu9iTMDJTqzSMlaU5kPt7yZxORo
	 sHVcQFAApVSooSYIcZRzXeGcF2e2vdvNQ9CGPUeE=
Date: Sat, 14 Jun 2025 07:53:22 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Benjamin.Cheatham@amd.com, Jonathan.Cameron@huawei.com, dakr@kernel.org,
	dan.j.williams@intel.com, linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	marc.herbert@linux.intel.com, rafael.j.wysocki@intel.com,
	rafael@kernel.org, sudeep.holla@arm.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
Message-ID: <2025061446-wriggle-modulator-f7f3@gregkh>
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614105037.1441029-1-ojeda@kernel.org>

On Sat, Jun 14, 2025 at 12:50:37PM +0200, Miguel Ojeda wrote:
> On Fri, 13 Jun 2025 20:33:42 -0400 Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Great writeup, but as Miguel says, this isn't needed at all, the kernel
> > relies on the compiler to be sane :)
> 
> We may still want to clean them up, e.g. for tooling -- Kees/Dan: do we?
> e.g. I see a similar case with discussion at:
> 
>     https://lore.kernel.org/lkml/3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de/
> 
> Which in the end was picked up as commit 2df2c0caaecf ("fbdev: au1100fb:
> Move a variable assignment behind a null pointer check").

If "tooling" trips over stuff like this, then we should fix the tooling
as again, the kernel relies on this not being "optimized away" by the
compiler in many places.

thanks,

greg k-h

