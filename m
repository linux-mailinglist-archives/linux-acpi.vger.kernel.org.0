Return-Path: <linux-acpi+bounces-20291-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD93D1ED53
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91DAD30208F1
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B9D399014;
	Wed, 14 Jan 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHQE/OF6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9C396D16;
	Wed, 14 Jan 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394486; cv=none; b=IvZP9hQ8IXL9z0MrGSsBrETVJM16wZOTuFKphYRouuqCOY5XyG/ZPUuFaJ7WeKVq+V5Hs0jTwiOc6TTMUcsrxM2H7II5uJu+Z3hJos3kXxD9VCML638FS+09CCaf4Br6fr2WZVUCUe6WQPOcqukJ53QKLobX61ufHo0Azt0YX0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394486; c=relaxed/simple;
	bh=Tz9jRrirlqlL3DGi+GSj/OGP+Gmit6shMMoFzEu5iH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peODbg5AkZkjKUJFFvAzTz/mX+7FG3GLcjNejbUOB4cCoLVeLLcpSRlhbJ4TjsMb16h6R4UqLtbNQIDgu5SEzZZXI/tuVy5YRitBpz8PRhWOQbIO31IOMyOAzOXbREtQTcvHqwwZL2H0aH0TvHXieWfBWG6vTolaRsiDAJnbkuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHQE/OF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DD8C4CEF7;
	Wed, 14 Jan 2026 12:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394486;
	bh=Tz9jRrirlqlL3DGi+GSj/OGP+Gmit6shMMoFzEu5iH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHQE/OF6s6+zHqNcyVw8XX7GbRSbEMIVre5jyA8HVe/XcxMMlOjGmNSS5EY6K2LqY
	 46utj4tTz6lqYQOJtK9tNlsCIR1YQLVJdEUuoeEnq4gI3O2qYTEKqnHlJ7iMsJvqfJ
	 twDmFvjw1vdGvZBkE9xmsa7wuvh0DQ5vJltarYFH9hWFLWWK8tmCK+zMJ+ovqiDDNY
	 maHqFqpul6KvLZXeQ3o3fyad6c/ePsN+HcRlPSTZOV/6W+WpKtlYT+6Y1Ysgd5HlN5
	 +8XIGPZiJv2GiwSzP9rovoM4UEqFJnVz1g4bidueQz/jOR3iGVncMbIJ582Peo162V
	 wYL76TTJojJSw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 26/26] ACPICA: Refactor for TPR Base/Limit registers bitmasks
Date: Wed, 14 Jan 2026 13:40:06 +0100
Message-ID: <3193976.CbtlEUcBR6@rafael.j.wysocki>
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

Link: https://github.com/acpica/acpica/commit/5cb62a1d4970
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 include/acpi/actbl1.h | 396 +++++++++++++++++++++++++++---------------
 1 file changed, 256 insertions(+), 140 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 8331a3494b75..4e15583e0d25 100644
=2D-- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1000,6 +1000,262 @@ struct acpi_drtm_dps_id {
 	u8 dps_id[16];
 };
