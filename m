Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D99D159566
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2020 17:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgBKQyL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Feb 2020 11:54:11 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42112 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbgBKQyJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Feb 2020 11:54:09 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id d2a3bbaa5cdf3a2b; Tue, 11 Feb 2020 17:54:07 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 0/2] ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system
Date:   Tue, 11 Feb 2020 17:51:36 +0100
Message-ID: <6974889.tv0o8xEHfr@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On some systems the platform generates spurious SCIs while the system is
suspended to idle and those SCIs are treated as genuine system events after
the rework of the main suspend-to-idle control flow in 5.4.  The patches
here address this problem by adding a mechanism to check whether or not
SCIs generated while the system is suspended to idle are spurious and to
discard the spurious ones.

Patch [1/2] updates ACPICA to provide a way to examine the status bits of
all GPEs enabled at the moment in one go.

Patch [2/2] uses that mechanism to implement the check mentioned above.

This series is on top of https://patchwork.kernel.org/patch/11373185/ which
should appear in linux-next tomorrow.

Thanks!



