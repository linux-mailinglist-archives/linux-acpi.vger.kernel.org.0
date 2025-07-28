Return-Path: <linux-acpi+bounces-15334-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4F0B13552
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21B93B333E
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 07:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E56F2236F4;
	Mon, 28 Jul 2025 07:06:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72513220F5B;
	Mon, 28 Jul 2025 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686380; cv=none; b=PAHrTEuokUPHk6kv9vErfaFQDqIX36OhZ6EL+0J9WLHPLuibnSHv6vwp3NCpjU430D8wQ14+R8DyLLaNVoKVYJ72EMit4pfER1A8KX1S6WNIzG/Icbb9s4ZfN8Mk8GDM2c6CyBxOJT1OF/sfJ97LDGHozPdzFHSwHuJls5fv/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686380; c=relaxed/simple;
	bh=3hgjVdNf1X1Ll/WQYsxY3MyIrNAu3JL+DvMlOCvNpsY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=icnT9k8zGtv9w/bSg4D/x7z6fsTdASll6Cz+0Pq0/2aVFp/nk6y22xXSFN71nihfUY/OLQLl5RMKKgC06r7fF2z42xWGAa5Neb2h7cWgjQ6BxzvmZtF/4ld5NtNg1CZE6eu18y8jGKYQzFEFNUrc+iA9RCn1CkAi9g8mL3jRcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4br8bG45Kqz2RVvf;
	Mon, 28 Jul 2025 15:03:54 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D773180044;
	Mon, 28 Jul 2025 15:06:14 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Jul 2025 15:06:13 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Jul 2025 15:06:13 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v3 0/2] ACPI: processor: idle: Optimize acpi idle driver registration
Date: Mon, 28 Jul 2025 15:06:10 +0800
Message-ID: <20250728070612.1260859-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)

This series fix a memory leak issue and optimize the registration of
acpi idle driver to enhance its readability. 

---
changelog:
v3: 
 * use a separate patch to fix memory leak.
 * change the return value of the new function to void.
 * change log level to debug on failure path.
v2:
 * register cpuidle driver in advance when all of the CPUs have been
   brought up.
https://patchwork.kernel.org/project/linux-acpi/patch/20250723121034.3685996-1-lihuisong@huawei.com/
v1:
https://patchwork.kernel.org/project/linux-acpi/patch/20250619061327.1674384-1-lihuisong@huawei.com/

Huisong Li (2):
  ACPI: processor: idle: Fix memory leak when register cpuidle device
    failed
  ACPI: processor: idle: Optimize acpi idle driver registration

 drivers/acpi/processor_driver.c |  3 ++
 drivers/acpi/processor_idle.c   | 67 ++++++++++++++++++++++-----------
 include/acpi/processor.h        |  8 ++++
 3 files changed, 55 insertions(+), 23 deletions(-)

-- 
2.33.0


