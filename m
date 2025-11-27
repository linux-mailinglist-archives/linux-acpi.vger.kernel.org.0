Return-Path: <linux-acpi+bounces-19316-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E37CC8ECC6
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EFF34E9A95
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F158D333753;
	Thu, 27 Nov 2025 14:41:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B99C3126AF;
	Thu, 27 Nov 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254462; cv=none; b=LKt+MkGsH3diXb8FdIq0P2gYvhk2qbnYf3XaQgBCPWBAZ3vqbGWnyEugfARYo/D1bbPcCQ+vSqVphuenJdGL63AAbgkmYKOsXSQvzYMfobaCx3qv89lJ8qFamBxb5hZQPUA8QsPKo0zQmgwWG8b+Oi3EHJxa15UDKRpQFFQTO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254462; c=relaxed/simple;
	bh=K7iJcFdKjnMQB4UGHADn6py6ZOatpUwsYAifbczzqh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8Jz3uz7m1A7FKtfzdBXUxYvGRbVAl83t9ahbCiCeEHLdJ2MdNXBhaGsYozUKh/pbCkO/TfAiboI1RPcm5Pkhx1sQ53ebzMr58ha5IKpgwS0EO4+FZXmc92xihTfJD8z3kQFYRTiilt8NgegUMUig6HKjWj/eFwC5PVI9JALVqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F4861063;
	Thu, 27 Nov 2025 06:40:53 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DD6A3F73B;
	Thu, 27 Nov 2025 06:40:59 -0800 (PST)
Date: Thu, 27 Nov 2025 14:40:56 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>,
	Huisong Li <lihuisong@huawei.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 0/6] mailbox: pcc: Refactor and improve initialisation
 and interrupt handling
Message-ID: <20251127-ancient-baboon-of-opportunity-5f773d@sudeepholla>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>

Hi Jassi,

On Thu, Oct 16, 2025 at 08:08:14PM +0100, Sudeep Holla wrote:
> This series refines and stabilizes the PCC mailbox driver to improve
> initialisation order, interrupt handling, and completion signaling.
> 
Are you happy to pull these patches directly from the list or do you
prefer me to send you pull request or do you want me to direct this via
ACPI/Rafael's tree. Please advice.

> It begins by reverting a previous patch that introduced redundant shared
> buffer management, simplifying the driver and restoring consistency with the
> mailbox core framework. It is essential to have a proper baseline for the
> main changes in the series.
> 
> Subsequent patches add proper completion reporting, clarify completion mode
> selection, and fix subtle sequencing and interrupt issues to ensure
> predictable, robust operation across ACPI-based PCC implementations.
> 
> Specifically, the series:
> 
> 1. Removes redundant shared buffer logic, reverting an earlier change that
>    duplicated existing mailbox core features and caused maintenance overhead.
> 
> 2. Adds ->last_tx_done() support to allow polling clients to verify
>    transmission completion without relying on interrupts.
> 
> 3. Explicitly configures completion modes (txdone_irq or txdone_poll) based
>    on ACPI PCCT doorbell capability flag, ensuring the correct completion
>    mechanism is chosen for each platform.
> 
> 4. Marks transmit completion in the IRQ handler by invoking mbox_chan_txdone(),
>    preventing timeouts and ensuring proper synchronization for interrupt-driven
>    transfers.
> 
> 5. Initializes the shared memory region (SHMEM) before binding clients,
>    preventing race conditions where clients could access uninitialized memory.
> 
> 6. Clears any pending responder interrupts before enabling IRQs, avoiding
>    spurious or false interrupts during startup.
> 
> Together, these updates make the PCC mailbox driver cleaner, more reliable,
> and fully aligned with the mailbox framework's expectations, improving
> determinism and robustness across different hardware platforms.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> Sudeep Holla (6):
>       Revert "mailbox/pcc: support mailbox management of the shared buffer"
>       mailbox: pcc: Wire up ->last_tx_done() for PCC channels
>       mailbox: pcc: Set txdone_irq/txdone_poll based on PCCT flags
>       mailbox: pcc: Mark Tx as complete in PCC IRQ handler
>       mailbox: pcc: Initialize SHMEM before binding the channel with the client
>       mailbox: pcc: Clear any pending responder interrupts before enabling it
> 
>  drivers/mailbox/pcc.c | 118 ++++++++++----------------------------------------
>  include/acpi/pcc.h    |  29 -------------
>  2 files changed, 23 insertions(+), 124 deletions(-)
> ---
> base-commit: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
> change-id: 20251016-pcc_mb_updates-d9d428985400
> 
> 
> -- 
> Regards,
> Sudeep
> 

-- 
Regards,
Sudeep

