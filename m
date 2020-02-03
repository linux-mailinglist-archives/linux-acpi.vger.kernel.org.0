Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D2615051B
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Feb 2020 12:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBCLTg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Feb 2020 06:19:36 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41854 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgBCLT3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Feb 2020 06:19:29 -0500
Received: from 79.184.253.222.ipv4.supernova.orange.pl (79.184.253.222) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id db64699071c4b765; Mon, 3 Feb 2020 12:19:26 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v2 0/2] intel_idle: Two new module parameters
Date:   Mon, 03 Feb 2020 12:13:41 +0100
Message-ID: <1921392.EN65KG1giI@kreacher>
In-Reply-To: <1720216.0Jr2BLnqKp@kreacher>
References: <1720216.0Jr2BLnqKp@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, January 30, 2020 3:44:40 PM CET Rafael J. Wysocki wrote:
> Hi All,
> 
> This series adds to module parameters to intel_idle (on top of the material
> already in the mainline since Monday), one to make it use ACPI even if that
> is not enabled for the processor model present in the system and the other
> one to allow passing a list of idle states to disable by default to it.
> 
> Details in the patch changelogs.

This is a small update of the original set fixing a build issue in the first
patch and addressing a couple of review comments in the second one.

Thanks,
Rafael



