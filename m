Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C94E25F5F6
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 11:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgIGJEh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 05:04:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728180AbgIGJEf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 05:04:35 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7EC0FECBFBD84D1A1059;
        Mon,  7 Sep 2020 17:04:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 17:04:14 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, Ken Xue <Ken.Xue@amd.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 0/5] Cleanups for ACPI APD driver
Date:   Mon, 7 Sep 2020 16:56:16 +0800
Message-ID: <1599468981-17301-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI APD driver has some unused code and some mis-behaved
kernel doc, make a cleanup for this driver.

Tested on Hisilicon ARM64, and compile tested on Intel x86.

Hanjun Guo (5):
  ACPI / APD: Add kernel doc for the properties in struct
    apd_device_desc
  ACPI / APD: Remove the flags in struct apd_device_desc
  ACPI / APD: Remove ACPI_MODULE_NAME()
  ACPI / APD: Remove the unneeded APD_ADDR(desc) macro define
  ACPI / APD: Head file including cleanups

 drivers/acpi/acpi_apd.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

-- 
1.7.12.4

