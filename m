Return-Path: <linux-acpi+bounces-14165-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6504FACF4C3
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 18:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263EB17452F
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4372E274FF5;
	Thu,  5 Jun 2025 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu3f3a49"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC461D63C0;
	Thu,  5 Jun 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142312; cv=none; b=lOFJSlKTLwgZCVJVvGq+Q4hy5dM4Xzp3Qcb/5JM/QDtk6QJEjflif2XU7LZA7scVM6uMtWgmfpywG+ECZk2SeMZYBpsZ8/+HbB4DLhBAhUsTot+8Sz7Y7F18DN24q5JU+1c712RDAsqF26jSriV70GjhOKMNSxlV3ssvqnrJZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142312; c=relaxed/simple;
	bh=EKuEJj1hiN5FAUPJllRUOb+XzT5dqu2BT3noUkRJ9Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSu1wGIYThGBoOeGlkyecenKFTuBU84/YJi17W7ToIHvh6L5h4RjIl0kGeKJH0S2+jh0KCd8xLjwFcd/PlblKgnZrsrr+OAlwAZ7SG7JsM+wmXx78Bbd7AevvrtZ9uj3q8p8s2FJl7ZlxhmkU5wEZvWmonRM2v8ADJFM0xB5e3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu3f3a49; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so10127595e9.1;
        Thu, 05 Jun 2025 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749142308; x=1749747108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zb6n4xN+CaXNZLNAdkRh4qtNOwrRTbDiXvfunUMx5/8=;
        b=hu3f3a49ctgx2xSr9S86FGXyEKTuUYNUWePORqobm5O4Nw6k6lVhoRlLAvL2xNNYll
         16CbhTpPqFZiQHvkz6rlXS/IzqZRwd3ZU+sRiy+MMOfAbMGzgc3fWH6jc35mkBZwQFAX
         a0dHiFrYoT3sEnBXIGgfSrZs2yjiy0Jp55mCkM8E9Yl15X04l/41zj5o52YNvv3e7RmN
         +0wRu4UB/xtBwhPZzQmutETtObAquUrbaSlrGNjOTl+vn3tO4GpSeLkC/Y9TPbgyzvpi
         /9Fs58k72MTEGPTyFZIxJBIwsNy30In2pHNRMCcTkU12CJFbb09aAG6AjFGsxQcmFj+O
         SN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142308; x=1749747108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zb6n4xN+CaXNZLNAdkRh4qtNOwrRTbDiXvfunUMx5/8=;
        b=f/n6jXlZfstgRDddDNHn1sJ1OsLc2415JfUuoZZiGO9ITmPHA7HkUDeJdxsq6gYUoL
         RfTGNr0eYbY3SVUUdymTPy7RAzx54H2qubk/+9T9AwiPk7PEq3UtA5sZhfs6tSXVr8r6
         7vUMaiX12yvuyQXXJJfVju43QkZ2U9W2yc5VqF8ep9KIWzVEMhWx6GIJPVMUtmzPCsB7
         w9VicrIaC8IyIRJzQVg0RFx2cuziGZKKhRpIgrwRQgUBQ+JCmcBRcm6gOCzySA0ZgnzP
         hUjd+V6TrwOSmWESKjjzBVDckqX2X+WlQMq4RbjVU06LRGiFnFBgTJh10u7Oyop8HSPl
         3VXg==
X-Forwarded-Encrypted: i=1; AJvYcCU18jPvok1adoYixYErGbpxUoN9hoKchliKYrmoSaGBhhszCZwv/G2WPQKISH48Y5dW+ziJCotQnj8oahKbvks=@vger.kernel.org, AJvYcCUUi404biVziQnxvLdLBBKPyuDTq2w+I5ntELU/gblBTkpZOf7FeLr2a6d+xt4h5XViv6N0Zs2FZwyC@vger.kernel.org, AJvYcCVDbOcM0R8F70RNZ6hV8jX6snm4hXYMxznQwrtb2DZfKmgbV+Z0QzIy1+0IIPqW8n63NfYglTv+eODjPA==@vger.kernel.org, AJvYcCX1qdFNrrdxi4APJjK4rHuxdPmq154gSca+vQ5gOT4O4xPp1Khsqh5ZhSsgKlT4uxho9hI1sGrXckIMb6Ch@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm4B/pPMZTjPD2qq9C4zXZ1DTl4BPA0hQHXUGOQdQMKmtvwy+1
	UOpfaaUwiKRswsNq0DXuAV8PrkH9qIylgvBHq47aR44tjWaLTURV5vOD
