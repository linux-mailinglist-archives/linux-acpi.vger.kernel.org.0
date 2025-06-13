Return-Path: <linux-acpi+bounces-14345-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1AFAD8E51
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 15:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0893F1E714B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519D52F2C4A;
	Fri, 13 Jun 2025 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDmwatfu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB8C2ED85A;
	Fri, 13 Jun 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822580; cv=none; b=cb0V8rvJVVPnLS+MAe7y2LfHIVfHIRcr+66PAHC6kXhLZ8qB4uGVHgqjyqGmD6S0tLg+BB5IfXrHOgWpIofCy48j+pXpRbV8oXTh0Nbf/C2ktwqM28ngMOq6AfK+aiivuh/LddBnMYTFSI2qaFfFLsrvnPzi0cn6aViSn5Z7AV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822580; c=relaxed/simple;
	bh=X3GP0rFGQWYb7D9EofmWO4CkjJb3nRBnJ4sS25K5GGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihzV1Hz3jgC/gaq3cBp2HrFgN7kiHFfl6tuLwnwLyrUJeBxfiCHBJTPLQy+n+HVsvfOOJpnECzpD8qwO1UNJ81PmTb4U0mjROYsBM9auKWD6AOMrmEPBY3rvvv9xxwSPhOHMjiziPERGTKt/aZq96shuGC1QocwxfJUH8CWEZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDmwatfu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so1738863f8f.2;
        Fri, 13 Jun 2025 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749822577; x=1750427377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/r6nOkep5bcePWw/OmX8epaR10E2HZMsLJvTHOobc0=;
        b=jDmwatfuYDuuuzpxYppYdUR56GQzk0p5X3qFTdrDZ5FdZ0UCQGn4LaKjfl93RcwwUg
         Sjss4lSAe/Jh8tl7mBAZBdg+XqASL+jyqstRNZNhgnwclKpmLclePAQRHN5/u7W9qsNI
         hg0rcZsRm9fyZGlBxHTCyTV12utmpkjIpjTuNKhdimf2Bst7NoFIe8nWG4dFp6GnzI0t
         g8MpiORXevD/aNg1PGPwcV2e6kTVxKfN2LLZnjT8Z4NFWVkXpne1GUgwVFDCVDkn4IaY
         0Up+QEuTQG6rGQfNwxm6Y1A25dWyzZIbbO/FY4X93Bv+aATID9hhZfRf+pon6ywqMMN7
         EjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749822577; x=1750427377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X/r6nOkep5bcePWw/OmX8epaR10E2HZMsLJvTHOobc0=;
        b=GkevFhoHdWL74jRF4Dt0SW9QSwr3/ra6gPbjgg+EFkt3tKOSTN8mOkXWEE6lf5n3sG
         nbRt9WqHFzfE/Gj43f5cDKq1ieZ8bkggCLspyeP110Hlf4eqtFJgFJ03EkD07HNmbk6/
         Sz7cdKwHAniieBIJTqASohOjNeNAQqZkjv4u3z1DHwxl6U9NHSKo53NVRhOZUmn0pUov
         VKvPr5WyUpWOpVA/+tP5caR8GXFHg2c2N88/PKyxRsNgtGFo7+VvbZHIFM6ojOuWQcBJ
         +ICXM23c620muoLBJDKfdUk9WIwiwixYAtUzU9d2FugZr4yJ3V1FdVZAGFqnUUL+tgBt
         cXjA==
X-Forwarded-Encrypted: i=1; AJvYcCUky7R9QWPeC9R5atmjQC2HRDgGI+F6dPkiCsZZ6UqeWOxRwa+AoLA7+dIaUG7TIpAc9BJGxo8hF7AI/GB6@vger.kernel.org, AJvYcCWkn1gh8IObpPz/BZ7eAX3U+kx1H7Y2Qgwexe3Aqps7UE8arjZQdNVZ47nVJUZdXdshRk5HdK1yRoEM@vger.kernel.org, AJvYcCX1PibPX/C/Vrf7Wen0QNLo4FDpngmKnjPbK8gwue4GufOyen8UUnwEz+l4W+uD7q/T8o4qcOxtnRDpXeFI8qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbItQ4ExO6RhlkLDgTsUke5NXnMHpF5YKg2L2To1vnB1nO7UDI
	hwKgt/H3/MgeIs6bw54dAOHeFfU/gpS1YXeDz0iqyOQyfYmF4pVHZQU5
X-Gm-Gg: ASbGncu5y7xL+oaDaNvs4d1tg869E7bmHL3eosLunOyLcnSsp0uKarlv8nGvPEXbS84
	9WeXGCUvVTbO4tEWg7ehl+tUJqfEyI6U5vfWeRssYjVJejhJz3XshVfBUO98SYxagmzkmlvxnbd
	gzsTeA6+Zq2SGTUQ1zkLLWxWCOOTlTvqfqsz7AExPXRODl0tq+9Gxn9UVXe46B02cRZZf3h7beo
	GKWpaVt3Py9o6W5Xtqt+KzehpTYdl5EWJsorJJUEQOguqwzjEB6oIbVg3/k1K75FH4lXEMiW3dt
	JzVSLfo2pg0EugHYBjr3ryUo4wGXypHacud6c2UPqZWrarX7K3FjZbCu5jcJVI9VGO4+dUuRrkJ
	fGRfcsLhWC4iM/pjMANAikAQlSMRdFYTFHkVR
X-Google-Smtp-Source: AGHT+IGGIalFTB6DUZM1gWX0syyRV3WpDt1rCMWnNCP9Kf/JDeJ16571MhlLO0tSnSeYWmbVL1oyKA==
X-Received: by 2002:a05:6000:22ca:b0:3a4:d975:7d6f with SMTP id ffacd0b85a97d-3a56877eb6fmr3360807f8f.39.1749822576560;
        Fri, 13 Jun 2025 06:49:36 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54d74sm2482634f8f.10.2025.06.13.06.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 06:49:36 -0700 (PDT)
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
Subject: [PATCH v6 4/6] rust: platform: Set `OF_ID_TABLE` default to `None` in `Driver` trait
Date: Fri, 13 Jun 2025 14:45:10 +0100
Message-ID: <20250613134510.1231709-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
References: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a default value of `None` for `Driver::OF_ID_TABLE` to simplify
driver implementations.

Drivers that do not require OpenFirmware matching no longer need to
import the `of` module or define the constant explicitly.

This reduces unnecessary boilerplate and avoids pulling in unused
dependencies.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/kernel/platform.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 5923d29a0511..2436f55b579b 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -162,7 +162,7 @@ pub trait Driver: Send {
     type IdInfo: 'static;
 
     /// The table of OF device ids supported by the driver.
-    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>>;
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
 
     /// Platform driver probe.
     ///
-- 
2.43.0


