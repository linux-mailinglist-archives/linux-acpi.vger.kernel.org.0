Return-Path: <linux-acpi+bounces-14628-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3963DAE8D40
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6792C4A7147
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603392DCBF9;
	Wed, 25 Jun 2025 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHHjHwSr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93587285C9E
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877878; cv=none; b=JMeARSF0osYC3hnl3LQqnHAlhFXyiCN6X47e6lelfHKXqUqEysU2BXyAfwhXBCOJjE6UaqeN8iJ7HiacIvNenCNMLTs5xe5k+6ke2NifPJk3wv+vDIf1a31V9rd298XcS/DHakSaCg5f8w+s+gdBQ2kf5Yk6gxuWEhnKjtqh0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877878; c=relaxed/simple;
	bh=H1nIbQ51LzP26r3FyzLrx1fsskjj5Fl+oqqOWgYj5qY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HZ7D3+86nZnNPJWlzhzNcf+sB1RmN61Eveq6VgQKJjHvHuN8pctaWx6P1C+mD0nU4m3zKXMG7Kbydg31uYPUqfR4b3OIGCJPtTDQSPwR58ir5gjl1SBBHY0JcI5wnKx897Xt6f5cPupalYWWJPN4Y1kSD/6wye3O8CqflEMAGWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HHHjHwSr; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-73884ccffcbso58312a34.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750877874; x=1751482674; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idFC2oFkGWkgRu1swz+9drrbnHgsETd3u3GhQHpoMnk=;
        b=HHHjHwSrydboVMDa2KX79ePXIg1CVsDYFiCuZoLTLipxPVDK1F/H6ny62Ygv6tAFoN
         NVndEogNM3uQeHw8P+g5t/M8X22wgaAoGEqsljiRth4kOXywyL6YBgL/27mffnC2CewE
         aQEvQwG7gLqrvrhN2xm8BW7pnKFEZg0e7zLcSw22HGEuerzJhVuLAw6oYq9Jr+cekQBE
         BnluKFVBqLP3P2++GgAXK/AT27XEqxkXCCiyhlzHfGvzJ8gaL2zYdmkc/7DRf4VwRKxC
         OmeUVRek9IYbBBpefc4jO9IcHKAQinVXA5+xbE6ximX6SHpK/Y+lIZw+mBk5bIQfD0Lb
         HkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750877874; x=1751482674;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idFC2oFkGWkgRu1swz+9drrbnHgsETd3u3GhQHpoMnk=;
        b=dveOeSKYna2B20079RNxUkQ7OJQ8EZK0funWMzEyxo/d5BlttiUVDekO6wUpyX8wjz
         NWekJRWcBNfDk/OQCWCJ63vJsgvFxG55QcIFj9Z349r68svmFNRFKIXvFCDqtk654PHX
         pRuRtw/NOen2wFRgXpwwrofwvrGr4dG0L6pBnBF6R6VlLkBf+ZG4TESTduamJMhdXAUc
         n29aH5Y4ACq1q1FYUzoFFnJszZa8+duq8w4g+zUgPcMD5ztMjWhr12WHVY6+P4F53gB4
         d0i3VtYus09y8zfTuP2HKlMQlmyUiv5RGC0lMk+YyxRxfVdRnlFeOO7tVhxHKUDoJwVz
         Wyxw==
X-Forwarded-Encrypted: i=1; AJvYcCUhbtkarOdRgklpntgTHiIoymAMyjKh0yKLp77vOE1ibuG10tUXKVzUxxx7m+ywSUh3PmHfckWmNOcZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzoNrZ96w/kYuTEsjYCoOs6U135eoUs+pgc2lK+aKfObEZnJ6r7
	onyGRrDtaw4CQt5M9v6cr6yZR+xBEMv6bPU9NajbixKwLGQII04Qcz0OOeaUrE1+FYI=
X-Gm-Gg: ASbGncuikzIG3TCBMgE1Wu1kuiUwnG2QHAvwyhjgFTH6PO+Rw1RPB00O0t+w9b+HZlX
	QfqojnPgsezhfAA6V8tRwZJIKpwq9fIsoI3/PrQwqGsHKa2XhrFotce/jPOxm83KX1bvUsGGWQI
	DlKjEjtJDk9OwXw6NUqsYHwMlizRONma1DPB+kqslFI8ny4OTdo24Mh7yYmFLnowU33j4lSq4qe
	UFOD8ufQUBHcuqQlp+y03zjMOUG0RhB9k0mW+gX5H9EguGOZaguJOUKlfYvAbb1RlOiygmwpkFE
	RDY8+oyMKjlMeuCyynHtC4cvKthtpn6SavkkXbjJos/ZL3/47Kcg5EAkA8mkx16sKiDZjw==
X-Google-Smtp-Source: AGHT+IFULxSdU/YC3cPv8TMpcR9HigBXOMNkhwUT8MmP1kJ8gCSc2YxGcMd40BPtiHnFyyub103kRA==
X-Received: by 2002:a05:6830:61c4:b0:72b:aa94:6d26 with SMTP id 46e09a7af769-73adc6fa96amr2404587a34.18.1750877874602;
        Wed, 25 Jun 2025 11:57:54 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73a90cc0257sm2284326a34.60.2025.06.25.11.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:57:54 -0700 (PDT)
Date: Wed, 25 Jun 2025 13:57:52 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jon Hunter <jonathanh@nvidia.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] ACPI: APEI: EINJ: prevent memory corruption in
 error_type_set()
Message-ID: <ae6286cf-4d73-4b97-8c0f-0782a65b8f51@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "einj_buf" buffer is 32 chars.  If "count" is larger than that it
results in memory corruption.  Cap it at 31 so that we leave the last
character as a NUL terminator.  By the way, the highest reasonable value
for "count" is 24.

Fixes: 0c6176e1e186 ("ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v3: Style improvements.  Add a comment.
v2: I introduces a bug in v1 because I put parentheses in the wrong place.

 drivers/acpi/apei/einj-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index d6d7e36e3647..f5cfa6310f0e 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -826,6 +826,10 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
 	int rc;
 	u64 val;
 
+	/* Leave the last character for the NUL terminator */
+	if (count > sizeof(einj_buf) - 1)
+		return -EINVAL;
+
 	memset(einj_buf, 0, sizeof(einj_buf));
 	if (copy_from_user(einj_buf, buf, count))
 		return -EFAULT;
-- 
2.47.2


