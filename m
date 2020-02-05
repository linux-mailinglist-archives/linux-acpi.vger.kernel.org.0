Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFA9E15339C
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2020 16:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgBEPFd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Feb 2020 10:05:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:45282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbgBEPFc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Feb 2020 10:05:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C99C0AD11;
        Wed,  5 Feb 2020 15:05:30 +0000 (UTC)
Message-ID: <1580915129.23547.3.camel@suse.de>
Subject: Forcing non-ACPI watchdog driver
From:   Jean Delvare <jdelvare@suse.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Tom Abraham <tabraham@suse.com>
Date:   Wed, 05 Feb 2020 16:05:29 +0100
Organization: Suse Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

Is there a way to prevent the ACPI WDAT watchdog interface from being
used and force the use of a native watchdog driver instead?

I have a customer who reports a regression on kernel upgrade. Old
kernel (v4.4) uses iTCO_wdt and watchdog works, new kernel (v4.12) uses
wdat_wdt and watchdog doesn't work (instant reboot when opening the
device). While I'm going to look for fixes to backport, I think it
would be pretty convenient to have a way to just revert to the working
driver until the new driver is fixed somehow. But I can't see any way
to do that at the moment, short of disabling ACPI completely, which is
definitely too extreme to be considered.

Am I missing something?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
