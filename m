Return-Path: <linux-acpi+bounces-20307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D0BD1EDF5
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E6ED309BE62
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946EF39B49A;
	Wed, 14 Jan 2026 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgB00Mf+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7215839B483;
	Wed, 14 Jan 2026 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394542; cv=none; b=qSeOioo82/y/dOo4Sv734A+SUr6v+BRsIZPb1VTgOyvK793LPlZ52nYVhJOJ3T5xI7Gr2pDqDmFQqlp0jjYb7wDNhWOQ4QMnHfCdSRVrjwf6vAzKovKXHoCBpkLVUVcReOTkCMfUPQo1xZ8Hdg1ZOTaohV2HyoYgLI9HRLHr8Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394542; c=relaxed/simple;
	bh=nRBzlc4gvxmF1LgRmFaudZE1I+1Q1hR9RouE8HLsTF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSAd5jqZ7JKmMolixbOVU/o7NDlBExIBIvT02gCyyVQ2t34KwTSpJuEFm9sDHozU2j3/5N6Ud7/OiaqHS2b/zNntrYvcnpeByivM4IAyB4yMMUDdONrux6wSN+12e/fjT9YnA7RDNi+Yh0RgixNcp/i9JUHWidr4ZbOzjjzVXf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgB00Mf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC96C16AAE;
	Wed, 14 Jan 2026 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394541;
	bh=nRBzlc4gvxmF1LgRmFaudZE1I+1Q1hR9RouE8HLsTF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgB00Mf+/M1Izer/043Xe8IvsfAa6xM6mdr47GbFZfIj7gZPjvrX6NT9dnb0kmatg
	 3F4O7i3reo9tlbE80hcR+9OpCzAyJxy9//mFX9JnUfXlRytjk3okfY0Kunb3F7ng0E
	 f7cq3fvNXfsUC1CW89zAlNmGKWMhwAyZZBWfoHzIM+3UH7wUKt62YoU5Ts28t6Fv7N
	 pGuxFy/+5xtAH6ZjDOve2YdOW/mm5MAbhZzZ1thBwhFIui+FsbXNsCj6nYDBEIt27b
	 O6UU7FzKy+bElirKU0M+ZhUbWxGjhB//Z7hlAT9K2rXVUhlh85Lm/OoXqPK+5iuQ7g
	 cXgzpxJbQOxdQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 10/26] ACPICA: Define DTPR structure related info tables and data
 template
Date: Wed, 14 Jan 2026 13:24:38 +0100
Message-ID: <3676546.iIbC2pHGDl@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12822121.O9o76ZdvQC@rafael.j.wysocki>
References: <12822121.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

=46rom: Michal Camacho Romero <michal.camacho.romero@intel.com>

 * DTPR Table Info
 * TPR Instance Table Info
 * TPR Array Table Info
 * TPR Serialize Request Table Info
 * DTPR Table Data Template

Link: https://github.com/acpica/acpica/commit/abadf1d34732
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 423e7232974a..f16020829f42 100644
=2D-- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1976,7 +1976,7 @@ struct acpi_ibft_target {
=20
 /*************************************************************************=
******
  *
=2D * DTPR - DMA TPR Reporting
+ * DTPR - DMA TXT Protection Ranges Table
  *        Version 1
  *
  * Conforms to "Intel=C2=AE Trusted Execution Technology (Intel=C2=AE TXT)=
 DMA Protection
@@ -1988,6 +1988,7 @@ struct acpi_ibft_target {
 struct acpi_table_dtpr {
 	struct acpi_table_header header;
 	u32 flags;		// 36
+	u32 ins_cnt;
 };
=20
 struct acpi_tpr_array {
=2D-=20
2.51.0





