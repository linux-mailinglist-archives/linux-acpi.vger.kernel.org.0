Return-Path: <linux-acpi+bounces-13910-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F3DAC47D8
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 07:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F921898E92
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 05:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70F51E0B62;
	Tue, 27 May 2025 05:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQMrMWvx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2744A33
	for <linux-acpi@vger.kernel.org>; Tue, 27 May 2025 05:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748325251; cv=none; b=nsg40I/VbvSraT0eqaBiKvvUQE/JUPmUwkBwhHkGenAHc6Dqg/oljtI9OOCK2Nakke/wPWgWVPlgQ6plBMnn6R/PQNe0y+eUoQAe2zdMHf46fwKYTRYYT2gJRyGdESWmg7nuzF/TkCJ4EYXI8gHdQpzVGVgbjm0g2EJ4gpS4ETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748325251; c=relaxed/simple;
	bh=HjTMatqeqVA60Vr2vbz4oeS4Caye/UgdIEnm2hUQ/Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JdUZ1cAe9wVGHTq0KIVkcjsZBuZc8LTbNO/liJBnHrYjD5GY5Fpezjs4AYKA5bWSN4bAr1XHjrSAPsIXuSutt3aG0A2RqWXtSi3TAEzYo50ts1cC+MiA8hGKv0meoQNKMpmtzD1xiFjULh0fYr2dc1IWWgglZwXpCNVumCLlDt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQMrMWvx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac34257295dso583281166b.2
        for <linux-acpi@vger.kernel.org>; Mon, 26 May 2025 22:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748325248; x=1748930048; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qMBOVGdnQVQ4NSm9o7YnP9x3OdPGFH+Y2T5UF66g6X8=;
        b=RQMrMWvx4fsspDWHyLKJkHMZcDB5yWogw/Wo6jgqUL47r2qJj/zmYDrhqm7seVX/nP
         3rsXu7PdhmUICkx+WKJT1R0Cm1ZzLzNI6uqBMm6S0GmAjqpU2/yHWnND6YD0XgiFAZjz
         2zvdR+CF9NS7wxNUU1Nf4ZPQfAQ43Qbno68xXVzZyxjnbFhFiVtUB6e4QWLCBvTelmcv
         2Q3HrMl2a0de5WZrKo28y+3Xi3JpsNvQCln/PNIYwlTKWvdi7Ku7fjJasGOEU6ZsBTzJ
         MXoqcgI5Pr8wmc7XRrAtJ7VRR1aDmR2x8NyK5L/vyuGhqmSq+mLaxEPmJqSc2qPKG0IE
         /ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748325248; x=1748930048;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMBOVGdnQVQ4NSm9o7YnP9x3OdPGFH+Y2T5UF66g6X8=;
        b=C7UnkqBEvGxoTO5zNEqOzrmQIBnsNGfZxcb/0sX5hUACyBmqPu26cEiZR2TC1RPksY
         Ww/F9y894WyBEFEAF3dJVUHjVZy7YWrfznyShGViELIsnE7nV/j8cVLuDoGLMHO67XRm
         6q3tcKOk1gaq5xYZgIV3RNUHVx4ZygEuWohj30hFOKEevzrW9QpN/s6w6UOAg6eR/pTk
         9yv1dA9i0V/1A2+MZE7B7PLx+nb8/0SMVJc/C5KDlasM5s1QmQyYRlE24bCNuMm/6HJh
         EONOYp+oekdtO87dHpGrO1mbQ9umuPMuxNI/SYQidwPnNuGU5/E7JSLCWwrQao0Jn7mx
         hNNw==
X-Forwarded-Encrypted: i=1; AJvYcCVDJjwkHqrydwO1fWHyFxay8z/J7cY6d2YjEWl7vsVqgEs8gxxNQwsxuDnhtISaPldxpwMvTdYpek2j@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgehHzp+DBVVV/jOSJLtxx66brwEPZhx+onmbYjupjNISJpCe
	LI5nj6T/orG6Bt/NOeU47h4tFAOh6e8uQpGdn2jnXtZlEeCoEf0nu+QIHk5tkjciOnfzvP3/pCY
	WcSUe
X-Gm-Gg: ASbGncsNAceEM4Ps0VgGiW+qhpdvJ4rKyIZiftAGhsSyy4WoVGxvbpU9r9zuOIXwhtk
	FiPFnoPT7rRAb/zcrTR6s9yLTxxoWiVj2UQYdmx7deVkPeCX+xtbS2Grp7Mp5fWbrR2+ioNgGjT
	sV+YvrwYfObII1FrdcIRck6T+xA4rPEhIzUEZTcN3cdvEdS00Q2QPxelTGg+JHMQtnWnW/7drVP
	enIK3BZOfQuLORy4IGcrA0ejyKd6jWBkZcYleTv170IkNG08/Jb/DIop+QVCOxPPPMVXDFn0p3K
	8ovmmkZ8OvUUuCd85R0SHB9ba1DA9Va/FAyUXwNb7ofVbE+fjZ8vjHbVPL3ptzrx3uhlQi25BCo
	=
X-Google-Smtp-Source: AGHT+IG2ab0KIO3Z5oiiNuKbor1U3QysoZKdFmQOlEh6I2uRnGXcGTV467zCuDRfsK2qo6oElSKgYQ==
X-Received: by 2002:a17:907:7f17:b0:ad5:2137:cc9e with SMTP id a640c23a62f3a-ad85b120246mr1089746866b.3.1748325248139;
        Mon, 26 May 2025 22:54:08 -0700 (PDT)
Received: from localhost (hf94.n1.ips.mtn.co.ug. [41.210.143.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad8816eb7e3sm171917466b.50.2025.05.26.22.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 22:54:07 -0700 (PDT)
Date: Tue, 27 May 2025 08:54:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] ACPI: MRRM: Silence error code static checker warning
Message-ID: <aDVTfEm-Jch7FuHG@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The error code is not set correctly on if kasprintf() fails.  On the
first iteration it would return -EINVAL and subsequent iterations
would return success.  Set it to -ENOMEM.

In real life, this allocation will not fail and if it did the system
will not boot so this change is mostly to silence static checker warnings
more than anything else.

Fixes: 04f53540f791 ("ACPI: MRRM: Add /sys files to describe memory ranges")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/acpi/acpi_mrrm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
index 2f22f013959a..70088cdfde13 100644
--- a/drivers/acpi/acpi_mrrm.c
+++ b/drivers/acpi/acpi_mrrm.c
@@ -156,8 +156,10 @@ static __init int add_boot_memory_ranges(void)
 
 	for (int i = 0; i < mrrm_mem_entry_num; i++) {
 		name = kasprintf(GFP_KERNEL, "range%d", i);
-		if (!name)
+		if (!name) {
+			ret = -ENOMEM;
 			break;
+		}
 
 		kobj = kobject_create_and_add(name, pkobj);
 
-- 
2.47.2


