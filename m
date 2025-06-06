Return-Path: <linux-acpi+bounces-14204-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B37AD0730
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 19:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4615C3AB793
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843A4289E0B;
	Fri,  6 Jun 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNg7bG3S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C031DCB09;
	Fri,  6 Jun 2025 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229705; cv=none; b=LcBQOxE/X+GfSM0gcLc9JGylW8VGFjSHY3WpeKICL9NSmWhs1LQTZWA27qxpmLHocSYX1fnrAwf8L4vXg9fWOsjDBnbD/QU0QkbSOGfazEtTl7iR2gn0XXSP30vybnUXpdr67k6PDL9y7p7QOLC+u1o21P+rc9F6kjPkBtPmYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229705; c=relaxed/simple;
	bh=0n6dKNaXjAtpClMuqrF6yIV1Y2xk3819lpUQzbOxuqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMR2JcdsixDUvgumKF2HxQyS0jiSK+Ef3PTPKnrDAnIr6bYbJiRQoUiiyShOkcnN9N+pVBDOnhVkeBsekpAnU6sGxGnmibVFn3R83QxxkOqW4/vuSZK8P9N4KMMdj31BgIRbbkXQCCqnL1fkdmzGZVX2aktGM9LAJHWaQi8+hEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNg7bG3S; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4f379662cso1996863f8f.0;
        Fri, 06 Jun 2025 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749229702; x=1749834502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRYCAFkO2zcpC+e8ef4KzR9UwAmJFdk1MxOth/JzNs4=;
        b=MNg7bG3SThDWAN5m6WlH8UjtUGPIhKUnCLvrq+ypxlFz/l2V4XRhIQ/NIKZHp/lB7y
         xr0Q7VnecrCy3o2GXEAk4Z8bO+FHJ6Z4NsoUF508HFnvBOXqbd3qEOIDJ0IH/Z7+CYt2
         QMWPaettJV+5+gmv7bno/IaC2m0B+WYbL9YLn+s+F7cilEBr3bd9deR6GGB5ilnvsPJ7
         mfaQ0Ie3LUrA/inGHmBCv88rGJkkW5f8zn76r2wN8Vtgi99hHxsO0AvhRjbCSHN3ZHko
         wKhOj+BDCH4Zr+2aTj9ydP2Melk5a5K+hdW6cD23bbHvB0UF5o/ivIS5UGagPP/0yCXq
         xVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749229702; x=1749834502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GRYCAFkO2zcpC+e8ef4KzR9UwAmJFdk1MxOth/JzNs4=;
        b=LJCXMG23Bv2cSlhMWnYSmf973KdwcT61ZgCbPVfOZEzhlw3COgwsEzVWZ4TyCOFEJP
         rLDlAhRXl+qJiUQ85ZhN4d2g6RQOpmqK0GEKLpqQ8E/TLJmKeCi421CZY4l0sUZqv2m0
         ckVn4QmZLc7v7hAIpA3F3UCPGYluG4jYYMpJAHna4U8pmXj859xrmz1OKDKoEVOCNtYR
         AMkvOv2sM7mk5Ox2aMmwSO+3jxnkpKRl+5bxgEHNg4Tu8VJKk9pQvR31CJ+0+nA4whIv
         yCDuxZMLKxmgtE1d62xlbThI00W7WLuWK7JMwLd+FsqwHoap2VFK76MG2tj33ngkVK5b
         37sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSiHPQw/dJYS9RkPhzNRZFMAmkSC1OW1KnjV7pDEqTXE9CA1p+Mk0iL18KArJtsmvfGJYEWTgFv7qIn6FdqOw=@vger.kernel.org, AJvYcCW5XT+9ANBO9DCrp/MONXgXjgPO5REhHSlKH5nfbc+s2vZeyPDAmVnjGKR/K+aRyxT9kgEP7wuJRR8zoPY1@vger.kernel.org, AJvYcCXdjZpLBaDQRAhOp3QbBrBRf8skMoaK3tXbmzSnZI5wDt8IxC8EjrnBkXJoTDt075AymKywqsDK+EGN@vger.kernel.org
X-Gm-Message-State: AOJu0YyKXiTX5LQNfCGlMRdJgN01TYen1YswZccC4Nb+U8FjwucyzFnM
	/fKV1B/UFwKUHRu73czDuCdfBw+Fe5CN6qvwopFgeROxq6RJmafksSt0
