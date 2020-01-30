Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20ECD14DD22
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2020 15:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgA3Orm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Jan 2020 09:47:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51265 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgA3Orl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jan 2020 09:47:41 -0500
Received: from 79.184.253.19.ipv4.supernova.orange.pl (79.184.253.19) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 41d897d1c2f42d75; Thu, 30 Jan 2020 15:47:39 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH 0/2] intel_idle: Two new module parameters
Date:   Thu, 30 Jan 2020 15:44:40 +0100
Message-ID: <1720216.0Jr2BLnqKp@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

This series adds to module parameters to intel_idle (on top of the material
already in the mainline since Monday), one to make it use ACPI even if that
is not enabled for the processor model present in the system and the other
one to allow passing a list of idle states to disable by default to it.

Details in the patch changelogs.

Thanks,
Rafael



