Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033353ABBCF
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 20:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhFQSaw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 14:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhFQSav (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 14:30:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586F1C061574
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 11:28:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hv20so5619155ejc.12
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 11:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kjD/vZGv1MuJEA+n21mlZZT0W20GptgddJdtQQlCe0w=;
        b=eXykBWA9XLJLwNtxg2l8uu5ayNAFlGp0fVCSGyxl3id9WxqtuRucP6Xrd29BAAQxrj
         ZB01D6I7CP3hEIrEuFaTzKYDaNycbBT1IO0JLZjFitdptJRH0AT9akw1vkUlHRbhkXey
         NRhZRbtvX84mY6jR660dF6oilA1AoLGgw2Yq0gWY6IjpqM+0tCzNpq/J+edkp4tlFHU5
         s4KmkcR9SPD1TpGAQPWmRfBoaV6xW00fl2FYLdJ5ia2+8tEYqredvcsWtxxmEOiWfYA9
         wGC3r+ScPmde1Bq5uczwcXeGrTjBGjm/GGrerjvvm5KFhHYU3q3vi/qK9h4YuuVM9tnm
         sokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjD/vZGv1MuJEA+n21mlZZT0W20GptgddJdtQQlCe0w=;
        b=OCZKoxZ8AtQUEeKrnlN0x2ADpoMYwK3mkhemX+beHEP672jNd1uKCEdSSyoTNE89WO
         87K5Y3azL7O6bLu7Q9QX7Rr+fAVRFiLW45Ib5u0pCJzFd88MkjcgptdgA/Qe4b8RJ/y2
         ofRIKNDrKnsIQ1ZT9ZQWEIhTAsFixFkWobucEJpPpb8PFrh2yICUtvuw7ZAl95Zqrznq
         sdGXYOZlawqO/MsnsEoWUXXnZMIa+bSOeZzc58oJuARouAcAPCcWEbuqyM1BaCqETgQ0
         y1m4ZETU65Rw8phKIrYw6LSb6HF+Ro8W/MZCxVknrENvuYry4I0l0adZLj0Is3Ie8I9N
         As4w==
X-Gm-Message-State: AOAM531YaZ6CpsVGR2ZLw+3mmZBzwmxW54N3M9+Vvu60bMQ8YqUHooQo
        0e4DexLwxNQPMr9tJ3SN3ig=
X-Google-Smtp-Source: ABdhPJx6k+p3kMmCrH4xyloseECWSMl8G9B2zOFuLGlgIVFzApc/53vh7yoyjHINvkbYIPHgdyIJkA==
X-Received: by 2002:a17:906:3016:: with SMTP id 22mr6699252ejz.28.1623954520984;
        Thu, 17 Jun 2021 11:28:40 -0700 (PDT)
Received: from ?IPv6:2a02:908:1984:a6c0::47cb? ([2a02:908:1984:a6c0::47cb])
        by smtp.gmail.com with ESMTPSA id r4sm4117797ejd.105.2021.06.17.11.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 11:28:40 -0700 (PDT)
Subject: Re: [PATCH 4/5] ACPI: PM: s2idle: Add support for new Microsoft UUID
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     teohhanhui@gmail.com, Shyam-sundar.S-k@amd.com,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
References: <20210617164212.584-1-mario.limonciello@amd.com>
 <20210617164212.584-4-mario.limonciello@amd.com>
From:   Julian Sikorski <belegdol@gmail.com>
Message-ID: <be247cfb-c3d5-b91a-6db5-d69b7255f4c1@gmail.com>
Date:   Thu, 17 Jun 2021 20:28:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617164212.584-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W dniu 17.06.2021 o 18:42, Mario Limonciello pisze:
> From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> 
> This adds supports for _DSM notifications to the Microsoft UUID
> described by Microsoft documentation for s2idle.
> 
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-firmware-notifications
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   drivers/acpi/x86/s2idle.c | 34 ++++++++++++++++++++++++++++++----
>   1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 0d19669ac7ad..3f2a90648ec9 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -32,6 +32,9 @@ static const struct acpi_device_id lps0_device_ids[] = {
>   	{"", },
>   };
>   
> +/* Microsoft platform agnostic UUID */
> +#define ACPI_LPS0_DSM_UUID_MICROSOFT      "11e00d56-ce64-47ce-837b-1f898f9aa461"
> +
>   #define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
>   
>   #define ACPI_LPS0_GET_DEVICE_CONSTRAINTS	1
> @@ -39,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
>   #define ACPI_LPS0_SCREEN_ON	4
>   #define ACPI_LPS0_ENTRY		5
>   #define ACPI_LPS0_EXIT		6
> +#define ACPI_LPS0_MS_ENTRY      7
> +#define ACPI_LPS0_MS_EXIT       8
>   
>   /* AMD */
>   #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
> @@ -51,6 +56,9 @@ static acpi_handle lps0_device_handle;
>   static guid_t lps0_dsm_guid;
>   static int lps0_dsm_func_mask;
>   
> +static guid_t lps0_dsm_guid_microsoft;
> +static int lps0_dsm_func_mask_microsoft;
> +
>   /* Device constraint entry structure */
>   struct lpi_device_info {
>   	char *name;
> @@ -366,14 +374,18 @@ static int lps0_device_attach(struct acpi_device *adev,
>   		rev_id = 0;
>   		lps0_dsm_func_mask = validate_dsm(adev->handle,
>   					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
> +		lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
> +					ACPI_LPS0_DSM_UUID_MICROSOFT, rev_id,
> +					&lps0_dsm_guid_microsoft);
>   	} else {
>   		rev_id = 1;
>   		lps0_dsm_func_mask = validate_dsm(adev->handle,
>   					ACPI_LPS0_DSM_UUID, rev_id, &lps0_dsm_guid);
> +		lps0_dsm_func_mask_microsoft = -EINVAL;
>   	}
>   
> -	if (lps0_dsm_func_mask < 0)
> -		return 0;//function eval failed
> +	if (lps0_dsm_func_mask < 0 && lps0_dsm_func_mask_microsoft < 0)
> +		return 0; //function evaluation failed
>   
>   	lps0_device_handle = adev->handle;
>   
> @@ -412,7 +424,14 @@ int acpi_s2idle_prepare_late(void)
>   	if (pm_debug_messages_on)
>   		lpi_check_constraints();
>   
> -	if (acpi_s2idle_vendor_amd()) {
> +	if (lps0_dsm_func_mask_microsoft > 0) {
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
> +				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
> +				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
> +				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +	} else if (acpi_s2idle_vendor_amd()) {
>   		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD,
>   				lps0_dsm_func_mask, lps0_dsm_guid);
>   		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
> @@ -432,7 +451,14 @@ void acpi_s2idle_restore_early(void)
>   	if (!lps0_device_handle || sleep_no_lps0)
>   		return;
>   
> -	if (acpi_s2idle_vendor_amd()) {
> +	if (lps0_dsm_func_mask_microsoft > 0) {
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
> +				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
> +				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> +				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +	} else if (acpi_s2idle_vendor_amd()) {
>   		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD,
>   				lps0_dsm_func_mask, lps0_dsm_guid);
>   		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD,
> 
Tested-by: Julian Sikorski <belegdol@gmail.com>
