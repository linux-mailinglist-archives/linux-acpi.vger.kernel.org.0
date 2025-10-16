Return-Path: <linux-acpi+bounces-17834-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990C9BE52DF
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 21:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F96481BF7
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 19:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E50233155;
	Thu, 16 Oct 2025 19:08:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B6643AA4;
	Thu, 16 Oct 2025 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641732; cv=none; b=F7w4YWDr7nPA3M70XNqMW+O9UT9kFRkYuJrMxzpGxK/RVWeOL5Y2nzwzfwnFpuJuwOFmAHmPO5qIGJ41u8aNZTaWet+IRofaGGTYT61JECRavjx0046RwTqhIBCeYYKQSlCEAZ8V5G8O6aImtuzBS2HReaCyX14JGcAJXPSdeeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641732; c=relaxed/simple;
	bh=DGRUdxYMmHlCxMQZWbBBusbPgZXAp8yA1XaYfhg88kU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lO4a6/WVFwfcx4Ucvd/zjch1v4nwQ7UFQHeBfcnCgGhgD5SpTH2S6YxEHAUY3E7LQ+uhWYfbXeONh3ZufLBpfXQ6nHexEdOJSMZmUOTDKVlasUXZZDccZLykoFxNzK8c6SegmgmzHX+yA9LEKKSNZFMYfcdcvk9xdXsMzuEUus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A9321688;
	Thu, 16 Oct 2025 12:08:41 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E04803F66E;
	Thu, 16 Oct 2025 12:08:47 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 0/6] mailbox: pcc: Refactor and improve initialisation and
 interrupt handling
Date: Thu, 16 Oct 2025 20:08:14 +0100
Message-Id: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKBC8WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Mz3YLk5PjcpPjSgpTEktRi3RTLFBMjC0sLUxMDAyWgpoKi1LTMCrC
 B0bG1tQAMVXqJYAAAAA==
X-Change-ID: 20251016-pcc_mb_updates-d9d428985400
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
X-Mailer: b4 0.14.3

This series refines and stabilizes the PCC mailbox driver to improve
initialisation order, interrupt handling, and completion signaling.

It begins by reverting a previous patch that introduced redundant shared
buffer management, simplifying the driver and restoring consistency with the
mailbox core framework. It is essential to have a proper baseline for the
main changes in the series.

Subsequent patches add proper completion reporting, clarify completion mode
selection, and fix subtle sequencing and interrupt issues to ensure
predictable, robust operation across ACPI-based PCC implementations.

Specifically, the series:

1. Removes redundant shared buffer logic, reverting an earlier change that
   duplicated existing mailbox core features and caused maintenance overhead.

2. Adds ->last_tx_done() support to allow polling clients to verify
   transmission completion without relying on interrupts.

3. Explicitly configures completion modes (txdone_irq or txdone_poll) based
   on ACPI PCCT doorbell capability flag, ensuring the correct completion
   mechanism is chosen for each platform.

4. Marks transmit completion in the IRQ handler by invoking mbox_chan_txdone(),
   preventing timeouts and ensuring proper synchronization for interrupt-driven
   transfers.

5. Initializes the shared memory region (SHMEM) before binding clients,
   preventing race conditions where clients could access uninitialized memory.

6. Clears any pending responder interrupts before enabling IRQs, avoiding
   spurious or false interrupts during startup.

Together, these updates make the PCC mailbox driver cleaner, more reliable,
and fully aligned with the mailbox framework's expectations, improving
determinism and robustness across different hardware platforms.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
Sudeep Holla (6):
      Revert "mailbox/pcc: support mailbox management of the shared buffer"
      mailbox: pcc: Wire up ->last_tx_done() for PCC channels
      mailbox: pcc: Set txdone_irq/txdone_poll based on PCCT flags
      mailbox: pcc: Mark Tx as complete in PCC IRQ handler
      mailbox: pcc: Initialize SHMEM before binding the channel with the client
      mailbox: pcc: Clear any pending responder interrupts before enabling it

 drivers/mailbox/pcc.c | 118 ++++++++++----------------------------------------
 include/acpi/pcc.h    |  29 -------------
 2 files changed, 23 insertions(+), 124 deletions(-)
---
base-commit: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
change-id: 20251016-pcc_mb_updates-d9d428985400


-- 
Regards,
Sudeep