=20
+/*************************************************************************=
******
+ *
+ * DTPR - DMA TXT Protection Ranges Table
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
+	u32 flags;		/* 36 */
+	u32 ins_cnt;
+};
+
+struct acpi_tpr_array {
+	u64 base;
+};
+
+struct acpi_tpr_instance {
+	u32 flags;
+	u32 tpr_cnt;
+};
+
+struct acpi_tpr_aux_sr {
+	u32 srl_cnt;
+};
+
+/*
+ * TPRn_BASE (ACPI_TPRN_BASE_REG)
+ *
+ * Specifies the start address of TPRn region. TPR region address and size=
 must
+ * be with 1MB resolution. These bits are compared with the result of the
+ * TPRn_LIMIT[63:20], which is applied to the incoming address, to
+ * determine if an access fall within the TPRn defined region.
+ *
+ * Minimal TPRn_Base resolution is 1MB. Applied to the incoming address, to
+ * determine if an access fall within the TPRn defined region. Width is
+ * determined by a bus width which can be obtained via CPUID
+ * function 0x80000008.
+ */
+
+typedef u64 ACPI_TPRN_BASE_REG;
+
+/* TPRn_BASE Register Bit Masks */
+
+/* Bit 3 - RW: access: 1 =3D=3D RO, 0 =3D=3D RW register (for TPR must be =
RW) */
+#define ACPI_TPRN_BASE_RW_SHIFT        3
+
+#define ACPI_TPRN_BASE_RW_MASK         ((u64) 1 << ACPI_TPRN_BASE_RW_SHIFT)
+
+/*
+ * Bit 4 - Enable: 0 =E2=80=93 TPRn address range enabled;
+ *                 1 =E2=80=93 TPRn address range disabled.
+ */
+#define ACPI_TPRN_BASE_ENABLE_SHIFT    4
+
+#define ACPI_TPRN_BASE_ENABLE_MASK     ((u64) 1 << ACPI_TPRN_BASE_ENABLE_S=
HIFT)
+
+/* Bits 63:20 - tpr_base_rw */
+#define ACPI_TPRN_BASE_ADDR_SHIFT      20
+
+#define ACPI_TPRN_BASE_ADDR_MASK       ((u64) 0xFFFFFFFFFFF << \
+			 ACPI_TPRN_BASE_ADDR_SHIFT)
+
+/* TPRn_BASE Register Bit Handlers*/
+
+/*
+ * GET_TPRN_BASE_RW:
+ *
+ * Read RW bit from TPRn Base register - bit 3.
+ *
+ * Input:
+ * - reg (represents TPRn Base Register (ACPI_TPRN_BASE_REG))
+ *
+ * Output:
+ *
+ * Returns RW bit value (u64).
+ */
+#define GET_TPRN_BASE_RW(reg)     (((u64) reg & ACPI_TPRN_BASE_RW_MASK) >>=
  \
+					  ACPI_TPRN_BASE_RW_SHIFT)
+
+/*
+ * GET_TPRN_BASE_ENABLE:
+ *
+ * Read Enable bit from TPRn Base register - bit 4.
+ *
+ * Input:
+ * - reg (represents TPRn Base Register (ACPI_TPRN_BASE_REG))
+ *
+ * Output:
+ *
+ * Returns Enable bit value (u64).
+ */
+#define GET_TPRN_BASE_ENABLE(reg) (((u64) reg & ACPI_TPRN_BASE_ENABLE_MASK=
) \
+							 >> ACPI_TPRN_BASE_ENABLE_SHIFT)
+
+/*
+ * GET_TPRN_BASE_ADDR:
+ *
+ * Read TPRn Base Register address from bits 63:20.
+ *
+ * Input:
+ * - reg (represents TPRn Base Register (ACPI_TPRN_BASE_REG))
+ *
+ * Output:
+ *
+ * Returns TPRn Base Register address (u64).
+ */
+#define GET_TPRN_BASE_ADDR(reg)   (((u64) reg & ACPI_TPRN_BASE_ADDR_MASK) =
  \
