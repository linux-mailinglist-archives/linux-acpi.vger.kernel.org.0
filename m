Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B511C5A99E6
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Sep 2022 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiIAORC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Sep 2022 10:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiIAOQg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Sep 2022 10:16:36 -0400
Received: from vorpal.se (vorpal.se [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A21769F7C
        for <linux-acpi@vger.kernel.org>; Thu,  1 Sep 2022 07:15:33 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 91C55142D4;
        Thu,  1 Sep 2022 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1662041731; bh=0qDV7AZayCwc3JAA5ZN/+VOhM3pRDx+rRU4oVSOTj44=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PT7I6ZlqTJaAOKCnwyXqPFubc++zz46eu4DYhaabwzD2A3py/SKwwQ3MAlIy2EcrL
         ll+nY9yjpRcWA/Be5iRE7RC2/Ciw4avcdBfYQ2KK01mBPtFCe6S316CSKH8FEPx1Yn
         fnbp8wIQRIcX5TcWjnCMdTet7MRh3Da55nzo17CuFIe1E+nutvblTfq1vITAKOyO5t
         bKNvBkymjpQOvNrMO3S51LHO4tddWz3HvVBJOarCQcMYUshaVOxG//hJR4hbh7Wulv
         zSZBYfLdDiW+hMDby8Bh6xzJIt7rKVDMipMYoQMNs0WeN0Df21E+e/OIgIb+y3LWYV
         jeC6vj9vi7EAw==
Message-ID: <314eecd8-efce-bf3a-f9ba-0cf311023200@vorpal.se>
Date:   Thu, 1 Sep 2022 16:15:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] ACPI: video: Add Toshiba Satellite/Portege Z830 quirk
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220824184950.631520-1-lkml@vorpal.se>
 <20220824184950.631520-2-lkml@vorpal.se>
 <d097b844-8fe4-3469-2137-9e8407348175@redhat.com>
 <3863cad2-1910-b377-011b-4970eeb68e13@vorpal.se>
 <91260f39-27d9-222b-53e7-41ab4bb412a3@redhat.com>
 <9640be14-b478-5887-9057-de2796eccd6b@redhat.com>
 <ef3046e5-f402-3d33-8d94-4d9f87ceadd5@vorpal.se>
 <68b1c4fd-56a4-8de6-62ec-98bd6ef8b169@redhat.com>
 <918639a6-3cb0-5b8d-73b2-7eed623002a0@vorpal.se>
 <86b54175-e060-d4c2-ffd2-54f2544d6d4f@redhat.com>
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <86b54175-e060-d4c2-ffd2-54f2544d6d4f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2022-09-01 12:42, Hans de Goede wrote:
> Hi,
> 

<snip>

> 
> Great, thank you so much for testing this!
> 
> Is it ok if I add a:
> 
> Tested-by: Arvid Norlander <lkml@vorpal.se>
> 
> to the 2 patches for fixing this to give you credit for your testing ?

Yes, of course. As a newcommer it is hard to learn and remember all these
little rules you have in kernel development. It is quite different from the
forge-based workflow I'm used to.

> 
>> I'm not set up to test hibernation (using swap file on btrfs). Nor do I
>> know if it even works on this laptop. It has some sort of auto hibernate
>> feature in BIOS called Intel Rapid Start. It supposedly auto transitions to
>> hibernation after being asleep for a while. I have not looked into if this
>> is supported on Linux, and what setup would be required to support it in
>> that case.
> 
> Regular suspend/resume testing is what I was looking for. On restore
> from hibernation the backlight is already on when restoring the state so
> I don't expect any problems there.  And as you indicate getting hibernation
> to work is tricky in general, IMHO there is no need to go through all
> the trouble necessary to (maybe) get that to work.

Hm, I have not found it tricky when I have had swap partitions. At least on
my Thinkpads as long as I avoid nvidia drivers.

> 
> Regards,
> 
> Hans
> 

Best regards,
Arvid Norlander
