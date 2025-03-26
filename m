Return-Path: <linux-acpi+bounces-12443-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BD8A71CD1
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 18:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EAC172A5A
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E984C1F91F3;
	Wed, 26 Mar 2025 17:15:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943881F892D;
	Wed, 26 Mar 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009303; cv=none; b=oN4+cNY924lp9OcTq574Jg2ns64IkmmgUBDxFDJoulsGLapZ08QEkPOxJvartcxqQi5501RzgdUNt2iAEpb5wIJUQF/fpr/3zcIjySLF5jQVA9+UpXX5mHyRKynMC9S1ph1jH1PBITwmjJRTzW9mtXFwQ3LVTNtcEQxjqwsdhgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009303; c=relaxed/simple;
	bh=p41HMt0OF9U47gVvXP5P+GHZwTOVB4E6ivu+PU66GvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rml4xp2+uicfe9z5EXyVJwr3yLTHlIrCHT7IWXPirHbpepW3xywNuc4DQS9Ss7OUSK2Bq2CMjY0MCpPSKA6lwtKbD8iykC9vJTpxakfUiM08inyC1GZKXreYO6hDf06snjY4ED+cHwGVWnKtfCBkHOzTRDqxtCFzU9FsvUgM34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZND1R5yXbz9sq9;
	Wed, 26 Mar 2025 18:14:51 +0100 (CET)
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
Subject: [PATCH 03/10] device property: Add fwnode_property_read_int_array()
Date: Wed, 26 Mar 2025 18:13:42 +0100
Message-ID: <20250326171411.590681-4-remo@buenzli.dev>
In-Reply-To: <20250326171411.590681-1-remo@buenzli.dev>
References: <20250326171411.590681-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rust bindings for reading device properties has a single
implementation supporting differing sizes of integers. The fwnode C API
already has a similar interface, but it is not exposed with the
fwnode_property_ API. Add the fwnode_property_read_int_array() wrapper.

Co-developed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
---
 drivers/base/property.c  | 9 +++++----
 include/linux/property.h | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c1392743d..64d5b7055 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -292,10 +292,10 @@ int device_property_match_string(const struct device *dev, const char *propname,
 }
 EXPORT_SYMBOL_GPL(device_property_match_string);
 
-static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
-					  const char *propname,
-					  unsigned int elem_size, void *val,
-					  size_t nval)
+int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
+				   const char *propname,
+				   unsigned int elem_size, void *val,
+				   size_t nval)
 {
 	int ret;
 
@@ -310,6 +310,7 @@ static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
 	return fwnode_call_int_op(fwnode->secondary, property_read_int_array, propname,
 				  elem_size, val, nval);
 }
+EXPORT_SYMBOL_GPL(fwnode_property_read_int_array);
 
 /**
  * fwnode_property_read_u8_array - return a u8 array property of firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index e214ecd24..441a1ad76 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -57,6 +57,8 @@ bool fwnode_property_present(const struct fwnode_handle *fwnode,
 			     const char *propname);
 bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
 			     const char *propname);
+int fwnode_property_read_int_array(const struct fwnode_handle *fwnode, const char *propname,
+				   unsigned int elem_size, void *val, size_t nval);
 int fwnode_property_read_u8_array(const struct fwnode_handle *fwnode,
 				  const char *propname, u8 *val,
 				  size_t nval);
-- 
2.49.0


