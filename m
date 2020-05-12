Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3FD1CEBC9
	for <lists+linux-acpi@lfdr.de>; Tue, 12 May 2020 06:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgELEJO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 May 2020 00:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726072AbgELEJM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 May 2020 00:09:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0371C05BD09
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2020 21:09:09 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so5748550pfc.0
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2020 21:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yP6D/ixJy1go9I3dKKTs64wSH22i2lwmmxRms2M5Log=;
        b=rFjrz9rDOYj5kTHRA9iW5hkbpiDEvFt+HIsb9wikLbrAcUSBldbXdKbYpt7EC1eJDu
         vRHSLfztu+FL84B8qSEaDPj8TR5zF5dkvnWMEeUDhSnZ+o/ZnUI+g+/glbL5QZ2l26Ub
         Kf+pFuNVkyX/xujz123lwbFV/+v26ivFpNzRv/JeytkerLige4bEVIcCMmxeDtRlBM8m
         kZUZMWJ0WGaufznZ5GG/vWLyEE2dRwH2mFe4SPaUAVgmMAn5sVG2MoyfJcODZO8umdGA
         2Dmm/WMEM2kcg5U7AGkly7XNwyB+33DyaTkJex9y2wstyBJ+GIEa26FYtJloj3tV8CIr
         oPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yP6D/ixJy1go9I3dKKTs64wSH22i2lwmmxRms2M5Log=;
        b=lWWSTnEgRIqLaKCnjKOQTsNJlF/OiG794oe8ppUPm23mwUvoSGsquES37scMYwxigO
         9EqSQ/XtTw+QsD4nOvC2uFcdk3+G6x7QdkEzNQ0hiojvn7FGAAWsLx3Kts/3U4Uc18Dv
         gFXW+XGkV+sElVXUHzp6m7eVNi3Ut8uIniWNrEZR6PcByEf9dtZpdQmJ8zmLN5Baz7E8
         Sqf4+IhJZB55X6kCrW1Ay/UuQoOpzqp5hNsJzs+7oZPsLQMQVZ/eOcBR/DS1yu7+UtrA
         glx600SXYmkw4sA7wK9UwBG5/r62NWqWtPedRtobZzrXY7AzwKIjXvbMg6KTvT8Az5eD
         H7rQ==
X-Gm-Message-State: AOAM5331dgcyPbkmsteZRlobaCj/aAKATrwMrkxGgfoV7aDhPIaiJ4fT
        wGdojkWW/mbx3zFGk08r5ivgQQ==
X-Google-Smtp-Source: ABdhPJwR/mT3M4ET0gUnmGWVdzywReAuxXeomuc5BK5uwflbMkhGQbsFgUJAeMnqFKRm6B3nbWRNqQ==
X-Received: by 2002:a63:3ec4:: with SMTP id l187mr8207696pga.358.1589256549383;
        Mon, 11 May 2020 21:09:09 -0700 (PDT)
Received: from localhost.localdomain ([240e:362:443:6f00:91af:f25c:441c:7ba4])
        by smtp.gmail.com with ESMTPSA id e4sm9471527pge.45.2020.05.11.21.08.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 21:09:08 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>,
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
        linux-arm-kernel@lists.infradead.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 0/2] Let pci_fixup_final access iommu_fwnode
Date:   Tue, 12 May 2020 12:08:29 +0800
Message-Id: <1589256511-12446-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some platform devices appear as PCI but are
actually on the AMBA bus, and they need fixup in
drivers/pci/quirks.c handling iommu_fwnode.
So calling pci_fixup_final after iommu_fwnode is allocated.

For example: 
Hisilicon platform device need fixup in 
drivers/pci/quirks.c

+static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
+{
+	struct iommu_fwspec *fwspec;
+
+	pdev->eetlp_prefix_path = 1;
+	fwspec = dev_iommu_fwspec_get(&pdev->dev);
+	if (fwspec)
+		fwspec->can_stall = 1;
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
 

Zhangfei Gao (2):
  iommu/of: Let pci_fixup_final access iommu_fwnode
  ACPI/IORT: Let pci_fixup_final access iommu_fwnode

 drivers/acpi/arm64/iort.c | 1 +
 drivers/iommu/of_iommu.c  | 1 +
 2 files changed, 2 insertions(+)

-- 
2.7.4

