Return-Path: <linux-acpi+bounces-20616-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDGoD91md2nCfQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20616-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:06:37 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE9988969
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B78C3049265
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BA8338925;
	Mon, 26 Jan 2026 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TomOpbD0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CB3382E8
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432732; cv=none; b=olwd9ebwBZUZYC5zh71URw0rs92hMp5ZewK/MYs/v0LWdmfqPZA+KKp2WusOphVnjSlx4ak9Wz1VU1199W3blHwUU67TZ9MBRvJ4gWDGRuuMVT/47cIVzkKHjmpoBL5icxI/aZfLswOfZ0w2JD/jcFVCfxeu3pyv7n9AD/PK0Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432732; c=relaxed/simple;
	bh=bXzZLukQXEbPWRHxObil5vyPCVlHq4BXTn8D2BTuTm8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cGPkvugI+QLMaaDJG1ItdSJo8Vt2ZGqUd6Dli31AdgfBQ5HaPP9vDVLcJjjptEBM6meu6m/+14wghDkPb3o8ulEpayaqrWJbna8UMpGphMncyYFJnAhIWQLxxH618NKKBbudQRRpJmeUa0alw34OhjrhOvk/1w3XSdZfYh3r/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TomOpbD0; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47ee33324e8so34581725e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 05:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769432728; x=1770037528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gN2t17/t1rDSBRJlYmD8L1PuCsoH1p/D10jNGeOcAjc=;
        b=TomOpbD04f6pwTQfko1b2fNKs5QM/zOYyq1xD9kM+y5QB1mdjgesxLyaLiiWW5YB4I
         sfD1YowHw9pXLrSTjS6b/v6Hf5jDIDdp6gy+npEe3K6lZHhQp0S17Ym9CYqhX20RJCxr
         tIyWF8w9FiZ1tI/1DCRZr6sYoMXSwMY7BNc6FBjegMEOMUt4DmZzLk2RSQPkxtzCctjc
         az5zNWooGsPdwYR6klBvQHABZULnsQr5gTT00gT2+VTXOnqCfnzKhBt8uckn742+RC+7
         yP4K1m7+WaWV4EdqEc/BxZmz/Bq19da/b7gaFbDj45ARNUFWft2UhzAYV7Ve3I9LwMZJ
         PJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769432728; x=1770037528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gN2t17/t1rDSBRJlYmD8L1PuCsoH1p/D10jNGeOcAjc=;
        b=a9yowM/oj+pwAnEVLNeVmMHAlDscMkXW5EBZShMStRx1Qno/ElBedwvwHXHGByMYho
         bmNAMvteH+cAECCDsw+xB1keGTtQzaMF71VGXuxWSAk9EvFdUqSufO3VxgN/jsrJBaBt
         WUy20vHkrlAfaZU86Q6OBnBNHncLt2KDw7k/a/2xkiVtXItfvuKWnyP4gBqXk5XCZ3e9
         oRMejg/jkLQpa+gVnCDnxIm3T8ePXM/4DGlYkeea/Z2RV1VHk6q0cEzmH4vNceaF/WQL
         Ynf4XH/dYgqzluaLLZvQ4cJkKEEzg/sn0O3fISlguS8mrqpnr04CtpFk1w3dU28iRIzv
         bIUw==
X-Forwarded-Encrypted: i=1; AJvYcCUD8Qyk5rq/j0vT5lfFbGlSnvp9rqhzSNhFZjhZ1LdD63fXyR0WV9IrRPts8URSaj1zFZd8bHP19g8A@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtyi9m5dggI6tMejWswdDhFXUjtTqGYN3oBy5gNXIN/SMOfcfS
	4YWAMLNDkWw1rOnVWWM2s6Vrdq5Az39m9sh6k5Wgob5qBsboNPuwnLCJW+iw03Iqcq60FikEy8b
	D/zrrdaB9kYmVaizCMA==
