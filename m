Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3023A85D29
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2019 10:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfHHIog (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Aug 2019 04:44:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53961 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbfHHIog (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Aug 2019 04:44:36 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 4dbb172df3063ed1; Thu, 8 Aug 2019 10:44:34 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH 0/2] intel-hid: intel-vbtn: Suspend-related fix and update
Date:   Thu, 08 Aug 2019 10:40:19 +0200
Message-ID: <1717835.1Yz4jNODO2@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

These two patches fix a minor issue related to system suspend in the intel-hid
and intel-vbtn drivers and update the suspend/resume handling in intel-hid to
reduce special-casing in it somewhat.

Please refer to the changelogs for details.

Thanks,
Rafael



