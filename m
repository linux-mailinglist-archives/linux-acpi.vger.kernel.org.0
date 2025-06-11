Return-Path: <linux-acpi+bounces-14281-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB37BAD5A30
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E491E5479
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 15:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409C71DD543;
	Wed, 11 Jun 2025 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sQ7YFMZM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4F1C6FE9
	for <linux-acpi@vger.kernel.org>; Wed, 11 Jun 2025 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654950; cv=none; b=kCoaC2Rz+zJyPfLKef7W5wQF6XB3K75gzBceLk+wmRF7fo+aGiHNkwKR71OG0uBYpVwfMOLME2+ga6lQakgDlL6aUlPUsWFVGT3/ykoc1DGEV3iXdIig0RKJnlTKcmRxLxuwFdbOP9JwU7jGI3q1STB/PqCg0F0ztZeuOI8ESHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654950; c=relaxed/simple;
	bh=FVL2plGFRc7FnYDk3q7OY6X26ABkyomyNDDhmQ5vilQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o3bOk4mwbPvl1odgbUJK5YzHPZ9FfDV1gb6V3NFyRJjykI4IMDJu9D/ta34xzs7QlB4iykO0m2vSMS8kK43uycHqkaHTotNqJkw0hVjO6z+ZwaGhPEGhudhHUc2Eo8Vr5XBL38VXKoso9rjxdx4H1EwXP4N5oVSAXXzSvS6itDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sQ7YFMZM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso63421355e9.2
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jun 2025 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749654946; x=1750259746; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zB5j9gvblcH4W7br/blh5/SpFtnoSJSdAHq7NFiVq5Y=;
        b=sQ7YFMZMOL2qq8JsPPYNHAwh6xTBPBxZFmVCBzlmznVgxOC6nkkwY4gWcB40hxIIgd
         ziHcDzJm8PObqEt+9pZAUrNkLQN4dLzZ5Wj/cxEpkKtM8EH72H9LwzzOiTSi3FLkeZA/
         1+/Kr/GZgOn37A1ppBM/812GzmqJaEnu87a3KCQb9SuCQaNW6j6hYwjv1b3RWrWzkKOP
         oQe3xWw0RmP1r6Jktf2+7eMAjYHH/Zc7+OCgZwSv0jTDa6D+DWP2zmv/Xbc6B+Jqujgl
         4pQAe2cNq9fzwvakBnW7QGxkULS+DFmk9aYp2koAbdCVR2eB2fcCPMYfHlB8FilbKhLm
         4Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654946; x=1750259746;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zB5j9gvblcH4W7br/blh5/SpFtnoSJSdAHq7NFiVq5Y=;
        b=nvg2VGpWkN1lmU1xZIXYDoksnTQCMaerhzsSKih9m5JhvovjXipO3A1cqY+7cppEZh
         cHudw50y7rwSH8n2xpqOEbVxwOswRJQpQYDasu4ocp5/vHnSUgSO0Aeh6z7+SW0ehDlR
         6MN0I2Q/euSFDhvomXRG4//82C6ksCr8WttPeyNJXoOjOR1IsO5XnFUiMF/KjcPKryYH
         ynT5mYigkmaa8eJAlRSUMxEMd9scmtTpL9owbFBxM+Lj4eGjox0mgcY7+3AYoGnULDGO
         tSZHieJQhW/Ae2dKZdWD14AJx1mkVRJInmeKR41axf7qJYCN3Q+372LHJ+L/gMHLeQKT
         eIVQ==
X-Gm-Message-State: AOJu0YxkiieLr/Ruwnd4ZpkW2sp2xcldVXfZLjGk4Vs0OE3RkwAIcU4k
	7V9AhITn0Gydez9H8amBAzDl9wYKSMBY0aHBvDlPo7u8fsX5jRlX+Bne6EP43mnfO8aLXzAEpIc
	W7vxR
