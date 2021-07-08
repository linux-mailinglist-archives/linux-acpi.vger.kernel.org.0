Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA48E3C18E3
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jul 2021 20:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhGHSLl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Jul 2021 14:11:41 -0400
Received: from foss.arm.com ([217.140.110.172]:35956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhGHSLl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Jul 2021 14:11:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0A2FD6E;
        Thu,  8 Jul 2021 11:08:58 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E94253F66F;
        Thu,  8 Jul 2021 11:08:57 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 00/13] mailbox: pcc: Add support for PCCT extended PCC subspaces
Date:   Thu,  8 Jul 2021 19:08:38 +0100
Message-Id: <20210708180851.2311192-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Though the series is about adding support for PCCT extended PCC subspaces,
except one patch, remaining are either preparatory or clean up to add
the PCCT extended PCC subspaces. Only patch 12 adds the support of extended
PCC type3/4 subspaces.

The main change affecting your is the change in pcc_mbox_request_channel
to avoid clien driver using con_priv member which is designed for controller
private pointer rather than for client's to use that.

Shared memory region accesses could be consolidated but I am planning to
take that up later as some drivers are using different types of mappings,
yet to figure out on how to consolidate that aspect.

Regards,
Sudeep

Sudeep Holla (13):
  mailbox: pcc: Fix doxygen comments
  ACPI: CPPC: Fix doxygen comments
  mailbox: pcc: Refactor all PCC channel information into a structure
  mailbox: pcc: Consolidate subspace interrupt information parsing
  mailbox: pcc: Consolidate subspace doorbell register parsing
  mailbox: pcc: Add pcc_mbox_chan structure to hold shared memory region info
  mailbox: pcc: Use PCC mailbox channel pointer instead of standard
  mailbox: pcc: Rename doorbell ack to platform interrupt ack register
  mailbox: pcc: Add PCC register bundle and associated accessor functions
  mailbox: pcc: Avoid accessing PCCT table in pcc_send_data and pcc_mbox_irq
  mailbox: pcc: Drop handling invalid bit-width in {read,write}_register
  mailbox: pcc: Add support for PCCT extended PCC subspaces(type 3/4)
  mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe

 drivers/acpi/cppc_acpi.c               |  50 +--
 drivers/hwmon/xgene-hwmon.c            |  35 +-
 drivers/i2c/busses/i2c-xgene-slimpro.c |  33 +-
 drivers/mailbox/pcc.c                  | 590 +++++++++++++++----------
 include/acpi/pcc.h                     |  21 +-
 5 files changed, 420 insertions(+), 309 deletions(-)

--
2.25.1

