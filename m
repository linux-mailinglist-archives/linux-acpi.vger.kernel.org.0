Return-Path: <linux-acpi+bounces-475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2701C7BBCD9
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 18:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D460D28196C
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D33428E03
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcRQn+lT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84221273FB
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 15:17:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387B3CF
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696605463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CtGazeMDVs11juc+046JIkadiDiGDKBQoMZvQIXcRhM=;
	b=PcRQn+lTLk2o7rblWyIZZS76fnnQSl91fqLYt+BE78CS2mRmYc06pF7Qsi3vXyq0EtRqhb
	Hv9F826ugiua50VNZHepCO0C/xYQolhqvsDB+UHjbAEQfVcscToqyMapjldQWTtAoo4sw9
	73xyuw2sGVLlu0etlPbE6IkG/1PW3cM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-qTyVCcG6MLeMrU7mRcqHbw-1; Fri, 06 Oct 2023 11:17:42 -0400
X-MC-Unique: qTyVCcG6MLeMrU7mRcqHbw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-538ed3724bcso1904101a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 06 Oct 2023 08:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696605461; x=1697210261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtGazeMDVs11juc+046JIkadiDiGDKBQoMZvQIXcRhM=;
        b=Jcv2/Oh/WX/itmpi+uRapPz8t+3X+4c23re+IuI0h+82ZA+OgN4yc7LlA7Xw36XiiS
         XGVVMIH2huGA8AHiEFdQZj41k6giwfxPgNqbllPAZZLdWCHmgDYxk5qhkQ+KLm6//5UC
         ZQ9hFLb+xdUJ4FKjT6O+Nu2wLloaaJPLthdN+raTJcbIlKiH7mHu9bM+MZqO2Ef7UO4M
         vA/d9Jw/PymfiHtJd/gHVuJfdAdv8bcoYTSjyVnPtaDZsOGI0c6sHwSStFxFmz14ijU5
         BbTdn7s7JrV9zNWdU1kOnbts1hRbLifGqq0wfxZGYjOusgBUzuzf5fmOjagBrVIZTgzB
         9Yvw==
X-Gm-Message-State: AOJu0YwrUhy4UnC4rjyCYcHWJUjPn0g2a1Q2+xg0Wg6M5TBwRaFZCbWz
	yUPPcTV3ylnaKyezGdUEegnr2F0cFD3LLoDHcI1JmWa48E4nEoyX1dyRSY/qAsqqPB8ACKh6BsO
	Vnv+1gRBXaR56A8LRIkD2Ig==
X-Received: by 2002:a05:6402:544:b0:534:5e2a:d443 with SMTP id i4-20020a056402054400b005345e2ad443mr7422600edx.29.1696605460510;
        Fri, 06 Oct 2023 08:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGokPFz/Wy5FDk3w3bAVj0cR6YYJTT2f6ESS/2aLaUWO9TRQ1GEIEu69o54NihpLI6UzA1zHQ==
X-Received: by 2002:a05:6402:544:b0:534:5e2a:d443 with SMTP id i4-20020a056402054400b005345e2ad443mr7422572edx.29.1696605460150;
        Fri, 06 Oct 2023 08:17:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p26-20020aa7d31a000000b00534ac155da7sm2699665edq.29.2023.10.06.08.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 08:17:39 -0700 (PDT)
Message-ID: <9a905931-6210-8f6b-92f5-3c863d4a2e86@redhat.com>
Date: Fri, 6 Oct 2023 17:17:38 +0200
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
Content-Language: en-US, nl
To: August Wikerfors <git@augustwikerfors.se>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Mario Limonciello <Mario.Limonciello@amd.com>, linux-acpi@vger.kernel.org,
 Francesco <f.littarru@outlook.com>, regressions@lists.linux.dev
References: <20231006123304.32686-1-hdegoede@redhat.com>
 <ed4672a7-439c-4240-aadc-7a36858c36b2@augustwikerfors.se>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ed4672a7-439c-4240-aadc-7a36858c36b2@augustwikerfors.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi August,

