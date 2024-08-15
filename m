Return-Path: <linux-acpi+bounces-7594-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38388952B1A
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 11:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3814B21CB9
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 09:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0002C1C2308;
	Thu, 15 Aug 2024 08:30:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7AF1C2301;
	Thu, 15 Aug 2024 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710652; cv=none; b=jx2cIfgQOJ3wmMblfmwBDZslamxRynNXcwhNdLg7q15ry4POwTz9h3iCtFzTRB7clOvwcmATaLIBCiNGZcHkK7qcfs2GvTYBHVZd5iNrXsc9RFi3L37dbydnt99UOoxwnc7LAV+auH46n4MSn+4HvR1cChm1wK8Sjec3MQnV5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710652; c=relaxed/simple;
	bh=UCKGBoCnmN1loLFN5J/skTKjHoNsWsvh3M3lDR6/A44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VK1DqtmvNJ18YwXN+RHsPVZtdqFEQ30762iq8xo7Mu1X6M4LyCthtEoTvibD/RMuf9UXLxUR2heQejqUSftPF8eBIazhEtd19CgkUHXO1+aX0A1CjGi6sWBZNXO2Z4qrKCXTmFyyE+UoMW7aYt0cvkxgJA3xvHTw9FYrrjRMNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12C931756;
	Thu, 15 Aug 2024 01:31:17 -0700 (PDT)
Received: from e126645.nice.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94E103F6A8;
	Thu, 15 Aug 2024 01:30:45 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Robert Moore <robert.moore@intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Thomas Bertschinger <tahbertschinger@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 5/6] rust: bindings: Add bindings for rcppc_cpufreq driver
Date: Thu, 15 Aug 2024 10:29:09 +0200
Message-Id: <20240815082916.1210110-6-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240815082916.1210110-1-pierre.gondois@arm.com>
References: <20240815082916.1210110-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings to prepare the enablement of the rcppc_cpufreq
driver.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers.c                  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index bee2b6013690..a7ba64b5614b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <acpi/cppc_acpi.h>
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
diff --git a/rust/helpers.c b/rust/helpers.c
index 3b2850a11859..624b5c94dad6 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -370,6 +370,12 @@ void rust_helper_cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
 	cpufreq_register_em_with_opp(policy);
 }
 EXPORT_SYMBOL_GPL(rust_helper_cpufreq_register_em_with_opp);
+
+void rust_helper_cpufreq_verify_within_cpu_limits(struct cpufreq_policy_data *policy)
+{
+	cpufreq_verify_within_cpu_limits(policy);
+}
+EXPORT_SYMBOL_GPL(rust_helper_cpufreq_verify_within_cpu_limits);
 #endif
 
 #ifndef CONFIG_OF_DYNAMIC
-- 
2.25.1


