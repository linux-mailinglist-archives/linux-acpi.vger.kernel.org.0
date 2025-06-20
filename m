Return-Path: <linux-acpi+bounces-14479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477A7AE1E52
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 17:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5E13ADC84
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0836428C5BA;
	Fri, 20 Jun 2025 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF8cYHf6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50183A14;
	Fri, 20 Jun 2025 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432633; cv=none; b=OMg4EHq7PPBOOIogIqJlnHKhfECLVTD8yP0IxV2oxGY+A+C2K1SjXcuMfN8zyhU1W47DxmrReQ1gmoHgPSHIqd0ipDaoEF5wkBMpxjdLo7M/C84imbLnJBcnfkNS02Ak2XNuV+o0+8JAezU05VUAcmp5+1YgHR7p4AVnTMAx+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432633; c=relaxed/simple;
	bh=fcDRVRsB7kTTxKbuSPIJvammikJeVCV2Sey5irOixwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghv0KNt7iEbRGFbyaCi+ZKSKZ+doP6YppLARMOnN2MlMqpI79cglQhItIF0wE00YpZOm4CXwj70FpJ1fAjEqH5zQJ5Bug+FlbnwqlZJSgABwrnnRtHf0T0SBkHkYaL165UGjerkkFL7Z4TwdchZ6+YJlu6jQdaxw9076MjaHlDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF8cYHf6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so22613685e9.1;
        Fri, 20 Jun 2025 08:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750432630; x=1751037430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9Z79uO0bQTG7SBiWvsssoDMq0Ao6no6bKJ2a4NfcKE=;
        b=kF8cYHf62bxcZr6i97MsG7gwmNPJ9T1ne3HsWKIKm8shgtGUsy+Ist0a+2L2hDUUxm
         O2C9JYakrgUZXYL6vvJsBaxo4n/MEjckn6YbLiwED4DIUMye2lyKhsNYvnpzKM+LwiP2
         3L6ElgWX6Dwv6yXL3hL1d7uM06qceuufxSBiLqpYtI51zI9h7LLWiWrws61dSmPfRLIM
         my/bX/YFWyRm6W4Sh0vrg0NrIhFvLh2mG0/5HE1IXi8VDuDx2vveG+KscbS9jJ8rwA+d
         4iaEUw8McUpMWn+ojk3wOU+8HoN/C2b/friyxHrlaem6M/74+aV+8c1OgT+Qf1wQNYBd
         hFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432630; x=1751037430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9Z79uO0bQTG7SBiWvsssoDMq0Ao6no6bKJ2a4NfcKE=;
        b=VRFQae9Mx0NpxnvXJnWZ2ePRdSBWxNnkDmk1YPJQKrYF2RoDG4/V/vF83dUC9w0+Ie
         NHhiE38vUY4LPCiQe41A0qhh/XcjVtA+aPi4Z6PH6C5w8jhmh28Kpa33HU/lBr2dP2Ip
         rKqU0jKJDkx3SP3iMlQpIq/p3/5XwpVCJUEhMrW2qMVsbGHivpAsyGkW5d341H6z98vn
         IWrOoeepHdJ1muuCjVJA5mTIC3cdZtFp5YIPDhDNzxWwsn13iAVFRcLB8KSEMMbM4NQP
         1KwTojkxfXGJjG3vcBVe7s7+vsVvGwZN/A6A8OlOiMOdFPYHtpeQHYQ69qUucbgo54SY
         dDvg==
X-Forwarded-Encrypted: i=1; AJvYcCWOxjW9U/+l478DEbxTCUOVYk0NsuxjTBhUdVxsjGzHIC8YNiQMw0AC/YhLzMZNS5n0j1R66mO1g7ebOg==@vger.kernel.org, AJvYcCWR+vEJ798LZkfSamDp0WeowNnqYnR57VsB6Yu7drlB4GvlqMJlFmbbE8XaxIXj0+YoQHJxVBUsttVnwWWX@vger.kernel.org, AJvYcCWyXKD/SlACaVfXXfVfWVl/XrKhOidu+jpXdnhyJEgPnwliIyRzMexzoH7RhlkjkLfS7Yi4Qu1igRrs@vger.kernel.org, AJvYcCX7iGae6ZyWM/QgmTMIVtzP7Ui3grc6sMAgtJ+Xp5rRiCV7Is0Ymj/UAzRjNic4ecdO1cS+qUFHv5R5YL3oLDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zRRbiqgU3vctI7koNW1LoSGU4IRHWkNrYfYiqS+K0UzU23ue
	uDdXQS1YC5T67DxxMyXkaQlARcyJcYBfpxJIY0/Zwuttl8LOy0J/yD/Takm96G8N3TU=
