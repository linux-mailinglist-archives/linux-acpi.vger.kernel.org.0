Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F046C7A4635
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Sep 2023 11:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbjIRJmE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Sep 2023 05:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjIRJlh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 05:41:37 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABB7CCD;
        Mon, 18 Sep 2023 02:40:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VsKThJJ_1695029998;
Received: from 30.240.112.49(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VsKThJJ_1695029998)
          by smtp.aliyun-inc.com;
          Mon, 18 Sep 2023 17:40:00 +0800
Message-ID: <e486db16-d36d-9e14-4f10-dc755c0ef97d@linux.alibaba.com>
Date:   Mon, 18 Sep 2023 17:39:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Content-Language: en-US
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Questions: Should kernel panic when PCIe fatal error occurs?
To:     "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, mahesh@linux.ibm.com,
        bhelgaas@google.com,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        gregkh@linuxfoundation.org
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, all folks,

Error reporting and recovery are one of the important features of PCIe, and
the kernel has been supporting them since version 2.6, 17 years ago.
I am very curious about the expected behavior of the software.
I first recap the error classification and then list my questions bellow it.

## Recap: Error classification

- Fatal Errors

Fatal errors are uncorrectable error conditions which render the particular
Link and related hardware unreliable. For Fatal errors, a reset of the
components on the Link may be required to return to reliable operation.
Platform handling of Fatal errors, and any efforts to limit the effects of
these errors, is platform implementation specific. (PCIe 6.0.1, sec
6.2.2.2.1 Fatal Errors).

- Non-Fatal Errors

Non-fatal errors are uncorrectable errors which cause a particular
transaction to be unreliable but the Link is otherwise fully functional.
Isolating Non-fatal from Fatal errors provides Requester/Receiver logic in
a device or system management software the opportunity to recover from the
error without resetting the components on the Link and disturbing other
transactions in progress. Devices not associated with the transaction in
error are not impacted by the error.  (PCIe 6.0.1, sec 6.2.2.2.1 Non-Fatal
Errors).

## What the kernel do?

The Linux kernel supports both the OS native and firmware first modes in
AER and DPC drivers. The error recovery API is defined in `struct
pci_error_handlers`, and the recovery process is performed in several
stages in pcie_do_recovery(). One main difference in handling PCIe errors
is that the kernel only resets the link when a fatal error is detected.

## Questions

1. Should kernel panic when fatal errors occur without AER recovery?

IMHO, the answer is NO. The AER driver handles both fatal and non-fatal
errors, and I have not found any panic changes in the recovery path in OS
native mode.

As far as I know, on many X86 platforms, struct `acpi_hest_generic_status::error_severity`
is set as CPER_SEV_FATAL in firmware first mode. As a result, kernel will
panic immediately in ghes_proc() when fatal AER errors occur, and there
is no chance to handle the error and perform recovery in AER driver.

For fatal and non-fatal errors, struct `acpi_hest_generic_status::error_severity`
should as CPER_SEV_RECOVERABLE, and struct `acpi_hest_generic_data::error_severity`
should reflect its real severity. Then, the kernel is equivalent to handling
PCIe errors in Firmware first mode as it does in OS native mode.
Please correct me if I am wrong.

However, I have changed my mind on this issue as I encounter a case where
a error propagation is detected due to fatal DLLP (Data Link Protocol
Error) error. A DLLP error occurred in the Compute node, causing the
node to panic because `struct acpi_hest_generic_status::error_severity` was
set as CPER_SEV_FATAL. However, data corruption was still detected in the
storage node by CRC.

2. Should kernel panic when AER recovery failed?

This question is actually a TODO that was added when the AER driver was
first upstreamed 17 years ago, and it is still relevant today. The kernel
does not proactively panic regardless of the error types occurring in OS
native mode. The DLLP error propagation case indicates that the kernel
might should panic when recovery failed?

3. Should DPC be enabled by default to contain fatal and non-fatal error?

According to the PCIe specification, DPC halts PCIe traffic below a
Downstream Port after an unmasked uncorrectable error is detected at or
below the Port, avoiding the potential spread of any data corruption.

The kernel configures DPC to be triggered only on ERR_FATAL. Literally
speaking, only fatal error have the potential spread of any data
corruption? In addition, the AER Severity is programable by the
Uncorrectable Error Severity Register (Offset 0Ch in PCIe AER cap). If a
default fatal error, e.g. DLLP, set as non-fatal, DPC will not be
triggered.


Looking forward to any comments and reply :)

Thank you.

Best Regards,
Shuai


[1] https://github.com/torvalds/linux/commit/6c2b374d74857e892080ee726184ec1d15e7d4e4#diff-fea64904d30501b59d2e948189bbedc476fc270ed4c15e4ae29d7f0efd06771aR438









