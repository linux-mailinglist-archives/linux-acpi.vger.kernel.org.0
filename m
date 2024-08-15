Return-Path: <linux-acpi+bounces-7592-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ECC952B0D
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 11:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3F8B210E3
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B2F1BD03D;
	Thu, 15 Aug 2024 08:30:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31FE19D8A2;
	Thu, 15 Aug 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710625; cv=none; b=BM9enkN9Cmey9ZGHQHGx4GnqdT/3LMEthID2nu9+I4rBTCqXKYejLqXpK00YZ2c9hiGyNyO3eITFYngN2MqMWTvxHKATVBCXIEkiskfjHOmPEsG0vc37/7fFm9TE7mk7LzNH5dgn1Rv72gsCA8k0xpTZyhvqfAcDflLkHk2gPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710625; c=relaxed/simple;
	bh=YRHVBaMdiGeTfmNJBTAk8FDw3gwW5aAfCPOCG88bRTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SFgejkM0OXF7m4cKUquPsApkJF+T1EtafI/b3TtRDtvdtvjyrjD+g8d/+RVVklWxHoSeGVwFOSb56cWiC053k2mIpfjRzcgl1hyPW3MpbnjtOZYoMvjNQ39zS5idwYx7pEg0u9ACJoeAIzKfLSOxOWcO+tzIcbt2L9ENkVj7eEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F35D16F8;
	Thu, 15 Aug 2024 01:30:49 -0700 (PDT)
Received: from e126645.nice.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D15D53F6A8;
	Thu, 15 Aug 2024 01:30:17 -0700 (PDT)
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
	Asahi Lina <lina@asahilina.net>,
	Danilo Krummrich <dakr@redhat.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Thomas Bertschinger <tahbertschinger@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 3/6] rust: module: Allow modules to specify initcall section
Date: Thu, 15 Aug 2024 10:29:07 +0200
Message-Id: <20240815082916.1210110-4-pierre.gondois@arm.com>
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

To give more flexibility to modules regarding their initialization,
add an `initcall` field allowing to specify the initicall section
their initialization function belongs to.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 rust/macros/module.rs | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index be03b2cf77a1..8724738f2a52 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -97,14 +97,22 @@ struct ModuleInfo {
     author: Option<String>,
     description: Option<String>,
     alias: Option<Vec<String>>,
+    initcall: Option<String>,
 }
 
 impl ModuleInfo {
     fn parse(it: &mut token_stream::IntoIter) -> Self {
         let mut info = ModuleInfo::default();
 
-        const EXPECTED_KEYS: &[&str] =
-            &["type", "name", "author", "description", "license", "alias"];
+        const EXPECTED_KEYS: &[&str] = &[
+            "type",
+            "name",
+            "author",
+            "description",
+            "license",
+            "alias",
+            "initcall",
+        ];
         const REQUIRED_KEYS: &[&str] = &["type", "name", "license"];
         let mut seen_keys = Vec::new();
 
@@ -131,6 +139,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
                 "description" => info.description = Some(expect_string(it)),
                 "license" => info.license = expect_string_ascii(it),
                 "alias" => info.alias = Some(expect_string_array(it)),
+                "initcall" => info.initcall = Some(expect_string(it)),
                 _ => panic!(
                     "Unknown key \"{}\". Valid keys are: {:?}.",
                     key, EXPECTED_KEYS
@@ -187,6 +196,12 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
         }
     }
 
+    let initcall_section = if let Some(section) = info.initcall {
+        section
+    } else {
+        String::from(".initcall6.init")
+    };
+
     // Built-in modules also export the `file` modinfo string.
     let file =
         std::env::var("RUST_MODFILE").expect("Unable to fetch RUST_MODFILE environmental variable");
@@ -335,7 +350,7 @@ unsafe fn __exit() {{
         type_ = info.type_,
         name = info.name,
         modinfo = modinfo.buffer,
-        initcall_section = ".initcall6.init"
+        initcall_section = initcall_section,
     )
     .parse()
     .expect("Error parsing formatted string into token stream.")
-- 
2.25.1


