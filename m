Return-Path: <linux-acpi+bounces-20617-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAlYJ6Fmd2nCfQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20617-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:05:37 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA6F8891D
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68A7930066A9
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA37C338584;
	Mon, 26 Jan 2026 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1fsj6QA/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAA338594
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432732; cv=none; b=lK+F6mK5JrVNwLIQxizc689ZB6Zd4cVh8L4eiwKMYiNlF7GmOhoNABgIYUX0cmBrFvN8s/L/3ROSmqtz4MurQBfeL37jNiBkvlbxYkeVFDDBxNk5tUclzRvrxgpXd0YUVhjbYK4/fUpsDI8whZ9BKr+GlQwQbaUWfsB8d99KsHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432732; c=relaxed/simple;
	bh=quWSaogirGvSyGU+eYcO01e5dALGwdCFt63QGZ45xEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JSz+q3gR9K5JTcjnuzEtg1rEF1DOh8DZD1exWXs2bmqJBEUNpxj6OljdBQfDZNJrwM6pmlUyvAFdk1sSVM6Gnnj6gbtDiRM9ZVJme2gKvhWyi+SluUQ3ZyxfVREEsaA+hRgQfLPpba/hE2cP3qK0SEEH8vdEk7WNm2DXRUcubyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1fsj6QA/; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b8839f45c3aso457575366b.1
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 05:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769432729; x=1770037529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZoKiHDA5dept7gPJfQdDlpAT5f6sSqPf63fb7QenF4=;
        b=1fsj6QA/AThlSVf3LHNvadyzWuWF46MBzkoxwbGAw6tb/3sqiskNir56a4YZE81bZC
         oeXiMCp3ggOJOKpyvhB+/H5wieBlVL89ZUHGNQozd8opy4dkU1jwHYeKnruGYN4uroy7
         cWI8DUPBLV4bKfxurc2izGxs7oAJByV/+HDl/t/Z8jYMiO7Wta+Dyr8ywz3g4qwHti0K
         ZFYKbJPNxF3kfm3M3skjqAhoY/BcljvzBzaTqyHfiUYtIZmwAtxNOsRjAXhnfSkBB6q2
         k+3z/WR5Tj8S/PqY8xqL/jAQ36Hts7mOUTFZ8Mb5QtLotCXWmQvzs6W+meQWR34c3B1r
         B2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769432729; x=1770037529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZoKiHDA5dept7gPJfQdDlpAT5f6sSqPf63fb7QenF4=;
        b=qK4IN7b6L70YumTN0W0YuH5WhyBXQguQEhr8vYwjDTjk8UtQKAk5hnTaX0SxM/itgw
         c5eFfF3S8pdCSXbgN8h+jugmx+cxVautEkI4tV3jajqvPqF2QidTULfdExcrpUg8boc+
         p4exJUnjZa3WqhXC99uuVwh7QT/UlAoj2wHZLoIIWrd1zwAeY7yjMHdQqBWWP94ocYFF
         oto2pRj+z40bIK4WOJaKC9siuB+Du8tT4+OQspcL/wUClwxB+7VXrXxOROZVE5AM4j3O
         8WPfmrnwP7G0VQdkZvD/2PkXIWaER4s8evLviJw3UPQpa3gNxJyMnUuLG1SAvBzSou4e
         cSXA==
X-Forwarded-Encrypted: i=1; AJvYcCX5lDZUgSEsSde++PEj+sjii5edGJiIYobi1hln7LDL9XqxE078a1APDd3sY/JN/HGKffAJaWcLdbiE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy/4AnrQaaqHe4FkuVmaR1zSFrbf8ufJ31pNK9hZIQ4JFt6/xF
	dOtD57A8ktPlT2BEh/DK5k429HoMbljqWbS7yVvcAUdS1OEGhg2RSWYdXvrGL2ZmInP40lqnABh
	Kwu2vunfNNUHkWUbEIw==
X-Received: from ejhn16.prod.google.com ([2002:a17:906:1d10:b0:b88:3e98:7d99])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:d54a:b0:b87:324b:9ae1 with SMTP id a640c23a62f3a-b8d20e44af9mr337635166b.40.1769432729392;
 Mon, 26 Jan 2026 05:05:29 -0800 (PST)
Date: Mon, 26 Jan 2026 13:05:15 +0000
In-Reply-To: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=789; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=quWSaogirGvSyGU+eYcO01e5dALGwdCFt63QGZ45xEw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpd2aVPY91/Wh1b8DTGNqjiDw+6siqYJgl44iNU
 ZJ/YjGRhBWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaXdmlQAKCRAEWL7uWMY5
 RpjZD/9oT5g0w6umhbzjmngZGfdzYK4fSuwfVAdqAFqLNnORfzh2XkXm/FEz81hC6vd3BwC7Tb+
 +FSY7bADLbe9a55VbCs8IwS6nyDvuPsnHZoUNFGZCKH/KiIMmxveCI45pir8U26NetYXBMSNxah
 8FRe92VKvomzJEnAmGYOTHEKgOqA3isyA5HZxEcoGEFyVpl5gXX4vnsqlsoF509WECoqz0hZBrp
 J7vxanApMeZearv6nwBMQllprc2tl/gZ4WvV9Ffpf4cKftKbLR3PGm54JX+i6BJXAiajgGBTHGM
 FVGUGXbjWroqFO0AKq8ycK5/JpgKvvTYXtM5nYt0ndi5EaUhvgXgd/5k2y3/QSyB73ZqGEuCTEL
 ayk6bh7Lda4IMguB6AMjMiSnXkBrKmbtJvuGvD37CcBBkfS8ZwGaPom92S8pISrhbKQetfnSKmY
 gXCe0lIf+tn7tU6gYEJD8GgTBX7PKlcWgDo/5cpjiS8dRP60vNYnQAvh1lG+YKC+uYWDZgRr9hS
 mxpBjKIZZOqcDktqjgjsAGu3s+ekO25F56FjtpyP4ONZwoVKmYn5KbAp7mK09XLnB+Oo4PBGz7e
 4L21Y5HU4/4u5wMlM5/v7yV2h3+Diakzj8s37c3vxu5OPqxnlIF1zRwJY7hKAfAzB2FL7J35/6e jaK2+VtXfs+q8jw==
X-Mailer: b4 0.14.2
Message-ID: <20260126-zeroable-ffi-v1-2-0ef101d1ed85@google.com>
Subject: [PATCH 2/4] rust: cpufreq: import pin_init::zeroed() from ffi
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20617-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BA6F8891D
X-Rspamd-Action: no action

The zeroed() helper was re-exported from the ffi crate. As this usage of
zeroed() has nothing to do with pin-init, use the new re-export.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/cpufreq.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index f968fbd22890546db1758d921e3374359ef9d00b..fadba8e669be33911a30be0254d3d4dcba9f4226 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1012,7 +1012,7 @@ impl<T: Driver> Registration<T> {
         } else {
             None
         },
-        ..pin_init::zeroed()
+        ..ffi::zeroed()
     };
 
     const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {

-- 
2.52.0.457.g6b5491de43-goog


