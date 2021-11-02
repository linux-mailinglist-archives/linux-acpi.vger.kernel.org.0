Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E9F443580
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 19:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhKBS2n (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 14:28:43 -0400
Received: from foss.arm.com ([217.140.110.172]:41692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhKBS2n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Nov 2021 14:28:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E6B411B3;
        Tue,  2 Nov 2021 11:26:08 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DA2B3F7B4;
        Tue,  2 Nov 2021 11:26:07 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Robert Moore <robert.moore@intel.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH 0/3] ACPI: Add support for PCC Operation Region
Date:   Tue,  2 Nov 2021 18:25:39 +0000
Message-Id: <20211102182542.3460787-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This series adds support for ACPI PCC OpRegion added in ACPI 6.3
I understand that the ACPICA changes need to go via different route,
but I am posting it together to give complete narative/picture for
the review/discussion.

Regards,
Sudeep

Sudeep Holla (3):
  ACPICA: Fix wrong interpretation of PCC address
  ACPICA: Add support for PCC Opregion special context data
  ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype

 drivers/acpi/Kconfig           |   5 ++
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/acpica/evregion.c |  11 ++++
 drivers/acpi/acpica/exfield.c  |   7 +--
 drivers/acpi/bus.c             |   1 +
 drivers/acpi/pcc_opregion.c    | 111 +++++++++++++++++++++++++++++++++
 include/acpi/actypes.h         |   8 +++
 include/linux/acpi.h           |   6 ++
 8 files changed, 144 insertions(+), 6 deletions(-)
 create mode 100644 drivers/acpi/pcc_opregion.c

--
2.25.1