X-Gm-Gg: ASbGncs8sB7oA8xQ4cAA4xeIuT4W+kOPRI9ShUBbwJfZb+2uGEvaBiadE/X80lYOTz/
	PKWZc/zby1GTKCeVbIM0eL7Gq8pPetoXWDtJTyMQUOVMCzDpAx8bQUIQJhQm803LQW48XB6M/e5
	9yHVRi9Skn5XrkdAlA5QqRWEdquUvj2TLC5wPOPU3amYcfFo/KnLNZ6DhoWO9pALV73drag0KA1
	ZOPRF4eXFyi0AUuH76J0SQ1OXzmlY5SGHRrJwZqcv7TWBOAjTwi5vfQ9JAJOiDp07T8C7JDl6p0
	Gtt4vzMlDFUjM9DgR8yfxlvFz29gfyiwyt1VPAoQHy6zIpNj5ayTSGyHAdhc14GGNGFtQoM6EVu
	rT67pxC/Hfn06tUapDApKWPPqUgFf6/NH4OFzFXk=
X-Google-Smtp-Source: AGHT+IEHFgrcMTbzofDrxYhszmZSjhSU+Dr+aUv88uObflo1lT+8kHGwGwDfULZbO4ZhDjQFQW/1LA==
X-Received: by 2002:a05:600c:3582:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-45369ade30amr4425595e9.7.1750432629909;
        Fri, 20 Jun 2025 08:17:09 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f1d1bbsm2343322f8f.41.2025.06.20.08.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:17:09 -0700 (PDT)
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
Subject: [PATCH v8 1/9] rust: device: implement FwNode::is_of_node()
Date: Fri, 20 Jun 2025 16:15:04 +0100
Message-ID: <20250620151504.278766-1-igor.korotin.linux@gmail.com>
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

From: Danilo Krummrich <dakr@kernel.org>

Implement FwNode::is_of_node() in order to check whether a FwNode
instance is embedded in a struct device_node.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 MAINTAINERS                    | 1 +
 rust/helpers/helpers.c         | 1 +
 rust/helpers/of.c              | 8 ++++++++
 rust/kernel/device/property.rs | 7 +++++++
 4 files changed, 17 insertions(+)
 create mode 100644 rust/helpers/of.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f724cd556f4..1e918319cff4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18579,6 +18579,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 F:	Documentation/ABI/testing/sysfs-firmware-ofw
 F:	drivers/of/
 F:	include/linux/of*.h
+F:	rust/helpers/of.c
 F:	rust/kernel/of.rs
 F:	scripts/dtc/
 F:	tools/testing/selftests/dt/
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index ed00695af971..041a8112eb9e 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -26,6 +26,7 @@
 #include "kunit.c"
 #include "mm.c"
 #include "mutex.c"
+#include "of.c"
 #include "page.c"
 #include "platform.c"
 #include "pci.c"
diff --git a/rust/helpers/of.c b/rust/helpers/of.c
new file mode 100644
index 000000000000..86b51167c913
--- /dev/null
+++ b/rust/helpers/of.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/of.h>
+
+bool rust_helper_is_of_node(const struct fwnode_handle *fwnode)
+{
+	return is_of_node(fwnode);
+}
diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 838509111e57..63fe4b6ee6bc 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -61,6 +61,13 @@ pub(crate) fn as_raw(&self) -> *mut bindings::fwnode_handle {
         self.0.get()
     }
 
+    /// Returns `true` if `&self` is an OF node, `false` otherwise.
+    pub fn is_of_node(&self) -> bool {
+        // SAFETY: The type invariant of `Self` guarantees that `self.as_raw() is a pointer to a
+        // valid `struct fwnode_handle`.
+        unsafe { bindings::is_of_node(self.as_raw()) }
+    }
+
     /// Returns an object that implements [`Display`](core::fmt::Display) for
     /// printing the name of a node.
     ///
-- 
2.43.0


