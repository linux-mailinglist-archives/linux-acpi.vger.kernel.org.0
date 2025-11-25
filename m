Return-Path: <linux-acpi+bounces-19241-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A3CC83F12
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 09:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFE8A348429
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 08:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182182DC779;
	Tue, 25 Nov 2025 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dS4EU0Gg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81A62D8785;
	Tue, 25 Nov 2025 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764058499; cv=none; b=Hgfjd0jUTJQIpwkjtPacthmsXkO/VQyTgbrIPZbhadOf5g8VYtb+0tYdPzbn+8Dzey4DWvaietnJfds3dcgnAoqRjSsZvFB0KgRyMLKZwT8R6wwe1jJ0U/bJSKTtiKDomTPbSsO5MHlliOTuW5DOmpuJopk/ymZYMPfmOQYYvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764058499; c=relaxed/simple;
	bh=QnNb3Rg0Cnjh7njPROJmsVbynAuz0L77GmBmAM6S4Ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ObnfF17yybqA9eJpsxIL+BZB7Wuvmi9D2vEi1iTxYiM83pFEi8ot1OpJHDAIma4aFycPZL2G5+czCZY+wh3p+LgZN28eQSDT84O9edDMVH0NT3inHl9BEvpHIZu9gCY6V872EZqEPqL4EIH4BdqClst2k80yjGtFfH++Q73JGiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dS4EU0Gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C5EFC4CEF1;
	Tue, 25 Nov 2025 08:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1764058498; bh=QnNb3Rg0Cnjh7njPROJmsVbynAuz0L77GmBmAM6S4Ac=;
	h=From:Date:Subject:To:Cc:From;
	b=dS4EU0GglFGWvG7fDyI3aFhK84BED4WSX9Q+WoLDFxGkWwFezYoVToFT45H1svYFM
	 5yaqy+UUFGt97Wq2I1sqrVs1FYQyM22qduu873LZmel6Jy9M0ve6mktP4bLmC2SFCp
	 eEGUyfpNl8H8cIgjz3IkypmvlncEyMHckHe9t5Ak=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDDBCFD379;
	Tue, 25 Nov 2025 08:14:57 +0000 (UTC)
From: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Date: Tue, 25 Nov 2025 16:14:38 +0800
Subject: [PATCH] ACPICA: Avoid walking the Namespace if StartNode is NULL
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-acpica-v1-1-99e63b1b25f8@linux.dev>
X-B4-Tracking: v=1; b=H4sIAG1lJWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyNT3cTkgszkRN3UtFTTRNO0ZAPDFEsloOKCotS0zAqwQdGxtbUAeGp
 fDFgAAAA=
X-Change-ID: 20251125-acpica-efe5a5fc01d9
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>, 
 Kexy Biscuit <kexybiscuit@aosc.io>, Wentao Guan <guanwentao@uniontech.com>, 
 zhanjun@uniontech.com, niecheng1@uniontech.com, 
 Cryolitia PukNgae <cryolitia@deepin.org>, 
 Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764058497; l=1953;
 i=cryolitia.pukngae@linux.dev; s=20250730; h=from:subject:message-id;
 bh=QnNb3Rg0Cnjh7njPROJmsVbynAuz0L77GmBmAM6S4Ac=;
 b=AGRGG95C86u4Pf5GvMzwCi3bhEDAW7nug8pzVPLRdDT4UBucJbj2650Vod+CnDbW5JUPtZxYM
 HXHJUU9sHujAy0o59jKmCQZiSyaL+lAv5VDnj+wN8ozPEwRr7CMdsJ2
X-Developer-Key: i=cryolitia.pukngae@linux.dev; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia.pukngae@linux.dev/20250730
 with auth_id=540

ACPICA commit 1c1b57b9eba4554cb132ee658dd942c0210ed20d

Since commit 0c9992315e73 ("ACPICA: Avoid walking the ACPI Namespace
if it is not there") fixed the situation that both StartNode and
AcpiGbl_RootNode is NULL. The Linux kernel mainline now still crashed
on Honor Magicbook 14 Pro[1]. Due to the access to the member of
ParentNode in AcpiNsGetNextNode, the NULL pointer dereference will
always happen, no matter whether the StartNode equals to the
ACPI_ROOT_OBJECT or not. So we move the check of StartNode being NULL
out of the if block.

Unfortunately, all the attempt to contact with Honor has failed, they
refused to provide any technical support for Linux. The bad DSDT
table's dump could be found on GitHub[2].

DMI: HONOR FMB-P/FMB-P-PCB, BIOS 1.13 05/08/2025

1. https://gist.github.com/Cryolitia/a860ffc97437dcd2cd988371d5b73ed7
2. https://github.com/denis-bb/honor-fmb-p-dsdt

Signed-off-by: Cryolitia PukNgae <cryolitia@deepin.org>
Link: https://github.com/acpica/acpica/pull/1061
Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
---
 drivers/acpi/acpica/nswalk.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index a2ac06a26e92..5670ff5a43cd 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -169,9 +169,12 @@ acpi_ns_walk_namespace(acpi_object_type type,
 
 	if (start_node == ACPI_ROOT_OBJECT) {
 		start_node = acpi_gbl_root_node;
-		if (!start_node) {
-			return_ACPI_STATUS(AE_NO_NAMESPACE);
-		}
+	}
+
+	/* Avoid walking the namespace if the StartNode is NULL */
+
+	if (!start_node) {
+		return_ACPI_STATUS(AE_NO_NAMESPACE);
 	}
 
 	/* Null child means "get first node" */

---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20251125-acpica-efe5a5fc01d9

Best regards,
-- 
Cryolitia PukNgae <cryolitia.pukngae@linux.dev>



