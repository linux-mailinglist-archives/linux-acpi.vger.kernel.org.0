Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00D03CB767
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 14:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbhGPMij (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 08:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbhGPMii (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 08:38:38 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA0CC06175F
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jul 2021 05:35:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1FD35BFC64;
        Fri, 16 Jul 2021 14:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1626438941; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=p719hhvLkmWdWf4z2n1jQy8p2K5vaq4SeJnoGL6fEUg=;
        b=TM5p4xWL1U9Ndv7qEWqfrBnaXet/8Exb2nKvtXBUGYlJ4Cmb8SraUZ9UggUSRzgs7LzCdY
        2AwKHAr87bi/CQxT+x7blNAf6VSL0OkPiVLlKk732lQ2WuefhwQXDraMmEezPZw7j8meTn
        vlQW53H6PO4vdEeWfyA9NYeH7qxPkWOKLMahOdkQjs7CJ1ZLUWgwHHP7WWoInOt8SvW4Hn
        vTH+N2ryqNV7x9vkKm9D4mAP4sV4X1ekVxn01WyqyERr4f30MZAH8xf2gMXjZfw6/GUgX8
        DJh54ZykWxyqqAQDlFlq5SM7HQnjVYbgKzViqMVuWwmYkLDSegTdU0+Pmji1iA==
Subject: Re: [PATCH] ACPI: PM: Only mark EC GPE for wakeup on Intel systems
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Julian Sikorski <belegdol@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210630194606.530-1-mario.limonciello@amd.com>
 <704855e5-fad4-a002-a16a-1f3fbddbf5f0@fris.de>
 <CAJZ5v0hSZcNf4Cy3fSA4jRjw1J5r5T36NOs9yCTiRksFLmjzFA@mail.gmail.com>
 <SA0PR12MB451080F1208ED9E104879F1EE2119@SA0PR12MB4510.namprd12.prod.outlook.com>
From:   Frieder Schrempf <frieder@fris.de>
Message-ID: <1f7f6251-ef02-92bd-b1d3-c60733f5a09e@fris.de>
Date:   Fri, 16 Jul 2021 14:35:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <SA0PR12MB451080F1208ED9E104879F1EE2119@SA0PR12MB4510.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 16.07.21 14:25, Limonciello, Mario wrote:
> [Public]
> 
>>>> These events only occur when the EC GPE is inadvertently set as a wakeup
>>>> source. Originally the EC GPE was only set as a wakeup source when using
>>>> the intel-vbtn or intel-hid drivers in commit 10a08fd65ec1 ("ACPI: PM:
>>>> Set up EC GPE for system wakeup from drivers that need it") but during
>>>> testing a reporter discovered that this was not enough for their ASUS
>>>> Zenbook UX430UNR/i7-8550U to wakeup by lid event or keypress.
>>>> Marking the EC GPE for wakeup universally resolved this for that
>>>> reporter in commit b90ff3554aa3 ("ACPI: PM: s2idle: Always set up EC GPE
>>>> for system wakeup").
>>>>
>>>> However this behavior has lead to a number of problems:
>>>>
>>>> * On both Lenovo T14 and P14s the keyboard wakeup doesn't work, and
>>>> sometimes the power button event doesn't work.
>>>> * On HP 635 G7 detaching or attaching AC during suspend will cause
>>>> the system not to wakeup
>>>> * On Asus vivobook to prevent detaching AC causing resume problems
>>>> * On Lenovo 14ARE05 to prevent detaching AC causing resume problems
>>>> * On HP ENVY x360  to prevent detaching AC causing resume problems
>>>>
>>>> As there may be other Intel systems besides ASUS Zenbook UX430UNR/i7-
>> 8550U
>>>> that don't use intel-vbtn or intel-hid avoid these problems by only
>>>> universally marking the EC GPE wakesource on non-AMD systems.
>>>>
>>>> Link:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchw
>> ork.kernel.org%2Fproject%2Flinux-
>> pm%2Fcover%2F5997740.FPbUVk04hV%40kreacher%2F%2322825489&amp;dat
>> a=04%7C01%7Cmario.limonciello%40amd.com%7Cc2ced5bd6bbb4e62e9ac08d
>> 948525197%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63762034
>> 0670859712%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=oUsKS5mjAa
>> rc%2FhnnY%2FILZWWzUbvdBQHlH1MAcusHSIw%3D&amp;reserved=0
>>>> Link:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.fr
>> eedesktop.org%2Fdrm%2Famd%2F-
>> %2Fissues%2F1230&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7
>> Cc2ced5bd6bbb4e62e9ac08d948525197%7C3dd8961fe4884e608e11a82d994e1
>> 83d%7C0%7C0%7C637620340670859712%7CUnknown%7CTWFpbGZsb3d8eyJ
>> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
>> 1000&amp;sdata=KKUiOSeAQEkFjN9X8y8k3sC3J3s48faaNLzklPO12as%3D&amp;
>> reserved=0
>>>> Link:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.fr
>> eedesktop.org%2Fdrm%2Famd%2F-
>> %2Fissues%2F1629&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7
>> Cc2ced5bd6bbb4e62e9ac08d948525197%7C3dd8961fe4884e608e11a82d994e1
>> 83d%7C0%7C0%7C637620340670859712%7CUnknown%7CTWFpbGZsb3d8eyJ
>> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
>> 1000&amp;sdata=kDGTIkQMh%2FGG4OhssvukJ7xJ7Ld6j6bl1TXRvpS58%2Fk%3D
>> &amp;reserved=0
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> As this seems to fix quite some issues for the AMD systems, is there any
>>> reason why this is not tagged as fix for stable? Are there any plans for
>>> backporting?
>>
> 
> There's a number of other patches in other subsystems besides this one that are
> needed for successful S0i3 on AMD systems that land in 5.14 but are not stable
> candidates at this time.  Perhaps after 5.14 is out and has been well tested it will
> make sense to send the whole remaining series back to stable.

Ok, thanks for clarifying! I guess I will just wait until the dust has 
settled.
