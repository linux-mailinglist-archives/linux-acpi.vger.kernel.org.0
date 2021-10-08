Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDEA4262B8
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 05:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhJHDHg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Oct 2021 23:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhJHDHf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Oct 2021 23:07:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708FBC061570;
        Thu,  7 Oct 2021 20:05:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 45EAA1F4190F
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, sebastian.reichel@collabora.com,
        pgriffais@valvesoftware.com, hdegoede@redhat.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 0/1] acpi: battery: Accept charges over the design capacity as full
Date:   Fri,  8 Oct 2021 00:05:28 -0300
Message-Id: <20211008030529.223682-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

We have come across a battery that, when brand new, can go above the
reported maximum charge, leading to reports like this:

$ cat /sys/class/power_supply/BAT1/uevent

POWER_SUPPLY_NAME=BAT1
POWER_SUPPLY_TYPE=Battery
POWER_SUPPLY_STATUS=Unknown
POWER_SUPPLY_PRESENT=1
POWER_SUPPLY_CHARGE_FULL_DESIGN=4160000
POWER_SUPPLY_CHARGE_FULL=4538000
POWER_SUPPLY_CHARGE_NOW=4539000
POWER_SUPPLY_CAPACITY=100
POWER_SUPPLY_CAPACITY_LEVEL=Full
[...]

And then userspace get confused by Unknown and some programs even say
"Charging: 100%". After applying this patch, kernel reports "Full",
which for practical reasons is true, even if the battery will charge a
bit more. After some time, the battery health degrades and the maximum
charge meets the design expectation. Ideally this would be fixed in the
battery firmware, but it's not always possible to do that.

André Almeida (1):
  acpi: battery: Accept charges over the design capacity as full

 drivers/acpi/battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.33.0

