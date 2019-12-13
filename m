Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D11D11E097
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 10:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLMJ1m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 04:27:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61528 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfLMJ1i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Dec 2019 04:27:38 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 55d164afaf331298; Fri, 13 Dec 2019 10:27:36 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 00/10] cpuidle: intel_idle: Use ACPI _CST to get idle states information
Date:   Fri, 13 Dec 2019 10:09:40 +0100
Message-ID: <3950312.2WmFeOdZGY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

The RFC of this does not seem to have attracted much attention, so here goes
the first non-RFC revision.

The purpose of this set of patches is to allow the intel_idle driver to use
C-states information from ACPI _CST on systems where the processor is not
recognized by it.

The first five patches are preparatory (please look into the changelogs for
details) and are not expected to make any functional difference.

Patch [06/10] adds ACPI _CST support to intel_idle so that _CST is used when
the driver does not have a dedicated list of C-states for the given processor.

Patch [07/10] is an update of https://patchwork.kernel.org/patch/11256815/.

Patch [08/10] changes intel_idle to also use ACPI _CST in specific cases when
there is a tables of C-states for the given processor in the driver (it will
use the _CST information to decide which C-state to enable by default then).

Patch [09/10] adds a module parameter called "no_acpi" that can be used to
prevent intel_idle from using ACPI _CST via the kernel command line.

Finally, the last patch makes intel_idle use ACPI _CST, if available, on all
server systems supported by it.

This has been lightly tested on a Dell XPS13 9360 (with an additional patch to
set use_acpi for Kaby Lake).  The difference between using the idle states list
from _CST and the built-in one generally appears to be that in the latter case
the processor spends more time in package C-state when the system is idle.

If there are any concerns about this series, please let me know.

For easier access, the patches are available from the intel_idle+acpi branch
in the linux-pm.git tree.

Thanks,
Rafael



