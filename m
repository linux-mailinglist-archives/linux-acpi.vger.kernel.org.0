Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E5838D1CD
	for <lists+linux-acpi@lfdr.de>; Sat, 22 May 2021 01:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEUXET (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 May 2021 19:04:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:11009 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhEUXET (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 May 2021 19:04:19 -0400
IronPort-SDR: 9S+3lxPu8o/K0Ny4NvUq293XbEGYbHLPlCbnZugmjpCdrsjXhtT0AsaRTS6wmxoQz0N+8ripX+
 66d081kgM9Bg==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="265494907"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265494907"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 16:02:54 -0700
IronPort-SDR: sPTRrcZbr59EtzrjGvSGefjwgy9GSpt5ayJhmin502Zg+I7XsXRCnbckxwCiyQMEASuNg+3IWm
 Ab4yXELBRL0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="544253753"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga001.fm.intel.com with ESMTP; 21 May 2021 16:02:54 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 0/1] Mutex memory leak fix
Date:   Fri, 21 May 2021 15:28:07 -0700
Message-Id: <20210521222808.2174134-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, we fixed a memory leak from a patch that was added to kernel
in the previous ACPICA release. Please take this patch for the rc series.

Thanks,

Erik

Erik Kaneda (1):
  ACPICA: Clean up context mutex during object deletion

 drivers/acpi/acpica/utdelete.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.29.2

