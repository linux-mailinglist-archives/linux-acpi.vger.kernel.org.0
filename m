Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98BE3A2086
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 01:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhFIXKz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 19:10:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57280 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhFIXKz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 19:10:55 -0400
Received: from [123.112.67.122] (helo=[192.168.2.106])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <hui.wang@canonical.com>)
        id 1lr7Jg-0001pX-NU; Wed, 09 Jun 2021 23:08:57 +0000
Subject: Re: [PATCH v3] ACPI : don't always override the acpi irq
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        manuelkrause@netscape.net, Thomas Gleixner <tglx@linutronix.de>
References: <20210609021442.12446-1-hui.wang@canonical.com>
 <CAJZ5v0juxLJXiyreAjeNkUYZZ2SHWCdFRM+ip3-H6NrgYHa=Cw@mail.gmail.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <89db9baf-3bb9-39e1-2bec-51c8f4aa412a@canonical.com>
Date:   Thu, 10 Jun 2021 07:08:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0juxLJXiyreAjeNkUYZZ2SHWCdFRM+ip3-H6NrgYHa=Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 6/9/21 8:44 PM, Rafael J. Wysocki wrote:
> On Wed, Jun 9, 2021 at 4:14 AM Hui Wang <hui.wang@canonical.com> wrote:
>> The laptop keyboard doesn't work on many MEDION notebooks, but the
>>
>> +                                        irq->shareable, irq_is_legacy(irq));
>>                  break;
>>          case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>>                  ext_irq = &ares->data.extended_irq;
>> --
> Applied as 5.14 material under a new subject ("ACPI: resources: Add
> checks for ACPI IRQ override") and with some edits in the patch
> changelog.
>
> Note, however, that this is a change in behavior that may result in
> regressions on old machines, in which case some further refinements of
> the code will be necessary.
>
> Thanks!
Understand. Thanks.
