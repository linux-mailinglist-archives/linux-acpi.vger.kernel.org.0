Return-Path: <linux-acpi+bounces-14441-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95CAADE8F9
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 12:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E93BD900
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4EF2165E9;
	Wed, 18 Jun 2025 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLXrOwT1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0827E7C0;
	Wed, 18 Jun 2025 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242262; cv=none; b=njANGiKaLSkj0B63C/gN6hcOOoTQm9lh55K+4vg8jzKVEATeXWLD4IzcBWaXOK23ARAqOFoMT1X3H4rqXv3MQgaV/thoG5h04jmGrj1voeUzNMPMR0tozSaKD8lyA2b7XxJxMrlk1wIYzuTIKo2jcXD90YZOZv7WVHiPak4roX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242262; c=relaxed/simple;
	bh=X3GP0rFGQWYb7D9EofmWO4CkjJb3nRBnJ4sS25K5GGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFXAy223eERRqJC/Jzy1GK7i/B/sOXg1WEh+SavnJs3aEfZ9FlNd1st+xUPCrgE7ZZ+ICPhXrJ3+VNYUouz8WssXbAo6+dFNUAX446FWICbw3LW9JDrvtBU7ZHpELuvHpXBOqlp+kdU4gOO7RhbqQYAB6v38zmHeS09znpyBkkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLXrOwT1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a51481a598so3907860f8f.3;
        Wed, 18 Jun 2025 03:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750242259; x=1750847059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/r6nOkep5bcePWw/OmX8epaR10E2HZMsLJvTHOobc0=;
        b=fLXrOwT1J5Y8bdFyDn/70qn+YD5ESDAh50Ptgk8VAKKuaPGParp0fHlgNvJGj99tsp
         adOuC0cVcgBgwb8JeitA1HmvYQGB2QqTMJgkdFRaO/+fvQC/gGZuK4kGfnUl6H2Twakf
         wxVc4ENtBJSAWQKxb7DpRWfJISXxCbdGg3i+68qs4sF+1HmwoPx2tuoPB1ahgermF58P
         SgeL3mY1R9BIl7MV1KRwFf4iC0h5DJSwi+rQ+I6lPfZDzKGo9kVInQ8I0UORSGFjtvkD
         97Di5So1LSpReZ5+417M0mDGWW0umuUv1EsqzRUsMg4iXqwW+03Hb++neEv+G0+z4Tum
         sGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750242259; x=1750847059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X/r6nOkep5bcePWw/OmX8epaR10E2HZMsLJvTHOobc0=;
        b=qswKrS4ZM+jR+8YskIDB5WzpY4OZ9Xx9fDqVPoCX7/hO06Y2K7S7J9COyk63pXsU9D
         i3C79FrH/BydSguNIauZ/FUiTo9KL18/bTfuJoZ5Y5xQZq45Svlv3vy5l1wtb68SANds
         2f0nqh2vr1LBysl/fJhr97Y6/bh6ypncbBbCy1gfuv3GolcZhnp15mmt+fdSs3ifA1H6
         4QMIKu2Mt0TjtJSFzOwzKcNo+bP8xbI19PPFx87W8tmmPjfOBJXI+A5i6IVDXypjTC2A
         VAphdnlIxByHyLiLyRZfnbAJodO3RmO3KDrTuHHzWouZjwljbRLco20xaP2l55EtH703
         H77w==
X-Forwarded-Encrypted: i=1; AJvYcCUSLsu9g2mcKtCl3zcUTaiWZ2F4KkO0fCL6HzUneKfeY/YzNTOEfifmJrhzn94cbNSiZvG3S0gUQZPU@vger.kernel.org, AJvYcCUZjuScDyQPe9SNHyBOlGWccMXHq8ETjBFr4lVWbodbcxTfn1aQPnI2Y1+/BS/15GBwCCfyRrEyHuHkGtMVxvY=@vger.kernel.org, AJvYcCW9dvT5Ni2bc454p+VkuVCx3ueWuH9KubxYdGnokKJI9tCo18WpdckG7DU8Y33ZtxekaYuGV3OY7NK5b7mQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwdO76FCbTc0H/A9IABUzGX57ZMV5HzpPpc67rdPZuC8jvBXyfv
	H5t2JSR9wubZ4/YTSJURXYQs4BV5FJWzkgwTCnwlc+dtTxWIQTUm5iVwp0Kd4OWuJ68=
X-Gm-Gg: ASbGncuLKk1SPM6vwr9/XuWnthz1NIppkU7Mt9HISwwAWsD4dAekSczOquKqqC5H83t
	LJTp9yCb1tjfi/IpYGNbcNi6XjcByLB81v0vDuuFdRZsOaLvsI6jDYTFURvP2j2AmQpJ/wShgF7
	VwKsCQnX8+7CHWTkiTQ81vcbJmbrOjF8QD0+ad+Hpi16QmkshbSDgo89he10rttw/8Ubk1/Fsec
	tTIWHJqtyzVB+TdeF2h0oK5Wk3hVqtmgoPm7SIaXE0mtYnudtPkKM6mAQpsGjT4CCpDEeXhyr8J
	S3CXLmiLd6+5UzGCW1VCeJzDyv/io9M+R5mIayKcO5iD/4l5aavANmuNHb7KrhRLacYxLCYa2r1
	jNx0s7PwPnXRDQnFkoiyqh9M0fomoDELwOJEC
X-Google-Smtp-Source: AGHT+IEWJFosgYtVST8+ChR8BDeP/SmvQxlvk4F/BE7rA8OuYv9evRFDiLtSxCZZLKuCzhAMhcHWNw==
X-Received: by 2002:a05:6000:144e:b0:3a4:f975:30f7 with SMTP id ffacd0b85a97d-3a572e58f6fmr13346541f8f.56.1750242258788;
        Wed, 18 Jun 2025 03:24:18 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08c7csm16769840f8f.50.2025.06.18.03.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 03:24:18 -0700 (PDT)
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
Subject: [PATCH v7 7/9] rust: platform: Set `OF_ID_TABLE` default to `None` in `Driver` trait
Date: Wed, 18 Jun 2025 11:22:16 +0100
Message-ID: <20250618102216.3049450-1-igor.korotin.linux@gmail.com>
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


