Return-Path: <linux-acpi+bounces-15005-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52257AF88BC
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 09:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12A6F7B9AD1
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 07:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C88278E77;
	Fri,  4 Jul 2025 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Xpycg0q/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D8274FF9
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612831; cv=none; b=baN4+P2SgxHLi2FjqjWOW5PFcEc5bg8kMT5JePRTXIczaItEfRy+XwtdafOtFNBKiTe4Y2bxv7HMbiOqUyBRpYD2Wmt8aNkYFC5Z9pNwwnm7Ph9jnzn2ymEuOQqI8ioPJCtFaQ+YEAVagt4FBIBYSstykehFFkzKBsPR4w+U1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612831; c=relaxed/simple;
	bh=169PDjupJ8pNp0wACYdaBOi2G5j5ACOyZXywYUb0nJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtX2khtoF8plP4P97Yx/+bGfMNYqxaX1hct005GhubZztXF3bwZYx4JYhY544szALLjC/2d3UNNc+oep8jVvpzHCXCUrT/BRLUefZqAXbL1QzwyaS3tu4KgAohckHnmtDQbTDmN5YE/AYRfhFDIPEUdbK9nCHCjPmyAtNibn8Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Xpycg0q/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313cde344d4so714396a91.0
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jul 2025 00:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751612829; x=1752217629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNcclU2G18Bdovh3QAsek7AK/q114CkADd+BrTGwXao=;
        b=Xpycg0q/HWdHHvv6tbsoU/uiBy2tEVhatOJsw2uoaL537pgNT6y/0lQTeJ8jx03irM
         J8AVhXk9X7foqKcXvc+TOjkTgztEX1JVr9ykZ/Ug+jf8+yswhgGgW5GtFd5e4UdPt8Sf
         fUQOerbOqr4cUz3Q70fK06TPZhB/u5V955dm72PdR5sBWuqEn0JwAr+puO5STOgTRrRE
         rkjvdBF1zAAEO+bbvr1UnYMGcfeKBAafUI3cZwmK0MfJVCISeCtW5yWxUPOJApH5riZh
         itctuYTqXaOFnV95nfzH1CAgtveSbbWS9CHLQG4gIVzsNUUN///KRPnpTCopQrnCnuf3
         o3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612829; x=1752217629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNcclU2G18Bdovh3QAsek7AK/q114CkADd+BrTGwXao=;
        b=xIe8cZQM2HW0yTMNgKvOhZ5IPCKJudTbvP6w2S5JLVeOgSOlxz7QqD3avAwI/XkQ81
         45/oBr8ttmxA67aU4kKC3wkK4cblhmLBEbDCOm1fnAVSP2kFfSZOqPVVt/qPchFcv8YK
         ojCZAhIh4TlZ3ivM+2e4t+h8cLxX1lS+XGvy6/+rQmvCBfzQF8O0ltGF6i7x/F0KE35B
         lshQkyFuVNk9n7Mt0ZRwDvptW7bJL/1DbZ/TjLsykR79La+IVqe1BiokRrh5U0/QI4Fk
         C/TMxuDa1w1tZT1eNhvpy98ClqnXzG1nWHQ2Kwo+jVotjPobMO8FgsA7nOZFXKmtJZOR
         y42A==
X-Forwarded-Encrypted: i=1; AJvYcCUbhTuBidxvEkJWw1PcFAGmRZmvTEfneQ0oAhy/uZV4Y5pPuboIuqxmwAZ5LyzduFHo5u6smSG0+tSe@vger.kernel.org
X-Gm-Message-State: AOJu0YxUgzSCCq97r++6ato/nPfD4sCUogpbP3Y4jg/QGl+sRQGWNesD
	HduFSQyDmLrd8cTCAk16SklQQfMNmbNNP7MrZSW85nOXLJfGnY3GUmB8Nq1930n1YIc=
X-Gm-Gg: ASbGncu2WybLsdKCe3loclxLhTNDW2UOkv4ZJ/4bJFlusfVQgL8YB6yNzM5dkCOl0iX
	Cy0AtzlLczetz1IFiya+NHm1yy7kmz1/KghZBU34JcySguDspEEaLUAOmHaMentfJJDsEJEVc0j
	ay7eaofqoETerqXSoxes9I/E0izkYdqfraJP+ZalPA2EE9uI1KNwksJJ69DhJV9ux56uK2A9HSx
	jkDe56eC3PnwmCVtDqGqxEATXgdpldUseBolYgtcruBjqTqFKvNHuPM5ZAf2T+9VCVjpsHLMMnw
	xg7nXNbXGl9jD7+laoALehpZn9AS1Lih5B+oN3jkTo8NLndNYtG9MH6f5grwmMQ4mf3Vzge7cbg
	L0Tt8USji8wiHriEtnlTk4LeWBQ==
