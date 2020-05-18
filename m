Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E581D71B1
	for <lists+linux-acpi@lfdr.de>; Mon, 18 May 2020 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgERHW7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 03:22:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38139 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgERHW7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 May 2020 03:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589786577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CDV6x+LbRIT81sDBbNhyRgMHCkZ5P5dh5ZdEq0nLHtA=;
        b=aga6SMOsKWNppK8vyqWZei1Xs09wUn/g68ccOJNHxXP50OGNA11MpABLGBJ/odmSBnzsLv
        p/Vz8mMS/Bm7YMKv12WrWAOhzvM6vYA0bSHmAfHTHaX6Oq18T+EFnlrrL+ODPC6XPhk1gd
        vPOuOQIxxEDwjoJG3OArC04rA94Cyzc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-r7MTMDhkPDuRHdX3j7VTUw-1; Mon, 18 May 2020 03:22:55 -0400
X-MC-Unique: r7MTMDhkPDuRHdX3j7VTUw-1
Received: by mail-wr1-f71.google.com with SMTP id z5so5191968wrt.17
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2020 00:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CDV6x+LbRIT81sDBbNhyRgMHCkZ5P5dh5ZdEq0nLHtA=;
        b=Kk9mpm1iLWZ7VKXt4+7SeMztg1zIO3ObF8anSnNtZXComcSUrd/wAc0zMgIbE7Mqyf
         jscW306xjXMxUelRSG0dU3V9rrx36dHpE5TRYwz+mTNPX/W/ug7ABIDbUi7p3/1AJN87
         IytSb7tiB9ytvQ8UBJNe8kj8KiQ3vtYHi0wHBZLoHINAsbQrJThzkbjB5AKrP63ZEU/O
         Vo6fmDD7ReqmD5vuD5yM6cmwEDXyj0gwdOgEsyZ7JvYWRBa9OFi7TAdWS96YVaGQAPgx
         bWOwi+zbW02M8XyDDVdK97lBXg5lA5fVFfhGn5NLgZE/e3lUYiKSIFhtvYYNHkTdV7Ts
         SFwQ==
X-Gm-Message-State: AOAM5305mDjpKdn4gQpxNJBdI0Gb6H2KNRYxnwi2lPqRxVDHFizpOmgL
        4oZ+E0eypd3StqMXaE3gqmgk1fD3c2VvGGwfPsnHmypTNpRYrhmubyQZ4fKQ26q0X8krZVeFoFG
        Gg/nsKNmzrr3SSNEK4So3ng==
X-Received: by 2002:a1c:49:: with SMTP id 70mr17068089wma.184.1589786574457;
        Mon, 18 May 2020 00:22:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQsxRMMMhF3+7UoPaofmXTgG0IdeYJenN30PROILcSoebYagjpzY916Llt3TsieWh2pHWUNQ==
X-Received: by 2002:a1c:49:: with SMTP id 70mr17068068wma.184.1589786574266;
        Mon, 18 May 2020 00:22:54 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id h27sm17386798wrc.46.2020.05.18.00.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 00:22:53 -0700 (PDT)
Subject: Re: [PATCH 1/2] ACPI / PMIC: Add i2c address for thermal control
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <cover.1589262490.git.mchehab+huawei@kernel.org>
 <4ea6a89bcde8c72427e69a87551bdfca8bf1af11.1589262490.git.mchehab+huawei@kernel.org>
 <CAJZ5v0gRScLoBGr6546=zJBtZj2D0-Yv48RZobN-0eih01L29A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <89fd7ece-ab9c-cee0-e575-7652a992fe3a@redhat.com>
Date:   Mon, 18 May 2020 09:22:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gRScLoBGr6546=zJBtZj2D0-Yv48RZobN-0eih01L29A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 5/15/20 6:28 PM, Rafael J. Wysocki wrote:
> On Tue, May 12, 2020 at 7:52 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
>>
>> On Asus T101HA, we keep receiving those error messages:
>>
>>          i915 0000:00:02.0: [drm] *ERROR* mipi_exec_pmic failed, error: -95
>>          intel_soc_pmic_exec_mipi_pmic_seq_element: Not implemented
>>          intel_soc_pmic_exec_mipi_pmic_seq_element: i2c-addr: 0x5e reg-addr 0x4b value 0x59 mask 0xff
>>
>> Because the opregion is missing the I2C address.
>>
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> ---
>>   drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
>> index 7ccd7d9660bc..a5101b07611a 100644
>> --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
>> +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
>> @@ -102,6 +102,7 @@ static struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
>>          .power_table_count = ARRAY_SIZE(chtdc_ti_power_table),
>>          .thermal_table = chtdc_ti_thermal_table,
>>          .thermal_table_count = ARRAY_SIZE(chtdc_ti_thermal_table),
>> +       .pmic_i2c_address = 0x5e,
>>   };
>>
>>   static int chtdc_ti_pmic_opregion_probe(struct platform_device *pdev)
>> --
> 
> This appears to be part of a series, but the second patch has not been
> CCed to linux-acpi.

Mauro send out 3 patches related to the PMIC, this one and 2 MFD patches.
I think his intention was to send out this standalone and the 2 MFD patches
as a series, but instead he send out this 1 + 1 MFD patch as a series and
the other MFD patch as a standalone patch.

Either way this patch is a standalone patch, the 2/2 patch is almost
completely unrelated, so if you can pick this one up, then that would be
great.

Regards,

Hans

