Return-Path: <linux-acpi+bounces-15035-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCF8AF9FC2
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jul 2025 13:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D77C484F5E
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jul 2025 11:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F766232392;
	Sat,  5 Jul 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN3Mgdir"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4159202963;
	Sat,  5 Jul 2025 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751713224; cv=none; b=WrAa8KO/XD7siubtn7Shi3++TtTOv1u4YkJdtTIddJH2Tdg2zRNNdetgO1weDvoArVm25aQ4X/8fbrVYNSlJHfm+fKPW46qy8flar8qiELVLL9I+Vq5IgM8fY2f4GEMCGXXsUiH+KrujNPVcB0ssg34Bz4R10O4W2WjDVOFSlHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751713224; c=relaxed/simple;
	bh=PhJ7xifvGwlfl3vBrMr1d1BsGsIO7YJMzaUUzb1+gD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryY10XvlURaWdcMEvEBN9XSfWkezfwvb+GlC8lhqfjGFuaf2Nknq9Oww8dHNy5aFD25YJiJMlNky767XtvoZkRivagmoZaZalplfkPUDIVJ7Au59bajAu2t+cld0RfqqzqH+Hugzqh2XBlWCsqYuUF0807Tf9fksynFsvsOjhpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mN3Mgdir; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2366e5e4dbaso20181255ad.1;
        Sat, 05 Jul 2025 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751713222; x=1752318022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJJOWWdh9uZnHbAYfBEqrlavQEuvplzcNBnHDL/vwCE=;
        b=mN3MgdirhpDz+VvNylntrpVcaFppvucLB1fonDzJCF5xDvyOYmc230rQPqQjOtKtkz
         hqpQgs/7lUrLR3W5eNeOng74YsbpGHylvFQsQAs5ZNYKcvb9bP6CrDbxzp+QLg10rW4B
         oeytTazUXb93IFOUE1deZKLRtfeWdxyWTfVPuzo7N59QpRBvxtRb6Zot2fyr/PHg74jM
         yMiTAYaAabLaxlbmo5omYJE4HCYnE1ISdgC9dYrLqH6/BR2UeA7cDvmiCBhBT13Gn/+1
         v5CUUFVLtAA2iM19Ljxzxww6e+YYDKwUu9QWCQiz9hBhgYNd6nd+zNuB4Ec33ZvxgEeA
         6f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751713222; x=1752318022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJJOWWdh9uZnHbAYfBEqrlavQEuvplzcNBnHDL/vwCE=;
        b=kI7kaHFvr1eHa8xOf4I3T7ciNQmQwO9GCrsGbDdhaYXgb8w3uthokw+Tbb+kvd1wx9
         NzvQScOi4McSY9Fc6wZtDjIKfcl3gJmvuB2yZy9jpNplpLlZ+wdwinab7ML63w5Xwxn0
         Emr7BnXbNds1I63XybYEeyJ9oBuHlf8NIKpOb5Bq5Ic/alUyX2eL9JS9lH3FhctE7gSO
         5qiIiue/m/mszIjMt9Uhh9wPSEpppt+gZ7MG5peQGnrAHtyN8abLD25HJoW5B1O3+TBm
         eB0eM2MDI1gnTVpHeRi7+GppmtU+9OJNWLu5/SzxKLRZwBLKLuE4aU4WcBHsAoYEeVpo
         Oskg==
X-Forwarded-Encrypted: i=1; AJvYcCU5yxQq3QNMgSISLUAbd/PqB7mOV59gGIr5hmIt/wnG9ITEH53cC8upj01vmeCu5brA0hBg+/q4cEHFkbu8@vger.kernel.org, AJvYcCXM7LfM/p2kotF3d/lURpFMiNlU/QUWwrmyNGIXpDQR+rNtpnS6iFatML6kBEjP9m/Vtgd3onNu8gr8@vger.kernel.org, AJvYcCXZUGq8o46YybnCFaHzE023QG3qJQIugL6k/4Mgxp7HKrJPZCx2lR7S9+jO2uZFYQy7B6oxT0IaTGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjtUqt98WarghdgysOaIGVDjCFCTcdYuCIEf63ZdqKe8Idddud
	TA3Y6MwAZ6W5lxkUwqrL5vhTuYjZ2L85qqQU5OJgbr4Xaa+t1x9ptW8y
X-Gm-Gg: ASbGnctirEa1nMKjUSkSR3WD9SMr79UY1u1b3uBYZ55ep9wSsPAYu7O8QYgz1Obe4eb
	k8eCa2OCQUsB43NKQlA3II09CUUWZPbJGqctNFLwc/PQNrka4Muu+iWlyJb9e9CnUyWJGtAMhYn
	Ieh8DRCq7S0S4GF/FkxQyk/boy5jUYQ0KKxAOyvW27MPbrePh/RQdlErC6KbT2D+32sB+YD790/
	qTovs5/YxuRkdZqMnMSA+ms//L5SKCx710zx8stJFRqBbzSg9MmcbO8LxpfbTZ67h2Dq3Tds5bh
	yz71FhiOxug62IPbrsMhP1wyzxze8apAhCyG401MCwVufcXBmjplnAqGa6CHvm0vctMXTk3+Wck
	=
X-Google-Smtp-Source: AGHT+IFefKyecOlU2VVIFgv+3yo9eBrl3L8U9dVaBYx+PWbl93ednYY5vCqD1gtXONj+GhaDMCvoZw==
X-Received: by 2002:a17:903:2292:b0:234:595d:a58e with SMTP id d9443c01a7336-23c84cb8097mr94871205ad.25.1751713222026;
        Sat, 05 Jul 2025 04:00:22 -0700 (PDT)
Received: from gmail.com ([2402:e280:3e9b:22f:dc74:2454:9fa:b447])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eea0sm40303985ad.137.2025.07.05.04.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 04:00:21 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	linux-acpi@vger.kernel.org
Cc: lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH v2] ACPI: FAN: Update fps count debug print
Date: Sat,  5 Jul 2025 16:30:04 +0530
Message-ID: <20250705110005.4343-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update invalid control value returned debug print with
appropriate message as no matching fps control value
for checking fan fps count condition.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
v1->v2: Addressed review comment received from Rafael Wysocki
        to update the debug message appropriately.
---
 drivers/acpi/fan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 8ad12ad3aaaf..095502086b41 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -102,7 +102,7 @@ static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
 			break;
 	}
 	if (i == fan->fps_count) {
-		dev_dbg(&device->dev, "Invalid control value returned\n");
+		dev_dbg(&device->dev, "No matching fps control value\n");
 		return -EINVAL;
 	}
 
-- 
2.43.0