+								   >> ACPI_TPRN_BASE_ADDR_SHIFT)
+
+/*
+ * SET_TPRN_BASE_RW:
+ *
+ * Set RW bit in TPRn Base register - bit 3.
+ *
+ * Input:
+ * - reg (represents TPRn Base Register (ACPI_TPRN_BASE_REG))
+ * - val (represents RW value to be set (u64))
+ */
+#define SET_TPRN_BASE_RW(reg, val) ACPI_REGISTER_INSERT_VALUE(reg,     \
+										ACPI_TPRN_BASE_RW_SHIFT,       \
+										ACPI_TPRN_BASE_RW_MASK, val);
+
+/*
+ * SET_TPRN_BASE_ENABLE:
+ *
+ * Set Enable bit in TPRn Base register - bit 4.
+ *
+ * Input:
+ * - reg (represents TPRn Base Register (ACPI_TPRN_BASE_REG))
+ * - val (represents Enable value to be set (u64))
+ */
+#define SET_TPRN_BASE_ENABLE(reg, val) ACPI_REGISTER_INSERT_VALUE(reg, \
+										ACPI_TPRN_BASE_ENABLE_SHIFT,   \
+										ACPI_TPRN_BASE_ENABLE_MASK, val);
+
+/*
+ * SET_TPRN_BASE_ADDR:
+ *
+ * Set TPRn Base Register address - bits 63:20
+ *
+ * Input
+ * - reg (represents TPRn Base Register (ACPI_TPRN_BASE_REG))
+ * - val (represents address value to be set (u64))
+ */
+#define SET_TPRN_BASE_ADDR(reg, val) ACPI_REGISTER_INSERT_VALUE(reg,   \
+										ACPI_TPRN_BASE_ADDR_SHIFT,     \
+										ACPI_TPRN_BASE_ADDR_MASK, val);
+
+/*
+ * TPRn_LIMIT
+ *
+ * This register defines an isolated region of memory that can be enabled
+ * to prohibit certain system agents from accessing memory. When an agent
+ * sends a request upstream, whether snooped or not, a TPR prevents that
+ * transaction from changing the state of memory.
+ *
+ * Minimal TPRn_Limit resolution is 1MB. Width is determined by a bus widt=
h.
+ */
+
+typedef u64 ACPI_TPRN_LIMIT_REG;
+
+/* TPRn_LIMIT Register Bit Masks */
+
+/* Bit 3 - RW: access: 1 =3D=3D RO, 0 =3D=3D RW register (for TPR must be =
RW) */
+#define ACPI_TPRN_LIMIT_RW_SHIFT   3
+
+#define ACPI_TPRN_LIMIT_RW_MASK    ((u64) 1 << ACPI_TPRN_LIMIT_RW_SHIFT)
+
+/* Bits 63:20 - tpr_limit_rw */
+#define ACPI_TPRN_LIMIT_ADDR_SHIFT 20
+
+#define ACPI_TPRN_LIMIT_ADDR_MASK  ((u64) 0xFFFFFFFFFFF << \
+								   ACPI_TPRN_LIMIT_ADDR_SHIFT)
+
+/* TPRn_LIMIT Register Bit Handlers*/
+
+/*
+ * GET_TPRN_LIMIT_RW:
+ *
+ * Read RW bit from TPRn Limit register - bit 3.
+ *
+ * Input:
+ * - reg (represents TPRn Limit Register (ACPI_TPRN_LIMIT_REG))
+ *
+ * Output:
+ *
+ * Returns RW bit value (u64).
+ */
+#define GET_TPRN_LIMIT_RW(reg)    (((u64) reg & ACPI_TPRN_LIMIT_RW_MASK)  =
  \
+								   >> ACPI_TPRN_LIMIT_RW_SHIFT)
+
+/*
+ * GET_TPRN_LIMIT_ADDR:
+ *
+ * Read TPRn Limit Register address from bits 63:20.
+ *
+ * Input:
+ * - reg (represents TPRn Limit Register (ACPI_TPRN_LIMIT_REG))
+ *
+ * Output:
+ *
+ * Returns TPRn Limit Register address (u64).
+ */
+#define GET_TPRN_LIMIT_ADDR(reg)  (((u64) reg & ACPI_TPRN_LIMIT_ADDR_MASK)=
  \
+								   >> ACPI_TPRN_LIMIT_ADDR_SHIFT)
+
+/*
+ * SET_TPRN_LIMIT_RW:
+ *
+ * Set RW bit in TPRn Limit register - bit 3.
+ *
+ * Input:
+ * - reg (represents TPRn Limit Register (ACPI_TPRN_LIMIT_REG))
+ * - val (represents RW value to be set (u64))
+ */
+#define SET_TPRN_LIMIT_RW(reg, val) ACPI_REGISTER_INSERT_VALUE(reg,       =
     \
+										ACPI_TPRN_LIMIT_RW_SHIFT,              \
+										ACPI_TPRN_LIMIT_RW_MASK, val);
+
+/*
+ * SET_TPRN_LIMIT_ADDR:
+ *
+ * Set TPRn Limit Register address - bits 63:20.
+ *
+ * Input:
+ * - reg (represents TPRn Limit Register (ACPI_TPRN_LIMIT_REG))
+ * - val (represents address value to be set (u64))
+ */
+#define SET_TPRN_LIMIT_ADDR(reg, val) ACPI_REGISTER_INSERT_VALUE(reg,     =
     \
