Return-Path: <linux-acpi+bounces-7990-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7073E964E0E
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85C6B237ED
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB1A1BD035;
	Thu, 29 Aug 2024 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="YkvWv6HA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4F1BC069;
	Thu, 29 Aug 2024 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957077; cv=none; b=JcP+hvZEI0BCa9A2dfysmgProVGErxjhoGVo2B2BXtd1kU33cvbag0cq5M27cmuMKg7m2sGtVfQw8e0Wm4S+ywsVx+Ai0XOZpgiGkT/oz3Avcgiy3pZMxTGRn8fGqhXV4i34dOV1m3SkHC9D9aqqrr/ENxPcTMkiIXsLP41EceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957077; c=relaxed/simple;
	bh=BPhU515HA9sbp9RVBZ9Yr0fC2nG+SR8C5WGkuoPJ8zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1q1pdzMxeCwI5VpUBVZthdi6ftyOS2aXTgzQ+6e1mncpOURUOzMsJ79ybrqXq4mE7oe+bx3ZOUjSq+pkHbsn5JmssCt73XpBrBKLMY7lQuUGuW7XJz6sm3V8VdWMUTrYfjyouX6pfn+n9I+HclLEl9I7q3XMusShd4pvbL4goU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=YkvWv6HA; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 8a35cfb13acde2a4; Thu, 29 Aug 2024 20:44:33 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C1EE46A8C16;
	Thu, 29 Aug 2024 20:44:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957073;
	bh=BPhU515HA9sbp9RVBZ9Yr0fC2nG+SR8C5WGkuoPJ8zI=;
	h=From:Subject:Date;
	b=YkvWv6HAu7RNCfD/SVbY6ufIxHO5AARL7yrurky7NEFU71oYXHWa0TDNAxMRDQ8pp
	 1ESc/zUCDKPuVtD8jHyp4nOzhNpyH5WQGHEsIT15BlfvgPBCc9MZYcfxlh1tNzyRSK
	 tRf80gX4RVYzYw/UjTVo2sZ9Xat1YPCy7PROXaa3s7Uz7uYzmEE6yj10jDO5VGbQ7X
	 LNPMoBX6JNTsCbqpQVKjoQm2xewahK1r/kQMVyoHXVA+vwR/at3KHbOtreNmgSqj0W
	 FIuKKxG4+zPZEfvgLxdmNMPdSOxKUEyEQ1I5oSl5Gl4dnNh9A9HYTp16KyqGCK4CMt
	 pRl7eGs/g0Rdg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 04/20] ACPICA: Headers: Add RISC-V SBI Subtype to DBG2
Date: Thu, 29 Aug 2024 20:28:29 +0200
Message-ID: <2960048.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <5819337.DvuYhMxLoT@rjwysocki.net>
References: <5819337.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjefgjeejgfekjeetkedtkeegjeetjedtgfegtddtfeeigfegueeljedukeeitdenucffohhmrghinhepmhhitghrohhsohhfthdrtghomhdpghhithhhuhgsrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsghrvgesihhnthgvlhdr
 tghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

ACPICA commit 6f4c900bcf9ca065129353f17a83773aa58095aa

Include the RISC-V SBI debugging subtype as documented in DBG2
dated April 10, 2023 [1].

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table # [1]
Link: https://github.com/acpica/acpica/commit/6f4c900b
Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 8cfcd1e1c177..89f0df489dc3 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -755,6 +755,7 @@ struct acpi_dbg2_device {
 #define ACPI_DBG2_16550_WITH_GAS    0x0012
 #define ACPI_DBG2_SDM845_7_372MHZ   0x0013
 #define ACPI_DBG2_INTEL_LPSS        0x0014
+#define ACPI_DBG2_RISCV_SBI_CON     0x0015
 
 #define ACPI_DBG2_1394_STANDARD     0x0000
 
-- 
2.43.0





