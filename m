Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0925282444
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Oct 2020 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgJCNTt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Oct 2020 09:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgJCNTt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Oct 2020 09:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601731187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/cKRZRbGjxQLiOAezESANVcl7eCV24aeM9891f3ig80=;
        b=Ejr5Dop0JmJm5q858PVfQFtDdUaqButHnOGrVT2e6fVBLYS4pryHirD3i2y88cLJCF9Uhq
        Mh0z/6cC6Ycuc1TyhzGR7dOdNLPCNoATHfbHifP40aXn3Ahs6xeJD5WKolLvsoobcCoxbe
        PgX66N2N8Lq+vpKkKAwPtonh1pQQbEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-WaKbc_-JNLGeBgxwrK0Tog-1; Sat, 03 Oct 2020 09:19:44 -0400
X-MC-Unique: WaKbc_-JNLGeBgxwrK0Tog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 721741074641;
        Sat,  3 Oct 2020 13:19:42 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4F5B73677;
        Sat,  3 Oct 2020 13:19:39 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 0/1] Documentation: Add documentation for new performance_profile sysfs class
Date:   Sat,  3 Oct 2020 15:19:37 +0200
Message-Id: <20201003131938.9426-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Recently 2 different patches have been submitted for drivers under
drivers/platform/x86 to configure the performance-profile of
modern laptops (see the actual RFC patch for what I mean with
a performance-profile). One for the thinkpad_acpi driver and
one for the hp-wmi driver.

Since I don't want each pdx86 driver to invent its own userspace API
for this I have started a dicussion about coming up with a standardized /
common sysfs class / API for this on the pdx86 list:
https://www.spinics.net/lists/platform-driver-x86/msg22794.html

The sysfs API proposal which I'm sending out as RFC in this email
thread is the result of me trying to distill that discussion into
a concrete proposal.

I have Cc-ed the linux-pm and linux-acpi lists because even though
the trigger for doing this is 2 different pdx86 drivers, the resulting
API should (must even) also be suitable for other platforms. I can
e.g. see various modern ARM platforms also having similar functionality
which they may want to export to userspace and the ideally the userspace
code for allowing the end-user to configure/select a profile would be
the same under ARM and x86.

Talking about userspace I've also Cc-ed Bastien and Benjamin who are
working on the userspace side of this.

Regards,

Hans

