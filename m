Return-Path: <linux-acpi+bounces-7989-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE7B964E0C
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668C2286568
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732141BCA1B;
	Thu, 29 Aug 2024 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="SN90roWw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DABB1BBBC5;
	Thu, 29 Aug 2024 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957076; cv=none; b=rfbwX0TGPnPu1Dz2lozkdP3Fk0GxHY9KAfNjY/xlbgxwdmklujNIotPVgV1m9gVDpPP1w5vzCxhggGqYh7reVHLl987I0lDhAS4aOdMh3CM3bR4w0mtmUlmwJvXlcafCwDD6eAGXlSwoBBpsGnJw1FzGJgD6/ZFR3q7pBC5cMZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957076; c=relaxed/simple;
	bh=oJWa1kyNjP1D7I2Usd0069b+swoaF1NTsD+2b5HCttc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a80ZIBVMr4Atz6sQn+fLtmdbvoSuPcpNy2A+TNwM2aNXpovR1N7o11HADF5xXiGkMzjkokqNe/SN1Ar1hFE6HOhkK7mW3qrDdggDOQrKG4eBI5E2qJgHiwT7/Gz3V7oosud+FIFa9sF1Ac3Dq6XTIjAq+XzWJuKe4cLgW/A9eo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=SN90roWw reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 24dfa355a6d8662c; Thu, 29 Aug 2024 20:44:32 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id BB6DD6A8C15;
	Thu, 29 Aug 2024 20:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957072;
	bh=oJWa1kyNjP1D7I2Usd0069b+swoaF1NTsD+2b5HCttc=;
	h=From:Subject:Date;
	b=SN90roWwOF0Hb5Qj3/liU6gEVKocdVhrz2oExQxwsXOEE5fg7Cv3X476sZzTbp0Z5
	 5uTf5bri4zwrf63c507Qeufy8lwG7sr4zWysJxAppQLz00FYVNpA9hK7l+RR7rUWqA
	 mp9Y5xCLdZ/KBX6dh5C804lBUxK2TqBXTAQ8DACll0G0TbE3B11zaEHhHbDq08d9ww
	 CRBvHcQoZDLwyb2WOVf94cHeSntzzVC4C6UCJFn2x9SRqSKfV2za8NeEdcauhKACeA
	 bW7Qf/XWITTAX7VdRiyO6/+y1dC+FcyjuM0CVYX98i09BVWE8PcbQ4BCO9mjC1svRc
	 fg+KPwK0jkRuQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 05/20] ACPICA: Implement the Dword_PCC Resource Descriptor Macro
Date: Thu, 29 Aug 2024 20:29:26 +0200
Message-ID: <3322262.44csPzL39Z@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeeuteeilefhueefgfffteeihfduudevjeefhfejfedvleeuheekledttdetvdeuvdenucffohhmrghinhepthhirghnohgtohhrvgdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsghrvgesihhnthgvlhdr
 tghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Jose Marinho <jose.marinho@arm.com>

ACPICA commit 1209ecf682e03d9ef0c22f4986a2e53b03bd2985

The Dword_pcc (alongside word_pcc and Qword_pcc) were accepted to ACPI
inclusion via a code-first process.

This patch implements support in iASL for Dword_pcc.

Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4594
Link: https://github.com/acpica/acpica/commit/1209ecf6
Signed-off-by: Jose Marinho <jose.marinho@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/aclocal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 02012168a087..6f4fe47c955b 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1090,6 +1090,8 @@ struct acpi_port_info {
 #define ACPI_ADDRESS_TYPE_IO_RANGE              1
 #define ACPI_ADDRESS_TYPE_BUS_NUMBER_RANGE      2
 
+#define ACPI_ADDRESS_TYPE_PCC_NUMBER            0xA
+
 /* Resource descriptor types and masks */
 
 #define ACPI_RESOURCE_NAME_LARGE                0x80
-- 
2.43.0





