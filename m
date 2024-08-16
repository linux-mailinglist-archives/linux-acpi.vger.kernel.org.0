Return-Path: <linux-acpi+bounces-7632-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E393E9550BA
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 20:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205EA1C20B42
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D21C233D;
	Fri, 16 Aug 2024 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXjI6/u/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FC2F43;
	Fri, 16 Aug 2024 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832598; cv=none; b=jUXJvs8Nna+QdBoNcPDv63nJUh4BSqWGW4pEswlTZaZkopNgW04oQFWmxpNwREfJVIWtt2D+qIggKp+/yBzQR885w8FgSZSN8cm7VZh+YYcpLRsT0CvGbf25XUyf6BCVRsW5ziwwEiPEH1Z3RYPDuOP+/RRQHBnoW/REk7QfAw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832598; c=relaxed/simple;
	bh=9nBk+OVqT2U6ithIdAtJd6yyta5mV3miRfL5OUOo/Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p02zA/QGYjgc4MgCL24CUCERnKL/Hi7MKE7MUZscnXT104Soo69ys1PoNmuyyfMPAYk5oehH0DTLdFRlg2FWjChvXDhyZNw+qIJUrZTtkes8Fnug6BTvADPHxldNwlj+2OeDdhwHjg0C0sITf0B+x7sL5eQvpQpXUS5wP0greK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXjI6/u/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428243f928cso16554225e9.3;
        Fri, 16 Aug 2024 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723832595; x=1724437395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tt1M3N9em0+Z01XyYhLmbINqjYflUEk+VUJQL5UpS3Q=;
        b=BXjI6/u/B0bv1FsM1LeJkdIypUl8J1D7nm3Yt9p8PwASQ4TJQQSe6lv9E6zhfcvVcS
         ISR0QkxuU4Ce0R4WYwobdZp2RIKjxxXXTsjLFZ9ZErGZuChKW0p7fB04Orb2zy41YgaO
         YEXtNc6Cy+4vUWv33XEPUgwDSU0nEVnT8SoJ3ffO1Aq741WFAYXPlQO7bbcjJeqi105Q
         nX+BpCCDPACMdU/BjifTS5kBRQJBb9zfYkGsnlNOnV0q8n/MdmOCcPuOmNS76JReMvlI
         byKVik5y7Z+yWrFqYGL3jglGBGJZYO+My6anfUgwOUPG81D3DLhNHuzC8wgedPLMVOVv
         6sqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723832595; x=1724437395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tt1M3N9em0+Z01XyYhLmbINqjYflUEk+VUJQL5UpS3Q=;
        b=ksKvWRz2esc5ivfXMcXX9s4JrDpbOE3TN6NjpVLV46lef1YEOS7bc+a7/2M03kU6t2
         T8baLvvAZzjnwOpKP/K5SafYoHXTwwjxsmzclH4cEyssXzipFEzkAnR41IxMgcjqb4fJ
         3+US6/Tm+y0nXpAVX+pwVo3yM57fC9AcJsoc75N+XYgN7gLc/qQpsHOzAwaFI2MUJOoA
         J6Y7YZs5nv8x3S9NYBRmoS1k4spwFmhryY1I9S3vwf0QSVQicA5rOO04Zu0/ooD2V8vV
         RNI1XzXind0soats61fU1bwrq0k4l0YZxRhCm67X9a8b0BbOe+pbHXbcKZvaLd1uIxPB
         KxJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0yQdrAJ5pfi3P4Xy7l+wM8EFKBaJcdtAgcd/JPOCGZyge8swI2e7CV/klvrST+TIv9VHNpwVN9kfOuTEpb77s7WtQSG4D/mR2y/NWB6YDG17tFJDCaWFU/ZNHcg8puFVW7h+8kWQ4l8qvIJqJeO52/uJnLvwxxu/OfXbhCk37NQF0sYzbK+W0hlH0KN0zAHIsHg/57JCSPbC4mIyXHY/xCRWqsy27tocg4v24A0BAQkLlvl89HCYvH+cMTkiW0ujQsYGd/iSw
X-Gm-Message-State: AOJu0YzToEltElSQjxUsh+r4rZTly1PpfGfeh/Bog4yH2HkKAOQorEk8
	i4fIVuKpL7AurwMDt+6THSASnTNvZ8GbesGwCFbW6a0T5j1FtcsC
X-Google-Smtp-Source: AGHT+IGe7kGpO1ikYBDLyoCv4FPzIfHwsornnyTjsVTL0wNifZExOmpdSgtf+WuYd8hTh3t/puS2HA==
X-Received: by 2002:a05:600c:5029:b0:426:59fc:cdec with SMTP id 5b1f17b1804b1-429ed7af8f1mr28923365e9.21.1723832595196;
        Fri, 16 Aug 2024 11:23:15 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm82383415e9.21.2024.08.16.11.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 11:23:14 -0700 (PDT)
Message-ID: <03af1025-f946-4eb2-a41e-28f0436e60e6@gmail.com>
Date: Fri, 16 Aug 2024 20:23:12 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] platform/surface: Add OF support
To: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
 <20240814-topic-sam-v3-3-a84588aad233@quicinc.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20240814-topic-sam-v3-3-a84588aad233@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/24 12:27 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
> 
> Add basic support for registering the aggregator module on Device Tree-
> based platforms. These include at least three generations of Qualcomm
> Snapdragon-based Surface devices:
> 
> - SC8180X / SQ1 / SQ2: Pro X,
> - SC8280XP / SQ3: Devkit 2023, Pro 9
> - X Elite: Laptop 7 / Pro11
> 
> Thankfully, the aggregators on these seem to be configured in an
> identical way, which allows for using these settings as defaults and
> no DT properties need to be introduced (until that changes, anyway).
> 
> Based on the work done by Maximilian Luz, largely rewritten.
> 
> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
> ---

Looks good to me and works without issues on my Surface Pro X.

Thanks again for picking this up!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Tested-by: Maximilian Luz <luzmaximilian@gmail.com>

