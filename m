Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BB31CEE68
	for <lists+linux-acpi@lfdr.de>; Tue, 12 May 2020 09:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgELHpR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 May 2020 03:45:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39465 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725823AbgELHpR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 May 2020 03:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589269515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qogJlqBrtgB8Cetl7KnaPS+eRicDS5Deuj/Ua6MW4IA=;
        b=ECRZz9ojE/Vg44GuQwN6t/izaYzol8NzRXyS2HB7x7KssrhadulmUTH7e6Bcidjo1xnqgr
        NAR4rRS3SE+71D7H0mjj9ox499y0qxZJRYqYWCvdu2OqU0pEPMVJrABIvgAFB6L0leuaPh
        /QTR07Jad1WrpfGOLr9Aar83W2qb/PA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-_5bUo0tSO2eKKvRhLtEKGA-1; Tue, 12 May 2020 03:45:14 -0400
X-MC-Unique: _5bUo0tSO2eKKvRhLtEKGA-1
Received: by mail-wr1-f69.google.com with SMTP id z8so6505319wrp.7
        for <linux-acpi@vger.kernel.org>; Tue, 12 May 2020 00:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qogJlqBrtgB8Cetl7KnaPS+eRicDS5Deuj/Ua6MW4IA=;
        b=GjX1OY3+1Ido7GLzNM+FGilT4tsCV2w1Aos7MheUHI80LfWRyuKPILHYq3WO96n/hQ
         97qepHDjDZUBIlrTKO+qo2KhNY+oivOkSTULmU8D7hLoSHYZbSPTa8YE9mutXGg97XWl
         HztiLnyqHTKgHROF751DVF/cg7dRWuzXnj8uY17+8Lt2eCZFGbqACBlI0lRNoMaRnopf
         mposjEgW7MLKwcCtUQyhKGPzNCGSxC0jzZzZbkmEhhuD1Q0OZMmVdjh7cag6+kphbyPE
         vtMGAbSU39lFLSZEEE+QIkooVlmFjssPdPgbqnSnzY6sc3TbKpzaOy7ZoD1YTFdiwjmU
         Btbg==
X-Gm-Message-State: AGi0PuYn7V2iuv/QzgO/HgWuEuMD+bzo2k85/yRIwmBR/Hxx4UAGGWXQ
        jM3LdEfv8TXg7RpW25gV527SQCq0TZ+0xZFjwtN9qfVxbp1b6EC41mdwqLvJI5IWAKCzVyMcdNJ
        dG9A4p9ilbdT5LZHMaEISJQ==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr35150268wmc.93.1589269512832;
        Tue, 12 May 2020 00:45:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypIGfg6opgkdevY9siA7TOIK+FzCH62oLKl8E96YDTwIJUq/LcuamnpbU9ZUopthrFhTdIWAqQ==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr35150262wmc.93.1589269512658;
        Tue, 12 May 2020 00:45:12 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id f5sm21069562wrp.70.2020.05.12.00.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 00:45:12 -0700 (PDT)
Subject: Re: [PATCH 1/2] ACPI / PMIC: Add i2c address for thermal control
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <cover.1589262490.git.mchehab+huawei@kernel.org>
 <4ea6a89bcde8c72427e69a87551bdfca8bf1af11.1589262490.git.mchehab+huawei@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2038c2ab-bbca-f26b-e2e2-fff04ca48272@redhat.com>
Date:   Tue, 12 May 2020 09:45:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4ea6a89bcde8c72427e69a87551bdfca8bf1af11.1589262490.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/12/20 7:51 AM, Mauro Carvalho Chehab wrote:
> On Asus T101HA, we keep receiving those error messages:
> 
> 	i915 0000:00:02.0: [drm] *ERROR* mipi_exec_pmic failed, error: -95
> 	intel_soc_pmic_exec_mipi_pmic_seq_element: Not implemented
> 	intel_soc_pmic_exec_mipi_pmic_seq_element: i2c-addr: 0x5e reg-addr 0x4b value 0x59 mask 0xff
> 
> Because the opregion is missing the I2C address.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> index 7ccd7d9660bc..a5101b07611a 100644
> --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> @@ -102,6 +102,7 @@ static struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
>   	.power_table_count = ARRAY_SIZE(chtdc_ti_power_table),
>   	.thermal_table = chtdc_ti_thermal_table,
>   	.thermal_table_count = ARRAY_SIZE(chtdc_ti_thermal_table),
> +	.pmic_i2c_address = 0x5e,
>   };
>   
>   static int chtdc_ti_pmic_opregion_probe(struct platform_device *pdev)
> 