X-Gm-Gg: ASbGncv8l9Uu4BkkUXXxq9KQRgaLstGp1eYplXZVu8qAFGJzvH0DThMYVvOkPNUMbgH
	TFZc4LNpKRN9cQYPSskv31zJwDKvRURY2PYbjvj6YxhBvzOcEI63UAaKsRjKhvOM29nWMVam4xv
	Zg2WKJIJVh38o4QMGVscXbN3wJ62MVamxXy9zcQ/i+0PJO99DyQpX0mxqTv1O0UxIe9ll7rmdz6
	qJ7yizwjZ6JmfSN7nDc42OxWmGbGhMcLrm2lbBDTjFwl6Qrl3JqIOWPeqWvJqo91L5/cW+DsvW6
	sAL8pR5GPGfezX6vImTFDf3lh879hA8IiXF5u7iARekUW9Sm7QHRqoFYV2Va8Utxk3A68PTKb3Z
	gpeuujZYcjG4avxAfkwgqEPA=
X-Google-Smtp-Source: AGHT+IErjGYl7sI7GIuDfz4J4eQlm8b9WIboTOmarv33R4sio/kFqZCnW1PcwtspN8KbUlz+HhwPGA==
X-Received: by 2002:a05:600c:3504:b0:450:d00d:cc with SMTP id 5b1f17b1804b1-451f0f00d51mr73369675e9.2.1749142308298;
        Thu, 05 Jun 2025 09:51:48 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.. ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fb17b58fsm24015045e9.16.2025.06.05.09.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:51:47 -0700 (PDT)
Sender: Igor Korotin <igorkor.3vium@gmail.com>
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	Igor Korotin <igor.korotin.linux@gmail.com>
Subject: [PATCH v2 4/5] rust: platform: Add ACPI match table support to `Driver` trait
Date: Thu,  5 Jun 2025 17:51:44 +0100
Message-ID: <20250605165145.3663681-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
References: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the `platform::Driver` trait to support ACPI device matching by
adding the `ACPI_ID_TABLE` constant.

This allows Rust platform drivers to define ACPI match tables alongside
their existing OF match tables.

These changes mirror the existing OF support and allow Rust platform
drivers to match devices based on ACPI identifiers.

To avoid breaking compilation, a stub ACPI match table definition is
added to the Rust sample platform driver. Functional support for ACPI
matching in the sample driver will be provided in a follow-up patch.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/kernel/platform.rs              | 14 ++++++++++++--
 samples/rust/rust_driver_platform.rs |  3 ++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 3cc9fe6ccfcf..e6cc878a5a37 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -39,12 +39,18 @@ unsafe fn register(
             None => core::ptr::null(),
         };
 
+        let acpi_table = match T::ACPI_ID_TABLE {
+            Some(table) => table.as_ptr(),
+            None => core::ptr::null(),
+        };
+
         // SAFETY: It's safe to set the fields of `struct platform_driver` on initialization.
         unsafe {
             (*pdrv.get()).driver.name = name.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).driver.of_match_table = of_table;
+            (*pdrv.get()).driver.acpi_match_table = acpi_table;
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
@@ -98,7 +104,7 @@ fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
     }
 
     fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
-        None
+        T::ACPI_ID_TABLE
     }
 }
 
@@ -129,7 +135,7 @@ macro_rules! module_platform_driver {
 /// # Example
 ///
 ///```
-/// # use kernel::{bindings, c_str, device::Core, of, platform};
+/// # use kernel::{acpi, bindings, c_str, device::Core, of, platform};
 ///
 /// struct MyDriver;
 ///
@@ -145,6 +151,7 @@ macro_rules! module_platform_driver {
 /// impl platform::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
 ///     fn probe(
 ///         _pdev: &platform::Device<Core>,
@@ -165,6 +172,9 @@ pub trait Driver: Send {
     /// The table of OF device ids supported by the driver.
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>>;
 
+    /// The table of ACPI device ids supported by the driver.
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>>;
+
     /// Platform driver probe.
     ///
     /// Called when a new platform device is added or discovered.
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 8b42b3cfb363..e3992e7a71e9 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,7 +2,7 @@
 
 //! Rust Platform driver sample.
 
-use kernel::{c_str, device::Core, of, platform, prelude::*, types::ARef};
+use kernel::{acpi, c_str, device::Core, of, platform, prelude::*, types::ARef};
 
 struct SampleDriver {
     pdev: ARef<platform::Device>,
@@ -20,6 +20,7 @@ struct SampleDriver {
 impl platform::Driver for SampleDriver {
     type IdInfo = Info;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 
     fn probe(
         pdev: &platform::Device<Core>,
-- 
2.43.0


