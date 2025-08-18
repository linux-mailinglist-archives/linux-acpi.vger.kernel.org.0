Return-Path: <linux-acpi+bounces-15762-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156FAB297CE
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5028319654C2
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E9E25F988;
	Mon, 18 Aug 2025 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CE4akxDe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7850925E834
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490233; cv=none; b=EEfUHAzq0z749gMPQroiSH0Vy4puI6t3GsXqwWEq2wnGVURn7y3wrVe3iHZ/VjbZPf2MKEPgn/l0eejv4+BOxxKs8I2Z4l8XAsPzYmH5aecm6LIX2lfypKjtAoRzRpVqcO5IQFNIDMp1ufEz0/rp4vECbXV4GvQtZZEDq0iEhs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490233; c=relaxed/simple;
	bh=JzH3yhqwYOudTCMAKRwj0oa4K99Zc+6yOM1JzEGNxmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHpNnR6CjOzmOnT3yaUfrUySzNOQGnU8McHU+PnqpY1K21TjS/dF7Dg6nvhoi1IllnXUhDUPhMIeWP0QD0i1eHvPkv+BPlHDHXFTX/bFGeysWtDwcUQEI1z0hHx4mGwUO2ePWPhGFi6L3OdIXepD2CQ7O7QaAqcEYQPbzLLp2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CE4akxDe; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323266d6f57so3660428a91.0
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490232; x=1756095032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPHcLL2SG/7gEz7cPa5IwB1kBN+rHxLpWke4w+6lxok=;
        b=CE4akxDeqOem6d46ePEyqAupaBofCeegggCdJS5x8WF0ZTSGJolGt2GULq31ZQmP5r
         L+d8T9US0UE4vNKPGKsN+Ucrk8S1j0F1HIFczzpqvnwbzGVNxpJdqfqwwddWnUuBSvL8
         L5PBf/CGHY4YthJwMpae2FFBXWGmks/Q3LeW80WM3uNm6/IExiNR6q/sZ8ZQL+uCP4Hj
         JHM6brEEG5Chew8SsMKrDOoB5jOJekirDiP4OG0Sx2HuDPra6FTRccHbGffZz0y8CLF4
         KutSYj02ADY6qgh9huiUVw1NhLRGIwqEuWh18neqBBpUz04TKhGTLlX4k6l4DGlkkh3b
         6kFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490232; x=1756095032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPHcLL2SG/7gEz7cPa5IwB1kBN+rHxLpWke4w+6lxok=;
        b=EAoLv6j1sVeUzxRTvnd62vyZOqyJSLADm3Z8zH7LiEn/3KIeiEKxCRcEfYtb/Qkx4/
         33GYaPVakA/VOMz9UPJ8QF4vogCjtfomFiC5aW5CPd8TYBqIApT039M+avnfuJZI7O7n
         aH6VsEKzKNn41Ljn/lhJV+4gLqgCq9mwMDsbq2JAat4kLRmdpuFUuJgjMWxDL5tg9YOO
         Zvp9eUmWBVrpnSyyWSuFFbZPfKbyO87XSPeGerwM6OZ8eKIM0ZfRJcG1cd0GAJWe6Lju
         FFUt5bwP/DZvFbkqUDojK05QCdC6rbL7PCdgAinCXEmIzgHOamkp2v0HeDOO/+F6f2bm
         LwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG/1wHqsagWNhZOwIPclvQbIbfwCLny8hkSVu5z2Z+lFaUNgW066BglRbwRd2texkbLokxBOmlMkZs@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEyvVXxBjIG8TwEhRpuuzWK92Jn/yY6BAKfpW/gl98i/AOMH0
	dC7ax5W2XVfWfgxDx8Ts3bf/o/x+emamwGzEHs6gQuUrwKzt3s3lBHJa2L/dw+zsEXM=
X-Gm-Gg: ASbGncuL6xfNEliVqCby9Ntn1LFDkXeHsQWAyHVNup6J4tYsGnsL0YLvNx7cmb7YQz/
	nb6JHCxpEU4guuxWe/0pTNr06TZ/iHMKzZVRkKPelJ1SbXgHst7NZmZFj0qpEYXVbPFl82/sWYb
	X40H3FHTpWb7SzE1LJLD+FErl0+XPs1UYYNz2s5RM6LZ4JoJFQ31h/k0pFven++6iPDCuJp/ld/
	q/n2govVKQjXj+o8CRS3BIx/fBel/86J+O9fm3tnyBRFimeF7ojrKcP7ALBPo0OC+c/7THw38DG
	txl3EHmVrcaf01dqun0TljiUgX6LkmQ26CSGg5ywIyP//5ZfOUlAo1pVgrW/zegIvQ8C80b4CuR
	mWCkKpCyL+09rRPHrcp7dVevidqw456kkg4nSODE8KXxiB0zcZFwZOw==
