Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF5AFBDC0B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2019 12:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbfIYKUO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Sep 2019 06:20:14 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:41136 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbfIYKUN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Sep 2019 06:20:13 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 3D1604D436; Wed, 25 Sep 2019 12:20:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 398C04D253;
        Wed, 25 Sep 2019 12:20:12 +0200 (CEST)
Date:   Wed, 25 Sep 2019 12:20:12 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
cc:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Moore, Robert" <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH] ACPICA: Introduce acpi_load_table_with_index()
In-Reply-To: <20190924120843.GU2680@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.20.1909251218520.65328@fox.voss.local>
References: <6851700.HULMXZj6Ep@kreacher> <20190923094701.24950-1-nikolaus.voss@loewensteinmedical.de> <20190924120734.GT2680@smile.fi.intel.com> <20190924120843.GU2680@smile.fi.intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 24 Sep 2019, Shevchenko, Andriy wrote:
> On Tue, Sep 24, 2019 at 03:07:34PM +0300, Shevchenko, Andriy wrote:
>> On Mon, Sep 23, 2019 at 11:47:01AM +0200, Nikolaus Voss wrote:
>>> For unloading an ACPI table, it is necessary to provide the
>>> index of the table. The method intended for dynamically
>>> loading or hotplug addition of tables, acpi_load_table(),
>>> does not provide this information, so a new function
>>> acpi_load_table_with_index() with the same functionality,
>>> but an optional pointer to the loaded table index is introduced.
>>>
>>> The new function is used in the acpi_configfs driver to save the
>>> index of the newly loaded table in order to unload it later.
>>
>> I'll test it later, though couple of remarks:
>> - would it make sense to provide a counter part helper for unloading? Now it
>>   looks a bit inconsistent in configfs when we use acpi_load_*() vs.
>>   acpi_tb_*() in remove.

Yes, IMO it would make sense, but it is an ACPICA API change. Bob, what's 
your opinion?

>
> ...and I think we may unexport acpi_tb_* in this case as Bob suggested for it
> to be internal API.

see above.

>
>> - please, include Ferry into Cc (as done in this mail)
>
