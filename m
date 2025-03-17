Return-Path: <linux-acpi+bounces-12313-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B380A65FCF
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 21:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDE8188ACF1
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 20:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470431F866A;
	Mon, 17 Mar 2025 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpPoF3rC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FBD1FAA;
	Mon, 17 Mar 2025 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245101; cv=none; b=Kfxasv95gPhxpQ0rnVFasN2pmD/kcobX7cqpsESTNTo2me+D8zedfoHuiLTKfwckMtFuBrRxyI/rBC1KfUvqYiVdxarvuaogZS0DboMoHotU4cNmeQ5cEjDVzK9iMLIoSE4CANmbPONBK+V/b9ScnGiOITXvj1a866qqaAltY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245101; c=relaxed/simple;
	bh=QpFS5fAHCciJkJc6rhl3MyU++6GoZXdBE1mLhu6pdZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuSBu39wv+NvGtYn/6VnKX5KfFf9/lkZmLFLNG2Iv7Pf18OLBToLnYHhlQuLG3++Antn06g2eKfPItdF7STN2U5v23drpaej72eIFSlPLk2fNulF9GSE2EqU/oRUdjGHNEgVjZ41bcvueSJpbhLWoFbX2OeK8xnzaRLoIxk/1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpPoF3rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58C7C4CEE3;
	Mon, 17 Mar 2025 20:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742245100;
	bh=QpFS5fAHCciJkJc6rhl3MyU++6GoZXdBE1mLhu6pdZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpPoF3rCj3tSgGcI9NZS+Fm8ejrHrirjgKmGkmj26odd2/xTab5bymgvu0pzecOlO
	 8oeVMx7IGYZZP56fW2PLAKn6SJcGy0w5Vdc8munKK3Do1dR3KTtBghXN9Zlf8BHmOl
	 ZKwJS20pu1KjpEUqF/XsqwJeaxtCPNyvAAEt6Vx17JUV2DdwDYsnsIlz5McnG5OCb3
	 r6DfALMod5G7MmjPGSONrZBOdm7Rxf8mem78R6LLBKaK8I00IhSe6kPETxC8kYcgWn
	 6hqu+cMtL29ULrS7vii+i3bwHWfeGFUSFZa6tN/1LmKgUnwMP/HVElVpCgokmoNBN2
	 9VU6Z+wfj87jw==
Date: Mon, 17 Mar 2025 20:58:15 +0000
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Rafael J. Wysocki" <rafael@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] net: remove sb1000 cable modem driver
Message-ID: <20250317205815.GN688833@kernel.org>
References: <20250312085236.2531870-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312085236.2531870-1-arnd@kernel.org>

On Wed, Mar 12, 2025 at 09:51:19AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This one is hilariously outdated, it provided a faster downlink over
> TV cable for users of analog modems in the 1990s, through an ISA card.
> 
> The web page for the userspace tools has been broken for 25 years, and
> the driver has only ever seen mechanical updates.
> 
> Link: http://web.archive.org/web/20000611165545/http://home.adelphia.net:80/~siglercm/sb1000.html
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Simon Horman <horms@kernel.org>


