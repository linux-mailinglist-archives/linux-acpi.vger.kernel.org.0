Return-Path: <linux-acpi+bounces-14484-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31275AE1EEC
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 17:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB3816483D
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1E22D191E;
	Fri, 20 Jun 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1F010FI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84DA19A297;
	Fri, 20 Jun 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434080; cv=none; b=kv2SZ3i7Z2jW1wfvA2Df2UOYsS0uA3JjQ7dNyyHGATeylcA1C1hpNyYqJHRndxp3CSK22LeVRFKItCrrlhrHEJ0wspssFQncrxM3iA6qt6nZxpeC5RqGZhC+AVX4mUXE/+k5egzbBMZXO9HG31X95U71Ez1/bS5crNzH4snS7pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434080; c=relaxed/simple;
	bh=1Hy3ujJXBqxV9lfXBO++FN2/fZmpMCZpJfkWT5aJ4iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5z86OiNtSSzLpBsKXNofl3rhDUWAn+1p5/iJ38uCQDyoHYdXjej8qd8NwDBDX56NEMT7On8mj6oJoAXLqL2FtwxYdQ3c6sFeg2AckTAA67Xq9xFnxQcFi+NviXNepwl6EFfr/V+R6xQFDY2mCPsJOQCht2mpgZ/i3CvHRWWnMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1F010FI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a54700a463so1173812f8f.1;
        Fri, 20 Jun 2025 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750434077; x=1751038877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7KlnwZB+CxVWmAEV673+n7G11D71TLYbf9q51R/jMw=;
        b=b1F010FIpU/hLuKZP/4+afeZhU/wKNN4zYGiBBhgEbDtmFxsk1MLAxDbrJt0cq2Thv
         7sowAnpLtvcDWAZnjJjE747BvJXyjmJ6pcaSAcEtHEvUxU1uXUDfrCvIuvo5HC/yRzwF
         UW6ejK5yKP7EzLIu85zMSQ70Fmai6EvPji93kwz0Rd0T0huKvDK83PfuRyDVLjRAe1fT
         8OpxQvsHEBFTf1KYDLrTrm72twC0wYpw4bCV8mO4s2hrVN4MJTwK4K1ZL9w3gIEo581M
         Ak48XTHjrnLCjoYijPty51JoykEIddUztJAfwIEyfpfMmYVatHR9HP7k+LXGStrbj/hZ
         RhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434077; x=1751038877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f7KlnwZB+CxVWmAEV673+n7G11D71TLYbf9q51R/jMw=;
        b=Hh/5v8ZpbFNxKbmkFS9WwL6PP6IJ0EbV+GO0bNwiW3KMu3FscYTMBJHVL5wan/8ejF
         xJ1qyuYEiZ1oychNDlB9d6ca8K3OZUxuHbFgkRXEZW/+xwXs3SSmAPQxIcW/UKNBqvvD
         ZDxvalny+FsPW0ZOqwq+poB+Se8Taz8ASigp/QM2FNo4K3IHhGqHMOopTAX01AoTRQwT
         QMvfcrR53SVTlFsXEurc+gN/gLC2FJNqqSl5nOCHjuvoraaHqLQIz6Ok9qnMBXQMnfyI
         QtZqCFvp4izdihsJjASuPCjemNlMkLnRbxB2amosfeSMXxp0C/1U1/sB0MHcbCsdeqn4
         pbog==
X-Forwarded-Encrypted: i=1; AJvYcCUCh3Rxf+mz7yzs/o+2NByisqjwhA8zEWyUknVYiLbBhJC6dcPxGIijjQVVFT6UsvWIU4dL+xo9xEix@vger.kernel.org, AJvYcCUHL9GUSUJuac5OP/6gFtUIkYjWRgiv0WPWcqZfNKsjp9FTNOSlrElNAo7/yyBhLBwAe1y0q1hRlYwmjd0q@vger.kernel.org, AJvYcCUpe/nnymwZeibJlrbgbI5uPgF4zqSDFRIYxIk9dfxUV2O/G4Dj7ExDlfcLM3wMwa982MRjWCTRYgsXng==@vger.kernel.org, AJvYcCX6TEeITeG4rA7FhMLiCzrH3GT8hdgK4EQ9KS09yRGRTwJ1/B3Hi5bTXGLQ3yK7yGt656Wwmf5QS1wZDOw2zVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNh7Y0a4t/LDeUPzQd5xC1OYht2ohMgJ2yF/6YlUr1vOTrG+R+
	I3mVNVBDg5h3d+c8tCvYP6w1e/fVMgPt7YACVVc0uTWh4u+r2bY+s9/C+0xrLaIhBfk=
X-Gm-Gg: ASbGnctAFLR2YA/VwVCgvzpSKhlzpFha6OopfYZMUf4tY5+fnKw9TFR6b7cY98cqOOn
	93lpDxXFIZAPXf5Kl3IvgbwpaCZ8m82XAD9Adw89OaJoSGIPOCEwXNNE/pXqBE+h7vQlcpzOuvW
	GIUVxENGc/EKXSo2XYJXGfHU5NjU9N9AGPOR9P70ZZcj2i7/29j+xdzZS2L3Iv91ocJkAxAnVDF
	iAcHGAEH5+5kaOXNLP1DYZzWV6oUpYSc2UjBRzSTFco/mVIoelsmUYeT1qt6+7hcMEm1O8e97ZB
	ztWTWIZ8ZFSXVvDjZZxJhvKIokGkrSq/AxVKF+G7oQhDONxnQUH+YZf9n2qb2ma6VNTaeiDeEq9
	RyON+xEPOw5oQJMeBj8ERgxEjeH+l8XB2IG4z
X-Google-Smtp-Source: AGHT+IHOv7jEZj3mRK2FKbLya5sasuGQ2QY4nLc12MK00uIo4X2fqCr1Bwt8tjCkiXqrV6BFEuewOg==
X-Received: by 2002:a05:6000:460e:b0:3a5:8601:613b with SMTP id ffacd0b85a97d-3a6d27e1793mr2283088f8f.20.1750434076927;
        Fri, 20 Jun 2025 08:41:16 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f104bbsm2413391f8f.4.2025.06.20.08.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:41:16 -0700 (PDT)
Sender: Igor Korotin <igorkor.3vium@gmail.com>
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Alex Hung <alex.hung@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Remo Senekowitsch <remo@buenzli.dev>,
	Tamir Duberstein <tamird@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Len Brown <lenb@kernel.org>,
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH v8 6/9] rust: driver: Add ACPI id table support to Adapter trait
Date: Fri, 20 Jun 2025 16:39:13 +0100
Message-ID: <20250620153914.295679-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
References: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
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


