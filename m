Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E9B2B89F3
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 03:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgKSCFl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Nov 2020 21:05:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7649 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgKSCFl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2020 21:05:41 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cc3102cdVz15Kfq;
        Thu, 19 Nov 2020 10:05:24 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.144) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 10:05:30 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/1] acpi/nfit: fix badrange insertion in nfit_handle_mce()
Date:   Thu, 19 Nov 2020 09:57:45 +0800
Message-ID: <20201119015746.1990-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

v1 --> v2:
Modified the title and description of the patch.

Zhen Lei (1):
  acpi/nfit: fix badrange insertion in nfit_handle_mce()

 drivers/acpi/nfit/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.26.0.106.g9fadedd


