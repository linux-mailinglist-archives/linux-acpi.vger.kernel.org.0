Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA947D785
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Dec 2021 20:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbhLVTOd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Dec 2021 14:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbhLVTOc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Dec 2021 14:14:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A22CC061574
        for <linux-acpi@vger.kernel.org>; Wed, 22 Dec 2021 11:14:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d9so6958521wrb.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Dec 2021 11:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EkplSK95bDKaTLjATnzK24WfR1amNRzKPTQ6bpBxUWU=;
        b=wJ0O6g0Su6lKuUQLlrcYmS87eThzM17dE7zlGitj65GOQeE2QpFdXnVoZGbhGarbeN
         QAa2zd/sNoZDHhdtMx1hWRp/oP6WlBaI3blEhODOrUdr6+9VDtBx+aLCvkrADKtcKffN
         PgIXNRz56Pw5ssz4SZeTnih7rSr2XBEEgqmRVlETaJvsktqmkcwoqicHpWsf95Ac+oUB
         uc1C0zF9rxXqw0egy+OBt78/mI8Iewp86jeX0+jlYn3GLLXkpOl7zFXitMUoTXLoUvna
         erCqFHiw1Wohjt8a57p8IgokwY940wpwJXg5165emujcjwt4PudF1zeApABRpm+2qWBx
         9vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EkplSK95bDKaTLjATnzK24WfR1amNRzKPTQ6bpBxUWU=;
        b=ga5S3mpiOFjbv+0y3aXxrABJL4JeQruC891ValDcQ/4xEDqblt4Y0fpicNNWbO5AzM
         3YFz5SEQHNeZgdroSeeOx+iupGAitnST7B6vg2W6svB2Iy6bkMthqO/JeYGbO3s8B+UH
         o8uw3opQtC3D7flS8d/UREmypMVGmj2bp6ax6bnAdRigt9c4kybLJ9ts2pLND7gHRCAm
         dw8N9zeVbMSVjTWnCUinFCCz4SKoKQ2Rf9IqXDgmFYaVmZNNmSyfZW5112KP9JEGa1mD
         TI5CaV/za3qtBnOBY7RxOrSNhtg+MSyt6BU+Nb/XxE3q9spDrnRGza34fDIh5cwpeHFI
         kTcw==
X-Gm-Message-State: AOAM5339d0/WQIDL69o5ZKOAMW1BqWfMYUMttJhx5Ny/SM+1taDIH5xg
        aLK61tC98wLg+yBM/ZOmBRDkoQ==
X-Google-Smtp-Source: ABdhPJyQ5jIxCHtbfMjppNaBywIRDKKryWuFHi/znnznIFbJ61IvUWj87rSqcX51FPDNjw1C6ZLgaQ==
X-Received: by 2002:adf:fd02:: with SMTP id e2mr2952627wrr.139.1640200464719;
        Wed, 22 Dec 2021 11:14:24 -0800 (PST)
Received: from localhost.localdomain (p200300d9970878003dae64a47964a371.dip0.t-ipconnect.de. [2003:d9:9708:7800:3dae:64a4:7964:a371])
        by smtp.googlemail.com with ESMTPSA id s1sm5798360wmh.35.2021.12.22.11.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:14:24 -0800 (PST)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki " <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
Cc:     1vier1@web.de, Manfred Spraul <manfred@colorfullife.com>
Subject: drivers/acpi/processor_thermal.c: avoid cpufreq_get_policy()
Date:   Wed, 22 Dec 2021 20:14:11 +0100
Message-Id: <20211222191411.13805-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

cpu_has_cpufreq() stores a 'struct cpufreq_policy' on the stack.
Unfortunately, with debugging options enabled, the structure can be
larger than 1024 bytes, which causes a compiler warning/error.

(actually observed: 1184 bytes).

Therefore: Switch to cpufreq_cpu_get().

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>

---
 drivers/acpi/processor_thermal.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index a3d34e3f9f94..74210d63f62c 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -53,10 +53,19 @@ static int phys_package_first_cpu(int cpu)
 
 static int cpu_has_cpufreq(unsigned int cpu)
 {
-	struct cpufreq_policy policy;
-	if (!acpi_processor_cpufreq_init || cpufreq_get_policy(&policy, cpu))
+	struct cpufreq_policy *policy;
+	int retval;
+
+	if (!acpi_processor_cpufreq_init)
 		return 0;
-	return 1;
+
+	retval = 0;
+	policy = cpufreq_cpu_get(cpu);
+	if (policy) {
+		cpufreq_cpu_put(policy);
+		retval = 1;
+	}
+	return retval;
 }
 
 static int cpufreq_get_max_state(unsigned int cpu)
-- 
2.33.1

