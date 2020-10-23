Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0671D297125
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Oct 2020 16:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750405AbgJWOQi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Oct 2020 10:16:38 -0400
Received: from smtp.radex.nl ([178.250.146.7]:59099 "EHLO radex-web.radex.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750404AbgJWOQh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Oct 2020 10:16:37 -0400
Received: from [192.168.1.158] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id C9C9A24065;
        Fri, 23 Oct 2020 16:16:35 +0200 (CEST)
From:   Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v1 2/2] device property: Don't clear secondary pointer for
 shared primary firmware node
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20201022184100.71659-1-andriy.shevchenko@linux.intel.com>
 <20201022184100.71659-2-andriy.shevchenko@linux.intel.com>
 <20201023123544.GB614478@kuha.fi.intel.com>
Message-ID: <06eb930d-841f-29d9-e1e3-1f54d7bf10ca@gmail.com>
Date:   Fri, 23 Oct 2020 16:16:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023123544.GB614478@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi

Op 23-10-2020 om 14:35 schreef Heikki Krogerus:
> On Thu, Oct 22, 2020 at 09:41:00PM +0300, Andy Shevchenko wrote:
>> It appears that firmware nodes can be shared between devices. In such 
>> case
>> when a (child) device is about to be deleted, its firmware node may 
>> be shared
>> and ACPI_COMPANION_SET(..., NULL) call for it breaks the secondary link
>> of the shared primary firmware node.
>>
>> In order to prevent that, check, if the device has a parent and parent's
>> firmware node is shared with its child, and avoid crashing the link.
>>
>> Fixes: c15e1bdda436 ("device property: Fix the secondary firmware 
>> node handling in set_primary_fwnode()")
>> Reported-by: Ferry Toth <fntoth@gmail.com>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> FWIW:
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Tested-by: Ferry Toth <fntoth@gmail.com>

>> ---
>> drivers/base/core.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 41feab679fa1..78114ddac755 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -4264,6 +4264,7 @@ static inline bool fwnode_is_primary(struct 
>> fwnode_handle *fwnode)
>> */
>> void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
>> {
>> + struct device *parent = dev->parent;
>> struct fwnode_handle *fn = dev->fwnode;
>> if (fwnode) {
>> @@ -4278,7 +4279,8 @@ void set_primary_fwnode(struct device *dev, 
>> struct fwnode_handle *fwnode)
>> } else {
>> if (fwnode_is_primary(fn)) {
>> dev->fwnode = fn->secondary;
>> - fn->secondary = ERR_PTR(-ENODEV);
>> + if (!(parent && fn == parent->fwnode))
>> + fn->secondary = ERR_PTR(-ENODEV);
>> } else {
>> dev->fwnode = NULL;
>> }
>> -- 2.28.0
