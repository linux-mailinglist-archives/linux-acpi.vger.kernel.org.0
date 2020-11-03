Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56B92A4C5E
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 18:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgKCRLK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 12:11:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:58026 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbgKCRLJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Nov 2020 12:11:09 -0500
IronPort-SDR: U+ec9ukWG3ZmZz9KaYCOIj5N2Tu59VQGHHgEIbRKomo28BenuCzQvJO1ZThBNSV46QsZv+Pmdv
 hC8Ec08D084A==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="233257071"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="233257071"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 09:11:09 -0800
IronPort-SDR: /Hvnh3UjVZbbrD3xyYMDjLuM2pRKBB4cFCdQB8k2xzwU/PSWXZ3ugIcYmRfuC3jnmSr+ePf7MA
 Onn1wV54PXQw==
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="528564205"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 09:11:09 -0800
Date:   Tue, 3 Nov 2020 09:11:07 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     yaoaili126@163.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, james.morse@arm.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, yangfeng1@kingsoft.com,
        yaoaili@kingsoft.com
Subject: Re: [PATCH] ACPI, APEI, Fix incorrect return value of
 apei_map_generic_address
Message-ID: <20201103171107.GA15662@agluck-desk2.amr.corp.intel.com>
References: <20201102024726.8214-1-yaoaili126@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102024726.8214-1-yaoaili126@163.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Nov 01, 2020 at 06:47:26PM -0800, yaoaili126@163.com wrote:
> From: Aili Yao <yaoaili@kingsoft.com>
> 
> >From commit 6915564dc5a8 ("ACPI: OSL: Change the type of
> acpi_os_map_generic_address() return value"),acpi_os_map_generic_address
> will return logical address or NULL for error, but
> pre_map_gar_callback and related apei_map_generic_address ,for
> ACPI_ADR_SPACE_SYSTEM_IO case, it should be also return 0,as it's a
> normal case, but now it will return -ENXIO. so check it out for such
> case to avoid einj module initialization fail.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> Tested-by: Tony Luck <tony.luck@intel.com>

Yes. Tested this version too. Works fine.

-Tony
