Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A7F1CEF74
	for <lists+linux-acpi@lfdr.de>; Tue, 12 May 2020 10:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgELIsI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 May 2020 04:48:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:38110 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgELIsI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 May 2020 04:48:08 -0400
IronPort-SDR: fn5nf7kTIEwAr9IxVovXyypQaW+NiJUfGt/20kvpE9OBjb2PZso3Lao1CRV3K/gHXIEbs45iSI
 3zlngHP7dj+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 01:48:08 -0700
IronPort-SDR: L6OFau1JYloiIwPwqe+sq1+vWAEMFFQAPukcwbGc2F2R35psFBXmcVyMeWJIfn9RVa6DQReInb
 2kY5Vvr6q33A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="371497330"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 May 2020 01:48:05 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 12 May 2020 11:48:05 +0300
Date:   Tue, 12 May 2020 11:48:04 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] ACPI / PMIC: Add i2c address for thermal control
Message-ID: <20200512084804.GI487496@lahna.fi.intel.com>
References: <cover.1589262490.git.mchehab+huawei@kernel.org>
 <4ea6a89bcde8c72427e69a87551bdfca8bf1af11.1589262490.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea6a89bcde8c72427e69a87551bdfca8bf1af11.1589262490.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 12, 2020 at 07:51:56AM +0200, Mauro Carvalho Chehab wrote:
> On Asus T101HA, we keep receiving those error messages:
> 
> 	i915 0000:00:02.0: [drm] *ERROR* mipi_exec_pmic failed, error: -95
> 	intel_soc_pmic_exec_mipi_pmic_seq_element: Not implemented
> 	intel_soc_pmic_exec_mipi_pmic_seq_element: i2c-addr: 0x5e reg-addr 0x4b value 0x59 mask 0xff
> 
> Because the opregion is missing the I2C address.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
