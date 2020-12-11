Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3552D6E0F
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Dec 2020 03:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389516AbgLKCOx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 21:14:53 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.3]:34795 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgLKCOj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Dec 2020 21:14:39 -0500
Received: from [100.112.128.122] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.us-west-2.aws.symcld.net id 47/DD-50495-2F4D2DF5; Fri, 11 Dec 2020 02:09:54 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRWlGSWpSXmKPExsWSLveKXffTlUv
  xBp//iFnsvy5h0bXQwGLh/VOsFl+/3Wa3eHN8OpPF8n39jBZNnU1sFp87JrNYrN7zgtli7Zd5
  bBZnTl9ideD2mDRzBrPHzll32T1+bVvD4rF5hZbHvJOBHj1tm5g83u+7yuax5Wo7i8fnTXIBn
  FGsmXlJ+RUJrBldHZ2sBee1K55vWMnUwHhFtYuRk0NI4D+jxL9utS5GLiD7AaPE/utvWEESbA
  LaElu2/GLrYuTgEBGQkfiw1hOkhllgK5PEyX07wWqEBRIlNrxtZQexWQRUJbb+WQBm8wrYSPS
  0zmYEsSUE5CWe9i5nBrE5gWrOdD1mgVisInH/wRI2iHpBiZMzn4DFmYHqm7fOZoawJSQOvnjB
  DDNnzsWpUHaCxLKXd5gnMArMQtI+C0n7LCTtCxiZVzFaJBVlpmeU5CZm5ugaGhjoGhoa6RoaG
  +oaGZrpJVbpJuqVFuuWpxaX6BrpJZYX6xVX5ibnpOjlpZZsYgRGWkpB840djLPefNA7xCjJwa
  Qkyvt48qV4Ib6k/JTKjMTijPii0pzU4kOMMhwcShK86peBcoJFqempFWmZOcCoh0lLcPAoifD
  mgKR5iwsSc4sz0yFSpxgVpcR5lUESAiCJjNI8uDZYornEKCslzMvIwMAgxFOQWpSbWYIq/4pR
  nINRSZh38yWgKTyZeSVw018BLWYCWsxz6TzI4pJEhJRUA5PubD6Ncwuv/T6z92X7db/e7EY9f
  7t79oUB5pbdarJC7NvqudU1n0yaUneB6ZgN1+HS+VE9KTLCtqy/z22W/rix93RCZcZJBvlA+S
  u//Tek6UxtcuJkaoxTuRW232nXqdZkh3Nd7i/1DQXaPBa9E1hYz7/xzkHZ2tpwLV+tGRIrPOM
  nFVdFLzwicdRU/ne9bKNlybbaoPcs6ma7lp/UtHgntUVNzbuK5+a+uWGXjl6+sdMy5xbPlFAb
  +9rItJtmqltvKGbPnf2v+vLbLTb+RvyLbl9TyLuWqf1s37fmn+U1jZrTGWZsuLK69b2BsW5XQ
  mhq9WyX3eaRU9dF2b34e/PX9Bl7dLifbvQXPFImrMRSnJFoqMVcVJwIANEFbmqvAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-7.tower-326.messagelabs.com!1607652592!24750!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28831 invoked from network); 11 Dec 2020 02:09:54 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-7.tower-326.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Dec 2020 02:09:54 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 302FD1D359FEFC2F5C5E;
        Fri, 11 Dec 2020 10:09:48 +0800 (CST)
Received: from localhost.home (10.64.86.16) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Thu, 10 Dec
 2020 18:09:41 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <hdegoede@redhat.com>, <mgross@linux.intel.com>,
        <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <hadess@hadess.net>,
        <pobrn@protonmail.com>, <mario.limonciello@dell.com>,
        <eliadevito@gmail.com>, <bberg@redhat.com>, <dvhart@infradead.org>,
        <njosh1@lenovo.com>
Subject: [PATCH v6 1/3] Documentation: Add documentation for new platform_profile sysfs attribute
Date:   Thu, 10 Dec 2020 21:06:28 -0500
Message-ID: <20201211020630.305905-1-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.86.16]
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

 .../ABI/testing/sysfs-platform_profile        | 24 +++++++++++
 Documentation/userspace-api/index.rst         |  1 +
 .../userspace-api/sysfs-platform_profile.rst  | 43 +++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
 create mode 100644 Documentation/userspace-api/sysfs-platform_profile.rst

diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
new file mode 100644
index 000000000000..5ac14268585f
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
+		available_profiles changes the profile to the new value.
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
index 000000000000..56639d218003
--- /dev/null
+++ b/Documentation/userspace-api/sysfs-platform_profile.rst
@@ -0,0 +1,43 @@
+=====================================================================
+Platform Profile Selection (e.g. /sys/firmware/acpi/platform_profile)
+=====================================================================
+
+On modern systems the platform performance, temperature, fan and other
+hardware related characteristics are often dynamically configurable. The
+profile is often automatically adjusted to the load by some
+automatic mechanism (which may very well live outside the kernel).
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
+
+
-- 
2.28.0

