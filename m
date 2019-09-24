Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3677DBD08D
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Sep 2019 19:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439397AbfIXRZv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Sep 2019 13:25:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:18361 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438977AbfIXRZv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Sep 2019 13:25:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 10:25:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; 
   d="gz'50?scan'50,208,50";a="200977240"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Sep 2019 10:25:41 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iCoZI-000C6O-W1; Wed, 25 Sep 2019 01:25:40 +0800
Date:   Wed, 25 Sep 2019 01:24:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild-all@01.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/5] ACPI / utils: Introduce acpi_dev_hid_uid_match()
 helper
Message-ID: <201909250100.SW9as0ET%lkp@intel.com>
References: <20190924120153.8382-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="odbdbkqrr7kuauxc"
Content-Disposition: inline
In-Reply-To: <20190924120153.8382-2-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--odbdbkqrr7kuauxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pm/linux-next]
[cannot apply to v5.3 next-20190920]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/ACPI-utils-Describe-function-parameters-in-kernel-doc/20190924-230504
base:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from init/main.c:30:0:
>> include/linux/acpi.h:665:50: warning: 'struct acpi_device' declared inside parameter list will not be visible outside of this definition or declaration
    static inline bool acpi_dev_hid_uid_match(struct acpi_device *adev,
                                                     ^~~~~~~~~~~

vim +665 include/linux/acpi.h

   664	
 > 665	static inline bool acpi_dev_hid_uid_match(struct acpi_device *adev,
   666						  const char *hid2, const char *uid2)
   667	{
   668		return false;
   669	}
   670	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--odbdbkqrr7kuauxc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ZwAA

--odbdbkqrr7kuauxc--
