Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232362B6EA3
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Nov 2020 20:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgKQT33 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Nov 2020 14:29:29 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:33472 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKQT33 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2020 14:29:29 -0500
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 363853A39E8
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2020 19:29:27 +0000 (UTC)
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 49026240007;
        Tue, 17 Nov 2020 19:29:03 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-acpi@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Tin Huynh <tnhuynh@apm.com>
Subject: Re: [PATCH v2 1/3] rtc: ds1307: Remove non-valid ACPI IDs
Date:   Tue, 17 Nov 2020 20:29:02 +0100
Message-Id: <160564099645.1265721.9852311675923504898.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201116142859.31257-1-andriy.shevchenko@linux.intel.com>
References: <20201116142859.31257-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 16 Nov 2020 16:28:57 +0200, Andy Shevchenko wrote:
> The commit 9c19b8930d2c ("rtc: ds1307: Add ACPI support") added invalid
> ACPI IDs (all of them are abusing ACPI specification). Moreover there is
> not even a single evidence that vendor registered any of such devices.
> 
> Remove broken ACPI IDs from the driver. For prototyping one may use PRP0001
> with device properties adhering to a DT binding. The following patches
> will add support of that to the driver.

Applied, thanks!

[1/3] rtc: ds1307: Remove non-valid ACPI IDs
      commit: a31111189bb1160f84cf4cf9f910aa2ba7553d18
[2/3] rtc: ds1307: Make use of device properties
      commit: 227ec129ad7b035ee2ae2e57e9567a8126ad93f3
[3/3] rtc: ds1307: Drop of_match_ptr and CONFIG_OF protections
      commit: 698fffc2705cc48804cc31021cdb2ae4290927be

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
