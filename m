Return-Path: <linux-acpi+bounces-507-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D0F7BC6CA
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 12:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE781C208C5
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2250182D5
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXB0+oNQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B21749B
	for <linux-acpi@vger.kernel.org>; Sat,  7 Oct 2023 08:51:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A045CEA
	for <linux-acpi@vger.kernel.org>; Sat,  7 Oct 2023 01:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696668679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDRM3x+Dbg0HgjsFOZuFQecU4AZd+pusA3mLRKOu+cI=;
	b=AXB0+oNQ5ysuoB2mVSy5+nBICMBraxj9En4g23KrUGMknWg/pIesFjhdbt69qxHCuUt10D
	NkR9i09H3gTFhSFmBSd/YHIZD9gWetWYCdNXDe9z8w+rmEhVJH9do39Nu6URozxlC7xfl6
	IhHODkGRogxq4vaDIKxI5tLp2y0+BCM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-PZqvDVMlNNmdmOoBI5UJNw-1; Sat, 07 Oct 2023 04:51:17 -0400
X-MC-Unique: PZqvDVMlNNmdmOoBI5UJNw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b2cf504e3aso242298266b.2
        for <linux-acpi@vger.kernel.org>; Sat, 07 Oct 2023 01:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696668677; x=1697273477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDRM3x+Dbg0HgjsFOZuFQecU4AZd+pusA3mLRKOu+cI=;
        b=CHCz28HBBjjd5Mai8vJ6gAD+QoMOgdclq9Jbitw5QbNvP3+mcVM+BZmYVpBGu20sgX
         S36zEsrW0SVRbOivXe3ExNeJS0La5UfFk1qN63ETpvH7UeeKWuqtiwFmaAW5Yl8dRNQp
         EQUl3EFy3fdVm2L4XaIkfE6RBTzlR0xv17gzYdxYFYDYscPadXuk0HO+FGjPTqhUmtMh
         OjcMRDxlSMI/FvgouzKp8kHiqTlEMLCNcJOFZTaLh+q1kweiu9N2iTn6GQky3rHXrHBx
         /rVKnwtNGCjA3fa+NmLHKaNjoDNS6HLE7AfweSAsiiiIk8J6v/U+Oel9nnrA81c0Biej
         gw4Q==
X-Gm-Message-State: AOJu0YzB8hFpGQdu2lHRDvh7dGJaI9CXVovLFoQW+a5k40MWZmjJbpVb
	q46drmuYub6YqIWOlm66R2veDT88ukZ44BwuV+xOZ6h5BMa6UFutysa1QYvEy/+Gruly/2VMOU1
	dD0RSOiIM08xFMQ1JXUymXA==
X-Received: by 2002:a17:906:5188:b0:9a5:c9a4:ba1b with SMTP id y8-20020a170906518800b009a5c9a4ba1bmr10482854ejk.8.1696668676805;
        Sat, 07 Oct 2023 01:51:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+Yb2r7gN29uw7TiEY3d3JfAvYPX6gsIQq82PCTAtWvTwZvWl3RZzGWb3BpGZ4CyNMEp9pNQ==
X-Received: by 2002:a17:906:5188:b0:9a5:c9a4:ba1b with SMTP id y8-20020a170906518800b009a5c9a4ba1bmr10482840ejk.8.1696668676423;
        Sat, 07 Oct 2023 01:51:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id qx18-20020a170906fcd200b0099bc8bd9066sm4037437ejb.150.2023.10.07.01.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 01:51:15 -0700 (PDT)
Message-ID: <026f8034-0b0e-9c77-f547-7f883b9b8bc1@redhat.com>
Date: Sat, 7 Oct 2023 10:51:15 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ACPI: resource: Add TongFang GM6BGEQ, GM6BG5Q and
 GM6BG0Q to irq1_edge_low_force_override[]
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: August Wikerfors <git@augustwikerfors.se>,
 Mario Limonciello <Mario.Limonciello@amd.com>, linux-acpi@vger.kernel.org,
 Francesco <f.littarru@outlook.com>, regressions@lists.linux.dev
References: <20231006123304.32686-1-hdegoede@redhat.com>
 <ed4672a7-439c-4240-aadc-7a36858c36b2@augustwikerfors.se>
 <9a905931-6210-8f6b-92f5-3c863d4a2e86@redhat.com>
 <CAJZ5v0gK1Q54sMRJJJBTf+gY5jd-_57jYKvN5ELNSpmaeVVjAw@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gK1Q54sMRJJJBTf+gY5jd-_57jYKvN5ELNSpmaeVVjAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Rafael,

