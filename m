Return-Path: <linux-acpi+bounces-13288-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02813A9D1B7
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE12F1BC17DB
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE31223302;
	Fri, 25 Apr 2025 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="yHukXgLJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907ED221567;
	Fri, 25 Apr 2025 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609666; cv=none; b=JXtP7dahvVAoO2NARydL2kMVmZgyl6pppAXHiZP3NQ0HPuRbI1TXX5k/tBTWt/4e9ow6L2fnqEbWtD8nOmrbMuV/m5yJdeKHMMblD1b/EQi2R8kjnNqI5rdiYe+CKyKdQRvI46DKxbqAIiWWcOlBvpc5XqiOVSxyDSdCUbDCHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609666; c=relaxed/simple;
	bh=ttESHxoGQS0X2vMOzL67rlzoGp6Qjw1IZDEeuKq7kjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFDy5ICjh/H+6jyqjc+jTDhDta4zohx4JX7VLtbWoYZOLBUzeXULBRbwshoDOZJ8vdWbXyyAbA25c2M6mOlTuEkQsrIFaijwHtj7winztgDGXK3Q8pBQ2nHtF8t5JfXMOlowGzU1CWXRFZmJz7FvTCUfT9k70NfYyr+hTKkFxek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=yHukXgLJ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CC874664706;
	Fri, 25 Apr 2025 21:34:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609659;
	bh=ttESHxoGQS0X2vMOzL67rlzoGp6Qjw1IZDEeuKq7kjs=;
	h=From:Subject:Date;
	b=yHukXgLJ/i9xuHSWC3Yp1LmbTRuuanzy9LXMoFD4x7SPQePsI7YVSLD0UqeQ+k/Jl
	 Y5/9H/Gnp6429frwOt3BLlaT4E1MvEQLeNOT8UsEhky82nRqIw9IcRJU4e4tV2eS16
	 495mOM6d8ddzkA98RPlVRMojUPUrrJUkxsCokeMPOLH74jlvh3trnRkFfG1EpXWCJB
	 tH0B7otG7vXKHcSuXHuRvXFbmzuXO7nnGuzLIwBG/uNEQNcSJtQpWoeODS/FfUrTrE
	 gL3a53RIf7V+MDm+oIHsoD/MecsZHBq1b/diQ0ea2gqL+oaJWgB4Evqchcfej9n+vL
	 bLfKuQlPwVV+g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 10/19] ACPICA: infrastructure: Add new DMT_BUF types and  shorten a
 long name
Date: Fri, 25 Apr 2025 21:26:44 +0200
Message-ID: <3643286.iIbC2pHGDl@rjwysocki.net>
In-Reply-To: <12671029.O9o76ZdvQC@rjwysocki.net>
References: <12671029.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Tony Luck <tony.luck@intel.com>

ACPICA commit b8713f71b4023a0396fe61503bbbf5226e5eed1b

Some ERDT subtables have 11 and 24 byte reserved fields.

Add the ACPI_DMT_BUF11 and ACPI_DMT_BUF24 types to describe these reserved
fields in struct acpi_dmtable_info structures.

Shorten the ACPI_SUBTABLE_HEADER_16 name to ACPI_SUBTBL_HDR

Link: https://github.com/acpica/acpica/commit/b8713f71
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 2 +-
 include/acpi/actbl2.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index b403b0b60bf6..6d2cc181e3a4 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -157,7 +157,7 @@ struct acpi_aspt_acpi_mbox_regs {
 
 /* Larger subtable header (when Length can exceed 255) */
 
-struct acpi_subtable_header_16 {
+struct acpi_subtbl_hdr_16 {
 	u16 type;
 	u16 length;
 };
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 274b3b85b6d7..2c07b097ef9f 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1764,7 +1764,7 @@ struct acpi_table_mrrm {
 	******************************************************************************/
 
 struct acpi_mrrm_mem_range_entry {
-	struct acpi_subtable_header_16 header;
+	struct acpi_subtbl_hdr_16 header;
 	u32 reserved0;		/* Reserved */
 	u64 addr_base;		/* Base addr of the mem range */
 	u64 addr_len;		/* Length of the mem range */
-- 
2.43.0