+										ACPI_TPRN_LIMIT_ADDR_SHIFT,            \
+										ACPI_TPRN_LIMIT_ADDR_MASK, val);
+
+/*
+ * SERIALIZE_REQUEST
+ *
+ * This register is used to request serialization of non-coherent DMA
+ * transactions. OS shall  issue it before changing of TPR settings
+ * (base / size).
+ */
+
+struct acpi_tpr_serialize_request {
+	u64 sr_register;
+	/*
+	 * BIT 1 - Status of serialization request (RO)
+	 *         0 =3D=3D register idle, 1 =3D=3D serialization in progress
+	 * BIT 2 - Control field to initiate serialization (RW)
+	 *         0 =3D=3D normal, 1 =3D=3D initialize serialization
+	 * (self-clear to allow multiple serialization requests)
+	 */
+};
+
 /*************************************************************************=
******
  *
  * ECDT - Embedded Controller Boot Resources Table
@@ -1974,146 +2230,6 @@ struct acpi_ibft_target {
 	u16 reverse_chap_secret_offset;
 };
=20
=2D/***********************************************************************=
********
=2D *
=2D * DTPR - DMA TXT Protection Ranges Table
=2D *        Version 1
=2D *
=2D * Conforms to "Intel=C2=AE Trusted Execution Technology (Intel=C2=AE TX=
T) DMA Protection
=2D *              Ranges",
=2D * Revision 0.73, August 2021
=2D *
=2D ***********************************************************************=
*******/
=2D
=2Dstruct acpi_table_dtpr {
=2D	struct acpi_table_header header;
=2D	u32 flags;		/* 36 */
=2D	u32 ins_cnt;
=2D};
=2D
=2Dstruct acpi_tpr_array {
=2D	u64 base;
=2D};
=2D
=2Dstruct acpi_tpr_instance {
=2D	u32 flags;
=2D	u32 tpr_cnt;
=2D};
=2D
=2Dstruct acpi_tpr_aux_sr {
=2D	u32 srl_cnt;
=2D};
=2D
=2D/*
=2D * TPRn_BASE (ACPI_TPRN_BASE_REG)
=2D *
=2D * Specifies the start address of TPRn region. TPR region address and si=
ze must
=2D * be with 1MB resolution. These bits are compared with the result of the
=2D * TPRn_LIMIT[63:20] * applied to the incoming address, to determine if =
an
=2D * access fall within the TPRn defined region.
=2D *
=2D * Minimal TPRn_Base resolution is 1MB.
=2D * Applied to the incoming address, to determine if
=2D * an access fall within the TPRn defined region.
=2D * Width is determined by a bus width which can be
=2D * obtained via CPUID function 0x80000008.
=2D */
=2D
=2Dtypedef u64 ACPI_TPRN_BASE_REG;
=2D
=2D/* TPRn_BASE Register Bit Masks */
=2D
=2D/* Bit 3 - RW: access: 1 =3D=3D RO, 0 =3D=3D RW register (for TPR must b=
e RW) */
=2D#define ACPI_TPRN_BASE_RW_SHIFT        3
=2D#define ACPI_TPRN_BASE_RW_MASK         ((u64) 1 << ACPI_TPRN_BASE_RW_SHI=
=46T)
=2D
=2D/*
=2D * Bit 4 - Enable: 0 =E2=80=93 TPRn address range enabled;
=2D *                 1 =E2=80=93 TPRn address range disabled.
=2D */
=2D#define ACPI_TPRN_BASE_ENABLE_SHIFT    4
=2D#define ACPI_TPRN_BASE_ENABLE_MASK     ((u64) 1 << ACPI_TPRN_BASE_ENABLE=
_SHIFT)
=2D
=2D/* Bits 63:20 - tpr_base_rw */
=2D#define ACPI_TPRN_BASE_ADDR_SHIFT      20
=2D#define ACPI_TPRN_BASE_ADDR_MASK       ((u64) 0xFFFFFFFFFFF << \
=2D			 ACPI_TPRN_BASE_ADDR_SHIFT)
=2D
=2D/* TPRn_BASE Register Bit Handlers*/
=2D#define GET_TPRN_BASE_RW(reg)     (((u64) reg & ACPI_TPRN_BASE_RW_MASK) =
>>  \
=2D					  ACPI_TPRN_BASE_RW_SHIFT)
=2D#define GET_TPRN_BASE_ENABLE(reg) (((u64) reg & ACPI_TPRN_BASE_ENABLE_MA=
SK) \
=2D							 >> ACPI_TPRN_BASE_ENABLE_SHIFT)
=2D#define GET_TPRN_BASE_ADDR(reg)   (((u64) reg & ACPI_TPRN_BASE_ADDR_MASK=
)   \
=2D								   >> ACPI_TPRN_BASE_ADDR_SHIFT)
=2D
=2D#define SET_TPRN_BASE_RW(reg, val) ACPI_REGISTER_INSERT_VALUE(reg,     \
=2D										ACPI_TPRN_BASE_RW_SHIFT,       \
=2D										ACPI_TPRN_BASE_RW_MASK, val);
=2D#define SET_TPRN_BASE_ENABLE(reg, val) ACPI_REGISTER_INSERT_VALUE(reg, \
=2D										ACPI_TPRN_BASE_ENABLE_SHIFT,   \
=2D										ACPI_TPRN_BASE_ENABLE_MASK, val);
=2D#define SET_TPRN_BASE_ADDR(reg, val) ACPI_REGISTER_INSERT_VALUE(reg,   \
=2D										ACPI_TPRN_BASE_ADDR_SHIFT,     \
=2D										ACPI_TPRN_BASE_ADDR_MASK, val);
=2D
=2D/*
=2D * TPRn_LIMIT
=2D *
=2D * This register defines an isolated region of memory that can be enabled
=2D * to prohibit certain system agents from accessing memory. When an agent
=2D * sends a request upstream, whether snooped or not, a TPR prevents that
=2D * transaction from changing the state of memory.
=2D *
=2D * Minimal TPRn_Limit resolution is 1MB.
=2D * Width is determined by a bus width
=2D */
=2D
=2Dtypedef u64 ACPI_TPRN_LIMIT_REG;
=2D
=2D/* TPRn_LIMIT Register Bit Masks */
=2D
=2D/* Bit 3 - RW: access: 1 =3D=3D RO, 0 =3D=3D RW register (for TPR must b=
e RW) */
=2D#define ACPI_TPRN_LIMIT_RW_SHIFT   3
=2D#define ACPI_TPRN_LIMIT_RW_MASK    ((u64) 1 << ACPI_TPRN_LIMIT_RW_SHIFT)
=2D
=2D/* Bits 63:20 - tpr_limit_rw */
=2D#define ACPI_TPRN_LIMIT_ADDR_SHIFT 20
=2D#define ACPI_TPRN_LIMIT_ADDR_MASK  ((u64) 0xFFFFFFFFFFF << \
=2D								   ACPI_TPRN_LIMIT_ADDR_SHIFT)
=2D
=2D/* TPRn_LIMIT Register Bit Handlers*/
=2D#define GET_TPRN_LIMIT_RW(reg)    (((u64) reg & ACPI_TPRN_LIMIT_RW_MASK)=
    \
