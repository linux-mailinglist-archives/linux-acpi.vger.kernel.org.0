Return-Path: <linux-acpi+bounces-14440-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B62EADE8DD
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 12:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEBE3A4B48
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58572288521;
	Wed, 18 Jun 2025 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXB2kXbk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C62877FF;
	Wed, 18 Jun 2025 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242120; cv=none; b=DZf0XWI5XZEHpZnbba5D2HAJhvATdsRQGe6C4GdG3rlwJ9TRJ6RtANwSnXCz/SJXwObYynHVwBLwOyqZSRwfXAuxR6MlL7EhzvmetgwR+zLTwfiV6a+1ovWL3tCuC6Nntqv4rKGgEz+sGJYiW1cqF2niAlEgEGCi8iJbzUqZ1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242120; c=relaxed/simple;
	bh=1Hy3ujJXBqxV9lfXBO++FN2/fZmpMCZpJfkWT5aJ4iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZYxZVDtpB43qkdmmqb9csnwSmuijimnaVDz/NG7/o8wSpWkxcqPo9OdCwioerTQ4rUgBlzGqPKcpqCnOSnl4033oFpFSdGep/6NEnHgjPT+cRD5SMROuLpElD+NjtG1bkMzEBy17N+ufKMFNHj9Dc9BVrvox6aMofomOt0CaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXB2kXbk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a35c894313so7551132f8f.2;
        Wed, 18 Jun 2025 03:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750242116; x=1750846916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7KlnwZB+CxVWmAEV673+n7G11D71TLYbf9q51R/jMw=;
        b=cXB2kXbkuAy9hDfKDfZozzZfsEXtcUnC5DP7KWb5mDfLn8iFyvLx2qfoez9TMRevoo
         LXZ0HRUUBrP+z8uC0DJCrfBrBLWFmX1rzbtP7ZxPV99tPzLEwFAh/al/MwKBy6vb7g9N
         CZZjVbxoA4qZTzKrzRWBNZwWxk0ekKuau41orO6Lcd8v8jCEAQf6i5tYRFwZ41nDwBqf
         iExHvMaQ4iirdDJzPheE9Sj+5favfHkKUurh442+3h5qla/nw9HoWH3Dry8BB4eNS9bs
         zXPrpXcqWdQh8xDqvXnDK3BQVOnZobPuWOt77hqoi/ShOFY4dyAbaH4sKQjdI8zONoz3
         OF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750242116; x=1750846916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f7KlnwZB+CxVWmAEV673+n7G11D71TLYbf9q51R/jMw=;
        b=hmkQtZGirV4abw1sCv5SMQ4lLWneYhxabsl7QJ00D99WtyE49qkIsLmM/7aepIcqFx
         uFSmbVBzAC3kskCt7DD8m/ZMPGmM8iClaWY6+iFj6rMEcnRtU/OJ+REFQO2cj7k0r9x3
         UFnXQO24xpUDKtUijUJiOasmBYjqx3NZFfyq3aoUKjzESxnPdqQvAohCZfq7FuYow5Ht
         UQcOFwHYdxlZ8RyrEgybRjFVeDwZ4plsJjiI4H8+XNd3umeaLeaxQ/0CjBXAafsoTgMI
         5oq9vC+SF8GgUytx84aE/fux4doZEOPLHB/ztvT76HKwsGg0Mb95UdJB2JtV9tTWyq1V
         bApw==
X-Forwarded-Encrypted: i=1; AJvYcCVwGxHIAQ4mL2JWwaj+OsVs0fmAGJ7FHGOCGXPNJvLC21/33NivPF2q8bok1aRLcx+Rrx8DH/hNu6cL@vger.kernel.org, AJvYcCW+uPLT9OvPbQ711ZUGk5IObIoAG7NLEPsMPy/CeqhWAkqxNRcdzQ7JXgkjabcF03xundhPQPaGff0TdMoN@vger.kernel.org, AJvYcCX1+6igHnUsyFSLaG6qHAxpTpAhzeLlzAGNynF+OQbS0M6CKZc5w4VeKC/b4Y1oa7IgVcEmkYzAGZv8rFEgkCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP//yJ+4chSzvc+KrZQN5NaV68D4/gG9Kor2J7lNm0ef3kvCOt
	z3QiSGwZFiLRbvD/qnwyvsE7+JhYfsPbj6USYxV5izmWP/Lq4WYbgrOm
