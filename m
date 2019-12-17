Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C775C12304A
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 16:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfLQP3z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 17 Dec 2019 10:29:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:17746 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbfLQP3z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Dec 2019 10:29:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 07:29:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="247520868"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga002.fm.intel.com with ESMTP; 17 Dec 2019 07:29:54 -0800
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Dec 2019 07:29:54 -0800
Received: from fmsmsx101.amr.corp.intel.com ([169.254.1.124]) by
 FMSMSX113.amr.corp.intel.com ([169.254.13.86]) with mapi id 14.03.0439.000;
 Tue, 17 Dec 2019 07:29:54 -0800
From:   "Brown, Len" <len.brown@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] ACPI: processor: Make ACPI_PROCESSOR_CSTATE depend on
 ACPI_PROCESSOR
Thread-Topic: [PATCH] ACPI: processor: Make ACPI_PROCESSOR_CSTATE depend on
 ACPI_PROCESSOR
Thread-Index: AQHVtATgr90L2ltRnU+72Mog3gPr5qe+dYVw
Date:   Tue, 17 Dec 2019 15:29:53 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C9487D6EF6A5@fmsmsx101.amr.corp.intel.com>
References: <16614264.JRhOIQ9zEg@kreacher>
In-Reply-To: <16614264.JRhOIQ9zEg@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWE5OGVmMTEtNTY1Yy00ZGQ3LTljZDAtMWI2ZTUzNWNmZmU3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicTlXY1gyckZVYXNNUFJ6QVwvSzBVb2FCaVFpVlwvRURpRnhLbzBuWGxwVXVuNXFtbmthWnlQYkhDbHJhNE5zdVwvaSJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Acked-by: Len Brown <len.brown@intel.com>

