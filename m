Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D78A75B0E
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2019 00:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfGYW40 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 18:56:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59328 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfGYW40 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jul 2019 18:56:26 -0400
Received: from 79.184.253.188.ipv4.supernova.orange.pl (79.184.253.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id dce5c082049a12d6; Fri, 26 Jul 2019 00:56:23 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: [PATCH 0/4] PM / ACPI: sleep: Additional changes related to suspend-to-idle
Date:   Fri, 26 Jul 2019 00:51:09 +0200
Message-ID: <3471485.I2vrcDHEeC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On top of the "Simplify the suspend-to-idle control flow" patch series posted previously:

https://lore.kernel.org/lkml/71085220.z6FKkvYQPX@kreacher/

sanitize the suspend-to-idle flow even further.

First off, decouple EC wakeup from the LPS0 _DSM processing (patch 1).

Next, reorder the code to invoke LPS0 _DSM Functions 5 and 6 in the
specification-compliant order with respect to suspending and resuming
devices (patch 2).

Finally, rearrange lps0_device_attach() (patch 3) and add a command line switch
to prevent the LPS0 _DSM from being used.

Please refer to the changelogs for details.

Thanks,
Rafael



