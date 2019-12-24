Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B536712A44B
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2019 23:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfLXWTI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Dec 2019 17:19:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:44885 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfLXWTI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Dec 2019 17:19:08 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2019 14:19:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,353,1571727600"; 
   d="scan'208";a="214256959"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Dec 2019 14:19:06 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ijsW9-000GjQ-CF; Wed, 25 Dec 2019 06:19:05 +0800
Date:   Wed, 25 Dec 2019 06:18:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH pm] power: avs: cpr_get_opp_hz_for_req() can be static
Message-ID: <20191224221834.qtzuikxnnfh7twji@4978f4969bb8>
References: <201912250622.SScsrif7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912250622.SScsrif7%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Fixes: bf6910abf548 ("power: avs: Add support for CPR (Core Power Reduction)")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 qcom-cpr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
index a3187973bbb5fd..98c9ee4075ae9d 100644
--- a/drivers/power/avs/qcom-cpr.c
+++ b/drivers/power/avs/qcom-cpr.c
@@ -1078,8 +1078,8 @@ static unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
 	return fuse_corner;
 }
 
-unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
-				     struct device *cpu_dev)
+static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
+					    struct device *cpu_dev)
 {
 	u64 rate = 0;
 	struct device_node *ref_np;
