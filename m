Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E64321D7F2
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jul 2020 16:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgGMOLf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jul 2020 10:11:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2459 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729782AbgGMOLe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Jul 2020 10:11:34 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 268373485370AB025F40;
        Mon, 13 Jul 2020 15:11:33 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.82.58) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 13 Jul 2020 15:11:32 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <helgaas@kernel.org>, <bp@alien8.de>, <james.morse@arm.com>,
        <lenb@kernel.org>, <tony.luck@intel.com>,
        <dan.carpenter@oracle.com>, <zhangliguang@linux.alibaba.com>,
        <andriy.shevchenko@linux.intel.com>, <wangkefeng.wang@huawei.com>,
        <jroedel@suse.de>
CC:     <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>
Subject: [PATCH v12 0/2] ACPI / APEI: Add support to notify the vendor specific HW errors
Date:   Mon, 13 Jul 2020 15:08:59 +0100
Message-ID: <20200713140901.853-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.82.58]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

CPER records describing a firmware-first error are identified by GUID.
The ghes driver currently logs, but ignores any unknown CPER records.
This prevents describing errors that can't be represented by a standard
entry, that would otherwise allow a driver to recover from an error.
The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of
version 2.8).

patch set
1. add a notifier chain for these non-standard/vendor-records
   in the ghes driver.

2. add a driver to handle HiSilicon hip PCIe controller's errors.
   
Changes:
V12:
1. Changed the Signed-off-by tag to Co-developed-by tag in the patch
   "ACPI / APEI: Add a notifier chain for unknown (vendor) CPER records"

V11:
1. Following modifications made by James Morse in the APEI patch
   for the vendor error record.
   - Removed kfifo and ghes_gdata_pool. Expanded commit message.
   
   Note: Kept the Signed-off-by: James Morse as he is given
   because I am not sure the right format.
   
2. Changes in the HIP PCIe error handler driver
   for the comments by Andy Shevchenko.

V10:
1. Changes for Bjorn's comments on HIP PCIe error handler driver
   and APEI patch.
   
2. Changes in the HIP PCIe error handler driver
   for the feedbacks by Andy Shevchenko.
   
V9:
1. Fixed 2 improvements suggested by the kbuild test robot. 
1.1 Change ghes_gdata_pool_init() as static function.
1.2. Removed using buffer to store the error data for
     logging in the hisi_pcie_handle_error()

V8:
1. Removed reporting the standard errors through the interface
   because of the conflict with the recent patches in the
   memory error handling path.
2. Fix comments by Dan Carpenter.
   
V7:
1. Add changes in the APEI driver suggested by Borislav Petkov, for
   queuing up all the non-fatal HW errors to the work queue and
   notify the registered kernel drivers from the bottom half using
   blocking notifier, common interface for both standard and
   vendor-spcific errors.
2. Fix for further feedbacks in v5 HIP PCIe error handler driver
   by Bjorn Helgaas.

V6:
1. Fix few changes in the patch subject line suggested by Bjorn Helgaas.

V5:
1. Fix comments from James Morse.
1.1 Changed the notification method to use the atomic_notifier_chain.
1.2 Add the error handled status for the user space.  

V4:
1. Fix for the following smatch warning in the PCIe error driver,
   reported by kbuild test robot<lkp@intel.com>:
   warn: should '((((1))) << (9 + i))' be a 64 bit type?
   if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
	^^^ This should be BIT_ULL() because it goes up to 9 + 32.

V3:
1. Fix the comments from Bjorn Helgaas.

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
  ACPI / APEI: Add a notifier chain for unknown (vendor) CPER records

Yicong Yang (1):
  PCI: hip: Add handling of HiSilicon HIP PCIe controller errors

 drivers/acpi/apei/ghes.c                 |  63 +++++
 drivers/pci/controller/Kconfig           |   8 +
 drivers/pci/controller/Makefile          |   1 +
 drivers/pci/controller/pcie-hisi-error.c | 327 +++++++++++++++++++++++
 include/acpi/ghes.h                      |  27 ++
 5 files changed, 426 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-hisi-error.c

-- 
2.17.1


