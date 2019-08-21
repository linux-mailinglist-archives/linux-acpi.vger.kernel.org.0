Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E4A97DA5
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2019 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfHUOxO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Aug 2019 10:53:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726960AbfHUOxO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Aug 2019 10:53:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C3CF06E4B87B7D1AE8DE;
        Wed, 21 Aug 2019 22:53:06 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 21 Aug 2019 22:52:58 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Keith Busch <keith.busch@intel.com>, <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/4 V4] ACPI: Support generic initiator proximity domains
Date:   Wed, 21 Aug 2019 22:52:38 +0800
Message-ID: <20190821145242.2330-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch set has been sitting around for a long time without significant
review.  I would appreciate it very much if anyone has time to take a look.

One outstanding question to highlight in this series is whether
we should assume all ACPI supporting architectures support Generic
Initiator domains, or whether to introduce an
ARCH_HAS_GENERIC_INITIATOR_DOMAINS entry in Kconfig.

Change since V3.
* Rebase.

Changes since RFC V2.
* RFC dropped as now we have x86 support, so the lack of guards in in the
  ACPI code etc should now be fine.
* Added x86 support.  Note this has only been tested on QEMU as I don't have
  a convenient x86 NUMA machine to play with.  Note that this fitted together
  rather differently form arm64 so I'm particularly interested in feedback
  on the two solutions.

Since RFC V1.
* Fix incorrect interpretation of the ACPI entry noted by Keith Busch
* Use the acpica headers definitions that are now in mmotm.

It's worth noting that, to safely put a given device in a GI node, may
require changes to the existing drivers as it's not unusual to assume
you have local memory or processor core. There may be further constraints
not yet covered by this patch.

Original cover letter...

ACPI 6.3 introduced a new entity that can be part of a NUMA proximity domain.
It may share such a domain with the existing options (memory, CPU etc) but it
may also exist on it's own.

The intent is to allow the description of the NUMA properties (particularly
via HMAT) of accelerators and other initiators of memory activity that are not
the host processor running the operating system.

This patch set introduces 'just enough' to make them work for arm64 and x86.
It should be trivial to support other architectures, I just don't suitable
NUMA systems readily available to test.

There are a few quirks that need to be considered.

1. Fall back nodes
******************

As pre ACPI 6.3 supporting operating systems do not have Generic Initiator
Proximity Domains it is possible to specify, via _PXM in DSDT that another
device is part of such a GI only node.  This currently blows up spectacularly.

Whilst we can obviously 'now' protect against such a situation (see the related
thread on PCI _PXM support and the  threadripper board identified there as
also falling into the  problem of using non existent nodes
https://patchwork.kernel.org/patch/10723311/ ), there is no way to  be sure
we will never have legacy OSes that are not protected  against this.  It would
also be 'non ideal' to fallback to  a default node as there may be a better
(non GI) node to pick  if GI nodes aren't available.

The work around is that we also have a new system wide OSC bit that allows
an operating system to 'announce' that it supports Generic Initiators.  This
allows, the firmware to us DSDT magic to 'move' devices between the nodes
dependent on whether our new nodes are there or not.

2. New ways of assigning a proximity domain for devices
*******************************************************

Until now, the only way firmware could indicate that a particular device
(outside the 'special' set of cpus etc) was to be found in a particular
Proximity Domain by the use of _PXM in DSDT.

That is equally valid with GI domains, but we have new options. The SRAT
affinity structure includes a handle (ACPI or PCI) to identify devices
with the system and specify their proximity domain that way.  If both _PXM
and this are provided, they should give the same answer.

For now this patch set completely ignores that feature as we don't need
it to start the discussion.  It will form a follow up set at some point
(if no one else fancies doing it).
 

Jonathan Cameron (4):
  ACPI: Support Generic Initiator only domains
  arm64: Support Generic Initiator only domains
  x86: Support Generic Initiator only proximity domains
  ACPI: Let ACPI know we support Generic Initiator Affinity Structures

 arch/arm64/kernel/smp.c        |  8 +++++
 arch/x86/include/asm/numa.h    |  2 ++
 arch/x86/kernel/setup.c        |  1 +
 arch/x86/mm/numa.c             | 14 ++++++++
 drivers/acpi/bus.c             |  1 +
 drivers/acpi/numa.c            | 62 +++++++++++++++++++++++++++++++++-
 drivers/base/node.c            |  3 ++
 include/asm-generic/topology.h |  3 ++
 include/linux/acpi.h           |  1 +
 include/linux/nodemask.h       |  1 +
 include/linux/topology.h       |  7 ++++
 11 files changed, 102 insertions(+), 1 deletion(-)

-- 
2.20.1