On 10/6/23 21:20, Rafael J. Wysocki wrote:
> On Fri, Oct 6, 2023 at 5:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi August,
>>
>> On 10/6/23 16:18, August Wikerfors wrote:
>>> Hi Hans,
>>>
>>> On 2023-10-06 14:33, Hans de Goede wrote:
>>>> The TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q are 3 GPU variants of a TongFang
>>>> barebone design which is sold under various brand names.
>>>>
>>>> The ACPI IRQ override for the keyboard IRQ must be used on these AMD Zen
>>>> laptops in order for the IRQ to work.
>>>>
>>>> Adjust the irq1_edge_low_force_override[] DMI match table for this:
>>>>
>>>> 1. Drop the sys-vendor match from the existing PCSpecialist Elimina Pro 16
>>>>     entry for the GM6BGEQ (RTX3050 GPU) model so that it will also match
>>>>     the laptop when sold by other vendors such as hyperbook.pl.
>>>>
>>>> 2. Add board-name matches for the GM6BG5Q (RTX4050) and GM6B0Q (RTX4060)
>>>>     models.
>>>>
>>>> Suggested-by: August Wikerfors <git@augustwikerfors.se>
>>>> Reported-by: Francesco <f.littarru@outlook.com>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
>>>> Link: https://laptopparts4less.frl/index.php?route=product/search&filter_name=GM6BG
>>>> Link: https://hyperbook.pl/en/content/14-hyperbook-drivers
>>>> Link: https://linux-hardware.org/?probe=bfa70344e3
>>>> Link: https://bbs.archlinuxcn.org/viewtopic.php?id=13313
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> Since this is a regression fix for 453b014e2c29 ("ACPI: resource: Fix IRQ override quirk for PCSpecialist Elimina Pro 16 M") (for PCSpecialist systems like Francesco's with product name "Elimina Pro 16 M" but not board name "GM6BGEQ") and 2d331a6ac481 ("ACPI: resource: revert "Remove "Zen" specific match and quirks"") (for other vendors using the same TongFang design), it should have a "Fixes:" tag for at least one of those.
>>>
>>> Both of those commits are in 6.5 (and 6.6-rc) so this should go into 6.6-rc and be backported to 6.5, but the patch seems to depend on 424009ab2030 ("ACPI: resource: Drop .ident values from dmi_system_id tables") and maybe also d37273af0e42 ("ACPI: resource: Consolidate IRQ trigger-type override DMI tables") to apply cleanly, which seem to only be queued for linux-next/6.7? I'm not familiar with what the correct process is for such cases.
>>
>> You are right:
>>
>> Fixes: 453b014e2c29 ("ACPI: resource: Fix IRQ override quirk for PCSpecialist Elimina Pro 16 M")
> 
> OK
> 
>> Note likewise this commit should really also be send as a fix
>> for 6.6 and backported to the stable kernels:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/drivers/acpi/resource.c?h=bleeding-edge&id=c1ed72171ed580fbf159e703b77685aa4b0d0df5
> 
> That's harder, because it does depend on commit 424009ab2030 ("ACPI:
> resource: Drop .ident values from dmi_system_id tables") which is not
> 6.6-rc material IMV.
> 
> So I'm going to queue this up with the Fixes tag above and Cc: stable
> pointing to commit 424009ab2030 as a dependency, but for 6.7.

I realize that I'm the architect of this whole mess, but delaying
these new quirks to 6.7 does not seem like a good idea to me.

This fixes a serious problem (kbd not working pretty much makes
the whole laptop unusable under Linux at least on the road). With
a very small chance of regressions since this is DMI match base.

Maybe we can just take all the resource.c DMI quirk changes
as fixes to 6.6 ?  I admit the:

"ACPI: resource: Consolidate IRQ trigger-type override DMI tables"
"ACPI: resource: Drop .ident values from dmi_system_id tables"

patches are not really bugfixes. But they too have a very low
chance of causing regressions.

Regards,

Hans


p.s.

Note that "ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA"
should probably go as a fix to 6.6 regardless of the discussion since
that is a pure bugfix which applies cleanly on top of 6.6

And the same goes for this (unrelated) drivers/acpi/ec.c patch:

"ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx"

That too is a pure bugfix which IMHO should go to 6.6 as such.





