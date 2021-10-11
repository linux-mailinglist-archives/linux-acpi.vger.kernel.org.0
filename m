Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80C3428E90
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 15:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbhJKNtk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 09:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236323AbhJKNtf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 09:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633960055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYFSzJa4/X5MdTw0ej6ByG8jedB2v1DK+40e1tfjLpY=;
        b=OYregtajtk/2AQ+dy8jOzq5mE5Kfil87sd7MH3WmXi8SfKrGE6qQi1UehgpHaJyYtDwJMD
        1LH2Y0MRNq+fWmoVW3RUOPnyymi0OhUaXIV+z9CHLFosBHCuP6/VhRyQAoN8fL/1DRlGXj
        fif/xoyKuYzC2yjWmpvVadxIRAhmBi8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-gSeFxOEjPG6PyCzkre5ZDA-1; Mon, 11 Oct 2021 09:47:34 -0400
X-MC-Unique: gSeFxOEjPG6PyCzkre5ZDA-1
Received: by mail-ed1-f71.google.com with SMTP id h19-20020aa7de13000000b003db6ad5245bso7340312edv.9
        for <linux-acpi@vger.kernel.org>; Mon, 11 Oct 2021 06:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dYFSzJa4/X5MdTw0ej6ByG8jedB2v1DK+40e1tfjLpY=;
        b=Y2qOpglDcRweEEtgxoTpNTufv/RIyLNmHgUVbb3s9/g/uyOawOI2n5kN+48YnqUMom
         5CE48h9Bq/hXzbFdNYfscRxYuXswUd6/IGaEFUdUKCBKZ0fqDXDIKItfXSY3IXTMT9r2
         i7Was2EABSYOAJm5We9Q8dMvWW0LDJI+SK1LdDeiG8RBwffR+LdQX3LZ8vjC/kJmEEVD
         jui5cxTcU09MQURfHzmCc42SRKoBkNXXn0gfk2LMp5LItriOCl7GW3IKA1+DwxGmyZ0c
         YnMnusEDJie7mc4ZujNCODXeaefGmQAQxkF8SAzO8EajYNY3V6imKW95IfzZvzInMr4C
         DFIQ==
X-Gm-Message-State: AOAM531/o9Kf+fB69IJ9w/LPBYhC7T30ViLFAkjVn8zbOStkVVdwXdUT
        NkA7c+07bswtnjGwYVKDSYN7juXtv7eE3kOmpmywjkOKgRjJVsTa+WiF4obdOFF7x3hW6fUdjhE
        tuc3/1LJcjp+5GWeNooxHRg==
X-Received: by 2002:a50:d944:: with SMTP id u4mr41485550edj.327.1633960052858;
        Mon, 11 Oct 2021 06:47:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl98X8t7epnvmXxk3hpem5zaOR2SPG1wUIZIsGJp9yhGYwckwlRuh6DVHhzZQQoUI0O3pLzw==
X-Received: by 2002:a50:d944:: with SMTP id u4mr41485521edj.327.1633960052710;
        Mon, 11 Oct 2021 06:47:32 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id m15sm4253564edv.45.2021.10.11.06.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 06:47:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] ACPI: PM: Include alternate AMDI0005 id in special
 behaviour
To:     Sachi King <nakato@nakato.io>, Shyam-sundar.S-k@amd.com,
        mgross@linux.intel.com, mario.limonciello@amd.com,
        rafael@kernel.org, lenb@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, stable@vger.kernel.org
References: <20211002041840.2058647-1-nakato@nakato.io>
 <20211002041840.2058647-2-nakato@nakato.io>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <912fedbb-5399-bb4e-555f-9ad48a284a31@redhat.com>
Date:   Mon, 11 Oct 2021 15:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211002041840.2058647-2-nakato@nakato.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/2/21 6:18 AM, Sachi King wrote:
> The Surface Laptop 4 AMD has used the AMD0005 to identify this
> controller instead of using the appropriate ACPI ID AMDI0005.  The
> AMD0005 needs the same special casing as AMDI0005.
> 
> Cc: <stable@vger.kernel.org> # 5.14+
> Signed-off-by: Sachi King <nakato@nakato.io>

Rafael, I assume that you will pick up this one?  Please add the
following tags from other parts of the thread:

Link: https://github.com/linux-surface/acpidumps/tree/master/surface_laptop_4_amd
Link: https://gist.github.com/nakato/2a1a7df1a45fe680d7a08c583e1bf863
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Regards,

Hans



> ---
>  drivers/acpi/x86/s2idle.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index bd92b549fd5a..1c48358b43ba 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -371,7 +371,7 @@ static int lps0_device_attach(struct acpi_device *adev,
>  		return 0;
>  
>  	if (acpi_s2idle_vendor_amd()) {
> -		/* AMD0004, AMDI0005:
> +		/* AMD0004, AMD0005, AMDI0005:
>  		 * - Should use rev_id 0x0
>  		 * - function mask > 0x3: Should use AMD method, but has off by one bug
>  		 * - function mask = 0x3: Should use Microsoft method
> @@ -390,6 +390,7 @@ static int lps0_device_attach(struct acpi_device *adev,
>  					ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
>  					&lps0_dsm_guid_microsoft);
>  		if (lps0_dsm_func_mask > 0x3 && (!strcmp(hid, "AMD0004") ||
> +						 !strcmp(hid, "AMD0005") ||
>  						 !strcmp(hid, "AMDI0005"))) {
>  			lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
>  			acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
> 

