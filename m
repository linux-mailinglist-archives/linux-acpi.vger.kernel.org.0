Return-Path: <linux-acpi+bounces-21-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61F87A9C2E
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 21:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62245282908
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 19:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788BE1BD3A
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 18:42:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B8718B16
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 17:10:48 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A024207
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 10:10:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-321530de76eso1125597f8f.0
        for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316228; x=1695921028; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b/lesyyYEsnt9FdfxR9CoxFmQAH4gicQBv/bIfqhS7o=;
        b=wb43W1KM6k5XhAXgeaYTbwrLq1CrEylF88fN3VpuVFL4q9/Hoz7hxRT3pW8BW+eCUj
         fsQNtmN+ex3noa8EU3Hq5QZGxpEziSvlINU2oSm4hTefYQIBysiwReroTtZXsSlDuBXS
         TRe3afX17VN0T50dVK2LsJD4qAAJI3EpiRLLnX7V3XHx1suqalEmdZ9R2pUJzcZxwqa0
         IeKwZ1ZfUiFcPbMn3BeWmOgFGsR3O/k82M8FdVsiygaRKrEW3MNc4aE8IIcwp/NPWEHx
         AnfL3EkDABkcA2w5Sn97+x/twhzoBi3NTN5JCKTPWHJF/kNqIP4lfJUPWSDyp+yLL/Cj
         cC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316228; x=1695921028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/lesyyYEsnt9FdfxR9CoxFmQAH4gicQBv/bIfqhS7o=;
        b=X3NLbakZLfku+9QxxkysXnlzotwqFxMxwZW8ftCE2BXeABvsdN/b4lhWIi8urUA7Ve
         5F93NCV5mAnkxGa3R33ZWe2NNbZq65aGXwlkXxdk8ggyvUaSEH5BMX2ssfYxCASecudB
         tJR+YlV9rTmeQ2CaD4SdFhgXfQrvBW2FJrG407JngAXEM751KBdbu9zLjxP+upvmP3BB
         CiwrmBp7yxxKQ6PMq3SlDs9YNnJOwYSzrLJSsHgfNY9r2UkPfcSWzMXbcuZEfYN1TpLD
         yaJevljmSPhM+pwDW8GAhNqUnA4ITxq9EiCUyQMH4UjtHBnel0vX0m+RKo4Xu4hITCw5
         i3Pw==
X-Gm-Message-State: AOJu0YzejAEe2ALx3Q4EBjXeV7uV+s3cMGPeV9fg4jAI7HqmwwkroYS7
	zRrEnZOVMV9Tibj5LhgLgJ0/K+ajSeHsXNbPLaSQGg==
X-Google-Smtp-Source: AGHT+IGJfbg273QOiGyWJV30e+vCp/gVKXDpLIBgIJKJV1ZLq7zoYeLh1EwUM6sczbGm0RhUCMN7/g==
X-Received: by 2002:a05:6402:64c:b0:523:100b:462b with SMTP id u12-20020a056402064c00b00523100b462bmr4294427edx.5.1695281801541;
        Thu, 21 Sep 2023 00:36:41 -0700 (PDT)
Received: from linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x13-20020aa7d38d000000b0052fe12a864esm440591edq.57.2023.09.21.00.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:36:40 -0700 (PDT)
Date: Thu, 21 Sep 2023 09:36:37 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 9/9] ACPI: thermal: Drop valid flag from struct
 acpi_thermal_trip
Message-ID: <20230921073637.GA3346@linaro.org>
References: <5708760.DvuYhMxLoT@kreacher>
 <9162925.CDJkKcVGEf@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9162925.CDJkKcVGEf@kreacher>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 12, 2023 at 08:47:23PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the valid flag in struct acpi_thermal_trip is in fact
> redundant, because the temperature field of invalid trips is always
> equal to THERMAL_TEMP_INVALID, so drop it from there and adjust the
> code accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

