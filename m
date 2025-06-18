Return-Path: <linux-acpi+bounces-14435-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49456ADE82B
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 12:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A21B7ADD5D
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB36285040;
	Wed, 18 Jun 2025 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffhvQe2w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C54828505C;
	Wed, 18 Jun 2025 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241322; cv=none; b=H0sCxEQKcw8kz0aajojchxBmvzUjuBs8iS07zXpzIVPLYFvAwjMe2jPHfCD4b5MPyJ4mpzqgOmo1DVKrT05oTn53gOsTJ5Fib4e/o0AkY5lCOcLSMC3hBn/e2Is4Lnx+tW244XZghtg0POmI0fP9M+DKY0J6MqKsBjzhT24495Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241322; c=relaxed/simple;
	bh=PM3oiMkCf1SkhOWKY+/gl8R1ZWVyQafTba/3XCv24As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pK2ooislCw6M/LgfIntunMzPAU3zF0RAe+/8G6BbiJCssmBPEN5UuIxR+BUWRLqMd7EdZPGLtsNhViAeqrfQBZoq9dBzkmKhd9g+cXan1dNSMWiWq9Sz9gCgXYqAvLl+ixjklaO2wkfkjk2BCP93WioQOi8abtsHaecezC0iOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffhvQe2w; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450dd065828so54694125e9.2;
        Wed, 18 Jun 2025 03:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750241319; x=1750846119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMzjEshtuGmJcwDym84s/UXUgcbvyW1pPiIeK/zCXQs=;
        b=ffhvQe2wJ9YoDFfQQA0LnRZCSUe7iK+p/36wYmE9rVphu5JVa3HfNcK0T2N2EPhjNU
         ZtX/20xskYB+lLyWAX7qQP+vBFx2PYpYMbC4f6YT7xB2bIcxCTPq1SoY8C7Aijpl7Lvq
         t2GpPv3QloVQd/bihtl8zJ5BeUqJUq2Kq+3vu/gR7s6oSQAoyFNXnbum/ZYaoONlXrUM
         YKSjM+j3aFL1k54T5ghqiBhPwghjpSta/J8v3BkA3NDaIl8v27PT5O6pg4259dkGe/FD
         q247rdFhegBZeqCiXx67gtV0qiVHJevFcRN+zYB+j53yZvHP9peaHd3EH8llDPWvnszf
         jmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750241319; x=1750846119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vMzjEshtuGmJcwDym84s/UXUgcbvyW1pPiIeK/zCXQs=;
        b=V+kUZa5bfj5+cD7aN4xTT9KeZLX3qDDUghIP/gZNzN+0YC1neQK61ISBkdVqxQNkyS
         6SEORzw47GxuNle5SsAEJGwJwHiCLe8P2vHcsPRjFrTV/lMJywUq8DpPlBRSrX0RofyA
         d4W5HgI665zW0HP2LDihTAEvS9QKU69h0Q8/NG/i/A1ioCIMPnXEJlVl8cNvo9Nu/QsB
         +uTWMXy/FY/MWGfpOOBc1JXZCPAKJdvbUyG55AykdAg82zt3XxXTBtaH50xduXjJWO7x
         3R2ctWnr/+w8wsAe98vCBMVzaJtn5Fx1v3z1gklcRkR2AkqL40WA37hFyWNgRCSxICcm
         liBA==
X-Forwarded-Encrypted: i=1; AJvYcCUua5NeqVnGhWnEjXETTv1yeaENrJ2KYeuc/h8SrQg7xE0/0eihv7FgbZDeCXIfxz3pu8lZCakmYKCi57H9@vger.kernel.org, AJvYcCV3bQndGoR+la2Guryh85DMQpJlpOEU/9BE7zZqP6yzM1r4YYBS6zdmmsQnO9BOfUpezvO3L/6QtFL7bH6HWXM=@vger.kernel.org, AJvYcCV6gM2AfVT75s+VEogOwEJgq/1uQZ253Yuty7QL3LK8DPZnLvrOJDjq1otzzj23dSY5PN6X3dCdS3BA@vger.kernel.org
X-Gm-Message-State: AOJu0YxB/Y4JnqaJpOVfDFrS9FsVmEMZ+Zcj1qMrmmrTUxgaNjKrq/4F
	of9u/lYfUpbE/s63m/XUcU94P3lsW7AWEQ+0wfI7hSXH80A3P+n+ypwx
