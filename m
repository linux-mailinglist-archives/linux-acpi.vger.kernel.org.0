Return-Path: <linux-acpi+bounces-12384-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC6FA6ACF5
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Mar 2025 19:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F2B188EBFE
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Mar 2025 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E27922756A;
	Thu, 20 Mar 2025 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T+tbcdjN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB45022617F
	for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2025 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494445; cv=none; b=WHgarHbzfv8KgUn2w6ib0pitScvrigJpOYyHkghP9GzPJaLpWB/Th0+QsW7QAIzB9YdBLlJ6rJ1q3+utt8xSjif2Yggl2Q/6txzkYnngyZCM8O4m2UCTIu1DVZXCrSQkONK1nmMkDHX6rilqviX/k6hJJhPOn/d4JWF31CPYvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494445; c=relaxed/simple;
	bh=dIq2rFVsMRPfjTTzICdGo2oAsZfoxmPnshpJze5uM1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGmxRQkz80M9yeg/kPjTU/Pu/fF6zF5/6/WPosiRq/oNrGcMHtGeHWvAuYeRCYrk+WgCuBoIaD2pvaMbfs+fAtphCnrn9Ozf7qI5h086T8hiccTJ91LCfnrJCsE/y+26tWx43/QqoXTBqLPYO3wYb6WYudJNE/BmCPVVp5+73f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T+tbcdjN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2243803b776so30624495ad.0
        for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2025 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742494443; x=1743099243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIkGguZ4dnQIKNQIeCLR9up0U6ko09Dl8rkZeShLSI0=;
        b=T+tbcdjNddLmsN3DILHgadqwkuTyfN64mDLQya5sHqvr4Ya2UlcHDtS3/d6mrhl/gq
         d4aeEsNKs3xox9BFp6jDFXwKMbpmmK+1z/GlLFQZHfz0MQm0mpCYUj5k0PQhza/FvwiT
         OCBhtuVyk3Qb6ibBfts3uSZiWgH8H/dpmUQHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742494443; x=1743099243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIkGguZ4dnQIKNQIeCLR9up0U6ko09Dl8rkZeShLSI0=;
        b=FvoPJtdC/ILrs6In9Ud9EZyk0BBw4M4E4v74ZILF1ZSSOHm9LBN2adjKoARZ1G6nZ3
         DXDxgHVgE5SGbAxZA04T2M9ESwof0CBx5zxS9zt3Mcx26vlMeqJUEGJjaPfg7abKrXLh
         eFLS1X87lh1XjQCRmBMHdJgnrWFvtiPLIwnWAENVTMroIovY8Iz8Kprk0F2nJOQuFOdS
         yqldkRTY3FuUDxmBr9mq4hIizlURyH0q/qCXnC84pvE6EWZC9C3YtW/wl4pqbJodMVKF
         iaSKm70vO8KqfmgXZCj5qpZhjyrOmD9SQrP/MJka6ZY8GksEo6wtL4tH75VWqEPGcyIC
         Rl9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhhBvmPHi3RPcgVzW+TF+rAGpSe4/Rltm/0duuqmB7kG3BXGxguh37elyy3eQfSDwj+P9JjDIdAixx@vger.kernel.org
X-Gm-Message-State: AOJu0YyASOh0hvV8erNGCr1bVLlTYxunmC5Eg4G4xYZwkWi5sdPkliiN
	amBUGR/1JoyHoreF184kTG3/nqW7uHRULXuhd1E6fu1MRmOW6p2vyEvhbIPPvA==
X-Gm-Gg: ASbGncu8qayFBdKiBM2ccCsVHGWzWTql9IDwvgokCfPnm0UXUA8lkfZegdn86iivWy9
	0StdBtV8+ae8i8R2BE7usAZDxNvzo8pl4Pzr2rbyxwt1kN4x1XhYWM+uPXg3sOlEFs2VY8+pOxf
	DMBcfj2SH2UMeC8LyaDiNTdLUwLrZtbgG3hRnvXPWRkragSiRr4EmxGX1bROFsDkKwG09zIgBZ9
	pxXjoXtoj38TGmkghd/XfdCr1zifaaKGSd/227ZbIbXe2qFF1u0iMv35AP1AIrkRrCN5KCCJ7hX
	I5+ouGUsIuxdO3uRNBG729YvXbS2QQlM7cu/oBhnTWLldfqrfJ4wS8pqqHmdYKN5OAhF9pHetL5
	LM9UHDlk=
