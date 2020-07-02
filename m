Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA7521230C
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jul 2020 14:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgGBMRp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Jul 2020 08:17:45 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48804 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgGBMRn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2020 08:17:43 -0400
Received: from 89-64-84-242.dynamic.chello.pl (89.64.84.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 160ca2da34263fd4; Thu, 2 Jul 2020 14:17:41 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dan Williams <dan.j.williams.korg@gmail.com>
Subject: [PATCH 0/3] ACPI: OSL: Always use deferred unmapping of memory
Date:   Thu, 02 Jul 2020 14:09:38 +0200
Message-ID: <22474080.3crLlKV2y5@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

This series is on top of the git branch at

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpica-osl

and it basically makes the deferred unmapping of ACPI memory introduced by
the first commit in that branch be the only option.

Arguably, it could be done in a single patch, but I prefer to do that in
smaller steps in case something breaks, to make it easier to identify
the point of breakage.

Patch [1/3] causes acpi_os_unmap_generic_address() to use the deferred
unmapping, patch [2/3] makes acpi_os_unmap_iomem() use it too and patch
[3/3] is a cleanup of top of the latter.

Thanks,
Rafael



