Return-Path: <linux-acpi+bounces-14437-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58552ADE84E
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 12:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53FE3A3064
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD38285C9D;
	Wed, 18 Jun 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAHCGE2M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC71D63FC;
	Wed, 18 Jun 2025 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241731; cv=none; b=pZzcBoh5AHFmxEIeCO/H0cO4Spo4hR/A9694iweLB4XMcXjDPeCj0OOJuR3tTnvNcnLOeR/HXJHZa2Qkb4Lp7FnK83JI7ms0yT64ZP3kr1tlBKaVtV6nLdl7XOp2cQphNKwB7TyC4vtmyAGaCudYEhYk6/RGN+Fm4t7OQBJzLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241731; c=relaxed/simple;
	bh=ltwb9DIv2KJ/ugDKG09NyjxtUjK7KgzzXwT+rpLfPek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSs3k/yyTy8iL+ORyD88n+3dCIKrVbVU4posefJf9oVBa/e6yc03daJoQ9FanJ22qJkvbEV8bQh2LmIaLpv6K4Nb2w0c9nh4AwOOTN0u6amZjkhhx4KTU1IT4dlyLRzygagGicEjAUFspAcGj8ng6GRMuUXIEwt6F7/Llgdsuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAHCGE2M; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so5354572f8f.1;
        Wed, 18 Jun 2025 03:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750241728; x=1750846528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJsvhinXAz/28vXCLsDhFRnAr3ugS1hgCI0FXeRg2Pw=;
        b=RAHCGE2MlP3J8zFKH8GZFkN5y+BVE3oCfCN8coAqpMan2fFEN9mhD7Wgoi3/zr9mEK
         F9t2OGHvVwDx2cOLsYhNnWRkdDQb5yuNXiAiSAqnMnaikfEONlqmuhBGE1cY/unuzaxZ
         SFXiZdT3vO9fiV3HsxsQ9N2fLMCXba8UJBdrKjDURZAEydhuNe1w3hZfZIkFNWzi8Uwe
         195lNKxrF+8Eo6K6MgQmQibuUBoe9OaE78vnq4UmOlZ5V0xO6oDbajh3LTERNZfZ9yHI
         hIXy7aF8I/2OAOtn2oIXSMwmqimOI1qLM/Hmx/D1N5L6eapqgzvSH+9zBxchQv5xEJi+
         EY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750241728; x=1750846528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJsvhinXAz/28vXCLsDhFRnAr3ugS1hgCI0FXeRg2Pw=;
        b=mvuUiJPFetY50g+8N5HwKGRvh7ozDXSzX/Eh/v/hcx7k6KiZIeqIY4qE/jVcXpzzpU
         J4apFdRcQK4YmA4oqBN9bh2OsQGvSZzkQjvUN3DuBFWHhrxSlxenYZ9ybcBa0Is/ulw+
         10i4Vd+5zX8nBsFoGjJiPZfsPCmlM3TadzT1rLgSw9nzR9h7r9mIk6P7CRSfJUJ7/K+z
         ElJqGYl5R9GyL2Dvo7cUXKKtOKwozRpsn9qytr4KoV0so/c9Hz6omhmHvFU46jHrYJte
         6FiEljlcK5azpLGkj3sSUwteoYQQeu7x2I0NwoWWoVzrmqVVVjly2uDKrvb11Fovbggi
         cWdw==
X-Forwarded-Encrypted: i=1; AJvYcCUVxXMx/UH6wMg3Vo9rBXki+Zij0naUbfjQoMx2/ET4Z721xO6yMksn3N41oFITvGCOt+VKqwD6DGSL@vger.kernel.org, AJvYcCVV/FsqoehO74Ql8q5gtKNUtCGqLEReOTl/c95bTZZLIgao8hINC5p+6RW/Np60fXj3tHhdosr2PjvJCsry@vger.kernel.org, AJvYcCWkQwYkeiyqJk0+mCBZlhZfE91Iq+XU4DoTrNWnq3khrjcIb2IH//59EWphyRC6S0cfDS+2bA8zJ3V1epd/Q1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yziiphl/qNRgo8v/NO0bslYnkyIX0b+Z8tnRpjQAFxF9aMD4bEc
	pDYcNNspTE/oXp6Bk/Jy2WdXCifOHa2PeF1KXL0EVtogNdZ0jQoq59XB
X-Gm-Gg: ASbGnctw/kdwyQtRwDAig7F1+XRsRs0bhkTmeoJw5WtTFbwwZapt/9VZVYX70NnZO98
	KmU22YjgRNk+L94wwGpKD5jjk7F9dD1zMg8LX295oBml10h07xIDP7Y4jKBSJg+iN5GlUsbAfYA
	Q9xZfLxPLc4RS0uf5oNhHal7tOm0SBADRbWFg45or/nJYjDNNWvhng3aDHlaCKR9J3VMkBr3eer
	MDQ8FBLrO6N6q+kuybl6RvEexPZGlfNgzc60Dbc1MIPCyWMsPX5AQbjQlT30/umxxpLLPi3ovCp
	aHJYhzSfhtYWZp3MHZD2v6oxbNgC/TsHX4CYsSkmG31zXOAOBJWtjnVQeTEYX2h7GgCJWVmqzAb
	djah0R5lFzUOLO3KxKCn5O8Y5TjYAlP9dgWJY
X-Google-Smtp-Source: AGHT+IHMgSwhUqWfJPYacZImHH+hqT1pGDyJydFaYgDyOIKYQNzn0o0KZQVvbpbNHsGoX4rc88bs5Q==
X-Received: by 2002:a05:6000:1a88:b0:3a4:eeb5:58c0 with SMTP id ffacd0b85a97d-3a5723a43b5mr15751243f8f.20.1750241728005;
        Wed, 18 Jun 2025 03:15:28 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e25e89fsm197453115e9.33.2025.06.18.03.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 03:15:27 -0700 (PDT)
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
Subject: [PATCH v7 3/9] samples: rust: platform: conditionally call Self::properties_parse()
Date: Wed, 18 Jun 2025 11:13:25 +0100
Message-ID: <20250618101325.3048187-1-igor.korotin.linux@gmail.com>
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

Only call Self::properties_parse() when the device is compatible with
"test,rust-device".

Once we add ACPI support, we don't want the ACPI device to fail probing
in Self::properties_parse().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_platform.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 000bb915af60..036dd0b899b0 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -40,7 +40,12 @@ fn probe(
             dev_info!(dev, "Probed with info: '{}'.\n", info.0);
         }
 
-        Self::properties_parse(dev)?;
+        if dev
+            .fwnode()
+            .is_some_and(|node| node.is_compatible(c_str!("test,rust-device")))
+        {
+            Self::properties_parse(dev)?;
+        }
 
         let drvdata = KBox::new(Self { pdev: pdev.into() }, GFP_KERNEL)?;
 
-- 
2.43.0


