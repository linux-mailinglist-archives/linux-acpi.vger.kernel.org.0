Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0B82ACBCE
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 04:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbgKJDcP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 22:32:15 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.5]:58710 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730921AbgKJDcO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 22:32:14 -0500
Received: from [100.112.128.173] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.us-west-2.aws.symcld.net id 5C/0F-13169-5B90AAF5; Tue, 10 Nov 2020 03:32:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRWlGSWpSXmKPExsWS8eIhj+5WzlX
  xBrO2KVjsvy5h0bXQwGLh/VOsFl+/3Wa3eHN8OpPF8n39jBZNnU1sFp87JrNYrN7zgtnizOlL
  rA5cHpNmzmD22DnrLrvHr21rWDw2r9DymHcy0OP9vqtsHluutrN4fN4kF8ARxZqZl5RfkcCas
  WflBKaC/dwV7efOszUwfuDoYuTiEBL4zyixecdXli5GTiDnPqPEtp9lIDabgLbEli2/2LoYOT
  hEBGQkPqz1BKlnFmhnklh97DEbSI2wgK7EiaVrwWwWARWJy9/uMYPYvAJWEn0r/rOD2BIC8hJ
  Pe5eDxTkFVCXOdD2G2qUicf/BEjaIekGJkzOfgMWZgeqbt85mhrAlJA6+eMEMM+fkhk9MEHaC
  xLKXd5gnMArMQtI+C0n7LCTtCxiZVzGaJxVlpmeU5CZm5ugaGhjoGhoa6RoaWeqaGuglVukm6
  pUW65anFpfoGukllhfrFVfmJuek6OWllmxiBMZUSkGj0Q7Gv68/6B1ilORgUhLlzWJaFS/El5
  SfUpmRWJwRX1Sak1p8iFGGg0NJgvccB1BOsCg1PbUiLTMHGN8waQkOHiUR3hcsQGne4oLE3OL
  MdIjUKUZFKXHe7SB9AiCJjNI8uDZYSrnEKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZj3N8gU
  nsy8Erjpr4AWMwEtDnBcAbK4JBEhJdXAZGgxzWvTrqTEuhe1jsY33s8+GbL97yzukivPj/6RZ
  Wvy73Dq1RTIPPl93+2+3nUKB477evg9DzkTGHdw/tf2Y1d9+V4fvR3gn76scC6D2ynP/dFWhn
  v2TPzn/fiZ0+K+1zwvFlutEdHh2Ndsx7bZS36Gf8sSj0uFL/oenH649KbG9uJ3D4/Ht8s852Y
  L5X+pyXLT3CooTcf4QNUk1qUf4r8tjFMK2mOkf2W7T1m6RWfkXZ5Cn8ervtzTX59zNnXh9fry
  6xGtSn5BX+8daPiXrfTs/27Li9K5NTltF2JvPHgd+VDsqK7o3dPXhC+WPtvDuWnHr1OxHCkSF
  d0bv693dZrfy7Jpfrl/X518wMfmrUosxRmJhlrMRcWJAEugaJykAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-3.tower-335.messagelabs.com!1604979123!34582!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10495 invoked from network); 10 Nov 2020 03:32:05 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-3.tower-335.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Nov 2020 03:32:05 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 8E79530B21B52347DA7F;
        Mon,  9 Nov 2020 22:32:03 -0500 (EST)
Received: from localhost.home (10.64.89.28) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 9 Nov 2020
 19:32:00 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <rjw@rjwysocki.net>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <mario.limonciello@dell.com>, <eliadevito@gmail.com>,
        <hadess@hadess.net>, <bberg@redhat.com>,
        <platform-driver-x86@vger.kernel.org>, <dvhart@infradead.org>
Subject: [PATCH 0/3] Platform Profile support
Date:   Mon, 9 Nov 2020 22:31:21 -0500
Message-ID: <20201110033124.3211-1-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.89.28]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch series is for the implementation of the platform-profile
feature - the ability to determine which mode the platform is in and
to change the mode using a sysfs entry.

The first patch is an update of the document I've been working on with
review and help from the kernel community. Thank you to everybody for
their input.

The second patch implements the platform-profile sysfs and API's needed.

The third patch has Lenovo specific changes in thinkpad_acpi.c to use 
the new platform-profile implementation and be able to switch between
low, medium and high power modes.

Thanks
Mark


Mark Pearson (3):
  Documentation: Add documentation for new platform_profile sysfs
    attribute
  ACPI: platform-profile: Add platform profile support
  platform/x86: thinkpad_acpi: Add platform profile support

 .../ABI/testing/sysfs-platform_profile        |  66 +++++
 MAINTAINERS                                   |   8 +
 drivers/acpi/Kconfig                          |  19 ++
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/platform_profile.c               | 171 ++++++++++++
 drivers/platform/x86/thinkpad_acpi.c          | 261 +++++++++++++++++-
 include/linux/platform_profile.h              |  36 +++
 7 files changed, 550 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
 create mode 100644 drivers/acpi/platform_profile.c
 create mode 100644 include/linux/platform_profile.h

-- 
2.28.0

