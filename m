Return-Path: <linux-acpi+bounces-16572-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C9FB5160F
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 13:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C5118997AD
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8892853F1;
	Wed, 10 Sep 2025 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bjc9Jpz0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AE427E7EB
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504841; cv=none; b=e+PInMR35bywvR+FEQao4VBGagbRw5DZ9QxLkx13ZyY9dn/zPgEmQ3G8CRBIa+SCnapoAqzn+55YJlDT/IdJ+smPOxOXb0dWJHy58yeGcQfoF+V27kjYbyng3Qx1MBY4/NmD5FNmQ1bfCpj0c798HaCXBML8veQHlrOwPu4Vxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504841; c=relaxed/simple;
	bh=lbVleNB36fG112XJp199lcPL6rD2vaZRqT8hFjobxP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGKIvvK2OzwVuOWb+pxDPz+uEgfrgoV3rDlwFyjh7Ae/U7sxrjnUBuM+W3O1YtwXjt+cPImh4dD9BpJsrhbJoI9vmshvFQC/R65bY3WQI5k0ySrLUcnkJ/UB+UDtCldnGIfjGB4xOs0yvI6nrKByQuh/MaD6I9V+oFMnrJnOUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bjc9Jpz0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so3816174f8f.2
        for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 04:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757504838; x=1758109638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4b8l9UODp/FeCRZCFvzP4dsffoCBp+wjbwx4BoMSIwg=;
        b=bjc9Jpz0wsqoK1Q/e7o0LX2Zg06F2GnUSUuhk+iOYeh+a+N2xsZ4zALT+klTsofDM5
         PivKeCDnbQbVPHZwTBDJq3YwET226q86w4rhHNlzXl+PyC7pB1xAvV1IJBSw8I6GEzAp
         DyU6J9VBdUZOtyWyReKFoyvCGGlwecOlTyc6Tfhi9/zs4RAxYoc9bd6jEwdJo8X04mjk
         soFKpxUYL8HiyZ05ObwARaNvv7gBvzVDeHG5aJh9wPcWMUce8WAvaL/07XIhiqzZDcjF
         h7lfltqaq/frL+Xlivl9YN7dpbHcTxyU7niLhI5h28Vz/B9rdvj0ASLNWXasbnhgXFSf
         0hJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757504838; x=1758109638;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4b8l9UODp/FeCRZCFvzP4dsffoCBp+wjbwx4BoMSIwg=;
        b=cbtnsavDQTncmzIYL8dlvi2+Gt0f3dndiSOsjoTuSLVfaLyTRcguXj/kIi6kP6aTMJ
         Kx+pHh7eBdns4PvcPgjjkHGRDj3UZXQFozvG67lKqCBHZmqX6XzzW7tgC/9cegB2wTmR
         ofOUKv2XjUmD1G9WQntMfHNBDs1McrsSvMLAgyowLjsTbsu3dN8vj4evxuxey9o/Z1oq
         59RQe7DqvCXV2aEqJPpb0cTFHuPWZJ0vPjGS1KeQq7KWjxz6bsKr3cjqeJJ5Y9qqIC5J
         FUdd1jsiUsYAN/AIoTxrOu7xDQ8ylNGlntYVYD/MRz9Dtaw9QWwH3ZtHNukYBHTe3QGP
         XgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHXZBjRnONI+PCBUvUSKWhzcUBkiuFGaDP03+/6IdiqHIZfiKrLeX4oRyGj9XMisAlqA3c1v9wKI0n@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUtzhlkXJXOe7FGjRWUU2Gk1BG4+16gHcA1EDzosa/Hr7+soF
	g5nhbygZNt4SzO8YLpeNWD4mFCrbXGGDWm9Pm4JqdCtAOCmQJJMZKG7/QGZknCJWccw=
X-Gm-Gg: ASbGnctLypytrTN7HACF54YK4YfGJxJIsIHeQdn1ig+ke4zYITENR5tXG01bNN5d3k5
	+3DJxXlupbIqbPG59hAUkrEyaqxuGTbzkZKMpKQWjK6jHyxRH1Tmcedq7Vjt6CqRUZ+X/10SYCa
	CiosBbgslR9tRMQY8CBuNVOLCKSxvPfEHQ8L8EWiHi38NYig1/wrY1SifP0azBZjSPL/8ThW14r
	p3DJdaL0Ld+ThxpLuGKZ/BvO1z7PltusIS7FMk0rYmq9IO48LddPvEO3w1B68XlUCj+QYJW8pL6
	QWKLRaWq9PJfqGKUCYLlvlxSTeSN68QwWUDVMixFys8SYU59A5HRP5EIUlDxvcGhjAd8nH9go1j
	oG/AWGo6UBAp4vq+5AYuuujceu5R+ig281zNt
X-Google-Smtp-Source: AGHT+IHzDMf/jaVov1RUOe73ZJkbRYR7qCbsg0/lCE8ZJG90MzF2ZKZezbrOeFUqcZDoFKM+jB3U0w==
X-Received: by 2002:a05:6000:25c8:b0:3e2:6d96:b4b4 with SMTP id ffacd0b85a97d-3e643555864mr10937053f8f.41.1757504838050;
        Wed, 10 Sep 2025 04:47:18 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238832sm6381943f8f.31.2025.09.10.04.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:47:17 -0700 (PDT)
Message-ID: <98d80660-7140-43a2-b17c-07a0884996f8@suse.com>
Date: Wed, 10 Sep 2025 14:47:16 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/15] x86/mce: Define BSP-only init
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-2-eef5d6c74b9c@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250908-wip-mca-updates-v6-2-eef5d6c74b9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/25 18:40, Yazen Ghannam wrote:
> Currently, MCA initialization is executed identically on each CPU as
> they are brought online. However, a number of MCA initialization tasks
> only need to be done once.
> 
> Define a function to collect all 'global' init tasks and call this from
> the BSP only. Start with CPU features.
> 
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

<snip>

> @@ -2240,6 +2233,27 @@ DEFINE_IDTENTRY_RAW(exc_machine_check)
>   }
>   #endif
>   
> +void mca_bsp_init(struct cpuinfo_x86 *c)
> +{
> +	u64 cap;
> +
> +	if (!mce_available(c))
> +		return;
> +
> +	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
> +	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
> +	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
> +
> +	rdmsrq(MSR_IA32_MCG_CAP, cap);
> +
> +	/* Use accurate RIP reporting if available. */
> +	if ((cap & MCG_EXT_P) && MCG_EXT_CNT(cap) >= 9)
> +		mca_cfg.rip_msr = MSR_IA32_MCG_EIP;
> +
> +	if (cap & MCG_SER_P)
> +		mca_cfg.ser = 1;
> +}
> +


LGTM

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

nit: One question though for those CPUs which consist of P+E cores, is 
it mandated that both types of cores will have identical MCE 
architecture, I assume the x86 world will be a lot more unified than 
Arm's big.LITTLE ?

>   /*
>    * Called for each booted CPU to set up machine checks.
>    * Must be called with preempt off:
> 


