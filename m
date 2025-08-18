Return-Path: <linux-acpi+bounces-15765-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4B9B297C0
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200C04E66C3
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C0D264F96;
	Mon, 18 Aug 2025 04:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="P9Q581HK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E805264A92
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490259; cv=none; b=Q+Zt2Sk5LfxGFU0o/lO6XPtdHJ9jsIUO5IALzry3s8fcLYOyOgImDCSBkJ6ickvz9RD7SN60bJiqbXoYgwY25yrGulRZxqj8Ns/i21lE9ttTjuUQ+zKQTfPH+hXzWI3c7P9BVR1D9xylgtYetRoJoLtbKd7G2oVN1p5tdRD2Wd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490259; c=relaxed/simple;
	bh=UBn+LBjax9N4GZfXPTV/0yYRe68OpjEpS5e1cFYqyMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXhLmZ0g95OJZmJDcY7Wf5xjM/ow8NvjtQcnFeYvR/nMtG22/wALEUvBFhyp5efj6W9xQINOB7trycYyzLbKCaLEabL7a6utrqfSxMM5Dz8HKy0bAwsoKo8E9palCa6MsFp3eXmjD2GQ2SSx5j008FFOfxSpO40TKNw4cRI67b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=P9Q581HK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2445805aa2eso28807565ad.1
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490256; x=1756095056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl+ki3sYBLOuIZdWtmik+PFOlIYEBNco4Pu8AxHtczE=;
        b=P9Q581HK8/KAZ3rnXUSh8nAgIRolwnPxlSBXom15JzP4qXSLqTCzyQzc6bNAfPTjDc
         uU2/MEDHJfhtRWVgZxGo/fxzBeZwL+n4qMxhhdTAQ3Bc34XbcC0g3ROHs0qcGJLShant
         1b/KxBBhvZMiKkFR+kTBu9jXJJlQSqWh2uYl0bTZXzJ3fhmR9j2aSqx3TZPi7uWa0t00
         lpHakni+toVcdH1DUVXY3YRzDA7EDg6rVsDF5DFa+iQAW82SNkfbz29TRkZCLrqAQiK5
         uiRZ3m3yHTIZupCAZhuxr7YHYmDfyyU+KvKvw/092Vf1WCaSZt/fvg/lIKoZXm3Dep2J
         en8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490256; x=1756095056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bl+ki3sYBLOuIZdWtmik+PFOlIYEBNco4Pu8AxHtczE=;
        b=CMQiOtLvjGx4XlyEnJs8T/puKAtHfmB9fYQllo8PDtbiSfnXtitCUXemy/OsP6kUfn
         PmiuZEowdyK8wrlrhH1RrZT8pJWiIjAjg9bZjb+3DBF2RvBw09/1jnGb+SgPsHDKYrhx
         j9F6QJ8YfcGf7kBxpYq+HuFgH0Fi4C7MZwFLF0+tZfESgnp4Et6z/QkgJtccpJOjTSXE
         L7pK8QwWbScWD5pV2c/lhimLrl2tImkAixrnQSO80E+CMzsyLQ721Itb00gIGI/Rl+x8
         taeXSpuTl61eSz44aAHuNFfkpErjUfOZcQInVL6vuMYQqqNX1OAoga0V69EPReitAHXd
         cVtA==
X-Forwarded-Encrypted: i=1; AJvYcCUa5VLHnaYw8g+1edTL6TAQaEOssVrd+ODXTc5FD+5zQzKZibOfzjr/yZrEFztKxTXwXrq/EjLgxdPx@vger.kernel.org
X-Gm-Message-State: AOJu0YwYFeiHH73YwPTXctQLLq6BuaBwkn6+LtUhowEOn78eYuOCExlc
	sa0td3lpWTP5oci7k/w5nmWC4hfqY11ULw4PPxW8mcRIbQXtoK4laFwSkKC3bkjtL2Y=
X-Gm-Gg: ASbGncsVYr6/Je2KSCbsC0PK1xdDn0BmcUhiTL4ce7rmNTjstjIfLYA45qA0U/8/ciN
	/4Lto5/HZwzsD52GJhWx1QYZ5lIZRkwr05v/9lJ9ZAAR6gyfjxUEZsfE4S3NHg9JgDJUXowGqMw
	8kDZxmXtJ5t6at2331kCO+u0FyBX0ofmf++uIdB839RB+E0HUoJhqD3Smv+lqmuCCbkXKw0jsCt
	GhxrBc1EAWaAGnteygvie+BUlJx16HPM9ubZMtlwNp8ppI6T6sfRdwi2/Ugv8CcXbrzvNNxmjsu
	5OLC7TCfJJ3eSQfgR2hbIf8Y5DdWDBx7ImVBuPxQgkLsIRrm1ygI6/4EgKwgGekRzkxPyhLNfys
	wmvKeothULA/m9Mrn0RMSKDKjpaq3/6nki4D+E87nMN2Nank3Wxpz8A==
X-Google-Smtp-Source: AGHT+IHeYI/gJKhVi0ejI5JAJv+DItCCeU8H2nRnY+2JhkO9bcHtEjh5t07sN3PKPK/WfAop4xC+yg==
X-Received: by 2002:a17:902:e848:b0:240:72e9:87bb with SMTP id d9443c01a7336-2446d934b0dmr122949965ad.42.1755490256221;
        Sun, 17 Aug 2025 21:10:56 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:10:55 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v10 06/24] byteorder: Add memcpy_to_le32() and memcpy_from_le32()
Date: Mon, 18 Aug 2025 09:39:02 +0530
Message-ID: <20250818040920.272664-7-apatel@ventanamicro.com>
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

Add common memcpy APIs for copying u32 array to/from __le32 array.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/byteorder/generic.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/byteorder/generic.h b/include/linux/byteorder/generic.h
index c9a4c96c9943..b3705e8bbe2b 100644
--- a/include/linux/byteorder/generic.h
+++ b/include/linux/byteorder/generic.h
@@ -173,6 +173,22 @@ static inline void cpu_to_le32_array(u32 *buf, unsigned int words)
 	}
 }
 
+static inline void memcpy_from_le32(u32 *dst, const __le32 *src, size_t words)
+{
+	size_t i;
+
+	for (i = 0; i < words; i++)
+		dst[i] = le32_to_cpu(src[i]);
+}
+
+static inline void memcpy_to_le32(__le32 *dst, const u32 *src, size_t words)
+{
+	size_t i;
+
+	for (i = 0; i < words; i++)
+		dst[i] = cpu_to_le32(src[i]);
+}
+
 static inline void be16_add_cpu(__be16 *var, u16 val)
 {
 	*var = cpu_to_be16(be16_to_cpu(*var) + val);
-- 
2.43.0


