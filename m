Return-Path: <linux-acpi+bounces-437-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57F47B9CFD
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 14:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id F23C91C20901
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 12:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B43F134C0
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vITy67iq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14EA125CE
	for <linux-acpi@vger.kernel.org>; Thu,  5 Oct 2023 11:20:18 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A781924871
	for <linux-acpi@vger.kernel.org>; Thu,  5 Oct 2023 04:20:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-313e742a787so511038f8f.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Oct 2023 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696504815; x=1697109615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4AE5jS4qjwXCMnOlOFtdJ9RttCSKbWymcLORudPBgc=;
        b=vITy67iqXCawyJRrBYTbANj04Wqd82i9f+X41xRdVLpr9q1nrjp3lsGFiHlsCH4/Mm
         gYaoQefcPxWoF98ga9pncX77lQMPRQgXX5DlFeNEWdkrD7jVEA4VmiAonOKryk1TfyP8
         Xf/ODAA7V8B2gZkU8C/xsfqPlqxWBhEehk7ysxdNpqytvgNkJj5CllMfDprn49pUEKT7
         OlgtR6JFLaxWz3LozZJ5G3+wdPB+at/WpKJKi/DeZqjdgNeEx3aT5HuOoDzmhwmoJ19G
         RrDWYo6ObHQwOXN+QuZunJj8p0F5Nl5JdS7rlbIFcT3WQLYQL6NMEKxcncm3Le4s1NKf
         kqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696504815; x=1697109615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4AE5jS4qjwXCMnOlOFtdJ9RttCSKbWymcLORudPBgc=;
        b=NsQ+l8qVwqWXXjSTrwMZ6cPCKimhioRxp7YwoM/bcK2FFoUK86R6RDTfO0ayT00L8j
         x3NhNAHuwriLHuqdbTitSWqFj3Vxv9MFJ5VDJ0Qrja63G72ZgP0Z5o3kxGwihQhBB3Lh
         8sinJlSzaWmwA4ZFtnheVIPe2l96p0ADAopzXGJXrMGPsoxnTqIg7/Se8w5sgkeav1zh
         FC1rhqodq9z5S9CjVYIFrv0CcmBrNwa5x8fZ9AzQVLmBOiZSLUbTQvjqRG79Kel9mOB/
         V01sng7+qXfyO4Sz/rJhCtJndiTShhK7UydEtH4eW3H9Tb6G0bWxw07g7mBG8JoheYWo
         I86g==
X-Gm-Message-State: AOJu0YzXLS3svaYIuV4pWZ0thyAlxLgtc24L77h7CqHOZ0Oj5B0QSpPw
	wPa+LWajKhZcV9+bZr9uz7pTVw==
X-Google-Smtp-Source: AGHT+IEI36e0d7npO9gHvSq0PCK8REknqrsXlLxeDQM2Vg3iDm3n0GAUq6RQUC7RZu5soOlpwzCm6w==
X-Received: by 2002:a5d:6387:0:b0:323:1688:a70e with SMTP id p7-20020a5d6387000000b003231688a70emr1084141wru.16.1696504815109;
        Thu, 05 Oct 2023 04:20:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8bb6:12b3:863a:e5dd? ([2a05:6e02:1041:c10:8bb6:12b3:863a:e5dd])
        by smtp.googlemail.com with ESMTPSA id t25-20020a1c7719000000b004065daba6casm3539418wmi.46.2023.10.05.04.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 04:20:14 -0700 (PDT)
Message-ID: <d784edb6-9a95-b30c-6f55-a1daccad2f9e@linaro.org>
Date: Thu, 5 Oct 2023 13:20:13 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/6] thermal: int340x: Use thermal_zone_for_each_trip()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <4846448.GXAFRqVoOG@kreacher> <3532950.iIbC2pHGDl@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3532950.iIbC2pHGDl@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 03/10/2023 15:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify int340x_thermal_update_trips() to use thermal_zone_for_each_trip()
> for walking trips instead of using the trips[] table passed to the
> thermal zone registration function.
> 
> For this purpose, store active trip point indices in the priv fieids of
> the corresponding thermal_trip structures.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Mo changes
> 
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


