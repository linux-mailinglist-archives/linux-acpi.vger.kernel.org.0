Return-Path: <linux-acpi+bounces-9584-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF639C864E
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 10:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0963B21624
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 09:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8C91DF24B;
	Thu, 14 Nov 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kWa26J1H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152E1DA0ED;
	Thu, 14 Nov 2024 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576764; cv=none; b=WyHVCeSTW/r1RtU2oifoAEi+iZwgofm3S8GOx1meSO0tbl+STwDb9CcdZjeuYi5TtiwGaal/auJOidHA4MIjzy2yOagzrRw2M+SlbLCLn4z1o/xLRW/5K3d+fSZbkrOxyY/079d4Zads77RxkU2DDJvQ4X0ypPwqDhGGd1/KuKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576764; c=relaxed/simple;
	bh=1uBXJ6TSGmiwzNukM03CToLqaGHPss3V2DVeZy/AE1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+dR4f6bnTTPofTSw/HbY2TWgh4wob6hII6wwMveSsvHfaKZQL9DrGpaGGmYO8cuHp8ego3DrzR0zazOMUVWm36TO0SFZfywsOrsjSKv4AIbjzUxhe9sXeRqNsBp8uCAZ9IBh3RUzzmrK33YNGpFmks0obwtrES6p1MiIrQd/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kWa26J1H; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E87E940E0220;
	Thu, 14 Nov 2024 09:32:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WvcG_SBnzOyk; Thu, 14 Nov 2024 09:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731576754; bh=g/UV2Vl8EVA86rQBI5eN+ioVn6VRTFK99yqErYywcsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kWa26J1HFid4FvzBH8im2y2C0QrkMom6aONHZFy4vTiIddPAg7/SrWrj9qo17et52
	 gOD7ufib6OJNDqgYBZObP57B9ctHBrVCIf99gJ81RbCuE30pwQSgCC/RzfIpPFbclS
	 CjzsG2k+je45mAvHY+mFd7VcOIbNa0XNdPPb+imNyJ/nOSaXGZrKzc431BLWvYiOgo
	 d0m59FRwZ9CpC/3NNHuxKLSMEloRcCMe+rSmoS6jlxDgnal63B56tVyo/PiTKAqA5M
	 gfVa24uRfWPWRXyySSOV70z1kmbfKNjxpNlB9JwXvWE5yA2CEUrdcXBA84YEzCh9fL
	 lTHyx15HzAVqIg0GhyFVsYTwbPBMob2k19nTCLZIN6pRkblFHW3al6EOUS+tGWSlWp
	 G5oxZyN5ojgtduNJ3wvPbWuPyl54w7Fqkvjirpf+APVrP/YK6hlttAq+YZ84+zl5DX
	 NMEjQqY1eQz/nKTXa4kF+Wi3xp18BgGKIBdRiM1Ug99DKdnkpeNNlF6bQbIUl8qLRP
	 qvxSzzKNm/WaX3Rs5sf5LNoaFOtjk+dPZ5a64h6hX0RDJ/mGXsTQn+ue+NH83lpgj/
	 J79ebJsd9KXENjU5KCyyD5+8aa6sKhl7U8HOxu4sr0tPFil8gOC8UzFCMIjr8SCmmo
	 mP4p/sRsxOUi3iMZL5VGBpgI=
Received: from zn.tnic (p200300ea973a31a9329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:31a9:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2054E40E0219;
	Thu, 14 Nov 2024 09:32:24 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:32:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org, dan.j.williams@intel.com, tony.luck@intel.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com
Subject: Re: [RFC PATCH v2 5/5] cxl: Add mce notifier to emit aliased address
 for extended linear cache
Message-ID: <20241114093217.GBZzXDoVnBPiAhVOvJ@fat_crate.local>
References: <20241112221335.432583-1-dave.jiang@intel.com>
 <20241112221335.432583-6-dave.jiang@intel.com>
 <20241113081128.GAZzRfMIuLpzwHY_R7@fat_crate.local>
 <9cbccaa0-f83e-4e92-bfbd-65a7ec08b2bd@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9cbccaa0-f83e-4e92-bfbd-65a7ec08b2bd@intel.com>

On Wed, Nov 13, 2024 at 08:27:35AM -0700, Dave Jiang wrote:
> I'm actually looking for recommendation on what the proper one is. The
> handler is expected to offline the aliased address of the reported MCE if
> there is one.

Well, MCE_PRIO_EARLY will emit a trace record so that if you have error events
consumers like rasdaemon, it'll get that error record for reporting etc.

MCE_PRIO_UC calls memory_failure() on the error and thus offlines the page.
Functionality which you're partly replicating in your notifier.

And since you wanna do the same thing, why are you even adding a new priority
instead of using MCE_PRIO_UC? amdgpu_bad_page_notifier() uses that same prio
because it does a similar thing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