X-Gm-Gg: ASbGncsFs/1d+Lr6gJ/1Ac4g0bwjseFE28RISBDEwpZN3WNK1pB/FAqvGY3YD47VIhl
	LwllMfsVU7YEiPpc1no5+pRsz1lPQ7Sr3PpL05zUhmLgEoqPPVFMAvV4XQsqHcBbkNHkJ4Vs+pQ
	GtolBBVBK+D6k7F3vRpgLXsA889CfamTGp4IcaHJMH3eWfO1utTn5MUfQ64mVw7JrwoXOlF/izx
	DI7+Bp80WGTBWwQS9iKgKxYng8Wc2BPMZW1Dn8kE+oBjqxOx9dp4y9gWs1QB2PrT1p/RbtoQzVj
	eN85N/3w2Rdep5Fuwdxp40pitQFwpIv95GcQEpfYIc5OnBxJR0gDC2mrVySmDcMMurgR6gxSyDH
	Q0YxJ9lwsqR2KK6s2PmuPjn8MrOesRxtNTA==
X-Google-Smtp-Source: AGHT+IEYJB/T6htKMIfvolJfKo2jkiliEKcvmU8R2tHOeMj6rr+QbYiU7LHeXV+HkIofpKDb5tBpOg==
X-Received: by 2002:a05:6000:144b:b0:3a4:e706:52f5 with SMTP id ffacd0b85a97d-3a531ca6afemr3843032f8f.13.1749229701638;
        Fri, 06 Jun 2025 10:08:21 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.. ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244ee34sm2433606f8f.72.2025.06.06.10.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 10:08:20 -0700 (PDT)
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
Subject: [PATCH v3 2/4] rust: driver: Add ACPI id table support to Adapter trait
Date: Fri,  6 Jun 2025 18:08:17 +0100
Message-ID: <20250606170817.3881748-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
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
 rust/kernel/driver.rs           | 39 ++++++++++++++++++++++++++++++++-
 rust/kernel/platform.rs         |  6 ++++-
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ab37e1d35c70..002d84f06b42 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -6,6 +6,7 @@
  * Sorted alphabetically.
  */
 
+#include <linux/acpi.h>
 #include <kunit/test.h>
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index ec9166cedfa7..638f1d270af8 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -6,7 +6,7 @@
 //! register using the [`Registration`] class.
 
 use crate::error::{Error, Result};
-use crate::{device, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
+use crate::{acpi, device, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
 use core::pin::Pin;
 use pin_init::{pin_data, pinned_drop, PinInit};
 
@@ -141,6 +141,38 @@ pub trait Adapter {
     /// The type holding driver private data about each device id supported by the driver.
     type IdInfo: 'static;
 
+    /// The [`acpi::IdTable`] of the corresponding driver
+    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>>;
+
+    /// Returns the driver's private data from the matching entry in the [`acpi::IdTable`], if any.
+    ///
+    /// If this returns `None`, it means there is no match with an entry in the [`acpi::IdTable`].
+    #[cfg(CONFIG_ACPI)]
+    fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+        let table = Self::acpi_id_table()?;
+
+        // SAFETY:
+        // - `table` has static lifetime, hence it's valid for read,
+        // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
+        let raw_id = unsafe { bindings::acpi_match_device(table.as_ptr(), dev.as_raw()) };
+
+        if raw_id.is_null() {
+            None
+        } else {
+            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
+            // does not add additional invariants, so it's safe to transmute.
+            let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
+
+            Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceId>::index(id)))
+        }
+    }
+
+    #[cfg(not(CONFIG_ACPI))]
+    #[allow(missing_docs)]
+    fn acpi_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
+        None
+    }
+
     /// The [`of::IdTable`] of the corresponding driver.
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>>;
 
@@ -178,6 +210,11 @@ fn of_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
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
index 4917cb34e2fe..dd77934937d3 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -5,7 +5,7 @@
 //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
 
 use crate::{
-    bindings, device, driver,
+    acpi, bindings, device, driver,
     error::{to_result, Result},
     of,
     prelude::*,
@@ -95,6 +95,10 @@ impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
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