On 10/6/23 16:18, August Wikerfors wrote:
> Hi Hans,
> 
> On 2023-10-06 14:33, Hans de Goede wrote:
>> The TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q are 3 GPU variants of a TongFang
>> barebone design which is sold under various brand names.
>>
>> The ACPI IRQ override for the keyboard IRQ must be used on these AMD Zen
>> laptops in order for the IRQ to work.
>>
>> Adjust the irq1_edge_low_force_override[] DMI match table for this:
>>
>> 1. Drop the sys-vendor match from the existing PCSpecialist Elimina Pro 16
>>     entry for the GM6BGEQ (RTX3050 GPU) model so that it will also match
>>     the laptop when sold by other vendors such as hyperbook.pl.
>>
>> 2. Add board-name matches for the GM6BG5Q (RTX4050) and GM6B0Q (RTX4060)
>>     models.
>>
>> Suggested-by: August Wikerfors <git@augustwikerfors.se>
>> Reported-by: Francesco <f.littarru@outlook.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
>> Link: https://laptopparts4less.frl/index.php?route=product/search&filter_name=GM6BG
>> Link: https://hyperbook.pl/en/content/14-hyperbook-drivers
>> Link: https://linux-hardware.org/?probe=bfa70344e3
>> Link: https://bbs.archlinuxcn.org/viewtopic.php?id=13313
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Since this is a regression fix for 453b014e2c29 ("ACPI: resource: Fix IRQ override quirk for PCSpecialist Elimina Pro 16 M") (for PCSpecialist systems like Francesco's with product name "Elimina Pro 16 M" but not board name "GM6BGEQ") and 2d331a6ac481 ("ACPI: resource: revert "Remove "Zen" specific match and quirks"") (for other vendors using the same TongFang design), it should have a "Fixes:" tag for at least one of those.
> 
> Both of those commits are in 6.5 (and 6.6-rc) so this should go into 6.6-rc and be backported to 6.5, but the patch seems to depend on 424009ab2030 ("ACPI: resource: Drop .ident values from dmi_system_id tables") and maybe also d37273af0e42 ("ACPI: resource: Consolidate IRQ trigger-type override DMI tables") to apply cleanly, which seem to only be queued for linux-next/6.7? I'm not familiar with what the correct process is for such cases.

You are right:

Fixes: 453b014e2c29 ("ACPI: resource: Fix IRQ override quirk for PCSpecialist Elimina Pro 16 M")

Note likewise this commit should really also be send as a fix
for 6.6 and backported to the stable kernels:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/drivers/acpi/resource.c?h=bleeding-edge&id=c1ed72171ed580fbf159e703b77685aa4b0d0df5

Regards,

Hans



> 
>> ---
>> Changes in v2:
>> - Add missing reported and suggested by tags
>> ---
>>   drivers/acpi/resource.c | 20 +++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 014a3911381b..18f6353c142e 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -512,17 +512,23 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
>>           },
>>       },
>>       {
>> -        /*
>> -         * PCSpecialist Elimina Pro 16 M
>> -         *
>> -         * Some models have product-name "Elimina Pro 16 M",
>> -         * others "GM6BGEQ". Match on board-name to match both.
>> -         */
>> +        /* TongFang GM6BGEQ / PCSpecialist Elimina Pro 16 M, RTX 3050 */
>>           .matches = {
>> -            DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
>>               DMI_MATCH(DMI_BOARD_NAME, "GM6BGEQ"),
>>           },
>>       },
>> +    {
>> +        /* TongFang GM6BG5Q, RTX 4050 */
> FWIW the PCSpecialist Elimina Pro 16 M is sold with all three GPU options: https://www.pcspecialist.ie/notebooks/elimina-pro-16-M/
> Presumably the RTX 4050 option has board name "GM6BG5Q" but maybe it's better to leave it out if it's not confirmed.
> 
>> +        .matches = {
>> +            DMI_MATCH(DMI_BOARD_NAME, "GM6BG5Q"),
>> +        },
>> +    },
>> +    {
>> +        /* TongFang GM6BG0Q / PCSpecialist Elimina Pro 16 M, RTX 4060 */
>> +        .matches = {
>> +            DMI_MATCH(DMI_BOARD_NAME, "GM6BG0Q"),
>> +        },
>> +    },
>>       { }
>>   };
>>   
> 
> Regards,
> August Wikerfors
> 


