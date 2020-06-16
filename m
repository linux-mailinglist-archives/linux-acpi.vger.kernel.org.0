Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F21FA58B
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jun 2020 03:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFPBRz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jun 2020 21:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgFPBRy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2020 21:17:54 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213A3C08C5C3
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jun 2020 18:17:54 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id u26so15429347qtj.21
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jun 2020 18:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/xX6nZw43qnrS5POTejrGqQ7NU/q6i+TSuGWkPxARP8=;
        b=K64yw4UaVuSTB06zM70ynWO3Qe34OlpnWZDFtQx+XohI9pGel76JaZtLQSBoWSuTVn
         iUzYet0x27iuRTb1k2C8psq+ocK+eUc+lbqn/lM4DjoyK8Lwthh6he1ErlgUVUwd2DYt
         +Ye+ql9uWjMbbc98okBddDJZZSEPasbtsclPT6fSyzC2cMfQoctWhwgA1EprQkRAaKW3
         kZpng1WUzZbMtCYVB9VeNUn8PkNpzWWpfDFshQHOc4eQsm4yRF+loPV3Fp3xPvwnmEqr
         I9MkdliB1IiEzSTXoV4J1n+HUh2x8Vc310feGGYXQTOVnGd2k9zdRqFaiLC6Nf2wojul
         zk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/xX6nZw43qnrS5POTejrGqQ7NU/q6i+TSuGWkPxARP8=;
        b=mv6ZkC/p/OCWX6Ohfw68dziHjK7UYltDqFE3S+Wz25+6Xx6RsHDVhORk+IVtRcB7tk
         mxt3Sw7eNwGaDFWSF1BI9JzXFGYwGJiI0xMGV0ysO89BzrJvSkGCu0lhk5tPOovTZts2
         XgtzwNAlwLwKn9nrQOE5cWXa9Do/wlkmCbc81G6LB69lj5kOh3L6gzA7kEh+k/RcMqcx
         WmkAzm7F+4h7Fqm2XfcT6N7wrmzl6lGUQlDmpc8mujopWNn+Uk48dRj3m/l0y4CKcNOX
         6ffEthrv1LVBkKI9oDgicJsrOq1R2En6CjOLorHBPQ6P8THKZiGnltt7K+s8d1lAiaAx
         whww==
X-Gm-Message-State: AOAM531B6yhiwkw23aYAsVZtbtkrgkd1ML356eF487jHei3Gu1xyG7Pk
        BOz9fqTJf6suvaHc8ddk3BpAZljtDiCM
X-Google-Smtp-Source: ABdhPJx/VShp5rkGDpPUGAg/FhXNCRybPGhdLZkWV0hxwM8Gk42L1iKKJC5+PkUN237Ww8vlTPH4HPEgQvLG
X-Received: by 2002:ad4:4374:: with SMTP id u20mr548678qvt.144.1592270273220;
 Mon, 15 Jun 2020 18:17:53 -0700 (PDT)
Date:   Mon, 15 Jun 2020 18:17:41 -0700
In-Reply-To: <20200616011742.138975-1-rajatja@google.com>
Message-Id: <20200616011742.138975-3-rajatja@google.com>
Mime-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 3/4] pci: acs: Enable PCI_ACS_TB for untrusted/external-facing devices
From:   Rajat Jain <rajatja@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When enabling ACS, currently the bit "translation blocking" was
not getting changed at all. Set it to disable translation blocking
too for all external facing or untrusted devices. This is OK
because ATS is only allowed on internal devces.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci.c    |  4 ++++
 drivers/pci/quirks.c | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d2ff987585855..79853b52658a2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3330,6 +3330,10 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	/* Upstream Forwarding */
 	ctrl |= (cap & PCI_ACS_UF);
 
+	if (dev->external_facing || dev->untrusted)
+		/* Translation Blocking */
+		ctrl |= (cap & PCI_ACS_TB);
+
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b341628e47527..6294adeac4049 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
 	}
 }
 
+/*
+ * Currently this quirk does the equivalent of
+ * PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV
+ *
+ * Currently missing, it also needs to do equivalent of PCI_ACS_TB,
+ * if dev->external_facing || dev->untrusted
+ */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
 	if (!pci_quirk_intel_pch_acs_match(dev))
@@ -4973,6 +4980,10 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
+	if (dev->external_facing || dev->untrusted)
+		/* Translation Blocking */
+		ctrl |= (cap & PCI_ACS_TB);
+
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
 
 	pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
-- 
2.27.0.290.gba653c62da-goog

