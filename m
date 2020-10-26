Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1836C29933B
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Oct 2020 18:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775081AbgJZRA7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 26 Oct 2020 13:00:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:31527 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1772050AbgJZQ7G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Oct 2020 12:59:06 -0400
IronPort-SDR: 2sHFqqIShy94SB/pqIoU80T/xqtLjGALSkFNMxM/1Q3MHtlbHUkzHqUlbR3E9RxcQqbz6NCLsc
 3zVMHomiW38w==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="167172950"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="167172950"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 09:59:06 -0700
IronPort-SDR: TRYwYcvvxoZmxQJRLWRtBu1Mow89wGrqonEIN/BftOsc0ulzf1WS67WRn/hRi4NclNBsaeGDQR
 b3Q/md0mv/wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="334093291"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 26 Oct 2020 09:59:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Oct 2020 09:59:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Oct 2020 09:59:04 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Mon, 26 Oct 2020 09:59:04 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "yaoaili126@163.com" <yaoaili126@163.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "yaoaili@kingsoft.com" <yaoaili@kingsoft.com>
Subject: RE: [PATCH] Fix incorrect return value of pre_map_gar_callback
Thread-Topic: [PATCH] Fix incorrect return value of pre_map_gar_callback
Thread-Index: AQHWq19sp66xi2qbOUqFwfzrDLYujqmqGylg
Date:   Mon, 26 Oct 2020 16:59:04 +0000
Message-ID: <0976809238164c308f8e1592595899f0@intel.com>
References: <20201026061509.48212-1-yaoaili126@163.com>
In-Reply-To: <20201026061509.48212-1-yaoaili126@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> -	if (ctx->ins_table[ins].flags & APEI_EXEC_INS_ACCESS_REGISTER)
> +	if (ctx->ins_table[ins].flags & APEI_EXEC_INS_ACCESS_REGISTER &&
> +	 entry->register_region.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)

I don't know (too long since I looked at APEI code) if this is the right fix, but I tried it out and it does allow einj.ko module to load.

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony
