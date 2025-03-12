Return-Path: <linux-acpi+bounces-12126-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A316A5E221
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 17:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FF6189E060
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654D324BC09;
	Wed, 12 Mar 2025 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2wnzQv1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D441B87F3;
	Wed, 12 Mar 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798777; cv=none; b=deKG/llKAGIzK5ZEDCg4YV6pzZH6rRFbcLmX2uYg6VLtS8h21BpaPk/ym3NAg/GgIdDG0uetvU1ymHEixS9AS1xMCl3bRqfHs45MCT4Po0jSb89jLjup5mkOcEGm/OgEdvbcNzraXGpUvnZ07vhOwn/uyLISyH2YTGJCrnyfgcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798777; c=relaxed/simple;
	bh=OXSXt8JRe88bc9jaXTJlcjEd0ik8aTsjuG+zs9/eZaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z7zds31/IE8zAjKuVXMt0xa+GpQJ9pBmxV+8FlzuQf7WmYuGIyiNMRK9kAo9q886EyQiZUsVlO6UFRgF7v5YsDxY9ncE7zuOCuQoakDIVR9GD7RZjwYv/Rph5uCEqBjSezRGoJ1Wz3tRmmxOS0U9tVEnNoXjeNR3R/AnTDr8tvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2wnzQv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B538C4CEDD;
	Wed, 12 Mar 2025 16:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741798776;
	bh=OXSXt8JRe88bc9jaXTJlcjEd0ik8aTsjuG+zs9/eZaI=;
	h=From:To:Cc:Subject:Date:From;
	b=E2wnzQv1viG1OqsjF5pEOKKwikOm93zMtTKoqGTq/QJtFrwPzEetbWoGBMrrem2nO
	 NQySivLpTB+Og+UmDkwJnhILHKzOBixJXNufqWGaxaMLb6YBfJ5zUCvK1Kw1+RhN8W
	 UW7YzURoE/2NhWK+ZGJ6lZ8QJ1RN7gc9P8O67Lj18gae/Wfv1F2cn6ErsjOjuqtLCe
	 9/lIuC6VpFlAs/IqscPnDv0mp73xUWadrF6j1xvi9tpDMdquZV1JWVZsF5sk3OkJnS
	 rPxZQ0sVOmQ1q5M9CJjWYVIMTvM7bNi28RxjHMbEcypQ8lQuK6lxOQSrEMQeocm2O+
	 bw9JazyP3CG7Q==
From: Kees Cook <kees@kernel.org>
To: Robert Moore <robert.moore@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ACPICA: Add __nonstring annotations for unterminated strings
Date: Wed, 12 Mar 2025 09:59:26 -0700
Message-Id: <20250312165922.work.963-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2399; i=kees@kernel.org; h=from:subject:message-id; bh=OXSXt8JRe88bc9jaXTJlcjEd0ik8aTsjuG+zs9/eZaI=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkX9+ZazYmIiOUK2eQpuJCbX615XdMqtcIDryftZFbbq e+yx/JLRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEROxzP8d93WHr1d+sieVc8d lE8k7dmZ6/XpqLWV5+t/vxW4HTYtu8HIsPMS+xUe0UUMtc7rE7/G++TmJ6lMXN4d5PzX/2p2Qso 9fgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
I wanted to send this as the fix from the "Linux perspective", but
I know ACPICA is separate upstream, and likely the fixes will come
from there. To that end, I've proposed these changes uptream as well:
https://github.com/acpica/acpica/pull/1006

Cc: Robert Moore <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev
---
 drivers/acpi/acpica/aclocal.h   | 4 ++--
 drivers/acpi/acpica/nsrepair2.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 6f4fe47c955b..6481c48c22bb 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -293,7 +293,7 @@ acpi_status (*acpi_internal_method) (struct acpi_walk_state * walk_state);
  * expected_return_btypes - Allowed type(s) for the return value
  */
 struct acpi_name_info {
-	char name[ACPI_NAMESEG_SIZE];
+	char name[ACPI_NAMESEG_SIZE] __nonstring;
 	u16 argument_list;
 	u8 expected_btypes;
 };
@@ -370,7 +370,7 @@ typedef acpi_status (*acpi_object_converter) (struct acpi_namespace_node *
 					      converted_object);
 
 struct acpi_simple_repair_info {
-	char name[ACPI_NAMESEG_SIZE];
+	char name[ACPI_NAMESEG_SIZE] __nonstring;
 	u32 unexpected_btypes;
 	u32 package_index;
 	acpi_object_converter object_converter;
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 1bb7b71f07f1..330b5e4711da 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -25,7 +25,7 @@ acpi_status (*acpi_repair_function) (struct acpi_evaluate_info * info,
 				     return_object_ptr);
 
 typedef struct acpi_repair_info {
-	char name[ACPI_NAMESEG_SIZE];
+	char name[ACPI_NAMESEG_SIZE] __nonstring;
 	acpi_repair_function repair_function;
 
 } acpi_repair_info;
-- 
2.34.1


