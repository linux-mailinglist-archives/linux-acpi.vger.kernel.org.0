Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E813ABBCC
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 20:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhFQSac (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 14:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhFQSab (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 14:30:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603BEC061574
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 11:28:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g8so11659083ejx.1
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 11:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mEjjmEcYCeuAngVHFOxlLmyM2M9CsU8xfLqH/UGJgF4=;
        b=qf69oz+OoGa+WZLcVf1MVB4p/1vScH1e2Po2rvjMp918v5Ngew7u1OWXgoLPyjuMAO
         JfNhIpiq/FgRbHmzVJd5vRtWWGrPowlvleBhaibaq+7nbbwlV9LV0lxtmkwmNAh1Q2U3
         8v3plwF51Q9s5vqSEWOa+RYpTxW9wU8zTyLubiD1ujU7TEppLe1goRWjTRPe72SQ9JFl
         i+H10CdzeUFQYJ6cj9iEMJpomuBbIPsX9Eb2RIKKowXyXYelofH4sKjSpbaTsX7MOOyY
         8AgMmOVsKOrE7RcOZKwH1gy5yGi2vOtyA5Q1LtCHGW0ya+r1RjrG2kGEu2JBXuqIE+aI
         XkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mEjjmEcYCeuAngVHFOxlLmyM2M9CsU8xfLqH/UGJgF4=;
        b=sb0A962DRq7r5J1qoKGb8rxREuSh7TpEj4rroPx8MdKE1o8IXDESeEjzS2B41bq0JM
         HhfNv7P8xjaoYqzBylh2bKz2tYelxo5p5RKFLCHdr9PXEJbyYh+qE6SjBIKemyXwgq1y
         17CyLwgWwyADdW/ljBTb5GlRIx3NEjoBsGTwZm22V+7thzpzGD0ctpCITFv4VCnrHcxB
         /O4VXsTKejr12msYLQ+KWvwSbXZn0p3neSvW6cSu6E/psMh9tR53oLCYEXR4mPM+HS/Y
         60H8HLyolbw+232tQmOQJaBFnLuUN4+J7j+chWa6m6mWtQnUniOVrpx5iPjDs0NaLRnv
         SYkw==
X-Gm-Message-State: AOAM532WtEJ0nhyAqPP0wygjaWJ5yyULMo5rU/Dmp+6zUqTi3dvvrmG6
        bNcv5fICXf2CYs5kBxOhaMY=
X-Google-Smtp-Source: ABdhPJxuVgoGitlrFKbuXnZYxt7TodzM2+MP0JuDu5xF/53QOJToZqAipATA1o4v/FjZ+/PWAKNLQw==
X-Received: by 2002:aa7:c790:: with SMTP id n16mr8522055eds.98.1623954501035;
        Thu, 17 Jun 2021 11:28:21 -0700 (PDT)
Received: from ?IPv6:2a02:908:1984:a6c0::47cb? ([2a02:908:1984:a6c0::47cb])
        by smtp.gmail.com with ESMTPSA id o21sm4090487ejh.57.2021.06.17.11.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 11:28:20 -0700 (PDT)
Subject: Re: [PATCH 1/5] ACPI: PM: s2idle: Use correct revision id
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     teohhanhui@gmail.com, Shyam-sundar.S-k@amd.com,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
References: <20210617164212.584-1-mario.limonciello@amd.com>
From:   Julian Sikorski <belegdol@gmail.com>
Message-ID: <f50c6baf-a780-7a58-4083-88d53934290b@gmail.com>
Date:   Thu, 17 Jun 2021 20:28:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617164212.584-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W dniu 17.06.2021 o 18:42, Mario Limonciello pisze:
> From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> 
> AMD spec mentions only revision 0. With this change,
> device constraint list is populated properly.
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   drivers/acpi/x86/s2idle.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2d7ddb8a8cb6..da27c1c45c9f 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -96,7 +96,7 @@ static void lpi_device_get_constraints_amd(void)
>   	int i, j, k;
>   
>   	out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
> -					  1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
> +					  rev_id, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
>   					  NULL, ACPI_TYPE_PACKAGE);
>   
>   	if (!out_obj)
> 
No regressions against [1] on my ASUS UM425IA. Suspend and resume still 
work, provided other relevant patches are applied. I am testing on 
Fedora 5.12 kernel [2].

Tested-by: Julian Sikorski <belegdol@gmail.com>

[1] 
https://patchwork.kernel.org/project/linux-acpi/patch/20210317143842.786380-2-alexander.deucher@amd.com/
[2] 
https://gitlab.com/belegdol/kernel-ark/-/commits/fedora-5.12-s0ix-8-upstream-newnvme