X-Received: from wmbjj21.prod.google.com ([2002:a05:600c:6a15:b0:46e:1e57:dbd6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:470e:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-4805ce3fcaemr63455715e9.5.1769432727799;
 Mon, 26 Jan 2026 05:05:27 -0800 (PST)
Date: Mon, 26 Jan 2026 13:05:14 +0000
In-Reply-To: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=bXzZLukQXEbPWRHxObil5vyPCVlHq4BXTn8D2BTuTm8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpd2aV4Lk3pJz0stKiMcxdwDpn8Kl1BIjlWX/rA
 aiAyQf03zGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaXdmlQAKCRAEWL7uWMY5
 RuoiEAC1swO+geQ+r+AjShO8mOnMB/d2DuExVIlaIuoxklXWLQXi30gIy/MzfAAkXa3MM0hHl2j
 hh53B8QTFDgYVxbfzUdlR2iiLv7JD9zdJXcQWboxTqRakN/Z8lhDdQz+tZXG4kDyEzuVhJVWTsp
 hEp1lNtWWRrT5sN52J9Rks+F/KbQwA3ZjqknlUJoIKuqffWbC3OeZ19nJTXQ+lNraopmiJ7/H2G
 0fCUTS26dd6Di792kIMpyY0Kdy07GHev06L7g453oNygCHc7ksg+ROsK2girhonLkVBCdI7dj8a
 4p7ZX6Z3Ovwc+//kovrIehqaaHeJoLWWBO+BfKZWjCF2N0GxPQRB5wgK3pCwfx9COnmo/rzNDsg
 m+Oria3AxIzwcgIKEXGXmDq6jKquJT+rFJD5VjswYLdQ8qMWYhZgpGRZjmLXc7AYfnBdHOLfe1J
 3HSS/YNE9DyRhSqmFb6abGDjUl9MAdJfRT42gD/HSjhWJWu69722AcH3+84x2HFPv4xIHX/2iMF
 8dC814QSrhnvf+jWFMe1hdzwSHZA09toEN1KnxglEjuBr3RhqTfxyR67J8ytsr3zOua92OXYI7e
 f8jiLcJOHbX6hfJiqVQ3Y+zUvI6yFB7lJ7tPyXp+x4I6NoPeIDdxiCATHZ/bcKxTEaEVltMOBxc s8T1/rN35j3ksVA==
X-Mailer: b4 0.14.2
Message-ID: <20260126-zeroable-ffi-v1-1-0ef101d1ed85@google.com>
Subject: [PATCH 1/4] rust: ffi: reexport Zeroable and related items
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Len Brown <lenb@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20616-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,linaro.org,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCE9988969
X-Rspamd-Action: no action

To implement FromBytes/AsBytes for bindings types, we need to move these
traits to the ffi crate. For consistency, this means that Zeroable
should also be available from the ffi crate. Thus, add the appropriate
re-exports.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/Makefile | 9 ++++++---
 rust/ffi.rs   | 7 +++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 5d357dce1704d15e43effc528be8f5a4d74d3d8d..701d64c2310858aca8f7f76d698549fa014f62bf 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -207,7 +207,8 @@ rustdoc-compiler_builtins: $(src)/compiler_builtins.rs rustdoc-core FORCE
 	+$(call if_changed,rustdoc)
 
 rustdoc-ffi: private is-kernel-object := y
-rustdoc-ffi: $(src)/ffi.rs rustdoc-core FORCE
+rustdoc-ffi: private rustc_target_flags = --extern pin_init
+rustdoc-ffi: $(src)/ffi.rs rustdoc-pin_init rustdoc-core FORCE
 	+$(call if_changed,rustdoc)
 
 rustdoc-pin_init_internal: private rustdoc_host = yes
@@ -249,7 +250,8 @@ quiet_cmd_rustc_test_library = $(RUSTC_OR_CLIPPY_QUIET) TL $<
 rusttestlib-build_error: $(src)/build_error.rs FORCE
 	+$(call if_changed,rustc_test_library)
 
-rusttestlib-ffi: $(src)/ffi.rs FORCE
+rusttestlib-ffi: private rustc_target_flags = --extern pin_init
+rusttestlib-ffi: $(src)/ffi.rs rusttestlib-pin_init FORCE
 	+$(call if_changed,rustc_test_library)
 
 rusttestlib-proc_macro2: private rustc_target_flags = $(proc_macro2-flags)
@@ -657,7 +659,8 @@ $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
 $(obj)/ffi.o: private skip_gendwarfksyms = 1
-$(obj)/ffi.o: $(src)/ffi.rs $(obj)/compiler_builtins.o FORCE
+$(obj)/ffi.o: private rustc_target_flags = --extern pin_init
+$(obj)/ffi.o: $(src)/ffi.rs $(obj)/compiler_builtins.o $(obj)/pin_init.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
 $(obj)/bindings.o: private rustc_target_flags = --extern ffi --extern pin_init
diff --git a/rust/ffi.rs b/rust/ffi.rs
index f961e9728f590fd2c52d4c03a1f715d654051d04..7218d4c535cbd7163d9aca52b0525c588a394d1b 100644
--- a/rust/ffi.rs
+++ b/rust/ffi.rs
@@ -48,3 +48,10 @@ macro_rules! alias {
 pub use core::ffi::c_void;
 
 pub use core::ffi::CStr;
+
+pub use pin_init::{
+    zeroed,
+    MaybeZeroable,
+    Zeroable,
+    ZeroableOption, //
+};

-- 
2.52.0.457.g6b5491de43-goog


