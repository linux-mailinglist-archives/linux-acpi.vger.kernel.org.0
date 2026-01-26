Return-Path: <linux-acpi+bounces-20618-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOnYLA1nd2nCfQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20618-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:07:25 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4265C8898F
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95AB93020D78
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AC53396F1;
	Mon, 26 Jan 2026 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGlWRNbS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8BE3385A1
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432734; cv=none; b=rtYviH3pMNBOKK9psqk4CSZfF309GE4sxcLSd3hylGiopt9HwePrUOYpYN7OM1kaB7l2su4N/pcNBG617wXYO3pLbZKkDcRewFO342/XNH58XWz1sP3493THEZ5XK8YUTnZyrq92zQxcKMPkhMuOqXGzXOeg5DLKzLm5/0I3LBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432734; c=relaxed/simple;
	bh=LUQ8/ci9izP5J9/4y+2ltP+4wEzDDnOt0Trjo5chvYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aDJxVHMrKU8YJvFhgERLHDY53vn7uQ/h1oXXgLU0OdAUPaM1roTJfHUrU7aO7e70+X1xZ+6/KaF3wsmEn6cKdGuvbe+H+Ok0ghcjasQtzbO9Iax5FqFtZA5Wk07+/c18rJUI80D+vrRHB4EPUtmuPNs6yeIlwY7ymTHs1oe/6Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGlWRNbS; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47ee71f0244so36253905e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 05:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769432731; x=1770037531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+RxVCguDzSbO7RZAiYTn6auR9kVUW4tmzLLXhLMJbM=;
        b=YGlWRNbS34nRsqVveuY//zUCTXKdGUziRUgrBN+uab6fgcQykqEkA9JKdQClh0R6FA
         7Wb/qTxQDz56A3phif+jTiXVPyVTW6M9PetaUyBuhFZ1kd70tCP7aRtgNMsk6lNkiMAf
         6cSESETyUUH76bRRceL9EvPVI3fAX6npoNtYodXTHieGBrKUub3MfOJKyvqtZCcxRAcl
         rAVYbsPLPo3pNA9ZqPu45jV+0pUAc2ee4IoBRbzGl572Mni/LtFVPWJpU+FF2es9b6NV
         zTOOiMsSXEdsZkPvbQ98tGqiRTM59ZxJYBGrQ7pMKZJEpYSeO+Z68hx00c2R1xP9r9EI
         CFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769432731; x=1770037531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+RxVCguDzSbO7RZAiYTn6auR9kVUW4tmzLLXhLMJbM=;
        b=BFxdGMJPl4S+KOPktsKCvK0VYCQCqxWd++LFfKlZFWNmuS1/8euHHBvYESLmNWeNU1
         3hevQPBGQzACWm796ztf39VJE6g0pijXIIjllimJtjXj+Rqzs5iaHC2ss8tL4yM/ZTcT
         RoHvpE36YmYxrGpKCczRUXpZoA5XwgX/q6e62ioZdaoML9xYvSzWonofy00GiceQ9Ve/
         zkvrZpfLQBispskuRyH7Rk9OHDiVUZtOTwPSx9PdNXpdyISHpt3sBGUY4nDgJUOMaI4t
         dFMz/k68Biv5xTbGKgmRPoABfAESX6RQqFTQyNXq4qUPUhUNE207TuAhykS0QYiORcy8
         YFlA==
X-Forwarded-Encrypted: i=1; AJvYcCWu/bOHYXfgdHRzpN2oJ2Ck1i3zKSQld6lo4fxuJYI2jCtevHU+Kta/3Ah5DtceuhWUjOorUYkNRbji@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHOEeAZSRm4PshldC7QyESlDz6b6JcpsgJid9qoKRuugGkCN3
	MdX+hElteovV7X9zqlwMEkH0iERob0+n2/4zZKj4DvAGi7tucrrtjdvGmfapZJGYeER1UDSKvOU
	xs+Fowf+AtC4MeJKSuw==
