Return-Path: <linux-acpi+bounces-14132-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED1ACDE06
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 14:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0257A86AD
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 12:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5624628FA9F;
	Wed,  4 Jun 2025 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKacmE3f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163628FA9A;
	Wed,  4 Jun 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040346; cv=none; b=RORpP8aWzPJL0JDr3/y2swEla0C8NOQEuCJhMsV6xirBbTMpjmfczQTVzH08TZ6BzU+ASL/vKs7stZnJSjfD1a6o3fM8vOjJ5AgusE9ze2zRYdWwyW+h5pagnk3Uv9JSEzeW0ffc5LgXbsyEYmuP7jc3ifSHTGFd9vGtV5kfffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040346; c=relaxed/simple;
	bh=EKuEJj1hiN5FAUPJllRUOb+XzT5dqu2BT3noUkRJ9Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTSrMKbbFDb+l2lv+5UbO5jL0xdf1fgsTlj0vtST8U3qGftEoTcyRgSGz8Kvh0VwEuabtsxBGSJ5dUCKBDbVnyXQYE4wBtJGkd5FE0WXZJ8sm+iFk9iNzXLs9tsNp7d9socNjVNtiHT7q7cRgLnO55OhKVCaJoF6xGXrR0qFH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKacmE3f; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-450caff6336so42011355e9.3;
        Wed, 04 Jun 2025 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749040342; x=1749645142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zb6n4xN+CaXNZLNAdkRh4qtNOwrRTbDiXvfunUMx5/8=;
        b=QKacmE3fBKmoq77l2hVR+i2gvGWOO5Hqq8jpQ/sc8zOZ5xsaDwBhZaz0lhGxS95TSO
         VrICSgyQOLiWvN7Sw9OHOG6pMOkAAJv0AZEv0G1oVJgx5jfKvk0Mxa4sxo7dRe9yUfmT
         tjRnqlk0bCWzU5UTxHLxZBWJ7Zv1sRuhyI17upTiVuvfpMVPlemy8PBW5SDwyXvVWP7B
         8pfMJAPNyz9CPN4jGCBaGpimw6cyowGN9SU+ywXXWCZTdzOvA3SyNF8RzCH8MBdw7EWz
         jOQ7aXsFbIjBfDomhNc9r4hppHqAx444VQIAWiM7bDdNtimHGwKtMDTaraiU40VmJqk5
         0qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749040343; x=1749645143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zb6n4xN+CaXNZLNAdkRh4qtNOwrRTbDiXvfunUMx5/8=;
        b=ksElP5p2Pb0PQFkVyeDaIWaXiF1O1lYYwcGKdbcclvcHb8zVdIdWyloPffj4lO6/BY
         dG17q8cFnc+LXs/ge4BRxF5DkKURENppwiZ5IrfXtt50n/96EpuN3CbmMF2Ov4eMyj3y
         gLtuaLuKME7qF82ovoaC+XkUiMpyFGV55gKFQgkq3jMgsScOed6a5N4lCNGBmWn05knP
         ezpjeEy8By/tPtNnx2HFQXD4IKDRGazoKlHaIXVILDKjrkhpDaiuAP4fJVYbI5TFmdPw
         gALvu7+2bzAAfa15Jx0GaAiBPXNBIANq0C0aIwmuiL0zcHEcWqF/pSJGt69yO8wM3yhu
         RYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAWdgzvA14/xwV+zUXdP0j8Pvd4gthI5nQPNwlXMiMiNERoev8X6RLSEhvpUfDjfueZXZVkORozhVVb79T@vger.kernel.org, AJvYcCULXgIlbgxxlV6rCb4nQehUSYVIY7NECsRrze6vgXPFuxW8UMickqf7v9wf0zG0bUCMQZaezCeg7J5w/XFJUSo=@vger.kernel.org, AJvYcCVg+KOJ2lqEaN6q8S7FjcmjNH7Z1mzI/Ue/r6jU2k2ALVjM4N8KKmKEO66eFb2nA4FUKRfNGG7VBtT6Kg==@vger.kernel.org, AJvYcCWRWpzjH55Y47ixlK5U/ncVR2uOjoy09eK1SItuJxe9jN76JFBkzVbKetM5eGdZil4jfRwahpMfPqDl@vger.kernel.org
X-Gm-Message-State: AOJu0YwixhAFX+s1mMAPRizzJEtox/EbxIPnJl5Gx1TkLs+WpR4Itlbn
	bMnIKNIwKgg+0y+WMAjpCwqyAFL9zaqJaoGStEL8SRmY8lsORJGqKVXj8by9PFWC
X-Gm-Gg: ASbGncuZHUkf6MbKWyU4Vt380mRvwudnFxQ2c3AiiJhvm8UvxON8pNb3qfuuDSftzZh
	qNiQZssF6aScWradmO1PrtcSaDlSa5TVc4o5cd6fMFtV/0saUiEIOSlnREd1K8toNbo5xMCis+K
	pL+Op3SPY58BiUiLjIrVlTdHmTUfRUpDS1k3XXyv5VOuxD4mIpXoRCa/mjgMLiEVx2JynUIOnyu
	WSXfC+YYzFd5NVwTCSQAWsQfBN8qg50pOxS///13CxEMIde6yFNohxY/3CKq0b4kd0Y2k6G1qsr
	af2o4mm4U+Cwe3GT+xkp+7rc5XSxORHDa00/BgGtFt0tDzvj7LazkUT+u02zqwh+1NP837Rntb6
	LPJYYrleRqb9p08LaLlQFZK5W+HGhuRDuPeZOy5c=
X-Google-Smtp-Source: AGHT+IFhjQKYa6TmqFc5RdnTJpBhC99HefNd12BPqVLoU7t0wxGN1xn/KoXcIxM1eKnDWp8Oj5kJJA==
X-Received: by 2002:a05:600c:4686:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-451f0a8a2b9mr21941225e9.11.1749040342334;
        Wed, 04 Jun 2025 05:32:22 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8006c21sm194467085e9.33.2025.06.04.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 05:32:20 -0700 (PDT)
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
Subject: [PATCH v1 4/5] rust: platform: Add ACPI match table support to `Driver` trait
Date: Wed,  4 Jun 2025 13:29:43 +0100
Message-ID: <20250604122945.3445776-5-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604122945.3445776-1-igor.korotin.linux@gmail.com>
References: <20250604122945.3445776-1-igor.korotin.linux@gmail.com>
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


