Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FE327B5A6
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Sep 2020 21:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgI1Tsh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Sep 2020 15:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgI1Tsh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Sep 2020 15:48:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85223C061755;
        Mon, 28 Sep 2020 12:48:36 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g72so2170245qke.8;
        Mon, 28 Sep 2020 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BTNL+zfDw2eRPjMS84+hCnl/S955qQfanNkcVv5LTEs=;
        b=KAiFp8uIfuZP/3hcoex4XODf0/IP3AvxyHpXOE0q682IXBgwTRvCsAvfSaqrp8n0Ik
         4LQNkz8dlKZ7RC/dNuLoqIRkeAm3mDCr+ZxPiLL+4xERbQTaepq1Kl9DYThWZhd2xtuw
         1zj27tMcXGDY4XaxZgtHrQO9x772Ojqw+bKNEud17m/szWM2WNTmojyBlXVFY1pY424t
         alBPdz8oPy99hisWPuGIvIP+cv38ok0gFwVw55fWHNoKQLxxUMRfoANtZoIuEIwmQ3RO
         IGDTtqLy+Bt2ljF+NhQV9zURcHBc7AdW7pddtF4z5QzeouznVreaxjBji1kQW9J4P1Es
         b+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BTNL+zfDw2eRPjMS84+hCnl/S955qQfanNkcVv5LTEs=;
        b=KlJnP/DfvCgns1ARfHvgujiG0OjGDVerpxGrKBj6r3BOdOimVeT6w8BBDc2dS8mXc9
         efU/EqRfqgsPTaLnEZficYD8lwBwaX3rZXoZrNPrLXQ1ZrEDY6NzJWsNn/P92dfrhJWt
         PI2YPYt6crcjhtnvluISnfRCcFhyxHf8Xqrh7aFoK13HKZYWWz3BJDrBUmD5oKnV9E9V
         f9iKBz8SrG6ytiCSYD9zQ4iuH+c2elBAsGJ5L8eu1hkW0G0u1zCAHYl6jhk7T3C5ZiAp
         f8j3ZTYGuiS/buFicOWAgzu5769eQVe6zu9wrYAGllmjbUDF2yaJMZV+OwQ9F6nTIaGD
         Bl/Q==
X-Gm-Message-State: AOAM533d0KOi4ImB3MGDTfZkTLS8PfMCyvLA3mCoOqoqj6jQ18pu1VjJ
        avUTNkEujLpx/qmf1eLXwf8=
X-Google-Smtp-Source: ABdhPJyii5BQnxtJrkXUVz9aLcPGlGbnaZWbGwgiB6mGwzVqqDYzkO0gWDJxDVlOAWxqBpG28Pa48w==
X-Received: by 2002:a37:a187:: with SMTP id k129mr1075526qke.147.1601322515586;
        Mon, 28 Sep 2020 12:48:35 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id w59sm2473353qtd.1.2020.09.28.12.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:48:34 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ACPI / NUMA: Add stub function for pxm_to_node
Date:   Mon, 28 Sep 2020 12:45:55 -0700
Message-Id: <20200928194554.3423466-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After commit 01feba590cd6 ("ACPI: Do not create new NUMA domains from
ACPI static tables that are not SRAT"):

$ scripts/config --file arch/x86/configs/x86_64_defconfig -d NUMA -e ACPI_NFIT

$ make -skj"$(nproc)" distclean defconfig drivers/acpi/nfit/
drivers/acpi/nfit/core.c: In function ‘acpi_nfit_register_region’:
drivers/acpi/nfit/core.c:3010:27: error: implicit declaration of
function ‘pxm_to_node’; did you mean ‘xa_to_node’?
[-Werror=implicit-function-declaration]
 3010 |   ndr_desc->target_node = pxm_to_node(spa->proximity_domain);
      |                           ^~~~~~~~~~~
      |                           xa_to_node
cc1: some warnings being treated as errors
...

Add a stub function like acpi_map_pxm_to_node had so that the build
continues to work.

Fixes: 01feba590cd6 ("ACPI: Do not create new NUMA domains from ACPI static tables that are not SRAT")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

I am not sure if this is the right place or value for this. It looks
like there is going to be another stub function added here, which is
going through -mm:

https://lkml.kernel.org/r/159643094925.4062302.14979872973043772305.stgit@dwillia2-desk3.amr.corp.intel.com

 include/acpi/acpi_numa.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index fdebcfc6c8df..09eb3bc20ff5 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -22,5 +22,10 @@ extern int acpi_numa __initdata;
 extern void bad_srat(void);
 extern int srat_disabled(void);
 
+#else				/* CONFIG_ACPI_NUMA */
+static inline int pxm_to_node(int pxm)
+{
+	return 0;
+}
 #endif				/* CONFIG_ACPI_NUMA */
 #endif				/* __ACP_NUMA_H */

base-commit: eb6335b68ce3fc85a93c4c6cd3bb6bc5ac490efe
-- 
2.28.0

