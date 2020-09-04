Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5971025E0BB
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 19:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgIDR0j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 13:26:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53176 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgIDR0U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 13:26:20 -0400
Received: from 89-64-89-131.dynamic.chello.pl (89.64.89.131) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.468)
 id fdcf7f96b97809a9; Fri, 4 Sep 2020 19:26:17 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 0/6] ACPICA / ACPI: OSL: Rework GPE registers access code
Date:   Fri, 04 Sep 2020 19:19:26 +0200
Message-ID: <1748021.N9i9sLPJ40@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

The underlying issue here is that in Linux calling
acpi_os_read_memory() or acpi_os_write_memory() from an interrupt
handler is generally invalid, because these functions may attempt
to map memory on the fly.  It is only valid to call them from an
interrupt handler if it is known that there is a memory mapping
covering the physical address passed as the argument.

However, in that case using acpi_os_read_memory() or
acpi_os_write_memory() for accessing memory is inefficient, because
they need to look up the mapping in question every time in a global
list, and it would be much more straightforward to use the (known
already) logical address of the target memory region.

In ACPICA this problem affects GPE registers that are accessed
with the help of acpi_hw_read() and acpi_hw_write() which is
inefficient not just because they end up calling
acpi_os_read_memory() or acpi_os_write_memory() if the GPE
registers are located in system memory, but also because these
functions check things that need not be checked for GPE registers
in particular and they do that on every access.

This series of patches reworks the GPE register accesses in ACPICA
to be more efficient by omitting the unnecessary checks and making it
possible to use logical addresses directly if these registers are
located in system memory.

The first four patches modify ACPICA and the last two add the
requisite OS support to Linux on top of that.

Please refer to the changelogs of the patches for details.

Thanks,
Rafael



