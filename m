Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF8E2D9816
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Dec 2020 13:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393498AbgLNMjk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Dec 2020 07:39:40 -0500
Received: from foss.arm.com ([217.140.110.172]:46712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391213AbgLNMjk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Dec 2020 07:39:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BD1DD6E;
        Mon, 14 Dec 2020 04:38:54 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0726B3F66B;
        Mon, 14 Dec 2020 04:38:52 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org
Cc:     yousaf.kaukab@suse.com, jeremy.linton@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH v2 0/4]  cppc_cpufreq: fix, clarify and improve support
Date:   Mon, 14 Dec 2020 12:38:19 +0000
Message-Id: <20201214123823.3949-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi guys,

I'm sending v2 of some of the patches at [1] in light of the discussions
at [2].

v2:
 - Patches 1-3 are trivial rebase on linux next 20201211, with conflicts
   fixed after eliminating what previously was "[PATCH 4/8] cppc_cpufreq:
   replace per-cpu structures with lists." Therefore, I have kept
   Viresh's acks.

 - Patch 4 is a merge between:
     - [PATCH 4/8] cppc_cpufreq: replace per-cpu structures with lists
     - [PATCH] cppc_cpufreq: optimise memory allocation for HW and NONE
       coordination
   both found at [1].

   This functionality was introducing the problem at [2] and it's fixed
   in this version by bailing out of driver registration if a _CPC entry
   is not found for a CPU.

   Yousaf, it would be great if you can test this and make sure it
   matches your expectations.

   Rafael, Viresh if you think this last patch introduces too many
   changes, you can skip it for 5.11 which is around the corner and
   have more time for review for 5.12. I've added more eyes in the review
   list.


All patches are based on linux next 20201211 after patch at [3] is
applied.

[1] https://lore.kernel.org/linux-pm/20201105125524.4409-1-ionela.voinescu@arm.com/#t
[2] https://lore.kernel.org/linux-pm/20201210142139.20490-1-yousaf.kaukab@suse.com/
[3] https://lore.kernel.org/linux-pm/20201214120740.10948-1-ionela.voinescu@arm.com/

Ionela Voinescu (4):
  cppc_cpufreq: use policy->cpu as driver of frequency setting
  cppc_cpufreq: clarify support for coordination types
  cppc_cpufreq: expose information on frequency domains
  cppc_cpufreq: replace per-cpu data array with a list

 .../ABI/testing/sysfs-devices-system-cpu      |   3 +-
 drivers/acpi/cppc_acpi.c                      | 141 ++++++------
 drivers/cpufreq/cppc_cpufreq.c                | 204 ++++++++++--------
 include/acpi/cppc_acpi.h                      |   6 +-
 4 files changed, 181 insertions(+), 173 deletions(-)

-- 
2.29.2.dirty

