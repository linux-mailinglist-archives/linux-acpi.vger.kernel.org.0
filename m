Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A134321659C
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 06:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGGEyb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jul 2020 00:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgGGEya (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2020 00:54:30 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A1EC061755
        for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2020 21:54:30 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o26so27788179qko.7
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2020 21:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qk/CudVh/aYmFA4VGFCO8mdbAWkl57VHCd1ZIJWN+1w=;
        b=Xre+DO5bBquqMu+hdF9c3GWOfwJPU0JSYZ82fhlA0HFoIo0LganFlMRGd90xICWjvh
         x6VqENjaJX+E6NmE7NvnAmKue5CkshpdqCfHOJDdbjwtbGNakh6+Y2o2MCQzOFHd8mWB
         Tx6gwJgY9b5m33RdN7MXjvEI7lNExtH3p/MO6RXgh/of/7qxV2dhNwE5Ya8bmsH5mhBC
         KVvnUlfyjdwVqd5LHb1/V/h1A+eW5DYc5Y2+BZt27U5BtA20FnqlrWGeEQKgYsXSbbew
         xusxlAqAeT++ykRLTsGvPyIrcRpvzT4IW00uhXW1Wj6u8ayVQwdQHaPEUuR7QMoK/PRD
         25lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qk/CudVh/aYmFA4VGFCO8mdbAWkl57VHCd1ZIJWN+1w=;
        b=HRaPsf0ZmvxH+nc5DjB23sHUVTF6PAqtiGNtEvlFoxhRSyumuQjUS6lF5aXFw3/o42
         vAtQv2zn5aNrpKsM36KOxFbXNPvGYso2Tex4hSTbKIWKxsqwvcPFFphy4JTxsC16N9QB
         uSMS2W9tp5OA+g5s+GPsaAbsruZ9uYPV0EHJCS5lQyi51jGKJY7TEX4ZFPWkT20HZYNZ
         jC9em69aMNgbh960sCKBy5i45GUkydGnu9W67iuVL3a2JRaZbgFMZE1bG9JmlVgZfx3L
         J8Bq7feQ5YUMQFmsDApIrmOVkXNq6CeqcMIMZIaY/XsAX4SqSs6HD6ezgyaDGXVpCPh9
         MpvA==
X-Gm-Message-State: AOAM532QhVG7PyLsR4Z8zORK6ExW0tGU5UJhSMWC6l2TAUohCVIXNmdB
        XDJ1391sbZDSW509k7yUYapFUgSej6GA
X-Google-Smtp-Source: ABdhPJxwPXvnk3sNJWoQC6YwOTWi9tymhjLuGByDfNWQcfhaj8ZWG0wbKLQWCrNYPqv0Xn0Z4pBVaY07uBDo
X-Received: by 2002:a0c:aed6:: with SMTP id n22mr50763155qvd.70.1594097669245;
 Mon, 06 Jul 2020 21:54:29 -0700 (PDT)
Date:   Mon,  6 Jul 2020 21:54:18 -0700
In-Reply-To: <20200707045418.3517076-1-rajatja@google.com>
Message-Id: <20200707045418.3517076-4-rajatja@google.com>
Mime-Version: 1.0
References: <20200707045418.3517076-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v3 4/4] PCI/ACS: Enable PCI_ACS_TB for untrusted/external-facing
 devices
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
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When enabling ACS, enable translation blocking for external facing ports
and untrusted devices.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
    Minor code comments fixes.
v2: Commit log change

 drivers/pci/pci.c    |  7 +++++++
 drivers/pci/quirks.c | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 73a8627822140..497ac05bf36e8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -876,6 +876,13 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	/* Upstream Forwarding */
 	ctrl |= (cap & PCI_ACS_UF);
 
+	/* Enable Translation Blocking for external devices */
+	if (dev->external_facing || dev->untrusted)
+		if (cap & PCI_ACS_TB)
+			ctrl |= PCI_ACS_TB;
+		else
+			pci_warn(dev, "ACS: No Trans Blocking on ext dev\n");
+
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b341628e47527..9cc8c1dc215ee 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
 	}
 }
 
+/*
+ * Currently this quirk does the equivalent of
+ * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
+ *
+ * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
+ * if dev->external_facing || dev->untrusted
+ */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
 	if (!pci_quirk_intel_pch_acs_match(dev))
@@ -4973,6 +4980,13 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
+	/* Enable Translation Blocking for external devices */
+	if (dev->external_facing || dev->untrusted)
+		if (cap & PCI_ACS_TB)
+			ctrl |= PCI_ACS_TB;
+		else
+			pci_warn(dev, "ACS: No Trans Blocking on ext dev\n");
+
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
 
 	pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
-- 
2.27.0.212.ge8ba1cc988-goog

