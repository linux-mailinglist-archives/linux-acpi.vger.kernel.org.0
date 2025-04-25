Return-Path: <linux-acpi+bounces-13293-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59308A9D1C4
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647211B81CC5
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FF221E0A2;
	Fri, 25 Apr 2025 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Qsa/V48j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995422424F;
	Fri, 25 Apr 2025 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609669; cv=none; b=HlYzQf6yVJ/sHuOpQiwbPg/bTJ8LAMAB6usf2UJ0ORRx+JsG/tsPpsMvkJvvyF4IjfVpHDPomGHtOK5ccPIGy4DVz6Cmb9KYOj0hocttgt4ClmK5KB3r6N3TLb77/llVdyXjzbEip3wBHMk3tiiN4di1DyyJb8XkWP4yWMGn+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609669; c=relaxed/simple;
	bh=OyFn51IdBevH5sjLGd5N+sOiVTaOZxPw/FiBI2Mw79k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIrEpoH6UITfCGYLpl6efucCwI5xiIFWicEgoApD1IZIv9/VAp/hjpZE3B7bXQm7ZcX5LHiU5v/mlfCt/De8ZN2812gaJq0myWdkuGVpl+ZW3BtcNkAI+8tR0EtQkQw3/Eex9O717fEcP34pIA9FLq1v0DvvbyLrvvMvKwNjZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Qsa/V48j; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8A0DE663C4C;
	Fri, 25 Apr 2025 21:34:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609664;
	bh=OyFn51IdBevH5sjLGd5N+sOiVTaOZxPw/FiBI2Mw79k=;
	h=From:Subject:Date;
	b=Qsa/V48jMeMDRi8O4aR1kOmbkq8cO96HivJoDmKl4D9SFEz+dxYlkSknpEC9lCEqq
	 Qb6U3gXH9N24gHk8MRLRq+CLC7SyXlP5TZ61Dx2S+/m8k5FGL6Yy9dsAiNR8MKI1Yp
	 gzQD/jGLYZcbvgJ+DKqHGA5xR37nYvRt2Qrqp6syMv+0vnUrcoDofssAENbX7DNTe4
	 kwEG16C2bhle1uBSs3oKYw3E8F5KUiF/tT+PDRk8V1/cwz05z51fMcZkXSOR1dhzC1
	 pUQwwK3mj+ZVdCdlrjKMmxd+CiC2TcLz/ZBqAeGPKgFMATQ/DId18Lbup9GWV0ngzO
	 M8Txd8LCOJqpg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 05/19] ACPICA: infrastructure: Add new header and  ACPI_DMT_BUF26
 types
Date: Fri, 25 Apr 2025 21:23:17 +0200
Message-ID: <3005638.e9J7NaK4W3@rjwysocki.net>
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

ACPICA commit 52840d3826bd7e183fcb555e044e190aea0b5021

New MRRM tables can have subtables that are larger than 255 bytes.

Add a new header typedef that uses u16 for Length. Could be
backported to acpi_aspt_header, struct acpi_dmar_header, struct acpi_nfit_header,
struct acpi_prmt_module_header, struct acpi_prmt_module_info. Will be used for
upcoming ERDT table.

MRRM table has a 26-byte reserved section in header. Add ACPI_DMT_BUF26
to describe this in struct acpi_dmtable_info.

Link: https://github.com/acpica/acpica/commit/52840d38
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index e0cbda95fec8..b403b0b60bf6 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -155,6 +155,13 @@ struct acpi_aspt_acpi_mbox_regs {
 	u64 reserved2[2];
 };
 
+/* Larger subtable header (when Length can exceed 255) */
+
+struct acpi_subtable_header_16 {
+	u16 type;
+	u16 length;
+};
+
 /*******************************************************************************
  *
  * ASF - Alert Standard Format table (Signature "ASF!")
-- 
2.43.0





