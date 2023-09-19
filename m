Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01A7A5823
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Sep 2023 05:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjISDzA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Sep 2023 23:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjISDy6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 23:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED71C122
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 20:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695095649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=opGMZb4zVfpw4j3bwF+zyk+VH4LC+VDK5rPEHS4VpxU=;
        b=Y9HGGUSpjBmN+UdmvCIEp0ZMteMCx9Ci5sLS9VwiS1BJ41tP823IcL6m5TbakN5tp/eYNz
        /Db0XX7mlis4zyFdWTIi6pcI+vCkB7TUSMaVqQ4alOj4yBtmssQuZO9YXWVoz65RrA+jhS
        bGvTvYjZSr5J9WCG3PJXGEVlWeIRoRs=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-HxsStjNbN86_mn1NvjlBTg-1; Mon, 18 Sep 2023 23:54:04 -0400
X-MC-Unique: HxsStjNbN86_mn1NvjlBTg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3ade3827a69so679156b6e.3
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 20:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695095644; x=1695700444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opGMZb4zVfpw4j3bwF+zyk+VH4LC+VDK5rPEHS4VpxU=;
        b=ILgzEH1NcfA8n8i0PKrA6FdDu46w8mhM/O9pVCqPgz8ArfRSWliZQOBcILK01U5d/K
         OKvy6EQOey+/QcgWsMnbvIZ4kS3482wMW5vG91pAHS/yaiv3tjiDGsp6IJSGZfUqM9HQ
         eLQWFb6oqDBt1CE6rvLNPkwURcxUDTGeH1xC1EVsltG42+B3yZv2LuBMP7O2+ofPuwr+
         Gfi+lm1KV0WBoDmgIURbLa88KjB+LDYg7tDreQCQZi1dTw108SN5sol9A6uagGF1ldiv
         vgE7BM4XLIUzv96hmsPED34cFqlXRdFrxFPfdPdyWHja5pYdjjVAvjcWDToS+0AdWUsZ
         VsBQ==
X-Gm-Message-State: AOJu0Yw/TQdTIEjN23GaeR08CNkGqjv1+Xbf5Y/GLbT5ApKOrx1VL6CJ
        yo6fBGxz1pf1zB5Yb1ZOxihmAsJwXHRHF1gLAYwhyPxu8R1UjN41Jpl7OmWDkWRO3xUjo+9dHZh
        UslF7+i6hwqiew7SJ/eXCwg==
X-Received: by 2002:a54:4504:0:b0:3a3:76c6:a46f with SMTP id l4-20020a544504000000b003a376c6a46fmr12922324oil.38.1695095644170;
        Mon, 18 Sep 2023 20:54:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGYlj7TJDnGHj/RWXEc2C+lTOzyiwCCuIn5mHVU8DsjC6vooAlJ9Xs3Gr3phqs2j6qI73HUw==
X-Received: by 2002:a54:4504:0:b0:3a3:76c6:a46f with SMTP id l4-20020a544504000000b003a376c6a46fmr12922314oil.38.1695095643929;
        Mon, 18 Sep 2023 20:54:03 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id s5-20020a17090a948500b0026b3f76a063sm7639370pjo.44.2023.09.18.20.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 20:54:03 -0700 (PDT)
Message-ID: <ea0a43be-4143-7efa-b1c6-550ece6965f6@redhat.com>
Date:   Tue, 19 Sep 2023 13:53:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 30/35] irqchip/gic-v3: Add support for ACPI's
 disabled but 'online capable' CPUs
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-31-james.morse@arm.com>
 <ZQLADHCbOr5J8TpX@shell.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZQLADHCbOr5J8TpX@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 9/14/23 18:10, Russell King (Oracle) wrote:
> On Wed, Sep 13, 2023 at 04:38:18PM +0000, James Morse wrote:
>>   static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
>>   {
>> -	return (gicc->flags & ACPI_MADT_ENABLED);
>> +	return ((gicc->flags & ACPI_MADT_ENABLED ||
>> +		 gicc->flags & ACPI_MADT_GICC_CPU_CAPABLE));
> 
> ... and this starts getting silly with the number of parens.
> 
> 	return gicc->flags & ACPI_MADT_ENABLED ||
> 	       gicc->flags & ACPI_MADT_GICC_CPU_CAPABLE;
> 
> is entirely sufficient. Also:
> 
> 	return gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_CPU_CAPABLE);
> 
> also works.
> 

vote for the second one, which is: gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_CPU_CAPABLE)

Thanks,
Gavin

