Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 910666F736
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2019 04:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfGVCgE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 Jul 2019 22:36:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34466 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfGVCgD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Jul 2019 22:36:03 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so70679985iot.1;
        Sun, 21 Jul 2019 19:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmpW1NFzohqIzwtUAGpOMfm6T7OXwekwb4pFafqF9Dc=;
        b=MUC3JA5Xn+yntubO6se2+79QvncgFSj+T2OJH9lublNhM2xcqH47/HgWNnK0hU8KVO
         cfdilWLHQa1IjPcodBoN4GNSo2oAuAgAsjrMN1G7E8sCKA1OnvKJAh0Ha78i0Xeq1bS6
         AWzNXmimdYJMjuPWb7TaxkOnIDJmSEoZ36LZFjyVPkBFWUsKShRBxmg03d1pl/k4Cgmu
         bc5hs6YjiXFbVLThIIrMas5ItGr+qjhO1Z2NycCJmV2+vhNLHbSlzubD9/nrI4pgE8GC
         /tEBFH2Wu0W2F/vgsBkdqN0crqKbWkxTwwxeo73SZAkG0a9LbJaNPMjNtXd9ca58djqL
         c2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmpW1NFzohqIzwtUAGpOMfm6T7OXwekwb4pFafqF9Dc=;
        b=TqGgssxnh4H+u4H24YRtTX3qVxIM9GbXOfIc+DJ1u1yzAbULTQ6hpvwshPQ2bgxZFw
         1LBIWdxJTzaMTUcRHDAvKDE4YIQQQhjbjZBUkeS6ibO3fYHSueVmBjWkIN6TcqIOHofB
         NqVxYr9TghGFBH9lubnOuyT4TY0PgI5nHgMQaz4Xys3M16Rn23B/Z0tfXq7Fg10mDmYL
         l7UkJ3cloAvrIIgEzaiPB0WWmzEIRsIXm41THxR9FLmTkhny2bp55cGwDxL+s72c7NU+
         JqiCC9fM8zKd0zRCI11yTd9F7yP6pCx+p6Bh6eL/h2o6pDN2E9ydg4b6S9jJrvSSv9lW
         /xog==
X-Gm-Message-State: APjAAAWJHPh6u23BxIuZ3Ti8nfh3Hv1vqOurEGt1E13tsnzGqXpQKgpm
        1DDru95mtjFgeimIjjyfLWI=
X-Google-Smtp-Source: APXvYqwnw3FMQ08BVeB4mj8eeIiN/GmPetIS9K9cN7C9AvU/2eCuzbTYxkCEvWxQEkZRROch/r3Wcw==
X-Received: by 2002:a6b:f906:: with SMTP id j6mr62115959iog.26.1563762962179;
        Sun, 21 Jul 2019 19:36:02 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id e188sm32816577ioa.3.2019.07.21.19.36.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 19:36:01 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, bjorn@helgaas.com,
        skunberg.kelsey@gmail.com
Subject: [PATCH 1/3] ACPI: Remove acpi_has_method() call from acpi_adxl.c
Date:   Sun, 21 Jul 2019 20:35:28 -0600
Message-Id: <20190722023530.67676-2-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722023530.67676-1-skunberg.kelsey@gmail.com>
References: <20190722023530.67676-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_check_dsm() will already return an error if the DSM method does not
exist. Checking if the DSM method exists before the acpi_check_dsm() call
is not needed. Remove acpi_has_method() call to avoid additional work.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/acpi/acpi_adxl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/acpi/acpi_adxl.c b/drivers/acpi/acpi_adxl.c
index 13c8f7b50c46..89aac15663fd 100644
--- a/drivers/acpi/acpi_adxl.c
+++ b/drivers/acpi/acpi_adxl.c
@@ -148,11 +148,6 @@ static int __init adxl_init(void)
 		return -ENODEV;
 	}
 
-	if (!acpi_has_method(handle, "_DSM")) {
-		pr_info("No DSM method\n");
-		return -ENODEV;
-	}
-
 	if (!acpi_check_dsm(handle, &adxl_guid, ADXL_REVISION,
 			    ADXL_IDX_GET_ADDR_PARAMS |
 			    ADXL_IDX_FORWARD_TRANSLATE)) {
-- 
2.20.1

