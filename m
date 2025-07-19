Return-Path: <linux-acpi+bounces-15239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD77B0AFEC
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Jul 2025 14:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639811897AE0
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Jul 2025 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB9521FF4E;
	Sat, 19 Jul 2025 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJkTRXR/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6E1F956;
	Sat, 19 Jul 2025 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928730; cv=none; b=KPDzL5ABHU3AcmlIZY3YDMFYsVem4pJ7v6pafH9IYhWjneUus0TUsTo3L0GUXiA9DIpvaY2fdbYa2HZf+sjh0qnSqebUNhmc/UvdB7ithDFKkQ87JMY5UCBuiFWLxZZuKLCVhhK6v11R/KHGUPDQ4YYD3TEi7n4wYx6q4bCV7Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928730; c=relaxed/simple;
	bh=/a02GhmI4psaSZMGtMQ5WtrsQFuTeKvocvb3Uey5pw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YoOdrP80AaxK/HO0960xkSXG8OF7qw5o/7RlMOkW8V17p753cj7lynYh4RW8pysVdNOFuqfyAnwgFjVSfvt3xtdXfkXEcKHVNnvaiof2iyE6uKQVkF0Ie+gPgI47Mb9Jj6FWYiB25qOTqDlPoe2V0nkQmHvTMhLKdgOIscCVlBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJkTRXR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B81C4CEE3;
	Sat, 19 Jul 2025 12:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752928729;
	bh=/a02GhmI4psaSZMGtMQ5WtrsQFuTeKvocvb3Uey5pw4=;
	h=From:To:Cc:Subject:Date:From;
	b=YJkTRXR/joeJNwH+i1L32NKheS7fpdMqzPCZlXTlGYf8vHG/GhXs/1t/N5a3OlTlI
	 n/IGTKeMGQW5St1PNHc1KcCl9MHcHT2HHtx+fygQJKYsAiYXodrdfhkEgDBTYE0X8h
	 MvZ1rG+gfPjVoVCEFEwICGpQM/yk8kMU5WNwsc5IIu1tcZwHouDmcK9YIrJMLgrHUF
	 z7rE98IpjA9VN+S13jac04pLKG9m8R9OI81hC8h8FU+U/yfSk0fVuAC0OBtJTB/Rj4
	 f7fHq85hM7tVdJVY9OTl1QHtVqag//OemWftHZqd1ODb+rVQb9IPo/esAcZcLj2yI0
	 l4hQ5CJP1xCHA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1] ACPI/PNP: Use my kernel.org address in MAINTAINERS and ABI docs
Date: Sat, 19 Jul 2025 14:38:41 +0200
Message-ID: <2796086.mvXUDI8C0e@rjwysocki.net>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael@kernel.org>

For the sake of consistency, use my kernel.org address in all Contact
records in sysfs-bus-acpi and in the MAINTAINERS records related to
ACPI and PNP.

Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-acpi |   18 +++++++++---------
 MAINTAINERS                              |    4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -1,6 +1,6 @@
 What:		/sys/bus/acpi/devices/.../path
 Date:		December 2006
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		This attribute indicates the full path of ACPI namespace
 		object associated with the device object.  For example,
@@ -12,7 +12,7 @@
 
 What:		/sys/bus/acpi/devices/.../modalias
 Date:		July 2007
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		This attribute indicates the PNP IDs of the device object.
 		That is acpi:HHHHHHHH:[CCCCCCC:].  Where each HHHHHHHH or
@@ -20,7 +20,7 @@
 
 What:		/sys/bus/acpi/devices/.../hid
 Date:		April 2005
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		This attribute indicates the hardware ID (_HID) of the
 		device object.  For example, PNP0103.
@@ -29,14 +29,14 @@
 
 What:		/sys/bus/acpi/devices/.../description
 Date:		October 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		This attribute contains the output of the device object's
 		_STR control method, if present.
 
 What:		/sys/bus/acpi/devices/.../adr
 Date:		October 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		This attribute contains the output of the device object's
 		_ADR control method, which is present for ACPI device
@@ -45,14 +45,14 @@
 
 What:		/sys/bus/acpi/devices/.../uid
 Date:		October 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		This attribute contains the output of the device object's
 		_UID control method, if present.
 
 What:		/sys/bus/acpi/devices/.../eject
 Date:		December 2006
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		Writing 1 to this attribute will trigger hot removal of
 		this device object.  This file exists for every device
@@ -60,7 +60,7 @@
 
 What:		/sys/bus/acpi/devices/.../status
 Date:		Jan, 2014
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		(RO) Returns the ACPI device status: enabled, disabled or
 		functioning or present, if the method _STA is present.
@@ -90,7 +90,7 @@
 
 What:		/sys/bus/acpi/devices/.../hrv
 Date:		Apr, 2016
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		(RO) Allows users to read the hardware version of non-PCI
 		hardware, if the _HRV control method is present.  It is mostly
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -315,8 +315,8 @@
 F:	drivers/acpi/apei/
 
 ACPI COMPONENT ARCHITECTURE (ACPICA)
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Robert Moore <robert.moore@intel.com>
-M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
 L:	linux-acpi@vger.kernel.org
 L:	acpica-devel@lists.linux.dev
 S:	Supported
@@ -19769,7 +19769,7 @@
 F:	drivers/iio/magnetometer/rm3100*
 
 PNP SUPPORT
-M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
 L:	linux-acpi@vger.kernel.org
 S:	Maintained
 F:	drivers/pnp/




