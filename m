Return-Path: <linux-acpi+bounces-13069-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30ECA8ABFF
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Apr 2025 01:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE813BBDD9
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 23:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98282D8DA1;
	Tue, 15 Apr 2025 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHsLz5Km"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504C1C54B2;
	Tue, 15 Apr 2025 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759233; cv=none; b=hoe32qsvHVLwtOQDOQ5Gm/0xlgawp9iox6OIZlGLXeoq0k28BL292ZNe9rZUmx2qbH7IFYkqu7XaXopjeKBucTJGVWWAS0iovFoScj3LMG05HM9JSIGtdAtp68FOxalX/GEMry63X7GL+hPiCqqCjVoUd+RParZyy4brqpbW0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759233; c=relaxed/simple;
	bh=ba187HjfDG+ALjqx85rVDK6TpqjUBOiJ5BEKK23LXQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avASMc7MW3xmNqwvX/VLChf0yCwRQiDJeF+3TL9SAK6BNwDP+MaOmxoVvA6Zer8dpcBx/R9RLubjKtHEqxlFQxqOJGiW5G+UV0g/C2+pzvqIjYUtfzuoydgbjKlAqIb5nJ7K83VFC7LtAyM1v+VpZQKRffa18nomI8w5rmOkVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHsLz5Km; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF18C4CEE7;
	Tue, 15 Apr 2025 23:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744759232;
	bh=ba187HjfDG+ALjqx85rVDK6TpqjUBOiJ5BEKK23LXQU=;
	h=From:To:Cc:Subject:Date:From;
	b=nHsLz5KmqG0ArnVipWQ/9yH2bVSLWi8xw8j11eGL/c1224IZGpfB8fu1JQbyIGL9Z
	 LU/NjivEMN7ufh9GTz82GZ8Dammf/KLYgMI285fFVPwM92opuKKMhexO6Pv/HA2F1a
	 Hza3XSlo6FYsHYTu8R1BVeC9FOpK8GmMmuqexp4QrJiubrupi2sSKfV9K7QJY5fEor
	 OLMuGeFNOKqd93qRt7IICvtWnrU8eO+yCXn28sI3NecYva4VioZ1nFxNAis6vHU9p5
	 zCXahJaHQe9djKECZfJs9ICJjnLOZTChcGdtrhjSrWzQaCStUxPM4UXtZkkdS3VNkO
	 oJRTM0Q9hyt3A==
From: Kees Cook <kees@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ACPI: tables: Add __nonstring annotations for unterminated strings
Date: Tue, 15 Apr 2025 16:20:29 -0700
Message-Id: <20250415232028.work.843-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2810; i=kees@kernel.org; h=from:subject:message-id; bh=ba187HjfDG+ALjqx85rVDK6TpqjUBOiJ5BEKK23LXQU=; b=owGbwMvMwCVmps19z/KJym7G02pJDOn/Xu5ReLm1fb2qZ+G7uy2bGoNm+5i82ZYkZ9Vi23k1o kGtaIlkRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQ6/jIyTPEUP9a5ulRXK//5 vELvmWJ9WkLMV47unM0rZiy0uTBQhOGfygY9FgbZI3ffJj/0qSvY/ef23q+/Du7d/X1yNmO/7QM 5NgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the 4-byte
ACPI identifier arrays with __nonstring (and the new __nonstring_array)
to correctly identify the char arrays as "not C strings" and thereby
eliminate the many warnings like this:

In file included from include/acpi/actbl.h:371,
                 from include/acpi/acpi.h:26,
                 from include/linux/acpi.h:26,
                 from drivers/acpi/tables.c:19:
include/acpi/actbl1.h:30:33: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (5 chars into 4 available) [-Wunterminated-string-initialization]
   30 | #define ACPI_SIG_BERT           "BERT"  /* Boot Error Record Table */
      |                                 ^~~~~~
drivers/acpi/tables.c:400:9: note: in expansion of macro 'ACPI_SIG_BERT'
  400 |         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
      |         ^~~~~~~~~~~~~

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev
---
 drivers/acpi/tables.c | 2 +-
 include/acpi/actbl.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2295abbecd14..0a9ade7117bd 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -396,7 +396,7 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
 }
 
 /* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
-static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
+static const char table_sigs[][ACPI_NAMESEG_SIZE] __nonstring_array __initconst = {
 	ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
 	ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
 	ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT,
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 451f6276da49..2fc89704be17 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -66,7 +66,7 @@
  ******************************************************************************/
 
 struct acpi_table_header {
-	char signature[ACPI_NAMESEG_SIZE];	/* ASCII table signature */
+	char signature[ACPI_NAMESEG_SIZE] __nonstring;	/* ASCII table signature */
 	u32 length;		/* Length of table in bytes, including this header */
 	u8 revision;		/* ACPI Specification minor version number */
 	u8 checksum;		/* To make sum of entire table == 0 */
-- 
2.34.1


