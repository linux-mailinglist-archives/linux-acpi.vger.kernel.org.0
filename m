Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1921D4C4135
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 10:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiBYJWw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Feb 2022 04:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbiBYJWv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 04:22:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40551B3E5A
        for <linux-acpi@vger.kernel.org>; Fri, 25 Feb 2022 01:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645780934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zs/ymP2WaH294uTd9JZ+0QQGXWyIxaz/3V5QrO6MW94=;
        b=L5jwfw436jER6bzrRdgT/aZrBOeoTgRklxtFsj+spR/pbMpQI64F7yUOHERbfG0pROwSdk
        cYwKajd1CDBbBpcfTDm4YuuzJEXOaK8Lr5hcHxFFlGXk/6qXbGcbgxZxX7PPc/kBBzSjpW
        AT+NhTrWovKZOWVwbIAeTzrN5Z/Nebk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-RNF6pzRlPkSIkhCvM5sh_A-1; Fri, 25 Feb 2022 04:22:12 -0500
X-MC-Unique: RNF6pzRlPkSIkhCvM5sh_A-1
Received: by mail-ej1-f69.google.com with SMTP id m12-20020a1709062acc00b006cfc98179e2so2389762eje.6
        for <linux-acpi@vger.kernel.org>; Fri, 25 Feb 2022 01:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zs/ymP2WaH294uTd9JZ+0QQGXWyIxaz/3V5QrO6MW94=;
        b=S15pF7AA589ON8tyiiydZOxucQjZppmKFq0K5lKVerfJ+1Rvxxf92FD+uU8DJDeZo8
         7RS67D6ONKPk0P6DqnQvkC9Hb7CZiJlJFv5h+qRp7lToExIZmIxZsqLA62hTOjCEwTyG
         LjqPV/GdfEcKEXUevl0bkVKltfM0FIPd/54P1ZtI/eVf/wTTJ+94YvXg0Eloiqhffr9j
         VS9VGnLGzUE00+xHE5k1pX8ylMHf+Uxsk7I0ued+vKGcb/rxtYhhm9R0WKAVhXcqxKQ2
         KCcF3Wq3YzFlNjDIExbi2CgI1/WyANMAUtJVMRp+104/OnKp4epb/c1I+2ACuaMa1kuF
         oz3A==
X-Gm-Message-State: AOAM533lVaHuI2+aBVo67HMUTp4XJw7JHdc+Hq7xUnBm4N48kNshYUYZ
        TgfLbRG0A976Y5iLLedaNlYQDDleXzsVt91R6gbLuUSiMG+5ENLvQdrdVbTm6XN3ygrWR6bfy5F
        F+5doDFyd420q4QZMW4S8BA==
X-Received: by 2002:a17:906:6c90:b0:6cd:37e6:2297 with SMTP id s16-20020a1709066c9000b006cd37e62297mr5505990ejr.507.1645780931042;
        Fri, 25 Feb 2022 01:22:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNUBQNKtnE9iscoVWnpSlJ9Ku4C5VfWCOmUcgax8l/mtoni86gZdyc3Qew0e5w/6+PCHC5VQ==
X-Received: by 2002:a17:906:6c90:b0:6cd:37e6:2297 with SMTP id s16-20020a1709066c9000b006cd37e62297mr5505982ejr.507.1645780930861;
        Fri, 25 Feb 2022 01:22:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709062f8f00b006cd545d4af6sm786892eji.45.2022.02.25.01.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 01:22:10 -0800 (PST)
Message-ID: <d89e734f-2f85-aa76-f3b5-ae03a1f6cc0d@redhat.com>
Date:   Fri, 25 Feb 2022 10:22:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/6] platform/x86: int3472: Support multiple clock
 consumers
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     rafael@kernel.org, lenb@kernel.org, markgross@kernel.org,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20220216225304.53911-1-djrscally@gmail.com>
 <20220216225304.53911-4-djrscally@gmail.com>
 <c7d1539f-01a2-299d-ca4f-8e60cfe71775@redhat.com>
 <20220225004943.AA8EDC340EF@smtp.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220225004943.AA8EDC340EF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Stephen,

On 2/25/22 01:49, Stephen Boyd wrote:
> Quoting Hans de Goede (2022-02-21 01:59:09)
>> Hi,
>>
>> On 2/16/22 23:53, Daniel Scally wrote:
>>> At present, the int3472-tps68470 only supports a single clock consumer when
>>> passing platform data to the clock driver. In some devices multiple
>>> sensors depend on the clock provided by a single TPS68470 and so all
>>> need to be able to acquire the clock. Support passing multiple
>>> consumers as platform data.
>>>
>>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Michael, I plan to merge this entire series through the platform-drivers-x86 git
>> tree, may I have your ack for merging the clk bits from this ?
>>
> 
> With the type fix
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Thanks, and sorry for not addressing you, I should have seen that
there are 2 clk subsys maintainers (and I know from experience
that you are the most active maintainer recently).

Regards,

Hans

