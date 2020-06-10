Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F551F5903
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jun 2020 18:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgFJQ3o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jun 2020 12:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbgFJQ3o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2020 12:29:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034ACC03E96B
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2020 09:29:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so2415086wmj.0
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2020 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=j5Pct8v3ypV1WZLw0GyvqrOhrFs4NH3t96P5hnyBKhk=;
        b=ZolXlrgAxaP5mpsSlFUEG0mAJKeCcZa7rx4fX8q2QmXYQVuNoUNXL1nnJ+E4IZdw7K
         PoExNRxgvxCoxLIOdSjpDZnLhjwgFvHXpk7izi3epK2BAI6+tEAUHmWKFRoPNEuc4m5Q
         qyvuZj7gVMS8F2JLlQ5Kq6gxRn9e9PqeBvRMIzLIVAa08G95d3yD3O2sSvTW6XgwX4Bj
         nRqy+xCOifd7N6WavxIjQsBjmlpfLVIocb9odMgAy9lYOlIROD4vchbyDscs0DJxbixa
         //IJeOysXjf1vmuW5dv83cHaUNkvAvw5Srwm3TG7gAxaQlPZNuqQDnP8ISQNo4H83Kdj
         wdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=j5Pct8v3ypV1WZLw0GyvqrOhrFs4NH3t96P5hnyBKhk=;
        b=adQJcWfjFtOsqYTQ0CsEZiW5oNsl7DRHH9gf65FhkUhkIy6hJTiuhE9Stuv2QT7IAI
         Dx1eNNLH0YCJRZrlFTT8Q5mfCJiqKbyQkZn5wC57diT5G6WaWj5IdRDaUYZ9Wi9OC0MR
         WtEAySteynSevjtPVWHmqG6xSzhyV9LF8OIEvYVAsc2am7ihHOCF9hy+lwEnXMfLwPnp
         v3YeYgkAQIFt8kE5rYDL6BWdZeOhBjnXPY4cAf10pncfqhJgoVbn9G2T2r+vBbwX6yHk
         rxFBk4AThtXUyaUU5tsQS+Y5ZVHn2GpiopEEeTgjPkabzraYCKBPGQvK6GsqpAagy5Eg
         j7lQ==
X-Gm-Message-State: AOAM5316gh5yhRnuhUUgdqydcArh9xUN5wyY4Ow1tqmXuSZ6daW8akiv
        n79nhDv+QhruZwtBB0CSIpMDdG+BMgw=
X-Google-Smtp-Source: ABdhPJwoo/G2XH1cCJBRy2SRAZnceQcWmv/pHd5QQeAHK5Kh0LByCpUvzm0Ot2mj8ezCymd0evrfww==
X-Received: by 2002:a7b:c090:: with SMTP id r16mr4200287wmh.105.1591806581137;
        Wed, 10 Jun 2020 09:29:41 -0700 (PDT)
Received: from garrit-VirtualBox ([94.31.102.44])
        by smtp.gmail.com with ESMTPSA id 88sm494902wre.45.2020.06.10.09.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:29:40 -0700 (PDT)
Date:   Wed, 10 Jun 2020 18:29:39 +0200
From:   Garrit Franke <garritfranke@gmail.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org
Subject: [PATCH] acpi: apei-base: fix sparse warnings
Message-ID: <20200610162939.GA105986@garrit-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

first off, I must admit that this is my first kernel patch, so I would
love to receive any feedback. I thought that a good way to get started
is to check for minor warnings in drivers, so I went ahead and fixed
two of them:

"drivers/acpi/apei/apei-base.c:290:23: warning: symbol
'apei_resources_all' was not declared. Should it be static?"

"drivers/acpi/apei/apei-base.c:451:5: warning: symbol
'arch_apei_filter_addr' was not declared. Should it be static?"

Thanks for your time,
Garrit

Signed-off-by: Garrit Franke <garritfranke@gmail.com>
---
 drivers/acpi/apei/apei-base.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index e358d0046..321318dcb 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -287,7 +287,7 @@ struct apei_res {
 };
 
 /* Collect all resources requested, to avoid conflict */
-struct apei_resources apei_resources_all = {
+static struct apei_resources apei_resources_all = {
 	.iomem = LIST_HEAD_INIT(apei_resources_all.iomem),
 	.ioport = LIST_HEAD_INIT(apei_resources_all.ioport),
 };
@@ -448,8 +448,9 @@ static int apei_get_nvs_resources(struct apei_resources *resources)
 	return acpi_nvs_for_each_region(apei_get_res_callback, resources);
 }
 
-int (*arch_apei_filter_addr)(int (*func)(__u64 start, __u64 size,
+static int (*arch_apei_filter_addr)(int (*func)(__u64 start, __u64 size,
 				     void *data), void *data);
+
 static int apei_get_arch_resources(struct apei_resources *resources)
 
 {
-- 
2.25.1

