Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE04749DA5
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjGFN3Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 09:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjGFN3X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 09:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F902E1
        for <linux-acpi@vger.kernel.org>; Thu,  6 Jul 2023 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688650124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pNsnYUe+79Gr5pg0TJZSxSnB5xwOLsni0nvUY+1anj0=;
        b=F9r/KCLZaM0LtnYXvO6kEVH+ej0QH12ms/THJlsev4zaNsoZQDcRlw46XgOh5qEZoxV4M7
        XRB61FnPPPlNQvHbuGEADLruYg2yWehAZPCnNnF/0WMDeEZ9sCbo4KUUCxnzeUq24wgnW9
        EY8MjgMSdn6CVShKXLziKDUQDT6400o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-cktQgbd5Ov2wNeJG3YNLQg-1; Thu, 06 Jul 2023 09:28:43 -0400
X-MC-Unique: cktQgbd5Ov2wNeJG3YNLQg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51d8823eb01so573150a12.1
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jul 2023 06:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688650122; x=1691242122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNsnYUe+79Gr5pg0TJZSxSnB5xwOLsni0nvUY+1anj0=;
        b=GqrvcmFMIK7Y1+zDzV/c1eqoXlEMKBu8x8xZa340F+jBfU8cp80h6vnKdcjRMbpRXz
         Dn7v1X66Om2Ley5cXXKTQXe0DJ9RdMfYQg479KoXDBbg0smUetUr9wMWDFztxNnfDnxb
         oXxx8WDGaf0vyqnY0tamCSQFtPsoWpfVQIaelZOjeSRAHvFihmOimzNG+AihIbmp8zi+
         z0ypjeW2O1fEqoqC0tj3BLL9H+mv2vTyvjrkTp5fvT7Zq6qSfT+X26Z6F/YgPU/t4Tto
         T61gehLjsbNJTAzCqUicot1oyeFegnZATjai/7IUAMaZJ/hmaMK86qugE0TDigBrRSiv
         hcCQ==
X-Gm-Message-State: ABy/qLbhPDQoj3zTKLfF+SdhQVXnX1R6e+5dAkjIiCaSFRyrjabd2lOB
        ABUuZNiGOyLLoQ31IyHqaJhSuuDiFnhBuj4ncj8gfFxLemlNhITMMykI14HCwMc7mTNxgwp6qwR
        BrLtAq+rook+x0uQGrNIWJg==
X-Received: by 2002:a05:6402:890:b0:51d:a308:74f9 with SMTP id e16-20020a056402089000b0051da30874f9mr1577192edy.29.1688650122318;
        Thu, 06 Jul 2023 06:28:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGYrL9VV2OjdDy4YdgM+Be453WHMg9CvX8y5OBGB1Amfae9PD1h1ASYfjCOaH4JXlT2b4VpRw==
X-Received: by 2002:a05:6402:890:b0:51d:a308:74f9 with SMTP id e16-20020a056402089000b0051da30874f9mr1577176edy.29.1688650122005;
        Thu, 06 Jul 2023 06:28:42 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z25-20020aa7cf99000000b0051e24600e12sm776040edx.61.2023.07.06.06.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 06:28:41 -0700 (PDT)
Message-ID: <fe819d77-333b-d5e4-45ba-52250fb79bab@redhat.com>
Date:   Thu, 6 Jul 2023 15:28:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 15/18] ACPI: bus: Introduce acpi_match_acpi_device()
 function
Content-Language: en-US, nl
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-16-hdegoede@redhat.com>
 <ZKaHErGZOVXXDn9c@smile.fi.intel.com>
 <08825217-ff29-1f58-220d-617570836542@redhat.com>
 <CAJZ5v0imzHiNxff3RQJvMzvr_xWHXERoyzYmLyZS7hASO0qN+A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0imzHiNxff3RQJvMzvr_xWHXERoyzYmLyZS7hASO0qN+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 7/6/23 15:26, Rafael J. Wysocki wrote:
> On Thu, Jul 6, 2023 at 2:29 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 7/6/23 11:19, Andy Shevchenko wrote:
>>> On Wed, Jul 05, 2023 at 11:30:07PM +0200, Hans de Goede wrote:
>>>> Some ACPI glue code (1) may want to do an acpi_device_id match while
>>>> it only has a struct acpi_device available because the first physical
>>>> node may not have been instantiated yet.
>>>>
>>>> Add a new acpi_match_acpi_device() helper for this, which takes
>>>> a "struct acpi_device *" as argument rather then the "struct device *"
>>>> which acpi_match_device() takes.
>>>>
>>>> 1) E.g. code which parses ACPI tables to transforms them
>>>> into more standard kernel data structures like fwnodes
>>>
>>> Looks like it's v1 of my original patch, anyway this is now in Linux Next as
>>> 2b5ae9604949 ("ACPI: bus: Introduce acpi_match_acpi_device() helper").
>>
>> Ah interesting, it does indeed look a lot like your version.
>> but it was developed independently.
>>
>> Unfortunately it seems that this is headed for 6.6-rc1 and the atomisp
>> changes in this series which rely on this are intended for 6.6-rc1 too.
> 
> No, the material Andy is talking about will be pushed for 6.5-rc1
> (probably even today), because it is part of a fix for systems that
> are broken in the field.
> 
>> So we still need to figure out how to merge this.
> 
> This shouldn't be a problem.

Great, thank you.

Regards,

Hans

