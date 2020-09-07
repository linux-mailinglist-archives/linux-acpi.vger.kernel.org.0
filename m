Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A680260220
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 19:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgIGRT2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 13:19:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:17429 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729735AbgIGN6j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 09:58:39 -0400
IronPort-SDR: T5jIJvD8d7SYuAnPYse8o7B5dt6F7wuNA8F/GrFIJytbZGWifzv/+Kv/hs3kwvukS1loqIY6Kl
 GLKlNzR3gpOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="138056014"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="138056014"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 06:57:42 -0700
IronPort-SDR: gPr5Ny3IQXuYQvwgibYGaWlmUn3YAb4BlYyoTJ5tC+1YzrC3jP+yF69NxRXjYUYCLMMFv/gRoh
 TborBRmkt1yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="406845155"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2020 06:57:40 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        linux-acpi@vger.kernel.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 0/2] Fixes for the Intel PMC mux driver
Date:   Mon,  7 Sep 2020 16:57:38 +0300
Message-Id: <20200907135740.19941-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Here are two of fixes from Utkarsh. Both deal with alternate mode
issues. Let me know if you want anything to be changed.

thanks,

Utkarsh Patel (2):
  usb: typec: intel_pmc_mux: Do not configure Altmode HPD High
  usb: typec: intel_pmc_mux: Do not configure SBU and HSL Orientation in
    Alternate modes

 drivers/usb/typec/mux/intel_pmc_mux.c | 12 ------------
 1 file changed, 12 deletions(-)

-- 
2.28.0

