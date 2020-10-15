Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8541E28F759
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Oct 2020 19:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbgJORAI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Oct 2020 13:00:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49192 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389998AbgJORAG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2020 13:00:06 -0400
Received: from 89-64-88-192.dynamic.chello.pl (89.64.88.192) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 2a5fe0e506130c9a; Thu, 15 Oct 2020 19:00:04 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 0/2] ACPI: DPTF: Driver name fixes and Kconfig update
Date:   Thu, 15 Oct 2020 18:57:22 +0200
Message-ID: <2206290.MayQypTng0@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

These patches fix the names of two DPTF drivers to adhere to the sysfs file
naming conventions and rework the DPTF part of Kconfig.

Please refer to the patch changelogs for details.

Thanks!



