Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84907AB394
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 10:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfIFIAS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 04:00:18 -0400
Received: from canardo.mork.no ([148.122.252.1]:53743 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfIFIAS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Sep 2019 04:00:18 -0400
Received: from miraculix.mork.no ([IPv6:2a02:2121:2c6:ea50:dc9c:cbff:fe10:7b5a])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id x867xoWc028521
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 6 Sep 2019 09:59:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1567756793; bh=/2gqBF8vGK7i6EkJq1a5lQAMlIV0aHWhGCUe6Yfoiwk=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=CcvHpfUg0S1II3Sn0y45rVu0KkCxuh9lXl8GbXj2TP2bOgIRv7Sl6Nj+GdvdPrJyL
         EWF7s+dzFRCvqab0FoQNqznbjp2X1H14PrC1z8igB3xmhIMRv+h3eAL3Oy3pTGGCcs
         ux5Ujttbfgup0qWjQZiKs3MRojUFVmZuOG0pwrZs=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1i699l-0002uY-0i; Fri, 06 Sep 2019 09:59:45 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     <Charles.Hyde@dellteam.com>
Cc:     <oliver@neukum.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <Mario.Limonciello@dell.com>, <chip.programmer@gmail.com>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 3/3] net: cdc_ncm: Add ACPI MAC address pass through functionality
Organization: m
References: <1567717304186.90134@Dellteam.com>
Date:   Fri, 06 Sep 2019 09:59:44 +0200
In-Reply-To: <1567717304186.90134@Dellteam.com> (Charles Hyde's message of
        "Thu, 5 Sep 2019 21:01:44 +0000")
Message-ID: <874l1pua6n.fsf@miraculix.mork.no>
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

> +	if (strstr(dev->udev->product, "D6000")) {

Huh? Can you please test that on all USB devices ever made?


Bj=C3=B8rn
