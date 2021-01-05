Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F22EA719
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 10:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbhAEJNd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 04:13:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:50266 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbhAEJNd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Jan 2021 04:13:33 -0500
IronPort-SDR: 9dWxisid2VFSwsHk7tYQSh7WarXU1RbZOWNmehwqR99hCTbJZ3cUjk/8Cfb67DvIf7GzrFbG5n
 tckTsTj32GEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156862069"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="156862069"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 01:11:47 -0800
IronPort-SDR: ilck+Uh3JiEhKLcwzP0vu24j5mUEA0/QLeMwHi8jAYW6WO37OI3IIQgdzm2TEGXMryOt1fBn9/
 A8GMzagDjOVA==
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="378794952"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 01:11:45 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
        heikki.krogerus@linux.intel.com, rafael@kernel.org
Cc:     bard.liao@intel.com
Subject: [PATCH 0/2] Revert "device property: Keep secondary firmware node secondary by type"
Date:   Tue,  5 Jan 2021 17:11:44 +0800
Message-Id: <20210105091146.25422-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

While the commit d5dcce0 ("device property: Keep secondary firmware
node secondary by type")
describes everything correct in its commit message the change it made does
the opposite and original commit c15e1bd ("device property: Fix the
secondary firmware node handling in set_primary_fwnode()") was fully
correct. Thus, revert the former one here and improve documentation.

Bard Liao (2):
  Revert "device property: Keep secondary firmware node secondary by
    type"
  device property: add description of fwnode cases

 drivers/base/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.17.1

