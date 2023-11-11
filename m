Return-Path: <linux-acpi+bounces-1417-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43AB7E8B37
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Nov 2023 15:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D1B1C2074F
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Nov 2023 14:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305DD17740
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Nov 2023 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jXlV0bfr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889BB14ABF
	for <linux-acpi@vger.kernel.org>; Sat, 11 Nov 2023 13:48:34 +0000 (UTC)
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682003A9D;
	Sat, 11 Nov 2023 05:48:31 -0800 (PST)
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 81E533F66F;
	Sat, 11 Nov 2023 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1699710509;
	bh=lP4YnLK406Oh78dHgIFdBe0DQkFdIy6q256xnJqXUJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=jXlV0bfrtyG/viewh3F6JofLzBzG5iQNPrui0+u0dNvPV32UNht5POgl1n6pwoy2T
	 KZB+4NDPNDrfCkpGqCNJsFWZdz6IyF5W6Bxae5oTTqKFaXZKfNhw6HFtZAyFxg58/a
	 yVbbtRo8IgY2qbM3XRBgSkr6I5FMqHmFwDawOH7chRIPZkgFXn3xLQQsxQulm7kolk
	 ZG/muAJK3GU4HLGYhcr970+/U+apNC4nFvkq7Kvc+VLlmzASZQXNU7yGACunxxVT5r
	 NtUnesC2aOS2tWz7Kg/XLfZuBITM7Gpl44ND7kgdRBUDnrXUip6fgp4qNLDLje4JL0
	 Z56S0NeRW0FKQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] ACPI: XSDT: struct acpi_table_xsdt must be packed
Date: Sat, 11 Nov 2023 14:48:27 +0100
Message-Id: <20231111134827.174908-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the ACPI 6.5 specification the component Entry starts at
offset 36 in the XSDT table which is not a multiple of 8. Hence we must
mark the structure as packed.

We did not see an error due to the incorrect packing yet as in
acpi_tb_parse_root_table() we use ACPI_ADD_PTR() to find the address of
Entry.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/acpi/actbl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 451f6276da49..1a37ac378765 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -148,7 +148,7 @@ struct acpi_table_rsdt {
 struct acpi_table_xsdt {
 	struct acpi_table_header header;	/* Common ACPI table header */
 	u64 table_offset_entry[1];	/* Array of pointers to ACPI tables */
-};
+} __packed;
 
 #define ACPI_RSDT_ENTRY_SIZE        (sizeof (u32))
 #define ACPI_XSDT_ENTRY_SIZE        (sizeof (u64))
-- 
2.40.1


