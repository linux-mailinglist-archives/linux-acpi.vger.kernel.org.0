Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DC51F5498
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jun 2020 14:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgFJMXo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jun 2020 08:23:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64746 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbgFJMXm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2020 08:23:42 -0400
Received: from 89-64-83-71.dynamic.chello.pl (89.64.83.71) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 3bbe034ef495dd51; Wed, 10 Jun 2020 14:23:40 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dan Williams <dan.j.williams@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
Subject: [RFT][PATCH 0/3] ACPI: ACPICA / OSL: Avoid unmapping ACPI memory inside of the AML interpreter
Date:   Wed, 10 Jun 2020 14:17:04 +0200
Message-ID: <318372766.6LKUBsbRXE@kreacher>
In-Reply-To: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

This series is to address the problem with RCU synchronization occurring,
possibly relatively often, inside of acpi_ex_system_memory_space_handler(),
when the namespace and interpreter mutexes are held.

The basic idea is to avoid the actual unmapping of memory in
acpi_ex_system_memory_space_handler() by making it take the advantage of the
reference counting of memory mappings utilized by the OSL layer in Linux.

The basic assumption in patch [1/3] is that if the special
ACPI_OS_MAP_MEMORY_FAST_PATH() macro is present, it can be used to increment
the reference counter of a known-existing memory mapping in the OS layer
which then is dropped by the subsequent acpi_os_unmap_memory() without
unmapping the address range at hand.  That can be utilized by
acpi_ex_system_memory_space_handler() to prevent the reference counters of
all mappings used by it from dropping down to 0 (which also prevents the
address ranges associated with them from being unmapped) so that they can
be unmapped later (specifically, at the operation region deactivation time).

Patch [2/3] defers the unmapping even further, until the namespace and
interpreter mutexes are released, to avoid invoking the RCU synchronization
under theses mutexes.

Finally, patch [3/3] changes the OS layer in Linux to provide the
ACPI_OS_MAP_MEMORY_FAST_PATH() macro.

Note that if this macro is not defined, the code works the way it used to.

The series is available from the git branch at

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpica-osl

for easier testing.

Cheers,
Rafael



