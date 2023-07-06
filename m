Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF887749BD6
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 14:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGFMd2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 08:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGFMdZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 08:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B561BE3
        for <linux-acpi@vger.kernel.org>; Thu,  6 Jul 2023 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688646678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5z9JqhldyDuTdwqsFffsop6ZZ3a2XGMJ/kErkTDhnA=;
        b=gNRYrxB/6V9SLRpC0qTVxeVTnNTisWd5MTK0N4Bq6R4h7JNZkTvnysn/H0ZYGm7dOUZde8
        CFdIVKPOt9fAMQ6tt+EJrboZK9wzUzS9mO7+lUoet5KYfcwz7HgfHivK66nGgwlynleZSZ
        6Jzn3uZT5vbq/nrbUCU1idg3bT2Fxfk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-h4-ieKq8Nje_TcNV20vrDw-1; Thu, 06 Jul 2023 08:31:17 -0400
X-MC-Unique: h4-ieKq8Nje_TcNV20vrDw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993831c639aso51047366b.2
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jul 2023 05:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688646676; x=1691238676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5z9JqhldyDuTdwqsFffsop6ZZ3a2XGMJ/kErkTDhnA=;
        b=kfTHokgOuD+totNF4UKPj+9tc8BJxH8ajFpjINsFVVa+jb6HKGBnKbdjqfFZk1QARj
         q+RADYpjpzn+c0k75vSnu+gJIw5aqGZCPgLeaQy3X2cgj45OZHV1GCCkzUDJCcPI/U1I
         qHFMEN4Xi0PNGyoGA/LMNUG9N162nWLZWj/y+DDZe1VrWALG269lcXtPUXJjxQZDJBJ8
         q8eiA0kGvd51e9c0xbjGRWoNlDblcBs/4NCU6QcQ38fP3ND4t9Mt6BCFMiTX+Ihnp1NH
         ytv/aITkXLG8PeNOD6gTqvdxHL3aldHPcYoU57sT6krN5GNSHsUVA7RfonZZIlhL/iv5
         7hJA==
X-Gm-Message-State: ABy/qLa8Tv+aysx+v4LlytBKgJqvf1YxIeCuGp1ZG72G1bPlxuGTqeck
        JNe6z9VUJfYD3TPa89VbB60RvFKhD77o1Ud+o8F/EfIH/2HhA3j2zIn6UGypS8yxnEVf67RkkVY
        GbCSpglOIJ2cjQNL7tdKSQw==
X-Received: by 2002:a17:906:1013:b0:98d:d26c:e13b with SMTP id 19-20020a170906101300b0098dd26ce13bmr1401914ejm.8.1688646676151;
        Thu, 06 Jul 2023 05:31:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHUK7MrSYoUIcMPPaXp4KnJW/AjIXj28r+WLLiOHAgQr3MCgXwVBwKwAaKoGunhP1ERR6Vy7g==
X-Received: by 2002:a17:906:1013:b0:98d:d26c:e13b with SMTP id 19-20020a170906101300b0098dd26ce13bmr1401887ejm.8.1688646675891;
        Thu, 06 Jul 2023 05:31:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gz3-20020a170906f2c300b009929c09abdfsm765786ejb.70.2023.07.06.05.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 05:31:15 -0700 (PDT)
Message-ID: <500c0f9a-7b81-3c13-6da8-39245282fe46@redhat.com>
Date:   Thu, 6 Jul 2023 14:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 18/18] media: atomisp: csi2-bridge: Add support for VCM
 I2C-client instantiation
Content-Language: en-US, nl
To:     Andy Shevchenko <andy@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-19-hdegoede@redhat.com>
 <ZKaUWAAf586ZIRMF@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZKaUWAAf586ZIRMF@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/6/23 12:15, Andy Shevchenko wrote:
> On Wed, Jul 05, 2023 at 11:30:10PM +0200, Hans de Goede wrote:
>> Fill sensor->vcm_type and call intel_cio2_bridge_instantiate_vcm() from
>> the v4l2-async bound op so that an I2C-client will be instatiated for
>> the VCM.
>>
>> Note unfortunately on atomisp the _DSM to get the VCM type sometimes
>> returns a VCM even though there is none. Since VCMs are typically only
>> used together with certain sensors, work around this by adding a vcm
>> field to atomisp_sensor_config and only check for a VCM when that is set.
> 
> ...
> 
>> +static char *atomisp_csi2_get_vcm_type(struct acpi_device *adev)
>> +{
>> +	union acpi_object *obj;
>> +	char *vcm_type;
>> +
>> +	obj = acpi_evaluate_dsm_typed(adev->handle, &vcm_dsm_guid, 0, 0,
>> +				      NULL, ACPI_TYPE_STRING);
>> +	if (!obj)
>> +		return NULL;
>> +
>> +	vcm_type = kstrdup(obj->string.pointer, GFP_KERNEL);
> 
> Where is the counterpart kfree()?

The vcm-type is stored in one of the generated sw-nodes and the ipu-bridge
code only creates those once and them leaves them in memory, even on
a rmmod. So this is deliberately leaked just like that the ipu_bridge
struct which contains all the swnode-s is deliberately leaked by
ipu-bridge.c

Regards,

Hans



> 
>> +	ACPI_FREE(obj);
>> +
>> +	if (!vcm_type)
>> +		return NULL;
>> +
>> +	string_lower(vcm_type, vcm_type);
>> +	return vcm_type;
>> +}
> 

