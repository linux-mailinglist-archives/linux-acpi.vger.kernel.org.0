Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC044A69C2
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Feb 2022 03:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbiBBCBJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Feb 2022 21:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242893AbiBBCBJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Feb 2022 21:01:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC45C06173B
        for <linux-acpi@vger.kernel.org>; Tue,  1 Feb 2022 18:01:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u185-20020a2560c2000000b0060fd98540f7so37148130ybb.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Feb 2022 18:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+oZZAJ93Jy4UHYgQMOKgcZ+Tafx++iolBtq7+r39Tt8=;
        b=UbQZqjK39u6TMbV7ooe4Qpn8t7EH7BRXJ+czxhC1600IQy3DDw3FS+kVkxYDRRl3vl
         Ryu5jR9neodQl/6jvFh9Itjq0tGpjiD6UDIEYHIjTiGLW+Dr9d0DquZtsolJ8wU/yLeV
         edZ7QX5teM86K1tiHqNfPmwJk6yv7wXaTydlOGgEb6JUrWd8/6RbIPYhG69X6u6ja0qR
         caNw/+3fgrg89vkjtWhoe1MWYAQUmpI+F1beyh/a70yzqnjgnfn0M0O54A9/kgtIrrNj
         BmfLvZ2l8DMl2mjOvF2QduGDI5LZISh7vBChoJ/FIS4R2MvS4J76ywRsWeJVLFMSs6d9
         YVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+oZZAJ93Jy4UHYgQMOKgcZ+Tafx++iolBtq7+r39Tt8=;
        b=0MTUBt50IG7nf+e5mOLULJ1dN/xVovBzBIWuK7Uq79vyFuwI1Ys5eTVsQwpwCR6b3o
         ZTF6DfRs0uRJmXIWW6zdaXbJsOtyE0kHA753BbmkZwNC42jPxE4nnn/+Bt7ViNmDhmpv
         OIPJTu6xD6P/5YuAshNgQ2XnEBEiflOmLiw+yGefKzlTlW7LYijikxcuSzKKXdA8THIS
         X1OzGpoZfKL0mWyPaDmpdaWaPFaC+cmcMzespt/Ryb+jpk5vIv7ysGvUJb9IzGudXjG3
         IEVGYwf0/lTRzo2Pioj5oQGLKZcNFwa/ofsXzszVlz8nsAiiroo/isKnIHmab4y5kOrE
         2Tlw==
X-Gm-Message-State: AOAM530QzuL8N3x1mPsT23y7lNMukKpyJUYrtTp1lqXZOXFl0FvViV+1
        DauRgeijKr2wwYDssZJFlw9N1pm7k4XH
X-Google-Smtp-Source: ABdhPJyY11MiO9c+Nqia5AcbphlMlCViWeU/vlCMo+UMffUd5Y5GEWLyzan3ovSdlF4GgrZlbtU4lO1oPpBm
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:57dc:f744:660d:72d])
 (user=rajatja job=sendgmr) by 2002:a25:e7d7:: with SMTP id
 e206mr24915081ybh.695.1643767267984; Tue, 01 Feb 2022 18:01:07 -0800 (PST)
Date:   Tue,  1 Feb 2022 18:01:02 -0800
Message-Id: <20220202020103.2149130-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v2 1/2] PCI: Allow internal devices to be marked as untrusted
From:   Rajat Jain <rajatja@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Today the pci_dev->untrusted is set for any devices sitting downstream
an external facing port (determined via "ExternalFacingPort" or the
"external-facing" properties).

However, currently there is no way for internal devices to be marked as
untrusted.

There are use-cases though, where a platform would like to treat an
internal device as untrusted (perhaps because it runs untrusted firmware
or offers an attack surface by handling untrusted network data etc).

Introduce a new "UntrustedDevice" property that can be used by the
firmware to mark any device as untrusted.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: * Also use the same property for device tree based systems.
    * Add documentation (next patch)

 drivers/pci/of.c       | 2 ++
 drivers/pci/pci-acpi.c | 1 +
 drivers/pci/pci.c      | 9 +++++++++
 drivers/pci/pci.h      | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index cb2e8351c2cc..e8b804664b69 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -24,6 +24,8 @@ void pci_set_of_node(struct pci_dev *dev)
 						    dev->devfn);
 	if (dev->dev.of_node)
 		dev->dev.fwnode = &dev->dev.of_node->fwnode;
+
+	pci_set_untrusted(dev);
 }
 
 void pci_release_of_node(struct pci_dev *dev)
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a42dbf448860..2bffbd5c6114 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1356,6 +1356,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
+	pci_set_untrusted(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ecce435fb3f..41e887c27004 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6869,3 +6869,12 @@ static int __init pci_realloc_setup_params(void)
 	return 0;
 }
 pure_initcall(pci_realloc_setup_params);
+
+void pci_set_untrusted(struct pci_dev *pdev)
+{
+	u8 val;
+
+	if (!device_property_read_u8(&pdev->dev, "UntrustedDevice", &val)
+	    && val)
+		pdev->untrusted = 1;
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3d60cabde1a1..6c273ce5e0ba 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -761,4 +761,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
+void pci_set_untrusted(struct pci_dev *pdev);
+
 #endif /* DRIVERS_PCI_H */
-- 
2.35.0.rc2.247.g8bbb082509-goog

