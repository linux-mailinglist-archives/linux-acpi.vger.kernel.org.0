Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7C2CC343
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 18:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgLBRRO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 12:17:14 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.4]:12859 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726525AbgLBRRO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 12:17:14 -0500
Received: from [100.112.131.7] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.us-west-2.aws.symcld.net id 90/E9-03087-1DAC7CF5; Wed, 02 Dec 2020 17:11:45 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRWlGSWpSXmKPExsWSLveKXffCqeP
  xBvvOaVnsvy5h0bXQwGLh/VOsFl+/3Wa3eHN8OpPF8n39jBZNnU1sFp87JrNYrN7zgtli7Zd5
  bBZnTl9ideD2mDRzBrPHzll32T1+bVvD4rF5hZbHvJOBHj1tm5g83u+7yuax5Wo7i8fnTXIBn
  FGsmXlJ+RUJrBm7XvxkK2hSqZixJq+B8aVsFyMXh5DAf0aJ3ze/MXUxcgI5Dxgldt/JBrHZBL
  Qltmz5xdbFyMEhIiAj8WGtJ0g9s8B8JolrE66yg8SFBRIlptxMASlnEVCR2Lf2FhuIzStgLfF
  3/jtWEFtCQF7iae9yZhCbU0BV4kzXYxaIVSoS9x8sgaoXlDg58wlYnBmovnnrbGYIW0Li4IsX
  zBBzFCTmfV3EAmEnSCx7eYd5AqPALCTts5C0z0LSvoCReRWjeVJRZnpGSW5iZo6uoYGBrqGhk
  a6hsYGuuYleYpVuol5psW55anGJrpFeYnmxXnFlbnJOil5easkmRmCMpRQ0ee1gbHrzQe8Qoy
  QHk5Io76r5x+OF+JLyUyozEosz4otKc1KLDzHKcHAoSfDqnwTKCRalpqdWpGXmAOMdJi3BwaM
  kwisJkuYtLkjMLc5Mh0idYlSUEuctAkkIgCQySvPg2mAp5hKjrJQwLyMDA4MQT0FqUW5mCar8
  K0ZxDkYlYV4fYMIS4snMK4Gb/gpoMRPQYpfPh0EWlyQipKQamDYe9azxdL37+63HtUtWC/tt/
  LcUSZ1379KcxSBf3rHAyd8+tskiZpm1/vXgt4KeAp+2Wop+Vfhqt0xavfjBE5bHBTMCPzfeUP
  lZkyqhG2L8tvLU28RSMQGRousbpXvvb/AKydiQc/Gc2PL6/cwzb1zrY9C7VLesIv5q14umt+a
  bt0jmaTxZKNQW6KvpMt1plqyl96QDzJbWH6X/5z+6q9XvJswZ8fmzeqhqXMnPR9LcB5d9yi6u
  uOYuMb340563gpmX1oufTCtJuCYiPudbwNPOCpbLVwSnOG2TnlFf76q1q/3g1aRDS+dc3SLSF
  vhih++/jdte1k653shalvq7v2rZjQfVy2eWC17R3HP5gBJLcUaioRZzUXEiAF9CkmmsAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-10.tower-326.messagelabs.com!1606929102!2143!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9901 invoked from network); 2 Dec 2020 17:11:44 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-10.tower-326.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Dec 2020 17:11:44 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id C134990C6908A62FDE20;
        Thu,  3 Dec 2020 01:11:39 +0800 (CST)
Received: from localhost.home (10.64.84.211) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 2 Dec 2020
 09:11:34 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <hdegoede@redhat.com>, <mgross@linux.intel.com>,
        <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <hadess@hadess.net>,
        <pobrn@protonmail.com>, <mario.limonciello@dell.com>,
        <eliadevito@gmail.com>, <bberg@redhat.com>, <dvhart@infradead.org>
Subject: [PATCH v5 1/3] Documentation: Add documentation for new platform_profile sysfs attribute
Date:   Wed, 2 Dec 2020 12:11:18 -0500
Message-ID: <20201202171120.65269-1-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.84.211]
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
Changes in v3, v4 & v5:
 - version bump along with rest of patch series

 .../ABI/testing/sysfs-platform_profile.rst    | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform_profile.rst

diff --git a/Documentation/ABI/testing/sysfs-platform_profile.rst b/Documentation/ABI/testing/sysfs-platform_profile.rst
new file mode 100644
index 000000000000..5f7b2a94409b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform_profile.rst
@@ -0,0 +1,66 @@
+=======================================================================
+ Platform Profile Selection (e.g. /sys/firmware/acpi/platform_profile)
+=======================================================================
+
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
+gets a consistent experience this API document defines a fixed set of
+profile names. Drivers *must* map their internal profile representation
+onto this fixed set.
+
+
+If there is no good match when mapping then a new profile name may be
+added. Drivers which wish to introduce new profile names must:
+
+ 1. Explain why the existing profile names canot be used.
+ 2. Add the new profile name, along with a clear description of the
+    expected behaviour, to the documentation.
+
+:What:        /sys/firmware/acpi/platform_profile_choices
+:Date:        October 2020
+:Contact:     Hans de Goede <hdegoede@redhat.com>
+:Description: This file contains a space-separated list of profiles supported for this device.
+
+              Drivers must use the following standard profile-names::
+
+         		 low-power:     Low power consumption
+         		 cool:          Cooler operation
+		         quiet:         Quieter operation
+		         balanced:      Balance between low power consumption and performance
+		         performance:   High performance operation
+
+              Userspace may expect drivers to offer more than one of these
+              standard profile names.
+
+:What:        /sys/firmware/acpi/platform_profile
+:Date:        October 2020
+:Contact:     Hans de Goede <hdegoede@redhat.com>
+:Description: Reading this file gives the current selected profile for this
+              device. Writing this file with one of the strings from
+              available_profiles changes the profile to the new value.
-- 
2.28.0

