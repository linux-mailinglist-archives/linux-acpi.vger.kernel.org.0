Return-Path: <linux-acpi+bounces-14285-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93921AD5D74
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 19:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4486F174527
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5BE229B38;
	Wed, 11 Jun 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSQGRtlV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACEA1CF7AF;
	Wed, 11 Jun 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664255; cv=none; b=Q4tXuJOs1qzhvKKRDs0uzG+5tznrhgu0CZNGaRCukKSwpvUtFc55FB2r/fjC5456na1rAygT6OJydI/OyDRJ0edGP9MnJ9yagATsgZnuOQfBJuGRcWVnQ/gRj7qZfSMiErMAHzxkq51aCjBLfU+5jv0CXA02tGrRl6LNCLKfDaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664255; c=relaxed/simple;
	bh=1Hy3ujJXBqxV9lfXBO++FN2/fZmpMCZpJfkWT5aJ4iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6ZsIuRgmdAVHbzeqJt7ZsRf1aP+v7LPMuLhHH0bAMSBng83+ZOJuduNHtxeIChBu6pbkSYSqedzgnetJ0cq+pSnqW68jQ34TWYcpMLf2w9Yaj5a/78jD6uLxhf45918RREOTKsvcVXM0QGfPEKUB+efW2ujrvzkWIChTs/HP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSQGRtlV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so130184f8f.3;
        Wed, 11 Jun 2025 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749664251; x=1750269051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7KlnwZB+CxVWmAEV673+n7G11D71TLYbf9q51R/jMw=;
        b=aSQGRtlVp15y590zOGhLrOTa9AG1LutadaePKtdJMJ3OCCPVGhraosTXwIHpSOvKFo
         2g/LhyLJOJ0WFW7X7h60X/0AI7g/GFry6EaVWIRwHnPmZzuxSH96GYhWU1capO+Nyn3R
         SKtcyyaS3L4+KEsYuxyNkVoi+FXcgRDlD3YfKI3YoK1lwhHGUSyu5rvFBAz0t2ZubW7d
         K7MfXWC+3A7wx67EIOfg44K8oWn6yPdfvckoUueAYLTk+JiLLgRaWINq6R2JWNUXLFSW
         c1dQECkXMGL8nILQOmr4OD8HdTeDiMSO+i6L1lvw1gAtuvao4VPPJlxPwLuJ/gHhqDOy
         2gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749664252; x=1750269052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f7KlnwZB+CxVWmAEV673+n7G11D71TLYbf9q51R/jMw=;
        b=LvQBBw5HmLfZUXEPmZfuN40HC4T7ifneUfcJYn4+iEYOxa8fIp8gNOINXSCzSwLRh8
         c3DBtiHxmPESGvnGcJm1kxdOfhqKbRbypFD68sYOgs+IYPqbLFStnbZA855mcQy15ngX
         dYk4VlCT3PDyKBvDZUBmUfYL8sjTJ+UzT3hlHdVhRUVR6pIWXABKRfSE+KCV4R6cZkD7
         pIVaXtzc2Lb3AzBpWKhNHghvcLrcrIHo6AGw6kOmmohVjP87MczV4eEf67V6DDv3tMWv
         V6MbFnXg2hKuwGRIAEuqgInqBgs6acfmUSENbNkfCa0GxklaisjcN34oG7UPgisAOHzv
         uiOA==
X-Forwarded-Encrypted: i=1; AJvYcCUqw5H93k+j3WTrtkX/Pc1rg60rJ/2P0gackKOfNbOAccVZuwk9AS3AbO4PGV6fcotX66ydfBZdxT3QKycTcuQ=@vger.kernel.org, AJvYcCW9HNnAbXyywX/zBVQHHepcqlYhnkE+S+Xo5tTZxU4CBSfKeS/RPqS0JMrEuNTgXNu+g2L3a6qZ1XYj@vger.kernel.org, AJvYcCXbGgVW9l07Ps03TUicfSx99/yyu5LrsqlDRwmMZQKWA0BX2f8kOfSbdd49G4CJF1gIBldisW/hXDou8ECY@vger.kernel.org
X-Gm-Message-State: AOJu0YypXQODh5IweWSANOeMflCwweb3jaRo7HYo0fI4uRZsmcDinTIw
	iRDh5Pf9cU38goY8TllTpwo/vFrB+KPJ4wgBAS/5yRzIZvOHcY0WAqze
X-Gm-Gg: ASbGncvWPNrw4zoedQO63RiQ5yWOIrNWv4yfEK4OpMtqscr+S3A5Jar2LMRYuWiZx88
	R90FWFSPyQVBuxkTZaUUDWUVIf99/GBpoArhF+/Pu7o7Einag5rbtHR9htsJeb4xzBuJgVaqXv8
	q1510lgSAum24NwaKMbvAEiwDdYJ85KC1BBlon1x+eOLdgmsY5sq0c4Zg48rLN1ab8JjRRpJfcf
	iERHsUZNGLPidjgVxmY1WYCXfISuDh3OTCZthbZer6RY46zZRBsnkseUw/ItiyjT6iHpd0IQxgC
	OMSxf1D+AvvoQ39nxO1WpoJNF/kIaCNu29JVVufrMhCzBV4uO0q6pUZy3OxA4Oc7q1IYEqwAYq5
	+aRJCnG6aXys+OHYjShdYqrOwXElAt21KE47X
X-Google-Smtp-Source: AGHT+IEPDg33JpYVf5j0B125l1p0dMB8jKVW3wBukaaW8ms6rL5iY2qDPIvs/t5k1jjA+Pax7owafg==
X-Received: by 2002:a05:6000:2283:b0:3a5:2e9c:edb with SMTP id ffacd0b85a97d-3a558a1f6acmr3423559f8f.47.1749664251298;
        Wed, 11 Jun 2025 10:50:51 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532461211sm15744491f8f.86.2025.06.11.10.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 10:50:50 -0700 (PDT)
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
Subject: [PATCH v5 3/6] rust: driver: Add ACPI id table support to Adapter trait
Date: Wed, 11 Jun 2025 18:48:48 +0100
Message-ID: <20250611174848.802947-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611174034.801460-1-igor.korotin.linux@gmail.com>
References: <20250611174034.801460-1-igor.korotin.linux@gmail.com>
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


