Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9BB42F70A
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Oct 2021 17:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbhJOPjP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 15 Oct 2021 11:39:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:29674 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhJOPjO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Oct 2021 11:39:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="227825204"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="227825204"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 08:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="443226376"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 15 Oct 2021 08:37:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 08:37:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 08:37:06 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Fri, 15 Oct 2021 08:37:06 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: RE: [PATCH] ACPI, APEI, EINJ: Relax platform response timeout to 1
 second.
Thread-Topic: [PATCH] ACPI, APEI, EINJ: Relax platform response timeout to 1
 second.
Thread-Index: AQHXwXYcnnvz2STlF0WUG4W2+USWZ6vUMWeA
Date:   Fri, 15 Oct 2021 15:37:06 +0000
Message-ID: <4d492cef3640414d85ecfdb602ad6fa0@intel.com>
References: <20211015033817.16719-1-xueshuai@linux.alibaba.com>
In-Reply-To: <20211015033817.16719-1-xueshuai@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> We observe that the waiting time for DDR error injection is about 10 ms
> and that for PCIe error injection is about 500 ms in Arm platfrom.
>
> In this patch, we relax the response timeout to 1 second and allow user to
> pass the time out value as a argument.

Spinning for 1ms was maybe ok. Spinning for up to 1s seems like a bad idea.

This code is executed inside a mutex ... so maybe it is safe to sleep instead of spin?

-Tony
