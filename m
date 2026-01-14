Return-Path: <linux-acpi+bounces-20316-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3077ED1EE3D
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A107A301D2CB
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249B39C62B;
	Wed, 14 Jan 2026 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IADRT9l6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCE639B487;
	Wed, 14 Jan 2026 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394574; cv=none; b=NADKH5H8aUBnq0ujo2+peNX+fF829LLRP5nbPH7B4LqKUZsBlsfpfTuwOKPuktKHZgznxb2x+U6TmXa+W8l9ZqDnI9NTMEoymtc/YFz3VDUHEuGRCSMDTAYa/Xd4Zr/m+oubTl9yDImfiFja3mXNTG901x1sF9j7HI9JajySGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394574; c=relaxed/simple;
	bh=yMgudD4QZFdyn/O8NoDW9KYx5lFBsUy/TenI2Jvqig4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f98b2D6DeabzAlbvlkUqdJH4G2ecXRh8vFyBC3j6uGxW6SPOT8KZJCm+xWJU4W6PnHPGz6YFDORMFJOqXco06dCSB2pRE+ZooKK5ww0h9AuOfiXFOPTdEv0eGkEmxo/eQl5o15196xyolUuESVJ/J1yuZHF5rYK5kFZs76NEFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IADRT9l6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B173CC4CEF7;
	Wed, 14 Jan 2026 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394573;
	bh=yMgudD4QZFdyn/O8NoDW9KYx5lFBsUy/TenI2Jvqig4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IADRT9l6i+SIjtO2tKI0ihbBO1ZIVMGPa1n9fE1c4TwLvC2uydkH5vnX//O4uK6kw
	 7pLmYDI4WbShgrBb5oOgRnFvg1uILN+eM0S07KPRnpy8eqPvsunoOK61OiAIJto/9E
	 6DcVJ3yR0/3+EKgi0X7b1Kq8Q86Gualtmwo5NGwZE+PZHcmaFiHPdf8H3vjh+tiina
	 f1Z4SFhPqLnc5UBtAMW4i2L77z0vUKDzMKZq7m7OOF5yG9PzXAGhJMekvndK0VLaYK
	 OhhXabwj/MzwPp35kAusHHrok6WxA0LEIhxy91z8NRtXNbdGmY7+3A+IwzAYE1WwvN
	 CZC5QqXTy8kQg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 01/26] ACPICA: Add support for the new ACPI Table: DTPR
Date: Wed, 14 Jan 2026 13:16:23 +0100
Message-ID: <6234415.lOV4Wx5bFT@rafael.j.wysocki>
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

Define a new the ACPI Table, structure and registers, related with it, acco=
rding
to the latest version of the Intel TXT DMA Protection Ranges (TPR) specific=
ation
(Revision 0.73):

*    DTPR ACPI Table
*    TPR Base Register
*    TPR Serialize Request Register
*    TPR Limit Register
*    TPR Instance Structure
*    DMAR TXT Protected Reporting Structure

These structures will be used to handle TPRs on the Intel CPU's.

Link: https://github.com/acpica/acpica/commit/10e7a88f70da
Link: https://uefi.org/sites/default/files/resources/633933_Intel_TXT_DMA_P=
rotection_Ranges_rev_0p73.pdf
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 include/acpi/actbl1.h | 86 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 7f35eb0e8458..23449a068c5c 100644
=2D-- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -47,6 +47,7 @@
 #define ACPI_SIG_HPET           "HPET"	/* High Precision Event Timer table=
 */
 #define ACPI_SIG_IBFT           "IBFT"	/* iSCSI Boot Firmware Table */
 #define ACPI_SIG_MSCT           "MSCT"	/* Maximum System Characteristics T=
able */
+#define ACPI_SIG_DTPR           "DTPR"	/* TXT DMA Protection Ranges report=
ing table */
=20
 #define ACPI_SIG_S3PT           "S3PT"	/* S3 Performance (sub)Table */
 #define ACPI_SIG_PCCS           "PCC"	/* PCC Shared Memory Region */
@@ -1973,6 +1974,91 @@ struct acpi_ibft_target {
 	u16 reverse_chap_secret_offset;
 };
=20
+/*************************************************************************=
******
+ *
+ * DTPR - DMA TPR Reporting
+ *        Version 1
+ *
+ * Conforms to "Intel=C2=AE Trusted Execution Technology (Intel=C2=AE TXT)=
 DMA Protection
+ *              Ranges",
+ * Revision 0.73, August 2021
+ *
+ *************************************************************************=
*****/
+
+struct acpi_table_dtpr {
+	struct acpi_table_header header;
+	u32 flags;		// 36
+};
+
+struct acpi_tpr_array {
+	u64 base;
+};
+
+struct acpi_dtpr_instance {
+	u32 flags;
+	u32 tpr_cnt;
+	struct acpi_tpr_array tpr_array[];
+};
+
+/*************************************************************************=
******
+ * TPRn_BASE
+ *
+ * Specifies the start address of TPRn region. TPR region address and size=
 must
+ * be with 1MB resolution. These bits are compared with the result of the
+ * TPRn_LIMIT[63:20] * applied to the incoming address, to determine if an
+ * access fall within the TPRn defined region.
+**************************************************************************=
*****/
+struct acpi_dtprn_base_reg {
+	u64 reserved0:3;
+	u64 rw:1;		// access: 1 =3D=3D RO, 0 =3D=3D RW (for TPR must be RW)
+	u64 enable:1;		// 0 =3D=3D range enabled, 1 =3D=3D range disabled
+	u64 reserved1:15;
+	u64 tpr_base_rw:44;	// minimal TPrn_base resolution is 1MB.
+	// applied to the incoming address, to determine if an
+	// access fall within the TPrn defined region.
+	// width is determined by a bus width which can be
+	// obtainedvia CPUID function 0x80000008.
+	//u64 unused : 1;
+};
+
+/*************************************************************************=
******
+ * TPRn_LIMIT
+ *
+ * This register defines an isolated region of memory that can be enabled
+ * to prohibit certain system agents from accessing memory. When an agent
+ * sends a request upstream, whether snooped or not, a TPR prevents that
+ * transaction from changing the state of memory.
+**************************************************************************=
*****/
+
+struct acpi_dtprn_limit_reg {
+	u64 reserved0:3;
+	u64 rw:1;		// access: 1 =3D=3D RO, 0 =3D=3D RW (for TPR must be RW)
+	u64 enable:1;		// 0 =3D=3D range enabled, 1 =3D=3D range disabled
+	u64 reserved1:15;
+	u64 tpr_limit_rw:44;	// minimal TPrn_limit resolution is 1MB.
+	// these bits define TPR limit address.
+	// width is determined by a bus width.
+
+	//u64 unused : 1;
+};
+
+/*************************************************************************=
******
+ * SERIALIZE_REQUEST
+ *
+ * This register is used to request serialization of non-coherent DMA
+ * transactions. OS shall  issue it before changing of TPR settings
+ * (base / size).
+**************************************************************************=
*****/
+
+struct acpi_tpr_serialize_request {
+	u64 sts:1;		// status of serialization request (RO)
+	// 0 =3D=3D register idle, 1 =3D=3D serialization in progress
+	u64 ctrl:1;		// control field to initiate serialization (RW)
+	// 0 =3D=3D normal, 1 =3D=3D initialize serialization
+	// (self-clear to allow multiple serialization requests)
+	u64 unused:62;
+};
+
 /* Reset to default packing */
=20
 #pragma pack()
=2D-=20
2.51.0





