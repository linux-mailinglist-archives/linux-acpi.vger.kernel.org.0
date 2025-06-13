Return-Path: <linux-acpi+bounces-14323-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C83AD8D86
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793463ADBC9
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 13:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22221AA1D8;
	Fri, 13 Jun 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtLf8G8H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71241A3155;
	Fri, 13 Jun 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822307; cv=none; b=Ilm/qHgQ83qWnA3SUWNuFMNABsjnPRoVp879U4gwVkiJY5z/3SXCvo/u9DTP+bXTPRHmWCpL6IISGfY4bRLerqtV0VEOOADyyxYB2y1Q+K1gSfpf/PuXSn7cK8SSHYouuktWf6+9tT5/ybKlwrS7K0pzrcrKgBCOEZgPLSkrPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822307; c=relaxed/simple;
	bh=1Hy3ujJXBqxV9lfXBO++FN2/fZmpMCZpJfkWT5aJ4iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mq6MJV7h8jHvpCJITHYfiwMuGfxpxUyDfSAmFq6dpGl5x+aKDAsN4IKNT+rDTV+3wjagnCh24vZiBpiA6qdWlu9m4iNKQhgsm3kRYk8/ZiawVrAL0EMqRszQ6OzYaK6Is7h5fWHpmztUeJSLhBL2PycWb/E0zbk/ouLwW/XV8jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtLf8G8H; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a54700a463so1471816f8f.1;
        Fri, 13 Jun 2025 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749822304; x=1750427104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7KlnwZB+CxVWmAEV673+n7G11D71TLYbf9q51R/jMw=;
        b=TtLf8G8H93S0R19lPo51vLv23ecS9k9HLiG5fRfu7hZ9ODrUqS7IfI17rH8oiuGXS9
         pRMry3wXAhMwpWMF4WlFSGjFXh4rxhBptuf3BdZXZNhZQ8UtBppv2yQhB1kaR/2O+2Rp
         RjAN5r1aJBLMoc9k5E9o11W6KNJfw4J9uKYo09zjz+Cac9KPhMUy9a4T4vA8vDgoc4YD
         veTK8VLD26cSj3PUj2rgF4qjZDRg/Qw1XF/rRpgBqFTVW5ch3jfRbEuyFFwNxV3a0Vh9
         YFp/TpU/l2zvGA56teePduwujP+LjoRyMELmdO1RrslygP9eXeO1TXGnWe4C667Sw9Du
         U35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749822304; x=1750427104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f7KlnwZB+CxVWmAEV673+n7G11D71TLYbf9q51R/jMw=;
        b=S+3NsdqO1pxNmB0p52+T0RQvc+GY9PE7d15TQpvS1HjwB2DCfEt+I/NnOzLKPqQ32u
         Jl9IPHS164/dgINbgvdYCWzJUFis5jghNnAaIIbK/5UJVNISDWlY2L/7Axcbqi+6s2G9
         XZoWC3Zxp5zXD8TqggT8l9RjrhmUCrWKrm1dvINOpa5Kt2DjDsp5dk2UPdLrjuRqlOBO
         ereUAOFh4id8yDhYaMDi9KJtbq0QTTmWJbsn9+Fk5/DXCQ46KJzQ6Hw5cEClLgc2afDT
         dGNZZqL3czZCrTgX4oxz5JYWrrFx4OnwCm2D+HVoi1j434omOi+FHoAoKMdvaqd/YpYm
         +HGA==
X-Forwarded-Encrypted: i=1; AJvYcCUa7l8XtW+tOXjyKSipzyYrQmcEknHIYepHk3xQpXfIZpSJg9dQ+n86mnmBa0l86ImVWqVnWEmJjIVI73cNwGo=@vger.kernel.org, AJvYcCV2ZNiB1Dx/pQbVpdiFf/11dd5oxalCwiwMq5ZgrDYpDr07oJDC3b28JTLNMLBmUrqoqTPromjK4F9Q2Td8@vger.kernel.org, AJvYcCV58KiDiVQAqLmq11uqz3DBLbXzGz+VMKCUP9m2SqIaL91hhQ38el3dKzB31GrIn0xpSVa+1uwu52+c@vger.kernel.org
X-Gm-Message-State: AOJu0Yxty8eWnOabCLD9m2f7n3dpiPHAtC9fob8JH0oLOjkDqO+pg0ns
	8E36Efxc1GvvZw6omsi6HS/upKzc61+7ygylvht8j9OCjauEKzOt8CX3
X-Gm-Gg: ASbGncshRpMxe910ljlkQi2drDF9eaptxHNLiD5WWiSyTWIwVWHiZZL0CR/4edXaxo+
	oMco4YgREuSa0lM+Hjf3KYM4kbkMgYSip0uSKzo32/ySOWK1Z0SrwgQxDmJRggihYVoDaPfygD1
	tR2AaA0YhpgfK7FKjrp0yq3a5AAuIszcz8kWqjHaRE3s0guoG4FHV5maUTtvZ3m5JueQHXX9o4r
	31G/8GE9Vqv+f4UTH+CgsYMUrjRryjakLYz/gAqHk1ztLZuJofRsOPUB/0kqvHdUQNR3l0Q5YiF
	otVBq2xu4vtQ63ozw5rSaM4zgPwjc+k0BKGW5q68PMljxMc1/no/gFoKhdheFeCRo0UdH7nyOJ7
	e7JToA4uqNtU00r9m27YiEnWLZUA84Cdh/Xke
X-Google-Smtp-Source: AGHT+IEWNniUs4P1E63VohfXQE6EU3JoQMNOoUU+QZyzKBx9d/Dwe+o27BZFGaemVFzQxWfkceM/fg==
X-Received: by 2002:a05:6000:40c9:b0:3a5:1220:36d4 with SMTP id ffacd0b85a97d-3a56d83462bmr1058582f8f.22.1749822303897;
        Fri, 13 Jun 2025 06:45:03 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e232e0asm51752975e9.14.2025.06.13.06.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 06:45:03 -0700 (PDT)
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
Subject: [PATCH v6 3/6] rust: driver: Add ACPI id table support to Adapter trait
Date: Fri, 13 Jun 2025 14:43:01 +0100
Message-ID: <20250613134301.1231229-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
References: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
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


