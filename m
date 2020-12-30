Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556002E7556
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Dec 2020 01:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgL3AYW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Dec 2020 19:24:22 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.115]:58792 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgL3AYW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Dec 2020 19:24:22 -0500
Received: from [100.112.7.19] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.us-east-1.aws.symcld.net id EA/01-56876-D67CBEF5; Wed, 30 Dec 2020 00:18:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRWlGSWpSXmKPExsWS8eIhr27u8df
  xBmcOali8OT6dyWL5vn5Gi88dk1ksVu95wWxx5vQlVgdWj3knAz3e77vK5rHlajuLx+dNcgEs
  UayZeUn5FQmsGU9W7GYpWKpbsfflD/YGxh71LkYuDiGB/4wSzXN7WSGch0DOkRmMXYycHGwC2
  hJbtvxi62Lk4BARkJH4sNYTpIZZoI9RYtbf/ewgNcICiRINb9cxg9gsAqoSXZeng9m8AlYSk5
  /OBauREJCXeNq7HCzOCVRzpusxC4gtJKAicf/BEjaIekGJkzOfgMWZgeqbt85mhrAlJA6+eME
  MMUdB4lPrZDYIO0Fi2cs7zBMYBWYhaZ+FpH0WkvYFjMyrGM2SijLTM0pyEzNzdA0NDHQNDY10
  zYAsE73EKt1kvdJi3dTE4hJdQ73E8mK94src5JwUvbzUkk2MwPBPKWDL2MHY/uaD3iFGSQ4mJ
  VFeyQWv44X4kvJTKjMSizPii0pzUosPMcpwcChJ8PIdBcoJFqWmp1akZeYAYxEmLcHBoyTCWw
  eS5i0uSMwtzkyHSJ1iVJQS530AkhAASWSU5sG1weL/EqOslDAvIwMDgxBPQWpRbmYJqvwrRnE
  ORiVh3mSQKTyZeSVw018BLWYCWsyYA7a4JBEhJdXAZBtc/URQK6wy4uLzaLkEVV9Z9X6VheU3
  PD4/VbV2kS6+tTN6PrPq3RtOJs822x4rXtb0QLvlqebl2Ovbme6pTpt8f0O+ccif015HUh8cn
  7Fv7rdb3QfFr/2fcb2d5Z/l44CVBlxX5+TUOLXGyi7TfmTR1rTd79meFfGtO44cnCjo7rLm39
  F+9qb16poLbczTbrBnzNzstZFdc17kbqUfv115H+qGsPStLXexfb6Zd8Y2vae/f2zKzWM1mvi
  S0+PROo0qu/QFxfq//0d41lvO75x/2HxttHDdrs0/xDYvKmy/eTu/00n/y6nHn3VWVBQvYeYW
  TV9uu7Cu62tX9RUGIYMpnPO2/+J0LdXZFiP0X4mlOCPRUIu5qDgRAGcxirN6AwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-24.tower-415.messagelabs.com!1609287533!657538!1
X-Originating-IP: [104.232.225.13]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11716 invoked from network); 30 Dec 2020 00:18:53 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.13)
  by server-24.tower-415.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Dec 2020 00:18:53 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 71729F22B6B38509BA9C;
        Tue, 29 Dec 2020 19:18:53 -0500 (EST)
Received: from localhost.home (10.64.93.153) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 29 Dec
 2020 16:18:51 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <hdegoede@redhat.com>, <mgross@linux.intel.com>,
        <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: [PATCH v8 1/3] Documentation: Add documentation for new platform_profile sysfs attribute
Date:   Tue, 29 Dec 2020 19:18:25 -0500
Message-ID: <20201230001827.3745-1-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.93.153]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On modern systems the platform performance, temperature, fan and other
hardware related characteristics are often dynamically configurable. The
profile is often automatically adjusted to the load by some
automatic-mechanism (which may very well live outside the kernel).

These auto platform-adjustment mechanisms often can be configured with
one of several 'platform-profiles', with either a bias towards low-power
consumption or towards performance (and higher power consumption and
thermals).

Introduce a new platform_profile sysfs API which offers a generic API for
selecting the performance-profile of these automatic-mechanisms.

