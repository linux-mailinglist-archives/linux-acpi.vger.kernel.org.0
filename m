Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279C361F005
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Nov 2022 11:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiKGKME (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Nov 2022 05:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiKGKME (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Nov 2022 05:12:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C93F186F9
        for <linux-acpi@vger.kernel.org>; Mon,  7 Nov 2022 02:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667815863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2joyg/Y0Frm3DrFDZnrlLZ/48yC402wd11jenlPgzmA=;
        b=ANGRa6q7upM5zT5tkTq1T8sbeYJVA6rgZkzYoFteGxUkegyu1GYVfDkO4k0K3Jd0YMC9B8
        KWgcQD1Hvoo7IFIJoIwen5SxaNceiuLOgVQ8TjLEEsvXsLq8DovPcmmCEeJ4OvegFCv851
        UVBJfVmfULzH3X3bHAEo04veawKQLFo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-241-KaWydovKPVS0c-ZcBdM3qA-1; Mon, 07 Nov 2022 05:11:02 -0500
X-MC-Unique: KaWydovKPVS0c-ZcBdM3qA-1
Received: by mail-ej1-f70.google.com with SMTP id sh31-20020a1709076e9f00b007ae32b7eb51so4052748ejc.9
        for <linux-acpi@vger.kernel.org>; Mon, 07 Nov 2022 02:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2joyg/Y0Frm3DrFDZnrlLZ/48yC402wd11jenlPgzmA=;
        b=arJnSMsC/IV93czWtJYCphf62cYAAUXG0uI5Xq9TIB65kQ/Qawfdks+vaElzRkxtYY
         weS4SQeskhbLCO7HwbqiKUTFSK9KLI8iYA/s8FkNrkMXcECK2BlaPNKxyye5HEp+XAJt
         u1zVyskg+NdpRQdCHzlAnl1nAKgtfPCp6Xl446H+zOnbZWr9U0je+Z2MJfnQB1htBav7
         h9PK6nQwK73+/KD9sxarYGa25sV+rvjD5qFjK5OmZpr5xWqVvqCpM0mT9FUXSjMCS17r
         FA8l1S5xhZHwoWkHFmVfwCUT4w+GuDCGyhfYwB+yWnLsWzi9DJpQChkZy1MORiyI0M1l
         L2LQ==
X-Gm-Message-State: ACrzQf09YKrxgU/K6WFRZN/H2dU+A2/Orc7T8+dyZ3ertOKst+MDYn9e
        ATrWuzHsLfRGV/OZ4fLpT2MNNAWgfzEd79gB0LfV8mBIYQWklH7kdUM/6XoA+r7ZHzCO4H3plxA
        4pHm4r7E3B3Ln/n070J6BQw==
X-Received: by 2002:a50:bb06:0:b0:461:4acc:4540 with SMTP id y6-20020a50bb06000000b004614acc4540mr51228037ede.307.1667815860666;
        Mon, 07 Nov 2022 02:11:00 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7kbj6phhXGHkimhxJvMalWj0xdMtE1Bg7QYtcoGOoguaIp4xajIfpiQo1HZMIqGl0eOYa68w==
X-Received: by 2002:a50:bb06:0:b0:461:4acc:4540 with SMTP id y6-20020a50bb06000000b004614acc4540mr51228025ede.307.1667815860486;
        Mon, 07 Nov 2022 02:11:00 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id s18-20020aa7c552000000b00461c1804cdasm3991790edr.3.2022.11.07.02.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 02:10:59 -0800 (PST)
Message-ID: <04d96d5a-eb81-eb5a-5db8-9103f1da5c42@redhat.com>
Date:   Mon, 7 Nov 2022 11:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 0/3] ACPI: video: Fix backlight regressions in 6.1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org
References: <20221104212108.73537-1-hdegoede@redhat.com>
 <CAJZ5v0h8FvqLwTixFALfOT2xbgiSqbT3XCMCbubwad4fHpK0hQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0h8FvqLwTixFALfOT2xbgiSqbT3XCMCbubwad4fHpK0hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/5/22 19:03, Rafael J. Wysocki wrote:
> On Fri, Nov 4, 2022 at 10:22 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael,
>>
>> Here is a series of patches to fix known (and likely also unknown)
>> regressions caused by the backlight-detect refactor landing in 6.1.
>>
>> This builds on top of the earlier Chromebook fix which went upstream
>> through platform-drivers-x86.git/fixes. as such I believe it would
>> be best for this series to go upstream through the pdx86 tree.
>>
>> Can you please give your Ack for merging this through the pdx86
>> git tree?
> 
> Sure, feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to these patches.

Thanks, I'll go and prepare a fixes pull-req for Linus with these patches.

> Also note that I'm going to drop the previously applied
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=6a377205da554cec45c8fd1cd8395030b448de31

Ack, thanks.

Regards,

Hans

