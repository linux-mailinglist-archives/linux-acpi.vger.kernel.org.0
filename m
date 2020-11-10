Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1622ACBD8
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 04:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbgKJDcZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 22:32:25 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.5]:58710 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729831AbgKJDcP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 22:32:15 -0500
Received: from [100.112.131.148] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.us-west-2.aws.symcld.net id 81/7F-13169-DB90AAF5; Tue, 10 Nov 2020 03:32:13 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRWlGSWpSXmKPExsWSLveKTXcv56p
  4g13fRSz2X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RoumziY2i88dk1ksVu95wWxx5vQl
  Vgcuj0kzZzB77Jx1l93j17Y1LB6bV2h5zDsZ6PF+31U2jy1X21k8Pm+SC+CIYs3MS8qvSGDN+
  PqquuCcQsXpzrPMDYwvpLsYuTiEBP4zSlzd1MUC4dxnlHh6eQZzFyMnB5uAtsSWLb/Yuhg5OE
  QEZCQ+rPUEqWEWaGeSWH3sMRtIjbBAnMStGfsYQWwWARWJt003mEDqeQWsJH7dDAMJSwjISzz
  tXQ42klPAWuLq8a/sILaQQIjEkx1vWUBsXgFBiZMzn4DZzED1zVtnM0PYEhIHX7xghplzcsMn
  Jgg7QWLZyzvMExgFZiFpn4WkfRaS9gWMzKsYLZKKMtMzSnITM3N0DQ0MdA0NjXQNjSx1DY1N9
  BKrdBP1Sot1y1OLS3SN9BLLi/WKK3OTc1L08lJLNjECYyqloLFtB+PMNx/0DjFKcjApifJmMa
  2KF+JLyk+pzEgszogvKs1JLT7EKMPBoSTBe44DKCdYlJqeWpGWmQOMb5i0BAePkgjvCxagNG9
  xQWJucWY6ROoUo6KUOO92kD4BkERGaR5cGyylXGKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagk
  zPsbZApPZl4J3PRXQIuZgBYHOK4AWVySiJCSamA6UCsrPOOz2nX2sMMH4qTUeRbeajPn58lpO
  Vx186P09po9B5Z0fs085/ryZ+07kytX5srZb05hL1L74vHoyq7fO57Jn9qQdeJC19Sbiv8NPY
  6Xq5ntyfP5VHX4WlHmku5rmrk+9nbzaxLXMuxfN1NXR1F6S8Gyj2vlitf0fpzEJd988fg33ds
  XQtr2KNRxKiqvDy90KMt5W3O89lKz9ae7M9I6nylXtkSdXpu81O9DN6eFlSyDzpXtTsbSTwJu
  73/R3/zYxLTv8tmfC6Z/P/vnkd/vGH9mvw0eG+cz2Zusanm56NpFi2YN66AW5roCCUWdgMgaS
  76c6j3rGy+x7QytS9lsmtglHCx9+Gr3pR9KLMUZiYZazEXFiQD67u6SpAMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-9.tower-326.messagelabs.com!1604979130!33045!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24369 invoked from network); 10 Nov 2020 03:32:13 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-9.tower-326.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Nov 2020 03:32:13 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 39592B28BB52329C64D0;
        Tue, 10 Nov 2020 11:32:08 +0800 (CST)
Received: from localhost.home (10.64.89.28) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 9 Nov 2020
 19:32:03 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <rjw@rjwysocki.net>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <mario.limonciello@dell.com>, <eliadevito@gmail.com>,
        <hadess@hadess.net>, <bberg@redhat.com>,
        <platform-driver-x86@vger.kernel.org>, <dvhart@infradead.org>
Subject: [PATCH 1/3] Documentation: Add documentation for new platform_profile sysfs attribute
Date:   Mon, 9 Nov 2020 22:31:22 -0500
Message-ID: <20201110033124.3211-2-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110033124.3211-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com>
 <20201110033124.3211-1-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.89.28]
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
 .../ABI/testing/sysfs-platform_profile        | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform_profile

diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
new file mode 100644
index 000000000000..abf900dafbfb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform_profile
@@ -0,0 +1,66 @@
+Platform profile selection (e.g. /sys/firmware/acpi/platform_profile)
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
+1. Explain why the existing profile names canot be used.
+2. Add the new profile name, along with a clear description of the
+   expected behaviour, to the documentation.
+
+What:		/sys/firmware/acpi/platform_profile_choices
+Date:		October 2020
+Contact:	Hans de Goede <hdegoede@redhat.com>
+Description:
+		This file contains a space-separated list of profiles
+		supported for this device.
+
+		Drivers must use the following standard profile-names:
+
+		low-power:		Low power consumption
+		cool:			Cooler operation
+		quiet:			Quieter operation
+		balanced:		Balance between low power consumption
+					and performance
+		performance:		High performance operation
+
+		Userspace may expect drivers to offer more than one of these
+		standard profile names.
+
+What:		/sys/firmware/acpi/platform_profile
+Date:		October 2020
+Contact:	Hans de Goede <hdegoede@redhat.com>
+Description:
+		Reading this file gives the current selected profile for this
+		device. Writing this file with one of the strings from
+		available_profiles changes the profile to the new value.
-- 
2.28.0

