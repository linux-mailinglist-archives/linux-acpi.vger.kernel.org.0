Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAEDB15F6D8
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 20:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbgBNT2y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 14:28:54 -0500
Received: from a3.inai.de ([88.198.85.195]:45284 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbgBNT2x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 14:28:53 -0500
Received: by a3.inai.de (Postfix, from userid 25121)
        id 224915872CEC1; Fri, 14 Feb 2020 20:28:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 1E15560C55E44
        for <linux-acpi@vger.kernel.org>; Fri, 14 Feb 2020 20:28:52 +0100 (CET)
Date:   Fri, 14 Feb 2020 20:28:52 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     linux-acpi@vger.kernel.org
Subject: Linux hangs at ACPI init on Medion P15648 MD63490
Message-ID: <nycvar.YFH.7.76.2002141734590.24119@n3.vanv.qr>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Greetings.


I have a problem with a certain x86 laptop, and judging from the
kernel's output, this looks very much like a broken ACPI table.
Versions tried are 5.3.8 (Fedora31 liveimage), 5.5.2 (openSUSE
Tumbleweed installer) and 5.6.0-rc1+
(b19e8c68470385dd2c5440876591fddb02c8c402; self compile), all
exhibiting the same hang.

The last messages emitted by 5.6.0-rc1+ are:

	ACPI: 11 ACPI AML tables successfully acquired and loaded
	ACPI: EC: EC started
	ACPI: EC: interrupt blocked
	ACPI: \: Used as first EC
	ACPI: \: GPE=0x10, IRQ=-1, EC_CMD/EC_SC=0x66, EC_DATA=0x62
	ACPI: EC: Boot ECDT EC used to handle transactions
	<hang>

The full boot procedure is made available at
http://inai.de/files/m921.mp4 [79MB].
Curiously, FreeBSD 12.1 can be booted without issues, so either they
already workaround the issue, or don't trigger it in the first place.

After about 20 minutes, the kernel issues a stack trace.
http://inai.de/files/m922.mp4 [4.2M]; this seems to repeat every 
20 minutes:

	Task swapper blocked for more than 491 seconds.
	schedule
	schedule_timeout
	__down_timeout
	down_timeout
	acpi_os_wait_semaphore
	acpi_ex_system_wait_semaphore
	acpi_ev_acquire_global_lock
	acpi_ex_acquire_mutex_object
	acpi_ex_acquire_global_lock
	acpi_ex_write_data_to_field
	acpi_ex_store_object_to_node
	acpi_ex_store
	acpi_ex_opcode_1A_1T_1R
	acpi_ds_exec_end_op
	acpi_ps_parse_loop
	[a few frames more]

For comparison, a (vastly) different laptop with a proper firmware,
the EC messages go like this:

	<Fujitsu U728 for comparison>
	ACPI: EC: EC started
	ACPI: EC: interrupt blocked
	ACPI: \_SB_.PCI0.LPCB.EC__: Used as first EC
	ACPI: \_SB_.PCI0.LPCB.EC__: GPE=0x22, EC_CMD/EC_SC=0x66, EC_DATA=0x62
	ACPI: \_SB_.PCI0.LPCB.EC__: Boot DSDT EC used to handle transactions
	ACPI: Interpreter enabled

It kind of makes sense that, if "\" is seen as an EC in the Medion that 
it is not going to work.
