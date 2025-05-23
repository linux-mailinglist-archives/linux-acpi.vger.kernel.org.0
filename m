Return-Path: <linux-acpi+bounces-13856-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A8EAC215B
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 12:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B56A435D5
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 10:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73202288D3;
	Fri, 23 May 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ImUeMeDr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B+Fb1BTI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C7229B1C;
	Fri, 23 May 2025 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997112; cv=none; b=iIOuRkkGZmnVOEfnpCWtRjm0jbpQ8zHMFPx1Pzzjwc1olM90c4IwSF5oZep3g4As6fyBen34r4gWpNBsmQ/7JInobm5zhcsWVOGTZBak3xivTj8job21lWLeP2rfew6aBYBsTBE6JyMCH1CyrthI+n5HmQZUjUFe/dXJb8hSpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997112; c=relaxed/simple;
	bh=s8hWxueZYAKj5utygI0hnGNZmhlCpTCMCwehNpq0JJE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fMoEU0nLXcNNBXcgjTTvbElt1vIP3nFoYw5r1FWNaX0VA0r/gDuxQtncfUtYgsXdzcxZ96EVhkNUJoAdVMudJOLTysXVmFxL3e5JFHne/kV7twj6zzs7aSlirlLS/n81juI9eZ9qdtbH7ayWp/CmfY5MSx2EaXYHdjAe15yVz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ImUeMeDr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B+Fb1BTI; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 723F1114013B;
	Fri, 23 May 2025 06:45:08 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Fri, 23 May 2025 06:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747997108;
	 x=1748083508; bh=Y81e2LvO0vLhZIXHKU9Um3avzr/8nqz2ybjBlLZu/vI=; b=
	ImUeMeDrVo5WEB6TzbS3e4dogqfeJoqSBQV8qf1zgCxU+1kivr69gvO1AnWqnop2
	qb0TrsUcToTRB76TQxcSx+g9/IoXlkJi7MVrGU6cnOY1eHXqrua8beIfOLfp6VgE
	kJ66NiAGYZlsOvhBK6F0dMSaHXjsYkJzrb/FbhdqqMZtYZAGdY5OEKlSqyqe2tzf
	L5ynOYM46Pz1tYlBlrV1QgvlpVZRbspohwnN5J5usxgZAOJV1Vu3g+zfKO0j3ELv
	GGgfN9LntiQ+O0kh+XelMtVvEAAcv5e9mSSHF4nyBiORc2OuWENgToy5yBFOAKaR
	4qT/YfMikneT2MS7QE877Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747997108; x=1748083508; bh=Y
	81e2LvO0vLhZIXHKU9Um3avzr/8nqz2ybjBlLZu/vI=; b=B+Fb1BTIYt3sXc7g4
	cztE/HtJJKQq99qO8iLskBT3dMeCpbqec2i69ICwQttKaErwMm9K5L8HaNCoMbnP
	/ud0qo6JT0RGMyKue80HRWieb9KzugiLgI4mKp04rqtSkgv5wH+n7iFvJgdmN7Lq
	bZbDOxOFsdd1i5KWtEa8AsyTEvGVj+xz4axrz/Wafuw4S9M9AzsXu2+1Wu5Ap+/U
	mjflV/nZ+BRNJcDf7Vy8nV2Vy2f73eStx5ROs5C31C8PDE1NIQ7JVkAVYUGXjxed
	IfstodzqF/M8dYYjE7Sqxpu/HuxSFM57yXmewjdzMdiA98lWuctQgNf7fU5IerV5
	Jp+pw==
X-ME-Sender: <xms:s1EwaENFjOZSZSANJ_xSGgjoTbMNAk27rBS4Cv4uLWxC_yZDyLtqxA>
    <xme:s1EwaK_LrWsRGLoV3VEyGzwBGFOEgqxFg1Gg66IMfFqYRR5aX9-xW0zOJTQF_GqlZ
    EWfD3zcX7AiprPLoak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdekieehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghf
    ufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoe
    grrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeektefgueefhfekhfej
    gefffeetffevuefhvdeijedtfedvteehfedtjeduffdvheenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegr
    mhgurdgtohhmpdhrtghpthhtohepfigprghrmhhinhesghhmgidruggvpdhrtghpthhtoh
    eplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrih
    hnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghlvgigghhhihhtihesrhhivhhosh
    hinhgtrdgtohhmpdhrtghpthhtohepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgv
    sggsrdgtrgdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:s1EwaLRLs3yc3EmwQAGnUuberBf2Mjb5nl6yH5rqM4PUoONA5_kLyQ>
    <xmx:s1EwaMtfLlV39O4d5X80twJEMpwOYKMuDogh7uycYHmOhNodrtqxlg>
    <xmx:s1EwaMfvNoThepEUYXlIBEhSXMSSRt1PEOXAVD628akT2l5q-dZykg>
    <xmx:s1EwaA1-K8Xsyja336JjMOxN5G-0G4XtOgVBwC0QmSmkVhEbueM-xw>
    <xmx:tFEwaFhjMgRjqJ5c5MAy9cXE0mFpY5m09n9fY12ujUvtu3nqbWIx7OhX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CDEF41060060; Fri, 23 May 2025 06:45:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tdd7d737077c6d117
Date: Fri, 23 May 2025 12:44:47 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Armin Wolf" <W_Armin@gmx.de>, "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Mario Limonciello" <mario.limonciello@amd.com>,
 "Mark Pearson" <mpearson-lenovo@squebb.ca>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Message-Id: <9fd12267-bfba-4f94-a132-b20c5be601b0@app.fastmail.com>
In-Reply-To: <91458376-dfc7-46fc-8523-aa176907d703@gmx.de>
References: <20250522141410.31315-1-alexghiti@rivosinc.com>
 <91458376-dfc7-46fc-8523-aa176907d703@gmx.de>
Subject: Re: [PATCH] drivers: acpi: Fix platform profile driver on !acpi platforms
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 22, 2025, at 22:04, Armin Wolf wrote:
> Am 22.05.25 um 16:13 schrieb Alexandre Ghiti:
>
> I already submitted a patch for this problem (see 
> https://lore.kernel.org/linux-acpi/a6d92cdd-4dc3-4080-9ed9-5b1f02f247e0@gmx.de/T/)
> that only disables the legacy sysfs interface while keeping the 
> class-based interface functional
> as it does not depend on ACPI at all.

Just for my understanding: what users of the platform profile are
there that work without ACPI? I see that CONFIG_ACPI_PLATFORM_PROFILE
is hidden under CONFIG_ACPI and cannot be selected in configurations
that turn off ACPI, so if that is an intended usecase, there is
probably still something wrong in Kconfig.

Should the driver be moved out of drivers/acpi to drivers/platform
in order to let non-ACPI platforms use it?

     Arnd

