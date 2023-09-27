Return-Path: <linux-acpi+bounces-193-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 815527B06E5
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 31F68282520
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4571CA88
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:32:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83AD11714
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 12:37:33 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF18E6
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 05:37:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40535597f01so109942375e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695818250; x=1696423050; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lSvSjPBwBbpaP5Mr40QQhbIUu3AL4PWGVIl5zKwP4Ko=;
        b=vqSN7EoAlxbuq316KtnPtrkiBXOGVi80pIVPzAvZgfQJ69/fF/dWZD0qPZUw8XkTg6
         Q2DwZuQPN5gObvrPR04Xf9xuHoexcQkjBjlEe958czpDUNFmxgzjlJwRu7DByWljJA59
         TZy9HdPGoa5Ek//1VeQlbiUwPyuNTw9XysqMIiwmc4HKZDCd8qMG6otb4I4y2MrvAdpZ
         JgkIOq9GODyhXxql8z4tIkrYvxprPU8Q9c3/NTGK+Th6bZAm+FqSMFtg7UmlIWMa5Hpz
         6fPMt4RFYIJgKTI4JdKTOXmO2qIwvmX/pj2j/YmzI4mqsjWo1tc4MbxkkJ344QmFyQGy
         I0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695818250; x=1696423050;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSvSjPBwBbpaP5Mr40QQhbIUu3AL4PWGVIl5zKwP4Ko=;
        b=TJ/dv85jsQvNj5/rv0DIkoptG+t7Xw3QAn6drePLDCPKGiJu3R8hLqivgoZJwUZSLV
         97WAjlFcPSsQQMDtf2uK9iIqxLHZ86heg443wRsPSF0nJKWRE0DaypP5WdesMF4rQHwz
         dQy0VYe17YnZyEdhZrokqJYFHmiY5COaHBcItXxWFAaleHqIK1P3E2oLrXTA/1CV2Cbp
         P7s58wqEo66KGYbASMtF0x1L3q6Didrnj/Qmy4s4nD0xQamq4zbF0YHDPKgg+j4LqEi7
         kH/6D+1mRyVqjR4Eazl6LMlmQ+3TzaF1VwCkk9nQIJlE9i5cSxwy/QhhqL4lwWSyRg5k
         ROog==
X-Gm-Message-State: AOJu0YxIY4d6JoFVmCzhN+PCph6Raii0pFbLQjLJKukx4O++n68x9VXg
	MuBvaR+1y4xPX2t0fIGmAhDtcg==
X-Google-Smtp-Source: AGHT+IGMNwZeZVMjHYbbFlIN0HffM3gIJdpZbL37AcIUk1gPy81JzbFuqU5EaISKNrPJieFYqvUpNQ==
X-Received: by 2002:a05:600c:2308:b0:401:bd2e:49fc with SMTP id 8-20020a05600c230800b00401bd2e49fcmr1921153wmo.24.1695818250434;
        Wed, 27 Sep 2023 05:37:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d49d0000000b0031c5b380291sm17074203wrs.110.2023.09.27.05.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:37:30 -0700 (PDT)
Date: Wed, 27 Sep 2023 15:37:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ACPI: thermal: Fix a small leak in acpi_thermal_add()
Message-ID: <37eb30ba-1dc9-42e7-a22e-af44f6270e67@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Free "tz" if the "trip" allocation fails.

Fixes: 5fc2189f9335 ("ACPI: thermal: Create and populate trip points table earlier")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/acpi/thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 10720a038846..f8a95939c88d 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -928,8 +928,10 @@ static int acpi_thermal_add(struct acpi_device *device)
 	acpi_thermal_guess_offset(tz, crit_temp);
 
 	trip = kcalloc(trip_count, sizeof(*trip), GFP_KERNEL);
-	if (!trip)
-		return -ENOMEM;
+	if (!trip) {
+		result = -ENOMEM;
+		goto free_memory;
+	}
 
 	tz->trip_table = trip;
 
-- 
2.39.2