X-Google-Smtp-Source: AGHT+IG2Lm+Y52n6XKyIXBlc4RYKAT1nFaGLczgz8usKKmMpO2sTLSC8znXmp2nRau7FtQyr+2X6Qg==
X-Received: by 2002:a17:90b:1e0e:b0:313:62ee:45a with SMTP id 98e67ed59e1d1-32341ed21famr13448415a91.13.1755490231451;
        Sun, 17 Aug 2025 21:10:31 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:10:30 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v10 03/24] RISC-V: Add defines for the SBI message proxy extension
Date: Mon, 18 Aug 2025 09:38:59 +0530
Message-ID: <20250818040920.272664-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add defines for the new SBI message proxy extension which is part
of the SBI v3.0 specification.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Rahul Pathak <rpathak@ventanamicro.com>
Signed-off-by: Rahul Pathak <rpathak@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 341e74238aa0..c19e5c7383a6 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -36,6 +36,7 @@ enum sbi_ext_id {
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
 	SBI_EXT_FWFT = 0x46574654,
+	SBI_EXT_MPXY = 0x4D505859,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -430,6 +431,67 @@ enum sbi_fwft_feature_t {
 
 #define SBI_FWFT_SET_FLAG_LOCK			BIT(0)
 
+enum sbi_ext_mpxy_fid {
+	SBI_EXT_MPXY_GET_SHMEM_SIZE,
+	SBI_EXT_MPXY_SET_SHMEM,
+	SBI_EXT_MPXY_GET_CHANNEL_IDS,
+	SBI_EXT_MPXY_READ_ATTRS,
+	SBI_EXT_MPXY_WRITE_ATTRS,
+	SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
+	SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP,
+	SBI_EXT_MPXY_GET_NOTIFICATION_EVENTS,
+};
+
+enum sbi_mpxy_attribute_id {
+	/* Standard channel attributes managed by MPXY framework */
+	SBI_MPXY_ATTR_MSG_PROT_ID		= 0x00000000,
+	SBI_MPXY_ATTR_MSG_PROT_VER		= 0x00000001,
+	SBI_MPXY_ATTR_MSG_MAX_LEN		= 0x00000002,
+	SBI_MPXY_ATTR_MSG_SEND_TIMEOUT		= 0x00000003,
+	SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT	= 0x00000004,
+	SBI_MPXY_ATTR_CHANNEL_CAPABILITY	= 0x00000005,
+	SBI_MPXY_ATTR_SSE_EVENT_ID		= 0x00000006,
+	SBI_MPXY_ATTR_MSI_CONTROL		= 0x00000007,
+	SBI_MPXY_ATTR_MSI_ADDR_LO		= 0x00000008,
+	SBI_MPXY_ATTR_MSI_ADDR_HI		= 0x00000009,
+	SBI_MPXY_ATTR_MSI_DATA			= 0x0000000A,
+	SBI_MPXY_ATTR_EVENTS_STATE_CONTROL	= 0x0000000B,
+	SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
+	/*
+	 * Message protocol specific attributes, managed by
+	 * the message protocol specification.
+	 */
+	SBI_MPXY_ATTR_MSGPROTO_ATTR_START	= 0x80000000,
+	SBI_MPXY_ATTR_MSGPROTO_ATTR_END		= 0xffffffff
+};
+
+/* Possible values of MSG_PROT_ID attribute as-per SBI v3.0 (or higher) */
+enum sbi_mpxy_msgproto_id {
+	SBI_MPXY_MSGPROTO_RPMI_ID = 0x0,
+};
+
+/* RPMI message protocol specific MPXY attributes */
+enum sbi_mpxy_rpmi_attribute_id {
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID = SBI_MPXY_ATTR_MSGPROTO_ATTR_START,
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
+	SBI_MPXY_RPMI_ATTR_IMPL_ID,
+	SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
+	SBI_MPXY_RPMI_ATTR_MAX_ID
+};
+
+/* Encoding of MSG_PROT_VER attribute */
+#define SBI_MPXY_MSG_PROT_VER_MAJOR(__ver)	upper_16_bits(__ver)
+#define SBI_MPXY_MSG_PROT_VER_MINOR(__ver)	lower_16_bits(__ver)
+#define SBI_MPXY_MSG_PROT_MKVER(__maj, __min)	(((u32)(__maj) << 16) | (u16)(__min))
+
+/* Capabilities available through CHANNEL_CAPABILITY attribute */
+#define SBI_MPXY_CHAN_CAP_MSI			BIT(0)
+#define SBI_MPXY_CHAN_CAP_SSE			BIT(1)
+#define SBI_MPXY_CHAN_CAP_EVENTS_STATE		BIT(2)
+#define SBI_MPXY_CHAN_CAP_SEND_WITH_RESP	BIT(3)
+#define SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP	BIT(4)
+#define SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS	BIT(5)
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
-- 
2.43.0


