Return-Path: <linux-acpi+bounces-12449-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A692BA71CDB
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 18:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3FC57A80CA
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 17:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377771FECB4;
	Wed, 26 Mar 2025 17:15:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4AA1F872C;
	Wed, 26 Mar 2025 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009323; cv=none; b=ainOMWoDTCg0v7+6PYSjXCgxIu8yIzkGTQFuEWdkCOIZWKesMyDqWeeoUIXpQDPmSW0X6bYRTH0nnLIXzJCEQb64tfopWrGLkfrX0MlGmLU5/Mf9X6ebytgevXbzsNCLxRpOyx6IO0fuwx4ixuLpnoOac6RZ+geFHf05NFlihNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009323; c=relaxed/simple;
	bh=GMrrzdfst3UrCx5Hw9DPHzzI0KYSCppNF/wVPqqk5rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLcNQkda8C7a7roh0gQArmEUP899stN1Og7KCENFQgoQ8fl7A9yY3ssibhfqkWwzfRGHUWW1a4dHSyTcVhg20ra7jE88HWLA+bzkBDZs3RR6kwGpxosOJ4a52Rxvhj78y+OMoRNmugb0VNOXHlPOWqN1vmG1tIC28dxd2yN9zzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZND1x5lL5z9sq9;
	Wed, 26 Mar 2025 18:15:17 +0100 (CET)
From: Remo Senekowitsch <remo@buenzli.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Rob Herring <robh@kernel.org>
Cc: Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Remo Senekowitsch <remo@buenzli.dev>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 10/10] samples: rust: platform: Add property read examples
Date: Wed, 26 Mar 2025 18:13:49 +0100
Message-ID: <20250326171411.590681-11-remo@buenzli.dev>
In-Reply-To: <20250326171411.590681-1-remo@buenzli.dev>
References: <20250326171411.590681-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZND1x5lL5z9sq9

Add some example usage of the device property read methods for
DT/ACPI/swnode properties.

Co-developed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
---
 drivers/of/unittest-data/tests-platform.dtsi |  3 ++
 samples/rust/rust_driver_platform.rs         | 56 +++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
index 4171f43cf..50a51f38a 100644
--- a/drivers/of/unittest-data/tests-platform.dtsi
+++ b/drivers/of/unittest-data/tests-platform.dtsi
@@ -37,6 +37,9 @@ dev@100 {
 			test-device@2 {
 				compatible = "test,rust-device";
 				reg = <0x2>;
+
+				test,u32-prop = <0xdeadbeef>;
+				test,i16-array = /bits/ 16 <1 2 (-3) (-4)>;
 			};
 		};
 
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 8120609e2..ed25a3781 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,7 +2,7 @@
 
 //! Rust Platform driver sample.
 
-use kernel::{c_str, of, platform, prelude::*};
+use kernel::{c_str, of, platform, prelude::*, str::CString};
 
 struct SampleDriver {
     pdev: platform::Device,
@@ -28,6 +28,60 @@ fn probe(pdev: &mut platform::Device, info: Option<&Self::IdInfo>) -> Result<Pin
             dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
         }
 
+        let dev = pdev.as_ref();
+        if let Ok(idx) = dev.property_match_string(c_str!("compatible"), c_str!("test,rust-device"))
+        {
+            dev_info!(pdev.as_ref(), "matched compatible string idx = {}\n", idx);
+        }
+
+        if let Ok(str) = dev
+            .property_read::<CString>(c_str!("compatible"))
+            .required()
+        {
+            dev_info!(pdev.as_ref(), "compatible string = {:?}\n", str);
+        }
+
+        let prop = dev
+            .property_read::<bool>(c_str!("test,bool-prop"))
+            .required()?;
+        dev_info!(dev, "bool prop is {}\n", prop);
+
+        if dev.property_present(c_str!("test,u32-prop")) {
+            dev_info!(dev, "'test,u32-prop' is present\n");
+        }
+
+        let prop = dev
+            .property_read::<u32>(c_str!("test,u32-optional-prop"))
+            .or(0x12);
+        dev_info!(
+            dev,
+            "'test,u32-optional-prop' is {:#x} (default = {:#x})\n",
+            prop,
+            0x12
+        );
+
+        // Missing property without a default will print an error
+        let _ = dev
+            .property_read::<u32>(c_str!("test,u32-required-prop"))
+            .required()?;
+
+        let prop: u32 = dev.property_read(c_str!("test,u32-prop")).required()?;
+        dev_info!(dev, "'test,u32-prop' is {:#x}\n", prop);
+
+        let prop: [i16; 4] = dev.property_read(c_str!("test,i16-array")).required()?;
+        dev_info!(dev, "'test,i16-array' is {:?}\n", prop);
+        dev_info!(
+            dev,
+            "'test,i16-array' length is {}\n",
+            dev.property_count_elem::<u16>(c_str!("test,i16-array"))
+                .unwrap()
+        );
+
+        let prop: KVec<i16> = dev
+            .property_read_array_vec(c_str!("test,i16-array"), 4)?
+            .required()?;
+        dev_info!(dev, "'test,i16-array' is KVec {:?}\n", prop);
+
         let drvdata = KBox::new(Self { pdev: pdev.clone() }, GFP_KERNEL)?;
 
         Ok(drvdata.into())
-- 
2.49.0


