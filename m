Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD5952474D
	for <lists+linux-acpi@lfdr.de>; Thu, 12 May 2022 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351150AbiELHrZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 May 2022 03:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351164AbiELHrX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 May 2022 03:47:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F7B1B54B0
        for <linux-acpi@vger.kernel.org>; Thu, 12 May 2022 00:47:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d17so4178068plg.0
        for <linux-acpi@vger.kernel.org>; Thu, 12 May 2022 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vwkfMqkkpGs1FVotSl8gOPBh3VAjsH5HCd0W5khKpM0=;
        b=QwOMO2oq5TbAyOFDFvpvkgkWVG6EaFOmZlzyuwsRB7Flg+Ox5gGrxGlgd257ueDece
         fAIvn+7oEvIbuelneZQjTzbxL+CSaBt4skadbYywXlDR4ZoqdF4Jo5aIouhWpRx2qpsl
         bpaVmdL7fcragnIuna4eczG35NFsj5Fgjn6TXwwsJ+P6s/WXLxqPiSVc5kHe1LyILLw1
         5Kuc9nX8N/8UVRcAjKl9ry49jeTRNn8+5BE/tPtuTlGEQ5h3osSjs+0ywkuWTx/M2HQY
         ZZmO8ghKDlLqpecBME9A6nLni9x7hRLyp8im5ldlY/plFQEKIeDSSiEOVFZNZD3X6A0N
         Z3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vwkfMqkkpGs1FVotSl8gOPBh3VAjsH5HCd0W5khKpM0=;
        b=MsJN5EO/Nqfs3kTP6u/KjZE2BE0njPzZ0rhPSe1ficgkIyRfofs+0VSf3OeDYOALJq
         kYqZJQlkoYQ5n5LLgMrThJ59wD4hy1PZnoHhh7hUpsD6j6YkXHXglToiz7WFoNlhasUh
         CZkWeaqgakr0IZtlsbgDmgKOcxs4i1lu/KGgcwcgGakJXJN+xU2eDRBy0PhXQb8VSTZ6
         wn/iP3BfABiUusS3fds7jrVUg+K1uTA7gVxOLhELawLk2Tb97otJNiP3haBOu2aih/mc
         O8BqMK+FCdiLphasuvC3tgd0OeVNNP4zyh3NZVp6uNQxhge9rT6qyNz51YjUOyPPh9iO
         iOBg==
X-Gm-Message-State: AOAM533081N+dC9vPiBzWnKs2HiY1D7KoOJb3NgwhGDHA9FEnqEwgCAH
        6GT4S33ZBvNCdfEgKlXTPbbYvg==
X-Google-Smtp-Source: ABdhPJx0gFtg0LRz6XpvrQ6zmby9LlayUCFmF87pWSFCFPlW3HOI/+gcMgEygACnvoeQR4T/ohb3ug==
X-Received: by 2002:a17:902:f78d:b0:14d:522e:deb3 with SMTP id q13-20020a170902f78d00b0014d522edeb3mr29111982pln.173.1652341635112;
        Thu, 12 May 2022 00:47:15 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id z12-20020a170902708c00b0015e8d4eb1desm3180431plk.40.2022.05.12.00.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:47:14 -0700 (PDT)
Date:   Thu, 12 May 2022 13:17:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH v1 5/5] cpufreq: CPPC: Enable dvfs_possible_from_any_cpu
Message-ID: <20220512074712.oaf7qaqeds5hlg63@vireshk-i7>
References: <20220511134559.1466925-1-pierre.gondois@arm.com>
 <20220511134559.1466925-5-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511134559.1466925-5-pierre.gondois@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11-05-22, 15:45, Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> The communication mean of the _CPC desired performance can be
> PCC, System Memory, System IO, or Functional Fixed Hardware (FFH).
> 
> PCC, SystemMemory and SystemIo address spaces are available from any
> CPU. Thus, dvfs_possible_from_any_cpu should be enabled in such case.
> For FFH, let the FFH implementation do smp_call_function_*() calls.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 000a0c610c30..ad1535fbf389 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -558,6 +558,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	}
>  
>  	policy->fast_switch_possible = cppc_allow_fast_switch();
> +	policy->dvfs_possible_from_any_cpu = true;
>  
>  	/*
>  	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
