Return-Path: <linux-acpi+bounces-19670-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED00CCBD06
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 13:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A91130281B9
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 12:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9B83328EF;
	Thu, 18 Dec 2025 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZFj1ZYty"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295703314CE;
	Thu, 18 Dec 2025 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766061613; cv=none; b=sA7gmYDAOvDG+YldEC8M1FE87cLiO8DGciSXlmhOJLMbz/O6w6C9BCp2bp/h6jaq2uRdiQ6IQMSweUYGDq4Fq37d/XHA4FDzShqzIoD8EzdtvCYPmz86flAIAIUTGXE9w1WBrpboMCtaLWKKcjOr6oLABae+wQAa1l2jOX2yJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766061613; c=relaxed/simple;
	bh=sre1twFs1oaMSWJWmMpYhlzmqOCAaTMsnJ9nVhzfEvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MErXX4XLlgJopibPWEvDIcIBZEq3lpcwAk1NeadeHljckTFb26Zvb7BDXV6MqyMsAYRrnFmZ60UHCJCqoNHATEuQNQde21XUP4EUP2Fe+uKMK1FJ2MBwkrlbwuqh0OGNMZz8ccoK435IRmxhI7KbM0OL5r+FRZ5ptHKQ+Zh97bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZFj1ZYty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3E9C4CEFB;
	Thu, 18 Dec 2025 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766061612;
	bh=sre1twFs1oaMSWJWmMpYhlzmqOCAaTMsnJ9nVhzfEvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFj1ZYtyUlODolz7RGNALvEqy31J7fNPPQefSXOY1SRUJ/ghBHpSBKBgIROHDeoTw
	 76/rTGWCN5PtcX025cTFj+Fuo33YcMpCPK/5p1+Yfa4DggkH3GjsoXCj8GLNK17nMp
	 tys81Kp9Unm22LyzjbkQNN5QaUylgCiAZd/ERpEw=
Date: Thu, 18 Dec 2025 13:40:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PNP: add a error handling in pnpacpi_init()
Message-ID: <2025121811-password-reroute-6880@gregkh>
References: <2025121841-unwoven-twelve-e65b@gregkh>
 <20251218122422.573466-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218122422.573466-1-lihaoxiang@isrc.iscas.ac.cn>

On Thu, Dec 18, 2025 at 08:24:22PM +0800, Haoxiang Li wrote:
> On Thu, 18 Dec 2025 12:33:05 +0100, Greg KH Wrote:
> > What tool are you all using to "find" these issues?  Why aren't you
> > properly documenting it?
> 
> Sorry for the inconvenience. I found these through manual code review.

Manually?  Really?  Why are you manually reviewing pnp code?  Do you
have this hardware?  Why not focus on code for hardware you have and can
test the fix for?

> I will document how the issue was identified later.

It should be in the changelog text, as is required.

thanks,

greg k-h