X-Gm-Gg: ASbGnctuegGePUPf7NKyq6uLUf0LFIHreiW40OJHolw64p/mYYbee01LaRicpyh+lOp
	KfZF9iAjFrEbe/VWNEImm9kiq2V6M8JGzmdX+zFBa33gYFsNbyUicaipKfRNc9loHwaH/iQfr+x
	afoFurfTkMfyHR5UMQLDRiCvJ8CXWhVM92AjvGY/Vz4Lfxyza/IbP0F0shkd+pPDJKpr0wWNSTf
	NNkyEfIvKWdqileWVAmcoQ6Whxd6CZWNvQwYi7Fp27lA+YOAWg+/K/9eym8sfrbS5JA/mp89w+p
	k0AYApxWLA01aaDM/asvJOwotncCoC55CyCpHnnIKBK6ZWdTQgqt6K+eRtpbxkDgPpaL1Nbkft+
	l16r9iaJrTCIa0F/TsgHNSE7DRvRHwx9iqa/BL/E=
X-Google-Smtp-Source: AGHT+IFWAjJNlkTSbKEj9ag9dCZUDRbFRfhT9FkaMsOUOcM/aGYq0xGr+w8AlC8AZoF7lkcJyJxlbQ==
X-Received: by 2002:a05:6000:40ca:b0:3a5:3b15:ef52 with SMTP id ffacd0b85a97d-3a57239776dmr12332294f8f.8.1750241318499;
        Wed, 18 Jun 2025 03:08:38 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54b7asm16689305f8f.16.2025.06.18.03.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 03:08:38 -0700 (PDT)
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
Subject: [PATCH v7 1/9] rust: device: implement FwNode::is_compatible()
Date: Wed, 18 Jun 2025 11:06:35 +0100
Message-ID: <20250618100636.3047585-1-igor.korotin.linux@gmail.com>
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

From: Danilo Krummrich <dakr@kernel.org>

Implement FwNode::is_compatible() to check whether a given match string
is compatible with a FwNode.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/property.c        | 6 ++++++
 rust/kernel/device/property.rs | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/rust/helpers/property.c b/rust/helpers/property.c
index 08f68e2dac4a..177b9ffd7ba4 100644
--- a/rust/helpers/property.c
+++ b/rust/helpers/property.c
@@ -6,3 +6,9 @@ void rust_helper_fwnode_handle_put(struct fwnode_handle *fwnode)
 {
 	fwnode_handle_put(fwnode);
 }
+
+bool rust_helper_fwnode_device_is_compatible(const struct fwnode_handle *fwnode,
+					     const char *match)
+{
+	return fwnode_device_is_compatible(fwnode, match);
+}
diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 838509111e57..a946bf8d5571 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -93,6 +93,15 @@ pub fn property_present(&self, name: &CStr) -> bool {
         unsafe { bindings::fwnode_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
     }
 
+    /// Return `true` if this [`FwNode`] is compatible with `match_str`, `false` otherwise.
+    pub fn is_compatible(&self, match_str: &CStr) -> bool {
+        // SAFETY:
+        // - By the invariant of `CStr`, `name.as_char_ptr()` is valid and null-terminated.
+        // - The type invariant of `Self` guarantees that `self.as_raw() is a pointer to a valid
+        //   `struct fwnode_handle`.
+        unsafe { bindings::fwnode_device_is_compatible(self.as_raw(), match_str.as_char_ptr()) }
+    }
+
     /// Returns firmware property `name` boolean value.
     pub fn property_read_bool(&self, name: &CStr) -> bool {
         // SAFETY:
-- 
2.43.0


