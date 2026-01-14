Return-Path: <linux-acpi+bounces-20292-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A74B4D1ED59
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F30EB300B34F
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFFC399A40;
	Wed, 14 Jan 2026 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m76ep/QD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA2397ADD;
	Wed, 14 Jan 2026 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394490; cv=none; b=KF7bK6OCZLk2I2ZJg/gjFQAl3fEB2hEcR7RhLkiCzh9ExgcNL+hgBoKb71mCHtdTX6LjLYDXEnMdLl9w1eoAPs9IHEcwb904mNxq0FwsZaqJ7m6IdR+107QNfGmuL6rnF/cbSYrDVaFJUdG+UZsUY5QJbscQEaieByjO18HCoIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394490; c=relaxed/simple;
	bh=5uzFKuLSWXuv3aNl/XrAZb9CeOSAV+yJBjW3NOApDRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXpAOd56Uu1HogbySMAtcHfR9RaKi5CDBThTenkrY6MgDUsV7gBnvQTPh10aN0r0tZXHnxE1gh2Bc4Dad7Bmuypsyl0U/12hh9KMwuaClfHOgrL42SEdVqySaFSKzg9zzuBn8jQLUpZo/nbYf62onrknR50FQDRabdxe9HNbF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m76ep/QD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C2FC4CEF7;
	Wed, 14 Jan 2026 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394489;
	bh=5uzFKuLSWXuv3aNl/XrAZb9CeOSAV+yJBjW3NOApDRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m76ep/QDPyJ3GhK4IGiJvnCwaGbbs4C5q0eEzm0tvIT2gmlYVFGGA3be8k7FyGYuO
	 nXnBXZ6Zh5+1FLNZLTb8nyqStEV6Q2nKWqfd4s6FsjccpVVYZOp2+NkNyhs3zB4POZ
	 03Oa2069WBM8nVQgEKMo3fgUW36PvGgbe/hpK1D3yzZTKfhCd+V3EJ8YX9uEVvwERS
	 BeybTpsajFCukYJpBXOCV1+gvmU+eTesPCaXmdoa0cfv/hqG/noqmkrsH+ulcmEQCL
	 XDOKiK6hZ+opJng0QydVvxB3suZ00HBDxbXdq8NlyXdXYGzg0cnrsbIXD0Nqujve3q
	 46DTlhMwDBzMA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 25/26] ACPICA: Replace TPRn Base and Limit registers
Date: Wed, 14 Jan 2026 13:39:10 +0100
Message-ID: <1871109.TLkxdtWsSY@rafael.j.wysocki>
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

Replace TPRn Base and Limit registers with compatible bitmasks for them.

Link: https://github.com/acpica/acpica/commit/be91c5813936
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 include/acpi/actbl1.h | 99 +++++++++++++++++++++++++++++++------------
 1 file changed, 72 insertions(+), 27 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index cdcda64d1d8e..8331a3494b75 100644
=2D-- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -2005,28 +2005,57 @@ struct acpi_tpr_aux_sr {
 };
=20
 /*
=2D * TPRn_BASE
+ * TPRn_BASE (ACPI_TPRN_BASE_REG)
  *
  * Specifies the start address of TPRn region. TPR region address and size=
 must
  * be with 1MB resolution. These bits are compared with the result of the
  * TPRn_LIMIT[63:20] * applied to the incoming address, to determine if an
  * access fall within the TPRn defined region.
+ *
+ * Minimal TPRn_Base resolution is 1MB.
+ * Applied to the incoming address, to determine if
+ * an access fall within the TPRn defined region.
+ * Width is determined by a bus width which can be
+ * obtained via CPUID function 0x80000008.
  */
=20
=2Dstruct acpi_tprn_base_reg {
=2D	u64 reserved0:3;
=2D	u64 rw:1;		/* access: 1 =3D=3D RO, 0 =3D=3D RW (for TPR must be RW) */
=2D	u64 enable:1;		/* 0 =3D=3D range enabled, 1 =3D=3D range disabled */
=2D	u64 reserved1:15;
=2D	u64 tpr_base_rw:44;
=2D	/*
=2D	 * Minimal TPRn_Base resolution is 1MB.
=2D	 * Applied to the incoming address, to determine if
=2D	 * an access fall within the TPRn defined region.
=2D	 * Width is determined by a bus width which can be
=2D	 * obtained via CPUID function 0x80000008.
=2D	 */
=2D};
+typedef u64 ACPI_TPRN_BASE_REG;
+
+/* TPRn_BASE Register Bit Masks */
+
+/* Bit 3 - RW: access: 1 =3D=3D RO, 0 =3D=3D RW register (for TPR must be =
RW) */
+#define ACPI_TPRN_BASE_RW_SHIFT        3
+#define ACPI_TPRN_BASE_RW_MASK         ((u64) 1 << ACPI_TPRN_BASE_RW_SHIFT)
+
+/*
+ * Bit 4 - Enable: 0 =E2=80=93 TPRn address range enabled;
+ *                 1 =E2=80=93 TPRn address range disabled.
+ */
+#define ACPI_TPRN_BASE_ENABLE_SHIFT    4
+#define ACPI_TPRN_BASE_ENABLE_MASK     ((u64) 1 << ACPI_TPRN_BASE_ENABLE_S=
HIFT)
+
+/* Bits 63:20 - tpr_base_rw */
+#define ACPI_TPRN_BASE_ADDR_SHIFT      20
+#define ACPI_TPRN_BASE_ADDR_MASK       ((u64) 0xFFFFFFFFFFF << \
+			 ACPI_TPRN_BASE_ADDR_SHIFT)
+
+/* TPRn_BASE Register Bit Handlers*/
+#define GET_TPRN_BASE_RW(reg)     (((u64) reg & ACPI_TPRN_BASE_RW_MASK) >>=
  \