X-Gm-Gg: ASbGnctqbs0NOeOLma/g3OVhAswo25CQaocYhUiMZTEs25oE3lo76P5WfC5rMPpajCT
	6RbmYvA/fMBe5IY4L7H+xEIvwDcCAUMXwEwIcG6Cp65IPB4Vlp6jpprg5/FJTXcwqYu6bL28QkN
	1Flr2L0lus/2CpU2RRfkFIn9Ns62t3XfPOHh4Cns991cATrF2PaascXbJ+K3sz4Z+lT4eDrYS3z
	mSMTfIkeVhcU4Az4iIfw4B58bI5JYPceNdB7yulfhq53L0xa5VvSZTwGg4IZZI32dsYe3Cc6rCC
	6fP+cIl4qyNebqWvMU5sEada7H0pG3JaQKbJDvzw3jnaFWSnBlFAciWMV/3dxiHjsfs=
X-Google-Smtp-Source: AGHT+IG35cL3sCDSoMZU6a3nIB/8YOEBrQRnLMFQEAJvmaIDZdrwuAYF9eI3Qnpk2auypSvQP6Xg5g==
X-Received: by 2002:a05:6000:40d9:b0:3a4:d31e:4af3 with SMTP id ffacd0b85a97d-3a558ad6e98mr2569413f8f.37.1749654946573;
        Wed, 11 Jun 2025 08:15:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a532461211sm15353436f8f.86.2025.06.11.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:15:45 -0700 (PDT)
Date: Wed, 11 Jun 2025 18:15:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: linux-acpi@vger.kernel.org
Subject: [bug report] PCI/ACPI: Fix allocated memory release on error in
 pci_acpi_scan_root()
Message-ID: <aEmdnuw715btq7Q5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Zhe Qiao,

Commit 631b2af2f357 ("PCI/ACPI: Fix allocated memory release on error
in pci_acpi_scan_root()") from Apr 30, 2025 (linux-next), leads to
the following Smatch static checker warning:

	drivers/pci/pci-acpi.c:1712 pci_acpi_scan_root()
	error: double free of 'root_ops' (line 1711)

drivers/pci/pci-acpi.c
    1667 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
    1668 {
    1669         struct acpi_pci_generic_root_info *ri;
    1670         struct pci_bus *bus, *child;
    1671         struct acpi_pci_root_ops *root_ops;
    1672         struct pci_host_bridge *host;
    1673 
    1674         ri = kzalloc(sizeof(*ri), GFP_KERNEL);
    1675         if (!ri)
    1676                 return NULL;
    1677 
    1678         root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
    1679         if (!root_ops)
    1680                 goto free_ri;
    1681 
    1682         ri->cfg = pci_acpi_setup_ecam_mapping(root);
    1683         if (!ri->cfg)
    1684                 goto free_root_ops;
    1685 
    1686         root_ops->release_info = pci_acpi_generic_release_info;
    1687         root_ops->prepare_resources = pci_acpi_root_prepare_resources;
    1688         root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
    1689         bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
    1690         if (!bus)
    1691                 goto free_cfg;

The acpi_pci_root_create() function frees root_ops on error in
pci_acpi_generic_release_info().  I think there is only one error
path where it frees "ri->cfg".  I probably would advise you to re-write
the the error handling in acpi_pci_root_create().

    1692 
    1693         /* If we must preserve the resource configuration, claim now */
    1694         host = pci_find_host_bridge(bus);
    1695         if (host->preserve_config)
    1696                 pci_bus_claim_resources(bus);
    1697 
    1698         /*
    1699          * Assign whatever was left unassigned. If we didn't claim above,
    1700          * this will reassign everything.
    1701          */
    1702         pci_assign_unassigned_root_bus_resources(bus);
    1703 
    1704         list_for_each_entry(child, &bus->children, node)
    1705                 pcie_bus_configure_settings(child);
    1706 
    1707         return bus;
    1708 
    1709 free_cfg:
    1710         pci_ecam_free(ri->cfg);
    1711 free_root_ops:
--> 1712         kfree(root_ops);
    1713 free_ri:
    1714         kfree(ri);
    1715         return NULL;
    1716 }

regards,
dan carpenter

