Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7B148540
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2020 13:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgAXMkH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jan 2020 07:40:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55450 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729774AbgAXMkH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Jan 2020 07:40:07 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 397EE532D99C1BB561E2;
        Fri, 24 Jan 2020 20:40:05 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.84.245) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 Jan 2020 20:39:58 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <helgaas@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
        <james.morse@arm.com>, <tony.luck@intel.com>,
        <gregkh@linuxfoundation.org>, <zhangliguang@linux.alibaba.com>,
        <tglx@linutronix.de>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <yangyicong@hisilicon.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH v2 0/2] ACPI: APEI: Add support to notify the vendor specific HW errors
Date:   Fri, 24 Jan 2020 12:39:36 +0000
Message-ID: <20200124123938.16524-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <Shiju Jose>
References: <Shiju Jose>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.84.245]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Presently the vendor drivers are unable to do the recovery for the vendor specific
recoverable HW errors, reported to the APEI driver in the vendor defined sections,
because APEI driver does not support reporting the same to the vendor drivers.

This patch set
1. add an interface to the APEI driver to enable the vendor
drivers to register the event handling functions for the corresponding
vendor specific HW errors and report the error to the vendor driver.

2. add driver to handle HiSilicon hip08 PCIe controller's errors
   which is an example application of the above APEI interface.

Changes:

V2:
1. Changes in the HiSilicon PCIe controller's error handling driver
   for the comments from Bjorn Helgaas.
   
2. Changes in the APEI interface to support reporting the vendor error
   for module with multiple devices, but use the same section type.
   In the error handler will use socket id/sub module id etc to distinguish
   the device.

V1:  
1. Fix comments from James Morse.

2. add driver to handle HiSilicon hip08 PCIe controller's errors,
   which is an application of the above interface.

Shiju Jose (1):
  ACPI: APEI: Add support to notify the vendor specific HW errors

Yicong Yang (1):
  PCI: hip: Add handling of HiSilicon hip PCIe controller's errors

 drivers/acpi/apei/ghes.c                 | 116 ++++++++++-
 drivers/pci/controller/Kconfig           |   8 +
 drivers/pci/controller/Makefile          |   1 +
 drivers/pci/controller/pcie-hisi-error.c | 336 +++++++++++++++++++++++++++++++
 include/acpi/ghes.h                      |  56 ++++++
 5 files changed, 512 insertions(+), 5 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-hisi-error.c

-- 
1.9.1


