Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F3B3C37D5
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jul 2021 01:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhGJXxJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 10 Jul 2021 19:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232675AbhGJXwu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Jul 2021 19:52:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B7A76135F;
        Sat, 10 Jul 2021 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625961004;
        bh=Kr5HoqsE5MPFdwwLrEQmw5vIHfZj7/DGPLKFuD6t3uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHOGnrxburRgX2zLX3Oe2P6oi2BT0fWoNkChppR+LQFWK98WMIWu5sKGXPmej8qin
         Q/KTD9HS6TfQv9Y5yXopU7r/NKu4WPQvjdWvuCElU42nKHRElKJJQd+Mw0X7NbEDE/
         4mvh9xzoUhNJ2nA/RtwMvVW0ZKu9bNt5O/6sjEwO/VkOSM3UxbmNt+2bJ8zXTrwErU
         wwodrmV/d08S1WmrUuN6Mwd9q4z5h9NQ/n/G8p8DvLeP/8ewwnv9EPT/PXhq8aWKA1
         8Zn0n4++9vRY6XXmPjV1LLeOTlaBcZNt92r/QWFJ4y2MoKaHL15T1S+LHGzk29Mdkg
         xOwcadWU1Zx2Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liguang Zhang <zhangliguang@linux.alibaba.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 35/43] ACPI: AMBA: Fix resource name in /proc/iomem
Date:   Sat, 10 Jul 2021 19:49:07 -0400
Message-Id: <20210710234915.3220342-35-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710234915.3220342-1-sashal@kernel.org>
References: <20210710234915.3220342-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Liguang Zhang <zhangliguang@linux.alibaba.com>

[ Upstream commit 7718629432676b5ebd9a32940782fe297a0abf8d ]

In function amba_handler_attach(), dev->res.name is initialized by
amba_device_alloc. But when address_found is false, dev->res.name is
assigned to null value, which leads to wrong resource name display in
/proc/iomem, "<BAD>" is seen for those resources.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_amba.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
index 49b781a9cd97..ab8a4e0191b1 100644
--- a/drivers/acpi/acpi_amba.c
+++ b/drivers/acpi/acpi_amba.c
@@ -76,6 +76,7 @@ static int amba_handler_attach(struct acpi_device *adev,
 		case IORESOURCE_MEM:
 			if (!address_found) {
 				dev->res = *rentry->res;
+				dev->res.name = dev_name(&dev->dev);
 				address_found = true;
 			}
 			break;
-- 
2.30.2