X-Google-Smtp-Source: AGHT+IFKNeA0nv8K4qQWl3UeJBhgwTr+2rWreG0zcMznfH4QEcK/AEsy8WvwIEoY2DqRAuKaZ2Dhgw==
X-Received: by 2002:a05:6a00:3927:b0:736:4644:86ee with SMTP id d2e1a72fcca58-739059d0a99mr743410b3a.14.1742494442872;
        Thu, 20 Mar 2025 11:14:02 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9e6b:24df:389d:f71b])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7390611d580sm98101b3a.119.2025.03.20.11.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 11:14:02 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	lukas@wunner.de,
	mika.westerberg@linux.intel.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v6] PCI: Allow PCI bridges to go to D3Hot on all non-x86
Date: Thu, 20 Mar 2025 11:06:04 -0700
Message-ID: <20250320110604.v6.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Currently, pci_bridge_d3_possible() encodes a variety of decision
factors when deciding whether a given bridge can be put into D3. A
particular one of note is for "recent enough PCIe ports." Per Rafael [0]:

  "There were hardware issues related to PM on x86 platforms predating
   the introduction of Connected Standby in Windows.  For instance,
   programming a port into D3hot by writing to its PMCSR might cause the
   PCIe link behind it to go down and the only way to revive it was to
   power cycle the Root Complex.  And similar."

Thus, this function contains a DMI-based check for post-2015 BIOS.

The above factors (Windows, x86) don't really apply to non-x86 systems,
and also, many such systems don't have BIOS or DMI. However, we'd like
to be able to suspend bridges on non-x86 systems too.

Restrict the "recent enough" check to x86. If we find further
incompatibilities, it probably makes sense to expand on the deny-list
approach (i.e., bridge_d3_blacklist or similar).

Link: https://lore.kernel.org/linux-pci/CAJZ5v0j_6jeMAQ7eFkZBe5Yi+USGzysxAgfemYh=-zq4h5W+Qg@mail.gmail.com/ [0]
Link: https://lore.kernel.org/linux-pci/20240227225442.GA249898@bhelgaas/ [1]
Link: https://lore.kernel.org/linux-pci/20240828210705.GA37859@bhelgaas/ [2]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[Brian: rewrite to !X86 based on Rafael's suggestions]
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Based on prior work by Manivannan Sadhasivam that was part of a bigger
series that stalled:

[PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all Devicetree based platforms
https://lore.kernel.org/linux-pci/20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org/

I'm resubmitting this single patch, since it's useful and seemingly had
agreement.

Changes in v6:
- Include more background lore (thanks Rafael)
- Switch to "non-x86" instead of "uses Device Tree" condition

Changes in v5:
- Pulled out of the larger series, as there were more controversial
  changes in there, while this one had agreement (Link [1][2]).
- Rewritten with a relaxed set of rules, because the above patch
  required us to modify many device trees to add bridge nodes.

 drivers/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ff69f3d653ce..4d7c9f64ea24 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3031,7 +3031,7 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
  * @bridge: Bridge to check
  *
  * This function checks if it is possible to move the bridge to D3.
- * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
+ * Currently we only allow D3 for some PCIe ports and for Thunderbolt.
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
@@ -3075,10 +3075,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return false;
 
 		/*
-		 * It should be safe to put PCIe ports from 2015 or newer
-		 * to D3.
+		 * Out of caution, we only allow PCIe ports from 2015 or newer
+		 * into D3 on x86.
 		 */
-		if (dmi_get_bios_year() >= 2015)
+		if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >= 2015)
 			return true;
 		break;
 	}
-- 
2.49.0.395.g12beb8f557-goog