Co-developed-by: Mark Pearson <markpearson@lenovo.com>
Signed-off-by: Mark Pearson <markpearson@lenovo.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
 - updated to rst format
Changes in v3, v4, v5
 - version bump along with rest of patch series
Changes in v6:
 - Split sysfs-platform_profile.rs into ABI text and then admin guide in
   userspace-api section. Hope this is correct - I'm guessing a bit.
Changes in v7:
 - Correct available_choices to platform_profile_choices
 - Improve phrasing as recommended by review
Changes in v8:
 - Removed unnecessary empty lines at end of file

 .../ABI/testing/sysfs-platform_profile        | 24 +++++++++++
 Documentation/userspace-api/index.rst         |  1 +
 .../userspace-api/sysfs-platform_profile.rst  | 42 +++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
 create mode 100644 Documentation/userspace-api/sysfs-platform_profile.rst

diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
new file mode 100644
index 000000000000..9d6b89b66cca
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform_profile
@@ -0,0 +1,24 @@
+What:		/sys/firmware/acpi/platform_profile_choices
+Date:		October 2020
+Contact:	Hans de Goede <hdegoede@redhat.com>
+Description:	This file contains a space-separated list of profiles supported for this device.
+
+		Drivers must use the following standard profile-names:
+
+		============	============================================
+		low-power	Low power consumption
+		cool		Cooler operation
+		quiet		Quieter operation
+		balanced	Balance between low power consumption and performance
+		performance	High performance operation
+		============	============================================
+
+		Userspace may expect drivers to offer more than one of these
+		standard profile names.
+
+What:		/sys/firmware/acpi/platform_profile
+Date:		October 2020
+Contact:	Hans de Goede <hdegoede@redhat.com>
+Description:	Reading this file gives the current selected profile for this
+		device. Writing this file with one of the strings from
+		platform_profile_choices changes the profile to the new value.
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index acd2cc2a538d..d29b020e5622 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -24,6 +24,7 @@ place where this information is gathered.
    ioctl/index
    iommu
    media/index
+   sysfs-platform_profile
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
new file mode 100644
index 000000000000..c33a71263d9e
--- /dev/null
+++ b/Documentation/userspace-api/sysfs-platform_profile.rst
@@ -0,0 +1,42 @@
+=====================================================================
+Platform Profile Selection (e.g. /sys/firmware/acpi/platform_profile)
+=====================================================================
+
+On modern systems the platform performance, temperature, fan and other
+hardware related characteristics are often dynamically configurable. The
+platform configuration is often automatically adjusted to the current
+conditions by some automatic mechanism (which may very well live outside
+the kernel).
+
+These auto platform adjustment mechanisms often can be configured with
+one of several platform profiles, with either a bias towards low power
+operation or towards performance.
+
+The purpose of the platform_profile attribute is to offer a generic sysfs
+API for selecting the platform profile of these automatic mechanisms.
+
+Note that this API is only for selecting the platform profile, it is
+NOT a goal of this API to allow monitoring the resulting performance
+characteristics. Monitoring performance is best done with device/vendor
+specific tools such as e.g. turbostat.
+
+Specifically when selecting a high performance profile the actual achieved
+performance may be limited by various factors such as: the heat generated
+by other components, room temperature, free air flow at the bottom of a
+laptop, etc. It is explicitly NOT a goal of this API to let userspace know
+about any sub-optimal conditions which are impeding reaching the requested
+performance level.
+
+Since numbers on their own cannot represent the multiple variables that a
+profile will adjust (power consumption, heat generation, etc) this API
+uses strings to describe the various profiles. To make sure that userspace
+gets a consistent experience the sysfs-platform_profile ABI document defines
+a fixed set of profile names. Drivers *must* map their internal profile
+representation onto this fixed set.
+
+If there is no good match when mapping then a new profile name may be
+added. Drivers which wish to introduce new profile names must:
+
+ 1. Explain why the existing profile names canot be used.
+ 2. Add the new profile name, along with a clear description of the
+    expected behaviour, to the sysfs-platform_profile ABI documentation.
-- 
2.28.0

