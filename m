Return-Path: <linux-acpi+bounces-13286-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E03A9D1B1
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F883BAB60
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807C221F09;
	Fri, 25 Apr 2025 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="KlZDEm/Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A521E0A8;
	Fri, 25 Apr 2025 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609665; cv=none; b=rKbc50s5K5+hOycFgI1UiMoEBefA49AbcJPTDhH8zlluq2RlyWgUUtDqviUwoQ96NQYy3xequzdEwftqRHZdesI+nkUN8VDHVy76lIPrLI3T7Dbwtl9Tx8SnRu1LyNHLLvkJRzoBEIkhRf7XKLH2hBNhdV96i4JiqUMTZAfJGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609665; c=relaxed/simple;
	bh=0MI0aBmXATawN3V0PUL/WS1ALDsJbUtNJjz41S1xg0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7NGOGNiHrg6Sr4NKP+CXMlCprCPkBmt4DJyy6LbIBaRhk29h8pPuyD1yLCcr1HgjN/UDlx2TeopCdbPosPNHn+1lyZ4yGGdqhtLCrnbTYgrfKSWdwh3pXjlME5b79zmreNtHKRnfbSmA+MURlCbGGpCyZIbC1EHetrSmud6wCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=KlZDEm/Y; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CA4836644DF;
	Fri, 25 Apr 2025 21:34:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609655;
	bh=0MI0aBmXATawN3V0PUL/WS1ALDsJbUtNJjz41S1xg0U=;
	h=From:Subject:Date;
	b=KlZDEm/Yf4nJBS0tj28RYxlfsutp5v1Ifsbz5Pm1HkHZX1iYTVA/VHA54HKnHE82q
	 WmUJu+3yDBDAvg5L0AAXm3Z3qsWytSCkMmCSDve4xyUErBByyku5LvrWetHCZb77CF
	 L8VHR8RbPfR3KOELrdjrvhMYBO+8QAT2vmZBY6LchUGE8DCHo8Qcjsxm2hn1g7v8S3
	 3857eJyApqByqCt0ybylFj5U7P7CVIiMDtCVmVMHwn7tpr99AH6Rwv0KcAaLyO7g5c
	 GBAcE4cXgqyjYS0JS7jSlQVKykpL+sn2/DfLOsfgUnwMjcoBSATYyKPwpmw1ovp9Um
	 YiTbl6Te1CeGQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 14/19] ACPICA: actbl2.h: ACPI 6.5: RAS2: Rename structure and field
 names of the RAS2 table
Date: Fri, 25 Apr 2025 21:29:12 +0200
Message-ID: <1942053.CQOukoFCf9@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Shiju Jose <shiju.jose@huawei.com>

ACPICA commit 2c8a38f747de9d977491a494faf0dfaf799b777b

Rename the structure and field names of the RAS2 table to shorten them and
avoid long lines in the ACPI RAS2 drivers.

 1. struct acpi_ras2_shared_memory to struct acpi_ras2_shmem

 2. In struct acpi_ras2_shared_memory: fields,
    - set_capabilities[16] to set_caps[16]
    - num_parameter_blocks to num_param_blks
    - set_capabilities_status to set_caps_status

 3. struct acpi_ras2_patrol_scrub_parameter to
    struct acpi_ras2_patrol_scrub_param

 4. In struct acpi_ras2_patrol_scrub_parameter: fields,
    - patrol_scrub_command to command
    - requested_address_range to req_addr_range
    - actual_address_range to actl_addr_range

Link: https://github.com/acpica/acpica/commit/2c8a38f7
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index ccbf543bceeb..3c2c0730165d 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -3035,15 +3035,15 @@ struct acpi_ras2_pcc_desc {
 
 /* RAS2 Platform Communication Channel Shared Memory Region */
 
-struct acpi_ras2_shared_memory {
+struct acpi_ras2_shmem {
 	u32 signature;
 	u16 command;
 	u16 status;
 	u16 version;
 	u8 features[16];
-	u8 set_capabilities[16];
-	u16 num_parameter_blocks;
-	u32 set_capabilities_status;
+	u8 set_caps[16];
+	u16 num_param_blks;
+	u32 set_caps_status;
 };
 
 /* RAS2 Parameter Block Structure for PATROL_SCRUB */
@@ -3056,11 +3056,11 @@ struct acpi_ras2_parameter_block {
 
 /* RAS2 Parameter Block Structure for PATROL_SCRUB */
 
-struct acpi_ras2_patrol_scrub_parameter {
+struct acpi_ras2_patrol_scrub_param {
 	struct acpi_ras2_parameter_block header;
-	u16 patrol_scrub_command;
-	u64 requested_address_range[2];
-	u64 actual_address_range[2];
+	u16 command;
+	u64 req_addr_range[2];
+	u64 actl_addr_range[2];
 	u32 flags;
 	u32 scrub_params_out;
 	u32 scrub_params_in;
-- 
2.43.0





