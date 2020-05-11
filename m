Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66A51CD399
	for <lists+linux-acpi@lfdr.de>; Mon, 11 May 2020 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgEKISl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 May 2020 04:18:41 -0400
Received: from foss.arm.com ([217.140.110.172]:53374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgEKISl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 May 2020 04:18:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00AF7D6E;
        Mon, 11 May 2020 01:18:40 -0700 (PDT)
Received: from bogus (unknown [10.37.12.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACC723F305;
        Mon, 11 May 2020 01:18:39 -0700 (PDT)
Date:   Mon, 11 May 2020 09:18:28 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Aaron Chou <zhoubb.aaron@gmail.com>
Cc:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        linux-acpi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [ARM64 ACPI] different CPU L3 cache size reported by
 /sys/device/ and dmidecode
Message-ID: <20200511081818.GA9532@bogus>
References: <CAMpQs4JoyZcHQLahh4w8OaowQ1y3pkTCTYvDn+dkVNOQ4zDpHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpQs4JoyZcHQLahh4w8OaowQ1y3pkTCTYvDn+dkVNOQ4zDpHQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 11, 2020 at 03:30:51PM +0800, Aaron Chou wrote:
> In the system, I can get the L3 cache size from two or more ways.
>

Which platform is this ? More details would help.

> Firstly, I can get it from the kernel interface, such as the `lscpu` command.
> Also, I can cat the file `/sys/devices/system/cpu/cpu3/cache/index3/size`.
>

IIRC, lscpu parse the above mentioned sysfs files and the above result
match the expectation.

> The way above can give me the L3 cache size is 32768K.
>

OK

> Now if I use the `dmidecode -t cache` command, I get the L3 cache size
> is 24576K.
>

Ah, that's bad.

> And the real size of the L3 cache is 24576K.
>

OK

> Why is it? who can explain it to me?
>

ACPI reads these cache information from PPTT. The firmware which populates
the ACPI PPTT must read it from DMI entries and keep them in sync. On
this system, looks like the firmware tried to be more imaginative and
populated PPTT with wrong values. Get that firmware fixed please!

--
Regards,
Sudeep
