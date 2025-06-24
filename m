Return-Path: <linux-acpi+bounces-14569-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC400AE705A
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 22:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2898517D15C
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 20:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D4B2E8887;
	Tue, 24 Jun 2025 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cskvL3f6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A12550D3;
	Tue, 24 Jun 2025 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750795858; cv=none; b=iIO+mXWZcll45l0JKchCNpuZHpaPhxqmFzInl0SvbX42tcuJhrkmuSwqm5nW8XnoYN4Ud3s1htkGxP0d6HTaQwpjsSD4mXcGAX4YDqXuOBASJeQBlSg+ZlIP7bW4kwW0eGN03VYbDVchskX4HusTm0dRrhzlpGR1u7X17gGfveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750795858; c=relaxed/simple;
	bh=JlD2kJrgCeZ7ncyAtBQx8f8fxawQsSq8+cjsUKPRDLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AhG5sP4SJIdS1FDkzp2piD6s0dHbEIu6H80drsENtlqaAlHw1Pyr/ihl6NUBoYQ7t3NZwtLBQvu7OGj5QJ065tF8HEFgx5F/suFd1jwLlgnCGCDNHQsyFG9CmEUef0HEabpVFv7+O8HQ4cOf1dO+n/9otqRbPZNODZE0cG6aTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cskvL3f6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so665927f8f.2;
        Tue, 24 Jun 2025 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750795855; x=1751400655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+EJQwxgA1QAPlqaW5RHzy9qtr5q8oppkK//j8Vgygw=;
        b=cskvL3f6LFMM2fnt4V+BA/ETAKf/k2YBuhDEzArgqW+CMZpUFUX08gCyjZ+fODaNGs
         zYPazUwWnAFy+G1dcRGDcouzPwKUSAFvZubguCPMvzVTiewJapovB2+TzqfP1kGg7LI/
         o92iPHrI1SzY8clVvuv0F+IfTpDhciz1fXKarY6i0fiCiQq40LW/kvQ8KZP0z5sdNmpB
         QyYOsO0Kdpp6jWT0j+KIeHaRZ0o6aEG0IDHq08bOoJtgSYVYahFMTv1kBB7Th/M2UHxc
         4HVOl/lwlj/Twfv4vvKe6L7u1SyEojQ7yLFGSGiZsw8owv0tapvg6ntxMCsRsGYK4D4n
         tbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750795855; x=1751400655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+EJQwxgA1QAPlqaW5RHzy9qtr5q8oppkK//j8Vgygw=;
        b=T11mFuf3uKZ3eHOQy6Iy5sOwOF6LkPqXfXmx5JxESNRQKPOM3HdP+8G5FvHpBIDGfr
         hlulwT8K27F2NAh6NwzKLp6EwoCJ9S3f22SfJqUYkxYYNdz6HaU9/QHc8lejgcw0iMo0
         dbj0QBYZR0Gs2M9VMj9L6dZUNvQhsBFkNLT4xA0SWzvXeGIfFpBrYYFg7nEVZIhSKoWT
         PUVhbwdrQhJwltTOE5j+OigALGmDIU/3bwN2OpWte/5L70hUpun34nrg06GztYnThXXg
         89wIRfhF4pMQw2Q+iCm9JCuoMkfLpiawGwPdJ0c34syQXQQ9th+NoSX0V//sw08Vx68h
         yqpA==
X-Forwarded-Encrypted: i=1; AJvYcCVlnaSG++q6iZD32vXatgMWE3MBeOwdxxY7rzBihmWXIsMfyWm3UzbgxLbGeSPAIuiJbjCFSo52Pwq1@vger.kernel.org, AJvYcCXVP5wq7vZARLgJEgR4N1jc0biylhW6UwQi0KE1Vzf/h216mkvKROEBzBkqzLH68qhyR3SxcXQpYkE9NNmF@vger.kernel.org
X-Gm-Message-State: AOJu0YyotBhY6gGx1rydWin4ZBnOIqeiPPFAD3XavbPUBsp4tVFBwFQF
	OiyX2yJ9IUJtsZpRhu0LKRx/VgH2weZDK48cU1+XsmQH52aOMRWRnkVyMESMtn32fyrKeA==
X-Gm-Gg: ASbGncutI8AqgD3PeiJ97GaqWX7RHFAUvFapY1xfEHTRB6Zim0nlRvTnRhqNMsV9+//
	/N5RosaZfNLy10YYlk62OwFDkJWoLVGp1nTaSIg2nc3qIo1nM4wlk/fY+NvKpVCNF6WQ8XkbAdj
	j61UKW5t104Q9FuQvt2s9nDL0RPd38x2AlbaQOgKSWX9Bj3y5odn4rTSiWuAYKfYw8xiLavE4JY
	jsa4cJwwVcGEELR1Grg4oNqlqMNJYqRXfYTaF+ZkpMye3jgIvdgcX4xuuLW0rMZF/E7Z8aYggov
	HD/Ro9ba7v2+reTXYA7nTGwvgbkxrje8VEZP7VNTlIY9tfqXFuCcTG/9iIWj
X-Google-Smtp-Source: AGHT+IFKjM+l9vmEEfDVCAbunK8mHOAF5id7fUaBlCgq+G5ofMcSJEX58QDiC6EEZnpWyYVpvcTOhw==
X-Received: by 2002:a05:6000:42c6:b0:3a5:39be:c926 with SMTP id ffacd0b85a97d-3a6ed6647a5mr34940f8f.32.1750795854799;
        Tue, 24 Jun 2025 13:10:54 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45361461375sm169031595e9.14.2025.06.24.13.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:10:54 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Zaid Alali <zaidal@os.amperecomputing.com>,
	Ira Weiny <ira.weiny@intel.com>,
	linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ACPI: APEI: EINJ: Fix less than zero comparison on a size_t variable
Date: Tue, 24 Jun 2025 21:10:32 +0100
Message-ID: <20250624201032.522168-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The check for c < 0 is always false because variable c is a size_t which
is not a signed type. Fix this by making c a ssize_t.

Fixes: 90711f7bdf76 ("ACPI: APEI: EINJ: Create debugfs files to enter device id and syndrome")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/acpi/apei/einj-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index d6d7e36e3647..7930acd1d3f3 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -909,7 +909,7 @@ static ssize_t u128_write(struct file *f, const char __user *buf, size_t count,
 	u8 tmp[COMPONENT_LEN];
 	char byte[3] = {};
 	char *s, *e;
-	size_t c;
+	ssize_t c;
 	long val;
 	int i;
 
-- 
2.50.0


