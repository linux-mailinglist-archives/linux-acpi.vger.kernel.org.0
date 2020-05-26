Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704D11E2139
	for <lists+linux-acpi@lfdr.de>; Tue, 26 May 2020 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbgEZLtt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 May 2020 07:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731989AbgEZLts (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 May 2020 07:49:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AB0C08C5C3
        for <linux-acpi@vger.kernel.org>; Tue, 26 May 2020 04:49:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so9967287pgv.8
        for <linux-acpi@vger.kernel.org>; Tue, 26 May 2020 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aQLHuck/H6hUhxdEpWbnpYG+y4hFu1KRyBN1f+7zkW8=;
        b=XirmZKzM+LLXAtNZtlVmQwpy7SRWcMC0TYlRFk6EZGxsqxO252W3y8Nbx4uWD13qJw
         t6QjUR70f+5VrzW+sLYKnb8N8Jp5p/D00A51Ue/rxj4SAEosbp4CeVDJsJSIvPSWRds6
         /mk9A2jA56M7p0pSDTmMSNjOjPAWeCn/FACm5/I5azIw1lC3WMp2WR3XnbKbz9xqsl2/
         ulTm4r8T6NUFIzbvPYU2rllFJGPgCXxuSK2bWEK8Oovu2ZNsAUny/uwETLINLVVqPbNh
         AC58/ztbWIjpzc0KrCChbcnxAr9RxwVmBX0Q6vVr6ifmh4olUxNMQiOLvWnSfEcQiZg/
         3Emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aQLHuck/H6hUhxdEpWbnpYG+y4hFu1KRyBN1f+7zkW8=;
        b=MMy9FHdNtejtcCBxztGMxY/4mejLdm5QUPiBm7XszSCPTQfdAAqWC50CCpjJuV94bl
         LltIJaW0jUe4wCzrVSa+VP8j1LIdc/usnL1n4fhhcNPU95oLIlnSJVP7AVYKzIfY/nU5
         5G1WsGZBWAVsSz95PHpRfRl301RwTJE+h/o6kHAhiX5EHiArjSVil7gnbd60tiS6yNu9
         A8pGsi4scRp6NswaJcqnhKrhZbUrrYrZSDMkmkVKdAxr4+LHjr03GsJNiCfq8l9vZ0A6
         nS8sE8TNNtlMuLrnjLzyko1CSiTUK7S2ZKGSe9LhLLV4qpbFYz0QrxvWrxtwUmJV2g1G
         m0Lw==
X-Gm-Message-State: AOAM531bC1EDgCJ0gNrc8KGMbx6p9a7xd+MkpwW87rWqU/itDqNw8L1d
        7GRzsckjH2Fp9SLLkcSjsC4Eaw==
X-Google-Smtp-Source: ABdhPJwWqcev50wczjJKTLuB5KeWjX6Xh40o0PZ2aKsrj0RnXDD5TWs804Gl6GBeG4uho5hk5LIVkg==
X-Received: by 2002:a63:33c6:: with SMTP id z189mr714101pgz.426.1590493787584;
        Tue, 26 May 2020 04:49:47 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.9])
        by smtp.gmail.com with ESMTPSA id c12sm15586567pjm.46.2020.05.26.04.49.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 04:49:46 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Date:   Tue, 26 May 2020 19:49:07 +0800
Message-Id: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some platform devices appear as PCI but are actually on the AMBA bus,
and they need fixup in drivers/pci/quirks.c handling iommu_fwnode.
Here introducing PCI_FIXUP_IOMMU, which is called after iommu_fwnode
is allocated, instead of reusing PCI_FIXUP_FINAL since it will slow
down iommu probing as all devices in fixup final list will be
reprocessed, suggested by Joerg, [1]

For example:
Hisilicon platform device need fixup in
drivers/pci/quirks.c handling fwspec->can_stall, which is introduced in [2]

+static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
+{
+    struct iommu_fwspec *fwspec;
+
+    pdev->eetlp_prefix_path = 1;
+    fwspec = dev_iommu_fwspec_get(&pdev->dev);
+    if (fwspec)
+        fwspec->can_stall = 1;
+}
+
+DECLARE_PCI_FIXUP_IOMMU(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
+DECLARE_PCI_iFIXUP_IOMMU(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva); 

[1] https://www.spinics.net/lists/iommu/msg44591.html
[2] https://www.spinics.net/lists/linux-pci/msg94559.html

Zhangfei Gao (2):
  PCI: Introduce PCI_FIXUP_IOMMU
  iommu: calling pci_fixup_iommu in iommu_fwspec_init

 drivers/iommu/iommu.c             | 4 ++++
 drivers/pci/quirks.c              | 7 +++++++
 include/asm-generic/vmlinux.lds.h | 3 +++
 include/linux/pci.h               | 8 ++++++++
 4 files changed, 22 insertions(+)

-- 
2.7.4

