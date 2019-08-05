Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0449B81F18
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2019 16:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfHEOaA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Aug 2019 10:30:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:21116 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHEOaA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Aug 2019 10:30:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 07:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="185333614"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 05 Aug 2019 07:29:59 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Rafael Wysocki <rafael@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/3] HMAT node online fixes
Date:   Mon,  5 Aug 2019 08:27:03 -0600
Message-Id: <20190805142706.22520-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Hi Rafael,

These are just some fixes from a while ago to work correctly with memory
node onlining, but haven't been merged in yet. I've included a fix from
Dan, but had to modify it slightly for conflicts. I think it makes most
sense for this to go through the acpi tree, but please let me know if
you think this should go through a different route.

Thanks!

Dan Williams (1):
  acpi/hmat: Skip publishing target info for nodes with no online memory

Keith Busch (2):
  hmat: Register memory-side cache after parsing
  hmat: Register attributes for memory hot add

 drivers/acpi/hmat/hmat.c | 143 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 114 insertions(+), 29 deletions(-)

-- 
2.14.4

