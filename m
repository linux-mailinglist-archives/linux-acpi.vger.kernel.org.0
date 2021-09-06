Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585F2401CD2
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Sep 2021 16:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbhIFOQW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Sep 2021 10:16:22 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:40055 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242521AbhIFOQW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Sep 2021 10:16:22 -0400
Received: from [192.168.0.7] (ip5f5ae911.dynamic.kabel-deutschland.de [95.90.233.17])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id AB11D61E64846;
        Mon,  6 Sep 2021 16:15:14 +0200 (CEST)
Subject: Re: New warning: PRMT not found
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <64150c95-3f7d-d21f-d6fb-b9d478ed6798@molgen.mpg.de>
 <766862fc-80fa-775b-6e63-6d9422d1d258@molgen.mpg.de>
 <CAJZ5v0i91+kPe4C-wy+oCDvYbR_Vp=MzwEyL+8T3xJU5O4XjRA@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <c6aaf684-2cd1-f615-34e1-7ef2020ae2d2@molgen.mpg.de>
Date:   Mon, 6 Sep 2021 16:15:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i91+kPe4C-wy+oCDvYbR_Vp=MzwEyL+8T3xJU5O4XjRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear Rafael, dear Aubrey,


Thank you for replying.


Am 06.09.21 um 14:02 schrieb Rafael J. Wysocki:
> On Mon, Sep 6, 2021 at 1:51 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:

[…]

>> Am 26.07.21 um 09:42 schrieb Paul Menzel:

>>> The new code added in commit cefc7ca462 (ACPI: PRM: implement
>>> OperationRegion handler for the PlatformRtMechanism subtype) causes
>>> Linux to log a warning on my desktop system Asus F2A85-M PRO.
>>>
>>>       PRMT not found
>>>
>>> The help text for the Kconfig option `ACPI_PRMT` suggests it’s mainly
>>> used for server systems, so the warning does not apply to a lot of
>>> systems. Therefore, in my opinion, the option should not be selected by
>>> default, or the warning be removed or demoted, and phrased in a way,
>>> that users can understand the consequences.
>>
>> The new warning shows up on a lot of systems, with no indication what to
>> do about it or why Linux actually warns about it.
>>
>> Should the message be removed entirely? Or is there another indicator
>> for systems where absent PRMT causes problems, so should be warned about?
> 
> This should be addressed by commit 2bbfa0addd63 "ACPI: PRM: Deal with
> table not present or no module found", or yet another fix is needed.

Linux still warns on my systems with Linux 5.14 and Linus’ master in 
QEMU i440fx and an Asus F2A85-M PRO.


Kind regards,

Paul