X-Gm-Gg: ASbGncuc4grRK8U/xC4A5qhAs8UuWq5HuHKgBUSrbxOUjw42gsEDJgYmyulxpT5rlZy
	YijuTPoeLxyT4GZpM4D03tOHz81fc5d61AaxdMN+/TU3aE3xDQOiFMpkourdbmYrqXV+E8CFOan
	Ddz2LC1h/cyImgl30wt3nJeUNWjhB94ymFvZD8LDwEhS6g2w+Ga3Hb0Mn6OjdSvIuR/eUYrlT2m
	/hH6nwIuH2FakFwlJp+o2gbEVR/TCoLZrNgy3EiJfmmP4rJbJCq42+D86f0C039ESUaVNX3vqUG
	XSmmjBU05rNMCTocYRtOjK7uaCtpP+NtitqGGY7BAFkTRjI6MPOy1soHGzjn8y++hOiPnV3qlws
	WwlhMog0hDYUWxg1IPt3iLISJZvhVOpVGh05c
X-Google-Smtp-Source: AGHT+IHTcdjTyyUyU7t1sq6t+9KngpxfIL2u1E+Zj8SLI9gfO4QlomLwU83Tc/eX4WSsq1bROLC11A==
X-Received: by 2002:a05:6000:1acb:b0:3a4:f038:af76 with SMTP id ffacd0b85a97d-3a572e886ddmr14451774f8f.53.1750242115844;
        Wed, 18 Jun 2025 03:21:55 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a53f79sm16320729f8f.4.2025.06.18.03.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 03:21:55 -0700 (PDT)
Sender: Igor Korotin <igorkor.3vium@gmail.com>
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	lenb@kernel.org,
	wedsonaf@gmail.com,
	viresh.kumar@linaro.org,
	alex.hung@amd.com,
	dingxiangfei2009@gmail.com
Subject: [PATCH v7 6/9] rust: driver: Add ACPI id table support to Adapter trait
Date: Wed, 18 Jun 2025 11:19:52 +0100
Message-ID: <20250618101952.3048902-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
References: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the `Adapter` trait to support ACPI device identification.

This mirrors the existing Open Firmware (OF) support (`of_id_table`) and
enables Rust drivers to match and retrieve ACPI-specific device data
when `CONFIG_ACPI` is enabled.

To avoid breaking compilation, a stub implementation of `acpi_id_table()`
is added to the Platform adapter; the full implementation will be provided
in a subsequent patch.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/driver.rs           | 41 ++++++++++++++++++++++++++++++++-
 rust/kernel/platform.rs         |  6 ++++-
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index bc494745f67b..dfb2dd500ef6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -28,6 +28,7 @@
  */
 #include <linux/hrtimer_types.h>
 
+#include <linux/acpi.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index cb62b75a0c0e..8389c122a047 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -6,7 +6,7 @@
 //! register using the [`Registration`] class.
 
 use crate::error::{Error, Result};
-use crate::{device, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
+use crate::{acpi, device, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
 use core::pin::Pin;
 use pin_init::{pin_data, pinned_drop, PinInit};
 
@@ -141,6 +141,40 @@ pub trait Adapter {
     /// The type holding driver private data about each device id supported by the driver.
     type IdInfo: 'static;
 
+    /// The [`acpi::IdTable`] of the corresponding driver
+    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>>;
+
+    /// Returns the driver's private data from the matching entry in the [`acpi::IdTable`], if any.
+    ///
+    /// If this returns `None`, it means there is no match with an entry in the [`acpi::IdTable`].
+    fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+        #[cfg(not(CONFIG_ACPI))]
+        {
+            let _ = dev;
+            return None;
+        }
+
+        #[cfg(CONFIG_ACPI)]
+        {
+            let table = Self::acpi_id_table()?;
+
+            // SAFETY:
+            // - `table` has static lifetime, hence it's valid for read,
+            // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
+            let raw_id = unsafe { bindings::acpi_match_device(table.as_ptr(), dev.as_raw()) };
+
+            if raw_id.is_null() {
+                None
+            } else {
+                // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
+                // does not add additional invariants, so it's safe to transmute.
+                let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
+
+                Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceId>::index(id)))
+            }
+        }
+    }
+
     /// The [`of::IdTable`] of the corresponding driver.
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>>;
 
@@ -180,6 +214,11 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
     /// If this returns `None`, it means that there is no match in any of the ID tables directly
     /// associated with a [`device::Device`].
     fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+        let id = Self::acpi_id_info(dev);
+        if id.is_some() {
+            return id;
+        }
+
         let id = Self::of_id_info(dev);
         if id.is_some() {
             return id;
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 5b21fa517e55..5923d29a0511 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -5,7 +5,7 @@
 //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
 
 use crate::{
-    bindings, container_of, device, driver,
+    acpi, bindings, container_of, device, driver,
     error::{to_result, Result},
     of,
     prelude::*,
@@ -94,6 +94,10 @@ impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
         T::OF_ID_TABLE
     }
+
+    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
+        None
+    }
 }
 
 /// Declares a kernel module that exposes a single platform driver.
-- 
2.43.0


