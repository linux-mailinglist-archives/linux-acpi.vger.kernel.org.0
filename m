Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582083AA839
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 02:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFQAoj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 20:44:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:50410 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhFQAoi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 20:44:38 -0400
IronPort-SDR: Oo+CyOqD0/Ee27Vl0fK5Bxsp+DiGLzCDTQ2FMiUmE0Hy45LnGPU66tez7sptgSY6lxw2o+QSoe
 2JlgmTGwoPEA==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="206097893"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="206097893"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 17:42:31 -0700
IronPort-SDR: 0ZDQ3heCk7d8sWgkK+uJ75YifobXY8g1yDR4ju7fsak6k+xLccplvf54fuLBvYOgj0mCOCDeyd
 PIDyOh5vwbeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="554227126"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Jun 2021 17:42:29 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltg72-0001ep-PR; Thu, 17 Jun 2021 00:42:28 +0000
Date:   Thu, 17 Jun 2021 08:42:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [RFC PATCH] ACPI: scan: __acpi_device_add() can be static
Message-ID: <20210617004201.GA151976@f10223fe78f9>
References: <3070024.5fSG56mABF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3070024.5fSG56mABF@kreacher>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

drivers/acpi/scan.c:660:5: warning: symbol '__acpi_device_add' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 scan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index be8b149244220..f30ab5a55a9a4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -657,8 +657,8 @@ static int acpi_tie_acpi_dev(struct acpi_device *adev)
 	return 0;
 }
 
-int __acpi_device_add(struct acpi_device *device,
-		      void (*release)(struct device *))
+static int __acpi_device_add(struct acpi_device *device,
+			     void (*release)(struct device *))
 {
 	struct acpi_device_bus_id *acpi_device_bus_id;
 	int result;
