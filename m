Return-Path: <linux-acpi+bounces-13850-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2331AC0DE8
	for <lists+linux-acpi@lfdr.de>; Thu, 22 May 2025 16:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189363BDB0F
	for <lists+linux-acpi@lfdr.de>; Thu, 22 May 2025 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6127B267F53;
	Thu, 22 May 2025 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LQgfpgg5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uHG8R7HM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317231F09B3;
	Thu, 22 May 2025 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923523; cv=none; b=onY6aRLA0g9JqJ5oMYhvQYpzIcsa5bcZfV4Sv7cIhGgfXFNryXfLQlF5DfxZa9tPfR57JOfDGw5HBa09H3a2tiqonCSXvSWW3yUB091r6Tk3deQHU4V5jZJrQl/3HVnKx6+VLFa1iskOLX8XIoauSBHnSn+LMF43Iz8wa2umLVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923523; c=relaxed/simple;
	bh=ydM9ptHlkLdvFWjUy5hhT6spfan/essBb3lzYMHeM6M=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ia3G0cJL/obNBQsY2K59CDTMZZZ9C2FOFDcEh2E8YIA1/ZbCkwQurLoHx2ntwmLqgsr4nM9sDFFGnf030MhDCK9SD+DUVvuDDC61ABFRHO+1UfpX+RVpJX5iucW626MU2BRUrn9WTKDeIYJ2YaRTY3WjcW4kWrvKrNbSoso/AYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LQgfpgg5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uHG8R7HM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CECC425401B5;
	Thu, 22 May 2025 10:18:39 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Thu, 22 May 2025 10:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747923519;
	 x=1748009919; bh=hGvglmTdn2YYCq15UF3RYcVZFPJgASgYWxVBs5I74hw=; b=
	LQgfpgg5qMN/n4ao5YaViMJaALSaiAMgZmMoJDHEwBdrbW1ug39JOk+6t+gTcutK
	XUBb2TKbYTC5HvSUSPNfzJl4OJNuUhgGdB0G2T/vC4OfmStg/8/d5Isauiik95ma
	YlOiL/TMDLaGNsnev0376hsL6ooAGPiX2+pg7z6qVvRikLJc0H7zHv9t/rj+ryEi
	4X6p+jfy01WeLeeK9jxOcB/K/DuzJ8mvXVDGZ3TrnmapMMqx/TBxknUnNQYHgnVB
	6zHLMNQE/vONcqoENWRCslS+HZqo3BFtfpk+oZDMFy3VPGmWIRL0saoB/4Z7y1ET
	hCXEe2BznJopcHWknRzv8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747923519; x=1748009919; bh=h
	GvglmTdn2YYCq15UF3RYcVZFPJgASgYWxVBs5I74hw=; b=uHG8R7HMLD3IxgJFs
	N6+NNHlwGn8+xveMDWBfEzut3IeV+k25hLZ3m3VASXtJJ/lt9gKYO1G2RoRM+w7C
	LiPk+G3KLQeTS2i7g7lGoTBcHkmSJEiElBiIOD1hf4PRpakHC6+OpNiBUSfdbCQQ
	Ofpo0b2dNL3qAyVRmjlUjIcKVxVMB/2SdvN5wc98Cfa4HY8KzovV2aJGjibevQkh
	1So0WUu5zsydi0a5bVlgcDrZMJfSF5Os/Gd8B5HKks31lVeMu5hjxF+JgslI13nD
	/0lOKEbIYOrnPf5h4t4UAIa4WsvCFcxye+EKvtT4rpkp/ps9T55pLB68K4JQaulF
	aeo1w==
X-ME-Sender: <xms:PzIvaJy09rgWubYH3fSbSTp49ffHcOxMnVs_DBBP9ZPINvfEEB-eIA>
    <xme:PzIvaJQqFXcjHUC9ZziprMzDEBXxIUFBnqtfGD93FdjmbEqexw78qUAeMGBEV26BP
    b8y2AQEy7pVk0mngws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeiudekucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghf
    ufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoe
    grrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpefhkeeltdfffefhgffh
    teetheeuhffgteeghfdtueefudeuleetgfehtdejieffhfenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrh
    hiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopeifpggrrhhm
    ihhnsehgmhigrdguvgdprhgtphhtthhopehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehilhhpohdr
    jhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    pegrlhgvgihghhhithhisehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehmphgvrg
    hrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhrtghpthhtoheplhhinhhugidq
    rggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PzIvaDVxFEjxhCEqUac1ABEGaVMpopwUpKvHYjrncgUFlYpttWUHdA>
    <xmx:PzIvaLg9KaZ1PsspZX17NK01Aw-pqFO3RJeHK1oMfIamloa0Hv0JhQ>
    <xmx:PzIvaLBb5n7RbR44iBPqhDtGAwly1A58kUXlIyq1QbAHbLg_h319Lg>
    <xmx:PzIvaELGm6XpDr_41_996-BkkYQe8LDT6aUJ6DWocK3uqt4zYVx41w>
    <xmx:PzIvaCUZrIkbbK9xg6J50_BaO79ZnKDxvOMHlAops5-Co0kVRvCxSStD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 028A81060062; Thu, 22 May 2025 10:18:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tdd7d737077c6d117
Date: Thu, 22 May 2025 16:18:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Mario Limonciello" <mario.limonciello@amd.com>,
 "Mark Pearson" <mpearson-lenovo@squebb.ca>, "Armin Wolf" <W_Armin@gmx.de>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Message-Id: <f6e5a993-2480-4d73-b866-81f9b7bc3dd8@app.fastmail.com>
In-Reply-To: <20250522141410.31315-1-alexghiti@rivosinc.com>
References: <20250522141410.31315-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH] drivers: acpi: Fix platform profile driver on !acpi platforms
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 22, 2025, at 16:13, Alexandre Ghiti wrote:

> Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI 
> platform profile")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

