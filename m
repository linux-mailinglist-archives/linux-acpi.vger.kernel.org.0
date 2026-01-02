Return-Path: <linux-acpi+bounces-19924-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0EACEE266
	for <lists+linux-acpi@lfdr.de>; Fri, 02 Jan 2026 11:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A106C300699C
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jan 2026 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B4F1F3BA4;
	Fri,  2 Jan 2026 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bEWm74dd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B052D877D;
	Fri,  2 Jan 2026 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767349122; cv=none; b=ckdbzibC/58btpP9+xYRLXjPZJHOMvgyX4ViUhi0qsnd4xN+yEjkz5iG3rnYLaqdF/+cos3lItQei5/PAUn8MMKF45ZTsJTDC0wnFWwd13JDbWfwQ1Ozf2PqBPkFfVUR5/2nsytSmsWflMMYc8J2M6WXa0SblOo0VPtKV2l+9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767349122; c=relaxed/simple;
	bh=QkHiYOtPP9WIFJsOtwgmesBiGifnG6ccCjQUKkJ2l6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohBPgWGUlgQ01Me6tuRKYvg1wozxUUaB1jdJe8OtdHLLXTGokFMeNkvf4A+E3CppP7zMP3Pkc1S7ehA1gaHjP6f4ojQgtGwk6vta4fw/A8/lGsBhdOAt/h3vNPaCHg0ZBWvEhkRIdJhLdayxWsg60/ji5r6aOta5xoevHPl9gDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bEWm74dd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1D17540E00DA;
	Fri,  2 Jan 2026 10:18:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dqT6AQHhW338; Fri,  2 Jan 2026 10:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1767349104; bh=6VczmQi2so8bnhl6giquuY8av9Bv8/UOPGpIy7M7RJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEWm74ddZr1dzx05L9pQZ6KOZMOvIrOjhd3kzT3mbPqxI3oAlxWWxOb90gDrO3Ezq
	 x6dtJntMQFOrGTIZ0iv0iH0fstzvM6AqkHY11cLYWaXlOf9oLTjEMkEqAUaaBRwdW9
	 5Ds2GxmZzo9+o6lMJwn0hnwTRvY64Y5UczsE9l4Pr1MXgrA7H5ND4w8KXEhQ8yJKjT
	 NjcjzF2WcouGCUjjEycNif6L/ec7KbRdVawrUcUVztW35w3eUrm+BOzVQqRL0ckNWQ
	 Th6+Q/93vZT1mDp1jqbh3FUrwXNPNtpaLIEXSRH6rlikflefk7bCB7PRS3caprN8yT
	 SDbLqZwwj3AdIF2mKv7N4zqhiQ+D/Wnw35J047CzSU1V+4xurUH+I+C3ntor+UBaQq
	 zCiItM+2GkW4lJHhGtYWP23rqR6fW/2Yk/EwcUdT7YXb8cnS4Zp23BNTvF6s+fdZyv
	 fKwZtZMsOPWeAFBnxK2hsag9TnqMyUmC4u2ZMl3Vf7ZWXaCt1aunVjcMIiRHNvrjwP
	 mhF1PY50b/JmLedLPOGmwcmr1WKhwSSCmWNNzB/Pc7Q/w+Q/8qiQKAmE0EpgAPOUPo
	 iJIjCIiif7zq6X/2cKX3t1xU4/NUL3iSPbLkDRAp60VvJD0lldqz6nICZ5ByXZZo81
	 CzBma3APxEQ+LyKxXLrn32s4=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6E72540E0173;
	Fri,  2 Jan 2026 10:18:10 +0000 (UTC)
Date: Fri, 2 Jan 2026 11:18:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, AmandeepKaur.Longia@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com,
	prime.zeng@hisilicon.com
Subject: Re: [PATCH v1 0/6] ACPI: processor: Recovery some reverted patches
Message-ID: <20260102101801.GAaVebWWUMQyFs_vHI@fat_crate.local>
References: <20251223100914.2407069-1-lihuisong@huawei.com>
 <20251224020532.GAaUtKbE7vA4ian0LU@renoirsky.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251224020532.GAaUtKbE7vA4ian0LU@renoirsky.local>

On Wed, Dec 24, 2025 at 03:05:32AM +0100, Borislav Petkov wrote:
> On Tue, Dec 23, 2025 at 06:09:08PM +0800, Huisong Li wrote:
> > Huisong Li (4):
> >   ACPI: processor: idle: Optimize ACPI idle driver registration
> >   ACPI: processor: Remove unused empty stubs of some functions
> >   ACPI: processor: idle: Rearrange declarations in header file
> >   ACPI: processor: Do not expose global variable acpi_idle_driver
> > 
> > Rafael J. Wysocki (2):
> >   ACPI: processor: Update cpuidle driver check in
> >     __acpi_processor_start()
> >   ACPI: processor: idle: Redefine two functions as void
> > 
> >  drivers/acpi/processor_driver.c |  13 +++-
> >  drivers/acpi/processor_idle.c   | 116 +++++++++++++++++++-------------
> >  include/acpi/processor.h        |  34 ++--------
> >  3 files changed, 86 insertions(+), 77 deletions(-)
> 
> I'll run them on the affected machine once I get to it.

Looks good.

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

