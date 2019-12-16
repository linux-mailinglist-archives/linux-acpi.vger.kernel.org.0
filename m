Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53441209E7
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 16:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfLPPjc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 10:39:32 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41060 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728417AbfLPPjc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 10:39:32 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B4EE5CC4E77E0A584EE6;
        Mon, 16 Dec 2019 23:39:28 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Mon, 16 Dec 2019 23:39:18 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
CC:     Keith Busch <keith.busch@intel.com>, <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tao Xu <tao3.xu@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH V6 7/7] docs: mm: numaperf.rst Add brief description for access class 1.
Date:   Mon, 16 Dec 2019 23:38:09 +0800
Message-ID: <20191216153809.105463-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191216153809.105463-1-Jonathan.Cameron@huawei.com>
References: <20191216153809.105463-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Try to make minimal changes to the document which already describes
access class 0 in a generic fashion (including IO initiatiors that
are not CPUs).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/admin-guide/mm/numaperf.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
index a80c3c37226e..327c0d72692d 100644
--- a/Documentation/admin-guide/mm/numaperf.rst
+++ b/Documentation/admin-guide/mm/numaperf.rst
@@ -56,6 +56,11 @@ nodes' access characteristics share the same performance relative to other
 linked initiator nodes. Each target within an initiator's access class,
 though, do not necessarily perform the same as each other.
 
+The access class "1" is used to allow differentiation between initiators
+that are CPUs and hence suitable for generic task scheduling, and
+IO initiators such as GPUs and CPUs.  Unlike access class 0, only
+nodes containing CPUs are considered.
+
 ================
 NUMA Performance
 ================
@@ -88,6 +93,9 @@ The latency attributes are provided in nanoseconds.
 The values reported here correspond to the rated latency and bandwidth
 for the platform.
 
+Access class 0, takes the same form, but only includes values for CPU to
+memory activity.
+
 ==========
 NUMA Cache
 ==========
-- 
2.19.1

