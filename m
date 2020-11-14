Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE012B2DC4
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Nov 2020 16:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgKNPB2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 14 Nov 2020 10:01:28 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.116]:53539 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbgKNPB1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 14 Nov 2020 10:01:27 -0500
Received: from [100.112.133.178] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-west-2.aws.symcld.net id D2/BF-18625-341FFAF5; Sat, 14 Nov 2020 15:01:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleJIrShJLcpLzFFi42JJl3vFpuv8cX2
  8wcMTkhb7r0tYdC00sFh4/xSrxddvt9kt3hyfzmSxfF8/o0VTZxObxeeOySwWq/e8YLY4c/oS
  qwOXx6SZM5g9ds66y+7xa9saFo/NK7Q85p0M9Hi/7yqbx5ar7SwenzfJBXBEsWbmJeVXJLBmv
  Fs5i7Vgt3LFxZ1/2BoYN8l2MXJxCAn8Z5S4MmE+O4Tzg1HixL1m1i5GTg42AW2JLVt+sXUxcn
  CICMhIfFjrCVLDLNDOJLH62GM2kBphgUSJ2+vus4DUsAioSmw/yQIS5hWwkVj/Yg3YGAkBeYm
  Zl76zg9icQCVnuh6D1QgJqEjcf7CEDaJeUOLkzCdgcWag+uats5khbAmJgy9eMIOMlxBQkLgz
  oxBiZILEspd3mCcwCsxC0j0LSfcsJN0LGJlXMZolFWWmZ5TkJmbm6BoaGOgaGhrpGhob6VroJ
  VbpJumVFuuWpxaX6BrpJZYX6xVX5ibnpOjlpZZsYgTGU0pBC8cOxsOvP+gdYpTkYFIS5f2wen
  28EF9SfkplRmJxRnxRaU5q8SFGGQ4OJQneCR+AcoJFqempFWmZOcDYhklLcPAoifCygaR5iws
  Sc4sz0yFSpxgVpcR520ASAiCJjNI8uDZYOrnEKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZhX
  BWQKT2ZeCdz0V0CLmYAWfzBbA7K4JBEhJdXAFFR55HqwQqSdwa7cLw3LinOLZ06+wX1/zXnfi
  RnXXVrtVufFsbDn7pFW+bvz68+InI3PZ3m8E68qkctfwhjJd63F/8wJJ7fjpfy1s+af0Gk1Nj
  vg514l2vBIuNG7LdUhYZKGv/jG/2UnHuYuCXgjKvW07ca0/j2bmf9rpV++5vRu+VGZ1XMt+Z1
  e3Q7b/L0hkNmicVP21qmP7to6ti3zvJAr88WLoWxDgH8CI/9z92m3eDbN5XNTev2MxUZLb+mO
  /28eLb1mksTZfdg4uHv//4IXtXnpwVZrYmcqnFJYZXCkKMTz9xSDkPOWa68/mB/51p/nvZtAx
  /nVN4sUX7odlHQ8aTQv2Nr151ob/8llSizFGYmGWsxFxYkABPbfTqIDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-30.tower-346.messagelabs.com!1605366080!52312!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 768 invoked from network); 14 Nov 2020 15:01:23 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-30.tower-346.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Nov 2020 15:01:23 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 46EE988AE034C2D8B4FC;
        Sat, 14 Nov 2020 23:01:18 +0800 (CST)
Received: from banther-ThinkPad-X1-Carbon-Gen-8.home (10.38.56.206) by
 reswpmail04.lenovo.com (10.62.32.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Sat, 14 Nov 2020 07:01:15 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <rjw@rjwysocki.net>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <mario.limonciello@dell.com>, <eliadevito@gmail.com>,
        <hadess@hadess.net>, <bberg@redhat.com>,
        <platform-driver-x86@vger.kernel.org>, <dvhart@infradead.org>
Subject: [PATCH v2 1/3] Documentation: Add documentation for new platform_profile sysfs attribute
Date:   Sat, 14 Nov 2020 10:01:00 -0500
Message-ID: <20201114150102.340618-1-markpearson@lenovo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.38.56.206]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On modern systems the platform performance, temperature, fan and other
hardware related characteristics are often dynamically configurable. The
profile is often automatically adjusted to the load by somei
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
2.25.1