X-Google-Smtp-Source: AGHT+IGrP/l0dKEOOpvLsvS4JGiMBKWICRCAtYJOylbaG7ycll8dUnb8u46RulbU17ZZf/1gB5ixPQ==
X-Received: by 2002:a17:90b:33d1:b0:312:639:a064 with SMTP id 98e67ed59e1d1-31aaddb4ac6mr1562105a91.28.1751612829169;
        Fri, 04 Jul 2025 00:07:09 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae59a93sm1358697a91.12.2025.07.04.00.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 00:07:08 -0700 (PDT)
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
Subject: [PATCH v8 15/24] ACPI: Add support for nargs_prop in acpi_fwnode_get_reference_args()
Date: Fri,  4 Jul 2025 12:33:47 +0530
Message-ID: <20250704070356.1683992-16-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704070356.1683992-1-apatel@ventanamicro.com>
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunil V L <sunilvl@ventanamicro.com>

Currently, ACPI does not support the use of a nargs_prop (e.g.,
associated with a reference in fwnode_property_get_reference_args().
Instead, ACPI expects the number of arguments (nargs) to be explicitly
passed or known.

This behavior diverges from Open Firmware (OF), which allows the use of
a #*-cells property in the referenced node to determine the number of
arguments. Since fwnode_property_get_reference_args() is a common
interface used across both OF and ACPI firmware paradigms, it is
desirable to have a unified calling convention that works seamlessly for
both.

Add the support for ACPI to parse a nargs_prop from the referenced
fwnode, aligning its behavior with the OF backend. This allows drivers
and subsystems using fwnode_property_get_reference_args() to work in a
firmware-agnostic way without having to hardcode or special-case
argument counts for ACPI.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/acpi/property.c | 29 +++++++++++++++++++++++++----
 drivers/base/property.c |  2 +-
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index d4863746fb11..e92402deee77 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -804,13 +804,35 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 	return NULL;
 }
 
+static unsigned int acpi_fwnode_get_args_count(struct fwnode_handle *fwnode,
+					       const char *nargs_prop)
+{
+	const struct acpi_device_data *data;
+	const union acpi_object *obj;
+	int ret;
+
+	data = acpi_device_data_of_node(fwnode);
+	if (!data)
+		return 0;
+
+	ret = acpi_data_get_property(data, nargs_prop, ACPI_TYPE_INTEGER, &obj);
+	if (ret)
+		return 0;
+
+	return obj->integer.value;
+}
+
 static int acpi_get_ref_args(struct fwnode_reference_args *args,
 			     struct fwnode_handle *ref_fwnode,
+			     const char *nargs_prop,
 			     const union acpi_object **element,
 			     const union acpi_object *end, size_t num_args)
 {
 	u32 nargs = 0, i;
 
+	if (nargs_prop)
+		num_args = acpi_fwnode_get_args_count(ref_fwnode, nargs_prop);
+
 	/*
 	 * Assume the following integer elements are all args. Stop counting on
 	 * the first reference (possibly represented as a string) or end of the
@@ -961,10 +983,10 @@ static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 				return -EINVAL;
 
 			element++;
-
 			ret = acpi_get_ref_args(idx == index ? args : NULL,
 						acpi_fwnode_handle(device),
-						&element, end, args_count);
+						nargs_prop, &element, end,
+						args_count);
 			if (ret < 0)
 				return ret;
 
@@ -979,9 +1001,8 @@ static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 				return -EINVAL;
 
 			element++;
-
 			ret = acpi_get_ref_args(idx == index ? args : NULL,
-						ref_fwnode, &element, end,
+						ref_fwnode, nargs_prop, &element, end,
 						args_count);
 			if (ret < 0)
 				return ret;
diff --git a/drivers/base/property.c b/drivers/base/property.c
index f626d5bbe806..6a63860579dd 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -578,7 +578,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_property_string);
  * @prop:	The name of the property
  * @nargs_prop:	The name of the property telling the number of
  *		arguments in the referred node. NULL if @nargs is known,
- *		otherwise @nargs is ignored. Only relevant on OF.
+ *		otherwise @nargs is ignored.
  * @nargs:	Number of arguments. Ignored if @nargs_prop is non-NULL.
  * @index:	Index of the reference, from zero onwards.
  * @args:	Result structure with reference and integer arguments.
-- 
2.43.0


