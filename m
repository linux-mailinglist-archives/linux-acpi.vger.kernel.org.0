Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE231CEBD2
	for <lists+linux-acpi@lfdr.de>; Tue, 12 May 2020 06:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgELEJi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 May 2020 00:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726667AbgELEJh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 May 2020 00:09:37 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DE6C05BD09
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2020 21:09:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k7so3861714pjs.5
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2020 21:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6S28BNiWmQ/hEXUnU1MTnqXBi18kA3ePoZOYdtU1cwQ=;
        b=zKPMo9VxVy3jMqZvbDFZzd0rfMvjK8sIRqKU+RRM8fhiK3BsQbxVPPqNYrdq3CNlJp
         srwFwGJmFE53BiW8OELV7eGESL1CDt3+K4ya4VOcLbsiDUEhRhJL5Hsx5wYQmr4/a1ha
         npM2phtb/qYoGwQEx97t6GacPM8Z7YAe5eoPRlt84htL5JM81zMsdpd3BUasJ+/8QsnH
         dkV7TQ2UOgKSRXuw2IGL0NHMPpGwN/hPYlde9jC+uvFu5gspfztR7vKX+YVtfvubS0Zb
         /IgWuGFfL2eesthQolXE8F1dD/HdpBfJqLHJnovOiJQqYzfmg/aL8KblwwEQlXwQIPtH
         rPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6S28BNiWmQ/hEXUnU1MTnqXBi18kA3ePoZOYdtU1cwQ=;
        b=YshQqi5Kz31aKHppjx1Azt4vzgSviGsLKl9WdA1jwu6Pou2q2K/lv8hz2YijJRylFc
         kQQTHIU0y4PgPao1oRbU05sTn9BDvG0zXEUr9cFCHA70emCPBzXi5W5CB0HuRklYCC8s
         zA2KZrXPIY17Plx3zK2bhsRUrQrhc+2LFsQUHwgjakOYLi8YLoPnAU2op/CmDYQYBaQQ
         xuUQEIXnylZhASZopiHXsb1TUwdbVmYDs3F83FGdPN8A7XekEHgOl34RIWM3n/MpP/2O
         bbyrI6vBROvBdCGBkP9eiNdu6n6NqXmBvzhboCWS+Yw4Nfxhhm2cWJFJoCIcvFW0Nxj6
         koiw==
X-Gm-Message-State: AGi0Puaf8sGcSp8OO+aIezsUoJ1Clj7nav58FQJs9v0lRWzeCsLaHDZB
        A2nWc5Is5bQ9rfhkde1mjYR8Kw==
X-Google-Smtp-Source: APiQypIz5wcptWAsZSR4zFqLILzJ6EQ/AyMRL3bPtWuTsky6Bgy54mQMi2/qmxe6ZV1FPbWCHDML+A==
X-Received: by 2002:a17:902:728e:: with SMTP id d14mr18153543pll.107.1589256577364;
        Mon, 11 May 2020 21:09:37 -0700 (PDT)
Received: from localhost.localdomain ([240e:362:443:6f00:91af:f25c:441c:7ba4])
        by smtp.gmail.com with ESMTPSA id e4sm9471527pge.45.2020.05.11.21.09.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 21:09:36 -0700 (PDT)
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
Subject: [PATCH 2/2] ACPI/IORT: Let pci_fixup_final access iommu_fwnode
Date:   Tue, 12 May 2020 12:08:31 +0800
Message-Id: <1589256511-12446-3-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589256511-12446-1-git-send-email-zhangfei.gao@linaro.org>
References: <1589256511-12446-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Calling pci_fixup_final after iommu_fwspec_init, which alloc
iommu_fwnode. Some platform devices appear as PCI but are
actually on the AMBA bus, and they need fixup in
drivers/pci/quirks.c handling iommu_fwnode.
So calling pci_fixup_final after iommu_fwnode is allocated.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/acpi/arm64/iort.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 7d04424..02e361d 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1027,6 +1027,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		info.node = node;
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     iort_pci_iommu_init, &info);
+		pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
 
 		fwspec = dev_iommu_fwspec_get(dev);
 		if (fwspec && iort_pci_rc_supports_ats(node))
-- 
2.7.4

