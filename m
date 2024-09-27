Return-Path: <linux-acpi+bounces-8463-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEC39886F3
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 16:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF53D1C22FAF
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88D913BAF1;
	Fri, 27 Sep 2024 14:21:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F813BAE2;
	Fri, 27 Sep 2024 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446887; cv=none; b=uUrCaKAoDgpMX3M0GtC9kzNKqyx2bvjzwMfTeNddEi7JKadVb5Bdl9xgsoBjn+hWVJZJd5Yb/fD8OZr+KfvIWEiwKgiOP++yXROkxmvGVutmUQpTyNquhgUntjd1/lCrIX7Sai0q8hkY0wSn1mfyT/wZ1UtznpMNLv3n3wW0XEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446887; c=relaxed/simple;
	bh=Esi3LywVgXAkX9q5mkmMPV9lH5AHWqgn85hQw1zVPpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X65KH/ODoIGxqxO4QAPFlBebT9CIGLmtQP1VfylqbUVaZJOYnDyM7AD413VYfNBOOeJl4W1/ZFX553JsL+hjvnceHsseYGBZUBOWASlzSiHQbOj1z65GG2ve910FSs93l9jfhQ+whLk8NaD+QI0PV2LFJgNzckaWIbZMwPHWe4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D3DC4CECD;
	Fri, 27 Sep 2024 14:21:26 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	bp@alien8.de,
	dan.j.williams@intel.com,
	tony.luck@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com
Subject: [RFC PATCH 1/6] ACPICA: actbl1.h: Add extended linear address mode to MSCIS
Date: Fri, 27 Sep 2024 07:16:53 -0700
Message-ID: <20240927142108.1156362-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240927142108.1156362-1-dave.jiang@intel.com>
References: <20240927142108.1156362-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ECN for "Extended-linear" addressing for direct-mapped memory-side caches
adds a field in the SRAT Memory Side CAche Information Structure to
indicate the address mode at the previously reserved bytes at offset 28.

The field is described as:
When Address Mode is 1 'Extended-Linear' it indicates that the
associated address range (SRAT.MemoryAffinityStructure.Length) is
comprised of the backing store capacity extended by the cache
capacity. It is arranged such that there are N directly addressable
aliases of a given cacheline where N is an integer ratio of target memory
proximity domain size and the memory side cache size. Where the N
aliased addresses for a given cacheline all share the same result
for the operation 'address modulo cache size'. This setting is only
allowed when 'Cache Associativity' is 'Direct Map'."

Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
Link: https://github.com/acpica/acpica/pull/961
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/acpi/actbl1.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 841ef9f22795..95ddc858a0c3 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1791,7 +1791,7 @@ struct acpi_hmat_cache {
 	u32 reserved1;
 	u64 cache_size;
 	u32 cache_attributes;
-	u16 reserved2;
+	u16 address_mode;
 	u16 number_of_SMBIOShandles;
 };
 
@@ -1803,6 +1803,9 @@ struct acpi_hmat_cache {
 #define ACPI_HMAT_WRITE_POLICY          (0x0000F000)
 #define ACPI_HMAT_CACHE_LINE_SIZE       (0xFFFF0000)
 
+#define ACPI_HMAT_CACHE_MODE_UNKNOWN		(0)
+#define ACPI_HMAT_CACHE_MODE_EXTENDED_LINEAR	(1)
+
 /* Values for cache associativity flag */
 
 #define ACPI_HMAT_CA_NONE                     (0)
-- 
2.46.1


