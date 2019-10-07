Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 004CBCEF29
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2019 00:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfJGWor (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Oct 2019 18:44:47 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:35145 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729051AbfJGWor (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Oct 2019 18:44:47 -0400
Received: from [192.168.0.5] (ip5f5bf2e6.dynamic.kabel-deutschland.de [95.91.242.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 55C5120225688;
        Tue,  8 Oct 2019 00:44:44 +0200 (CEST)
Subject: Re: [PATCH] ACPI: PM: Revert "ACPI / PM: Blacklist Low Power S0 Idle
 _DSM for Dell XPS13 9360"
To:     Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1569514137-2307-1-git-send-email-mario.limonciello@dell.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <97e66464-8407-fd58-21a6-aeb7736dec7b@molgen.mpg.de>
Date:   Tue, 8 Oct 2019 00:44:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1569514137-2307-1-git-send-email-mario.limonciello@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear Mario,


On 26.09.19 18:08, Mario Limonciello wrote:
> This reverts part of
> commit 71630b7a832f ("ACPI / PM: Blacklist Low Power S0 Idle _DSM for Dell XPS13 9360")
> to remove the S0ix blacklist for the XPS 9360.
> 
> The problems with this system occurred in one possible NVME SSD when
> putting system into s0ix.  As the NVME sleep behavior has been adjusted
> in d916b1be this is expected to be now resolved.

1.  Please add, that it was the Hynix(?) SSD.
2.  Please add the commit message summary of d916b1be.

     nvme-pci: use host managed power state for suspend

> Cc: 'Paul Menzel <pmenzel@molgen.mpg.de>'
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=196907
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

Tag it for the stable series? d916b1be (first tag v5.3-rc1) is not 
tagged for stable.

> ---
> The particular failing configuration was reported by only ever failed for Paul Menzel, so hopefully
> he can test on his failing system.

I successfully tested Linux 5.4-rc1+ with this commit last Friday on the 
Dell XPS 13 9360.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>

[…]


Kind regards,

Paul
