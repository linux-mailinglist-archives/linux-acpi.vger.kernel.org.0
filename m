Return-Path: <linux-acpi+bounces-6261-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4898FFEB6
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 11:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6C7B217E6
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9F215B966;
	Fri,  7 Jun 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Icz7oD97"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48E115B541
	for <linux-acpi@vger.kernel.org>; Fri,  7 Jun 2024 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751161; cv=none; b=qDbPtEStKppXyDvxXOwEYvZcjJTllzoC8/+zLR00PkYHRy868XjdYFSVP+zDZcvemM3raYDIfPOXPDgzSKle63tqxarhttwm39w6XnUzTClq1iIDom3i2CMjZgkgU7Ttwjk9c3htwzddPozI4sFThC+6dhsjurj69cN905CSrBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751161; c=relaxed/simple;
	bh=TTK1GYtFtsVo48+qOHmmrbUdupYD8dUd916fpZW2CU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyTuy7qRVLqnVqaXyoU5031/ME9JYnUSiw9U/qfqfzS+Naq8F75SoFQlMP9XsjcggU+FTEqp86sAzx5FxqhE5NJr4k+Br56veFnZcgELXyDKxVwhAwtiXxUG0dib5gL76OGGiOzEXnY3ZKUsIYESHTWOpAsL7WHi3IS4gv8gzao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Icz7oD97; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717751158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGYDizRf/2C0sa0+xp/HL0cUgtFnHVaSqzQ3tVH7lxg=;
	b=Icz7oD97R0bNENKMbn/YzpvNUeyn+0vuBmEoXZrJmRXRlw/MrTUh8xGblMcPQDvLKR/fUM
	uv5F4zbq6122VYa/TCsGLFFHMK/vKsRjKnDhfa+QqrvyAquoMTwZOPzoF2Xl2BOp1KUdxU
	6DnotyZCASqQslIbcJJJmlxglWBzU1c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-8_wr8BIMOWKljtTAR2i7Sw-1; Fri, 07 Jun 2024 05:05:54 -0400
X-MC-Unique: 8_wr8BIMOWKljtTAR2i7Sw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6917eb045bso76335266b.3
        for <linux-acpi@vger.kernel.org>; Fri, 07 Jun 2024 02:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751153; x=1718355953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGYDizRf/2C0sa0+xp/HL0cUgtFnHVaSqzQ3tVH7lxg=;
        b=SP040xrH2t8+eKnnIaPxCItk3fsaYjf26teCZY7TDSFMkSN2aJlKRJAowYpCC6r5Jh
         wgV8mIqqXdpKRoYNsHBwjlSnykopOEQStkiSY4IJMY/hDtn6ZDGhmD2QpY4r/B0UX9N8
         ZI5Zz/Pa0shZ4hhaofROtivdSIu+QG30LBauPpm6319/gjx99KsEfk/+5xwbNR6srsY/
         HaFn3njQzZxN7i6yiPJTCEXBxBzTn1fzje7sDsd26FyMFJ/giTuWNFPw+uOI5zoRPGKM
         XatTctFgNPDlX4PoCIRPJJeBs5feuj1hQQydPAiZeoLybVkO4RCo8orBRjc0wJ2rxtxd
         MlMA==
X-Forwarded-Encrypted: i=1; AJvYcCXfLbhnZpSj3RM7CyoIgqq1mawWAKlm11nOFOvLkVE5zwSWHEvXaNKluTFR/ecs4XRn+Hbby134LlVYOC4vy3elt2QtzFwLFnD+Iw==
X-Gm-Message-State: AOJu0Yw+4Ik9rBY/FSy1SX7NyhW337PJsgKNB+GFUPAOgr4UoTkUsTUu
	kVjompHNx6odLU8CnVKV5cQSIorjT9JzhXb/19e2rwLE5lHfg51Q+oRajES7ETq7lCby/sbfV+J
	s8Ymx7gzsdIBsFr/DfYvCLTb65xN0wQHZERFonXy47M6teiRgjEeHkdEA1So=
X-Received: by 2002:a17:906:e1b:b0:a6d:e0dd:f7 with SMTP id a640c23a62f3a-a6de0dd0399mr70566366b.52.1717751153238;
        Fri, 07 Jun 2024 02:05:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDIn9rSgHARHfYV/cxRs9YgwJvZSg1qSEkxYVv4VWP1Sp5NzmUd4BO6G+TOihp5MZeIbXWww==
X-Received: by 2002:a17:906:e1b:b0:a6d:e0dd:f7 with SMTP id a640c23a62f3a-a6de0dd0399mr70564966b.52.1717751152868;
        Fri, 07 Jun 2024 02:05:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581746sm217030166b.21.2024.06.07.02.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 02:05:52 -0700 (PDT)
Message-ID: <179d5111-5cc8-4a17-b735-84f02e0144f5@redhat.com>
Date: Fri, 7 Jun 2024 11:05:51 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] ACPI: PMIC: a small refactoring
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Andy Shevchenko <andy@kernel.org>
References: <20240606205712.3187675-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240606205712.3187675-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/6/24 10:54 PM, Andy Shevchenko wrote:
> Use sizeof(), dev_err()/dev_warn(), and regmap bulk read
> where it makes sense.
> 
> In v4:
> - dropped controversial changes (Hans)

Thanks, the whole series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans




> 
> Andy Shevchenko (3):
>   ACPI: PMIC: Use sizeof() instead of hard coded value
>   ACPI: PMIC: Convert pr_*() to dev_*() printing macros
>   ACPI: PMIC: Replace open coded be16_to_cpu()
> 
>  drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 13 ++++++++-----
>  drivers/acpi/pmic/intel_pmic_chtwc.c    |  5 +++--
>  drivers/acpi/pmic/intel_pmic_xpower.c   |  7 ++++---
>  3 files changed, 15 insertions(+), 10 deletions(-)
> 


