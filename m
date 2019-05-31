Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D6E30906
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 08:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfEaG53 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 02:57:29 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:46203 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaG53 (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Fri, 31 May 2019 02:57:29 -0400
Received: from linux-8mug.suse.de (prva10-snat226-1.provo.novell.com [137.65.226.35])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 31 May 2019 00:57:24 -0600
From:   Chester Lin <clin@suse.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     jlee@suse.com, mhocko@suse.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chester Lin <clin@suse.com>
Subject: [PATCH 0/3] ACPI: New eject flow to remove devices cautiously
Date:   Fri, 31 May 2019 14:56:39 +0800
Message-Id: <20190531065642.13254-1-clin@suse.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently there are two ways to handle ACPI device ejection. When an eject
event happens on a container, the kernel just sends KOBJ_CHANGE to
userland and userland should handle offline operation. For other device
types, acpi_scan_try_to_offline() is called and it tries to put target
device(s) offline and then removes all nodes once they are all offline.

However we found that sometimes applications could intensively access
resources on ejectable devices therefore they could have risk if ejection
suddenly happens and removes devices without any notification. In stead
of executing the offline callbakcs directly, we want to introduce a new
approach, which sends change events to notify all target nodes beforehand
and hands over offline handling to userland so that userland can have a
chance to schedule an offline task based on current workload. The online
function to recover from failure is also changed, it follows the same
approach to send change events rather than putting devices online directly
, which means userland will also need to take care of online handling.

To ensure that eject function can work properly since normal users might
not have their own offline/online handling, we will submit a generic udev
rule to systemd upstream as default in order to deal with change events
and take [offline/online] action accordingly. But the Hot-Removing part
still remains so the hotplug function can run to it once target nodes are
all offline.

To easily monitor eject status and start over an eject process, there's a
status trace mechanism in this eject flow, which helps to count current
online devices under the ejectable target, and it can reschedule an eject
event when all nodes within the device tree have been put offline.

Chester Lin (3):
  ACPI / hotplug: Send change events for offline/online requests when
    eject is triggered
  ACPI / hotplug: Eject status trace and auto-remove approach
  ACPI / device_sysfs: Add eject show attr to monitor eject status

 drivers/acpi/container.c    |   2 +-
 drivers/acpi/device_sysfs.c |  20 ++-
 drivers/acpi/glue.c         |  81 ++++++++++
 drivers/acpi/internal.h     |  31 +++-
 drivers/acpi/scan.c         | 298 ++++++++++++++++++++++++++----------
 drivers/base/core.c         |   2 +
 include/acpi/acpi_bus.h     |   3 +-
 7 files changed, 356 insertions(+), 81 deletions(-)

-- 
2.20.1

