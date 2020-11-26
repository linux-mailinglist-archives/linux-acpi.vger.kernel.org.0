Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2126E2C5995
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 17:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391589AbgKZQwR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Nov 2020 11:52:17 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.4]:19790 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391549AbgKZQwQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Nov 2020 11:52:16 -0500
Received: from [100.112.1.102] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-east-1.aws.symcld.net id 9D/00-42660-93DDFBF5; Thu, 26 Nov 2020 16:52:09 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRWlGSWpSXmKPExsWS8eIhj67l3f3
  xBvcuMFvsvy5h0bXQwGLh/VOsFl+/3Wa3eHN8OpPF8n39jBYfl3FYfO6YzGKxes8LZou1X+ax
  WZw5fYnVgdtj0swZzB47Z91l9/i1bQ2Lx+YVWh7zTgZ69LRtYvJ4v+8qm8eWq+0sHp83yQVwR
  rFm5iXlVySwZtw6/ICp4J9yRc/8VvYGxmeyXYxcHEIC/xklPjd0MUI4Dxklzl3+xt7FyMnBJq
  AtsWXLL7YuRg4OEQEZiQ9rPUFqmAUWMEl8ub6GFaRGWCBR4s+S94wgNouAqsSansVg9bwC1hJ
  bXouAhCUE5CWe9i5nBrE5gUrOdD1mAbGFBFQk7j9YwgZi8woISpyc+QQszgxU37x1NjOELSFx
  8MULZog5ChKTF1xlgrATJJa9vMM8gVFgFpL2WUjaZyFpX8DIvIrRLKkoMz2jJDcxM0fX0MBA1
  9DQSNcAxNJLrNJN0ist1k1NLC7RNdRLLC/WK67MTc5J0ctLLdnECIyxlAKGlB2Md19/0DvEKM
  nBpCTKu2TP/nghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErzH7wDlBItS01Mr0jJzgPEOk5bg4FE
  S4f19GyjNW1yQmFucmQ6ROsWoKCXOuw0kIQCSyCjNg2uDpZhLjLJSwryMDAwMQjwFqUW5mSWo
  8q8YxTkYlYR5t4Ns58nMK4Gb/gpoMRPQ4umce0AWlyQipKQamJweGMyP49Js62Z6f16gabvND
  Dalww62c8Ujf+XdvT1tceGBPQcU/1g+va/h809ns5PWhUsWOmtuf3rfFH510+ZD1lwLz8/Y22
  iis2a2+yfFu9y9uozvu+KX7/A19N8m+2pjZ8ZkLdWYq+fszjDGLhMWiS9ZOdGlzV4r+e9V56I
  pC0IXT63VO8/fx/rlpfvVmVLpj1fo/lTaG7OzoO6CHJMk7w1LtcYFyj9LHi6f5/04eU981R3B
  bQZSbL/nx5yO26GUNXOyfSZ3YHjRNdt1Tz3L8s/sFIyUm6rMaSX70COrWdJtf23Q2Y6e65NPL
  Hq4VKsuvmR/ZmHlfD/XDRpc0ia3Ek1F9avZbr5/mD2hXomlOCPRUIu5qDgRAGL6ThqsAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-13.tower-395.messagelabs.com!1606409528!181385!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8530 invoked from network); 26 Nov 2020 16:52:09 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-13.tower-395.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Nov 2020 16:52:09 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id C987F99A393690D97FF3;
        Thu, 26 Nov 2020 11:52:08 -0500 (EST)
Received: from localhost.home (10.64.80.205) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Thu, 26 Nov
 2020 08:52:05 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <hdegoede@redhat.com>, <mgross@linux.intel.com>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <rjw@rjwysocki.net>,
        <hadess@hadess.net>, <pobrn@protonmail.com>,
        <mario.limnociello@dell.com>, <eliadevito@gmail.com>,
        <bberg@redhat.com>, <dvhart@infradead.org>
Subject: [PATCH v4 1/3] Documentation: Add documentation for new platform_profile sysfs attribute
Date:   Thu, 26 Nov 2020 11:51:41 -0500
Message-ID: <20201126165143.32776-1-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.80.205]
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
Changes in v3 & v4:
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

