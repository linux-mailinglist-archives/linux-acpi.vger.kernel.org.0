Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA4C14B36B
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 12:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgA1LSP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 06:18:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbgA1LSP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 06:18:15 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 496A1E444703DA9C65CE;
        Tue, 28 Jan 2020 19:18:10 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 28 Jan 2020 19:18:02 +0800
From:   John Garry <john.garry@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <jeremy.linton@arm.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <guohanjun@huawei.com>, <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 0/2] Add basic generic ACPI soc driver
Date:   Tue, 28 Jan 2020 19:14:17 +0800
Message-ID: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A requirement has come up recently to be able to read system SoC packages
identifiers from userspace [0].

For device tree FW-based systems, this would be quite straightforward, in
that we could add a soc driver for that system and use the DT model
identifier as the soc id - that's how most soc drivers seem to do it.

For ACPI-based systems, the only place I know to get (put) such SoC
information is in the PPTT, specifically the ID Type Structure for a
processor package node. A processor package node describes a physical
boundary of a processor topology.

The ACPI spec does not declare how the fields in this structure must be
used, however it does provide pretty clear examples, which I would expect
most implementers to follow. As such, I try to solve the problem in 2
parts:
- Add ACPI PPTT API to get opaque package structure
- Add basic ACPI generic soc driver, which can interpret the fields
  for known platforms to fill in the ID Type Structure as per example
  in the spec.

So I'm hoping here for some comments on this approach - hence the RFC.
I've cc'ed some folks which may have suggestions.

[0] https://lore.kernel.org/linux-arm-kernel/1579876505-113251-6-git-send-email-john.garry@huawei.com/ ,
    https://lore.kernel.org/linux-arm-kernel/1579876505-113251-1-git-send-email-john.garry@huawei.com/

John Garry (2):
  ACPI/PPTT: Add acpi_pptt_get_package_info() API
  soc: Add a basic ACPI generic driver

 drivers/acpi/pptt.c        |  81 +++++++++++++++++++++++++++++
 drivers/soc/Makefile       |   1 +
 drivers/soc/acpi_generic.c | 102 +++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h       |  13 +++++
 4 files changed, 197 insertions(+)
 create mode 100644 drivers/soc/acpi_generic.c

-- 
2.17.1

