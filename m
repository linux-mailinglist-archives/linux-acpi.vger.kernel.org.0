Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4069CC5A
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 11:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfHZJOe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 05:14:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:60016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfHZJOe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Aug 2019 05:14:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4718CAC7F;
        Mon, 26 Aug 2019 09:14:33 +0000 (UTC)
Message-ID: <1566809983.2612.2.camel@suse.com>
Subject: Re: [RFC 1/3] net: cdc_ncm: add get/set ethernet address functions
From:   Oliver Neukum <oneukum@suse.com>
To:     Charles.Hyde@dellteam.com, linux-usb@vger.kernel.org
Cc:     Mario.Limonciello@dell.com, nic_swsd@realtek.com,
        linux-acpi@vger.kernel.org
Date:   Mon, 26 Aug 2019 10:59:43 +0200
In-Reply-To: <d3971424f9ee4b689b762721f671746a@AUSX13MPS303.AMER.DELL.COM>
References: <d3971424f9ee4b689b762721f671746a@AUSX13MPS303.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Am Freitag, den 23.08.2019, 22:26 +0000 schrieb
Charles.Hyde@dellteam.com:
> This patch adds support for pushing a MAC address out to USB based
> ethernet controllers driven by cdc_ncm.  With this change, ifconfig can
> now set the device's MAC address.  For example, the Dell Universal Dock
> D6000 is driven by cdc_ncm.  The D6000 can now have its MAC address set
> by ifconfig, as it can be done in Windows.  This was tested with a D6000
> using ifconfig on an x86 based chromebook, where iproute2 is not
> available.

The code is good. But placing it into cdc_ncm means that cdc_ether
or other drivers cannot use it.

	Regards
		Oliver

