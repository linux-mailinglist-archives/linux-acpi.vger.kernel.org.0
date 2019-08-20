Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B501295D71
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2019 13:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfHTLeG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Aug 2019 07:34:06 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:54515 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfHTLeG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Aug 2019 07:34:06 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7A90310564D67;
        Tue, 20 Aug 2019 13:34:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 172A1522475; Tue, 20 Aug 2019 13:34:04 +0200 (CEST)
Date:   Tue, 20 Aug 2019 13:34:04 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario.Limonciello@dell.com
Cc:     mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, rjw@rjwysocki.net, lenb@kernel.org,
        anthony.wong@canonical.com, rajmohan.mani@intel.com,
        raanan.avargil@intel.com, David.Laight@ACULAB.COM,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 0/8] thunderbolt: Intel Ice Lake support
Message-ID: <20190820113404.pm6qvqakdkcwdpat@wunner.de>
References: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
 <5486107424db48f2a06ed4c8a81f75b0@AUSX13MPC101.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5486107424db48f2a06ed4c8a81f75b0@AUSX13MPC101.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 19, 2019 at 04:29:35PM +0000, Mario.Limonciello@dell.com wrote:
> I've run into a problem when using
> a WD19TB that after unplugging it will cause the following to spew in dmesg:
> 
> [ 2198.017003] ============================================
> [ 2198.017005] WARNING: possible recursive locking detected
> [ 2198.017008] 5.3.0-rc5+ #75 Not tainted
> [ 2198.017009] --------------------------------------------
> [ 2198.017012] irq/122-pciehp/121 is trying to acquire lock:
> [ 2198.017015] 00000000801d4de8 (&ctrl->reset_lock){.+.+}, at: pciehp_check_presence+0x1b/0x80
> [ 2198.017026] 
>                but task is already holding lock:
> [ 2198.017028] 000000000899e2eb (&ctrl->reset_lock){.+.+}, at: pciehp_ist+0xaf/0x1c0

This was first reported by Theodore in April and appears to be a
false positive:

https://lore.kernel.org/linux-pci/20190402083257.kyqmirq4ovzscxsv@wunner.de/

Thanks,

Lukas
