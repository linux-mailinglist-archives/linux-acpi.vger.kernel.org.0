Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BCB585034
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Jul 2022 14:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiG2M7s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Jul 2022 08:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiG2M7s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jul 2022 08:59:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1534F189
        for <linux-acpi@vger.kernel.org>; Fri, 29 Jul 2022 05:59:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r83-20020a1c4456000000b003a3a22178beso616834wma.3
        for <linux-acpi@vger.kernel.org>; Fri, 29 Jul 2022 05:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BPQu7v8xoXDDpbuUwa+XWd+LXfd8VKDhv/Iz9DiRG4k=;
        b=NmpYWSxofVHCk3PiRDTpZtHuk69UpuMSqa97NuKEGMiNW0msXuHnOHoGWRo2oM3i9n
         4BtM/LfhqUsrE46A+BFMTNDVbUU9SpYoFTkmiO1c877fvz7MeeXDBwTchaTj819BVToY
         tlaGXPX3z2OWMDirjXIQ1JnCYbvIvyroDU6hZ3L8eDv0dHZMyni+RFzjWwsWSsJACFXe
         p/UbmHorDpE8Wj8vmNa+FlKDJvVJB6FJldcccKyVHHs4t/Sj2cRUogVGxMs0nURaA/sC
         6xw/P8oBSyfDsm0OLJqmxg5e5WMPeanv58kUNI1sY3ui3i8ZB/dubtA+wbnDD4Kap+Vu
         bv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=BPQu7v8xoXDDpbuUwa+XWd+LXfd8VKDhv/Iz9DiRG4k=;
        b=gKakOsjGEI0OgiNQsF+vdTCUF1yeYYgDApUshsk4rwOB6Qpjs3Ou1Oyo8r25yIJwWY
         PNtfKUz8CYYJTS9AQlkaC3aZSheEt+qtM6o/SFxUF9GVW67xQ6osGJe4TD2htVsyR8So
         KDZkeIUz9FL8dfUtUGhRjcZ8AWS4jmZ2x0/HY8e79vHfN47lT2guR5i1QIzecWZkO53U
         v3v9ClOZ9nYuvskNe3SYzv5zg0letHJkAKeuMpwFASBaV1tcc96pABNGdtmbL0vbcwc2
         56egdTnuvLO2/dQhGiOv5DJ1WvB85d2BH/Dp5IotmqW8FfhqRbLXY3aZsT3ZtbCDCKxj
         2MdQ==
X-Gm-Message-State: AJIora/EeTLpc4eGNtcF6LrK+b/vw6/ETvb5Ni3iYezCVIQB+YTZ2JF4
        92UoZ9lZC47j0XQfExwM3niuew==
X-Google-Smtp-Source: AGRyM1s/Fpy8y+cQTIPRLYx9xAoAOm7WrZLHT4H415U3iwoNYleLhnWQMJIMkBiLGQt1LRcsf60GeA==
X-Received: by 2002:a05:600c:3556:b0:3a3:2a9c:f26 with SMTP id i22-20020a05600c355600b003a32a9c0f26mr2787057wmq.58.1659099584981;
        Fri, 29 Jul 2022 05:59:44 -0700 (PDT)
Received: from localhost ([109.180.234.208])
        by smtp.gmail.com with ESMTPSA id m6-20020a056000180600b0021edb2d07bbsm3619274wrh.33.2022.07.29.05.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:59:44 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        viresh.kumar@linaro.org, robert.moore@intel.com, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] ACPI: CPPC: Disable FIE if registers in PCC regions
References: <20220728221043.4161903-1-jeremy.linton@arm.com>
        <20220728221043.4161903-2-jeremy.linton@arm.com>
Date:   Fri, 29 Jul 2022 13:59:43 +0100
In-Reply-To: <20220728221043.4161903-2-jeremy.linton@arm.com> (Jeremy Linton's
        message of "Thu, 28 Jul 2022 17:10:43 -0500")
Message-ID: <871qu4krb4.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jeremy,

One comment / query below.

Jeremy Linton <jeremy.linton@arm.com> writes:

> PCC regions utilize a mailbox to set/retrieve register values used by
> the CPPC code. This is fine as long as the operations are
> infrequent. With the FIE code enabled though the overhead can range
> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
> based machines.
>
> So, before enabling FIE assure none of the registers used by
> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
> enable a module parameter which can also disable it at boot or module
> reload.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++----
>  include/acpi/cppc_acpi.h       |  5 +++++
>  3 files changed, 61 insertions(+), 4 deletions(-)
>

[...]

> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 24eaf0ec344d..ed607e27d6bb 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c

[...]

> @@ -229,7 +233,12 @@ static void __init cppc_freq_invariance_init(void)
>  	};
>  	int ret;
>  
> -	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +	if (cppc_perf_ctrs_in_pcc()) {
> +		pr_debug("FIE not enabled on systems with registers in PCC\n");

The message should probably be promoted to a pr_info() and exposed as
part of the kernel logs. It is a change in the default behaviour we've
had until now. The message will provide some hint about why it was
disabled.

Thoughts?

[...]

