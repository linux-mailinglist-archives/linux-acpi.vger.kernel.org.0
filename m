Return-Path: <linux-acpi+bounces-12468-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440CFA7208F
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1739017AE29
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5337E264A88;
	Wed, 26 Mar 2025 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="u1VdDq6a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B20262802;
	Wed, 26 Mar 2025 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023531; cv=none; b=sk6t1AevALbxWPQgEYN1u8iwD1oH5LhqHPfI27JyrUxsdP1Y06UtSgBaaGKkO88zj0bID1/kIQIzcUhu/nlggyrbY5spmclVm+5FcEKz1qDRopzKCrovd0VYTohv6Mb5NNMU32xoK2tl3hpq8aNUf8MvClv7wuU8Q6WIx4O0w0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023531; c=relaxed/simple;
	bh=o8k717XIoqnvP/vehE0hXmP4cFalMLYYI51T0EPozzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0F0y/Qf6ZkUhBLxSn4tuyYmsVb4sPmT9NQDzLdmxUm/jP2wkJAN0XlLJCGv1ZVKns4QXYNCP3LLHvJvWk0y+q9o7rFYSc8sTj3ddrMmgq7500ycJVZJ8JpE8+Pxgbnz9RPn/NOPYzDEkimPtl0wqmI2sv8pFM3hHzwMMekYghY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=u1VdDq6a; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id f69fe34f09c738e7; Wed, 26 Mar 2025 21:12:07 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B51627F6388;
	Wed, 26 Mar 2025 21:12:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743019927;
	bh=o8k717XIoqnvP/vehE0hXmP4cFalMLYYI51T0EPozzU=;
	h=From:Subject:Date;
	b=u1VdDq6a6g0fPfp8V0CzLpt1KlGFJEECkU8A1710Wk4HgErSxDSDMLPeqEi1PzPGN
	 2Z+VVBD8TxMbcZqe13v1YdZffAYcKE3WOGbLGip1mRIrzDXE5rcHCl9I92gEStV3Lo
	 Mzx0UiTf6brwWK6jWM6fRsDBXBSkEs/TItJQX5YKVgiNTe9cFzIPSSKsXflzJRzBUS
	 BxEGiJ0Fb1c6LmZovJibmu5Fm6/FPrAG86LxlYUV0nJAyqCmArugmvBpO1D5w0ETdF
	 Aio8wG4CIhARFeGvFKGQ8KUeGRMtGai0wMAtge6IKxKaOQSp5Io9tvQFYtnyLTkiRx
	 ZNfriG1PHFVMg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 4/8] ACPICA: actbl1: Update values to hex to follow ACPI specs
Date: Wed, 26 Mar 2025 21:07:57 +0100
Message-ID: <13729719.uLZWGnKmhe@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeigeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepveehheehueelffeguefgteeuffffgfelhfeghfdvkeffueehteejjeegudeileeknecuffhomhgrihhnpehuvghfihdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsghrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Zaid Alali <zaidal@os.amperecomputing.com>

ACPICA commit 0b44ed75fb551bf3fbbbd39ca72bd932872fff20

ACPI specs(1) define Error Injection Actions in hex values.
This commit intends to update values from decimal to hex to be
consistent with ACPI specs.

Link: https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html (1)
Link: https://github.com/acpica/acpica/commit/0b44ed75
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 387fc821703a..1dc29933e2a3 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1024,17 +1024,17 @@ struct acpi_einj_entry {
 /* Values for Action field above */
 
 enum acpi_einj_actions {
-	ACPI_EINJ_BEGIN_OPERATION = 0,
-	ACPI_EINJ_GET_TRIGGER_TABLE = 1,
-	ACPI_EINJ_SET_ERROR_TYPE = 2,
-	ACPI_EINJ_GET_ERROR_TYPE = 3,
-	ACPI_EINJ_END_OPERATION = 4,
-	ACPI_EINJ_EXECUTE_OPERATION = 5,
-	ACPI_EINJ_CHECK_BUSY_STATUS = 6,
-	ACPI_EINJ_GET_COMMAND_STATUS = 7,
-	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS = 8,
-	ACPI_EINJ_GET_EXECUTE_TIMINGS = 9,
-	ACPI_EINJ_ACTION_RESERVED = 10,	/* 10 and greater are reserved */
+	ACPI_EINJ_BEGIN_OPERATION = 0x0,
+	ACPI_EINJ_GET_TRIGGER_TABLE = 0x1,
+	ACPI_EINJ_SET_ERROR_TYPE = 0x2,
+	ACPI_EINJ_GET_ERROR_TYPE = 0x3,
+	ACPI_EINJ_END_OPERATION = 0x4,
+	ACPI_EINJ_EXECUTE_OPERATION = 0x5,
+	ACPI_EINJ_CHECK_BUSY_STATUS = 0x6,
+	ACPI_EINJ_GET_COMMAND_STATUS = 0x7,
+	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS = 0x8,
+	ACPI_EINJ_GET_EXECUTE_TIMINGS = 0x9,
+	ACPI_EINJ_ACTION_RESERVED = 0xA,	/* 10 and greater are reserved */
 	ACPI_EINJ_TRIGGER_ERROR = 0xFF	/* Except for this value */
 };
 
-- 
2.43.0





