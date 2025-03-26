Return-Path: <linux-acpi+bounces-12466-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2346A7208B
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A163B6480
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5212B263C6C;
	Wed, 26 Mar 2025 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="repq7EoR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D925EFAE;
	Wed, 26 Mar 2025 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023529; cv=none; b=blaU7cPmX/lRTpPAkdFRK0RHg3c4HIlensihzlpzpE+hf0ErCN2T26yMGcjf3+8JkAR6pNT+gRUhe525r3Pi9cfieAytNpyZRILjGpTusNm68qnHBlsX14Dkid8y1ceA5MWTwck12xGrxkLRzPQ+dAPdrXhqOyd+3eh1zHUr7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023529; c=relaxed/simple;
	bh=lX6+zTT7ArT628pQvMIt/Li9iIBWCbQgHcaF3SsxxTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShG4N0+7VPTLQnG/uJ9NO+xxGNd4Go6Sd3BZmMeYXGpgy1byCNP4V6IkOahxfwk7UVKbxZdruQwQQrDRuGHfcWEaF2COk34DXd+Kwm6aW35DZ3noYzQD7eP4Mb1ScI3rwVa4Aht60tWKZ1keXXz9CcDaI/HCscP0cRBwtIektks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=repq7EoR; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id a7671533f0b139b5; Wed, 26 Mar 2025 21:12:05 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E0D777F6388;
	Wed, 26 Mar 2025 21:12:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743019925;
	bh=lX6+zTT7ArT628pQvMIt/Li9iIBWCbQgHcaF3SsxxTI=;
	h=From:Subject:Date;
	b=repq7EoRo2qmYCfKMkh4S/MFsi3kW12Y9MZSxy+cIVEQMEKcF7CK0PG/uJPVttLPl
	 HyTcZirPEGrNazlYhj/dRMm3E125CSvzBKDvCy4NLj9AKENMhsOSu1B4gF7vhpZBXt
	 TrZ8sbe56lojaJ47r2Gq5g4xCrJq49cQWqidI0U98YqnVsmNopgDo8jsVrNBVcdip5
	 A93LxB+FlAJt+IlgOhK6vX88k35rAHWYiJGGxojfb48DUciAVUQAoBuPGzbitiaRQa
	 fvOz7D0LEM3LiccW68jPvBRijxkXxH6i+ozm+6552cI/8uY50daGvTufzzvPCRQbdH
	 wSn9J460AYLzw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 6/8] ACPICA: Fix typo in comments for SRAT structures
Date: Wed, 26 Mar 2025 21:09:53 +0100
Message-ID: <8507690.T7Z3S40VBb@rjwysocki.net>
In-Reply-To: <5873907.DvuYhMxLoT@rjwysocki.net>
References: <5873907.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeigeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Adam Lackorzynski <adam@l4re.org>

ACPICA commit 218b5b3654b355e7481cbee8209f5212201b1196

Link: https://github.com/acpica/acpica/commit/218b5b36
Signed-off-by: Adam Lackorzynski <adam@l4re.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 5cd755143b7d..14082dd445f2 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -269,7 +269,7 @@ struct acpi_srat_gicc_affinity {
 
 #define ACPI_SRAT_GICC_ENABLED     (1)	/* 00: Use affinity structure */
 
-/* 4: GCC ITS Affinity (ACPI 6.2) */
+/* 4: GIC ITS Affinity (ACPI 6.2) */
 
 struct acpi_srat_gic_its_affinity {
 	struct acpi_subtable_header header;
-- 
2.43.0





