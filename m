Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB851609A6
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Feb 2020 05:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgBQEmk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 16 Feb 2020 23:42:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgBQEmk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Feb 2020 23:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=j5xYGsqatix9Wvp6r37SE7HlFrIRp5sccIPwkdusUgw=; b=PFv2kuVxmKyTv/vL9P5ucI7Kcq
        zbXfsJTGMdZai0nWspDOd1RVKO6/M6vZbU2cUKPuPyzOHL76btnCoNZVosmnKZSRt2CPmMjbpqdTA
        eywYiK32nNE0zFskUsoOlT/5xRRyuvPm/6qzzhmWqdoLi9qn7/TH7K6QKUofW1SUVRQISh23TQnTC
        BiE4Re9POUeS8qOi6QFnlm9qLry7UzLHmB0QYH8x7Qp7rfzs8OCt0Pgw7z3x5HoKbAwcKgX/Dl1+/
        Pwlkh8Zk4QWPdcXHSIfRnJwO3+4WNJXmlUS6SWsg+ij14H/cL3Tlu8s0VUeLheSZKJk020MetNyhs
        O6+CKP8A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3YEv-00018f-Hj; Mon, 17 Feb 2020 04:42:37 +0000
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation/admin-guide/acpi: fix
 fan_performance_states.rst warnings
Message-ID: <98d72d3b-c9eb-36bc-1d68-2c3020bdf9c5@infradead.org>
Date:   Sun, 16 Feb 2020 20:42:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Sphinx format warnings in fan_performace_states.rst
by adding indentation.

Documentation/admin-guide/acpi/fan_performance_states.rst:21: WARNING: Literal block ends without a blank line; unexpected unindent.
Documentation/admin-guide/acpi/fan_performance_states.rst:41: WARNING: Literal block expected; none found.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/acpi/fan_performance_states.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-56-rc2.orig/Documentation/admin-guide/acpi/fan_performance_states.rst
+++ lnx-56-rc2/Documentation/admin-guide/acpi/fan_performance_states.rst
@@ -18,7 +18,7 @@ may look as follows::
 
  $ ls -l /sys/bus/acpi/devices/INT3404:00/
  total 0
-...
+ ...
  -r--r--r-- 1 root root 4096 Dec 13 20:38 state0
  -r--r--r-- 1 root root 4096 Dec 13 20:38 state1
  -r--r--r-- 1 root root 4096 Dec 13 20:38 state10
@@ -38,7 +38,7 @@ where each of the "state*" files represe
 and contains a colon-separated list of 5 integer numbers (fields) with the
 following interpretation::
 
-control_percent:trip_point_index:speed_rpm:noise_level_mdb:power_mw
+  control_percent:trip_point_index:speed_rpm:noise_level_mdb:power_mw
 
 * ``control_percent``: The percent value to be used to set the fan speed to a
   specific level using the _FSL object (0-100).


