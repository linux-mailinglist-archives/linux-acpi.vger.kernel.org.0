Return-Path: <linux-acpi+bounces-19740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE89CD43EC
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 19:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65DF530139BC
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AA2306B05;
	Sun, 21 Dec 2025 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="dRWhkOVi";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="dacypMTh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B03054EC;
	Sun, 21 Dec 2025 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766341497; cv=none; b=NrMifPJNYoS3X/dklL5uvjItdnCTqc7tgd7VMHyRi2BRv6k2ifHtPk/l2wVkhh0aB0U9qdOoTu/T15monNGePIjg7RPg4Qq4aM0QvSNZu55QOvQAj9KLon+34+mSMI0vrKZb2K+tN8Dj8mq/l6CMqy2ESQjTw9lxdrbfWeoFoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766341497; c=relaxed/simple;
	bh=kmRPjQahAG5tcZJ52oMaww+i2Cz9UEX9U5JzqXyIrM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=th00gOYQQjaszPMwhyW/TcjuxxLWg5e/+mpWo+nc0RGvuI/CUgP+tuvJujan45qCVWyMCW3GHt40Uu1lpBJG6TWDBNKqv6vcozkg/qCsmp8yqu6ECB0c591fLOTcdx4RIc2+WoMjD2W6aUsls6FDMae5KO9er4HPLS5xLoA7U54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=dRWhkOVi; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=dacypMTh; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1766341464; bh=O9n5olvByOk66OI2JwAlHzR
	OWhgir85jJcDtWN3YL+0=; b=dRWhkOViuFPxyZIFdS12tHwLUKko2wpuOm1j3qg5vTqD7Xos+K
	uhXgaEn9m1MVRWgbCcemheBbJM7Niob8d6e1gXAx8acw294pF2PD5pbh5w5ODiSTYi38socsEKz
	2TZp3Spc6yiDIIWyfkq/oSVF4Ol5W4TR3lUZN2P9amOirWVDqfYLai8NuLHdW5J701Ryt80wMg8
	m2uzDuo9eL0kMsCuRli64suwEEo2tZ0eNZ3lMcvSwSp6PxvSWyRvRsOqwcT91reE12Mdm/hW04A
	iG930pgMVtYOmh20Qa/ixlNi0v0vVWafRsQoluThpBe40mI5BcmYxsPh19A8HbJxgQg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1766341464; bh=O9n5olvByOk66OI2JwAlHzR
	OWhgir85jJcDtWN3YL+0=; b=dacypMTh93BDBR3XkNJXx8ADsJUjMYc0HXIyvjJKXf4QjybJGx
	tqRbwXkSWHIiyf7+VVSIn+50pNfjedegalDg==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Gladyshev Ilya <foxido@foxido.dev>
Subject: [RFC PATCH 3/3] rust: sample driver for WMI demonstrations
Date: Sun, 21 Dec 2025 21:22:39 +0300
Message-ID: <905217b6dc4dda707e3596737b4ade9a210aa445.1766331321.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <cover.1766331321.git.foxido@foxido.dev>
References: <cover.1766331321.git.foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver is for RFC demonstration only. It will be removed before
real submission, however it's working and can be transformed into
sample driver
---
 drivers/platform/x86/Makefile        |  1 +
 drivers/platform/x86/redmi_wmi_rs.rs | 60 ++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 drivers/platform/x86/redmi_wmi_rs.rs

diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index d25762f7114f..3045e42618ef 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
 obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)	+= nvidia-wmi-ec-backlight.o
 obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
 obj-$(CONFIG_REDMI_WMI)			+= redmi-wmi.o
+obj-m					+= redmi_wmi_rs.o
 obj-$(CONFIG_GIGABYTE_WMI)		+= gigabyte-wmi.o
 
 # Acer
diff --git a/drivers/platform/x86/redmi_wmi_rs.rs b/drivers/platform/x86/redmi_wmi_rs.rs
new file mode 100644
index 000000000000..65300bad022d
--- /dev/null
+++ b/drivers/platform/x86/redmi_wmi_rs.rs
@@ -0,0 +1,60 @@
+//! This is SAMPLE DRIVER
+//! It doesn't aim into upstream and serves only demonstration purposes for
+//! RFC patchset
+
+use kernel::sync::atomic::{Atomic, Relaxed};
+
+use kernel::{
+    acpi::AcpiObject,
+    device, module_wmi_driver, pr_info,
+    prelude::*,
+    wmi::{self, Device, DeviceId, Driver},
+    wmi_device_table,
+};
+
+wmi_device_table!(
+    REDMI_TABLE,
+    MODULE_REDMI_TABLE,
+    <RedmiWMIDriver as Driver>::IdInfo,
+    [(DeviceId::new(b"46C93E13-EE9B-4262-8488-563BCA757FEF"), 12)]
+);
+
+struct RedmiWMIDriver {
+    probed_val: i32,
+    invokation_cnt: Atomic<i64>,
+}
+
+#[vtable]
+impl wmi::Driver for RedmiWMIDriver {
+    type IdInfo = i32;
+
+    const TABLE: &'static dyn kernel::device_id::IdTable<DeviceId, Self::IdInfo> = &REDMI_TABLE;
+
+    fn probe(
+        _: &Device<kernel::device::Core>,
+        id_info: &Self::IdInfo,
+    ) -> impl PinInit<Self, Error> {
+        pr_info!("Rust WMI Sample Driver probed with val {id_info}\n");
+
+        Ok(Self {
+            probed_val: *id_info,
+            invokation_cnt: Atomic::new(0),
+        })
+    }
+
+    fn notify(&self, _: &Device<device::Core>, _: &AcpiObject) {
+        pr_info!(
+            "Notified driver with probed_val: {}, invokation cnt: {}",
+            self.probed_val,
+            self.invokation_cnt.fetch_add(1, Relaxed)
+        );
+    }
+}
+
+module_wmi_driver!(
+    type: RedmiWMIDriver,
+    name: "redmi_wmi_sample",
+    authors: ["Gladyshev Ilya"],
+    description: "SAMPLE DRIVER for RFC demonstration only",
+    license: "GPL v2",
+);
-- 
2.51.1.dirty


