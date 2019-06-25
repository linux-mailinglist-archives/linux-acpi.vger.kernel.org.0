Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B4954E59
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2019 14:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfFYMGk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jun 2019 08:06:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46625 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbfFYMGg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jun 2019 08:06:36 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id a3be8bf0b7d12839; Tue, 25 Jun 2019 14:06:33 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/2] ACPI: PM: Fix two issues in acpi_device_set_power()
Date:   Tue, 25 Jun 2019 14:03:17 +0200
Message-ID: <10419005.Mb09WM6RCc@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

There are two, arguably minor, issues in acpi_device_set_power() that have been
introduced while making the code follow the ACPI 6 recommendations.

One of them is that, if the device is in D3hot, transitioning it into D3cold only
involves dropping references to some power resources and it should not
involve evaluating _PS3 which may happen currently.

The second one is that it sometimes is necessary to update the power state
of a device to D0 even if it was put into D0 previously, so that needs to be
possible.

Please refer to the patch changelogs for details.

Thanks,
Rafael



