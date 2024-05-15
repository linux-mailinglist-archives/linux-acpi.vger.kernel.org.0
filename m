Return-Path: <linux-acpi+bounces-5848-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3EF8C6CF0
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2024 21:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9F81C21C46
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2024 19:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE37015ADBE;
	Wed, 15 May 2024 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fwD/9y4D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542E15AD90;
	Wed, 15 May 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802295; cv=none; b=uwvSBMGhcnUvItrQIJng70Uus+xEC5wSiaenD1WkMV3JVIsvAkyMQiWWfMraWmaMmyU+M88CjUwNEYGOw0fF3ONgQouW4PeWH0nv4x/lslT4n6fVWt9bDmxhE0silVvlF5qX9kcfBYe+o427ZqfJAyCXx5BWNenSLCrP79dP3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802295; c=relaxed/simple;
	bh=aipCqGtKYBLSZAEtX4d0fHZNQSUleXGkdbB2/NndcgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o6mU2kX8oC4BeDuzI1jK9xdtBi+JIKn6IeKE0k87ZpiBwONtaUCVOILW2H8UmF756TXnkHVfDTR1KLUBqWK+UCWCo5Gmtc9lQkTW51M7nJe5rNmnfDFe7WpykZDvFbGH9+xEqw5xCrzH+ZciRkHsi8JfypVr/fx4e+Y9tCssCzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fwD/9y4D reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id cc38f74f4a0bbd45; Wed, 15 May 2024 21:44:45 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 621EB7F3A73;
	Wed, 15 May 2024 21:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715802285;
	bh=aipCqGtKYBLSZAEtX4d0fHZNQSUleXGkdbB2/NndcgY=;
	h=From:To:Cc:Subject:Date;
	b=fwD/9y4DoiOHQZ9dIG+Q0/hj4XU+EGzr79N/2OcAkY9CfcornJ/vRNfNGFMPhltPc
	 dn0OqN6+KTEF49igig8DGVnzZey33YTCxoto52Ftj3J6cJqpiTyo6L2PGkbzcQRC15
	 dR4VkOxgEc0mvE4D9/trDaKUjVUcCBmfzRf/m4J4spBSwtsSErc+hHqGZKHP4epUcm
	 KFjE3lKaFOQeuPuFDBEIXjqoKh67Hm1Aeu1HQrm76IFTGIEFNbBiGy+FLzzO0H0E2Y
	 K+lOKT77kTZfIweUgEBmOZiGzLVZ69fa2xLG+XVAHt81C+4CaN2yeAWtkoTBj+Hkns
	 Kbph3mduKg8WA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject:
 [PATCH v2 0/2] ACPI: EC: Install EC address space handler at the namespace
 root
Date: Wed, 15 May 2024 21:39:15 +0200
Message-ID: <12437901.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedgudefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhgu
 vghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtohepfigprghrmhhinhesghhmgidruggv
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

Hi Everyone,

This is an update of

https://lore.kernel.org/linux-acpi/5787281.DvuYhMxLoT@kreacher/

which was a follow up for the discussion in:

https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t

Patch [1/2] has been updated to avoid possible issues related to
systems with defective platform firmware and patch [2/2] is a resend
with a couple of tags added.

Thanks!




