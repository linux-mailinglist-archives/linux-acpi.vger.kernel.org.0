Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045CB2D3921
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Dec 2020 04:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgLIDJh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Dec 2020 22:09:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37075 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgLIDJh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2020 22:09:37 -0500
Received: from [123.114.42.209] (helo=[192.168.0.106])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1kmpqV-0003Sg-93; Wed, 09 Dec 2020 03:08:51 +0000
Subject: Re: [PATCH] ACPI / bus: skip the primary physical pnp device in
 companion_match
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
References: <20201204075041.44339-1-hui.wang@canonical.com>
 <CAJZ5v0jnVoo_heYUAfbt4t6xFAOqq+dGus1LCZP_-5Q8o8cpQQ@mail.gmail.com>
 <27211ea4-a691-ae96-4fed-6bb8f214963d@canonical.com>
 <CAJZ5v0gx4u9mWKxbe4kX2YRZsWFRt-x3DGTJMS2npRiyq2aCNQ@mail.gmail.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <545a824f-090f-549f-94d9-193cce4b0e4e@canonical.com>
Date:   Wed, 9 Dec 2020 11:08:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gx4u9mWKxbe4kX2YRZsWFRt-x3DGTJMS2npRiyq2aCNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 12/8/20 10:01 PM, Rafael J. Wysocki wrote:
> On Tue, Dec 8, 2020 at 3:02 AM Hui Wang <hui.wang@canonical.com> wrote:
>>
>> On 12/7/20 9:11 PM, Rafael J. Wysocki wrote:
>>> On Fri, Dec 4, 2020 at 8:51 AM Hui Wang <hui.wang@canonical.com> wrote:
> [cut]
>
>>> Would dropping the device ID in question from acpi_pnp_device_ids[]
>>> make the problem go away?
>>>
>>> If so, why don't you do just that?
>> Yes, if remove "WACFXXX" from acpi_pnp_device_ids[], could fix this
>> issue. I planned to do so, but I found the pnp_driver in the
>> drivers/tty/serial/8250/8250_pnp.c still handle this ID, maybe it could
>> introduce regression on old machines if removing it.
> Well, "WACFXXX" is not a proper device ID, it is a wild card possibly
> matching too many devices.
>
> What device ID specifically is used in the ACPI tables for the device
> in question?

It is "WACF2200", how about the change as below, is it safe to say the 
length of a pnp device id is 7?

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 4ed755a963aa..1e828378238c 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -336,6 +336,10 @@ static bool acpi_pnp_match(const char *idstr, const 
struct acpi_device_id **matc
  {
         const struct acpi_device_id *devid;

+       /* Expect the pnp device id has CCCdddd format (C character, d 
digital) */
+       if (strlen(idstr) != 7)
+               return false;
+
         for (devid = acpi_pnp_device_ids; devid->id[0]; devid++)
                 if (matching_id(idstr, (char *)devid->id)) {
                         if (matchid)


Thanks.

