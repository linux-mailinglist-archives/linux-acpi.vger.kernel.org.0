Return-Path: <linux-acpi+bounces-20619-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADO3KTtnd2nCfQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20619-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:08:11 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2F1889BC
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C1153068254
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 13:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B491D339868;
	Mon, 26 Jan 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8pxPmYN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5F3385A0
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432735; cv=none; b=JsQ+qF2c6ktq2rEn2QZN+Vw8yEMtOFLup4plO5XP8jglrS7QePGawBy58MDDenWbet9O+h5KboIHy4cj9yjJHU0bWxiTVBxEL7ON46iG21IHqZyKd/FQEN4ygR78hFaZPohqdQqEbSH9e9ivB1oxpt9zjEI3R0Uyv9S4G3EX1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432735; c=relaxed/simple;
	bh=xl8shNTbd3l7f1l/wIitQRKB1WOKnOl+vwXdD/w65TA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=htYEEdIvYlcZ3XIMmUKDHCXeXp/keSCZ/iRyZXFWseJnei4L7eG21HOZv2yjiGsUxYuOhZ6fmHXnTdgdGeBxk3fzS3g0On75OmUZVRssVq+HdkTQ/mJmvqjiYZ/KMYfpiYqFJjTNIQmIQH7K+j5MOigeIq2JrN6ISo+LEmfEbM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8pxPmYN; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47ee71f0244so36254245e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 05:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769432732; x=1770037532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4nsmpG+AyhITKbCRZV0HvgvKMdSs0TbZAwbcGdtt0dY=;
        b=u8pxPmYNhV3nGjOr4Kzto6ZTmlOorqunLn9Gn+bBrAbSzwvQGZLAGLFh26vYI284sz
         nPu183EMMF2bYfvqBNn1Wla5wEw4ES3Vi3L/43ODY4seg0pzwEg8gVe5CxjkvJ8kFWlp
         XJhj+R40kokZ7e6+pD5H5lMh7KLYJT008I+pw+TDit8eKnXZ07heCeTNjB26i+gDTdPe
         mXYwl8jBQOKlHd1oTV/MV3Bk1Ky3DjmS4HtlL31OxqyftC1eDTmmasgcvrf9eJiMQjZ0
         GtxrwQVrs3KmJA9oGCafWmRYyvbijmdJ0O7axZ0GhLU/4k8hz/ogziRWnf/sV0epC8LI
         lYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769432732; x=1770037532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nsmpG+AyhITKbCRZV0HvgvKMdSs0TbZAwbcGdtt0dY=;
        b=Zwz7fp+4a6TO1igsS92YeUPb7xWZuEf10KbNMTvAMakH/PN4Lvt8hO6wz7rhCH9/Rb
         Xoys26hk3LiQSTG5J3XkI5ODSlEoY9MYfqTrCTK7qYz2ehrAbSojYDr2qT6+v7tg9ZjP
         H+yCMAYUQybhkB2SGcCr+asiZjEZI5izoDxCKNSGXN2qcpG53HV30+vDmeccQcRIc+4v
         JFIgIIVo0xaj0JxTNrwkSi7nKAjKtWQUgTdfFbkf+TdreJg8xWhpvCXdmo+kIKfvQ2wA
         0oYQCHFJCttQZPI0TqTYpiM8YUfBJQmSmvzYS8aUyam1c8ZY5AyLOoZXx8fTyMbzXvWL
         cdfA==
X-Forwarded-Encrypted: i=1; AJvYcCUhUWuuRHqy/UTn9BjjhR5egD2Z0R6t+NI1hiRN7PAH5lKDiRfDIwqEx97+C+OJ7pg4L17ah6EFom4k@vger.kernel.org
X-Gm-Message-State: AOJu0Yxup+j1RrxGGbP8vBamszNobj8qyRDAW+GapQDjTTC8DuAZ0mPf
	6RZv8aDTl2eQ81dcNq6ScRvcoFk7SuZBWD0ZaVia7xNIaxg2fksiTDCiLD3EqosJK80u0D35oxO
	CzZaZiaV+0D3gCEdnQQ==
X-Received: from wmbjw6.prod.google.com ([2002:a05:600c:5746:b0:480:3842:3532])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:310f:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-4805ce4253cmr68763735e9.14.1769432732198;
 Mon, 26 Jan 2026 05:05:32 -0800 (PST)
Date: Mon, 26 Jan 2026 13:05:17 +0000
In-Reply-To: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=xl8shNTbd3l7f1l/wIitQRKB1WOKnOl+vwXdD/w65TA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpd2aV9Vd1e2rwhMiupm4OaSyGzjJpM8HhP+PR+
 NvrLp5mn++JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaXdmlQAKCRAEWL7uWMY5
 RoYMEACWHZ40+tzZDKpX1QwIMIaXP7/OPrWwSWZcGG5u52wEuWcjYYRIttamuTP+CVDMdVNgA3Q
 whtnCJvnfgMe2SGBHXduT9gewGP8Mrp9BmF7027YyFSHwquzVTb1L4hCqaD2Bts6Nybq7a4YrEr
 xJ8h0HuxspeQmzMVt6Smb9Ywje9zO/5TFvGU43TZaQY0FAGTxkvkAKKkeu5egWE9IXsQpVNNR1j
 bJsjWFzfI6S/9+22xFDouHlpJ4MvyHBH9PxVupLuGK+tOVQh6XNTQ7wHeNHy/tPbYqF/2MtBd2N
 q4muezv0uOgBqMXjMq58Zbb5jwR38ts1AUPURoWQ8xrxtYGn9L9XNpnRA5MiO74juCwFyCJ3xbO
 2a2SGnCLvP5budzPpQ7SK7mE12oNKIXYSrER1Kk9UHOoKEKw0cFvkdLBCKRYugln2oD28hQKJ/6
 gO8cz6SdNsbb859FkYTN5sJy/7ap+LQ1memQq0u/Urjpdu7opqBhQOwvCnMxLhTyW5ikhwfui58
 tppWZAc3nrH8QtHeQxbLtPV+Wg09sja2Sc1dqhXwVI5bBdESQoc/3Jw75UR1N7OMVcyY6TcIIBL
 YrrYBQE0DDmSgaiiGZGtfZqfedoL6C+JdCOMxNGutVpPsPOepM5xH2TwPqn0kcnCAU8ABzwtvRJ mfipw3tC70OW1jw==
X-Mailer: b4 0.14.2
Message-ID: <20260126-zeroable-ffi-v1-4-0ef101d1ed85@google.com>
Subject: [PATCH 4/4] rust: acpi: import pin_init::zeroed() from ffi
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20619-lists,linux-acpi=lfdr.de];
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
X-Rspamd-Queue-Id: 0E2F1889BC
X-Rspamd-Action: no action

The zeroed() helper was re-exported from the ffi crate. As this usage of
zeroed() has nothing to do with pin-init, use the new re-export.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/acpi.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 9b8efa623130c1f4256e36cc350caf5cef46d132..9ae0eca82c658a591b407c4f4549eda00b8d293c 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -39,7 +39,7 @@ impl DeviceId {
     pub const fn new(id: &'static CStr) -> Self {
         let src = id.to_bytes_with_nul();
         build_assert!(src.len() <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
-        let mut acpi: bindings::acpi_device_id = pin_init::zeroed();
+        let mut acpi: bindings::acpi_device_id = ffi::zeroed();
         let mut i = 0;
         while i < src.len() {
             acpi.id[i] = src[i];

-- 
2.52.0.457.g6b5491de43-goog


