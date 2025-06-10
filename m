Return-Path: <linux-acpi+bounces-14267-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A10AD3C4C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 17:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A1A3AFC0D
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8262367DE;
	Tue, 10 Jun 2025 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqKmKKXJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2B1A38E1;
	Tue, 10 Jun 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567924; cv=none; b=dmUomc65Jvmf2Z9Caa2XAKAbZEtU2I5uh5jxwSlrBke1cdfbuFDbMnIMWtuXuwieCbeWwy77lrT0Q3RSRj3k+jDvATS35nIG0Id/I9oc2FOy7cE2tWewvtKSG6mwLgInylb4oIrL8GefahH+M6yO87oMzvcGLAXxfoChVJO3hoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567924; c=relaxed/simple;
	bh=flqCuN1LFxKMYrK52rWr1/uWTHaSEMwBTPmhJUrxg+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+663DZxwo2yJoi8fAT3RRX9mSDCK50OOmsSziiWEeEBXgyo0hu6020dwBga1a0E2GgBS8Rm6NvdGv/twkcPT2JFZfqKr3oz+MtWq7WcH+pDR5O+GWtcMvRCw0HKBisTQRGDHIz+mMMEyFKZ1KMSGErTVzYEv7HM1uJFPmEaEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqKmKKXJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cf214200so51901455e9.1;
        Tue, 10 Jun 2025 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749567921; x=1750172721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYST0Wq5UCvFFk+G2xi/lkliKbwC7IeQBkNPHcpoKFQ=;
        b=cqKmKKXJm3+5paYuvHDxn7ZaFdxQDmVH5IvbTuiP0eR8jotIZNageiwovF46+gHUCM
         r67uTWK/zj4gALUpZ14GRc4mKMnDNpPSISX8OTBcp3C6fX4Y6xPUvvEUg8w23Rc4lUmz
         VucLEOK3JELYJgdvH3dC3DoHtj3WlNeBGZ0BrYsBMqKc+njsubNuJsL+GnJb0hZRtfBk
         pDX6x8V8Vxaj3bhE3lR6DUs2rp8TE9c4umpRu4dT4zBu64R6MkjrtxdCx9lAr9Uy3byJ
         XfxLr0vftHZndsD6RRigQnBHirWxqVfR6fbKu97Xckf+yecLIepu0/n20/dX2lOAYWO7
         zbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567921; x=1750172721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DYST0Wq5UCvFFk+G2xi/lkliKbwC7IeQBkNPHcpoKFQ=;
        b=ilniaFnGORUMpIAZhBhkQTwU/5bcQMTjC6q/g9vMCdn0TMeR0Xorm2LuH2ZpVYlAeD
         pTXWB3vopxBn8Qg4f59LRgIgm75fgcGFyhNw+shGGjjzKRb6+etUu+77uwIPVVdi8RKu
         1iO0HCTH9xwnUAOpwva0gHgf+S8FBkEkemWpaMdNo17QRouVp2zhJvaBzrgVTFULR7o3
         cVTkUdxQn79Nt8ZMJXuEop6tEgpqBdq3tpBM6fjjxUz1wei+G0Mqq2kTlGC5O29bpObg
         1F5khIKpWt92mX4xDx15k0tqM6jlPsX6hSo/nNJ0Pak+wiJ+xtDgsYXC2NFPYA4qc4QZ
         TC+w==
X-Forwarded-Encrypted: i=1; AJvYcCUWef56ZOitJnBZcDPTurltS/PlWEw5+yAxqc9cLKyRLTidvXmT/UxVtqAjU3f0MX5czsT5+5Zvo5T2kVIvfE0=@vger.kernel.org, AJvYcCVVXQVsmEDSbHlqLFPvo+c9FFUoBVqL3edmm7x2bBMlo92JDPGKC0gwaK3W6idtwwnZw9Z+FEdaOFwW@vger.kernel.org, AJvYcCWfLED02hi60y9STWgfHBB5TMWSG2cWiM7c5fF03Z4yPRzWFdgvmTP8yZ3HMud3lfpwQA2X9qjp5BcykGsc@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTKTtwARhgYkhABFV8tgFQ0mbh88tqFhBg3dhj7ByGqrIQbwk
	UD/39iWZ0al2fbpRNehd9iVfaEF0P8Ew/UAyMNs9qguCzaqMwtUS98m2IP00zT6CoJ8=
X-Gm-Gg: ASbGncsuNjFwH8aUuL1hEOQ6J0f5o281/1J++kwQssFPNNAR4wYKjnP8mx8CkTME2tG
	NJODctqvZ609d7ZQqEQtSzC+NwqL7dAjBmTiwjMlJqHj+orGUVS6thEI9QZZxA/e4TDEhOI3oSs
	zXIEvYuwBX8d9FZDhagGvt/SaEMBwm1l8oqpvZvnXLAgjOkaBqsVUAaFofA7yI8DFTNoQSVIXxT
	7ZD0K5AnPjiBLGqbJXs3ZhDt8RbMaveXpM5Cj0G5iIx5zGhyU8Dg1hELdwr2JveY06DeD1fGuAo
	hLqwjCfvj20kDKP7VV+pkviYHyffRMcJPU1zApvSIr0IU110zSr9X8jXDYjVI5PB7ZfmPkWtmKv
	pnTZxlJTkxJUY1qVs+l2u3HWnCruZmWRdEeKR
X-Google-Smtp-Source: AGHT+IFN9u2t/Wp8LhDB0gA0/W33WOWPayonuzXz/G4wLLYTAVQ6KWIGAINYjOJ1X1qxPMzreZHj1w==
X-Received: by 2002:a05:6000:420f:b0:3a4:f6ed:767a with SMTP id ffacd0b85a97d-3a531abcca7mr15162775f8f.38.1749567920129;
        Tue, 10 Jun 2025 08:05:20 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532464f20sm12559408f8f.98.2025.06.10.08.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:05:19 -0700 (PDT)
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
Subject: [PATCH v4 2/5] rust: driver: Add ACPI id table support to Adapter trait
Date: Tue, 10 Jun 2025 16:03:12 +0100
Message-ID: <20250610150312.237649-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610145234.235005-1-igor.korotin.linux@gmail.com>
References: <20250610145234.235005-1-igor.korotin.linux@gmail.com>
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


