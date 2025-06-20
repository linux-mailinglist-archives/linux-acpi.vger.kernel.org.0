Return-Path: <linux-acpi+bounces-14480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB48AE1E5D
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 17:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA953AE8FD
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE822951CF;
	Fri, 20 Jun 2025 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIEEU1Op"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BB58F5B;
	Fri, 20 Jun 2025 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432856; cv=none; b=HLl2gkPJCIf3Aff5NEqLdA+jkwg9qkdTp4Grlr+S5g3owbibVg1Jx/KT8whRV3IgBmXoOYv8dfJhlFGjClyfZ32A9F8afSHm+XkK6vJ6q2O6R6boicj7o0MAZb6Y/P2eCTYfq2wrUtjMMuushT4S94nYL2Uu4Sb3B5tos0eS/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432856; c=relaxed/simple;
	bh=8+3R0drlRKnn/JI35OglwAOSwdC9nd8AtxSqpjzELK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRO/08XOT4Ac5ZrgraaZ1EL2VaMinfYdytQLJd5+FVDOq5Neg/bcva9ZBi+v3lnh93cQP+XCCz+HOMdX4i9+IZk9CwG9sWYfIWb3AhiRjekXaSkx/V2jOwNrQUHWtgU5aa65tJnes6HKLDdJNtbhyRkICpjGOZhDpfKvnvhijVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIEEU1Op; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453066fad06so13046655e9.2;
        Fri, 20 Jun 2025 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750432853; x=1751037653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/KIHO86ldP5ZYoE2kwfFWlV69Tw5RaRQj/rKy8DDRg=;
        b=NIEEU1OpZ6bGXPEtZBJLe7vQYxJLQ/8YHga8PDGa70rCR21LdPdt/saNOifOY35g2y
         A+mNnv2ZNjWDYqYSA6TsTDEb25dG6opTvdRRCFsndRtDIEsfoPaiI6G7lbq2fSAjP+7P
         DPl6lOMctefpXzGoW/8zBf/k7AC2LmQ+5hNO/arqnTM2MbQz65K1NXWDdF3LUUpB9P7a
         PYs+z4498JHILdGfnH6z/wwzDCwhiyLZLZ1Pm6UMwC6Oe/LE41YgwLUJVkG7IWy6zYb8
         Xb5HBUm7WjxJOSSr8g8wKiy/pxMeZIUVlxHlIKwlfuKu49ihpoMsZKpjfrjCOHD8XLSZ
         99Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432853; x=1751037653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M/KIHO86ldP5ZYoE2kwfFWlV69Tw5RaRQj/rKy8DDRg=;
        b=l4CB78TFljm0hmdrfQGiH6dMKD14/tom9jhqZtF1m/whDczcZSC8EBEYJ7ZCJ/U4Gt
         xHKpSB+y9xx3eCo90imCMNt6TFhJLHlcCEUuov2rYIzxori9dCMkxU2fbSxxPbXG8llz
         bD/lY9f15GiXVDXWl6920EsOEHpMqcLSq/VmGhAaEWuaKJukL0+A5nXuV1BDPgi52GdT
         Au+OUniGzI/Eza6RM2D87AOQjqJjxdByixA8SweaXfp6fEqhOuj5j9lwOnEJ09x1qC0L
         XOpK05tYkllbqA7zqLH/U7FX8M/XEDMlFIk4lyK07BAuov2abg7oS4mbmiaSU6m16aFq
         HZcA==
X-Forwarded-Encrypted: i=1; AJvYcCU6c/v3LmRQ64RHS5aoq+sZen4Kn35T3PYjdcLIy2ksUp7yz2Fsk4CAC92Eac+0IVfdmnwh7iPK3cQV@vger.kernel.org, AJvYcCVDqeXgwImvlrxz6L9aXPG46iOhOerZA2+kPWmjaGyTKiyvaW8ayJxYqI/PjjlbdggqmRy9QAVHestmYdPg@vger.kernel.org, AJvYcCWFIrxNcTrErk8cwO5vNHlDFkpuFtLCYUe4S31/PwoQ9eFMLLEp6BXyXRg/FJosSFKnE2niPQLv/KZppQ==@vger.kernel.org, AJvYcCX34AKeNPHwFwqznjZp0sjrILWuYKXvTbZEv/U+1n6JBgdJUqVzxzvh9T3l/ZLn/2c8nkYbdwvRDOi43GZ1nqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLdJRtorhJ8hcJHIMfhcSfU81yfkLxPkYW4SAaK6JduR01VBh
	j2ZlWsb9f0pmIgSZ1cp3EHPs3OXcfABZzZmAkG7/fEnopQXJYpeMfcqk
X-Gm-Gg: ASbGncsH4gLSMM43DJEwLrp7Hl/bUkEUPENpWlLC1P/9YwoAzG8yasKleBUhsShd+bN
	Vlh68JoHIIGxhaWxZ+opa+sKVg37z8a5+1B9Hj94rGNiK5GPHhXeUzAKiZhy1/aUeg8+cPGqYs8
	d3KJQHdKkVd2iIsEfrSRZ53cyPuPv+KKx2Kgu2GBzH10NhoA8wOVyMikj4cgj+6kOWxv4asL0vm
	WeW9tNaiBpzwyRua2xbKDFPH1QFktfJJ7u4khzJRvABtK9uHEbjZ/ILCeDCyvVVO1L75dwZnCLg
	b+EqTUMXmSoWVaSBmee4jAQlsjQdPtuYXwo5PmkLAomE6QQPe5w6+qtK9k34Ha5V096/Oie2DG6
	MOYjseJVaVfdfqkOD+5iHt1MvnDXfu2q63S8R7Q2wdjrheoTG3w==
X-Google-Smtp-Source: AGHT+IFWKYgJk3mh4dufOnojkp3+ym/Cq+duMM+/JKKRWEtc/dnqzc4ndzC9W90pmrbOVECY/4YLeA==
X-Received: by 2002:a05:600c:46cb:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-4536877fc08mr16646495e9.30.1750432853078;
        Fri, 20 Jun 2025 08:20:53 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646d1508sm28563515e9.12.2025.06.20.08.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:20:52 -0700 (PDT)
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
Subject: [PATCH v8 2/9] samples: rust: platform: don't call as_ref() repeatedly
Date: Fri, 20 Jun 2025 16:18:49 +0100
Message-ID: <20250620151849.281238-1-igor.korotin.linux@gmail.com>
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

In SampleDriver::probe() don't call pdev.as_ref() repeatedly, instead
introduce a dedicated &Device.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 samples/rust/rust_driver_platform.rs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index c0abf78d0683..000bb915af60 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -32,13 +32,15 @@ fn probe(
         pdev: &platform::Device<Core>,
         info: Option<&Self::IdInfo>,
     ) -> Result<Pin<KBox<Self>>> {
-        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
+        let dev = pdev.as_ref();
+
+        dev_dbg!(dev, "Probe Rust Platform driver sample.\n");
 
         if let Some(info) = info {
-            dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
+            dev_info!(dev, "Probed with info: '{}'.\n", info.0);
         }
 
-        Self::properties_parse(pdev.as_ref())?;
+        Self::properties_parse(dev)?;
 
         let drvdata = KBox::new(Self { pdev: pdev.into() }, GFP_KERNEL)?;
 
-- 
2.43.0


