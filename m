Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 013919BD04
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Aug 2019 12:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfHXK0B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 24 Aug 2019 06:26:01 -0400
Received: from canardo.mork.no ([148.122.252.1]:51893 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbfHXK0B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 24 Aug 2019 06:26:01 -0400
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id x7OAPiQo013074
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 24 Aug 2019 12:25:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1566642346; bh=24IxeTH1e912w88ptP2Yb6xCPgtaB58BivyPEjXsA2I=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=VXkR1sN2UNmPfApo7ivNo7IHVqZ4rdMgFqyKl9k8j2b4HBHyy9sx6zDr/AywgD8C/
         9gQsoW0/pAfwg46DoGpjei0WMMDEoxF5HunSEZcd60CUMHYvvr24LXWGD1S2q1MO+K
         wVWe5+jawEUUdqH0uhZMyxP+nMqD4HTqlE1psXE0=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1i1TEu-0002B7-36; Sat, 24 Aug 2019 12:25:44 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     <Charles.Hyde@dellteam.com>
Cc:     <linux-acpi@vger.kernel.org>, <Mario.Limonciello@dell.com>,
        <oliver@neukum.org>, <nic_swsd@realtek.com>,
        <linux-usb@vger.kernel.org>
Subject: Re: [RFC 2/3] ACPI: move ACPI functionality out of r8152 driver
Organization: m
References: <b84b32cb144f4ba8918ee2406e69275a@AUSX13MPS303.AMER.DELL.COM>
Date:   Sat, 24 Aug 2019 12:25:44 +0200
In-Reply-To: <b84b32cb144f4ba8918ee2406e69275a@AUSX13MPS303.AMER.DELL.COM>
        (Charles Hyde's message of "Fri, 23 Aug 2019 22:28:24 +0000")
Message-ID: <87blwe272v.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.101.2 at canardo
X-Virus-Status: Clean
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

<Charles.Hyde@dellteam.com> writes:

> This change moves ACPI functionality out of the Realtek r8152 driver to
> its own source and header file, making it available to other drivers as
> needed now and into the future.  At the time this ACPI snippet was
> introduced in 2016, only the Realtek driver made use of it in support of
> Dell's enterprise IT policy efforts.  There comes now a need for this
> same support in a different driver, also in support of Dell's enterprise
> IT policy efforts.

Why not make a standalone driver out of this, making the MAC address
(and other system specifc objects?) available to userspace? Then you
can just distribute updated udev rules or systemd units or whatever for
the next docking product.

I don't think system specific policies should be put into device
drivers.  Users will combine systems and devices in ways you don't
foresee, and may have good reasons to want some non-default policy even
for supported combinations.

If you really want to have this policy in the driver(s), then please
consider extending eth_platform_get_mac_address() with an x86/acpi
method.  This will make the device driver code support fetching the mac
address from device tree and Sparc idproms too.  Provided the netdev
folks things this is OK, of course.  This needs to be discussed there,
like get_maintainer.pl would have told you.

Making sure we can modify the MAC address of USB ethernet devices is
obviously a good thing regardless of how/where you fetch it.





Bj=C3=B8rn