=2D								   >> ACPI_TPRN_LIMIT_RW_SHIFT)
=2D#define GET_TPRN_LIMIT_ADDR(reg)  (((u64) reg & ACPI_TPRN_LIMIT_ADDR_MAS=
K)  \
=2D								   >> ACPI_TPRN_LIMIT_ADDR_SHIFT)
=2D
=2D#define SET_TPRN_LIMIT_RW(reg, val) ACPI_REGISTER_INSERT_VALUE(reg,     =
       \
=2D										ACPI_TPRN_LIMIT_RW_SHIFT,              \
=2D										ACPI_TPRN_LIMIT_RW_MASK, val);
=2D#define SET_TPRN_LIMIT_ADDR(reg, val) ACPI_REGISTER_INSERT_VALUE(reg,   =
       \
=2D										ACPI_TPRN_LIMIT_ADDR_SHIFT,            \
=2D										ACPI_TPRN_LIMIT_ADDR_MASK, val);
=2D
=2D/*
=2D * SERIALIZE_REQUEST
=2D *
=2D * This register is used to request serialization of non-coherent DMA
=2D * transactions. OS shall  issue it before changing of TPR settings
=2D * (base / size).
=2D */
=2D
=2Dstruct acpi_tpr_serialize_request {
=2D	u64 sr_register;
=2D	/*
=2D	 * BIT 1 - Status of serialization request (RO)
=2D	 *         0 =3D=3D register idle, 1 =3D=3D serialization in progress
=2D	 * BIT 2 - Control field to initiate serialization (RW)
=2D	 *         0 =3D=3D normal, 1 =3D=3D initialize serialization
=2D	 * (self-clear to allow multiple serialization requests)
=2D	 */
=2D};
=2D
 /* Reset to default packing */
=20
 #pragma pack()
=2D-=20
2.51.0





