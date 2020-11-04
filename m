Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317022A6DBB
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Nov 2020 20:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgKDTUo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Nov 2020 14:20:44 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:48681 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbgKDTUo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Nov 2020 14:20:44 -0500
Received: from [192.168.0.2] (ip5f5af1c0.dynamic.kabel-deutschland.de [95.90.241.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id AF6AC20646221;
        Wed,  4 Nov 2020 20:20:41 +0100 (CET)
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Dell XPS 13 9310: Power Resource [PIN] results in 260 ms delay
Message-ID: <c61aab3b-74c9-4d17-7896-fba1bfedb1ab@molgen.mpg.de>
Date:   Wed, 4 Nov 2020 20:20:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear Linux folks,


Booting Linux on the Intel Tiger Lake Dell XPS 13 9310, there is a 260 
ms delay during startup.

     [    0.298217] ACPI: Power Resource [D3C] (on)
     [    0.558918] ACPI: Power Resource [PIN] (off)

As it’s off, I assume, it’s some kind of timeout. I uploaded the logs 
and the ACPI table dumps to the Linux bug tracker [1].

If you could suggest, how to debug this further, that’d be great.

I also suggest, that Linux prints a warning if certain parts take too 
much time, so firmware developers or engineers are finding bugs in their 
code early.


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=209931
