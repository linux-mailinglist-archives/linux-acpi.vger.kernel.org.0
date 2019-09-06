Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA2AC140
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 22:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394373AbfIFUHs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 16:07:48 -0400
Received: from canardo.mork.no ([148.122.252.1]:54565 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730769AbfIFUHr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Sep 2019 16:07:47 -0400
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id x86K7Dsr019205
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 6 Sep 2019 22:07:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1567800436; bh=mAik1eBj7axtTavBpQnUn60kafG7V4HqELjBPhjg2ig=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=h4QkRzfhVDmReHa4yq/1Ud/cweKkuqxTQlQf79uLaYRyu3F/JPf1+UhwgkC62H8VP
         RQfiX8o4VZRpyj34dVIQIIkfWfL6Iu1B3LJYUo9L30WHu8tTgzPTi17kvRXP1qm7OR
         EeE9Di4y2yp2PV742UekkAucEtYUFdTybkgG+ZUE=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1i6KVk-0005ZU-AV; Fri, 06 Sep 2019 22:07:12 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     <Charles.Hyde@dellteam.com>
Cc:     <stern@rowland.harvard.edu>, <oliver@neukum.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <Mario.Limonciello@dell.com>, <chip.programmer@gmail.com>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Organization: m
References: <43fa8b0a974d426faccf5e6d486af18a@AUSX13MPS307.AMER.DELL.COM>
        <Pine.LNX.4.44L0.1909061412350.1627-100000@iolanthe.rowland.org>
        <a9999ed336ba4f2a8cb93c57f0b3d2f4@AUSX13MPS307.AMER.DELL.COM>
Date:   Fri, 06 Sep 2019 22:07:12 +0200
In-Reply-To: <a9999ed336ba4f2a8cb93c57f0b3d2f4@AUSX13MPS307.AMER.DELL.COM>
        (Charles Hyde's message of "Fri, 6 Sep 2019 18:19:37 +0000")
Message-ID: <87mufhqjdb.fsf@miraculix.mork.no>
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

> What better suggestion do folks have, instead of using USB_REQ_SET_ADDRES=
S?

The spec is clear: wIndex is supposed to be 'NCM Communications
Interface'.  That's how you address a specific NCM function (a USB
device can have more than one...), and that's what you'll see in all the
other interface specific class requests in this driver.  You don't have
to look hard to find examples.


Bj=C3=B8rn