+					  ACPI_TPRN_BASE_RW_SHIFT)
+#define GET_TPRN_BASE_ENABLE(reg) (((u64) reg & ACPI_TPRN_BASE_ENABLE_MASK=
) \
+							 >> ACPI_TPRN_BASE_ENABLE_SHIFT)
+#define GET_TPRN_BASE_ADDR(reg)   (((u64) reg & ACPI_TPRN_BASE_ADDR_MASK) =
  \
+								   >> ACPI_TPRN_BASE_ADDR_SHIFT)
+
+#define SET_TPRN_BASE_RW(reg, val) ACPI_REGISTER_INSERT_VALUE(reg,     \
+										ACPI_TPRN_BASE_RW_SHIFT,       \
+										ACPI_TPRN_BASE_RW_MASK, val);
+#define SET_TPRN_BASE_ENABLE(reg, val) ACPI_REGISTER_INSERT_VALUE(reg, \
+										ACPI_TPRN_BASE_ENABLE_SHIFT,   \
+										ACPI_TPRN_BASE_ENABLE_MASK, val);
+#define SET_TPRN_BASE_ADDR(reg, val) ACPI_REGISTER_INSERT_VALUE(reg,   \
+										ACPI_TPRN_BASE_ADDR_SHIFT,     \
+										ACPI_TPRN_BASE_ADDR_MASK, val);
=20
 /*
  * TPRn_LIMIT
@@ -2035,20 +2064,36 @@ struct acpi_tprn_base_reg {
  * to prohibit certain system agents from accessing memory. When an agent
  * sends a request upstream, whether snooped or not, a TPR prevents that
  * transaction from changing the state of memory.
+ *
+ * Minimal TPRn_Limit resolution is 1MB.
+ * Width is determined by a bus width
  */
=20
=2Dstruct acpi_tprn_limit_reg {
=2D	u64 reserved0:3;
=2D	u64 rw:1;		/* access: 1 =3D=3D RO, 0 =3D=3D RW (for TPR must be RW) */
=2D	u64 enable:1;		/* 0 =3D=3D range enabled, 1 =3D=3D range disabled */
=2D	u64 reserved1:15;
=2D	u64 tpr_limit_rw:44;
=2D	/*
=2D	 * Minimal TPRn_Limit resolution is 1MB.
=2D	 * These bits define TPR limit address.
=2D	 * Width is determined by a bus width.
=2D	 */
=2D};
+typedef u64 ACPI_TPRN_LIMIT_REG;
+
+/* TPRn_LIMIT Register Bit Masks */
+
+/* Bit 3 - RW: access: 1 =3D=3D RO, 0 =3D=3D RW register (for TPR must be =
RW) */
+#define ACPI_TPRN_LIMIT_RW_SHIFT   3
+#define ACPI_TPRN_LIMIT_RW_MASK    ((u64) 1 << ACPI_TPRN_LIMIT_RW_SHIFT)
+
+/* Bits 63:20 - tpr_limit_rw */
+#define ACPI_TPRN_LIMIT_ADDR_SHIFT 20
+#define ACPI_TPRN_LIMIT_ADDR_MASK  ((u64) 0xFFFFFFFFFFF << \
+								   ACPI_TPRN_LIMIT_ADDR_SHIFT)
+
+/* TPRn_LIMIT Register Bit Handlers*/
+#define GET_TPRN_LIMIT_RW(reg)    (((u64) reg & ACPI_TPRN_LIMIT_RW_MASK)  =
  \
+								   >> ACPI_TPRN_LIMIT_RW_SHIFT)
+#define GET_TPRN_LIMIT_ADDR(reg)  (((u64) reg & ACPI_TPRN_LIMIT_ADDR_MASK)=
  \
+								   >> ACPI_TPRN_LIMIT_ADDR_SHIFT)
+
+#define SET_TPRN_LIMIT_RW(reg, val) ACPI_REGISTER_INSERT_VALUE(reg,       =
     \
+										ACPI_TPRN_LIMIT_RW_SHIFT,              \
+										ACPI_TPRN_LIMIT_RW_MASK, val);
+#define SET_TPRN_LIMIT_ADDR(reg, val) ACPI_REGISTER_INSERT_VALUE(reg,     =
     \
+										ACPI_TPRN_LIMIT_ADDR_SHIFT,            \
+										ACPI_TPRN_LIMIT_ADDR_MASK, val);
=20
 /*
  * SERIALIZE_REQUEST
=2D-=20
2.51.0





