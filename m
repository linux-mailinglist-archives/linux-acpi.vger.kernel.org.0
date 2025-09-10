Return-Path: <linux-acpi+bounces-16585-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E0EB51B2D
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 17:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEBB3A9856
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923DF30F544;
	Wed, 10 Sep 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TAHkeLtu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676528C2CE
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516998; cv=none; b=I7KQ7pW5Q0H8a7QiZLC3lBZoH0h113G4R2qo4eLNYQ8nRiXh0jqjmBYxW9qmVpYZgJkQNUbJN+FIv7AX00CkGBkMnKAYUMtgn8RfSBkw45syglfXcnC3F1gZT7q2sUwZsAjPORXeTJHzFTrcYMLyQE7gsnKzq/wperx9EwzKfnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516998; c=relaxed/simple;
	bh=nnB0i08/2aLtDWQLVR1K4St1ZSbXCZK4wpSnFXfLt3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DU3VuGinMSmFJlfsDqBNnUoyBHNxnZAwJJoFlkvzEX2mgAw1CFMWiN29DxUoyqOGsTGY5bDYXxQTAUZbZvtMVrP3ScKohspGQSSAgQYHv5lzxTQZrkE3L+cWk/OPFfmoL3OqJGGL3zC+nRrcpRg1gcNiDyY91azb9c9UOqf+qBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TAHkeLtu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e537dc30c7so5381772f8f.3
        for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757516995; x=1758121795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=40oSAn91xNyPOWvZAyVrrTXG59NLLE8QyWWIn9bLBM0=;
        b=TAHkeLtuhUxmEPkEheCnenYGgrwcyftgQ9Runton8SdVim0JB4mKt9UBDnpm2MdVsn
         LhtEmjfmsjcMZX+itabTxknzgaPjiddsIJYLTvPl6UN/KURGKvkbQENW0n6IYw/1trP3
         JNYInWsL217QrSSfggYA35d+7h99+S10gGLIgkCHMuQyP18sIlvLTo8Nyn8YTswWSgmR
         C5R0Qd929yFLF24USMmGw0pdANI4EkYnpjWgLj7nDgHonljdpeJWPsq4XEoSiBvIC3dm
         pPp4xpKYA8fUtWmwYqbhXAXvs1ZkBAs3JW6pVjyoywVNdJwEB2a2BkFIC01ZCjQS8ve1
         Tabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757516995; x=1758121795;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40oSAn91xNyPOWvZAyVrrTXG59NLLE8QyWWIn9bLBM0=;
        b=JTvwnzvlNRfZi29/m8A7HcfaWRd14zwAMuc6fzi7/cl6xVcVRrE3VRYWhDTmmtjQ5A
         v4CT3g2/altd6haFm8PUYRNFvGi+VCRtPBQCicFQB4QDAJf4eE3MU3Who3p+BC/ekN4v
         GkrnOY8hmCJCP16iXtUSJavteeLUYvhYC+PhGnC4sODFBxV0WLWOd1FG5c1TL3qrrSJ4
         z38/CmpycuPsBRJt4IGpnu+9+tmFxGlz+Duz+msNzomsYKDP9BNyU34MeumBF7SONx+B
         7YtNDBa8SJFOSfdXquTuBTx/gcvYQ/1sUErf0jn71/BCoh/+1NLU0heo4vEonMd7Lm9U
         8vBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU19wfE/2WzPatwocQHrgNU7OFHPHbcSdpWbIpS+lSU0CEpG7/bDVMkgiwpIAHlRhR3Y+VV8o+LweGI@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ+lrqJTH2JA9JZ/QbM1i2orlV9a0K31WqSW5BexP6Z4NW+FVa
	AMnxFrA+Dvs39qUemw3KkqizKMFdMn1RsFJT5fJuPF5l9OWdKO+UFMo3xw9VGMab24I=
X-Gm-Gg: ASbGnct4oS93/ohOdy0LCRqM3BSw81nkTIbXFz+vG8u2R069Rs++RkGJBLD5Y2sUVac
	y1j3XgfklqGSvSBSfEOWoBXg+z3ctrslMLb1V/8w7HqJx6Wbf+jb0hr52z8t24c5k3fh7w3JFft
	gCzJAljDaiz1dxe36Q4Y5NHhy5DWgCtarboEsMLkw55JEvSMKoAkhbWrfyyGgCIyNxCSVelcbj+
	aJvschdQoWmml/baNl9k86zZURJR6GCaW5haAMosnMTDjQjiIKtDpNpr4k998WW1tEWNVCV4NVp
	AD5C5/vYcd/VuyIpFRxFKeitAeDsVReBEvPfnn+Ik+Bc8DnuduEy0eNwufYoIKZgZxLvTzJB2ar
	B3e55MJ38dvxhAW7QXIFTZSpwg+k0AFwKqTbMBFuly9AGlGV1SzuCBbzi
X-Google-Smtp-Source: AGHT+IHDQqL6LkITSs858nblEdXJH/mpIf3Hn/ijPZZArZrA79uc5rdl7YUfoZeEVFfH35KSrip1IQ==
X-Received: by 2002:adf:eb02:0:b0:3e7:4ede:d8a1 with SMTP id ffacd0b85a97d-3e74eded8c3mr6607816f8f.48.1757516994848;
        Wed, 10 Sep 2025 08:09:54 -0700 (PDT)
Received: from [10.20.0.214] (ivokam.ddns.nbis.net. [109.121.139.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81cbce6sm33818155e9.5.2025.09.10.08.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 08:09:54 -0700 (PDT)
Message-ID: <687845b2-39be-4096-bfd2-ebd27fcbd9ca@suse.com>
Date: Wed, 10 Sep 2025 18:09:51 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/15] x86/mce: Move machine_check_poll() status checks
 to helper functions
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-6-eef5d6c74b9c@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250908-wip-mca-updates-v6-6-eef5d6c74b9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8.09.25 г. 18:40 ч., Yazen Ghannam wrote:
> There are a number of generic and vendor-specific status checks in
> machine_check_poll(). These are used to determine if an error should be
> skipped.
> 
> Move these into helper functions. Future vendor-specific checks will be
> added to the helpers.
> 
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