X-Received: from wmbjr13.prod.google.com ([2002:a05:600c:560d:b0:475:decb:4c4d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f8f:b0:477:b642:9dc9 with SMTP id 5b1f17b1804b1-4805cf672c6mr73201695e9.28.1769432730846;
 Mon, 26 Jan 2026 05:05:30 -0800 (PST)
Date: Mon, 26 Jan 2026 13:05:16 +0000
In-Reply-To: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1464; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=LUQ8/ci9izP5J9/4y+2ltP+4wEzDDnOt0Trjo5chvYo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpd2aVtIXd8lRq79A4IpzR63g6UepxqP3aP882H
 LHek6E8d/KJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaXdmlQAKCRAEWL7uWMY5
 Rgj7D/9tTA8NIpQVPOoBpUOfXvxyJh7I9QqsPbk2lhfUJ91ylb4nQV11NUnJK+HIj5SflIxE7BF
 mYJngykVKsX7zuV50ZnIjT9IxkkCrrROw4lZxAHaBqt5Q8G6tQqfcH3z6106ZZNDbaGwrGK3Gtk
 cn48veOg7BNZbVACSBoznv1R7o++CfAiX9Zt7mWz7UdG1yaw8fdCXQkf4Fvh0Z63ocZ7lnt8Zag
 m8D0pmiQeqUCEggRpao5HxxEl+D0tg1vvLFti7/x8PrvyWG67qcyvhcRVpq6G9EbSLhYRUqJ+4u
 OBzvQYUSiHqaWQBMiyGB4GrxkDTY9f1FAnWQkUi9CtxbsHvbfN+IZ5DsTKHolhw21VOSCtZQMAr
 3Ku6iXNp8qEypBEWEKUJ29NEBSIjkq5EMlV6sjnyu3hzkuwEH52lRaD/b7RZjdhv9RP1Q5e6ZY+
 s6ZQq7/PhL1+egs84UXI+Mu8mdRrfsEJwWA35dX3uyf/Zfvbg0kQ8UuuSECJKXDgTLOq+WreF5b
 P179o69MSYJyGdQE5mNYWnlvKvl0RxTAly0LSMqlE8aV9W59ySJwyxwjT0lr0Y+pyeyddlkDYlU
 OQNk6DBi7IyrpFDrb9nC2wdv6RMMSwph1p9wOG38PmnTs9IxhNLUJTlAaxpszYzxv5xVNm5Xvia ByFjijCPk5RWTFA==
X-Mailer: b4 0.14.2
Message-ID: <20260126-zeroable-ffi-v1-3-0ef101d1ed85@google.com>
Subject: [PATCH 3/4] rust: i2c: import pin_init::zeroed() from ffi
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20618-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4265C8898F
X-Rspamd-Action: no action

The zeroed() helper was re-exported from the ffi crate. As this usage of
zeroed() has nothing to do with pin-init, use the new re-export.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/i2c.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 491e6cc25cf42619ebfd88af731db47efb8db93c..731bacff0990c8b9b2fe8601f07470b68032f3e8 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -46,7 +46,7 @@ impl DeviceId {
     pub const fn new(id: &'static CStr) -> Self {
         let src = id.to_bytes_with_nul();
         build_assert!(src.len() <= Self::I2C_NAME_SIZE, "ID exceeds 20 bytes");
-        let mut i2c: bindings::i2c_device_id = pin_init::zeroed();
+        let mut i2c: bindings::i2c_device_id = ffi::zeroed();
         let mut i = 0;
         while i < src.len() {
             i2c.name[i] = src[i];
@@ -433,7 +433,7 @@ impl I2cBoardInfo {
     pub const fn new(type_: &'static CStr, addr: u16) -> Self {
         let src = type_.to_bytes_with_nul();
         build_assert!(src.len() <= Self::I2C_TYPE_SIZE, "Type exceeds 20 bytes");
-        let mut i2c_board_info: bindings::i2c_board_info = pin_init::zeroed();
+        let mut i2c_board_info: bindings::i2c_board_info = ffi::zeroed();
         let mut i: usize = 0;
         while i < src.len() {
             i2c_board_info.type_[i] = src[i];

-- 
2.52.0.457.g6b5491de43-goog


