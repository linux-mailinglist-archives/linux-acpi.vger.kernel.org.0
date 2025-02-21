Return-Path: <linux-acpi+bounces-11358-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32078A3E90B
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 01:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13173BF3F9
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 00:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F6AB667;
	Fri, 21 Feb 2025 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZFjRNJw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01734566A
	for <linux-acpi@vger.kernel.org>; Fri, 21 Feb 2025 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096596; cv=none; b=s8/xB+o/P3SRtVapIM4ByFUS7fcZTQwBUlgxTaRyr+oOuet5XFdRZWnAR4bU91QtqClCgmLa24qIvfudBEY/k3wI/K6W5WcNRyjOAU2LiSiCr42ivl4RMG5Hm1fJA3AUWx8PX+b5aiIs1hf4q5CQR9lX5JJcHjfK0xgCL8D8N8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096596; c=relaxed/simple;
	bh=7ycQWLzd5hwGPvM2CGrVqMLXE8dmu3R806nhRva4W5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YF0ak2ALUQ35yLZSANmzixdZrW4/KfPEah/G7rjthx/LVPM8ttxqtTtxXUtJEQSlZrQzpuZqAwZrAV4UVYfqqqyBg8tfSqb248RM23vW+7Vv+VmO4Ji+2gP4Louh2FBomBt0ZxA7NdLTB9UPbwt+8eCNR+R3DDp0SpoVJOxGzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZFjRNJw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1a4c150bso3068258a91.2
        for <linux-acpi@vger.kernel.org>; Thu, 20 Feb 2025 16:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740096594; x=1740701394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aobg0PVlzdviRy/cQd7B6jC/eqOG2GRLnGjA6uI98tk=;
        b=jZFjRNJwKhhD46lMkb+IVREb4sXoEYACuVCc7TZkCGgNSQFH48vZbovI2coEM8gi+y
         2DGO71sTx8FfVckuX95N3m0gQbQMmh49yww7FYADw+xDFC3rt/MYKh5egjqIPHJemo3z
         4o+61zOjwlYIrdn4FxzTMrW28CKszBHnNiBv8oqfQQeqnahGQDvQFJ2n9oPlUmAs7AOB
         oCs4THqqVwBOT4Pxqm5PMdo7XBKTGnxUW5W5n/XtFCN93MhNSNa3UApC5C+GXEXo/wFP
         WLMXIwyQOZ7xUKJu6s+zCGWoFtlZE4BudCTXyLvFs5kcp+wuZv8rVbAl/x11jqk2+YBm
         NGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740096594; x=1740701394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aobg0PVlzdviRy/cQd7B6jC/eqOG2GRLnGjA6uI98tk=;
        b=LKmfWf8jn1LacB4/yspMdmZSRpeMbLp4Zz+PQG2y0AQEX2njSwk28rbpqXothpopMH
         xsO1hulTZB00/QYLE7sfLWUaWuUy2PGYeyHeH/AoHk7uT0X56od+kNH3x9oRlz1IyIJO
         Db8ptvBxwUFBsOfzGEKgy6uJ4/KT20h3upU5yRQg1wIj3TCdqUJLnYRafNr/A0/J+npC
         zlGv8Phl8tQ8mjEDhXTSvTvkqC7Nj19Ji587nKxaBgS9tl4dvFTQQBfXYixjgbtiRFQ0
         2Tg3mbgmkLb1+xkk+tigZEeUrqhiRJ9987SdkwxGJRYwigDTkvsq0eMesG4k7yUd2V1D
         lEDw==
X-Forwarded-Encrypted: i=1; AJvYcCUzPGN2uXYdOaESnOg2h53TwEJeeti6mabM9nA/V9/RsJbaNlVfZLmvb23OJ6XxOUhKWxQn/csQ3C/r@vger.kernel.org
X-Gm-Message-State: AOJu0YxkkaFUmeWhW+NZjF3LvA1CFY9oP7zrElHH/Ci0d27w+ai1TEd8
	R0TMZ4RGiKuglY/bXBa0NXHH9bh47Eg+y2CRI+8dzwIjSU7dbMaRGcTPOMR4Mmlj9bIc2+XJRI0
	WBjgHug==
X-Google-Smtp-Source: AGHT+IHZzxzrxbsH7efugqJJN045fO9BV+dY755bECYZbZkD2jqYlwQTWhUh9sEr1Ybvi6ir1vlrHFwdCahW
X-Received: from pgar9.prod.google.com ([2002:a05:6a02:2e89:b0:ae1:b40f:fc2])
 (user=jperaza job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7011:b0:1ee:d7fa:5d8f
 with SMTP id adf61e73a8af0-1eef3d5a9dfmr1947981637.27.1740096594064; Thu, 20
 Feb 2025 16:09:54 -0800 (PST)
Date: Fri, 21 Feb 2025 00:09:40 +0000
In-Reply-To: <20250221000943.973221-1-jperaza@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221000943.973221-1-jperaza@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250221000943.973221-2-jperaza@google.com>
Subject: [v9 PATCH 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
From: Joshua Peraza <jperaza@google.com>
To: gregkh@linuxfoundation.org
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, helgaas@kernel.org, iommu@lists.linux-foundation.org, 
	jean-philippe@linaro.org, joro@8bytes.org, jperaza@google.com, 
	jsbarnes@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	mika.westerberg@linux.intel.com, oohall@gmail.com, pavel@denx.de, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rajatja@google.com, 
	rajatxjain@gmail.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Rajat Jain <rajatja@google.com>

The "DmaProperty" is supported and currently documented and used by
Microsoft [link 1 below], to flag internal PCIe root ports that need
DMA protection [link 2 below]. We have discussed with them and reached
a common understanding that they shall change their MSDN documentation
to say that the same property can be used to protect any PCI device,
and not just internal PCIe root ports (since there is no point
introducing yet another property for arbitrary PCI devices). This helps
with security from internal devices that offer an attack surface for
DMA attacks (e.g. internal network devices).

Support DmaProperty to mark DMA from a PCI device as untrusted.

Link: [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
Link: [2] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Joshua Peraza <jperaza@google.com>
---
 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 436019d96027..bb1459c43b6b 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -56,6 +56,9 @@ static const guid_t prp_guids[] = {
 	/* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
 	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
 		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
+	/* DmaProperty for PCI devices GUID: 70d24161-6dd5-4c9e-8070-705531292865 */
+	GUID_INIT(0x70d24161, 0x6dd5, 0x4c9e,
+		  0x80, 0x70, 0x70, 0x55, 0x31, 0x29, 0x28, 0x65),
 };
 
 /* ACPI _DSD data subnodes GUID [1]: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..a457ae3e811a 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1438,12 +1438,34 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
 		dev->external_facing = 1;
 }
 
+static int pci_dev_has_dma_property(struct pci_dev *dev)
+{
+	struct acpi_device *adev;
+	const union acpi_object *obj;
+
+	adev = ACPI_COMPANION(&dev->dev);
+	if (!adev)
+		return 0;
+
+	/*
+	 * Property used by Microsoft Windows to enforce IOMMU DMA
+	 * protection from any device, that the system may not fully trust;
+	 * we'll honour it the same way.
+	 */
+	if (!acpi_dev_get_property(adev, "DmaProperty", ACPI_TYPE_INTEGER,
+				   &obj) && obj->integer.value == 1)
+		return 1;
+
+	return 0;
+}
+
 void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
+	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
-- 
2.48.1.601.g30ceb7b040-goog


