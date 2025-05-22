Return-Path: <linux-acpi+bounces-13851-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5F6AC0DED
	for <lists+linux-acpi@lfdr.de>; Thu, 22 May 2025 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986733BFF0C
	for <lists+linux-acpi@lfdr.de>; Thu, 22 May 2025 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B03128BA84;
	Thu, 22 May 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="egyaIK78";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zd8XoNmY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436F1EA84;
	Thu, 22 May 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923635; cv=none; b=B2IZcGFfiCVbxaK1sfzHqrQHFJt74bHgJ9fSbuxsOvOX8vFKR6CY3Jwxt3x+k7mBIyO8aJhTM2Dqt+nTUMy5lSDlr/Supvb+Nb0M+BdgCClFzvWuWmwY4UH1oOJxDHTXu+bkJNeYx2spYz3WxxZBjbQYk5J93gsaPR+xYD/ke0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923635; c=relaxed/simple;
	bh=tckNKMKh4YInDWoa9+SwINj6KGVI4lSPKQzfRJ1nPQc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j/ipXKpXfVfjxSogLQb+9kiyb036HJ5nG9tx6f4M3+CdGtbW0OkxIERzViLU2N+2RnhlpIeG4rwE+U5mzNyl0Mi1eSryRmBKcb+mYuoeE45piqVTgNfDd9tJLBteIzQR5R3U1Sje9OHy/UpLuoB1+h/WBlXfjeLaMaU3gOvlbHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=egyaIK78; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zd8XoNmY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F40041140191;
	Thu, 22 May 2025 10:20:30 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Thu, 22 May 2025 10:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1747923630;
	 x=1748010030; bh=6SzZjdG+sF7GjKUZx/yFtARR+eKZB/Yfx9kGEaaXnEo=; b=
	egyaIK78kY8i5gA29bk8ECXgVxvt0Ai621vlSvncFJS6Ae3SqPtsGeCEw8NRfWov
	M+Um8GmHSHyBfFFLi/ZiauYubwK+s8Hv78tT0QWJtmatEHDKnVCr5Ast30R7UIG9
	8rosAoWXETSV3YN2mtuB1mm+WQqRT+QHDS+4IDriS72+zqGIPjirIvePkobSS1Gi
	38qoXBCZ3Emp2N2fZEyZ9RfZ5zJdrvZx/UOxAlighz6DIByzrpqdKf1nqTBU4lr4
	uqv8JuWOMgasvaR3SwGVVGuj0iRoooMyaGqKvb55LjoJ/KrfN66IXobkHRpOLxOR
	OmAUJA/5WTtb7kxclPccyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747923630; x=1748010030; bh=6
	SzZjdG+sF7GjKUZx/yFtARR+eKZB/Yfx9kGEaaXnEo=; b=Zd8XoNmYGq+p/5wqq
	osELy9IZIfUWCl+pufqzM1aVNZiwRvv1Tyaho+QcLOyd7oNO6TbtDUNn0bMYCf2B
	rouMvdhnJAgm+Z47x2k+8noLTmpv3tm5/p2n3IsIs8Xk52qaCewIWUOCkGlNV2tW
	2EbsZPe+staj9BUA27k8RxE++kVG6+iBEaQAAccPrjen6Q4zDvgTWsUA2WqgJcrb
	2UCi3z90SgGCiexbwpsSq+L/+ah1UoR2VHQW+BonIdQzL13RBZG9H6RskI1lSZRS
	ff7IiPx3//NOcm1ZPOtnI6uneqnjEWTmsEZaRVwcEJazYdgOrnkC3Rf60q7uIWsK
	L9geg==
X-ME-Sender: <xms:rjIvaBDBGWTSgXGDozXVenZ3c5RyETSn3CwGwUG46T3IvUAhXNhZPA>
    <xme:rjIvaPivIeWzRT1kRjuPPruciSXUci082-ni2TmwZR4Gat9EXAQmuin1wu_zen5Q1
    GCjE69t2X0AKI3yYn8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeiudelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghf
    ufgtgfesthejredtredttdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomh
    hpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghr
    nhepkeffuedtveekjeeukefgleejgeetleduueetudefudehfefhheefleehheffffekne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggr
    rhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepuddtpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghl
    lhhosegrmhgurdgtohhmpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtph
    htthhopeifpggrrhhmihhnsehgmhigrdguvgdprhgtphhtthhopehlvghnsgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopegrlhgvgihghhhithhisehrihhvohhsihhntgdrtghomhdprhgt
    phhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rjIvaMkUcRNNIXPA26nbK9gDsRTYhOCo0PXAQKIR1zzw9xpUIai9jw>
    <xmx:rjIvaLzbAZwvQsclg4XYwfA7A9UVO-cuGDBCBnLZt-mI5pgagntpZA>
    <xmx:rjIvaGQ7ye2q6i0g7dxPwI7Q10y0C8sTyjrsUy_mqvBA4_nv6awCCg>
    <xmx:rjIvaOa9IANsRWgLmGgYWbWQpQzvD2vTs1M6sBCw-B5h3O9HLjTIcA>
    <xmx:rjIvaNRD4BJ0IM-AtoxPHvife5VJC8uQPaGjM7cHfmib7AsLHqOg4fTo>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 689DD2CE005D; Thu, 22 May 2025 10:20:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1cac82e440972a10
Date: Thu, 22 May 2025 10:20:10 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Armin Wolf" <W_Armin@gmx.de>, "Arnd Bergmann" <arnd@arndb.de>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Message-Id: <83d4fd6f-805f-4b96-b772-70aa55c8c1f9@app.fastmail.com>
In-Reply-To: <20250522141410.31315-1-alexghiti@rivosinc.com>
References: <20250522141410.31315-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH] drivers: acpi: Fix platform profile driver on !acpi platforms
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 22, 2025, at 10:13 AM, Alexandre Ghiti wrote:
> The platform profile driver is loaded even on platforms that do not have
> acpi enabled. The initialization of the sysfs entries was recently moved
> from platform_profile_register() to the module init call, and those
> entries need acpi_kobj to be initialized which is not the case when acpi
> is disabled.
>
> This results in the following warning:
>
>  WARNING: CPU: 5 PID: 1 at fs/sysfs/group.c:131 
> internal_create_group+0xa22/0xdd8
>  Modules linked in:
>  CPU: 5 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           
> 6.15.0-rc7-dirty #6 PREEMPT
>  Tainted: [W]=WARN
>  Hardware name: riscv-virtio,qemu (DT)
>  epc : internal_create_group+0xa22/0xdd8
>   ra : internal_create_group+0xa22/0xdd8
>
>  Call Trace:
>
>  internal_create_group+0xa22/0xdd8
>  sysfs_create_group+0x22/0x2e
>  platform_profile_init+0x74/0xb2
>  do_one_initcall+0x198/0xa9e
>  kernel_init_freeable+0x6d8/0x780
>  kernel_init+0x28/0x24c
>  ret_from_fork+0xe/0x18
>
> Fix this by checking if acpi is enabled before trying to create sysfs
> entries.
>
> Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI 
> platform profile")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  drivers/acpi/platform_profile.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index ffbfd32f4cf1..b43f4459a4f6 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -688,6 +688,9 @@ static int __init platform_profile_init(void)
>  {
>  	int err;
> 
> +	if (acpi_disabled)
> +		return -EOPNOTSUPP;
> +
>  	err = class_register(&platform_profile_class);
>  	if (err)
>  		return err;
> -- 
> 2.43.0

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

