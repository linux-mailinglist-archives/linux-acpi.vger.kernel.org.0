Return-Path: <linux-acpi+bounces-14485-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3C6AE1F29
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 17:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD830188D7E7
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 15:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1F52D4B52;
	Fri, 20 Jun 2025 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ9yPT19"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F819A297;
	Fri, 20 Jun 2025 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434210; cv=none; b=J4qGb6FqkvoFB76s1GvD7uf0/23BTrWqHDA0JXNF/YHs9P/7sg8nZjXjKfNzsjglEijz6DIkg+gLJPNo9RrmgluAN8jmdAFgKCNlHNQTJuZN+EXNi92zMOQHTOwyEfS7lIHSW7pD1kAow85Uy5uZd7D+z1p6cbopALoP26twXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434210; c=relaxed/simple;
	bh=X3GP0rFGQWYb7D9EofmWO4CkjJb3nRBnJ4sS25K5GGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsvrXsMgjr8CBMvONC3q+f7/Ah/0b9esLnj5vrOufTKWlVO/Z0XPY+gKz4Lfuu3QmaDVivXfgjrzvARkai9eeoItDYcJEA/42IKuVEUA6EDwPOYDZmlUUNJzbwy+0uNiGslozDlnEz7J6KNc6osyUS5AMrV0s3nVYd8mojHHdNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ9yPT19; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cf214200so19174985e9.1;
        Fri, 20 Jun 2025 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750434207; x=1751039007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/r6nOkep5bcePWw/OmX8epaR10E2HZMsLJvTHOobc0=;
        b=kJ9yPT19DCAwz1Ppqhgt5E5EPfhcTcUdsmqKqdNDGwUvwO0G70TeIRWsJMZlNOZgKn
         x7ysjeBDWtEgon9dxyfjhA2WZdYV3W14KjHw/G1iE6tj0Ugf8FKkurB0tjoLAz7PQfHR
         B8QJ0x2uS0XGmXhCXuYZed0bghvCYigKUvDQMdCVXrDBym4BBajVHTenScGdcOpsOH+d
         ZFLIK3CxBXjo3wys4GqaKtr6AA6A24MTcKSGJtHJxF6tSCmqkApOeB4iLr95U2Wucz8/
         Mqd6vZbJOP511sryiTNQ+dh0eWxZyIM9pEUJyzEgJf4XDKEa82xaSYHmCxHTAVFa37WT
         c3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434207; x=1751039007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X/r6nOkep5bcePWw/OmX8epaR10E2HZMsLJvTHOobc0=;
        b=jzW6BsUab7sm+GTy1z1oZU+kDaEsPmK/Tk14dsDKgx33BUbGvQ/vWk/a7lPOC40eRq
         V93GGmqU9cyjNAA/CY6NvKFFAMqTimOH0V+/dH8SC757hAzo1kdo3sBRDttNMjTHQQnh
         HE6izru26hT+v2tkbPnTG0NQVAP2CqO8aIuWN1Mr1VlZ3ClvvRG94cyZOokQJJpqNr/v
         qpvvBw50yVOBGxim8CDQCRCyxu6HctKfKIaQM7q3TRRDr1aXZ+QnwrtwciSkXNhL9eea
         pHWa4CLDA6TvicxihU15IYeeGWFHglnsQ8PdSSL3Mgi/4cFWPNkiiLM+Y5t17SSDhcqj
         wQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+siVY5SgCFWcxqvWRvdxa57R9pA8x6CzYuxAPVEEJYYMBpFuCdnt/sXsAf3r1FlwUBb8B+GWlbW6HCQ==@vger.kernel.org, AJvYcCUOQSeNRqib2Qafr27DCONOsoHVq5PEdUCjTON+8H4JXPiI7TgnINZYlNE+6YVDBpPe77ZEXKGnqD9HbhMF@vger.kernel.org, AJvYcCUcE1FhQxPLYD7e8cyzZySxGyms15ycSi/x8DmpilstWZw8JCrzmd1qM/PaVUnSGXacdYw6jqoNLDXH@vger.kernel.org, AJvYcCX4mv0tS8iaCrBBR7cak8ecNwc/6IJqoZoMXZQrVG1Rvn3Ly5gW3iP/dx6HvYxb0cCgbcbzroG2u1P2SRYrwjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygE+fghR/FtOXGKPukRf2wYOW3Zg6z+1og7wGeO98ccodEU5Oj
	lGjqUYVRl9KdvX6DFnC+YM2mSgNragH+fx+Gwzh715jNnRytSzFcbfQA
X-Gm-Gg: ASbGncuPKjDaPf3kRQNglcfl+UUkIkIiaFH9qtQhs4AwlZgWvG/XkgSay+Iqm2SnQoH
	hIP+ZY3ZOl+Dbut2sKPFjVHs0ojaK+rkHwS0af9jw2YE+HQfZMkz6ALJl6u5bmgw6GitL4C8+cR
	4ZgeRJV+SbDNcM2nE4TwHwlbzmt+Mj5v3iowfaSorY4S2CE+vp9JJgIRxMKzmsOopaMLvfZu7eD
	h+rPSVHo2/qx02qKltxq7KwLuJonzVYPooPBnZTkCjny4cYdS/MdOBhfGz3jlbgOQBaDK5eCq2D
	p+Ezn2MFe7O5D3DvbV5zyvQLrlNPJWWBY5T8yP0uacyigMpsum4bf2l7i1YmaXxYasKH2a2Jz+9
	Nh/WkFNbroWs9kpVzNFnUzrxOrRrBgROJOFPO
X-Google-Smtp-Source: AGHT+IGOay+Dgmk/mALjZ37btoxDkdcv0+KYLeDqi25xqCLtwnCwdg8q4gUaX5ZM7cMj3xDEX0s+IA==
X-Received: by 2002:a05:600c:3b8d:b0:44a:b7a3:b95f with SMTP id 5b1f17b1804b1-453659f82abmr28801445e9.25.1750434207082;
        Fri, 20 Jun 2025 08:43:27 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb672sm29603795e9.6.2025.06.20.08.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:43:26 -0700 (PDT)
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
Subject: [PATCH v8 7/9] rust: platform: Set `OF_ID_TABLE` default to `None` in `Driver` trait
Date: Fri, 20 Jun 2025 16:41:24 +0100
Message-ID: <20250620154124.297158-1-igor.korotin.linux@gmail.com>
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


