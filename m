Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099A01C93BB
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgEGPJF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 11:09:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:51959 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgEGPJF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 11:09:05 -0400
IronPort-SDR: YxxHfya0RDlzGqK2Pu+Lbr7yIYcLO5gc4CLSb7Ld6N/z+Uz9h6Ch7jHk6oE9f7O+9YBh3p3fdF
 he5+67tHQBOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 08:09:03 -0700
IronPort-SDR: vktSx+cFHmQ8SF2S29VdVEY7P65FXjEKQvrbbVK44g+boKAtZdfXg8c9g+kv0r6i9vycDkp5rG
 ruPCC0S+YPWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="370143291"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2020 08:09:00 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 0/4] usb: typec: Intel PMC driver changes
Date:   Thu,  7 May 2020 18:08:56 +0300
Message-Id: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

There is actually only one change to the driver in patch 2/4 where I'm
adding handling for the properties that are used with static/fixed SBU
and HSL line orientation. On top of that, I add firmware documentation
for the driver, and I'm also adding an entry for it to the MAINTAINERS
file in the last patch.

Let me know if you want me to change anything.

thanks,

Heikki Krogerus (4):
  usb: typec: Add typec_find_orientation()
  usb: typec: mux: intel_pmc_mux: Support for static SBU/HSL orientation
  usb: typec: Add firmware documentation for the Intel PMC mux control
  MAINTAINERS: Add entry for Intel PMC mux driver

 .../firmware-guide/acpi/intel-pmc-mux.rst     | 153 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 drivers/usb/typec/class.c                     |  36 +++--
 drivers/usb/typec/mux/intel_pmc_mux.c         |  42 ++++-
 include/linux/usb/typec.h                     |   1 +
 5 files changed, 221 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/firmware-guide/acpi/intel-pmc-mux.rst

-- 
2.26.2

