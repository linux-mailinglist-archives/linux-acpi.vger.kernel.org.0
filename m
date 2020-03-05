Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D263D17B20E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2020 00:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgCEXLD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Mar 2020 18:11:03 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64946 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCEXLC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2020 18:11:02 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id b4ff29ff2f5c3147; Fri, 6 Mar 2020 00:11:01 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ACPI: EC: More updates related to initialization
Date:   Fri, 06 Mar 2020 00:09:18 +0100
Message-ID: <2656743.kaaXMJBMQx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

This series contains two more cleanup patches for ACPI EC initialization on top
of the series at

https://lore.kernel.org/linux-acpi/2411774.6kdisLRoUK@kreacher/T/#u

Please refer to the patch changelogs for details.

Thanks!



