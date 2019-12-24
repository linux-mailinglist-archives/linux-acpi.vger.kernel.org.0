Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7E12A449
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2019 23:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfLXWTI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Dec 2019 17:19:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:58177 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfLXWTI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Dec 2019 17:19:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2019 14:19:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,353,1571727600"; 
   d="scan'208";a="417663535"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Dec 2019 14:19:05 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ijsW9-000GhO-8K; Wed, 25 Dec 2019 06:19:05 +0800
Date:   Wed, 25 Dec 2019 06:18:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [pm:bleeding-edge 59/60] drivers/power/avs/qcom-cpr.c:1081:15:
 sparse: sparse: symbol 'cpr_get_opp_hz_for_req' was not declared. Should it
 be static?
Message-ID: <201912250622.SScsrif7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   89eba9e38dc4ed4576eaf7711c60403568663291
commit: bf6910abf54871b0e976e52f56fb3b3dd1b90e48 [59/60] power: avs: Add support for CPR (Core Power Reduction)
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        git checkout bf6910abf54871b0e976e52f56fb3b3dd1b90e48
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/power/avs/qcom-cpr.c:1081:15: sparse: sparse: symbol 'cpr_get_opp_hz_for_req' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
