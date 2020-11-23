Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A862C19B8
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Nov 2020 01:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgKXAAB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 19:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgKXAAA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 19:00:00 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809CFC0613CF;
        Mon, 23 Nov 2020 16:00:00 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c66so16594773pfa.4;
        Mon, 23 Nov 2020 16:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcox38vWgLUDdaMTxv7HfS0wKdBiBL9VU/KlvGDv3U0=;
        b=HeEMCdjnNPKhtEBtLIIMu6RxGmuo/I/Ws5Q1QHhxO79eNCoVv+9IqfzoF4eMbOaila
         fd1JspMILxCP2DZIwmXAc+HiLJZMpuypGqRgTXmJbZJjmona070n4KmKY4w2IossjD3c
         0ZH0Mm6Qx0ZHtrHpaDwCz1mRUiICy7eGbELJN8bP/jMwjuCv6A6nTitO89eZwQ5FLqOu
         PUKxRiiLYzNNmakpeEFtC+BrMJnSjX3/0NqERZOM3xBJgRMsml+lbSz9XnVWcKJRjf+P
         hIZFHJK35IcNaXQ1BKWEiyTaTxDbpslKrgfQ89CjAzkkaRrqtpyM6k01rU7W2ZgOaL4Q
         2Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcox38vWgLUDdaMTxv7HfS0wKdBiBL9VU/KlvGDv3U0=;
        b=mUWfvgk0Ka6k+AGT4bK9IxWC/Q9rNgaFMsaPNtC8jFINnNp4sBZRGQhebEa+BlqcWc
         ZK0PaEZcbknttW7Gsb/XbmA3k6ks9gQ5HYVaGTln/4h5hRQ1PwroONAr6+QRGxLd8tfP
         ZJ477Qi4qoPxjYX5Sx5cFWCDd+9BRlbhIC/XH7weqhpHxPC49JgpxCliWXB1vifcLqNJ
         17u41ESfs0uSreyptvA00iqv2q1NDSIbXQVzCyis5GklJc/2ai8JSetOjza4SOUe4nI4
         KZE9ilWOEpNMZvCYCKTDEUFc+PeK+O8MO+x6cXSmCxs6oOIx29ILVlFXtDyHrG3d3tlS
         eXmg==
X-Gm-Message-State: AOAM531U66zntNjglF1F+YJp9c3+aBT2w/wp6d/v1IhNROtnXqEw58Ic
        P8tlUskMNrVQKy83chFPLBrjWOkdQNFu08ez
X-Google-Smtp-Source: ABdhPJzwHYdkmu7ttNffuwOFExo8lpMrHD7sZfIR1TsMFquzWciGkM/lTlK1p4rGhlLh0egwCi9rjA==
X-Received: by 2002:a63:8f1b:: with SMTP id n27mr1545531pgd.74.1606176000058;
        Mon, 23 Nov 2020 16:00:00 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id n72sm12795716pfd.202.2020.11.23.15.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 15:59:59 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Punit Agrawal <punitagrawal@gmail.com>
Subject: [PATCH] ACPI: processor: Drop duplicate setting of shared_cpu_map
Date:   Tue, 24 Nov 2020 08:59:51 +0900
Message-Id: <20201123235951.96243-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

'shared_cpu_map', stored as part of the per-processor
acpi_processor_performance structre, is used to store cpus that share
a performance domain. By definition it contains the owning cpu.

While building the 'shared_cpu_map' it is being set twice - once while
initialising the performance domains and again when matching cpus
belonging to the same domain.

Drop the unnecessary initialisation.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
---
 drivers/acpi/processor_perflib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index b04a68950ff1..b0d320f18163 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -616,7 +616,6 @@ int acpi_processor_preregister_performance(
 			continue;
 
 		pr->performance = per_cpu_ptr(performance, i);
-		cpumask_set_cpu(i, pr->performance->shared_cpu_map);
 		pdomain = &(pr->performance->domain_info);
 		if (acpi_processor_get_psd(pr->handle, pdomain)) {
 			retval = -EINVAL;
-- 
2.29.2

