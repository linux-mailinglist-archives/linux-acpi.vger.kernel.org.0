Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD294192653
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Mar 2020 11:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCYK4m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Mar 2020 06:56:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49759 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgCYK4m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Mar 2020 06:56:42 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id ccb6cf05dbdca277; Wed, 25 Mar 2020 11:56:39 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        =?utf-8?B?T25kxZllag==?= Caletka <ondrej@caletka.cz>
Subject: [PATCH 0/2] ACPI: PM: s2idle: Harden the premature EC wakeups handling
Date:   Wed, 25 Mar 2020 11:52:42 +0100
Message-ID: <9291082.ZuhHelrm8h@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

It turns out that the checks added by commit fdde0ff8590b ("ACPI: PM: s2idle:
Prevent spurious SCIs from waking up the system") were not precise enough and
there are cases in which it actually doesn't prevent the system from resuming
due to a spurious wakeup event coming from the EC.

To fix that issue, allow acpi_any_gpe_status_set() to skip one GPE from the
check carried out by it (patch [1/2]) and use that for skipping the EC GPE
from that check in the suspend-to-idle loop, which then allows the wakeup
events coming from the EC to be checked more precisely (patch [2/2]).

Thanks!



