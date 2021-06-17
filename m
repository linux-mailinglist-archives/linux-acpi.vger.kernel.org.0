Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC0C3ABBD1
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 20:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhFQSbB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 14:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhFQSbB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 14:31:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034D5C061574
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 11:28:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gt18so11548682ejc.11
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1ukYDH8l86ZtCuh9VXyQHQvq9HK7Dq55KqG98CYPGfc=;
        b=pHWIJxR2Y9kiD6+8Ayqkox9rCkjc1uKT1O5h5b8n9NjaAOtSotBeZKY3zijAyFtyoW
         j4AS7/TC9JV3Ktl1TvzSVwU+T+iUaWoUJOvMfGDJRXSsiGfV6Cdbojw2Nfw2xGYGu+EZ
         acD3xg349jsu+6Br2XqnEqVcQZKPL1RxkH02aIeNy7dBW7o37o7+E0aqcMMTcVHZAQHM
         1W/hYFIKC9l1AQ2AXKKRUFjtfzhG4bZvgjIR859jX23jg9nR6viVwuk8yI7xpSOTfCMx
         UOsXnk8i171fGVmg9FNIexKhujtPFaOPZ076w9h8cUBioGwZGFu30usCBdcCtJCtk6uF
         nb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ukYDH8l86ZtCuh9VXyQHQvq9HK7Dq55KqG98CYPGfc=;
        b=k+ALRFQ6+KdDbskWyuCx1q/pt/Pvllf8MVeeZHsdoa487UpDlXCvX6nIX0oVFlFs9k
         xx4UUK/ll+ZXQbuLzuGvhvwmrFBWDq6X5pfZ/1/SREPQAlfrQ+Zu0/o6d219oxbe37/r
         8WZTCnSzwDy9riFITw9Nu8pAtDGrVLT+LHDnidJnYWxkoEYsvpHSO++Sho9zpN2+yjAW
         FUaURB5axgQ9152pT90i+w+ZyBmZdZ8JyQ/cW729sLzcog2L5OqkDz+J84tozwYKrUSo
         Wax+imXI3bMULdkuZ73op3DC+xMu5AaJ+uYaCtOMiRrIC26APFLMJfMUhQhXn/d19cmq
         aZxA==
X-Gm-Message-State: AOAM532Whlh6xjJUAck9oTq/Mhp5CHSwEuJRlh2o/Q35qxoa0m6yXncj
        2blSryb6jP3d+kRpdtZMfbU=
X-Google-Smtp-Source: ABdhPJz6KolF2vgbJUVXqbzSOil/mnaKB5WdwGUzDd67++YdhVXEUT+1VrHtITZmylRVg79nNYcv9w==
X-Received: by 2002:a17:906:b6c5:: with SMTP id ec5mr6705485ejb.290.1623954531626;
        Thu, 17 Jun 2021 11:28:51 -0700 (PDT)
Received: from ?IPv6:2a02:908:1984:a6c0::47cb? ([2a02:908:1984:a6c0::47cb])
        by smtp.gmail.com with ESMTPSA id t8sm4167877eju.14.2021.06.17.11.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 11:28:51 -0700 (PDT)
Subject: Re: [PATCH 5/5] ACPI: PM: Adjust behavior for field problems on AMD
 systems
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     teohhanhui@gmail.com, Shyam-sundar.S-k@amd.com
References: <20210617164212.584-1-mario.limonciello@amd.com>
 <20210617164212.584-5-mario.limonciello@amd.com>
From:   Julian Sikorski <belegdol@gmail.com>
Message-ID: <b10a17ec-9113-1001-4f06-f16601c67e46@gmail.com>
Date:   Thu, 17 Jun 2021 20:28:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617164212.584-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W dniu 17.06.2021 o 18:42, Mario Limonciello pisze:
> Some AMD Systems with uPEP _HID AMD004/AMDI005 have an off by one bug
> in their function mask return.  This means that they will call entrance
> but not exit for matching functions.
> 
> Other AMD systems with this HID should use the Microsoft generic UUID.
> 
> AMD systems with uPEP HID AMDI006 should be using the Microsoft method.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/x86/s2idle.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 3f2a90648ec9..816bf2c34b7a 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -371,12 +371,27 @@ static int lps0_device_attach(struct acpi_device *adev,
>   		return 0;
>   
>   	if (acpi_s2idle_vendor_amd()) {
> +		/* AMD0004, AMDI0005:
> +		 * - Should use rev_id 0x0
> +		 * - function mask > 0x3: Should use AMD method, but has off by one bug
> +		 * - function mask = 0x3: Should use Microsoft method
> +		 * AMDI0006:
> +		 * - should use rev_id 0x0
> +		 * - function mask = 0x3: Should use Microsoft method
> +		 */
> +		const char *hid = acpi_device_hid(adev);
>   		rev_id = 0;
>   		lps0_dsm_func_mask = validate_dsm(adev->handle,
>   					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
>   		lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
>   					ACPI_LPS0_DSM_UUID_MICROSOFT, rev_id,
>   					&lps0_dsm_guid_microsoft);
> +		if (lps0_dsm_func_mask > 0x3 && (!strcmp(hid, "AMD0004") ||
> +						 !strcmp(hid, "AMDI0005"))) {
> +			lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
> +			acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
> +					  ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
> +		}
>   	} else {
>   		rev_id = 1;
>   		lps0_dsm_func_mask = validate_dsm(adev->handle,
> 
Tested-by: Julian Sikorski <belegdol@gmail.com>
