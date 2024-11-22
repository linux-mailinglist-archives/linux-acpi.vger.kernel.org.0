Return-Path: <linux-acpi+bounces-9729-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E4A9D5952
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 07:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CD9DB20D09
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 06:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422D61632E2;
	Fri, 22 Nov 2024 06:20:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A1D13049E;
	Fri, 22 Nov 2024 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256459; cv=none; b=aBUvhOGXBY4D4OJegoVRG01C6rjy2Q9nw6jklZZRYTlxdjk1xdDauoHQK6S8CqQNPnN/xgQd2Qxk6n+3wP7LWb8C5mwLdk7p0Jwb2/9BYO1xE8pmDIBSr8PGI7qT33vpxKJxUTdKew1b+IE67MgZfS88v0reM1AhDN9CY1gTBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256459; c=relaxed/simple;
	bh=NSQdXNVyOy7drLHA2vuIV+iG0iYw6tdiwWdayeqv4yI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tIR9OJFRMcAPuM7Dmv2VxnUzhY9nQBcM/5eGPyJzGm8x3na4It0pFytIHL7gY5tBn6lHEc53x36zUFhmsX5nZ0vB9xJdqFIFht3oxMwj/sPWk0mZUHaUex4CoHzPHO22bIQSI3FjMDg3301EqQxzy2D/BVqD/XyeB3nKAZG3niI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XvlGR54ywz1JCfl;
	Fri, 22 Nov 2024 14:15:59 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 0143D1400D5;
	Fri, 22 Nov 2024 14:20:53 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 14:20:52 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v2 0/3] Support for autonomous selection in cppc_cpufreq
Date: Fri, 22 Nov 2024 14:20:48 +0800
Message-ID: <20241122062051.3658577-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
driver.

The patch series is organized in two parts:

 - patch 1 refactor out the general CPPC register get and set functions
   in cppc_acpi.c

 - patches 2-3 expose sysfs files for users to control CPPC autonomous
   selection when supported

Change since v1:
 - fix some incorrect placeholder
 - change kstrtoul to kstrtobool in store_auto_select

Lifeng Zheng (3):
  ACPI: CPPC: Refactor register get and set ABIs
  ACPI: CPPC: Add autonomous selection ABIs
  cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq

 .../ABI/testing/sysfs-devices-system-cpu      |  54 ++++
 drivers/acpi/cppc_acpi.c                      | 235 +++++++++---------
 drivers/cpufreq/cppc_cpufreq.c                | 138 ++++++++++
 include/acpi/cppc_acpi.h                      |  20 ++
 4 files changed, 328 insertions(+), 119 deletions(-)

-- 
2.33.0


